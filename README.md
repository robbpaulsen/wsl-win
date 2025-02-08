# README.md

___
## **Author**

robbpaulsen

## **Name**

Se pronuncia "DOUBL-YIU-ESS-EL GWIN"
___

<br>

`wsl-win`

### **Description**

Script que habilita e inicializa WSL/Windows Susystem for Linux en Windows 1X

### **Installation**

1. Clona el proyecto/repositorio

```powershell
git clone https://gitlab.com/robbpaulsen/wsl-win
Set-Location -Path .\wsl-win
```

2. Antes de ejecutar el script hay que tener en cuenta que es un Script de tercero por lo que este
no viene firmado y por eso se tiene que desbloquear (este procedimeinto es normal y tambien se debe de aplicar si manipulas o interactuas con archivos comprimidos desde la terminal, ya que Defender puede interrumpir, cancelar y/o enviar a cuarentena tu script/archivo)

```powershell
Unblock-File -Path .\setup.ps1
```

3. Ejecuta el script desde una terminal usando PowerShell 7 (de preferencia pero tambien
se ejecutaria con windows powershell o powershell 5 como se le conoce tambien)

```powershell
PS> .\setup.ps1
```