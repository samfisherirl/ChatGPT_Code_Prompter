#Include GuiReSizer.ahk
#Requires Autohotkey v2
#SingleInstance Force

sections := ""
MainGui := Gui()

MainGui.Opt("+Resize +Alwaysontop +MinSize250x150")
MainGui.OnEvent("Size", GuiReSizer)
MainGui.SetFont("s12 cWhite")
questionEdit := MainGui.Add("Edit",  "x10 r3", "question")
questionEdit.WidthP := 0.9
sectionEdit := MainGui.Add("Edit",  "x10 r2", "Section")
sectionEdit.WidthP := 0.9
pasteSection := MainGui.Add("Edit", "y+10 r4", "pasteSection")
pasteSection.WidthP := 0.9
firstButton := MainGui.Add("Button", "y+10 ", "Add another section")
firstButton.WidthP := 0.9
editSection2 := MainGui.Add("Edit", "y+10 r3", "act as a coding expert in coding for the code I will provide in a separate message. Context will start with ``[[  AHK or PY or other code Section START ]]`` and end with ``[[  AHK or PY code Section END ]]``. I need your answer to be complete code, if I provide you code to make changes, and there's a better way to do anything, please refactor or rename variables or do anything at your discretion. I always need the best code. Does that make sense?")
editSection2.WidthP := 0.9
button1 := MainGui.Add("Button", "y+10 ", "Copy Instructions")
button1.WidthP := 0.9
finalCopyEdit := MainGui.Add("Edit", "y+10 r2", "all")
finalCopyEdit.WidthP := 0.9
finalCopyButton := MainGui.Add("Button", "y+10 ", "Copy all")
finalCopyButton.WidthP := 0.9
resetButton := MainGui.Add("Button", "y+10 ", "Reset")
resetButton.WidthP := 0.9

finalCopyEdit.OnEvent("Change", editSectionChange)
resetButton.OnEvent("Click", resetButtonClick)
pasteSection.OnEvent("Change", editSectionChange)
button1.OnEvent("Click", button1Click)
finalCopyButton.OnEvent("Click", finalCopyButtonClick)
firstButton.OnEvent("Click", firstButtonClick)
#Include requests/guiUtils.ahk
darkMode(MainGui)
MainGUi.backcolor := "Black"
MainGui.Show("w400")

WinSetTransparent 222, "ahk_id " MainGui.hwnd
button1Click(*) => SendToClipboard(Format("{1}",editSection2.Value))
resetButtonClick(*)
{
    global sections
    sections := ""
    sectionEdit.Value := "section"
    pasteSection.value := "pasteSection"
}
firstButtonClick(*) 
{
    addSection()
}
editSectionChange(*)
{
    finalwrap()
}

pasteSectionSectionChange(*)
{
    finalCopyEdit.Value := "`n[[ " sectionEdit.Value " section START ]] `n" pasteSection.Value  "`n[[ " sectionEdit.Value " section END ]]`n`n"
}
SendToClipboard(str)
{
    return A_Clipboard := str
}
addSection()
{
    global sections
    sections .=  "`n[[ " Trim(sectionEdit.Value) " section START ]] `n" pasteSection.Value  "`n[[ " Trim(Trim(sectionEdit.Value)) " section END ]]`n`n"
    sectionEdit.Value := "section"
    pasteSection.value := "pasteSection"
}
finalCopyButtonClick(*)
{
    addSection()
    finalwrap()
    A_Clipboard := finalCopyEdit.Value
}
lastFinal := ""
finalwrap(){
    global sections, lastFinal
    ;editSection2.Value := "[[ " editSection.Value " section START ]]"
    ;sectionEdit.Value := "[[ " editSection.Value " section END ]]"
    nextScript := "thanks for your help. My request: " questionEdit.value .  "`n" sections "`nagain, thanks. My question: " questionEdit.value
    if lastFinal != nextScript {
            finalCopyEdit.Value := nextScript
            lastFinal := finalCopyEdit.Value
        }
}