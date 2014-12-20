; @Author: vargash1
; @Date:   2014-12-17 20:36:08
; @Email:  vargash1@wit.edu
; @Last Modified by:   vargash1
; @Last Modified time: 2014-12-18 12:53:34
; @Name:   Vargas, Hector
INCLUDE     Irvine32.inc
    Menu    STRUCT
        out_1       BYTE    "Enter the number for operation",0Dh,0Ah
                    BYTE    "(1) x AND y",0Dh,0Ah
                    BYTE    "(2) x OR y",0Dh,0Ah
                    BYTE    "(3) x XOR y",0Dh,0Ah
                    BYTE    "(4) NOT X",0Dh,0Ah
                    BYTE    "(5) NOT Y",0Dh,0Ah
                    BYTE    "(6) Enter new X and Y",0Dh,0Ah,
                            "(7) Quit",0Dh,0Ah,0
        banner      BYTE    "           ______                           )   _____",0Dh,0Ah
                    BYTE    "  (, /    )       /)               (__/_____)     /)        /)",0Dh,0Ah   
                    BYTE    "    /---(  ______//  _  _  __        /       _   // _      // _  _/_ _____",0Dh,0Ah
                    BYTE    " ) / ____)(_)(_)(/__(/_(_(_/ (_     /       (_(_(/_(__(_(_(/_(_(_(__(_)/ (_",0Dh,0Ah
                    BYTE    "(_/ (                              (______)",0Dh,0Ah,0 
        user_in     DWORD   ?
        bin_out     BYTE    "   Binary:            ",0
        hex_out     BYTE    "   Hexadecimal:       ",0
        dec_out     BYTE    "   Decimal:           ",0   
    Menu    ENDS    
.data
    and_s           BYTE    "               AND",0
    or_s            BYTE    "               OR",0
    not_s           BYTE    "               NOT",0
    xor_s           BYTE    "               XOR",0
    equals          BYTE    "               EQUALS ",0
    instructions    BYTE    "Enter a number X,Y(in base 10):",0
    prompt          BYTE    "> ",0
    x               DWORD   ?
    y               DWORD   ?
    new_menu        Menu<>
.code
main    PROC    
    call    read_in_val
    mov     ecx,1000
l1:
    call    valid_menu_choice
    call    go_to_menu_choice
    call    WaitMsg
    call    Clrscr   
    loop    l1

main    ENDP
;determines where to go
go_to_menu_choice   PROC
    cmp     new_menu.user_in,1
    je      menu_1
    cmp     new_menu.user_in,2
    je      menu_2
    cmp     new_menu.user_in,3
    je      menu_3
    cmp     new_menu.user_in,4
    je      menu_4
    cmp     new_menu.user_in,5
    je      menu_5
    cmp     new_menu.user_in,6
    je      menu_6
    cmp     new_menu.user_in,7
    je      menu_7
    ret
menu_1:
    call    and_op
    ret
menu_2:
    call    or_op
    ret 
menu_3:
    call    xor_op
    ret
menu_4:
    call    not_op_x
    ret
menu_5:
    call    not_op_y
    ret
menu_6:
    call    read_in_val
    ret
menu_7:
    INVOKE  ExitProcess,0
go_to_menu_choice   ENDP
;must be in range 1-6 so will 
;call same proc again if anything else is input
valid_menu_choice   PROC
    mov     edx,OFFSET new_menu.out_1
    call    WriteString
    call    ReadInt
    cmp     eax,0
    jl      invalid_choice
    cmp     eax,6
    jg      invalid_choice
    mov     [new_menu.user_in],eax
    ret
invalid_choice:
    call    valid_menu_choice
    ret
valid_menu_choice   ENDP
;doesnt matter what user enters,
;no check
read_in_val     PROC
    mov     edx,OFFSET instructions
    call    WriteString
    call    crlf
    mov     edx,OFFSET prompt
    call    WriteString
    call    ReadInt
    mov     [x],eax
    mov     edx,OFFSET prompt
    call    WriteString
    call    ReadInt
    mov     [y],eax
    ret
