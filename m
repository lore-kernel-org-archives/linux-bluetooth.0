Return-Path: <bluez-users-admin@lists.sourceforge.net>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C60F8D.41F3CFF3"
Message-ID: <4B7168B4A1DDAE4C97D38B93A8450A188DD203@WEXMBGBWI001001.corp.internal.symbol.com>
From: "Martinez, JuanAntonio" <JuanAntonio.Martinez@symbol.com>
To: <bluez-users@lists.sourceforge.net>
Subject: [Bluez-users] SDP problem w/ WM 5 PDA BT stack
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
Reply-To: bluez-users@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Mon, 2 Jan 2006 11:11:24 -0000

This is a multi-part message in MIME format.

------_=_NextPart_001_01C60F8D.41F3CFF3
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hi=20there,

=20

We=20have=20a=20problem=20when=20trying=20to=20connect=20a=20certain=20WM=20=
5=20PDA=20to=20a=20Linux
box=20(RedHat=209,=20kernel=202.4.20,=20properly=20patched)=20using=20the=20=
ad-hoc=20RPMs.

This=20PDA=20uses=20SS1=20(Stone=20Street=201)=20BT=20stack=20instead=20of=
=20MS's.

Linux=20box=20properly=20initiates=20all=20of=20the=20daemons=20and=20modu=
les,=20then=20SP
(Serial=20Port)=20is=20added=20("sdptool=20add=20SP"),=20since=20PDA=20sho=
uld=20detect=20this
service.

The=20problem=20is=20that=20it=20does=20not.

After=20discovering=20Linux=20BT=20on=20the=20PDA=20and=20then=20requestin=
g=20its=20services,
PDA=20comes=20out=20with=20the=20error=20window:

****************************

SDP=20Query=20Error

Unable=20to=20retrieve=20remote=20services.

A=20connection=20error=20has=20ocurred.

*****************************

The=20application=20uses=20rfcomm=20to=20transfer=20data=20between=20both=20=
devices.=20Linux
side=20"listens"=20(rfcomm=20listen=200)=20to=20the=20PDA.=20This=20connec=
tion=20cannot=20be
done,=20obviously.

=20

Yet,=20using=20MS's=20very=20BT=20stack=20(btd.dll),=20it=20*does=20work*,=
=20on=20another=20PDA
(WM2003).

We=20traced=20(hcidump)=20both=20PDAs:

=20

Non-Working=20one:

=20

HCIDump=20-=20HCI=20packet=20analyzer=20ver=201.9

>=20HCI=20Event:=20Connect=20Request=20(0x04)=20plen=2010

<=20HCI=20Command:=20Accept=20Connection=20Request=20(0x01|0x0009)=20plen=20=
7

>=20HCI=20Event:=20Command=20Status=20(0x0f)=20plen=204

>=20HCI=20Event:=20Connect=20Complete=20(0x03)=20plen=2011

<=20HCI=20Command:=20Write=20Link=20Policy=20Settings=20(0x02|0x000d)=20pl=
en=204

>=20HCI=20Event:=20Page=20Scan=20Repetition=20Mode=20Change=20(0x20)=20ple=
n=207

>=20HCI=20Event:=20Command=20Complete=20(0x0e)=20plen=206

<=20HCI=20Command:=20Change=20Connection=20Packet=20Type=20(0x01|0x000f)=20=
plen=204

>=20ACL=20data:=20handle=200x0029=20flags=200x02=20dlen=2012

=20=20=20=20L2CAP(s):=20Connect=20req:=20psm=201=20scid=200x0040

<=20ACL=20data:=20handle=200x0029=20flags=200x02=20dlen=2016

=20=20=20=20L2CAP(s):=20Connect=20rsp:=20dcid=200x0040=20scid=200x0040=20r=
esult=200=20status=200

>=20HCI=20Event:=20Number=20of=20Completed=20Packets=20(0x13)=20plen=205

>=20HCI=20Event:=20Command=20Status=20(0x0f)=20plen=204

>=20HCI=20Event:=20Connection=20Packet=20Type=20Changed=20(0x1d)=20plen=20=
5

>=20ACL=20data:=20handle=200x0029=20flags=200x02=20dlen=2016

=20=20=20=20L2CAP(s):=20Config=20req:=20dcid=200x0040=20flags=200x0000=20c=
len=204

=20=20=20=20MTU=202048=20

<=20ACL=20data:=20handle=200x0029=20flags=200x02=20dlen=2014

=20=20=20=20L2CAP(s):=20Config=20rsp:=20scid=200x0040=20flags=200x0000=20r=
esult=200=20clen=200

<=20ACL=20data:=20handle=200x0029=20flags=200x02=20dlen=2012

=20=20=20=20L2CAP(s):=20Config=20req:=20dcid=200x0040=20flags=200x0000=20c=
len=200

>=20HCI=20Event:=20Number=20of=20Completed=20Packets=20(0x13)=20plen=205

>=20HCI=20Event:=20Number=20of=20Completed=20Packets=20(0x13)=20plen=205

>=20ACL=20data:=20handle=200x0029=20flags=200x02=20dlen=2014

=20=20=20=20L2CAP(s):=20Config=20rsp:=20scid=200x0040=20flags=200x0000=20r=
esult=200=20clen=200

>=20ACL=20data:=20handle=200x0029=20flags=200x02=20dlen=2036

=20=20=20=20L2CAP(d):=20cid=200x40=20len=2032=20[psm=201]

=20=20=20=20=20=20=20=20SDP=20SSA=20Req:=20tid=200x0=20len=200x1b

=20=20=20=20=20=20=20=20=20=20pat=20uuid-16=200x0100=20(L2CAP)

=20=20=20=20=20=20=20=20=20=20max=200x7e8

=20=20=20=20=20=20=20=20=20=20aid(s)=200x0001=20(SrvClassIDList)=200x0004=20=
(ProtocolDescList)
0x0009=20(BTProfileDescList)=200x000d=20(IconURL)=200x0100=20-=200xffff

=20=20=20=20=20=20=20=20=20=20cont=2000=20

>=20ACL=20data:=20handle=200x0029=20flags=200x02=20dlen=2012

=20=20=20=20L2CAP(s):=20Disconn=20req:=20dcid=200x0040=20scid=200x0040

<=20ACL=20data:=20handle=200x0029=20flags=200x02=20dlen=2012

=20=20=20=20L2CAP(s):=20Disconn=20rsp:=20dcid=200x0040=20scid=200x0040

>=20HCI=20Event:=20Number=20of=20Completed=20Packets=20(0x13)=20plen=205

