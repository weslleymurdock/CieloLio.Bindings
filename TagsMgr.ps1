<# 
	Tags Manager v1.0
#>

param(
	[string] $version,
	[bool] $deleteRemote = False
)

if ($args[0] -Eq "--help")
{
	Write-Host "Tags Manager pwsh script. It helps (re)generate a tag and publish to remote git repo. It also delete remote tag and local tag in case of CI/CD publish error"
	Write-Host "Usage:"
	Write-Host "      ./TagsMgr.ps1 -version 2.0.212"
	Write-Host "	      - It Creates a tag and push to remote"
	Write-Host "      ./TagsMgr.ps1 -version 2.0.212 -deleteRemote False"
	Write-Host "           - It delete remote and local tags to create and push new tags"
	Write-Host "      ./TagsMgr.ps1 --help"
	Write-Host "           - It shows this output"
	Write-Host "Version: 1.0"
	exit 0;
}


if ($deleteRemote -Eq True){
	git push --delete origin "v$(version)"
	git tag -d "v$(version)"
}

git tag "v$(version)"
git push origin --Tags

Write-Host "Done."