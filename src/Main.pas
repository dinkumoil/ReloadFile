{
    This file is part of the ReloadFile plugin for Notepad++
    Author: Andreas Heim

    This program is free software; you can redistribute it and/or modify it
    under the terms of the GNU General Public License version 3 as published
    by the Free Software Foundation.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License along
    with this program; if not, write to the Free Software Foundation, Inc.,
    51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
}

unit Main;


interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.StrUtils, System.DateUtils,
  System.IOUtils, System.Math, System.Types, System.Classes, System.Generics.Defaults,
  System.Generics.Collections, Vcl.Graphics,

  SciSupport, NppSupport, NppMenuCmdID, NppPlugin, NppPluginForms, NppPluginDockingForms,

  dialog_TfrmAbout;


type
  // Plugin class
  TReloadFilePlugin = class(TNppPlugin)
  private
    FMenuItemIdxReloadFile:  integer;
    FMenuItemIdxAbout:       integer;
    FToolbarIconStdSmall:    TBitmap;
    FToolbarIconFluentLight: TIcon;
    FToolbarIconFluentDark:  TIcon;

  protected
    // Handler for certain Notepad++ events
    procedure   DoNppnToolbarModification; override;

  public
    constructor Create; override;
    destructor  Destroy; override;

    // Function to reload the file of the currently active tab
    procedure   DoReloadFile;
    
  end;


var
  // Class type to create in startup code
  PluginClass: TNppPluginClass = TReloadFilePlugin;

  // Plugin instance variable, this is the reference to use in plugin's code
  Plugin: TReloadFilePlugin;



implementation

{$R .\Res\images.res}


const
  // Plugin name
  TXT_PLUGIN_NAME:              string = 'ReloadFile';

  TXT_MENUITEM_RELOADFILE:      string = 'Reload File';
  TXT_MENUITEM_ABOUT:           string = 'About';

  ID_TOOLBAR_ICON_STD_SMALL:    string = 'TOOLBAR_ICON_STD_SMALL';
  ID_TOOLBAR_ICON_FLUENT_LIGHT: string = 'TOOLBAR_ICON_FLUENT_LIGHT';
  ID_TOOLBAR_ICON_FLUENT_DARK:  string = 'TOOLBAR_ICON_FLUENT_DARK';


// Functions associated to the plugin's Notepad++ menu entries
procedure ReloadFile; cdecl; forward;
procedure ShowAbout; cdecl; forward;


// =============================================================================
// Class TReloadFilePlugin
// =============================================================================

// -----------------------------------------------------------------------------
// Create / Destroy
// -----------------------------------------------------------------------------

constructor TReloadFilePlugin.Create;
begin
  inherited Create;

  // Store a reference to the instance in a global variable with an appropriate
  // type to get access to its properties and methods
  Plugin := Self;

  // This property is important to extract version infos from the DLL file,
  // so set it right now after creation of the object
  PluginName := TXT_PLUGIN_NAME;

  // Add plugins's menu entries to Notepad++
  FMenuItemIdxReloadFile := AddFuncItem(TXT_MENUITEM_RELOADFILE, Main.ReloadFile);
  FMenuItemIdxAbout      := AddFuncItem(TXT_MENUITEM_ABOUT,      Main.ShowAbout);
end;


destructor TReloadFilePlugin.Destroy;
begin
  // Cleanup
  FToolbarIconStdSmall.Free;
  FToolbarIconFluentLight.Free;
  FToolbarIconFluentDark.Free;

  // It's totally legal to call Free on already freed instances,
  // no checks needed
  frmAbout.Free;

  inherited;
end;


// -----------------------------------------------------------------------------
// (De-)Initialization
// -----------------------------------------------------------------------------



// -----------------------------------------------------------------------------
// Event handler
// -----------------------------------------------------------------------------

// Called when Notepad++ is ready for toolbar modifications
procedure TReloadFilePlugin.DoNppnToolbarModification;
var
  IconDataOld: TToolbarIcons;
  IconDataNew: TToolbarIconsWithDarkMode;

begin
  inherited;

  if IsNppMinVersion(8, 0) then
  begin
    FToolbarIconStdSmall := TBitmap.Create;
    FToolbarIconStdSmall.LoadFromResourceName(HInstance, ID_TOOLBAR_ICON_STD_SMALL);
    FToolbarIconStdSmall.PixelFormat := pf8Bit;

    FToolbarIconFluentLight := TIcon.Create;
    FToolbarIconFluentLight.LoadFromResourceName(HInstance, ID_TOOLBAR_ICON_FLUENT_LIGHT);

    FToolbarIconFluentDark := TIcon.Create;
    FToolbarIconFluentDark.LoadFromResourceName(HInstance, ID_TOOLBAR_ICON_FLUENT_DARK);

    IconDataNew.ToolbarBmp          := FToolbarIconStdSmall.Handle;
    IconDataNew.ToolbarIcon         := FToolbarIconFluentLight.Handle;
    IconDataNew.ToolbarIconDarkMode := FToolbarIconFluentDark.Handle;

    AddToolbarIconEx(CmdIdFromMenuItemIdx(FMenuItemIdxReloadFile), IconDataNew);
  end
  else
  begin
    FToolbarIconStdSmall := TBitmap.Create;
    FToolbarIconStdSmall.LoadFromResourceName(HInstance, ID_TOOLBAR_ICON_STD_SMALL);
    FToolbarIconStdSmall.PixelFormat := pf8Bit;

    IconDataOld.ToolbarBmp  := FToolbarIconStdSmall.Handle;
    IconDataOld.ToolbarIcon := 0;

    AddToolbarIcon(CmdIdFromMenuItemIdx(FMenuItemIdxReloadFile), IconDataOld);
  end;
end;


// -----------------------------------------------------------------------------
// Worker methods
// -----------------------------------------------------------------------------

// Request file reload
procedure TReloadFilePlugin.DoReloadFile;
begin
  ReloadCurrentFile(false);
end;



// -----------------------------------------------------------------------------
// Plugin menu items
// -----------------------------------------------------------------------------

// Reload file of currently active tab
procedure ReloadFile; cdecl;
begin
  Plugin.DoReloadFile();
end;


// Show "About" dialog in Notepad++
procedure ShowAbout; cdecl;
begin
  if not Assigned(frmAbout) then
  begin
    // Show about dialog in a modal state and destroy it after close
    frmAbout := TfrmAbout.Create(Plugin);
    frmAbout.ShowModal;
    frmAbout.Free;
  end;
end;


end.
