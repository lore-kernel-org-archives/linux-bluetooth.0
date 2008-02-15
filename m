Return-Path: <cyrus@holtmann.org>
Date: Fri, 15 Feb 2008 19:51:16 +0530 (IST)
From: pramod gurav <pramod_gurav_etc@yahoo.co.in>
To: BlueZ users <bluez-users@lists.sourceforge.net>
MIME-Version: 1.0
Message-ID: <961486.61640.qm@web8409.mail.in.yahoo.com>
Subject: Re: [Bluez-users] Headset not playing audio HELP PLEASE
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============1989320721=="
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

--===============1989320721==
Content-Type: multipart/alternative; boundary="0-467814118-1203085276=:61640"

--0-467814118-1203085276=:61640
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

hi =0AYour replies boost me to work hard on it...Thanks for that.=0AI just =
tried changing some lines in /usr/src/linux/net/bluetooth/hci_event.c=0Aand=
 compiled the kernel..=0ANow when I do hciconfig=0A[root@localhost Pramod]#=
 /usr/local/sbin/hciconfig -a=0Ahci0:   Type: USB=0A        BD Address: 00:=
02:72:CE:5B:80 ACL MTU: 1017:8 SCO MTU: 64:8=0A        UP RUNNING PSCAN ISC=
AN=0A        RX bytes:668 acl:0 sco:0 events:21 errors:0=0A        TX bytes=
:340 acl:0 sco:0 commands:21 errors:0=0A        Features: 0xff 0xff 0x8d 0x=
fe 0x9b 0xf9 0x00 0x80=0A        Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 H=
V2 HV3=0A        Link policy: RSWITCH HOLD SNIFF PARK=0A        Link mode: =
SLAVE ACCEPT=0A        Name: 'BlueZ (0)'=0A        Class: 0x080100=0A      =
  Service Classes: Capturing=0A        Device Class: Computer, Uncategorize=
d=0A        HCI Ver: 2.0 (0x3) HCI Rev: 0x204d LMP Ver: 2.0 (0x3) LMP Subve=
r: 0x4127=0A        Manufacturer: Broadcom Corporation (15)=0A=0ASCO MTU: 6=
4:8 this has changed =0Abut new problem is hwen I press button on HS link r=
eq comes but the connection is different this time=0A[root@localhost Pramod=
]# hcitool conn=0AConnections:=0A        > ACL 00:0F:DE:B1:02:42 handle 0 s=
tate 2 lm SLAVE=0Apreviously it used to be as=0A->  =0A  =0A  =0A  =0A =0A>=
 =0AACL =0A00:0F:DE:B1:02:42 =0Ahandle =0A11 =0Astate =0A1 =0Alm =0ASLAVE =
=0AAUTH =0AENCRYPT =0ASECURE=0A=0Aand when I play=0A[Pramod@localhost ~]$ a=
play -D bluetooth -f S16_LE test.raw=0Athere is a long wait and connections=
 are=0A[root@localhost Pramod]# hcitool conn=0AConnections:=0A        > ACL=
 00:0F:DE:B1:02:43 handle 0 state 2 lm SLAVE  =0A        < ACL 00:0F:DE:B1:=
02:42 handle 0 state 5 lm MASTER=0A=0A 00:0F:DE:B1:02:43 this is not my HS =
address(there is no other device near here)=0A00:0F:DE:B1:02:42 this one is=
 mine.=0A=0Aand no SCO connection at all..=0Aplanning to recompile the kern=
