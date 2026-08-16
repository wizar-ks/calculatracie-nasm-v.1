default rel

section .data

    saut_de_ligne:db "",10
    taille_saut_de_ligne: equ $ - saut_de_ligne

    message_1:db "Entrer votre chiffre numero 1",10
    taille_1: equ $ - message_1

    message_2:db "Entrer votre chiffre numero 2",10
    taille_2: equ $ - message_2

    message_3:db "Option : 1 addition | option 2 : soustraction",10
    taille_3: equ $ - message_3

    message_4:db "Le resultat est : ",0
    taille_4: equ $ - message_4

    moins:db "-",0
    taille_moins: equ $ - moins

section .bss
    ask           resb 32

    nombre_total  resb 32
    nombre_1      resb 32
    nombre_2      resb 32

section .text
    global _start

_start:
    jmp     debut

fonction_msg:
    mov     rdx,rsi
    mov     rsi,rdi
    mov     rdi,1
    mov     rax,1
    syscall
    ret

fonction_lecture:
    mov     rdx,rsi
    mov     rsi,rdi
    mov     rdi,0
    mov     rax,0
    syscall
    ret

affcihage_nombre_negatif:
    mov     rdi,moins
    mov     rsi,taille_moins

    call    fonction_msg

    jmp     continue

ascii_vers_int:
    xor     rcx,rcx
    xor     rbx,rbx
    
    jmp     boucle_ascii_vers_int

boucle_ascii_vers_int:
    cmp     byte[rsi + rcx],10
    je      retour

    push    rcx

    sub     rdi,48
    imul    rbx,10
    add     rdi,rbx

    mov     r8,rdi

    pop     rcx

    inc     rcx

    jmp     boucle_ascii_vers_int

fonction_str_len:
    xor     rcx,rcx
    xor     r9,r9

    jmp     boulce_str_len

boulce_str_len:

    cmp     byte[rsi],'1'
    je      fonction_addition

    cmp     byte[rsi],'2'
    je      fonction_soustraction

    ;inc     rcx

    jmp     boulce_str_len

fonction_addition:

    push    r15

    add     r15,r14
    mov     rcx,r15
    add     r15,48

    mov     rax,r15
    mov     byte [nombre_total],al

    pop     r15

    jmp     retour

fonction_soustraction:

    push    r15

    sub     r15,r14

    mov     rcx,r15

    add     r15,48

    cmp     r15,48
    jl      nombre_negatif

    mov     rax,r15
    mov     byte [nombre_total],al

    pop     r15

    jmp     retour

nombre_negatif:
    pop     r15

    push    r14

    sub     r14,r15
    add     r14,48

    mov     rax,r14
    mov     byte [nombre_total],al

    mov     r9,1         

    pop     r14

    jmp     retour


retour:
    ret

debut:

    mov     rdi,message_1
    mov     rsi,taille_1

    call    fonction_msg
    
    mov     rdi,nombre_1
    mov     rsi,32

    call    fonction_lecture

    ;mov     rdi,32
    ;mov     rsi,nombre_1

    ;call    fonction_msg

    mov     rcx,nombre_1

    movzx   rax,byte [rcx]

    mov     rdi,rax
    mov     rsi,nombre_1

    call    ascii_vers_int

    mov     r15,r8

    mov     rdi,message_2
    mov     rsi,taille_2

    call    fonction_msg

    mov     rdi,nombre_2
    mov     rsi,32

    call    fonction_lecture

    mov     rcx,nombre_2
    movzx   rax,byte [rcx]

    mov     rdi,rax
    mov     rsi,nombre_2

    call    ascii_vers_int

    mov     r14,r8

    mov     rdi,message_3
    mov     rsi,taille_3

    call    fonction_msg

    mov     rdi,ask
    mov     rsi,32

    call    fonction_lecture

    mov     rax,ask
    movzx   rcx,byte [rax]

    mov     rdi,rax
    mov     rsi,ask

    call    fonction_str_len

    push    rcx

    mov     rdi,message_4
    mov     rsi,taille_4

    call    fonction_msg

    cmp     r9,1
    je      affcihage_nombre_negatif

continue:

    mov     rdi,nombre_total
    mov     rsi,32

    call    fonction_msg

    mov     rdi,saut_de_ligne
    mov     rsi,taille_saut_de_ligne

    call    fonction_msg

    pop     rcx

    mov     rdi,rcx

fin:
    mov     rax,60
    syscall 
