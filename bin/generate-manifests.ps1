$templateString = @"
{
    "version": "0.0",
    "license": "MIT",
    "homepage": "https://github.com/ryanoasis/nerd-fonts",
    "url": " ",
    "hash": " ",
    "checkver": "github",
    "autoupdate": {
        "url": "https://github.com/ryanoasis/nerd-fonts/releases/download/v`$version/%name.zip"
    },
    "installer": {
        "script": [
            "`$AccessRule = New-Object System.Security.AccessControl.FileSystemAccessRule(\"NT AUTHORITY\\LOCAL SERVICE\", \"ReadAndExecute, Synchronize\", \"ContainerInherit, ObjectInherit\", \"None\", \"Allow\")",
            "`$Acl = Get-Acl `$dir",
            "`$Acl.SetAccessRule(`$AccessRule)",
            "`Set-Acl -Path `$dir -AclObject `$Acl",
            "`$TargetKey = \"HKCU:\\SOFTWARE\\Microsoft\\Windows NT\\CurrentVersion\\Fonts\\Scoop.`$app\"",
            "New-Item -Path `$TargetKey -Force | Out-Null",
            "Get-ChildItem `$dir -filter '*Windows Compatible.*' | ForEach-Object {",
            "    New-ItemProperty -Path `$TargetKey -Name `$_.Name -Value `$_.FullName -Force | Out-Null",
            "}"
        ]
    },
    "uninstaller": {
        "script": [
            "Remove-Item -Path 'HKCU:\\SOFTWARE\\Microsoft\\Windows NT\\CurrentVersion\\Fonts\\Scoop.`$app'"
        ]
    }
}
"@

$fontNames = @(
    "3270",
    "AnonymousPro",
    "Arimo",
    "AurulentSansMono",
    "BigBlueTerminal",
    "BitstreamVeraSansMono",
    "Bold",
    "BoldItalic",
    "CodeNewRoman",
    "Cousine",
    "DejaVuSansMono",
    "DroidSansMono",
    "FantasqueSansMono",
    "FiraCode",
    "FiraMono",
    "Go-Mono",
    "Gohu",
    "Hack",
    "Hasklig",
    "HeavyData",
    "Hermit",
    "Inconsolata",
    "InconsolataGo",
    "InconsolataLGC",
    "Iosevka",
    "Italic",
    "Lekton",
    "LiberationMono",
    "Meslo",
    "Monofur",
    "Monoid",
    "Mononoki",
    "MPlus",
    "Noto",
    "OpenDyslexic",
    "Overpass",
    "ProFont",
    "ProggyClean",
    "Regular",
    "RobotoMono",
    "ShareTechMono",
    "SourceCodePro",
    "SpaceMono",
    "Terminus",
    "Tinos",
    "Ubuntu",
    "UbuntuMono"
)

# Generate manifests
$fontNames | ForEach-Object {
    $templateString -replace "%name", $_ | Out-File -FilePath "$PSScriptRoot\..\bucket\$_-NF-User.json" -Encoding utf8
}

# # Use scoop's checkver script to autoupdate the manifests
# & $psscriptroot\checkver.ps1 * -u

# # Keep frozen files from updating
# $frozenFiles = @(
#     "CodeNewRoman-NF-User",
#     "Gohu-NF-User"
# )

# $frozenFiles | ForEach-Object {
#     git checkout "../bucket/$_.json"
# }
