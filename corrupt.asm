;Written by Ayush Kohli and Utsav Dhungel

section .bss
  buffer : resb 1

section .data
SYS_EXIT equ 1
SYS_WRITE equ 4
SYS_READ equ 3
READWRITE_MODE equ 2
;STDIN equ 0
;STDOUT equ 1
SYS_OPEN equ 5
KERNAL equ 0x80

section .text
  global _start

  exit:
   mov eax, SYS_EXIT
   mov ebx, 0 ; EXIT STATUS FOR SUCESS
   int KERNAL

  _start:
   pop ebx
   pop ebx
   pop ebx
  ; call open
  jmp open


  open:
   mov eax, SYS_OPEN
   mov ecx, READWRITE_MODE
   int KERNAL
   test eax,eax
   jns read
  ; ret

  read:
   mov ebx, 3
   mov eax, SYS_READ
   mov ecx, buffer
   mov edx, 1
   int KERNAL
   cmp eax, 0
   je exit
   jmp write

  write:
   mov ebx, 1
   mov eax, SYS_WRITE
   mov ecx, buffer
   mov edx, 1
   int KERNAL
   jmp read

  ;rand: Need to generate random character

  ;To Do List: 
  ;Instead of writing to STDOUT write to file itself
  ;Create random function to generate ramdom ASCII
  ;Try to impliment CALL and RETURN
  ;Beautify the Code
