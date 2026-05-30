param(
    [string]$Version,
    [string]$Date,
    [string]$UpdateLog
)

$ErrorActionPreference = 'Stop'

$Root = Split-Path -Parent $PSScriptRoot
$VersionFile = Join-Path $Root 'version.json'
$ReadmeFile = Join-Path $Root 'README.md'
$HtmlFile = Join-Path $Root 'excel-tools.html'

function Replace-Required {
    param(
        [string]$Path,
        [string]$Pattern,
        [string]$Replacement,
        [string]$Description
    )

    $content = Get-Content -LiteralPath $Path -Raw -Encoding UTF8
    if ($content -notmatch $Pattern) {
        throw "Cannot find target: $Description ($Path)"
    }

    $updated = [regex]::Replace($content, $Pattern, $Replacement, 1)
    if ($updated -ne $content) {
        Set-Content -LiteralPath $Path -Value $updated -Encoding UTF8 -NoNewline
    }
}

$meta = Get-Content -LiteralPath $VersionFile -Raw -Encoding UTF8 | ConvertFrom-Json

if ($Version) {
    if ($Version -notmatch '^\d+\.\d+\.\d+$') {
        throw 'Version must use x.y.z format, for example: 2.0.2'
    }
    $meta.version = $Version
}

if ($Date) {
    if ($Date -notmatch '^\d{4}-\d{2}-\d{2}$') {
        throw 'Date must use yyyy-MM-dd format, for example: 2026-05-30'
    }
    $meta.date = $Date
}

if ($UpdateLog) {
    $meta.updateLog = $UpdateLog
}

$meta | ConvertTo-Json -Depth 4 | Set-Content -LiteralPath $VersionFile -Encoding UTF8

$versionText = [string]$meta.version
$dateText = [string]$meta.date

Replace-Required `
    -Path $HtmlFile `
    -Pattern "const CURRENT_VERSION = '[^']+';" `
    -Replacement "const CURRENT_VERSION = '$versionText';" `
    -Description 'excel-tools.html CURRENT_VERSION'

Replace-Required `
    -Path $ReadmeFile `
    -Pattern '!\[Version\]\(https://img\.shields\.io/badge/version-v\d+\.\d+\.\d+-black\)' `
    -Replacement "![Version](https://img.shields.io/badge/version-v$versionText-black)" `
    -Description 'README version badge'

Replace-Required `
    -Path $ReadmeFile `
    -Pattern '`v\d+\.\d+\.\d+`' `
    -Replacement "``v$versionText``" `
    -Description 'README current version'

Replace-Required `
    -Path $ReadmeFile `
    -Pattern '`\d{4}-\d{2}-\d{2}`' `
    -Replacement "``$dateText``" `
    -Description 'README release date'

Replace-Required `
    -Path $ReadmeFile `
    -Pattern '(?m)^`v\d+\.\d+\.\d+`(?= )' `
    -Replacement "``v$versionText``" `
    -Description 'README current UI version'

Write-Host "Version synced: v$versionText ($dateText)"
