# ReloadFile plugin for Notepad++

Builds for 32 and 64 bits Notepad++ installations available

Author: Andreas Heim, 2019 - 2022


# Features

This is a new implemented clone of the old _ReloadButton_ plugin which is not maintained anymore by its author and never has been available as 64 bit version.

The plugin adds a menu entry to the _Plugins_ menu and a button to the toolbar of Notepad++ that, when pressed, causes a reload of the file in the currently active tab. It is possible to assign a keyboard shortcut to the menu entry via Notepad++ _Shortcut Mapper_.

**Please note: Reload of the file happens without asking the user to save his changed but unsaved document, so use with care!**


# Manual installation

1. Download the latest release. If you run a 32 bits version of Notepad++ take the file `ReloadFile_vX.X_UNI.zip`. In case of a 64 bits version take the file `ReloadFile_vX.X_x64.zip`.
2. Unzip the downloaded file to a folder on your harddisk where you have write permissons.

The following steps depend on the version of Notepad++ you use.


#### Notepad++ versions prior to v7.6

1. Copy the file `ReloadFile.dll` to the `plugins` directory of your Notepad++ installation. You can find the `plugins` directory under the installation path of Notepad++.
2. Copy the file `doc\ReloadFile.txt` to the directory `plugins\doc`. If it doesn't exist create it.


#### Notepad++ version v7.6

1. Under `%UserProfile%\AppData\Local\Notepad++\plugins` create a directory `ReloadFile` and copy the file `ReloadFile.dll` to this directory.
2. Under `%UserProfile%\AppData\Local\Notepad++\plugins\ReloadFile` create a directory `doc` and copy the file `doc\ReloadFile.txt` to this directory.


#### Notepad++ versions v7.6.1 and v7.6.2
1. Under `%ProgramData%\Notepad++\plugins` create a directory `ReloadFile` and copy the file `ReloadFile.dll` to this directory.
2. Under `%ProgramData%\Notepad++\plugins\ReloadFile` create a directory `doc` and copy the file `doc\ReloadFile.txt` to this directory.


#### Notepad++ version v7.6.3 and higher
1. Under `<Npp-install-dir>\plugins` create a directory `ReloadFile` and copy the file `ReloadFile.dll` to this directory.
2. Under `<Npp-install-dir>\plugins\ReloadFile` create a directory `doc` and copy the file `doc\ReloadFile.txt` to this directory.


# History

v1.1 - November 2022
- fixed:    The 64 bit version caused Notepad++ to crash when reloading a file
- fixed:    When plugin's dialog box is on screen but hidden by another application's window which has input focus, it is not possible to return to Notepad++ by clicking its taskbar icon.
- fixed:    Wrong implementation of Notepad++ version comparison.
- enhanced: Added support for Dark Mode icons.
- enhanced: Added new Notepad++ message constants from v7.9.2 up to v8.4.7
- enhanced: Added new Notepad++ menu command ids from v7.9.6 up to v8.4.7
- enhanced: Added new Scintilla constants from v4.4.6 up to v5.3.1
- enhanced: Adapted to new Scintilla v5.3.1 API of Notepad++ v8.4.7

v1.0 - September 2019
- Initial release
