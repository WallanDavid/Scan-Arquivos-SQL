Scanner de Restos de Instalações do SQL Server
Este script PowerShell foi desenvolvido para realizar um scanner em busca de restos de instalações do SQL Server na máquina. Ele verifica o registro do Windows em busca de entradas relacionadas ao SQL Server e procura por arquivos e diretórios associados ao SQL Server em locais comuns de instalação.

Pré-requisitos
PowerShell (versão 5.1 ou superior)
Privilegiado como administrador para execução do script
Como Usar
Baixe o arquivo Scan-SQLServerRemnants.ps1 para o seu computador.
Abra o PowerShell como administrador.
Navegue até o diretório onde o script foi baixado.
Execute o script com o comando .\Scan-SQLServerRemnants.ps1.
Funcionamento do Script
Verifica se o script está sendo executado como administrador.
Verifica se o SQL Server está instalado na máquina.
Realiza uma verificação no registro do Windows em busca de entradas relacionadas ao SQL Server.
Procura por arquivos e diretórios associados ao SQL Server em locais comuns de instalação.
Resultados
O script exibirá os resultados das verificações realizadas, mostrando se foram encontrados registros no registro do Windows e quais arquivos/diretórios foram identificados como relacionados ao SQL Server.

Contribuindo
Se você encontrar problemas ou tiver sugestões de melhorias para o script, sinta-se à vontade para abrir uma issue ou enviar um pull request.

Avisos
Este script realiza verificações e não realiza alterações no sistema. Recomenda-se revisar cuidadosamente os resultados antes de tomar qualquer ação.
