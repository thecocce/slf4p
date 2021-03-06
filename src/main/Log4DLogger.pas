(*
   Copyright 2016 Michael Justin

   Licensed under the Apache License, Version 2.0 (the "License");
   you may not use this file except in compliance with the License.
   You may obtain a copy of the License at

       http://www.apache.org/licenses/LICENSE-2.0

   Unless required by applicable law or agreed to in writing, software
   distributed under the License is distributed on an "AS IS" BASIS,
   WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
   See the License for the specific language governing permissions and
   limitations under the License.
*)

unit Log4DLogger;

interface

uses
  Log4D,
  djLogAPI, SysUtils;

type
  TLog4DLogger = class(TInterfacedObject, ILogger)
  private
    Delegate: TLogLogger;

    procedure Log(const ALevel: TLogLevel; const AMsg: string); overload;
    procedure Log(const ALevel: TLogLevel; const AFormat: string; const AArgs: array of const); overload;

  public
    constructor Create(const AName: string);

    procedure Debug(const AMsg: string); overload;
    procedure Debug(const AFormat: string; const AArgs: array of const); overload;
    procedure Debug(const AMsg: string; const AException: Exception); overload;

    procedure Error(const AMsg: string); overload;
    procedure Error(const AFormat: string; const AArgs: array of const); overload;
    procedure Error(const AMsg: string; const AException: Exception); overload;

    procedure Info(const AMsg: string); overload;
    procedure Info(const AFormat: string; const AArgs: array of const); overload;
    procedure Info(const AMsg: string; const AException: Exception); overload;

    procedure Warn(const AMsg: string); overload;
    procedure Warn(const AFormat: string; const AArgs: array of const); overload;
    procedure Warn(const AMsg: string; const AException: Exception); overload;

    procedure Trace(const AMsg: string); overload;
    procedure Trace(const AFormat: string; const AArgs: array of const); overload;
    procedure Trace(const AMsg: string; const AException: Exception); overload;

    function Name: string;

    function IsDebugEnabled: Boolean;
    function IsErrorEnabled: Boolean;
    function IsInfoEnabled: Boolean;
    function IsWarnEnabled: Boolean;
    function IsTraceEnabled: Boolean;

  end;

  TLog4DLoggerFactory = class(TInterfacedObject, ILoggerFactory)
  public
    function GetLogger(const AName: string): ILogger;
  end;

implementation

{ TLog4DLogger }

constructor TLog4DLogger.Create(const AName: string);
begin
  inherited Create;

  Delegate := TLogLogger.GetLogger(AName);
end;

procedure TLog4DLogger.Log(const ALevel: TLogLevel; const AMsg: string);
begin
  Delegate.Log(ALevel, AMsg);
end;

procedure TLog4DLogger.Log(const ALevel: TLogLevel; const AFormat: string;
  const AArgs: array of const);
begin
  if Delegate.IsEnabledFor(ALevel) then
    Delegate.Log(ALevel, Format(AFormat, AArgs));
end;

procedure TLog4DLogger.Debug(const AMsg: string);
begin
  Log(Log4D.Debug, AMsg);
end;

procedure TLog4DLogger.Debug(const AFormat: string; const AArgs: array of const);
begin
  Log(Log4D.Debug, AFormat, AArgs);
end;

procedure TLog4DLogger.Debug(const AMsg: string; const AException: Exception);
begin
  Delegate.Debug(AMsg, AException);
end;

procedure TLog4DLogger.Trace(const AMsg: string; const AException: Exception);
begin
  Delegate.Trace(AMsg, AException);
end;

procedure TLog4DLogger.Trace(const AFormat: string;
  const AArgs: array of const);
begin
  Log(Log4D.Trace, AFormat, AArgs);
end;

procedure TLog4DLogger.Trace(const AMsg: string);
begin
  Log(Log4D.Trace, AMsg);
end;

procedure TLog4DLogger.Warn(const AMsg: string; const AException: Exception);
begin
  Delegate.Warn(AMsg, AException);
end;

procedure TLog4DLogger.Warn(const AFormat: string; const AArgs: array of const);
begin
  Log(Log4D.Warn, AFormat, AArgs);
end;

procedure TLog4DLogger.Warn(const AMsg: string);
begin
  Log(Log4D.Warn, AMsg);
end;

procedure TLog4DLogger.Error(const AFormat: string;
  const AArgs: array of const);
begin
  Log(Log4D.Error, AFormat, AArgs);
end;

procedure TLog4DLogger.Error(const AMsg: string);
begin
  Log(Log4D.Error, AMsg);
end;

procedure TLog4DLogger.Error(const AMsg: string; const AException: Exception);
begin
  Delegate.Error(AMsg, AException);
end;

function TLog4DLogger.Name: string;
begin
  Result := Delegate.Name;
end;

procedure TLog4DLogger.Info(const AMsg: string; const AException: Exception);
begin
  Delegate.Info(AMsg, AException);
end;

function TLog4DLogger.IsDebugEnabled: Boolean;
begin
  Result := Delegate.IsDebugEnabled;
end;

function TLog4DLogger.IsErrorEnabled: Boolean;
begin
  Result := Delegate.IsErrorEnabled;
end;

function TLog4DLogger.IsInfoEnabled: Boolean;
begin
  Result := Delegate.IsInfoEnabled;
end;

function TLog4DLogger.IsTraceEnabled: Boolean;
begin
  Result := Delegate.IsTraceEnabled;
end;

function TLog4DLogger.IsWarnEnabled: Boolean;
begin
  Result := Delegate.IsWarnEnabled;
end;

procedure TLog4DLogger.Info(const AFormat: string; const AArgs: array of const);
begin
  Log(Log4D.Info, AFormat, AArgs);
end;

procedure TLog4DLogger.Info(const AMsg: string);
begin
  Log(Log4D.Info, AMsg);
end;

{ TLog4DLoggerFactory }

function TLog4DLoggerFactory.GetLogger(const AName: string): ILogger;
begin
  Result := TLog4DLogger.Create(AName);
end;

end.
