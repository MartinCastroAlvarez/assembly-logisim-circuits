; ------------------------------------------------------------------------
;Run with:
; >>> nasm -f elf64 -o hello.o hello.asm
; >>> ld -s -o hello hello.o
; >>> ./hello
; ------------------------------------------------------------------------
SECTION     .data

    ; ------------------------------------------------------------------------
    ; Definiendo los mensajes a imprimir en pantalla:
    ; Se definen constantes con EQU que contienen el tamaño
    ; de las respectivas cadenas de caracteres.
    ; ------------------------------------------------------------------------
    CADENA1     DB      "El 4 de febrero de 2022, a las 18:00 horas, tendremos el examen de Fundamentos de Computadores", 10
    CADENA1_LEN EQU     $ - CADENA1

    CADENA2     DB      "Total número de Consonantes: ", 10
    CADENA2_LEN EQU     $ - CADENA2

    CADENA3     DB      "Frecuencia de las Vocales: ", 10
    CADENA3_LEN EQU     $ - CADENA3

    CADENA4     DB      "Total número de números Pares: ", 10
    CADENA4_LEN EQU     $ - CADENA4

    ; ------------------------------------------------------------------------
    ; Definiendo el caracter Carriage Return
    ; ------------------------------------------------------------------------
    NLINEA      DB      10

    ; ------------------------------------------------------------------------
    ; Definiendo contadores de frecuencia, inicializados en 0.
    ; ------------------------------------------------------------------------
    TOT_A_U     DB      30H
    TOT_A_D     DB      30H
    TOT_E_U     DB      30H
    TOT_E_D     DB      30H
    TOT_I_U     DB      30H
    TOT_I_D     DB      30H
    TOT_O_U     DB      30H
    TOT_O_D     DB      30H
    TOT_U_U     DB      30H
    TOT_U_D     DB      30H
    TOT_P_U     DB      30H
    TOT_P_D     DB      30H
    TOT_C_U     DB      30H
    TOT_C_D     DB      30H

SECTION     .text
    GLOBAL      _start 

