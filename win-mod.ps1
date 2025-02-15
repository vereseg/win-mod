#Updated - 2/25/2025


#Requires -RunAsAdministrator

function ConfigureChanges
{
    Write-Host "==========================================" -ForegroundColor Yellow
    Write-Host "                                          " -ForegroundColor White
    Write-Host "                 Settings                 " -ForegroundColor Yellow
    Write-Host "                                          " -ForegroundColor White
    Write-Host "  Remove cross device programs       (0)  " -ForegroundColor White
    Write-Host "  *note* not currently able to be         " -ForegroundColor Red
    Write-Host "  installed through this script           " -ForegroundColor Red
    Write-Host "                                          " -ForegroundColor White
    Write-Host "  Disable Start Menu web search      (1)  " -ForegroundColor White
    Write-Host "                                          " -ForegroundColor White
    Write-Host "  Use old context menu               (2)  " -ForegroundColor White
    Write-Host "                                          " -ForegroundColor White
    Write-Host "  Disable Windows Error Reporting    (3)  " -ForegroundColor White
    Write-Host "                                          " -ForegroundColor White
    Write-Host "==========================================" -ForegroundColor Yellow
    Write-Host "  Reply with any values inside of ( )     " -ForegroundColor White
    Write-Host "  Multiple values must be seperated       " -ForegroundColor White
    Write-Host "  using ' ' Empty entry ends script       " -ForegroundColor White
    Write-Host "==========================================" -ForegroundColor Yellow
    
    $do_selected_changes = Read-Host "Entry: "
    $do_selected_changes = $do_selected_changes -split " "

    #Remove cross device programs
    if($do_selected_changes -eq 0)
    {
        Get-AppxPackage MicrosoftWindows.CrossDevice -AllUsers | Remove-AppxPackage -AllUsers
        Get-AppxPackage Microsoft.YourPhone -AllUsers | Remove-AppxPackage -AllUsers
    }

    #Start Menu web search
    if($do_selected_changes -eq 1)
    {
        reg add "HKCU\Software\Policies\Microsoft\Windows\Explorer" /v DisableSearchBoxSuggestions /T REG_DWORD /d 1
        Write-Host "disabled start menu web search." -ForegroundColor Green
    }

    #Old context menu
    if($do_selected_changes -eq 2)
    {
        reg add "HKCU\Software\Classes\CLSID\{86ca1aa0-34aa-4e8b-a509-50c905bae2a2}\InprocServer32" /f /ve
        Write-Host "switched to old context menu" -ForegroundColor Green
    }

    #Disable windows error reporting
    if($do_selected_changes -eq 2)
    {
        Disable-WindowsErrorReporting
        Write-Host "disabled windows error reporting" -ForegroundColor Green
    }

    Write-Host "Complete, please restart your computer." -ForegroundColor Yellow
    exit
}

function ConfigureChangesRevert
{
    Write-Host "==========================================" -ForegroundColor Yellow
    Write-Host "                                          " -ForegroundColor White
    Write-Host "                 Settings                 " -ForegroundColor Yellow
    Write-Host "                                          " -ForegroundColor White
    Write-Host "  Cross device programs              ( )  " -ForegroundColor Red
    Write-Host "  *note* not currently able to be         " -ForegroundColor Red
    Write-Host "  installed through this script           " -ForegroundColor Red
    Write-Host "                                          " -ForegroundColor White
    Write-Host "  Disable Start Menu web search      (1)  " -ForegroundColor White
    Write-Host "                                          " -ForegroundColor White
    Write-Host "  Use old context menu               (2)  " -ForegroundColor White
    Write-Host "                                          " -ForegroundColor White
    Write-Host "  Disable Windows Error Reporting    (3)  " -ForegroundColor White
    Write-Host "                                          " -ForegroundColor White
    Write-Host "==========================================" -ForegroundColor Yellow
    Write-Host "  Reply with any values inside of ( )     " -ForegroundColor White
    Write-Host "  Multiple values must be seperated       " -ForegroundColor White
    Write-Host "  using ' ' Empty entry ends script       " -ForegroundColor White
    Write-Host "==========================================" -ForegroundColor Yellow
    
    $do_selected_changes = Read-Host "Entry: "
    $do_selected_changes = $do_selected_changes -split " "

    #Cross device programs
    if($do_selected_changes -eq 0)
    {
        Write-Host "cross device programs need to be installed using winget"
    }

    #Start Menu web search
    if($do_selected_changes -eq 1)
    {
        reg delete "HKCU\Software\Policies\Microsoft\Windows\Explorer" /v DisableSearchBoxSuggestions /f
        Write-Host "enabled start menu web search." -ForegroundColor Green
    }

    #Context menu
    if($do_selected_changes -eq 2)
    {
        reg delete "HKCU\Software\Classes\CLSID\{86ca1aa0-34aa-4e8b-a509-50c905bae2a2}" /f
        Write-Host "switched to default context menu" -ForegroundColor Green
    }

    #Windows error reporting
    if($do_selected_changes -eq 2)
    {
        Enable-WindowsErrorReporting
        Write-Host "enabled windows error reporting" -ForegroundColor Green
    }

    Write-Host "Complete, please restart your computer." -ForegroundColor Yellow
    exit
}

#begin
while($begin_changes -notin "y","n")
{
    $begin_changes = Read-Host "Configure Changes (c), Revert Changes (r), Quit (q)"
    switch($begin_changes)
    {
        {'c' -eq $_}{
            ConfigureChanges
        }
        {'r' -eq $_}{
            ConfigureChangesRevert
        }
        {'q' -eq $_}{
            Write-Host "Canceling" -ForegroundColor Red
            exit
        }
        default{
            Write-Host "invalid please enter 'c', 'r', or 'q'" -ForegroundColor Red
        }
    }
}