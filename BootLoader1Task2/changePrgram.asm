bits 16
org 0x7c00

boot:
    mov si, menu
    call print_menu
    call read_input


    ; Check the user's input and display the corresponding output
    cmp al, '1'
    je option_1
    cmp al, '2'
    je option_2
    cmp al, '3'
    je option_3

    ; If the input is not 1, 2, 3, print an error message
    mov si, invalid_option
    call print_string
    jmp halt

option_1:
    mov si, message_1
    call print_string
    jmp boot

option_2:
    mov si, message_2
    call print_string
    jmp boot

option_3:
    mov si, message_3
    call print_string
    jmp boot

print_menu:
    mov ah, 0x0e
.loop_menu:
    lodsb
    or al, al
    jz .done_menu
    int 0x10
    jmp .loop_menu
.done_menu:
    ret

read_input:
    mov ah, 0
    int 0x16  ; BIOS keyboard interrupt
    ret

print_string:
    mov ah, 0x0e
.loop_print:
    lodsb
    or al, al
    jz .done_print
    int 0x10
    jmp .loop_print
.done_print:
    ret

halt:
    cli
    hlt

end_program:
    ; Reboot the system
    mov ax, 0x0000
    int 0x16  ; BIOS keyboard interrupt
    int 0x19  ; BIOS boot interrupt

menu db "Select an option:", 0x0d, 0x0a
     db "1. Car", 0x0d, 0x0a
     db "2. Bike", 0x0d, 0x0a
     db "3. Book", 0x0d, 0x0a
     
invalid_option db "Invalid option! Please select 1, 2, 3.", 0x0d, 0x0a, 0
message_1 db "You selected Car.", 0x0d, 0x0a, 0
message_2 db "You selected Bike.", 0x0d, 0x0a, 0
message_3 db "You selected Book.", 0x0d, 0x0a, 0

times 510 - ($ - $$) db 0
dw 0xaa55