_start: 
    ; ------------------------------------------------------------------------
    ; Initializa la frase a evaluar.
    ; ------------------------------------------------------------------------
    MOV         RDI, CADENA1
    CALL        _printCadena1

    ; ------------------------------------------------------------------------
    ; Itera sobre los caracteres de CADENA1.
    ; ------------------------------------------------------------------------
    .COUNT:
        ; ------------------------------------------------------------------------
        ; Lee el próximo byte de CADENA1.
        ; ------------------------------------------------------------------------
        MOV         SIL, [RDI]

        ; ------------------------------------------------------------------------
        ; Evalúa si hemos llegado al final de
        ; la cadena de caracteres.
        ; ------------------------------------------------------------------------
        CMP     SIL, 10
        JE      .END

        ; ------------------------------------------------------------------------
        ; Aumenta el contador de la vocal 'a'.
        ; ------------------------------------------------------------------------
        CMP     SIL, "A"
        JE      .A_FOUND
        CMP     SIL, "a"
        JE      .A_FOUND

        ; ------------------------------------------------------------------------
        ; Aumenta el contador de la vocal 'e'.
        ; ------------------------------------------------------------------------
        CMP     SIL, "E"
        JE      .E_FOUND
        CMP     SIL, "e"
        JE      .E_FOUND

        ; ------------------------------------------------------------------------
        ; Aumenta el contador de la vocal 'i'.
        ; ------------------------------------------------------------------------
        CMP     SIL, "I"
        JE      .I_FOUND
        CMP     SIL, "i"
        JE      .I_FOUND

        ; ------------------------------------------------------------------------
        ; Aumenta el contador de la vocal 'o'.
        ; ------------------------------------------------------------------------
        CMP     SIL, "o"
        JE      .O_FOUND
        CMP     SIL, "o"
        JE      .O_FOUND

        ; ------------------------------------------------------------------------
        ; Aumenta el contador de la vocal 'u'.
        ; ------------------------------------------------------------------------
        CMP     SIL, "u"
        JE      .U_FOUND
        CMP     SIL, "u"
        JE      .U_FOUND

        ; ------------------------------------------------------------------------
        ; Aumenta el contador de números pares.
        ; ------------------------------------------------------------------------
        CMP     SIL, "0"
        JE      .P_FOUND
        CMP     SIL, "2"
        JE      .P_FOUND
        CMP     SIL, "4"
        JE      .P_FOUND
        CMP     SIL, "6"
        JE      .P_FOUND
        CMP     SIL, "8"
        JE      .P_FOUND

        ; ------------------------------------------------------------------------
        ; Ignorando caracteres especiales.
        ; ------------------------------------------------------------------------
        CMP     SIL, ":"
        JE      .NEXT
        CMP     SIL, ","
        JE      .NEXT
        CMP     SIL, "."
        JE      .NEXT
        CMP     SIL, "-"
        JE      .NEXT
        CMP     SIL, "_"
        JE      .NEXT

        ; ------------------------------------------------------------------------
        ; Ignorando números impares.
        ; ------------------------------------------------------------------------
        CMP     SIL, "1"
        JE      .NEXT
        CMP     SIL, "3"
        JE      .NEXT
        CMP     SIL, "5"
        JE      .NEXT
        CMP     SIL, "6"
        JE      .NEXT
        CMP     SIL, "7"
        JE      .NEXT
        CMP     SIL, "9"
        JE      .NEXT

        ; ------------------------------------------------------------------------
        ; Si no ha sido filtrado, entonces muy
        ; probablemente sea una consonante.
        ; ------------------------------------------------------------------------
        JMP     .C_FOUND

    ; ------------------------------------------------------------------------
    ; Saltar al siguiente paso de la iteración.
    ; Mueve el cursor dentro de CADENA1 una posición.
    ; ------------------------------------------------------------------------
    .NEXT:
        INC     RDI
        JMP     .COUNT

    ; ------------------------------------------------------------------------
    ; Aumenta el contador de unidades de la vocal 'a'.
    ; ------------------------------------------------------------------------
    .A_FOUND:
        MOV     BL, [TOT_A_U]
        CMP     BL, 39H
        JE      .A_ROTATE
        INC     BL
        MOV     [TOT_A_U], BL
        JMP     .NEXT

    ; ------------------------------------------------------------------------
    ; Aumenta el contador de unidades de la vocal 'e'.
    ; ------------------------------------------------------------------------
    .E_FOUND:
        MOV     BL, [TOT_E_U]
        CMP     BL, 39H
        JE      .E_ROTATE
        INC     BL
        MOV     [TOT_E_U], BL
        JMP     .NEXT

    ; ------------------------------------------------------------------------
    ; Aumenta el contador de unidades de la vocal 'i'.
    ; ------------------------------------------------------------------------
    .I_FOUND:
        MOV     BL, [TOT_I_U]
        CMP     BL, 39H
        JE      .I_ROTATE
        INC     BL
        MOV     [TOT_I_U], BL
        JMP     .NEXT

    ; ------------------------------------------------------------------------
    ; Aumenta el contador de unidades de la vocal 'o'.
    ; ------------------------------------------------------------------------
    .O_FOUND:
        MOV     BL, [TOT_O_U]
        CMP     BL, 39H
        JE      .O_ROTATE
        INC     BL
        MOV     [TOT_O_U], BL
        JMP     .NEXT

    ; ------------------------------------------------------------------------
    ; Aumenta el contador de unidades de la vocal 'u'.
    ; ------------------------------------------------------------------------
    .U_FOUND:
        MOV     BL, [TOT_U_U]
        CMP     BL, 39H
        JE      .U_ROTATE
        INC     BL
        MOV     [TOT_U_U], BL
        JMP     .NEXT

    ; ------------------------------------------------------------------------
    ; Aumenta el contador de unidades de las consonantes.
    ; ------------------------------------------------------------------------
    .C_FOUND:
        MOV     BL, [TOT_C_U]
        CMP     BL, 39H
        JE      .C_ROTATE
        INC     BL
        MOV     [TOT_C_U], BL
        JMP     .NEXT

    ; ------------------------------------------------------------------------
    ; Aumenta el contador de unidades de los pares.
    ; ------------------------------------------------------------------------
    .P_FOUND:
        MOV     BL, [TOT_P_U]
        CMP     BL, 39H
        JE      .P_ROTATE
        INC     BL
        MOV     [TOT_P_U], BL
        JMP     .NEXT

    ; ------------------------------------------------------------------------
    ; Aumenta el contador de decenas de la vocal 'a'.
    ; ------------------------------------------------------------------------
    .A_ROTATE:
        MOV     BL, [TOT_A_D]
        INC     BL 
        MOV     [TOT_A_D], BL
        MOV     BL, 30H
        MOV     [TOT_A_U], BL
        JMP     .NEXT

    ; ------------------------------------------------------------------------
    ; Aumenta el contador de decenas de la vocal 'e'.
    ; ------------------------------------------------------------------------
    .E_ROTATE:
        MOV     BL, [TOT_E_D]
        INC     BL 
        MOV     [TOT_E_D], BL
        MOV     BL, 30H
        MOV     [TOT_E_U], BL
        JMP     .NEXT

    ; ------------------------------------------------------------------------
    ; Aumenta el contador de decenas de la vocal 'i'.
    ; ------------------------------------------------------------------------
    .I_ROTATE:
        MOV     BL, [TOT_I_D]
        INC     BL 
        MOV     [TOT_I_D], BL
        MOV     BL, 30H
        MOV     [TOT_I_U], BL
        JMP     .NEXT

    ; ------------------------------------------------------------------------
    ; Aumenta el contador de decenas de la vocal 'o'.
    ; ------------------------------------------------------------------------
    .O_ROTATE:
        MOV     BL, [TOT_O_D]
        INC     BL 
        MOV     [TOT_O_D], BL
        MOV     BL, 30H
        MOV     [TOT_O_U], BL
        JMP     .NEXT

    ; ------------------------------------------------------------------------
    ; Aumenta el contador de decenas de la vocal 'u'.
    ; ------------------------------------------------------------------------
    .U_ROTATE:
        MOV     BL, [TOT_U_D]
        INC     BL 
        MOV     [TOT_U_D], BL
        MOV     BL, 30H
        MOV     [TOT_U_U], BL
        JMP     .NEXT

    ; ------------------------------------------------------------------------
    ; Aumenta el contador de decenas de los números par.
    ; ------------------------------------------------------------------------
    .P_ROTATE:
        MOV     BL, [TOT_P_D]
        INC     BL 
        MOV     [TOT_P_D], BL
        MOV     BL, 30H
        MOV     [TOT_P_U], BL
        JMP     .NEXT

    ; ------------------------------------------------------------------------
    ; Aumenta el contador de decenas de consonantes.
    ; ------------------------------------------------------------------------
    .C_ROTATE:
        MOV     BL, [TOT_C_D]
        INC     BL 
        MOV     [TOT_C_D], BL
        MOV     BL, 30H
        MOV     [TOT_C_U], BL
        JMP     .NEXT

    ; ------------------------------------------------------------------------
    ; Imprimiendo resultados en pantalla.
    ; ------------------------------------------------------------------------
    .END:
        CALL        _printCadena2
        CALL        _printCadena3
        CALL        _printCadena4
        CALL        _exit