read_in_val     ENDP
or_op           PROC
    ;print out x
    mov     eax,[x]
    mov     ebx, TYPE DWORD 
    call    write_radix
    call    crlf
    call    set_text_color_green
    mov     edx,OFFSET or_s
    call    WriteString
    call    set_text_color_def
    call    crlf
    ;print out y
    mov     eax,[y]
    mov     ebx, TYPE DWORD 
    call    write_radix
    call    crlf
    ;print out result
    mov     eax,[x]
    mov     ebx,[y]
    or      eax,ebx
    mov     ebx,TYPE DWORD
    call    set_text_color_green
    mov     edx,OFFSET equals
    call    WriteString
    call    crlf
    call    set_text_color_def
    call    write_radix
    call    crlf
    ret
or_op           ENDP
and_op          PROC
        ;print out x
    mov     eax,[x]
    mov     ebx, TYPE DWORD 
    call    write_radix
    call    crlf
    call    set_text_color_green
    mov     edx,OFFSET and_s
    call    WriteString
    call    set_text_color_def
    call    crlf
    ;print out y
    mov     eax,[y]
    mov     ebx, TYPE DWORD 
    call    write_radix
    call    crlf
    ;print out result
    mov     eax,[x]
    mov     ebx,[y]
    and     eax,ebx
    mov     ebx,TYPE DWORD
    call    set_text_color_green
    mov     edx,OFFSET equals
    call    WriteString
    call    crlf
    call    set_text_color_def
    call    write_radix
    call    crlf
    ret
and_op          ENDP
xor_op          PROC
    ;print out x
    mov     eax,[x]
    mov     ebx, TYPE DWORD 
    call    write_radix
    call    crlf
    call    set_text_color_green
    mov     edx,OFFSET xor_s
    call    WriteString
    call    set_text_color_def
    call    crlf
    ;print out y
    mov     eax,[y]
    mov     ebx, TYPE DWORD 
    call    write_radix
    call    crlf
    ;print out result
    mov     eax,[x]
    mov     ebx,[y]
    xor     eax,ebx
    mov     ebx,TYPE DWORD
    call    set_text_color_green
    mov     edx,OFFSET equals
    call    WriteString
    call    crlf
    call    set_text_color_def
    
    call    write_radix
    call    crlf
    ret
xor_op          ENDP
not_op_x        PROC
    ;print out x
    mov     eax,[x]
    mov     ebx, TYPE DWORD 
    call    write_radix
    call    crlf
    call    set_text_color_green
    mov     edx,OFFSET not_s
    call    WriteString
    call    set_text_color_def
    call    crlf
    ;print out result
    mov     eax,[x]
    not     eax
    mov     ebx,TYPE DWORD
    call    set_text_color_green
    mov     edx,OFFSET equals
    call    WriteString
    call    crlf
    call    set_text_color_def
    
    call    write_radix
    call    crlf
    ret
not_op_x        ENDP
not_op_y        PROC
    ;print out y
    mov     eax,[y]
    mov     ebx, TYPE DWORD 
    call    write_radix
    call    crlf
    call    set_text_color_green
    mov     edx,OFFSET not_s
    call    WriteString
    call    set_text_color_def
    call    crlf
    ;print out result
    mov     eax,[y]
    not     eax
    mov     ebx,TYPE DWORD
    call    set_text_color_green
    mov     edx,OFFSET equals
    call    WriteString
    call    crlf
    call    set_text_color_def
    call    write_radix
    call    crlf
    ret
not_op_y        ENDP
write_radix     PROC
    ;write in plain old Decimal
    call    set_text_color_cyan
    mov     edx,OFFSET new_menu.dec_out
    call    WriteString
    call    set_text_color_def
    call    WriteInt
    call    crlf
    ;write in binary
    call    set_text_color_cyan
    mov     edx,OFFSET new_menu.bin_out
    call    WriteString
    call    set_text_color_def
    call    WriteBinB
    call    crlf
    ;write in hex   
    call    set_text_color_cyan
    mov     edx,OFFSET new_menu.hex_out
    call    WriteString
    call    set_text_color_def
    call    WriteHexB
    call    crlf
    ret
write_radix     ENDP
set_text_color_cyan  PROC uses eax
    mov     eax,cyan + (black * 16)
    call    SetTextColor
    ret
set_text_color_cyan  ENDP
set_text_color_def  PROC uses eax
    mov     eax,white + (black * 16)
    call    SetTextColor
    ret
set_text_color_def  ENDP
set_text_color_green    PROC uses eax
    mov     eax,green + (black * 16)
    call    SetTextColor
    ret
set_text_color_green    ENDP 
write_banner    PROC
    
    ret
write_banner    ENDP
end     main