el with original hci_event.c=0AAs you asked for "lsusb -v " let me inform y=
ou I done have lsusb command.=0AI can give this info=0A[root@localhost Pram=
od]# cat /proc/bus/usb/devices=0AT:  Bus=3D02 Lev=3D01 Prnt=3D01 Port=3D00 =
Cnt=3D01 Dev#=3D  7 Spd=3D12  MxCh=3D 0=0AD:  Ver=3D 2.00 Cls=3De0(unk. ) S=
ub=3D01 Prot=3D01 MxPS=3D64 #Cfgs=3D  1=0AP:  Vendor=3D0a5c ProdID=3D2101 R=
ev=3D 0.00=0AS:  Manufacturer=3DBroadcom Corp=0AS:  Product=3DBCM92045DG-Fl=
ash=0AC:* #Ifs=3D 4 Cfg#=3D 1 Atr=3Da0 MxPwr=3D100mA=0AI:  If#=3D 0 Alt=3D =
0 #EPs=3D 3 Cls=3De0(unk. ) Sub=3D01 Prot=3D01 Driver=3Dhci_usb=0AE:  Ad=3D=
81(I) Atr=3D03(Int.) MxPS=3D  16 Ivl=3D1ms=0AE:  Ad=3D82(I) Atr=3D02(Bulk) =
MxPS=3D  64 Ivl=3D0ms=0AE:  Ad=3D02(O) Atr=3D02(Bulk) MxPS=3D  64 Ivl=3D0ms=
=0AI:  If#=3D 1 Alt=3D 0 #EPs=3D 2 Cls=3De0(unk. ) Sub=3D01 Prot=3D01 Drive=
r=3Dhci_usb=0AE:  Ad=3D83(I) Atr=3D01(Isoc) MxPS=3D   0 Ivl=3D1ms=0AE:  Ad=
=3D03(O) Atr=3D01(Isoc) MxPS=3D   0 Ivl=3D1ms=0AI:  If#=3D 1 Alt=3D 1 #EPs=
=3D 2 Cls=3De0(unk. ) Sub=3D01 Prot=3D01 Driver=3Dhci_usb=0AE:  Ad=3D83(I) =
Atr=3D01(Isoc) MxPS=3D   9 Ivl=3D1ms=0AE:  Ad=3D03(O) Atr=3D01(Isoc) MxPS=
=3D   9 Ivl=3D1ms=0AI:  If#=3D 1 Alt=3D 2 #EPs=3D 2 Cls=3De0(unk. ) Sub=3D0=
1 Prot=3D01 Driver=3Dhci_usb=0AE:  Ad=3D83(I) Atr=3D01(Isoc) MxPS=3D  17 Iv=
l=3D1ms=0AE:  Ad=3D03(O) Atr=3D01(Isoc) MxPS=3D  17 Ivl=3D1ms=0AI:  If#=3D =
1 Alt=3D 3 #EPs=3D 2 Cls=3De0(unk. ) Sub=3D01 Prot=3D01 Driver=3Dhci_usb=0A=
E:  Ad=3D83(I) Atr=3D01(Isoc) MxPS=3D  25 Ivl=3D1ms=0AE:  Ad=3D03(O) Atr=3D=
01(Isoc) MxPS=3D  25 Ivl=3D1ms=0AI:  If#=3D 1 Alt=3D 4 #EPs=3D 2 Cls=3De0(u=
nk. ) Sub=3D01 Prot=3D01 Driver=3Dhci_usb=0AE:  Ad=3D83(I) Atr=3D01(Isoc) M=
xPS=3D  33 Ivl=3D1ms=0AE:  Ad=3D03(O) Atr=3D01(Isoc) MxPS=3D  33 Ivl=3D1ms=
=0AI:  If#=3D 1 Alt=3D 5 #EPs=3D 2 Cls=3De0(unk. ) Sub=3D01 Prot=3D01 Drive=
r=3Dhci_usb=0AE:  Ad=3D83(I) Atr=3D01(Isoc) MxPS=3D  49 Ivl=3D1ms=0AE:  Ad=
=3D03(O) Atr=3D01(Isoc) MxPS=3D  49 Ivl=3D1ms=0AI:  If#=3D 2 Alt=3D 0 #EPs=
=3D 2 Cls=3Dff(vend.) Sub=3Dff Prot=3Dff Driver=3D(none)=0AE:  Ad=3D84(I) A=
tr=3D02(Bulk) MxPS=3D  32 Ivl=3D0ms=0AE:  Ad=3D04(O) Atr=3D02(Bulk) MxPS=3D=
  32 Ivl=3D0ms=0AI:  If#=3D 3 Alt=3D 0 #EPs=3D 0 Cls=3Dfe(app. ) Sub=3D01 P=
