unit untprincipal;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, FileUtil, Forms, Controls, Graphics, Dialogs, StdCtrls;

type

  { TForm1 }

  TForm1 = class(TForm)
    btnCriptografar: TButton;
    btnDescriptografar: TButton;
    edtLetraInicial: TEdit;
    edtQtdLetras: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    memoTexto1: TMemo;
    memoTexto2: TMemo;
    procedure btnCriptografarClick(Sender: TObject);
    procedure btnDescriptografarClick(Sender: TObject);
    procedure edtLetraInicialKeyPress(Sender: TObject; var Key: char);
    procedure FormCreate(Sender: TObject);
    procedure GerarNovoAlfabeto(letraPartir:char);

  private
    var
       lstNovoAlfabeto, lstAlfabeto: array [0..25] of char;
  public

  end;

var
  Form1: TForm1;

implementation

{$R *.lfm}

{ TForm1 }

procedure TForm1.FormCreate(Sender: TObject);
var
   alfabeto: String;
   numChar, i: integer;
begin
  memoTexto1.Clear;
  memoTexto2.Clear;
  edtLetraInicial.Clear;
  edtQtdLetras.Clear;
  alfabeto:= 'abcdefghijklmnopqrstuvxwyz';
  numChar:= Length(alfabeto);
  for i:= 0 to numChar do
  begin
    lstAlfabeto[i]:=alfabeto[i];
  end;
end;

procedure TForm1.btnCriptografarClick(Sender: TObject);
var
  lstFrase,lstFraCriptus: array of char;
  i, j: integer;
  numTotalLetrasCriptus, numCharFraseEnviada, numCharAleatorio: integer;
  fraseEnviada, fraseCriptus: string;
  letraFrase, letraCriptus:char;
begin

  if Length(edtLetraInicial.Text) > 0 then
  begin
       GerarNovoAlfabeto(edtLetraInicial.Text[1]);
  end;
  fraseEnviada:=memoTexto1.text;
  numCharFraseEnviada:=Length(memoTexto1.Text);
  SetLength(lstFrase, numCharFraseEnviada);

  for i:=1 to numCharFraseEnviada do
  begin
    letraFrase:=fraseEnviada[i];
    if letraFrase<> ' ' then
    begin

        for j:=1 to Length(lstAlfabeto) do
        begin
             if(lstAlfabeto[j] = letraFrase) then
             begin

                letraCriptus:=lstNovoAlfabeto[j];
                lstFrase[i]:=letraCriptus;
             end;
        end;
    end;
    if letraFrase=' ' then
    begin
        lstFrase[i]:=' ';
    end;
  end;
  numCharAleatorio:= StrToInt(edtQtdLetras.Text);
  numTotalLetrasCriptus:= numCharFraseEnviada*numCharAleatorio+numCharFraseEnviada;
  SetLength(lstFraCriptus, numTotalLetrasCriptus);

  for i:=1 to numTotalLetrasCriptus do
  begin
       lstFraCriptus[i]:= lstAlfabeto[Random(25)+1];
  end;
  for i:=1 to numCharFraseEnviada do
  begin
       lstFraCriptus[(numCharAleatorio+1)*i]:=lstFrase[i];
  end;
  SetString(fraseCriptus, PChar(@lstFraCriptus[1]), Length(lstFraCriptus));
  memoTexto2.Text:= fraseCriptus;
end;

procedure TForm1.btnDescriptografarClick(Sender: TObject);
var
  lstFrase: array of char;
  i, j: integer;
  numCharFraseEnviada, numCharAleatorio: integer;
  fraseEnviada, fraseCriptus: string;
  letraCriptus:char;
begin
  fraseEnviada:=memoTexto1.Text;
  numCharAleatorio:= StrToInt(edtQtdLetras.Text);
  numCharFraseEnviada:=Length(fraseEnviada)-(Length(fraseEnviada) div (numCharAleatorio+1));
  SetLength(lstFrase,numCharFraseEnviada);
  GerarNovoAlfabeto(edtLetraInicial.Text[1]);
  for i:= 1 to numCharFraseEnviada do
  begin
    letraCriptus:=fraseEnviada[(numCharAleatorio+1)*i];
    for j:=1 to Length(lstNovoAlfabeto) do
    begin
      if lstNovoAlfabeto[j] = letraCriptus then
      begin
         lstfrase[i] := lstAlfabeto[j];
      end;
    end;
  end;

  SetString(fraseCriptus, PChar(@lstfrase[1]), Length(lstfrase));
  memoTexto2.Text:= fraseCriptus;
end;

procedure TForm1.edtLetraInicialKeyPress(Sender: TObject; var Key: char);
begin
     try
       StrToInt(key);
       Key:=''[1];
       ShowMessage('Digite apenas letras');
     except

     end;
end;

procedure TForm1.GerarNovoAlfabeto(letraPartir:char);
var
  posLetraPartir, i, cont: integer;
begin
  //Gerando um novo alfabeto a partir da letra digitada
  for i:=0 to Length(lstAlfabeto) do
  begin
       if(lstAlfabeto[i] = letraPartir) then
       begin
            posLetraPartir:=i;
            Break;
       end;
  end;
  if posLetraPartir >=1 then
  begin
       cont:= Length(lstAlfabeto)-posLetraPartir+2;
       for i:=posLetraPartir to Length(lstAlfabeto)+1 do
       begin
         lstNovoAlfabeto[i-posLetraPartir+1]:= lstAlfabeto[i];
       end;
       for i:=1 to posLetraPartir-1 do
       begin
         lstNovoAlfabeto[cont]:= lstAlfabeto[i];
         cont:= cont+1;
       end;
  end;
end;


end.

