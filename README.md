# Introduction 
Sample source code based on the repository https://github.com/azure-samples/dotnetcore-sqldb-tutorial
The application will evolve over time following convections and best practices

# Getting Started
Required software:
- Git
- Net Core SDK

To install the required packages, update the database and run the application locally, execute the following commands:
```
dotnet tool install -g dotnet-ef --version 3.1.1
dotnet-ef database update
dotnet run
```

To deploy the application on Azure install AZ Cli, and run the default authentication method:
```
az login
```
Sign in with your account and execute the bash script `createResources.sh` or run the following commands replacing the correct values

```
az group create --name <resourcegroup> --location <location>
az sql server create --name <server_name> --resource-group <resourcegroup> --location <location> --admin-user <db_username> --admin-password <db_password>
```
Save the deploymentLocalGitUrl obtained for later.
```
az sql server firewall-rule create --resource-group <resourcegroup> --server <server_name> --name AllowAllIps --start-ip-address 0.0.0.0 --end-ip-address 0.0.0.0
az sql db create --resource-group <resourcegroup> --server <server_name> --name <db_name> --service-objective S0
az webapp deployment user set --user-name <user_name>
az appservice plan create --name myAppServicePlan --resource-group <resourcegroup> --sku FREE
az webapp create --resource-group <resourcegroup> --plan myAppServicePlan --name <app-name> --deployment-local-git
az webapp config connection-string set --resource-group <resourcegroup> --name <app_name> --settings MyDbConnection=<connectionString> --connection-string-type SQLServer
az webapp config appsettings set --name <app_name> --resource-group <resourcegroup> --settings ASPNETCORE_ENVIRONMENT="Production"
```

In the appsettings.json, update the connection string ´MyDbConnection´ with the values <server_name>, <db_username> and <db_password> that you just used and push your code with the following commands.
Use the deploymentLocalGitUrl obtained previously when you created your sql server.

```
git add .
git commit -m "connect to SQLDB in Azure"
git remote add azure <deploymentLocalGitUrl>
git push azure master
```
That should be it, browse to `htps://<app_name>.azurewebsites.net`


# Build and Test
TODO: Describe and show how to build your code and run the tests. 

# Contribute
TODO: Explain how other users and developers can contribute to make your code better. 
