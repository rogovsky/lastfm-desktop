; Script generated by the Inno Setup Script Wizard.
; SEE THE DOCUMENTATION FOR DETAILS ON CREATING INNO SETUP SCRIPT FILES!

[CustomMessages]
Version=2.1.0.8

[Setup]
OutputBaseFilename=WmpPluginSetup_2.1.0.8
; setup.exe version
VersionInfoVersion=2.1.0.8
VersionInfoTextVersion=2.1.0.8
AppName=Last.fm Windows Media Player Plugin
AppVerName=Last.fm Windows Media Player Plugin {cm:Version}
VersionInfoDescription=Last.fm WMP Plugin Installer
AppPublisher=Last.fm
AppPublisherURL=http://www.last.fm
AppSupportURL=http://www.last.fm
AppUpdatesURL=http://www.last.fm
AppCopyright=Copyright Last.fm Ltd.
DefaultDirName="{pf}\Windows Media Player\Plugins"
UsePreviousAppDir=yes
UninstallFilesDir={commonappdata}\Last.fm\Client\UninstWMP
OutputDir=.
Compression=lzma
SolidCompression=yes
DirExistsWarning=no
DisableReadyPage=yes
; Keep this the same across versions, even if they're incompatible. That will ensure
; uninstallation works fine after many upgrades. Can't use GUID as it'll break backward
; compatibility.
AppId=Audioscrobbler Windows Media Player Plugin
CreateUninstallRegKey=no

[Registry]
; The name of the final subkey here must match the one in plugins.data
Root: HKLM; Subkey: "Software\Last.fm\Client\Plugins\wmp"; ValueType: string; ValueName: "Version"; ValueData: "{cm:Version}"; Flags: uninsdeletekey
Root: HKLM; Subkey: "Software\Last.fm\Client\Plugins\wmp"; ValueType: string; ValueName: "Name"; ValueData: "Windows Media Player"; Flags: uninsdeletekey

[Languages]
Name: "english"; MessagesFile: "compiler:Default.isl"

[InstallDelete]
Type: files; Name: "{app}\wmp_scrobbler.dll"

[UninstallDelete]
; For legacy reasons (log is now stored in a user-specific location)
Type: files; Name: "{app}\AudioScrobbler.log.txt"

; Try and delete the localappdata log for the case where the user running the uninstaller is the same as the plugin user
Type: files; Name: "{localappdata}\Last.fm\Client\WmpPlugin.log"

[Files]
Source: "Release\wmp_scrobbler.dll"; DestDir: "{app}"; Flags: ignoreversion
; NOTE: Don't use "Flags: ignoreversion" on any shared system files

[Run]
Filename: "regsvr32.exe"; Parameters: "/s ""{app}/wmp_scrobbler.dll"""

[UninstallRun]
Filename: "regsvr32.exe"; Parameters: "/u /s ""{app}/wmp_scrobbler.dll"""

[Code]
procedure CurStepChanged(CurStep: TSetupStep);
var
  batfile: String;
  batcontent: String;
  uninstaller: String;
  alreadyAdded: Boolean;
  cmdToAdd: String;
begin
  if (CurStep = ssPostInstall) then
  begin
    //MsgBox('postinstall', mbInformation, MB_OK);

    batfile := ExpandConstant('{commonappdata}\Last.fm\Client\uninst2.bat');
    LoadStringFromFile(batfile, batcontent);
    //MsgBox('loaded string: ' + batcontent, mbInformation, MB_OK);

    uninstaller := ExpandConstant('{uninstallexe}');
    //MsgBox('uninstaller pre-OEM: ' + uninstaller, mbInformation, MB_OK);

    alreadyAdded := (Pos(uninstaller, batcontent) <> 0);
    if (alreadyAdded = False) then
    begin
      cmdToAdd := uninstaller + #13#10;
      //MsgBox('not present, will add: ' + cmdToAdd, mbInformation, MB_OK);

      SaveStringToFile(batfile, cmdToAdd, True)
    end;

  end;

end;