rot=3D00 Driver=3D(none)=0A=0AAs you said there might be a incompatibility =
issues in one of them(HS/dongle)=0ACan it happen that I might require to pl=
ay the audio with certain frequency, rate or parameters which are supported=
 by my HS(Its a Sony Ericsson HBH-602)?=0AThanks once again for your share =
of time.=0Ahave a nice time ahead.=0A=0AThanks and Best regards =0APramod=
=0A=0A----- Original Message ----=0AFrom: jayjwa <jayjwa@atr2.ath.cx>=0ATo:=
 BlueZ users <bluez-users@lists.sourceforge.net>=0ASent: Friday, 15 Februar=
y, 2008 6:59:34 PM=0ASubject: Re: [Bluez-users] Headset not playing audio H=
ELP PLEASE=0A=0A=0AOn =0AFri, =0A15 =0AFeb =0A2008, =0Apramod =0Agurav =0Aw=
rote:=0A=0A-> =0Awill =0Ayou =0Aplease =0Asend =0Ame =0Athe =0Aconf =0Afile=
s =0ASo =0Athat =0AI =0Acan =0Arectify =0Amines.=0A=0AYour =0Aconfigs =0Alo=
ok =0AOK, =0Abut =0Aif =0Ayou =0Awant =0Athem:=0A=0Awget =0A--no-check-cert=
ificate =0Ahttps://atr2.ath.cx/~jayjwa/download/bt-configs.zip=0Aor=0Acurl =
=0A-O =0A-v =0A-k =0Ahttps://atr2.ath.cx/~jayjwa/download/bt-configs.zip=0A=
=0A=0A-> =0AAlso =0AI =0Awant =0Ato =0Atell =0Ayou =0Athat =0AI =0Ahave =0A=
installed =0Abt-sco =0Abut =0Alater =0Aon =0AI =0Aread =0Asomewhere =0Athat=
 =0Athis =0Ais =0Aolder =0Amethod =0Ato =0Ado. =0AIs =0Ait =0Awrite?=0A-> =
=0ASo =0AI =0Astoped =0Athere. =0ACan =0AI =0Atry =0Abtsco =0Away?=0A-> =0A=
But =0Ai =0Adont =0Ahave =0Amodule =0Asnd_bt_sco.=0A-> =0Aplease =0Aenlight=
en =0Ame =0Aon =0Abtsco =0A.=0A=0AIt's =0Aold =0Aand =0Aprobably =0Aobsolet=
e. =0AIt =0Amight =0Anot =0Aeven =0Abe =0Apossible =0Ato =0Ause =0Ait =0Awi=
thout =0Ainstalling =0Aold =0Abluez =0Alibs/utilz =0Aand =0Aan =0Aold =0A(p=
ossibly =0Ainsecure) =0Akernel. =0AEven =0Adoing =0Aall =0Athat =0Awork, =
=0Athere's =0Ano =0Agarentee =0Athat =0Ait =0Awill =0Awork =0Aany =0Abetter=
. =0AYou =0Amight =0Astill =0Ahit =0Athe =0Asame =0Aissue. =0AI'd =0Astay =
=0Acurrent, =0Aand =0Amake =0Asure =0Ato =0Asee =0Athe =0Alink =0Ain =0Amy =
=0Alast-to-this =0Apost =0Aabout =0Asco =0Amtu.=0A=0AThere's =0Aonly =0Aso =
=0Amany =0Aconfiguration =0Aoptions =0Ayou =0Acan =0Atry, =0Aand =0Aby =0An=
ow =0Ayou've =0Atried =0Ajust =0Aabout =0Aall =0Aof =0Athem. =0AAt =0Athis =
=0Apoint, =0Ayou =0Amay =0Abe =0Alooking =0Aat =0Aan =0Aincompatibility =0A=
in =0Aone =0Aor =0Aboth =0Aof =0Ayour =0Ahardware =0Acomponents, =0Aor =0Aa=
 =0Abug =0Ain =0Aeither/both. =0AThat's =0Awhy =0Ait =0Awould =0Abe =0Ahelp=
