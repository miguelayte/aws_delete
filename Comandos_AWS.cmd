cntb delete objects --region EU --bucket "sqlserver-backups" --prefix "srv107\2022 _05_"

access_key = de8386cfbb404bdfa6793d6981cd830d
secret_key = 2af4ea1ddcf7756812d2176eace2f924
URL de S3 = https://eu2.contabostorage.com

REM Listar los archivos de un bucket
aws --profile eu2 --region default --endpoint-url https://eu2.contabostorage.com s3 ls s3://sqlserver-backups

REM Listar los archivos de un bucket (solo mayo)
cntb delete objects --region EU --bucket "sqlserver-backups" --prefix "srv107\2022 _05_"
aws --profile eu2 --region default --endpoint-url https://eu2.contabostorage.com s3 ls "s3://sqlserver-backups/srv107\2022 _05"

REM Listar por rango de fechas y enviarlo a un archivo de texto
aws --profile eu2 --region default --endpoint-url https://eu2.contabostorage.com s3api list-objects --bucket sqlserver-backups --query "Contents[?LastModified>='2022-07-30' && LastModified<='2022-08-16'].[Key]" --output text > "awsDeleteObjects.cmd"


aws --profile eu2 --region default --endpoint-url https://eu2.contabostorage.com s3api list-objects --bucket sqlserver-backups --query "Contents[?LastModified<='2022-05-31'].[Key]" --output text > archivos06.txt


aws --profile eu2 --region default --endpoint-url https://eu2.contabostorage.com s3api list-objects-v2 --bucket "sqlserver-backups" --query "Contents[?contains(LastModified, '2022-05-31')].{Key: Key}" --output text | xargs -n1 -t -I 'KEY' aws --profile eu2 --region default --endpoint-url https://eu2.contabostorage.com s3 rm s3://sqlserver-backups/'KEY'

aws --profile eu2 --region default --endpoint-url https://eu2.contabostorage.com s3api delete-object --bucket "sqlserver-backups" --key "test.txt"

aws --profile eu2 --region default --endpoint-url https://eu2.contabostorage.com s3api delete-objects --bucket sqlserver-backups --delete '{"Objects":[{"Key":"worksheet.xlsx"},{"Key":"purple.gif"}]}'

aws --profile eu2 --region default --endpoint-url https://eu2.contabostorage.com s3 ls s3://sqlserver-backups --recursive --human-readable --summarize | awk -F'[-: ]' '$1 = 2022 && $2 = 6 {print}