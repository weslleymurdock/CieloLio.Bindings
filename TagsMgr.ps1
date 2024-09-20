<# 
	Tags Manager v1.0
#>

param(
	[switch]	$help,
	[switch]	$regenerate,
	[switch]    $nocreate,
	[string]	$version
)

if ($help)
{
	Write-Host "Tags Manager pwsh script. It helps (re)generate a tag and publish to remote git repo. It also delete remote tag and local tag in case of CI/CD publish error"
	Write-Host "Usage:"
	Write-Host "      ./TagsMgr.ps1 -version 2.0.212"
	Write-Host "	      - It Creates a tag and push to remote"
	Write-Host "      ./TagsMgr.ps1 -version 2.0.212 -regenerate"
	Write-Host "           - It delete remote and local tags to create and push new tags"
	Write-Host "      ./TagsMgr.ps1 -regenerate -nocreate"
	Write-Host "           - It delete remote and local tags only"
	Write-Host "      ./TagsMgr.ps1 -help"
	Write-Host "           - It shows this output"
	Write-Host "Version: 1.0"
	exit 0;
}

$tag = "v" + $version
$pattern = '^[v][\d+].[\d+].[\d+].*[\w*]*$'


if ($tag -match $pattern)
{
	Write-Host "Valid tag name created"
}
else
{
	Write-Error "tag name not contains valid version. Exiting"
	exit 1
}

if ($regemerate)
{
	git push --delete origin $tag
	git tag -d $tag	
}

if ($regemerate -and $nocreate)
{
	Write-Host "Done"
	exit 0;
}

git tag $tag
git push origin --tags


Write-Host "Done."