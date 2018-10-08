$os_type = (Get-WmiObject -Class Win32_ComputerSystem).SystemType -match ‘(x64)’

if ($os_type -eq "True") {
  Invoke-WebRequest -Uri https://download.microsoft.com/download/7/7/6/776727E8-57EE-4AB5-BC69-6CCDF04A2A70/SQLServer2008R2SP1-KB2528583-x64-ENU.exe -OutFile $env:USERPROFILE\Downloads\SQLServer2008R2SP1-KB2528583-x64-ENU.exe
  SQLServer2008R2SP1-KB2528583-x64-ENU.exe /x:C:\SQLServer2008R2_SP1\SP
  robocopy C:\SQLServer2008R2_SP1\SP C:\SQLServer2008R2_SP1 Setup.exe
  robocopy C:\SQLServer2008R2_SP1\SP\x64 C:\SQLServer2008R2_SP1\x64 /XF Microsoft.SQL.Chainer.PackageData.dll
else {
  $os_type = (Get-WmiObject -Class Win32_ComputerSystem).SystemType -match ‘(x86)’
    if ($os_type -eq "True") {
      Invoke-WebRequest -Uri https://download.microsoft.com/download/7/7/6/776727E8-57EE-4AB5-BC69-6CCDF04A2A70/SQLServer2008R2SP1-KB2528583-x86-ENU.exe -OutFile $env:USERPROFILE\Downloads\SQLServer2008R2SP1-KB2528583-x86-ENU.exe
      SQLServer2008R2SP1-KB2528583-x86-ENU.exe /x:C:\SQLServer2008R2_SP1\SP
      robocopy C:\SQLServer2008R2_SP1\SP C:\SQLServer2008R2_SP1 Setup.exe
      robocopy C:\SQLServer2008R2_SP1\SP\x86 C:\SQLServer2008R2_SP1\x86 /XF Microsoft.SQL.Chainer.PackageData.dll
    }
}

if(![System.IO.File]::Exists($path)){
    # file with path $path doesn't exist
}


setup.exe