ful =0Aif =0Ayou =0Acould =0Atry =0Aother =0Ahardware, =0Aor =0Atry =0Ato =
=0Afind =0Aaccounts =0Aof =0Asomeone =0Agetting =0Aa =0Aworking =0Aexample =
=0Ausing =0Ayour =0Ahardware =0Aon =0Aa =0Asimilar =0Asetup. =0AThen =0Ayou=
 =0Acould =0Asay =0Aeither =0Away =0Aif =0Ait's =0Areally =0Aa =0Ahardware =
=0Aissue =0Aor =0Anot. =0ACould =0Abe =0Athat =0Ait's =0Anot, =0Abut =0Ain =
=0Asearching =0Afor =0Athe =0Acause =0Aof =0Aan =0Aerror/reason =0Asomethin=
g's =0Anot =0Aworking, =0Ait's =0Aone =0Aof =0Athe =0Athings =0Ayou =0Ahave=
 =0Ato =0Aconsider. =0ABecause =0Aif =0Ait =0Ais =0Athe =0Acase, =0Athen =
=0Ano =0Aamount =0Aof =0Aconfig =0Achanges =0Aor =0Aupdates =0Awill =0Ahelp=
.=0A=0ABy =0Awhat =0Ayou've =0Aposted, =0Ait =0Alooks =0Acorrect =0Aand =0A=
should =0Abe =0Aworking, =0Aonly =0Ait =0Aisn't. =0AThe =0Afact =0Asound =
=0Adoes =0Awork =0Aone =0Away =0Aand =0Anot =0Athe =0Aother =0Ais =0Avery =
=0Aodd =0Atoo. =0AIf =0Ait =0Awas =0Aa =0Aconfig =0Aerror, =0Aseems =0Alike=
 =0Aneither =0Awould =0Awork.=0A=0A=0A=0A=0A-------------------------------=
------------------------------------------=0AThis =0ASF.net =0Aemail =0Ais =
=0Asponsored =0Aby: =0AMicrosoft=0ADefy =0Aall =0Achallenges. =0AMicrosoft(=
R) =0AVisual =0AStudio =0A2008.=0Ahttp://clk.atdmt.com/MRT/go/vse0120000070=
mrt/direct/01/=0A_______________________________________________=0ABluez-us=
ers =0Amailing =0Alist=0ABluez-users@lists.sourceforge.net=0Ahttps://lists.=
sourceforge.net/lists/listinfo/bluez-users=0A=0A=0A=0A=0A=0A=0A=0A      Dow=
nload prohibited? No problem. CHAT from any browser, without download. Go t=
o http://in.messenger.yahoo.com/webmessengerpromo.php/
--0-467814118-1203085276=:61640
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: quoted-printable

<html><head><style type=3D"text/css"><!-- DIV {margin:0px;} --></style></he=
ad><body><div style=3D"font-family:times new roman, new york, times, serif;=
font-size:12pt">hi <br>Your replies boost me to work hard on it...Thanks fo=
r that.<br>I just tried changing some lines in /usr/src/linux/net/bluetooth=
/hci_event.c<br>and compiled the kernel..<br>Now when I do hciconfig<br>[ro=
ot@localhost Pramod]# /usr/local/sbin/hciconfig -a<br>hci0:&nbsp;&nbsp; Typ=
e: USB<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; BD Address: 00:02:72:C=
E:5B:80 ACL MTU: 1017:8<span style=3D"font-weight: bold; font-style: italic=
; text-decoration: underline;"> SCO MTU: 64:8</span><br>&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; UP RUNNING PSCAN ISCAN<br>&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp; RX bytes:668 acl:0 sco:0 events:21 errors:0<br>&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; TX bytes:340 acl:0 sco:0 commands:21 error=
s:0<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Features: 0xff 0xff 0x8d
 0xfe 0x9b 0xf9 0x00 0x80<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Pac=
