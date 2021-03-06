{----------------------------------------------------------------------------}
{                       Written by Nguyen Le Quang Duy                       }
{                  Nguyen Quang Dieu High School, An Giang                   }
{----------------------------------------------------------------------------}

Program GSS;
Uses Math;
Const
  maxN =50000;
  oo =1000000000;
Type
  TNode =Record sum,pre,suf,ans :LongInt end;
Var
  n,m,res,first,last :LongInt;
  A :Array[1..maxN] of LongInt;
  IT :Array[1..4*maxN] of TNode;

  procedure Enter;
  var
    i :LongInt;
  begin
    Read(n);
    for i:=1 to n do Read(A[i]);
  end;

  function CombineIT(ITLeft,ITRight :TNode) :TNode;
  var
    ITRes :TNode;
  begin
    with (ITRes) do
      begin
        sum:=ITLeft.sum+ITRight.sum;
        pre:=Max(ITLeft.pre,ITLeft.sum+ITRight.pre);
        suf:=Max(ITRight.suf,ITRight.sum+ITLeft.suf);
        ans:=Max(ITLeft.suf+ITRight.pre,Max(ITRight.ans,ITLeft.ans));
      end;
    Exit(ITRes);
  end;

  procedure BuildIT(key,left,right :LongInt);
  var
    mid :LongInt;
  begin
    if (left=right) then
      with (IT[key]) do
        begin
          sum:=A[left];
          pre:=A[left];
          suf:=A[left];
          ans:=A[left];
        end
    else
      begin
        mid:=(left+right) div 2;
        BuildIT(key*2,left,mid);
        BuildIT(key*2+1,mid+1,right);
        IT[key]:=CombineIT(IT[key*2],IT[key*2+1]);
      end;
  end;

  function SearchIT(key,left,right :LongInt) :TNode;
  var
    mid :LongInt;
  begin
    if (right<first) or (last<left) then
      begin
        with (SearchIT) do
          begin
            sum:=0;
            pre:=-oo;
            suf:=-oo;
            ans:=-oo;
          end;
      end
    else
      begin
        if (first<=left) and (right<=last) then Exit(IT[key]);
        mid:=(left+right) div 2;
        Exit(CombineIT(SearchIT(key*2,left,mid),
                       SearchIT(key*2+1,mid+1,right)));
      end;
  end;

  procedure SolveIT;
  var
    i :LongInt;
  begin
    Read(m);
    for i:=1 to m do
      begin
        Read(first,last);
        WriteLn(SearchIT(1,1,n).ans);
      end;
  end;

Begin
  Assign(Input,''); Reset(Input);
  Assign(Output,''); Rewrite(Output);
  Enter;
  BuildIT(1,1,n);
  SolveIT;
  Close(Input); Close(Output);
End.