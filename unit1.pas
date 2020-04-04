unit Unit1;

{$mode objfpc}{$H+}
{
    DBF view es un visor de archivos en formato dbf (*.dbf)>
    Copyright (C) <2020>  <Rafael Bidegain>

    This program is free software: you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation, either version 3 of the License, or
    (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with this program.  If not, see <https://www.gnu.org/licenses/>.
}
interface

uses
  Classes, SysUtils, dbf, db, FileUtil, Forms, Controls, Graphics, Dialogs,
  Menus, ExtCtrls, ComCtrls, DBGrids, StdCtrls;

type

  { TForm1 }

  TForm1 = class(TForm)
    ComboBox1: TComboBox;
    DBGrid: TDBGrid;
    ds: TDataSource;
    Dbf: TDbf;
    MainMenu1: TMainMenu;
    MenuItem1: TMenuItem;
    MenuItem10: TMenuItem;
    MenuItem11: TMenuItem;
    MenuItem12: TMenuItem;
    MenuItem13: TMenuItem;
    MenuItem2: TMenuItem;
    MenuItem3: TMenuItem;
    MenuItem4: TMenuItem;
    MenuItem5: TMenuItem;
    MenuItem6: TMenuItem;
    MenuItem7: TMenuItem;
    MenuItem8: TMenuItem;
    MenuItem9: TMenuItem;
    OpenDialog: TOpenDialog;
    Panel1: TPanel;
    Panel2: TPanel;
    StatusBar1: TStatusBar;
    procedure MenuItem11Click(Sender: TObject);
    procedure MenuItem13Click(Sender: TObject);
    procedure MenuItem2Click(Sender: TObject);
    procedure MenuItem3Click(Sender: TObject);
    procedure MenuItem5Click(Sender: TObject);
    procedure MenuItem6Click(Sender: TObject);
    procedure MenuItem7Click(Sender: TObject);
    procedure MenuItem9Click(Sender: TObject);
  private

  public

  end;

var
  Form1: TForm1;

implementation

{$R *.lfm}

{ TForm1 }

procedure TForm1.MenuItem2Click(Sender: TObject);
var
  i:integer;
begin
  if opendialog.Execute then
  begin
     dbf.close;
     dbf.TableName:=OpenDialog.FileName;
     dbf.Exclusive:=true;
     dbf.open;
     StatusBar1.Panels[0].Width:=100;
     StatusBar1.Panels[1].Text:=OpenDialog.FileName;
     StatusBar1.Panels[0].Text:='Reg: '+ IntToStr(dbf.ExactRecordCount);

     ComboBox1.Items.clear;
     for i:=1 to dbf.Indexes.Count do
          ComboBox1.Items.add(dbf.Indexes[i-1].Name);
  end;
end;

procedure TForm1.MenuItem11Click(Sender: TObject);
begin
  MessageDlg('Acerca de',
  'DBF view es un visor de archivos en formato DBF (*.dbf)'+#13+
  'Autor: Rafael Bidegain'+#13+
  'Abril de 2020'+#13+#13+
  'Este programa es Software Libre.'+#13+
  'licenciado bajo los terminos de la GPL V3'+#13+
  'https://fsfe.org/campaigns/gplv3/gplv3.es.html'+#13+
  'https://www.gnu.org/licenses/gpl-3.0.html',
  mtInformation,
  [mbOK],
  '0'
  );
end;

procedure TForm1.MenuItem13Click(Sender: TObject);
  var
    i:integer;
  begin
    if opendialog.Execute then
    begin
       dbf.close;
       dbf.TableName:=OpenDialog.FileName;
       dbf.Exclusive:=false;
       dbf.open;
       StatusBar1.Panels[0].Width:=100;
       StatusBar1.Panels[1].Text:=OpenDialog.FileName;
       StatusBar1.Panels[0].Text:='Reg: '+ IntToStr(dbf.ExactRecordCount);

       ComboBox1.Items.clear;
       for i:=1 to dbf.Indexes.Count do
            ComboBox1.Items.add(dbf.Indexes[i-1].Name);
    end;

end;

procedure TForm1.MenuItem3Click(Sender: TObject);
begin
  dbf.Close;
  ComboBox1.Items.clear;
  StatusBar1.Panels[0].Text:='';
  StatusBar1.Panels[1].Text:='';
end;

procedure TForm1.MenuItem5Click(Sender: TObject);
begin
  DBGrid.ReadOnly:=True;
end;

procedure TForm1.MenuItem6Click(Sender: TObject);
begin
  DBGrid.ReadOnly:=False;
end;

procedure TForm1.MenuItem7Click(Sender: TObject);
begin
  if Dbf.active and (not Dbf.Exclusive)then
  begin
     dbf.RegenerateIndexes;
  end
  else
     showmessage('Seleccione abrir en modo exclusivo');
end;

procedure TForm1.MenuItem9Click(Sender: TObject);
begin
  dbf.Close;
  form1.close;
end;

end.

