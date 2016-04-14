#——————————————————————————

# PowerShell console profile
# 
#

# NOTES: contains five types of things: aliases, functions, psdrives,variables, and commands.
# version 1.00
# 21/3/2016

#USAGE:
# Test-Path $profile 
# New-Item $profile -ItemType File -Force
# Use .$Profile to reload.
#——————————————————————————
$host.UI.RawUI.WindowTitle = "ShellPower"

#Aliases
#——————————————————————————
set-alias grep Select-String
Set-Alias -Name ep -Value edit-profile | out-null
set-alias gh Get-Help
set-alias np C:\windows\system32\notepad.exe
# set-alias h history
Set-Alias ih Invoke-History

# set-alias nano "C:\Users\xxx\Apps\nano\nano.exe"


#Functions
#——————————————————————————
Function Edit-Profile
{ ISE $profile }

# Launch explorer in current folder
Function e { ii . }

# get up one directory
function .. { Push-Location ..}

# logfile
Function log
{ Get-Content "$env:USERPROFILE\AppData\Local\Citrix\DesktopPlayer\engine\var\log\mepd_errors.log" -tail 20 -wait }

# save history
$HistoryFilePath = Join-Path -Path ([Environment]::GetFolderPath('UserProfile')) -ChildPath ".ps_history"; 
function Persist-History {
  Register-EngineEvent -SourceIdentifier PowerShell.Exiting -Action {
    Get-History | Select-Object -Unique | Export-Clixml -Path $HistoryFilePath;
  } | Out-Null;
  if (Test-path -Path $HistoryFilePath) { 
    Import-Clixml -Path $HistoryFilePath | Add-History;
  }
  Set-PSReadlineKeyHandler -Key UpArrow -Function HistorySearchBackward;
  Set-PSReadlineKeyHandler -Key DownArrow -Function HistorySearchForward;
} 
Persist-History;



#dictu
# load log file
#Function log
#{ $Session = new-pssession -computername xxx
#  Invoke-Command -Session $Session -ScriptBlock { C:\scripts\tail-log.ps1 }
#  }





# Variables
#——————————————————————————
New-Variable -Name doc -Value “$home\documents”

#PS_Drives
#——————————————————————————

#Commands
#——————————————————————————
#set-location C:\Users\xxx\Documents\Scripts
