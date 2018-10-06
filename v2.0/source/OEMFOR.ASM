;*****************************************
;
;         A Sample OEM module
;
;*****************************************

CODE    SEGMENT BYTE PUBLIC 'CODE'
; This segment must be
; named CODE, it must be
; PUBLIC, and it's
; classname must be 'CODE'


        ASSUME  CS:CODE,DS:CODE,ES:CODE

; Must declare data and routines PUBLIC
        
PUBLIC  FATID,STARTSECTOR,SWITCHLIST,FREESPACE
PUBLIC  INIT,DISKFORMAT,BADSECTOR,DONE,WRTFAT
PUBLIC  FATSPACE,HARDFLAG

; This data defined in Microsoft-supplied module

        EXTRN   SWITCHMAP:WORD,DRIVE:BYTE

INIT:

; TODO: Read the boot sector into memory
;       CALL    READBOOT

; TODO: Set FATID to double sided if "D" switch specified
;        TEST    SWITCHMAP,10H
;        JNZ     SETDBLSIDE

        RET

DISKFORMAT:
        
; Use the bit map in SWITCHMAP to determine
; what switches are set

        TEST    SWITCHMAP,8     ;Is there a "/C"?
        JNZ     CLEAR           ; Yes -- clear operation
                                ; requested jump around the
                                ; format code
; TODO: Format the disk
CLEAR:

; TODO: Transfer the boot from memory to the new disk
;       CALL    TRANSBOOT

        RET

; Error return - set carry

ERRET:
        STC
        RET

BADSECTOR:

        RET


WRTFAT:


WRTFATLOOP:
; TODO: Set up call to write out a fat to disk

        MOV     BX,[FATSPACE]

; TODO: Write out one fat to disk
        JC      ERRET

; TODO: Decrement fat counter
        JNZ     WRTFATLOOP
        CLC                         ;Good return
        RET


DONE:

        RET

; Default Single sided
FATID           DB      0FEH

HARDFLAG        DB      0

STARTSECTOR     DW      9

SWITCHLIST      DB      5,"DCOVS"     ; "OVS" must be the last
                                      ; switches in the list

FATSPACE        DW      FATBUF

FREESPACE       DW      ENDBOOT

BOOT            DB      512 DUP(?) ; Buffer for the
                                   ; boot sector

FATBUF          DB      6 * 1024 DUP(?) ; Fat buffer
ENDBOOT         LABEL   BYTE

CODE    ENDS
        END