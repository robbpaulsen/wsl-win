<#
.SYNOPSIS
        Instala WSL (needs admin rights).
.DESCRIPTION
        Script para habilitar e instalar WSL/Windows Subsystem for Linux en Windows 1X.
.EXAMPLE
        ✅ PS> .\setup.ps1
        ⚠️ PS> bash ./setup.ps1
        ⚠️ PS> ./setup.ps1
.LINK
        https://gitlab.com/robbpaulsen/wwsl-win
.NOTES
        Author: robbpaulsen
#>

#Requires -RunAsAdministrator

Clear-Host

# Comprobando si el usuario esta ejecutando como administrador el script
$IsAdmin = (New-Object System.Security.Principal.WindowsPrincipal([System.Security.Principal.WindowsIdentity]::GetCurrent())).IsInRole([System.Security.Principal.WindowsBuiltInRole]::Administrator)
if (-not $IsAdmin) {
        Write-Host "`n⚠️ Necesitas ejecutar el script como administrador" -ForegroundColor Green -BackgroundColor Black
        exit 1
}

# Indicar al usuario el inicio de ejecucion del script
Write-Host "`n⏳Inicia la instalacion de WSL ..." -ForegroundColor Yellow -NoNewline

try {
    $StopWatch = [system.diagnostics.stopwatch]::startNew()
    # Arreglo de los Features que se habilitaran en Windows
    $features = @(
        'Microsoft-Windows-Subsystem-Linux',
        'VirtualMachinePlatform',
        'HypervisorPlatform',
        'Containers'
        )
    # Se inicia la habilitacion e instalacion de los Features
    $features | % { Enable-WindowsOptionalFeature -FeatureName $_ -NoRestart }
    
    # Se configura la version 2 de wsl por default
    Write-Host "`n⏳Habilitando la version 2 de WSL ..." -ForegroundColor Yellow -NoNewline ; Write-Host "👉 [05]" -ForegroundColor Green -BackgroundColor Black
    & wsl --set-default-version 2

    # Se actualizara el kernel de la instancia wsl
    Write-Host "`n⏳Actualizando el kernel de WSL ..."  -ForegroundColor Yellow -NoNewline ; Write-Host "👉 [04]" -ForegroundColor Green -BackgroundColor Black
    & wsl --update

    # Se copiara el archivo de configuracion de wslconfig al directorio del usuario
    $dest1 = "${ENV:USERPROFILE}"
    Copy-Item -Path ".\assets\wslconfig" -Destination "${dest1}"\.wslconfig -Force

    [int]$transcurrido = $StopWatch.Elapsed.TotalSeconds
    Write-Host "`n✅Se instalo WSL en $transcurrido seg" -ForegroundColor Yellow -NoNewline ; Write-Host "`nNOTA: reinicia el equipo ahora para que tome efecto la habilitacion de WSL, despues visota o instalal desde powershell tu distribucion"
    exit 0 # success
} catch {
        "⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
        exit 1
}