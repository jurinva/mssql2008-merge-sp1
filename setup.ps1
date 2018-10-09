function Get-Arch {
  $os_type = (Get-WmiObject -Class Win32_ComputerSystem).SystemType -match ‘(x64)’
  if ($os_type -eq "True") {
    return x64
  else {
    $os_type = (Get-WmiObject -Class Win32_ComputerSystem).SystemType -match ‘(x86)’
      if ($os_type -eq "True") {
        return x64
      }
  }
}

$arch = Get-Arch
$file = SQLServer2008R2SP1-KB2528583-$arch-ENU.exe
$uri = https://download.microsoft.com/download/7/7/6/776727E8-57EE-4AB5-BC69-6CCDF04A2A70/$file
#$x64uri = https://download.microsoft.com/download/7/7/6/776727E8-57EE-4AB5-BC69-6CCDF04A2A70/SQLServer2008R2SP1-KB2528583-x64-ENU.exe

function Merge ($a, $f, $u) {
  Invoke-WebRequest -Uri $u -OutFile $env:USERPROFILE\Downloads\$f
  Start-Process "$f /x:C:\SQLServer2008R2_SP1\SP"
  Start-Process "robocopy C:\SQLServer2008R2_SP1\SP C:\SQLServer2008R2_SP1 Setup.exe"
  Start-Process "robocopy C:\SQLServer2008R2_SP1\SP\$a C:\SQLServer2008R2_SP1\$a /XF Microsoft.SQL.Chainer.PackageData.dll"
}

function Check-IniFile ($a) {
  if(![System.IO.File]::Exists("C:\SQLServer2008R2_SP1\$a")){
    Add-Content C:\SQLServer2008R2_SP1\$a 'PCUSOURCE=".\SP"'
  }
}

function Main ($arch, $file, $uri) {
  Merge $arch $file $uri
  Check-IniFile $arch
  Start-Process "C:\SQLServer2008R2_SP1\setup.exe"
}

Main $arch $file $uri

