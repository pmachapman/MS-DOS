;*************************************
; COMMAND EQUs which are switch dependant

IF1
    IF IBM
        ECHO IBM version
    ELSE
        ECHO Normal version
    ENDIF

    IF   HIGHMEM
        ECHO Highmem version
    ENDIF

    IF   KANJI
        ECHO Kanji version
    ENDIF
ENDIF
