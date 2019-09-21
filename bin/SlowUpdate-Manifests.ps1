if (!$env:SCOOP_HOME) { $env:SCOOP_HOME = Resolve-Path (Split-Path (Split-Path (scoop which scoop))) }
$checkver = "$env:SCOOP_HOME\bin\checkver.ps1"
$dir = "$PSScriptRoot\..\bucket" # checks the parent dir
Get-ChildItem $dir | Foreach-Object {
    Invoke-Expression -Command ("$checkver -Dir $dir -App {0} -Update" -f $_.BaseName)
    Start-Sleep -Seconds 2
}
