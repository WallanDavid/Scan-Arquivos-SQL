Meta Business > Configurações > Configurações do Negócio > Contas > Páginas (validar se a página já existe e vai ser utilizada ou não)

Se tiver = Utilizar página existênte, ir até as configurações da página no facebook e adicionar pessoas para isso

Se não tiver = Criar uma página na hora, vincular instagram, conta de anúncios  

Em boleto é recomendável ser depositado semanalmente 


# Verifica se o script está sendo executado como administrador
if (-not ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
    Write-Error "Este script precisa ser executado como administrador."
    Exit
}

# Função para verificar a existência de registros no registro do Windows
function CheckRegistryEntries {
    param($searchTerm)

    $registryPath = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall"
    $foundEntries = Get-ChildItem $registryPath | Where-Object { $_.GetValue("DisplayName") -like "*$searchTerm*" }

    if ($foundEntries.Count -gt 0) {
        Write-Output "Registros encontrados no registro do Windows para '$searchTerm':"
        $foundEntries | ForEach-Object {
            $_.GetValue("DisplayName")
        }
    } else {
        Write-Output "Nenhum registro encontrado no registro do Windows para '$searchTerm'."
    }
}

# Função para verificar a existência de arquivos e diretórios
function CheckFileSystem {
    param($searchPath, $searchPattern)

    $foundFiles = Get-ChildItem -Path $searchPath -Recurse -Include $searchPattern

    if ($foundFiles.Count -gt 0) {
        Write-Output "Arquivos e diretórios encontrados em '$searchPath':"
        $foundFiles | ForEach-Object {
            $_.FullName
        }
    } else {
        Write-Output "Nenhum arquivo ou diretório encontrado em '$searchPath'."
    }
}

# Verifica se o SQL Server está instalado
$sqlInstalled = $false
$instances = Get-WmiObject -Class Win32_Product | Where-Object { $_.Name -like "*SQL Server*" }
if ($instances.Count -gt 0) {
    $sqlInstalled = $true
}

if (-not $sqlInstalled) {
    Write-Output "Nenhuma instância do SQL Server encontrada na máquina."
    Exit
}

# Executa as verificações
CheckRegistryEntries "SQL Server"
CheckRegistryEntries "Microsoft SQL Server"

$commonProgramFiles = [System.Environment]::GetFolderPath('CommonProgramFiles')
$commonProgramFiles += "\Microsoft Shared\"
CheckFileSystem $commonProgramFiles "*SQL Server*"

$installPath = (Get-ItemProperty "HKLM:\Software\Microsoft\Windows\CurrentVersion\Uninstall\Microsoft SQL Server Management Studio - 15.0 (64-bit)").InstallLocation
if ($installPath) {
    CheckFileSystem $installPath "*SQL Server*"
}

Write-Output "Scan de restos de SQL Server concluído."
