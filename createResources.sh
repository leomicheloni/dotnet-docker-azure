resourcegroup=webapptokiotastandard_rg
location=eastus2
server_name=webapptokiotastandardserver
db_username=admintokiota
db_password=T123456!
db_name=webapptokiotastandarddb
app_name=webapptokiotastandard
user_name=roberto.pindado

az group create --name $resourcegroup --location $location
az sql server create --name $server_name --resource-group $resourcegroup --location $location --admin-user $db_username --admin-password $db_password
az sql server firewall-rule create --resource-group $resourcegroup --server $server_name --name AllowAllIps --start-ip-address 0.0.0.0 --end-ip-address 0.0.0.0
az sql db create --resource-group $resourcegroup --server $server_name --name $db_name --service-objective S0
az webapp deployment user set --user-name $user_name
az appservice plan create --name myAppServicePlan --resource-group $resourcegroup --sku FREE
$webapp = az webapp create --resource-group $resourcegroup --plan myAppServicePlan --name $app-name --deployment-local-git
$connectionString = Server=tcp:${server_name}.database.windows.net,1433;Database=${db_name};User ID=${db_username};Password=${db_password};Encrypt=true;Connection Timeout=30;
az webapp config connection-string set --resource-group $resourcegroup --name $app_name --settings MyDbConnection=$connectionString --connection-string-type SQLServer
az webapp config appsettings set --name $app_name --resource-group $resourcegroup --settings ASPNETCORE_ENVIRONMENT="Production"
git add .
git commit -m "connect to SQLDB in Azure"
git remote add azure $webapp.deploymentLocalGitUrl
git push azure master


