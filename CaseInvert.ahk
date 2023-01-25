#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
#Warn  ; Enable warnings to assist with detecting common errors.
#SingleInstance, force
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

^CapsLock::
    clipboard_temp := ClipboardAll
    clipboard := ""
    Send, ^c
    ClipWait
    selected := clipboard
    length := StrLen(selected)
    i := 1
    while (i <= length)
    {
        char := SubStr(selected, i, 1)

        ; Do replacement thingies here
        if (RegExMatch(char, "[a-z]") > 0)
            StringUpper, char, char
        else if (RegExMatch(char, "[A-Z]") > 0)
            StringLower, char, char

        temp := SubStr(selected, 1, i - 1) char SubStr(selected, i + 1)
        selected := temp
        i++
    }
    clipboard := selected
    Send, ^v{Shift down}
    i := 0
    while (i < length)
    {
        Send, {Left}
        i++
    }
    Send, {Shift up}
    clipboard := clipboard_temp
Return