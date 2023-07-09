#Requires AutoHotkey v2.0
#SingleInstance Force


; ########     ###    ########  ######## ##     ## ########  ########
; ##     ##   ## ##   ##     ##    ##    ##     ## ##     ## ##
; ##     ##  ##   ##  ##     ##    ##    ##     ## ##     ## ##
; ########  ##     ## ########     ##    ##     ## ########  ######
; ##   ##   ######### ##           ##    ##     ## ##   ##   ##
; ##    ##  ##     ## ##           ##    ##     ## ##    ##  ##
; ##     ## ##     ## ##           ##     #######  ##     ## ########

#HotIf WinActive("ahk_exe rapture.exe")
mouse_pos_histories := []
~LButton::{
    MouseGetPos(&x_mouse, &y_mouse)
    mouse_pos_histories.insertAt(1, [x_mouse, y_mouse])
    if(mouse_pos_histories.Length > 2){
        mouse_pos_histories.pop()
    }
}
~LButton Up::{
    MouseGetPos(&x_mouse, &y_mouse)
    mouse_pos_histories.insertAt(1, [x_mouse, y_mouse])
    if(mouse_pos_histories.Length > 2){
        mouse_pos_histories.pop()
    }
    tooltip("a: line`ns: square`n1-5: ①-⑤")
    SetTimer () => ToolTip(), -3000
}
;; draw line
a::{
    Send("^z")
    m := mouse_pos_histories
    MouseClickDrag "L", m[2][1], m[2][2], m[1][1], m[2][2]
    tooltip()
}
;; draw triangle
s::{
    Send("^z")
    m := mouse_pos_histories
    MouseClickDrag "L", m[2][1], m[2][2], m[1][1], m[2][2]
    MouseClickDrag "L", m[1][1], m[2][2], m[1][1], m[1][2]
    MouseClickDrag "L", m[1][1], m[1][2], m[2][1], m[1][2]
    MouseClickDrag "L", m[2][1], m[1][2], m[2][1], m[2][2]
    tooltip()
}
;; Draw Number
1::
2::
3::
4::
5::{
    arr := ["①","②","③","④","⑤"]
    m := mouse_pos_histories
    MouseClick "right"
    Send("X")
    Sleep 300
    SendInput arr[A_ThisHotkey]
    Send("{TAB}")
    CoordMode("Mouse","Window")
    ControlGetPos &x, &y, &w, &h, "Button1", "A"
    MouseMove x+(w/2),y+h
}
#HotIf