>=20HCI=20Event:=20Disconn=20Complete=20(0x05)=20plen=204

=20

Working=20one:

=20

HCIDump=20-=20HCI=20packet=20analyzer=20ver=201.9

>=20HCI=20Event:=20Connect=20Request=20(0x04)=20plen=2010

<=20HCI=20Command:=20Accept=20Connection=20Request=20(0x01|0x0009)=20plen=20=
7

>=20HCI=20Event:=20Command=20Status=20(0x0f)=20plen=204

>=20HCI=20Event:=20Connect=20Complete=20(0x03)=20plen=2011

<=20HCI=20Command:=20Write=20Link=20Policy=20Settings=20(0x02|0x000d)=20pl=
en=204

>=20HCI=20Event:=20Page=20Scan=20Repetition=20Mode=20Change=20(0x20)=20ple=
n=207

>=20HCI=20Event:=20Command=20Complete=20(0x0e)=20plen=206

<=20HCI=20Command:=20Change=20Connection=20Packet=20Type=20(0x01|0x000f)=20=
plen=204

>=20HCI=20Event:=20Max=20Slots=20Change=20(0x1b)=20plen=203

>=20HCI=20Event:=20Command=20Status=20(0x0f)=20plen=204

>=20HCI=20Event:=20Connection=20Packet=20Type=20Changed=20(0x1d)=20plen=20=
5

>=20ACL=20data:=20handle=200x0029=20flags=200x02=20dlen=2012

=20=20=20=20L2CAP(s):=20Connect=20req:=20psm=201=20scid=200x0046

<=20ACL=20data:=20handle=200x0029=20flags=200x02=20dlen=2016

=20=20=20=20L2CAP(s):=20Connect=20rsp:=20dcid=200x0040=20scid=200x0046=20r=
esult=200=20status=200

>=20HCI=20Event:=20Number=20of=20Completed=20Packets=20(0x13)=20plen=205

>=20ACL=20data:=20handle=200x0029=20flags=200x02=20dlen=2016

=20=20=20=20L2CAP(s):=20Config=20req:=20dcid=200x0040=20flags=200x0000=20c=
len=204

=20=20=20=20MTU=204096=20

<=20ACL=20data:=20handle=200x0029=20flags=200x02=20dlen=2014

=20=20=20=20L2CAP(s):=20Config=20rsp:=20scid=200x0046=20flags=200x0000=20r=
esult=200=20clen=200

<=20ACL=20data:=20handle=200x0029=20flags=200x02=20dlen=2012

=20=20=20=20L2CAP(s):=20Config=20req:=20dcid=200x0046=20flags=200x0000=20c=
len=200

>=20HCI=20Event:=20Number=20of=20Completed=20Packets=20(0x13)=20plen=205

>=20HCI=20Event:=20Number=20of=20Completed=20Packets=20(0x13)=20plen=205

>=20ACL=20data:=20handle=200x0029=20flags=200x02=20dlen=2014

=20=20=20=20L2CAP(s):=20Config=20rsp:=20scid=200x0040=20flags=200x0000=20r=
esult=200=20clen=200

>=20ACL=20data:=20handle=200x0029=20flags=200x02=20dlen=2017

>=20ACL=20data:=20handle=200x0029=20flags=200x01=20dlen=205

=20=20=20=20L2CAP(d):=20cid=200x40=20len=2018=20[psm=201]

=20=20=20=20=20=20=20=20SDP=20SSA=20Req:=20tid=200x0=20len=200xd

=20=20=20=20=20=20=20=20=20=20pat=20uuid-16=200x1101=20(SP)

=20=20=20=20=20=20=20=20=20=20max=200xff8

=20=20=20=20=20=20=20=20=20=20aid(s)=200x0004=20(ProtocolDescList)

=20=20=20=20=20=20=20=20=20=20cont=2000=20

<=20ACL=20data:=20handle=200x0029=20flags=200x02=20dlen=2033

=20=20=20=20L2CAP(d):=20cid=200x46=20len=2029=20[psm=201]

=20=20=20=20=20=20=20=20SDP=20SSA=20Rsp:=20tid=200x0=20len=200x18

=20=20=20=20=20=20=20=20=20=20cnt=200x15

=20=20=20=20=20=20=20=20=20=20srv=20rec=20#0

=20=20=20=20=20=20=20=20=20=20=20=20aid=200x0004=20(ProtocolDescList)

=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20<=20<=20uuid-16=200x0100=20(L=
2CAP)=20>=20<

=20=20=20=20=20=20=20=20=20=20=20=20=20=20=20uuid-16=200x0003=20(RFCOMM)=20=
uint=200x1=20>=20>

=20

=20=20=20=20=20=20=20=20=20=20cont=2000=20

>=20HCI=20Event:=20Number=20of=20Completed=20Packets=20(0x13)=20plen=205

>=20ACL=20data:=20handle=200x0029=20flags=200x02=20dlen=2012

=20=20=20=20L2CAP(s):=20Disconn=20req:=20dcid=200x0040=20scid=200x0046

<=20ACL=20data:=20handle=200x0029=20flags=200x02=20dlen=2012

=20=20=20=20L2CAP(s):=20Disconn=20rsp:=20dcid=200x0040=20scid=200x0046

>=20HCI=20Event:=20Number=20of=20Completed=20Packets=20(0x13)=20plen=205

>=20HCI=20Event:=20Disconn=20Complete=20(0x05)=20plen=204

=20

Yes,=20MTUs=20are=20different,=20but=20the=20most=20relevant=20difference=20=
is=20that
"working"=20PDA=20only=20requests:=20aid(s)=200x0004=20(ProtocolDescList),=
=20which
*is*=20replied,=20and=20"nonworking"=20one=20requests:=20aid(s)=200x0001
(SrvClassIDList)=200x0004=20(ProtocolDescList)=200x0009=20(BTProfileDescLi=
st)
0x000d=20(IconURL)=200x0100=20-=200xffff,=20which=20*are=20not*=20replied,=
=20and=20hence=20PDA
shows=20the=20error.

=20

How=20can=20we=20configure=20bluez=20so=20it=20responds=20(with=20null=20d=
ata,=20whatsoever)
to=20this=20full=20SDP=20request?

=20

Many=20thanks=20in=20advance

Best=20regards,


________________________________________________________________________
This=20email=20has=20been=20scanned=20for=20computer=20viruses.
------_=_NextPart_001_01C60F8D.41F3CFF3
Content-Type: text/html;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html=20xmlns:o=3D"urn:schemas-microsoft-com:office:office"=20xmlns:w=3D"u=
rn:schemas-microsoft-com:office:word"=20xmlns:st1=3D"urn:schemas-microsoft=
-com:office:smarttags"=20xmlns=3D"http://www.w3.org/TR/REC-html40">