; ------------------------------------------------------------------------
; Llamando a la interrupción código 1 de salida, con exit code 3.
; ------------------------------------------------------------------------
_exit:
    MOV         AL, 1
    MOV         BL, 3
    INT         0x80
    RET

; ------------------------------------------------------------------------
; Llamando a interrupción código 4 de escritura,
; que escribe a STDOUT (EBX=1) la cadena de caracteres.
; ------------------------------------------------------------------------
_printCadena1:
    MOV         EAX, 4
    MOV         EBX, 1
    MOV         ECX, CADENA1
    MOV         EDX, CADENA1_LEN
    INT         0x80
    RET

; ------------------------------------------------------------------------
; Llamando a interrupción código 4 de escritura,
; que escribe a STDOUT (EBX=1) la cadena de caracteres.
; ------------------------------------------------------------------------
_printCadena2:
    MOV         EAX, 4
    MOV         EBX, 1
    MOV         ECX, CADENA2
    MOV         EDX, CADENA2_LEN
    INT         0x80
    CALL        _printConso
    RET

; ------------------------------------------------------------------------
; Llamando a interrupción código 4 de escritura,
; que escribe a STDOUT (EBX=1) la cadena de caracteres.
; ------------------------------------------------------------------------
_printCadena3:
    MOV         EAX, 4
    MOV         EBX, 1
    MOV         ECX, CADENA3
    MOV         EDX, CADENA3_LEN
    INT         0x80
    CALL        _printFrequency
    RET

; ------------------------------------------------------------------------
; Llamando a interrupción código 4 de escritura,
; que escribe a STDOUT (EBX=1) la cadena de caracteres.
; ------------------------------------------------------------------------
_printCadena4:
    MOV         EAX, 4
    MOV         EBX, 1
    MOV         ECX, CADENA4
    MOV         EDX, CADENA4_LEN
    INT         0x80
    CALL        _printPares
    RET