ket type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3<br>&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; Link policy: RSWITCH HOLD SNIFF PARK<br>&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; Link mode: SLAVE ACCEPT<br>&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; Name: 'BlueZ (0)'<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp; Class: 0x080100<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Serv=
ice Classes: Capturing<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Device=
 Class: Computer, Uncategorized<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p; HCI Ver: 2.0 (0x3) HCI Rev: 0x204d LMP Ver: 2.0 (0x3) LMP Subver: 0x4127=
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Manufacturer: Broadcom Corpo=
ration (15)<br><br><span style=3D"font-weight: bold; font-style: italic; te=
xt-decoration: underline;">SCO MTU: 64:8 this has changed </span><br>but ne=
w problem is hwen I press button on HS link req comes but the
 connection is different this time<br>[root@localhost Pramod]# hcitool conn=
<br>Connections:<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &gt; ACL 00:=
0F:DE:B1:02:42 handle 0 state 2 lm SLAVE<br>previously it used to be as<br>=
-&gt;&nbsp; =0A&nbsp; =0A&nbsp; =0A&nbsp; =0A =0A&gt; =0AACL =0A00:0F:DE:B1=
:02:42 =0Ahandle =0A11 =0Astate =0A1 =0Alm =0ASLAVE =0AAUTH =0AENCRYPT =0AS=
ECURE<br><br>and when I play<br>[Pramod@localhost ~]$ aplay -D bluetooth -f=
 S16_LE test.raw<br>there is a long wait and connections are<br>[root@local=
host Pramod]# hcitool conn<br>Connections:<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;<span style=3D"font-style: italic; text-decoration: underline;=
"> &gt; ACL 00:0F:DE:B1:02:43</span> handle 0 state 2 lm SLAVE&nbsp; <br>&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &lt; ACL 00:0F:DE:B1:02:42 handle =
0 state 5 lm MASTER<br><br><div><span style=3D"font-style: italic;">&nbsp;0=
0:0F:DE:B1:02:43 this is not my HS address(there is no other device near he=
re)</span><br>00:0F:DE:B1:02:42 this one is mine.<br><br>and no SCO connect=
ion at all..<br>planning to recompile the kernel with original hci_event.c<=
br>As you asked for "lsusb -v " let me inform you I done have lsusb command=
.<br>I can give this info<br>[root@localhost Pramod]# cat /proc/bus/usb/dev=
ices<br>T:&nbsp; Bus=3D02 Lev=3D01 Prnt=3D01 Port=3D00 Cnt=3D01 Dev#=3D&nbs=
p; 7
 Spd=3D12&nbsp; MxCh=3D 0<br>D:&nbsp; Ver=3D 2.00 Cls=3De0(unk. ) Sub=3D01 =
Prot=3D01 MxPS=3D64 #Cfgs=3D&nbsp; 1<br>P:&nbsp; Vendor=3D0a5c ProdID=3D210=
1 Rev=3D 0.00<br>S:&nbsp; Manufacturer=3DBroadcom Corp<br>S:&nbsp; Product=
=3DBCM92045DG-Flash<br>C:* #Ifs=3D 4 Cfg#=3D 1 Atr=3Da0 MxPwr=3D100mA<br>I:=
&nbsp; If#=3D 0 Alt=3D 0 #EPs=3D 3 Cls=3De0(unk. ) Sub=3D01 Prot=3D01 Drive=
r=3Dhci_usb<br>E:&nbsp; Ad=3D81(I) Atr=3D03(Int.) MxPS=3D&nbsp; 16 Ivl=3D1m=
s<br>E:&nbsp; Ad=3D82(I) Atr=3D02(Bulk) MxPS=3D&nbsp; 64 Ivl=3D0ms<br>E:&nb=
sp; Ad=3D02(O) Atr=3D02(Bulk) MxPS=3D&nbsp; 64 Ivl=3D0ms<br>I:&nbsp; If#=3D=
 1 Alt=3D 0 #EPs=3D 2 Cls=3De0(unk. ) Sub=3D01 Prot=3D01 Driver=3Dhci_usb<b=
