{----------------------------------------------------------------------------}
{                       Written by Nguyen Le Quang Duy                       }
{                   Nguyen Quang Dieu High School, An Giang                  }
{----------------------------------------------------------------------------}

Program NKRACING;
Const
  maxN =10000;
  maxM =100000;
Type
  TEdge =Record
    u,v,c :SmallInt;
  end;
Var
  n :SmallInt;
  m,sum,res :LongInt;
  E :Array[1..maxM] of TEdge;
  Lab :Array[1..maxN] of SmallInt;

  procedure Enter;
  var
    i :LongInt; 
  begin
    Read(n,m); sum:=0;
    for i:=1 to m do
      with (E[i]) do
        begin
          Read(u,v,c); Inc(sum,c);
        end;
  end;

  procedure Init;
  var
    i :SmallInt;
  begin
    for i:=1 to n do Lab[i]:=-1;
  end;

  function GetRoot(x :SmallInt) :SmallInt;
  begin
    while (Lab[x]>0) do x:=Lab[x];
    Exit(x);
  end;

  procedure Union(r1,r2 :SmallInt);
  var
    x :SmallInt;
  begin
    x:=Lab[r1]+Lab[r2];
    if (Lab[r1]>Lab[r2]) then
      begin
        Lab[r1]:=r2; Lab[r2]:=x;
      end
    else
      begin
        Lab[r1]:=x; Lab[r2]:=r1;
      end;
  end;

  procedure DownHeap(root,leaf :LongInt);
  var
    Key :TEdge;
    child :LongInt;
  begin
    Key:=E[root];
    while (root*2<=leaf) do
      begin
        child:=root*2;
        if (child<leaf) and (E[child].c<E[child+1].c) then Inc(child);
        if (Key.c>=E[child].c) then Break;
        E[root]:=E[child];
        root:=child;
      end;
    E[root]:=Key;
  end;

  procedure Greedy;
  var
    Tmp :TEdge;
    r1,r2 :SmallInt;
    i,count :LongInt;
  begin
    for i:=m div 2 downto 1 do DownHeap(i,m);
    count:=0; res:=0;
    for i:=m-1 downto 0 do
      begin
        Tmp:=E[1]; E[1]:=E[i+1]; E[i+1]:=Tmp;
        DownHeap(1,i);
        r1:=GetRoot(E[i+1].u); r2:=GetRoot(E[i+1].v);
        if (r1<>r2) then
          begin
            Inc(count);
            Inc(res,E[i+1].c);
            if (count=n-1) then Break;
            Union(r1,r2);
          end;
      end;
  end;

Begin
  Assign(Input,''); Reset(Input);
  Assign(Output,''); Rewrite(Output);
  Enter;
  Init;
  Greedy;
  Write(sum-res);
  Close(Input); Close(Output);
End.