<head>
<META=20HTTP-EQUIV=3D"Content-Type"=20CONTENT=3D"text/html;=20charset=3Dus=
-ascii">
<meta=20name=3DGenerator=20content=3D"Microsoft=20Word=2011=20(filtered=20=
medium)">
<o:SmartTagType=20namespaceuri=3D"urn:schemas-microsoft-com:office:smartta=
gs"
=20name=3D"PlaceType"/>
<o:SmartTagType=20namespaceuri=3D"urn:schemas-microsoft-com:office:smartta=
gs"
=20name=3D"PlaceName"/>
<o:SmartTagType=20namespaceuri=3D"urn:schemas-microsoft-com:office:smartta=
gs"
=20name=3D"place"/>
<!--[if=20!mso]>
<style>
st1\:*{behavior:url(#default#ieooui)=20}
</style>
<![endif]-->
<style>
<!--
=20/*=20Font=20Definitions=20*/
=20@font-face
=09{font-family:SimSun;
=09panose-1:2=201=206=200=203=201=201=201=201=201;}
@font-face
=09{font-family:"\@SimSun";
=09panose-1:2=201=206=200=203=201=201=201=201=201;}
=20/*=20Style=20Definitions=20*/
=20p.MsoNormal,=20li.MsoNormal,=20div.MsoNormal
=09{margin:0in;
=09margin-bottom:.0001pt;
=09font-size:12.0pt;
=09font-family:"Times=20New=20Roman";}
a:link,=20span.MsoHyperlink
=09{color:blue;
=09text-decoration:underline;}
a:visited,=20span.MsoHyperlinkFollowed
=09{color:purple;
=09text-decoration:underline;}
span.EstiloCorreo17
=09{mso-style-type:personal-compose;
=09font-family:Arial;
=09color:windowtext;}
@page=20Section1
=09{size:595.45pt=20841.7pt;
=09margin:1.0in=201.25in=201.0in=201.25in;}
div.Section1
=09{page:Section1;}
-->
</style>

</head>

<body=20lang=3DEN-US=20link=3Dblue=20vlink=3Dpurple>

<div=20class=3DSection1>

<p=20class=3DMsoNormal><font=20size=3D2=20face=3DArial><span=20style=3D'fo=
nt-size:10.0pt;
font-family:Arial'>Hi=20there,<o:p></o:p></span></font></p>

<p=20class=3DMsoNormal><font=20size=3D2=20face=3DArial><span=20style=3D'fo=
nt-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p=20class=3DMsoNormal><font=20size=3D2=20face=3DArial><span=20style=3D'fo=
nt-size:10.0pt;
font-family:Arial'>We=20have=20a=20problem=20when=20trying=20to=20connect=20=
a=20certain=20WM=205=20PDA
to=20a=20Linux=20box=20(RedHat=209,=20kernel=202.4.20,=20properly=20patche=
d)=20using=20the=20ad-hoc
RPMs.<o:p></o:p></span></font></p>

<p=20class=3DMsoNormal><font=20size=3D2=20face=3DArial><span=20style=3D'fo=
nt-size:10.0pt;
font-family:Arial'>This=20PDA=20uses=20SS1=20(Stone=20Street=201)=20BT=20s=
tack=20instead=20of
MS&#8217;s.<o:p></o:p></span></font></p>

<p=20class=3DMsoNormal><font=20size=3D2=20face=3DArial><span=20style=3D'fo=
nt-size:10.0pt;
font-family:Arial'>Linux=20box=20properly=20initiates=20all=20of=20the=20d=
aemons=20and=20modules,
then=20SP=20(<st1:place=20w:st=3D"on"><st1:PlaceName=20w:st=3D"on">Serial<=
/st1:PlaceName>=20<st1:PlaceType
=20w:st=3D"on">Port</st1:PlaceType></st1:place>)=20is=20added=20(&#8220;sd=
ptool=20add
SP&#8221;),=20since=20PDA=20should=20detect=20this=20service.<o:p></o:p></=
span></font></p>

<p=20class=3DMsoNormal><font=20size=3D2=20face=3DArial><span=20style=3D'fo=
nt-size:10.0pt;
font-family:Arial'>The=20problem=20is=20that=20it=20does=20not.<o:p></o:p>=
</span></font></p>

<p=20class=3DMsoNormal><font=20size=3D2=20face=3DArial><span=20style=3D'fo=
nt-size:10.0pt;
font-family:Arial'>After=20discovering=20Linux=20BT=20on=20the=20PDA=20and=
=20then=20requesting
its=20services,=20PDA=20comes=20out=20with=20the=20error=20window:<o:p></o=
:p></span></font></p>

<p=20class=3DMsoNormal><font=20size=3D2=20face=3DArial><span=20style=3D'fo=
nt-size:10.0pt;
font-family:Arial'>****************************<o:p></o:p></span></font></=
p>

<p=20class=3DMsoNormal><font=20size=3D2=20face=3DArial><span=20style=3D'fo=
nt-size:10.0pt;
font-family:Arial'>SDP=20Query=20Error<o:p></o:p></span></font></p>

<p=20class=3DMsoNormal><font=20size=3D2=20face=3DArial><span=20style=3D'fo=
nt-size:10.0pt;
font-family:Arial'>Unable=20to=20retrieve=20remote=20services.<o:p></o:p><=
/span></font></p>

<p=20class=3DMsoNormal><font=20size=3D2=20face=3DArial><span=20style=3D'fo=
nt-size:10.0pt;
font-family:Arial'>A=20connection=20error=20has=20ocurred.<o:p></o:p></spa=
n></font></p>

<p=20class=3DMsoNormal><font=20size=3D2=20face=3DArial><span=20style=3D'fo=
nt-size:10.0pt;
font-family:Arial'>*****************************<o:p></o:p></span></font><=
/p>

<p=20class=3DMsoNormal><font=20size=3D2=20face=3DArial><span=20style=3D'fo=
nt-size:10.0pt;
font-family:Arial'>The=20application=20uses=20rfcomm=20to=20transfer=20dat=
a=20between=20both
devices.=20Linux=20side=20&#8220;listens&#8221;=20(rfcomm=20listen=200)=20=
to=20the=20PDA.=20This
connection=20cannot=20be=20done,=20obviously.<o:p></o:p></span></font></p>=


<p=20class=3DMsoNormal><font=20size=3D2=20face=3DArial><span=20style=3D'fo=
nt-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p=20class=3DMsoNormal><font=20size=3D2=20face=3DArial><span=20style=3D'fo=
nt-size:10.0pt;
font-family:Arial'>Yet,=20using=20MS&#8217;s=20very=20BT=20stack=20(btd.dl=
l),=20it=20*<b><span
style=3D'font-weight:bold'>does=20work</span></b>*,=20on=20another=20PDA=20=
(WM2003).<o:p></o:p></span></font></p>

<p=20class=3DMsoNormal><font=20size=3D2=20face=3DArial><span=20style=3D'fo=
nt-size:10.0pt;
font-family:Arial'>We=20traced=20(hcidump)=20both=20PDAs:<o:p></o:p></span=
></font></p>

<p=20class=3DMsoNormal><font=20size=3D2=20face=3DArial><span=20style=3D'fo=
nt-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p=20class=3DMsoNormal><font=20size=3D2=20face=3DArial><span=20style=3D'fo=
nt-size:10.0pt;
font-family:Arial'>Non-Working=20one:<o:p></o:p></span></font></p>

<p=20class=3DMsoNormal><font=20size=3D2=20face=3DArial><span=20style=3D'fo=
nt-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p=20class=3DMsoNormal><font=20size=3D2=20face=3DArial><span=20style=3D'fo=
nt-size:10.0pt;
font-family:Arial'>HCIDump=20-=20HCI=20packet=20analyzer=20ver=201.9<o:p><=
/o:p></span></font></p>

<p=20class=3DMsoNormal><font=20size=3D2=20face=3DArial><span=20style=3D'fo=
nt-size:10.0pt;
font-family:Arial'>&gt;=20HCI=20Event:=20Connect=20Request=20(0x04)=20plen=
=2010<o:p></o:p></span></font></p>

<p=20class=3DMsoNormal><font=20size=3D2=20face=3DArial><span=20style=3D'fo=
nt-size:10.0pt;
font-family:Arial'>&lt;=20HCI=20Command:=20Accept=20Connection=20Request=20=
(0x01|0x0009)
plen=207<o:p></o:p></span></font></p>

<p=20class=3DMsoNormal><font=20size=3D2=20face=3DArial><span=20style=3D'fo=
nt-size:10.0pt;
font-family:Arial'>&gt;=20HCI=20Event:=20Command=20Status=20(0x0f)=20plen=20=
4<o:p></o:p></span></font></p>

<p=20class=3DMsoNormal><font=20size=3D2=20face=3DArial><span=20style=3D'fo=
nt-size:10.0pt;
font-family:Arial'>&gt;=20HCI=20Event:=20Connect=20Complete=20(0x03)=20ple=
n=2011<o:p></o:p></span></font></p>

<p=20class=3DMsoNormal><font=20size=3D2=20face=3DArial><span=20style=3D'fo=
nt-size:10.0pt;
font-family:Arial'>&lt;=20HCI=20Command:=20Write=20Link=20Policy=20Setting=
s=20(0x02|0x000d)
plen=204<o:p></o:p></span></font></p>

<p=20class=3DMsoNormal><font=20size=3D2=20face=3DArial><span=20style=3D'fo=
nt-size:10.0pt;
font-family:Arial'>&gt;=20HCI=20Event:=20Page=20Scan=20Repetition=20Mode=20=
Change=20(0x20)=20plen
7<o:p></o:p></span></font></p>

<p=20class=3DMsoNormal><font=20size=3D2=20face=3DArial><span=20style=3D'fo=
nt-size:10.0pt;
font-family:Arial'>&gt;=20HCI=20Event:=20Command=20Complete=20(0x0e)=20ple=
n=206<o:p></o:p></span></font></p>

<p=20class=3DMsoNormal><font=20size=3D2=20face=3DArial><span=20style=3D'fo=
nt-size:10.0pt;
font-family:Arial'>&lt;=20HCI=20Command:=20Change=20Connection=20Packet=20=
Type
(0x01|0x000f)=20plen=204<o:p></o:p></span></font></p>

<p=20class=3DMsoNormal><font=20size=3D2=20face=3DArial><span=20style=3D'fo=
nt-size:10.0pt;
font-family:Arial'>&gt;=20ACL=20data:=20handle=200x0029=20flags=200x02=20d=
len=2012<o:p></o:p></span></font></p>

<p=20class=3DMsoNormal><font=20size=3D2=20face=3DArial><span=20style=3D'fo=
nt-size:10.0pt;
font-family:Arial'>&nbsp;&nbsp;&nbsp;=20L2CAP(s):=20Connect=20req:=20psm=20=
1=20scid=200x0040<o:p></o:p></span></font></p>

<p=20class=3DMsoNormal><font=20size=3D2=20face=3DArial><span=20style=3D'fo=
nt-size:10.0pt;
font-family:Arial'>&lt;=20ACL=20data:=20handle=200x0029=20flags=200x02=20d=
len=2016<o:p></o:p></span></font></p>

<p=20class=3DMsoNormal><font=20size=3D2=20face=3DArial><span=20style=3D'fo=
nt-size:10.0pt;
font-family:Arial'>&nbsp;&nbsp;&nbsp;=20L2CAP(s):=20Connect=20rsp:=20dcid=20=
0x0040=20scid
0x0040=20result=200=20status=200<o:p></o:p></span></font></p>

<p=20class=3DMsoNormal><font=20size=3D2=20face=3DArial><span=20style=3D'fo=
nt-size:10.0pt;
font-family:Arial'>&gt;=20HCI=20Event:=20Number=20of=20Completed=20Packets=
=20(0x13)=20plen=205<o:p></o:p></span></font></p>

<p=20class=3DMsoNormal><font=20size=3D2=20face=3DArial><span=20style=3D'fo=
nt-size:10.0pt;
font-family:Arial'>&gt;=20HCI=20Event:=20Command=20Status=20(0x0f)=20plen=20=
4<o:p></o:p></span></font></p>

<p=20class=3DMsoNormal><font=20size=3D2=20face=3DArial><span=20style=3D'fo=
nt-size:10.0pt;
font-family:Arial'>&gt;=20HCI=20Event:=20Connection=20Packet=20Type=20Chan=
ged=20(0x1d)=20plen=205<o:p></o:p></span></font></p>

<p=20class=3DMsoNormal><font=20size=3D2=20face=3DArial><span=20style=3D'fo=
nt-size:10.0pt;
font-family:Arial'>&gt;=20ACL=20data:=20handle=200x0029=20flags=200x02=20d=
len=2016<o:p></o:p></span></font></p>

<p=20class=3DMsoNormal><font=20size=3D2=20face=3DArial><span=20style=3D'fo=
nt-size:10.0pt;
font-family:Arial'>&nbsp;&nbsp;&nbsp;=20L2CAP(s):=20Config=20req:=20dcid=20=
0x0040=20flags
0x0000=20clen=204<o:p></o:p></span></font></p>

<p=20class=3DMsoNormal><font=20size=3D2=20face=3DArial><span=20style=3D'fo=
nt-size:10.0pt;
font-family:Arial'>&nbsp;&nbsp;&nbsp;=20MTU=202048=20<o:p></o:p></span></f=
ont></p>

<p=20class=3DMsoNormal><font=20size=3D2=20face=3DArial><span=20style=3D'fo=
nt-size:10.0pt;
font-family:Arial'>&lt;=20ACL=20data:=20handle=200x0029=20flags=200x02=20d=
len=2014<o:p></o:p></span></font></p>

<p=20class=3DMsoNormal><font=20size=3D2=20face=3DArial><span=20style=3D'fo=
nt-size:10.0pt;
font-family:Arial'>&nbsp;&nbsp;=20&nbsp;L2CAP(s):=20Config=20rsp:=20scid=20=
0x0040=20flags
0x0000=20result=200=20clen=200<o:p></o:p></span></font></p>

<p=20class=3DMsoNormal><font=20size=3D2=20face=3DArial><span=20style=3D'fo=
nt-size:10.0pt;
font-family:Arial'>&lt;=20ACL=20data:=20handle=200x0029=20flags=200x02=20d=
len=2012<o:p></o:p></span></font></p>

<p=20class=3DMsoNormal><font=20size=3D2=20face=3DArial><span=20style=3D'fo=
nt-size:10.0pt;
font-family:Arial'>&nbsp;&nbsp;&nbsp;=20L2CAP(s):=20Config=20req:=20dcid=20=
0x0040=20flags
0x0000=20clen=200<o:p></o:p></span></font></p>

<p=20class=3DMsoNormal><font=20size=3D2=20face=3DArial><span=20style=3D'fo=
nt-size:10.0pt;
font-family:Arial'>&gt;=20HCI=20Event:=20Number=20of=20Completed=20Packets=
=20(0x13)=20plen=205<o:p></o:p></span></font></p>

<p=20class=3DMsoNormal><font=20size=3D2=20face=3DArial><span=20style=3D'fo=
nt-size:10.0pt;
font-family:Arial'>&gt;=20HCI=20Event:=20Number=20of=20Completed=20Packets=
=20(0x13)=20plen=205<o:p></o:p></span></font></p>

<p=20class=3DMsoNormal><font=20size=3D2=20face=3DArial><span=20style=3D'fo=
nt-size:10.0pt;
font-family:Arial'>&gt;=20ACL=20data:=20handle=200x0029=20flags=200x02=20d=
len=2014<o:p></o:p></span></font></p>

<p=20class=3DMsoNormal><font=20size=3D2=20face=3DArial><span=20style=3D'fo=
nt-size:10.0pt;
font-family:Arial'>&nbsp;&nbsp;&nbsp;=20L2CAP(s):=20Config=20rsp:=20scid=20=
0x0040=20flags
0x0000=20result=200=20clen=200<o:p></o:p></span></font></p>

<p=20class=3DMsoNormal><font=20size=3D2=20face=3DArial><span=20style=3D'fo=
nt-size:10.0pt;
font-family:Arial'>&gt;=20ACL=20data:=20handle=200x0029=20flags=200x02=20d=
len=2036<o:p></o:p></span></font></p>

<p=20class=3DMsoNormal><font=20size=3D2=20face=3DArial><span=20style=3D'fo=
nt-size:10.0pt;
font-family:Arial'>&nbsp;&nbsp;&nbsp;=20L2CAP(d):=20cid=200x40=20len=2032=20=
[psm=201]<o:p></o:p></span></font></p>

<p=20class=3DMsoNormal><font=20size=3D2=20face=3DArial><span=20style=3D'fo=
nt-size:10.0pt;
font-family:Arial'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20SDP=20SSA=20=
Req:=20tid
0x0=20len=200x1b<o:p></o:p></span></font></p>

<p=20class=3DMsoNormal><font=20size=3D2=20face=3DArial><span=20style=3D'fo=
nt-size:10.0pt;
font-family:Arial'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20=
pat
uuid-16=200x0100=20(L2CAP)<o:p></o:p></span></font></p>

<p=20class=3DMsoNormal><font=20size=3D2=20face=3DArial><span=20style=3D'fo=
nt-size:10.0pt;
font-family:Arial'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20=
max
0x7e8<o:p></o:p></span></font></p>

<p=20class=3DMsoNormal><font=20size=3D2=20face=3DArial><span=20style=3D'fo=
nt-size:10.0pt;
font-family:Arial'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
aid(s)=200x0001=20(SrvClassIDList)=200x0004=20(ProtocolDescList)=200x0009
(BTProfileDescList)=200x000d=20(IconURL)=200x0100=20-=200xffff<o:p></o:p><=
/span></font></p>

<p=20class=3DMsoNormal><font=20size=3D2=20face=3DArial><span=20style=3D'fo=
nt-size:10.0pt;
font-family:Arial'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20=
cont
00=20<o:p></o:p></span></font></p>

<p=20class=3DMsoNormal><font=20size=3D2=20face=3DArial><span=20style=3D'fo=
nt-size:10.0pt;
font-family:Arial'>&gt;=20ACL=20data:=20handle=200x0029=20flags=200x02=20d=
len=2012<o:p></o:p></span></font></p>

<p=20class=3DMsoNormal><font=20size=3D2=20face=3DArial><span=20style=3D'fo=
nt-size:10.0pt;
font-family:Arial'>&nbsp;&nbsp;&nbsp;=20L2CAP(s):=20Disconn=20req:=20dcid=20=
0x0040=20scid
0x0040<o:p></o:p></span></font></p>

<p=20class=3DMsoNormal><font=20size=3D2=20face=3DArial><span=20style=3D'fo=
nt-size:10.0pt;
font-family:Arial'>&lt;=20ACL=20data:=20handle=200x0029=20flags=200x02=20d=
len=2012<o:p></o:p></span></font></p>

<p=20class=3DMsoNormal><font=20size=3D2=20face=3DArial><span=20style=3D'fo=
nt-size:10.0pt;
font-family:Arial'>&nbsp;&nbsp;&nbsp;=20L2CAP(s):=20Disconn=20rsp:=20dcid=20=
0x0040=20scid
0x0040<o:p></o:p></span></font></p>

<p=20class=3DMsoNormal><font=20size=3D2=20face=3DArial><span=20style=3D'fo=
nt-size:10.0pt;
font-family:Arial'>&gt;=20HCI=20Event:=20Number=20of=20Completed=20Packets=
=20(0x13)=20plen=205<o:p></o:p></span></font></p>

<p=20class=3DMsoNormal><font=20size=3D2=20face=3DArial><span=20style=3D'fo=
nt-size:10.0pt;
font-family:Arial'>&gt;=20HCI=20Event:=20Disconn=20Complete=20(0x05)=20ple=
n=204<o:p></o:p></span></font></p>

<p=20class=3DMsoNormal><font=20size=3D2=20face=3DArial><span=20style=3D'fo=
nt-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p=20class=3DMsoNormal><font=20size=3D2=20face=3DArial><span=20style=3D'fo=
nt-size:10.0pt;
font-family:Arial'>Working=20one:<o:p></o:p></span></font></p>

<p=20class=3DMsoNormal><font=20size=3D2=20face=3DArial><span=20style=3D'fo=
nt-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p=20class=3DMsoNormal><font=20size=3D2=20face=3DArial><span=20style=3D'fo=
nt-size:10.0pt;
font-family:Arial'>HCIDump=20-=20HCI=20packet=20analyzer=20ver=201.9<o:p><=
/o:p></span></font></p>

<p=20class=3DMsoNormal><font=20size=3D2=20face=3DArial><span=20style=3D'fo=
nt-size:10.0pt;
font-family:Arial'>&gt;=20HCI=20Event:=20Connect=20Request=20(0x04)=20plen=
=2010<o:p></o:p></span></font></p>

<p=20class=3DMsoNormal><font=20size=3D2=20face=3DArial><span=20style=3D'fo=
nt-size:10.0pt;
font-family:Arial'>&lt;=20HCI=20Command:=20Accept=20Connection=20Request=20=
(0x01|0x0009)
plen=207<o:p></o:p></span></font></p>

<p=20class=3DMsoNormal><font=20size=3D2=20face=3DArial><span=20style=3D'fo=
nt-size:10.0pt;
font-family:Arial'>&gt;=20HCI=20Event:=20Command=20Status=20(0x0f)=20plen=20=
4<o:p></o:p></span></font></p>

<p=20class=3DMsoNormal><font=20size=3D2=20face=3DArial><span=20style=3D'fo=
nt-size:10.0pt;
font-family:Arial'>&gt;=20HCI=20Event:=20Connect=20Complete=20(0x03)=20ple=
n=2011<o:p></o:p></span></font></p>

<p=20class=3DMsoNormal><font=20size=3D2=20face=3DArial><span=20style=3D'fo=
nt-size:10.0pt;
font-family:Arial'>&lt;=20HCI=20Command:=20Write=20Link=20Policy=20Setting=
s=20(0x02|0x000d)
plen=204<o:p></o:p></span></font></p>

<p=20class=3DMsoNormal><font=20size=3D2=20face=3DArial><span=20style=3D'fo=
nt-size:10.0pt;
font-family:Arial'>&gt;=20HCI=20Event:=20Page=20Scan=20Repetition=20Mode=20=
Change=20(0x20)=20plen
7<o:p></o:p></span></font></p>

<p=20class=3DMsoNormal><font=20size=3D2=20face=3DArial><span=20style=3D'fo=
nt-size:10.0pt;
font-family:Arial'>&gt;=20HCI=20Event:=20Command=20Complete=20(0x0e)=20ple=
n=206<o:p></o:p></span></font></p>

<p=20class=3DMsoNormal><font=20size=3D2=20face=3DArial><span=20style=3D'fo=
nt-size:10.0pt;
font-family:Arial'>&lt;=20HCI=20Command:=20Change=20Connection=20Packet=20=
Type
(0x01|0x000f)=20plen=204<o:p></o:p></span></font></p>

<p=20class=3DMsoNormal><font=20size=3D2=20face=3DArial><span=20style=3D'fo=
nt-size:10.0pt;
font-family:Arial'>&gt;=20HCI=20Event:=20Max=20Slots=20Change=20(0x1b)=20p=
len=203<o:p></o:p></span></font></p>

<p=20class=3DMsoNormal><font=20size=3D2=20face=3DArial><span=20style=3D'fo=
nt-size:10.0pt;
font-family:Arial'>&gt;=20HCI=20Event:=20Command=20Status=20(0x0f)=20plen=20=
4<o:p></o:p></span></font></p>

<p=20class=3DMsoNormal><font=20size=3D2=20face=3DArial><span=20style=3D'fo=
nt-size:10.0pt;
font-family:Arial'>&gt;=20HCI=20Event:=20Connection=20Packet=20Type=20Chan=
ged=20(0x1d)=20plen=205<o:p></o:p></span></font></p>

<p=20class=3DMsoNormal><font=20size=3D2=20face=3DArial><span=20style=3D'fo=
nt-size:10.0pt;
font-family:Arial'>&gt;=20ACL=20data:=20handle=200x0029=20flags=200x02=20d=
len=2012<o:p></o:p></span></font></p>

<p=20class=3DMsoNormal><font=20size=3D2=20face=3DArial><span=20style=3D'fo=
nt-size:10.0pt;
font-family:Arial'>&nbsp;&nbsp;&nbsp;=20L2CAP(s):=20Connect=20req:=20psm=20=
1=20scid=200x0046<o:p></o:p></span></font></p>

<p=20class=3DMsoNormal><font=20size=3D2=20face=3DArial><span=20style=3D'fo=
nt-size:10.0pt;
font-family:Arial'>&lt;=20ACL=20data:=20handle=200x0029=20flags=200x02=20d=
len=2016<o:p></o:p></span></font></p>

<p=20class=3DMsoNormal><font=20size=3D2=20face=3DArial><span=20style=3D'fo=
nt-size:10.0pt;
font-family:Arial'>&nbsp;&nbsp;&nbsp;=20L2CAP(s):=20Connect=20rsp:=20dcid=20=
0x0040=20scid
0x0046=20result=200=20status=200<o:p></o:p></span></font></p>

<p=20class=3DMsoNormal><font=20size=3D2=20face=3DArial><span=20style=3D'fo=
nt-size:10.0pt;
font-family:Arial'>&gt;=20HCI=20Event:=20Number=20of=20Completed=20Packets=
=20(0x13)=20plen=205<o:p></o:p></span></font></p>

<p=20class=3DMsoNormal><font=20size=3D2=20face=3DArial><span=20style=3D'fo=
nt-size:10.0pt;
font-family:Arial'>&gt;=20ACL=20data:=20handle=200x0029=20flags=200x02=20d=
len=2016<o:p></o:p></span></font></p>

<p=20class=3DMsoNormal><font=20size=3D2=20face=3DArial><span=20style=3D'fo=
nt-size:10.0pt;
font-family:Arial'>&nbsp;&nbsp;&nbsp;=20L2CAP(s):=20Config=20req:=20dcid=20=
0x0040=20flags
0x0000=20clen=204<o:p></o:p></span></font></p>

<p=20class=3DMsoNormal><font=20size=3D2=20face=3DArial><span=20style=3D'fo=
nt-size:10.0pt;
font-family:Arial'>&nbsp;&nbsp;&nbsp;=20MTU=204096=20<o:p></o:p></span></f=
ont></p>

<p=20class=3DMsoNormal><font=20size=3D2=20face=3DArial><span=20style=3D'fo=
nt-size:10.0pt;
font-family:Arial'>&lt;=20ACL=20data:=20handle=200x0029=20flags=200x02=20d=
len=2014<o:p></o:p></span></font></p>

<p=20class=3DMsoNormal><font=20size=3D2=20face=3DArial><span=20style=3D'fo=
nt-size:10.0pt;
font-family:Arial'>&nbsp;&nbsp;&nbsp;=20L2CAP(s):=20Config=20rsp:=20scid=20=
0x0046=20flags
0x0000=20result=200=20clen=200<o:p></o:p></span></font></p>

<p=20class=3DMsoNormal><font=20size=3D2=20face=3DArial><span=20style=3D'fo=
nt-size:10.0pt;
font-family:Arial'>&lt;=20ACL=20data:=20handle=200x0029=20flags=200x02=20d=
len=2012<o:p></o:p></span></font></p>

<p=20class=3DMsoNormal><font=20size=3D2=20face=3DArial><span=20style=3D'fo=
nt-size:10.0pt;
font-family:Arial'>&nbsp;&nbsp;&nbsp;=20L2CAP(s):=20Config=20req:=20dcid=20=
0x0046=20flags
0x0000=20clen=200<o:p></o:p></span></font></p>

<p=20class=3DMsoNormal><font=20size=3D2=20face=3DArial><span=20style=3D'fo=
nt-size:10.0pt;
font-family:Arial'>&gt;=20HCI=20Event:=20Number=20of=20Completed=20Packets=
=20(0x13)=20plen=205<o:p></o:p></span></font></p>

<p=20class=3DMsoNormal><font=20size=3D2=20face=3DArial><span=20style=3D'fo=
nt-size:10.0pt;
font-family:Arial'>&gt;=20HCI=20Event:=20Number=20of=20Completed=20Packets=
=20(0x13)=20plen=205<o:p></o:p></span></font></p>

<p=20class=3DMsoNormal><font=20size=3D2=20face=3DArial><span=20style=3D'fo=
nt-size:10.0pt;
font-family:Arial'>&gt;=20ACL=20data:=20handle=200x0029=20flags=200x02=20d=
len=2014<o:p></o:p></span></font></p>

<p=20class=3DMsoNormal><font=20size=3D2=20face=3DArial><span=20style=3D'fo=
nt-size:10.0pt;
font-family:Arial'>&nbsp;&nbsp;&nbsp;=20L2CAP(s):=20Config=20rsp:=20scid=20=
0x0040=20flags
0x0000=20result=200=20clen=200<o:p></o:p></span></font></p>

<p=20class=3DMsoNormal><font=20size=3D2=20face=3DArial><span=20style=3D'fo=
nt-size:10.0pt;
font-family:Arial'>&gt;=20ACL=20data:=20handle=200x0029=20flags=200x02=20d=
len=2017<o:p></o:p></span></font></p>

<p=20class=3DMsoNormal><font=20size=3D2=20face=3DArial><span=20style=3D'fo=
nt-size:10.0pt;
font-family:Arial'>&gt;=20ACL=20data:=20handle=200x0029=20flags=200x01=20d=
len=205<o:p></o:p></span></font></p>

<p=20class=3DMsoNormal><font=20size=3D2=20face=3DArial><span=20style=3D'fo=
nt-size:10.0pt;
font-family:Arial'>&nbsp;&nbsp;&nbsp;=20L2CAP(d):=20cid=200x40=20len=2018=20=
[psm=201]<o:p></o:p></span></font></p>

<p=20class=3DMsoNormal><font=20size=3D2=20face=3DArial><span=20style=3D'fo=
nt-size:10.0pt;
font-family:Arial'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20SDP=20SSA=20=
Req:=20tid
0x0=20len=200xd<o:p></o:p></span></font></p>

<p=20class=3DMsoNormal><font=20size=3D2=20face=3DArial><span=20style=3D'fo=
nt-size:10.0pt;
font-family:Arial'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20=
pat
uuid-16=200x1101=20(SP)<o:p></o:p></span></font></p>

<p=20class=3DMsoNormal><font=20size=3D2=20face=3DArial><span=20style=3D'fo=
nt-size:10.0pt;
font-family:Arial'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20=
max
0xff8<o:p></o:p></span></font></p>

<p=20class=3DMsoNormal><font=20size=3D2=20face=3DArial><span=20style=3D'fo=
nt-size:10.0pt;
font-family:Arial'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
aid(s)=200x0004=20(ProtocolDescList)<o:p></o:p></span></font></p>

<p=20class=3DMsoNormal><font=20size=3D2=20face=3DArial><span=20style=3D'fo=
nt-size:10.0pt;
font-family:Arial'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20=
cont
00=20<o:p></o:p></span></font></p>

<p=20class=3DMsoNormal><font=20size=3D2=20face=3DArial><span=20style=3D'fo=
nt-size:10.0pt;
font-family:Arial'>&lt;=20ACL=20data:=20handle=200x0029=20flags=200x02=20d=
len=2033<o:p></o:p></span></font></p>

<p=20class=3DMsoNormal><font=20size=3D2=20face=3DArial><span=20style=3D'fo=
nt-size:10.0pt;
font-family:Arial'>&nbsp;&nbsp;&nbsp;=20L2CAP(d):=20cid=200x46=20len=2029=20=
[psm=201]<o:p></o:p></span></font></p>

<p=20class=3DMsoNormal><font=20size=3D2=20face=3DArial><span=20style=3D'fo=
nt-size:10.0pt;
font-family:Arial'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20SDP=20SSA=20=
Rsp:=20tid
0x0=20len=200x18<o:p></o:p></span></font></p>

<p=20class=3DMsoNormal><font=20size=3D2=20face=3DArial><span=20style=3D'fo=
nt-size:10.0pt;
font-family:Arial'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20=
cnt
0x15<o:p></o:p></span></font></p>

<p=20class=3DMsoNormal><font=20size=3D2=20face=3DArial><span=20style=3D'fo=
nt-size:10.0pt;
font-family:Arial'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20=
srv
rec=20#0<o:p></o:p></span></font></p>

<p=20class=3DMsoNormal><font=20size=3D2=20face=3DArial><span=20style=3D'fo=
nt-size:10.0pt;
font-family:Arial'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;
aid=200x0004=20(ProtocolDescList)<o:p></o:p></span></font></p>

<p=20class=3DMsoNormal><font=20size=3D2=20face=3DArial><span=20style=3D'fo=
nt-size:10.0pt;
font-family:Arial'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
&lt;=20&lt;=20uuid-16=200x0100=20(L2CAP)=20&gt;=20&lt;<o:p></o:p></span></=
font></p>

<p=20class=3DMsoNormal><font=20size=3D2=20face=3DArial><span=20style=3D'fo=
nt-size:10.0pt;
font-family:Arial'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
uuid-16=200x0003=20(RFCOMM)=20uint=200x1=20&gt;=20&gt;<o:p></o:p></span></=
font></p>

<p=20class=3DMsoNormal><font=20size=3D2=20face=3DArial><span=20style=3D'fo=
nt-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p=20class=3DMsoNormal><font=20size=3D2=20face=3DArial><span=20style=3D'fo=
nt-size:10.0pt;
font-family:Arial'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20=
cont
00=20<o:p></o:p></span></font></p>

<p=20class=3DMsoNormal><font=20size=3D2=20face=3DArial><span=20style=3D'fo=
nt-size:10.0pt;
font-family:Arial'>&gt;=20HCI=20Event:=20Number=20of=20Completed=20Packets=
=20(0x13)=20plen=205<o:p></o:p></span></font></p>

<p=20class=3DMsoNormal><font=20size=3D2=20face=3DArial><span=20style=3D'fo=
nt-size:10.0pt;
font-family:Arial'>&gt;=20ACL=20data:=20handle=200x0029=20flags=200x02=20d=
len=2012<o:p></o:p></span></font></p>

<p=20class=3DMsoNormal><font=20size=3D2=20face=3DArial><span=20style=3D'fo=
nt-size:10.0pt;
font-family:Arial'>&nbsp;&nbsp;&nbsp;=20L2CAP(s):=20Disconn=20req:=20dcid=20=
0x0040=20scid
0x0046<o:p></o:p></span></font></p>

<p=20class=3DMsoNormal><font=20size=3D2=20face=3DArial><span=20style=3D'fo=
nt-size:10.0pt;
font-family:Arial'>&lt;=20ACL=20data:=20handle=200x0029=20flags=200x02=20d=
len=2012<o:p></o:p></span></font></p>

<p=20class=3DMsoNormal><font=20size=3D2=20face=3DArial><span=20style=3D'fo=
nt-size:10.0pt;
font-family:Arial'>&nbsp;&nbsp;&nbsp;=20L2CAP(s):=20Disconn=20rsp:=20dcid=20=
0x0040=20scid
0x0046<o:p></o:p></span></font></p>

<p=20class=3DMsoNormal><font=20size=3D2=20face=3DArial><span=20style=3D'fo=
nt-size:10.0pt;
font-family:Arial'>&gt;=20HCI=20Event:=20Number=20of=20Completed=20Packets=
=20(0x13)=20plen=205<o:p></o:p></span></font></p>

<p=20class=3DMsoNormal><font=20size=3D2=20face=3DArial><span=20style=3D'fo=
nt-size:10.0pt;
font-family:Arial'>&gt;=20HCI=20Event:=20Disconn=20Complete=20(0x05)=20ple=
n=204<o:p></o:p></span></font></p>

<p=20class=3DMsoNormal><font=20size=3D2=20face=3DArial><span=20style=3D'fo=
nt-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p=20class=3DMsoNormal><font=20size=3D2=20face=3DArial><span=20style=3D'fo=
nt-size:10.0pt;
font-family:Arial'>Yes,=20MTUs=20are=20different,=20but=20the=20most=20rel=
evant=20difference=20is
that=20&#8220;working&#8221;=20PDA=20only=20requests:=20aid(s)=200x0004=20=
(ProtocolDescList),
which=20*<b><span=20style=3D'font-weight:bold'>is</span></b>*=20replied,=20=
and
&#8220;nonworking&#8221;=20one=20requests:=20aid(s)=200x0001=20(SrvClassID=
List)=200x0004
(ProtocolDescList)=200x0009=20(BTProfileDescList)=200x000d=20(IconURL)=200=
x0100=20-=200xffff,
which=20*<b><span=20style=3D'font-weight:bold'>are=20not</span></b>*=20rep=
lied,=20and=20hence
PDA=20shows=20the=20error.<o:p></o:p></span></font></p>

<p=20class=3DMsoNormal><font=20size=3D2=20face=3DArial><span=20style=3D'fo=
nt-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p=20class=3DMsoNormal><font=20size=3D2=20face=3DArial><span=20style=3D'fo=
nt-size:10.0pt;
font-family:Arial'>How=20can=20we=20configure=20bluez=20so=20it=20responds=
=20(with=20null=20data,
whatsoever)=20to=20this=20full=20SDP=20request?<o:p></o:p></span></font></=
p>

<p=20class=3DMsoNormal><font=20size=3D2=20face=3DArial><span=20style=3D'fo=
nt-size:10.0pt;
font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p=20class=3DMsoNormal><font=20size=3D2=20face=3DArial><span=20style=3D'fo=
nt-size:10.0pt;
font-family:Arial'>Many=20thanks=20in=20advance<o:p></o:p></span></font></=
p>

<p=20class=3DMsoNormal><font=20size=3D2=20face=3DArial><span=20style=3D'fo=
nt-size:10.0pt;
font-family:Arial'>Best=20regards,<o:p></o:p></span></font></p>

</div>


<BR>
________________________________________________________________________<B=
R>
This=20email=20has=20been=20scanned=20for=20computer=20viruses.<BR>
</body>

</html>

------_=_NextPart_001_01C60F8D.41F3CFF3--


-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