r>E:&nbsp; Ad=3D83(I) Atr=3D01(Isoc) MxPS=3D&nbsp;&nbsp; 0 Ivl=3D1ms<br>E:&=
nbsp; Ad=3D03(O) Atr=3D01(Isoc) MxPS=3D&nbsp;&nbsp; 0 Ivl=3D1ms<br>I:&nbsp;=
 If#=3D 1 Alt=3D 1 #EPs=3D 2 Cls=3De0(unk. ) Sub=3D01 Prot=3D01 Driver=3Dhc=
i_usb<br>E:&nbsp; Ad=3D83(I) Atr=3D01(Isoc) MxPS=3D&nbsp;&nbsp; 9 Ivl=3D1ms=
<br>E:&nbsp; Ad=3D03(O) Atr=3D01(Isoc) MxPS=3D&nbsp;&nbsp; 9 Ivl=3D1ms<br>I=
:&nbsp; If#=3D 1 Alt=3D 2 #EPs=3D 2 Cls=3De0(unk. ) Sub=3D01
 Prot=3D01 Driver=3Dhci_usb<br>E:&nbsp; Ad=3D83(I) Atr=3D01(Isoc) MxPS=3D&n=
bsp; 17 Ivl=3D1ms<br>E:&nbsp; Ad=3D03(O) Atr=3D01(Isoc) MxPS=3D&nbsp; 17 Iv=
l=3D1ms<br>I:&nbsp; If#=3D 1 Alt=3D 3 #EPs=3D 2 Cls=3De0(unk. ) Sub=3D01 Pr=
ot=3D01 Driver=3Dhci_usb<br>E:&nbsp; Ad=3D83(I) Atr=3D01(Isoc) MxPS=3D&nbsp=
; 25 Ivl=3D1ms<br>E:&nbsp; Ad=3D03(O) Atr=3D01(Isoc) MxPS=3D&nbsp; 25 Ivl=
=3D1ms<br>I:&nbsp; If#=3D 1 Alt=3D 4 #EPs=3D 2 Cls=3De0(unk. ) Sub=3D01 Pro=
t=3D01 Driver=3Dhci_usb<br>E:&nbsp; Ad=3D83(I) Atr=3D01(Isoc) MxPS=3D&nbsp;=
 33 Ivl=3D1ms<br>E:&nbsp; Ad=3D03(O) Atr=3D01(Isoc) MxPS=3D&nbsp; 33 Ivl=3D=
1ms<br>I:&nbsp; If#=3D 1 Alt=3D 5 #EPs=3D 2 Cls=3De0(unk. ) Sub=3D01 Prot=
=3D01 Driver=3Dhci_usb<br>E:&nbsp; Ad=3D83(I) Atr=3D01(Isoc) MxPS=3D&nbsp; =
49 Ivl=3D1ms<br>E:&nbsp; Ad=3D03(O) Atr=3D01(Isoc) MxPS=3D&nbsp; 49 Ivl=3D1=
ms<br>I:&nbsp; If#=3D 2 Alt=3D 0 #EPs=3D 2 Cls=3Dff(vend.) Sub=3Dff Prot=3D=
ff Driver=3D(none)<br>E:&nbsp; Ad=3D84(I) Atr=3D02(Bulk) MxPS=3D&nbsp; 32 I=
vl=3D0ms<br>E:&nbsp; Ad=3D04(O) Atr=3D02(Bulk) MxPS=3D&nbsp; 32 Ivl=3D0ms<b=
r>I:&nbsp; If#=3D 3 Alt=3D 0 #EPs=3D 0 Cls=3Dfe(app. ) Sub=3D01 Prot=3D00
 Driver=3D(none)<br><br>As you said there might be a incompatibility issues=
 in one of them(HS/dongle)<br>Can it happen that I might require to play th=
