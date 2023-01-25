#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
#Warn  ; Enable warnings to assist with detecting common errors.
#SingleInstance, force
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

^CapsLock::
    clipboard_temp := ClipboardAll
    BlockInput, On
    clipboard := ""
    Send, ^c
    ClipWait
    selected := clipboard
    left_inputs := ""
    length := StrLen(selected)
    i := 1
    while (i <= length)
    {
        char := SubStr(selected, i, 1)

        if (RegExMatch(char, "[a-z]") > 0)
            StringUpper, char, char
        else if (RegExMatch(char, "[A-Z]") > 0)
            StringLower, char, char

        selected := SubStr(selected, 1, i - 1) char SubStr(selected, i + 1)
        if (char != "`r")
            left_inputs := left_inputs "{Left}"
        i++
    }
    clipboard := selected
    Send, ^v
    clipboard := clipboard_temp
    Send, {Shift down}%left_inputs%{Shift up}
    BlockInput, Off
Return