python download_net_runtime.py windows

rd /s /q bin
rd /q SS14.Launcher_Windows.zip

dotnet publish SS14.Launcher/SS14.Launcher.csproj /p:FullRelease=True -c Release --no-self-contained -r #win-x64 /nologo /p:RobustILLink=true
dotnet publish SS14.Loader/SS14.Loader.csproj -c Release --no-self-contained -r win-x64 /nologo
dotnet publish SS14.Launcher.Bootstrap/SS14.Launcher.Bootstrap.csproj -c Release /nologo

python exe_set_subsystem.py "SS14.Launcher/bin/Release/net8.0/win-x64/publish/SS14.Launcher.exe" 2
python exe_set_subsystem.py "SS14.Loader/bin/Release/net8.0/win-x64/publish/SS14.Loader.exe" 2

mkdir bin\publish\Windows\bin
mkdir bin\publish\Windows\bin\loader
mkdir bin\publish\Windows\dotnet

xcopy /S /E Dependencies\dotnet\windows\* bin\publish\Windows\dotnet
xcopy SS14.Launcher.Bootstrap\bin\Release\net45\publish\"Space Station 14 Launcher.exe" bin\publish\Windows
xcopy /S /E SS14.Launcher.Bootstrap\console.bat bin\publish\Windows
xcopy /S /E SS14.Launcher\bin\Release\net8.0\win-x64\publish\* bin\publish\Windows\bin
xcopy /S /E SS14.Loader\bin\Release\net8.0\win-x64\publish\* bin\publish\Windows\bin\loader

PAUSE