; ------------------------------------------------------------------------
; Imprime en pantalla la frequencia de todas las vocales.
; ------------------------------------------------------------------------
_printFrequency:
    CALL        _printA
    CALL        _printE
    CALL        _printI
    CALL        _printO
    CALL        _printU
    RET

; ------------------------------------------------------------------------
; Llamando a interrupción código 4 de escritura,
; que escribe a STDOUT (EBX=1) la letra "a".
; ------------------------------------------------------------------------
_printA:
    MOV         EAX, 4
    MOV         EBX, 1
    MOV         ECX, TOT_A_D
    MOV         EDX, 1
    INT         0x80
    MOV         EAX, 4
    MOV         EBX, 1
    MOV         ECX, TOT_A_U
    MOV         EDX, 1
    INT         0x80
    CALL        _printNuevaLinea
    RET

; ------------------------------------------------------------------------
; Llamando a interrupción código 4 de escritura,
; que escribe a STDOUT (EBX=1) la letra "e".
; ------------------------------------------------------------------------
_printE:
    MOV         EAX, 4
    MOV         EBX, 1
    MOV         ECX, TOT_E_D
    MOV         EDX, 1
    INT         0x80
    MOV         EAX, 4
    MOV         EBX, 1
    MOV         ECX, TOT_E_U
    MOV         EDX, 1
    INT         0x80
    CALL        _printNuevaLinea
    RET

; ------------------------------------------------------------------------
; Llamando a interrupción código 4 de escritura,
; que escribe a STDOUT (EBX=1) la letra "i".
; ------------------------------------------------------------------------
_printI:
    MOV         EAX, 4
    MOV         EBX, 1
    MOV         ECX, TOT_I_D
    MOV         EDX, 1
    INT         0x80
    MOV         EAX, 4
    MOV         EBX, 1
    MOV         ECX, TOT_I_U
    MOV         EDX, 1
    INT         0x80
    CALL        _printNuevaLinea
    RET

; ------------------------------------------------------------------------
; Llamando a interrupción código 4 de escritura,
; que escribe a STDOUT (EBX=1) la letra "o".
; ------------------------------------------------------------------------
_printO:
    MOV         EAX, 4
    MOV         EBX, 1
    MOV         ECX, TOT_O_D
    MOV         EDX, 1
    INT         0x80
    MOV         EAX, 4
    MOV         EBX, 1
    MOV         ECX, TOT_O_U
    MOV         EDX, 1
    INT         0x80
    CALL        _printNuevaLinea
    RET

; ------------------------------------------------------------------------
; Llamando a interrupción código 4 de escritura,
; que escribe a STDOUT (EBX=1) la letra "u".
; ------------------------------------------------------------------------
_printU:
    MOV         EAX, 4
    MOV         EBX, 1
    MOV         ECX, TOT_U_D
    MOV         EDX, 1
    INT         0x80
    MOV         EAX, 4
    MOV         EBX, 1
    MOV         ECX, TOT_U_U
    MOV         EDX, 1
    INT         0x80
    CALL        _printNuevaLinea
    RET

; ------------------------------------------------------------------------
; Llamando a interrupción código 4 de escritura,
; que escribe a STDOUT (EBX=1) la cantidad de números par
; ------------------------------------------------------------------------
_printPares:
    MOV         EAX, 4
    MOV         EBX, 1
    MOV         ECX, TOT_P_D
    MOV         EDX, 1
    INT         0x80
    MOV         EAX, 4
    MOV         EBX, 1
    MOV         ECX, TOT_P_U
    MOV         EDX, 1
    INT         0x80
    CALL        _printNuevaLinea
    RET

; ------------------------------------------------------------------------
; Llamando a interrupción código 4 de escritura,
; que escribe a STDOUT (EBX=1) la cantidad de consonantes 
; ------------------------------------------------------------------------
_printConso:
    MOV         EAX, 4
    MOV         EBX, 1
    MOV         ECX, TOT_C_D
    MOV         EDX, 1
    INT         0x80
    MOV         EAX, 4
    MOV         EBX, 1
    MOV         ECX, TOT_C_U
    MOV         EDX, 1
    INT         0x80
    CALL        _printNuevaLinea
    RET

; ------------------------------------------------------------------------
; Imprime un Carriage Return
; ------------------------------------------------------------------------
_printNuevaLinea:
    MOV         EAX, 4
    MOV         EBX, 1
    MOV         ECX, NLINEA
    MOV         EDX, 1
    INT         0x80
    RET
