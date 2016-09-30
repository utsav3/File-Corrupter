;Written by Ayush Kohli and Utsav Dhungel

  
  ;MOST IMP
  ;http://docs.cs.up.ac.za/programming/asm/derick_tut/#procedures
  ;READ ABOVE LINK

; This is reserved memory
section .bss
  buffer : resw 1 ; Reserve one byte

;Store all constants to make code more readable
section .data
   fd equ 3
   SYS_EXIT equ 1
   SYS_WRITE equ 4
   SYS_READ equ 3   
   READWRITE_MODE equ 2
   SYS_OPEN equ 5
   KERNAL equ 0x80
   FILE_FD dw -1 ; Assume it failed to open


section .text
  global _start ; To keep linker happy :)


;Exit Procedure
exit:
   mov eax, SYS_EXIT
   mov ebx, 0 ; EXIT STATUS FOR SUCESS
   int KERNAL


EXITFALIURE:
      mov eax, SYS_EXIT
      mov ebx,1
      int KERNAL


_start:
     pop ebx
     ;add ebx,'0'\
     cmp ebx,0x2
     ; je exit

     ;pop ebx ;ARGC Value gets popped off the stack
      pop ebx ;ARGV[0] gets popped off the stack
      pop ebx ;ARGV[1] gets popped off the stack
      jmp open ; goto open



;open(argv[1],O-RDWR);
  open:
     mov eax, SYS_OPEN
     mov ecx, READWRITE_MODE
     int KERNAL ; LINUX magically does its thing
     test eax,eax ; Dont destroy value of eax because that is the fd
     mov dword [FILE_FD], eax
     jns read ; If there is no error (-1) then go to read
     jmp EXITFALIURE
  ; ret



;read(eax,*buff,1)
  read:
     ;Impliment Call and jns in the read function
     mov ebx, [FILE_FD] ; Hardcoded fd, ; NEED TO CHANGE

     mov eax, SYS_READ
     mov ecx, buffer
     mov edx, 1
     int KERNAL
     cmp eax, 0 ; 0 gets returned if read did not return anything
     je exit ; if eax == 0 exit
     ; jmp write ;else write



write:
      movzx eax,byte [buffer];
      push eax
      ;call xxx
      mov [buffer],al
    
       add byte [buffer], 5
       mov ax, word [buffer]
      ;mov ax,2
      mov edx,0
      mov bx,0xf1
      div bx
      mov  [buffer],ax
 

      mov ebx, 1 ; FD writing to STDOUT for now
      mov eax, SYS_WRITE ; Action to perform
      mov ecx, buffer						; instead use this will work
   
      mov edx, 1 ; sizeof(buffer)
      int KERNAL ; Linux does the magic
      jmp read ; Unconditinal jump to read to continue loop

  ;rand: Need to generate random character