e audio with certain frequency, rate or parameters which are supported by m=
y HS(Its a Sony Ericsson HBH-602)?<br>Thanks once again for your share of t=
ime.<br>have a nice time ahead.<br></div>Thanks and Best regards<div>&nbsp;=
</div><div>Pramod<div style=3D"font-family: times new roman,new york,times,=
serif; font-size: 12pt;"><br><br><div style=3D"font-family: times new roman=
,new york,times,serif; font-size: 12pt;">----- Original Message ----<br>Fro=
m: jayjwa &lt;jayjwa@atr2.ath.cx&gt;<br>To: BlueZ users &lt;bluez-users@lis=
ts.sourceforge.net&gt;<br>Sent: Friday, 15 February, 2008 6:59:34 PM<br>Sub=
ject: Re: [Bluez-users] Headset not playing audio HELP PLEASE<br><br><br>On=
 =0AFri, =0A15 =0AFeb =0A2008, =0Apramod =0Agurav =0Awrote:<br><br>-&gt; =
=0Awill =0Ayou =0Aplease =0Asend =0Ame =0Athe =0Aconf =0Afiles =0ASo =0Atha=
t =0AI =0Acan =0Arectify =0Amines.<br><br>Your =0Aconfigs =0Alook =0AOK, =
=0Abut =0Aif =0Ayou =0Awant =0Athem:<br><br>wget =0A--no-check-certificate =
=0A<a href=3D"https://atr2.ath.cx/%7Ejayjwa/download/bt-configs.zip" target=
=3D"_blank">https://atr2.ath.cx/~jayjwa/download/bt-configs.zip</a><br>or<b=
r>curl =0A-O =0A-v =0A-k =0A<a href=3D"https://atr2.ath.cx/%7Ejayjwa/downlo=
ad/bt-configs.zip" target=3D"_blank">https://atr2.ath.cx/~jayjwa/download/b=
t-configs.zip</a><br><br><br>-&gt; =0AAlso =0AI =0Awant =0Ato =0Atell =0Ayo=
u =0Athat =0AI =0Ahave =0Ainstalled =0Abt-sco =0Abut =0Alater =0Aon =0AI =
=0Aread =0Asomewhere =0Athat =0Athis =0Ais =0Aolder =0Amethod =0Ato =0Ado. =
=0AIs =0Ait =0Awrite?<br>-&gt; =0ASo =0AI =0Astoped =0Athere. =0ACan =0AI =
=0Atry =0Abtsco =0Away?<br>-&gt; =0ABut =0Ai =0Adont =0Ahave =0Amodule =0As=
nd_bt_sco.<br>-&gt; =0Aplease =0Aenlighten =0Ame =0Aon =0Abtsco =0A.<br><br=
>It's =0Aold =0Aand =0Aprobably =0Aobsolete. =0AIt =0Amight =0Anot =0Aeven =
=0Abe =0Apossible =0Ato =0Ause =0Ait <br>without =0Ainstalling =0Aold =0Abl=
uez =0Alibs/utilz =0Aand =0Aan =0Aold =0A(possibly =0Ainsecure) =0Akernel. =
<br>Even =0Adoing =0Aall =0Athat =0Awork, =0Athere's =0Ano =0Agarentee =0At=
hat =0Ait =0Awill =0Awork =0Aany =0Abetter. <br>You =0Amight =0Astill =0Ahi=
t =0Athe =0Asame =0Aissue. =0AI'd =0Astay =0Acurrent, =0Aand =0Amake =0Asur=
e =0Ato =0Asee =0Athe <br>link =0Ain =0Amy =0Alast-to-this =0Apost =0Aabout=
 =0Asco =0Amtu.<br><br>There's =0Aonly =0Aso =0Amany =0Aconfiguration =0Aop=
