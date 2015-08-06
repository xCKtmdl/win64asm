format PE64 GUI
entry start

include 'INCLUDE\win32a.inc'

section '.text' code readable executable

start:

	sub	rsp,8*(4+5)
	
		lea rcx, [_filename]
		mov edx,GENERIC_WRITE
		mov r8,0x00000002
		xor r9,r9
		

		mov	qword [rsp + 8*(4+0)],CREATE_ALWAYS		
		mov	qword [rsp + 8*(4+1)],FILE_ATTRIBUTE_NORMAL
		mov	qword [rsp + 8*(4+2)],0
		
		call [CreateFileA]
		
		; file handle is now in eax
		
		mov rcx,rax
		lea rdx,[_toWriteBuff]
		mov r8,13    ; number of bytes to write
		lea r9,[_numWritten]
		mov	qword [rsp + 8*(4+0)],0
		call [WriteFile]
		
		
		
		



	mov ecx,1
	call [ExitProcess]

section '.data' data readable writeable

  _toWriteBuff db 'HEEEY NOOOWWW',0  
  _numWritten db 0x00    
  _filename db 'file1.txt',0  

section '.idata' import data readable writeable

  dd 0,0,0,RVA kernel_name,RVA kernel_table
  dd 0,0,0,0,0

  kernel_table:
    ExitProcess dq RVA _ExitProcess
    CreateFileA dq RVA _CreateFileA	
    WriteFile dq RVA _WriteFile
    dq 0


  kernel_name db 'KERNEL32.DLL',0


  _ExitProcess dw 0
    db 'ExitProcess',0
  _CreateFileA dw 0
    db 'CreateFileA',0	
  _WriteFile dw 0
    db 'WriteFile',0		

