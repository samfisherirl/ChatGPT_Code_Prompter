#Include GuiReSizer.ahk
#Requires Autohotkey v2
#SingleInstance Force

MainGui := Gui()
MainGui.Opt("+Resize +Alwaysontop +MinSize250x150")
MainGui.OnEvent("Size", GuiReSizer)
MainGui.SetFont("s12 cWhite")
editSection := MainGui.Add("Edit",  "x10", "Section")
editSection.WidthP := 0.9
paste := MainGui.Add("Edit",  "x10 r3", "paste")
paste.WidthP := 0.9
complete := MainGui.Add("Edit", "y+10 r3", "[[ " editSection.Value " section START ]] `n`n" paste.Value  "`n`n[[ " editSection.Value " section END ]]")
complete.WidthP := 0.9
button3 := MainGui.Add("Button", "y+10 ", "Copy all")
button3.WidthP := 0.9
editSection2 := MainGui.Add("Edit", "y+10 r3", "[[ " editSection.Value " section START ]]")
editSection2.WidthP := 0.9
button1 := MainGui.Add("Button", "y+10 ", "Copy 1")
button1.WidthP := 0.9
editSection3 := MainGui.Add("Edit", "y+10 ", "[[ " editSection.Value " section END ]]")
editSection3.WidthP := 0.9
button2 := MainGui.Add("Button", "y+10 ", "Copy 2")
button2.WidthP := 0.9

editSection.OnEvent("Change", editSectionChange)
paste.OnEvent("Change", pasteSectionChange)
button1.OnEvent("Click", button1Click)
button2.OnEvent("Click", button2Click)
button3.OnEvent("Click", button3Click)
#Include requests/guiUtils.ahk
darkMode(MainGui)
MainGUi.backcolor := "Black"
MainGui.Show("h400 w300")

WinSetTransparent 222, "ahk_id " MainGui.hwnd
button1Click(*) => SendToClipboard(Format("{1}",editSection2.Value))
button2Click(*) => SendToClipboard(Format("{1}",editSection3.Value))
button3Click(*) => SendToClipboard(    complete.Value := "[[ " editSection.Value " section START ]] `n`n" paste.Value  "`n`n[[ " editSection.Value " section END ]]"
)
editSectionChange(*)
{
    editSection2.Value := "[[ " editSection.Value " section START ]]"
    editSection3.Value := "[[ " editSection.Value " section END ]]"
    complete.Value := "[[ " editSection.Value " section START ]] `n`n" paste.Value  "`n`n[[ " editSection.Value " section END ]]"
}

pasteSectionChange(*)
{
    complete.Value := "[[ " editSection.Value " section START ]] `n`n" paste.Value  "`n`n[[ " editSection.Value " section END ]]"
}
SendToClipboard(str)
{
    return A_Clipboard := str
}