tions =0Ayou =0Acan =0Atry, =0Aand =0Aby =0Anow =0Ayou've <br>tried =0Ajust=
 =0Aabout =0Aall =0Aof =0Athem. =0AAt =0Athis =0Apoint, =0Ayou =0Amay =0Abe=
 =0Alooking =0Aat =0Aan <br>incompatibility =0Ain =0Aone =0Aor =0Aboth =0Ao=
f =0Ayour =0Ahardware =0Acomponents, =0Aor =0Aa =0Abug =0Ain <br>either/bot=
h. =0AThat's =0Awhy =0Ait =0Awould =0Abe =0Ahelpful =0Aif =0Ayou =0Acould =
=0Atry =0Aother =0Ahardware, <br>or =0Atry =0Ato =0Afind =0Aaccounts =0Aof =
=0Asomeone =0Agetting =0Aa =0Aworking =0Aexample =0Ausing =0Ayour <br>hardw=
are =0Aon =0Aa =0Asimilar =0Asetup. =0AThen =0Ayou =0Acould =0Asay =0Aeithe=
r =0Away =0Aif =0Ait's =0Areally =0Aa <br>hardware =0Aissue =0Aor =0Anot. =
=0ACould =0Abe =0Athat =0Ait's =0Anot, =0Abut =0Ain =0Asearching =0Afor =0A=
the =0Acause <br>of =0Aan =0Aerror/reason =0Asomething's =0Anot =0Aworking,=
 =0Ait's =0Aone =0Aof =0Athe =0Athings =0Ayou =0Ahave =0Ato <br>consider. =
=0ABecause =0Aif =0Ait =0Ais =0Athe =0Acase, =0Athen =0Ano =0Aamount =0Aof =
=0Aconfig =0Achanges =0Aor <br>updates =0Awill =0Ahelp.<br><br>By =0Awhat =
=0Ayou've =0Aposted, =0Ait =0Alooks =0Acorrect =0Aand =0Ashould =0Abe =0Awo=
rking, =0Aonly =0Ait =0Aisn't. <br>The =0Afact =0Asound =0Adoes =0Awork =0A=
one =0Away =0Aand =0Anot =0Athe =0Aother =0Ais =0Avery =0Aodd =0Atoo. =0AIf=
 =0Ait =0Awas <br>a =0Aconfig =0Aerror, =0Aseems =0Alike =0Aneither =0Awoul=
d =0Awork.<br><br><br><br><br>---------------------------------------------=
----------------------------<br>This =0ASF.net =0Aemail =0Ais =0Asponsored =
=0Aby: =0AMicrosoft<br>Defy =0Aall =0Achallenges. =0AMicrosoft(R) =0AVisual=
 =0AStudio =0A2008.<br><a href=3D"http://clk.atdmt.com/MRT/go/vse0120000070=
mrt/direct/01/" target=3D"_blank">http://clk.atdmt.com/MRT/go/vse0120000070=
mrt/direct/01/</a><br>_______________________________________________<br>Bl=
uez-users =0Amailing =0Alist<br><a ymailto=3D"mailto:Bluez-users@lists.sour=
ceforge.net" href=3D"mailto:Bluez-users@lists.sourceforge.net">Bluez-users@=
lists.sourceforge.net</a><br><a href=3D"https://lists.sourceforge.net/lists=
/listinfo/bluez-users" target=3D"_blank">https://lists.sourceforge.net/list=
s/listinfo/bluez-users</a><br></div><br></div></div></div><br>=0A=0A=0A    =
  <!--4--><hr size=3D1></hr> 5, 50, 500, 5000 - Store N number of mails in =
your inbox. <a href=3D"http://in.rd.yahoo.com/tagline_mail_4/*http://help.y=
ahoo.com/l/in/yahoo/mail/yahoomail/tools/tools-08.html/">Click here.</a></b=
ody></html>
--0-467814118-1203085276=:61640--


--===============1989320721==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
--===============1989320721==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

--===============1989320721==--
