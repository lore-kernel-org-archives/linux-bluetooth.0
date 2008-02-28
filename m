Return-Path: <cyrus@holtmann.org>
Date: Thu, 28 Feb 2008 08:54:47 +0530 (IST)
From: pramod gurav <pramod_gurav_etc@yahoo.co.in>
To: BlueZ users <bluez-users@lists.sourceforge.net>
MIME-Version: 1.0
Message-ID: <918680.33243.qm@web8402.mail.in.yahoo.com>
Subject: Re: [Bluez-users] BT headset doesn't work: SCO connection timeout
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============1369351274=="
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

--===============1369351274==
Content-Type: multipart/alternative; boundary="0-773819792-1204169087=:33243"

--0-773819792-1204169087=:33243
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi andrea=0ASame problem used to occur with me.=0AMy hciconfig also used to=
 show this sco mtu =0ASCO MTU: 64:0=0Awhereas others on the list it was som=
ething SCO MTU: 64:8.=0ASo i changed my dongle. and it simply worked.=0AI b=
ought one new BT dongle which clamed it supports HS audio Gtaeway.=0AIt is =
a product of ENTER multimedia.=0Athis is it.=0A[root@localhost Pramod]# /us=
r/local/sbin/hciconfig -a=0Ahci0:   Type: USB=0A        BD Address: 11:11:1=
1:11:11:11 ACL MTU: 678:8 SCO MTU: 48:10=0A        UP RUNNING PSCAN ISCAN=
=0A        RX bytes:10283222 acl:386 sco:201151 events:719 errors:0=0A     =
   TX bytes:10319322 acl:347 sco:202172 commands:192 errors:0=0A        Fea=
tures: 0xbf 0xfe 0x8d 0x78 0x08 0x18 0x00 0x00=0A        Packet type: DM1 D=
M3 DM5 DH1 DH3 DH5 HV1 HV2 HV3=0A        Link policy: RSWITCH HOLD SNIFF PA=
RK=0A        Link mode: SLAVE ACCEPT=0A        Name: 'BlueZ (0)'=0A        =
Class: 0x080100=0A        Service Classes: Capturing=0A        Device Class=
: Computer, Uncategorized=0A        HCI Ver: 1.2 (0x2) HCI Rev: 0x1fe LMP V=
er: 1.2 (0x2) LMP Subver: 0x1fe=0A        Manufacturer: Integrated System S=
olution Corp. (57)=0A=0AI tried all option from list about sco but they nev=
er worked.=0AYou too can try them. But before that try replacing your BT do=
ngle.=0AIt will save your time.=0A=0A=0AThanks and Best regards=0A=0APramod=
=0A=0A----- Original Message ----=0AFrom: Andrea Bondavalli <Andrea.Bondava=
lli@qtm.it>=0ATo: Bluez-users@lists.sourceforge.net=0ASent: Wednesday, 27 F=
ebruary, 2008 8:44:09 PM=0ASubject: [Bluez-users] BT headset doesn't work: =
SCO connection timeout=0A=0A    =0A<!--=0A=0A /* Style Definitions */=0A p.=
MsoNormal, li.MsoNormal, div.MsoNormal=0A=09{margin:0cm;margin-bottom:.0001=
pt;font-size:12.0pt;font-family:"Times New Roman";}=0Aa:link, span.MsoHyper=
link=0A=09{color:blue;text-decoration:underline;}=0Aa:visited, span.MsoHype=
rlinkFollowed=0A=09{color:purple;text-decoration:underline;}=0Aspan.StileMe=
ssaggioDiPostaElettronica17=0A=09{font-family:Arial;color:windowtext;}=0A _=
filtered {margin:70.85pt 2.0cm 2.0cm 2.0cm;}=0Adiv.Section1=0A=09{}=0A-->=
=0ADear all,=0A   =0A I=E2=80=99ve got a linux kernel 2.4.20 with bluez=0Al=
ibs/utils 3.23 on a ARM linux platform.=0A   =0A I can successfully ping an=
d pair my headset, but I am=0Anot able to connect a SCO channel.=0A As soon=
 as I try to connect a SCO channel (using the=0Ascotest utility, and also o=
ther applications) the call always fails with a timeout=0Aerror.=0A   =0A H=
ere are some useful  traces:=0A   =0A # hciconfig=0Ahci0:   Type: UART=0A  =
      BD Address: 00:80:E1:00:AB:BA ACLMTU: 1021:4 SCO MTU: 64:0=0A        =
UP RUNNING PSCAN ISCAN=0A        RX bytes:10150 acl:204 sco:0events:326 err=
ors:0=0A        TX bytes:4097 acl:168 sco:0commands:81 errors:0=0A   =0A # =
hciconfig hci0=0Arevision=0A   STLC2500 R4.212102005 12:40:14 ZAV100012  A7=
=0A        HW Id=3D V440BAA=0A   =0A # hciconfig hci0=0Aversion=0Ahci0:   T=
ype: UART=0A        BD Address: 00:80:E1:00:AB:BA ACLMTU: 1021:4 SCO MTU: 6=
4:0=0A        HCI Ver: 2.0 (0x3) HCI Rev: 0x402LMP Ver: 2.0 (0x3) LMP Subve=
r: 0x520=0A        Manufacturer: ST Microelectronics(48)  =0A--------------=
------------------------------------------------------=0A Ping=0Aoutput is =
OK:=0A   =0A # passkey-agent0000 00:12:1C:BB:01:98 &=0A# l2ping 00:12:1C:BB=
:01:98=0APasskey request for device 00:12:1C:BB:01:98=0APasskey service has=
 been released=0A Ping : 00:12:1C:BB:01:98 from 00:80:E1:00:AB:BA(data size=
 44) ...=0A0 bytes from 00:12:1C:BB:01:98 id 0 time 101.29ms=0A0 bytes from=
 00:12:1C:BB:01:98 id 1 time 48.42ms=0A0 bytes from 00:12:1C:BB:01:98 id 2 =
time 52.15ms=0A0 bytes from 00:12:1C:BB:01:98 id 3 time 36.95ms=0A0 bytes f=
rom 00:12:1C:BB:01:98 id 4 time 60.60ms=0A0 bytes from 00:12:1C:BB:01:98 id=
 5 time 43.05ms=0A0 bytes from 00:12:1C:BB:01:98 id 6 time 48.42ms=0A0 byte=
s from 00:12:1C:BB:01:98 id 7 time 96.63ms=0A0 bytes from 00:12:1C:BB:01:98=
 id 8 time 60.66ms=0A0 bytes from 00:12:1C:BB:01:98 id 9 time 62.69ms=0A0 b=
ytes from 00:12:1C:BB:01:98 id 10 time 41.35ms=0A11 sent, 11 received, 0% l=
oss=0A   =0A   =0A --------------------------------------------------------=
------------=0A scotest (from bluez-utils-3.23) output=0A   =0A # hcidump -=
X=0AHCI sniffer - Bluetooth packet analyzer ver 1.40=0Adevice: hci0 snap_le=
n: 1028 filter: 0xffffffff=0A # passkey-agent=0A0000 00:12:1C:BB:01:98 &=0A=
 # scotest -s=0A00:12:1C:BB:01:98 &=0A  =0A < HCI Command: Create Connectio=
n (0x01|0x0005)plen 13=0A  0000: 98 01 bb 1c 12 00 18 cc  02 00 00 0001    =
       .............=0A> HCI Event: Command Status (0x0f) plen 4=0A  0000: =
00 01 0504                                      ....=0A> HCI Event: Role Ch=
ange (0x12) plen 8=0A  0000: 00 98 01 bb 1c 12 0001                        =
  ........=0A> HCI Event: Link Key Request (0x17) plen 6=0A  0000: 98 01 bb=
 1c 1200                                ......=0A< HCI Command: Link Key Re=
quest Negative Reply (0x01|0x000c) plen 6=0A  0000: 98 01 bb 1c 1200       =
                         ......=0A> HCI Event: Command Complete (0x0e) plen=
 10=0A  0000: 01 0c 04 00 98 01 bb 1c  1200                   ..........=0A=
> HCI Event: PIN Code Request (0x16) plen 6=0A  0000: 98 01 bb 1c 1200     =
                           ......=0APasskey request for device 00:12:1C:BB:=
01:98=0A< HCI Command: PIN Code Request Reply (0x01|0x000d) plen 23=0A  000=
0: 98 01 bb 1c 12 00 04 30  30 30 30 00 00 00 00 00 .......0000.....=0A  00=
10: 00 00 00 00 00 0000                             .......=0APasskey servi=
ce has been released=0A> HCI Event: Command Complete (0x0e) plen 10=0A  000=
0: 01 0d 04 00 98 01 bb 1c  1200                   ..........=0A> HCI Event=
: Link Key Notification (0x18) plen 23=0A  0000: 98 01 bb 1c 12 00 11 a5  8=
9 24 9a 6a 5b d8 44 07 .........$.j[.D.=0A  0010: 3a e8 13 4e 0f 0600      =
                       :..N...=0A> HCI Event: Connect Complete (0x03) plen =
11=0A  0000: 00 01 00 98 01 bb 1c 12  00 0100                ...........=0A=
> HCI Event: Command Status (0x0f) plen 4=0A  0000: 00 02 0000             =
                         ....=0A< HCI Command: Write Link Policy Settings (=
0x02|0x000d) plen 4=0A  0000: 01 00 0f 00                                  =
    ....=0A> HCI Event: Max Slots Change (0x1b) plen 3=0A  0000: 01 0005   =
                                      ...=0A> HCI Event: Command Complete (=
0x0e) plen 6=0A  0000: 02 0d 08 00 0100                                ....=
...=0A< HCI Command: Add SCO Connection(0x01|0x0007) plen 4=0A  0000: 01 00 =
a000                                      ....=0A> HCI Event: Command Compl=
ete (0x0e) plen 4=0A  0000: 02 07 0401                                     =
 ....=0A< HCI Command: Remote Name Request (0x01|0x0019) plen 10=0A  0000: =
98 01 bb 1c 12 00 02 00  00 00                   ..........=0A> HCI Event: =
Command Status (0x0f) plen 4=0A  0000: 00 01 1904                          =
            ....=0A> HCI Event: Remote Name Req Complete (0x07) plen 255=0A=
  0000: 00 98 01 bb 1c 12 00 50  61 72 72 6f 74 20 4d 4b  .......ParrotMK=
=0A  0010: 36 30 30 30 76 31 2e 30  31 63 00 00 00 00 00 00 6000v1.01c.....=
..=0A  0020: 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00 ..............=
...=0A  0030: 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00 .............=
....=0A  0040: 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00 ............=
.....=0A  0050: 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00 ...........=
......=0A  0060: 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00 ..........=
.......=0A  0070: 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00 .........=
........=0A  0080: 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00 ........=
.........=0A  0090: 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00 .......=
..........=0A  00a0: 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00 ......=
...........=0A  00b0: 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00 .....=
............=0A  00c0: 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00 ....=
.............=0A  00d0: 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00 ...=
..............=0A  00e0: 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00 ..=
...............=0A  00f0: 00 00 00 00 00 00 00 00  00 00 00 00 00 0000     .=
...............=0A> HCI Event: Command Status (0x0f) plen 4=0A  0000: 00 02 =
0000                                      ....=0A< HCI Command: Read Remote=
 Version Information (0x01|0x001d) plen 2=0A  0000: 0100                   =
                         ..=0A> HCI Event: Command Status (0x0f) plen 4=0A =
 0000: 00 01 1d04                                      ....=0A> HCI Event: =
Read Remote Ver Info Complete (0x0c) plen 8=0A  0000: 00 01 00 02 43 00 1c0=
1                          ....C...=0A> HCI Event: Command Status (0x0f) pl=
en 4=0A  0000: 00 02 0000                                      ....=0Ascote=
st[104]: Can't connect: Connection timed=0Aout (110)=0A=0A=0A It seems that=
 the only reply to the Add SCO=0AConnection command is an unexpected Comman=
d Complete event and than the=0Aconnect() system call fails with a timeout =
(40sec) error.=0A As far as I know the only possible replies to the Add=0AS=
CO Connection  command should be the Command Status event and the Command C=
omplete=0Aevent.=0A   =0A Have you ever experienced this problem ? Any hint=
s ?=0A   =0A Thank you a lot in advance,=0A Andrea Bondavalli=0A   =0A   =
=0A =0A=0A=0A-----Inline Attachment Follows-----=0A=0A---------------------=
----------------------------------------------------=0AThis SF.net email is=
 sponsored by: Microsoft=0ADefy all challenges. Microsoft(R) Visual Studio =
2008.=0Ahttp://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/=0A=0A=0A---=
--Inline Attachment Follows-----=0A=0A_____________________________________=
__________=0ABluez-users mailing list=0ABluez-users@lists.sourceforge.net=
=0Ahttps://lists.sourceforge.net/lists/listinfo/bluez-users=0A=0A=0A=0A=0A=
=0A=0A=0A=0A      Now you can chat without downloading messenger. Go to htt=
p://in.messenger.yahoo.com/webmessengerpromo.php
--0-773819792-1204169087=:33243
Content-Type: text/html; charset=utf-8
Content-Transfer-Encoding: quoted-printable

<html><head><style type=3D"text/css"><!-- DIV {margin:0px;} --></style></he=
ad><body><div style=3D"font-family:times new roman, new york, times, serif;=
font-size:12pt"><font face=3D"Arial" size=3D"2"><span style=3D"font-size: 1=
0pt; font-family: Arial;" lang=3D"EN-GB">Hi andrea<br>Same problem used to =
occur with me.<br>My hciconfig also used to show this sco mtu <br>SCO MTU: =
64:0<br>whereas others on the list it was something </span></font><font fac=
e=3D"Arial" size=3D"2"><span style=3D"font-size: 10pt; font-family: Arial;"=
 lang=3D"EN-GB">SCO MTU: 64:8.<br>So i changed my dongle. and it simply wor=
ked.<br></span></font>I bought one new BT dongle which clamed it supports H=
S audio Gtaeway.<br>It is a product of ENTER multimedia.<br>this is it.<br>=
[root@localhost Pramod]# /usr/local/sbin/hciconfig -a<br>hci0:&nbsp;&nbsp; =
Type: USB<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; BD Address: 11:11:1=
1:11:11:11 ACL MTU: 678:8 <span style=3D"font-style: italic; font-weight: b=
old;
 text-decoration: underline;">SCO MTU: 48:10</span><br>&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp; UP RUNNING PSCAN ISCAN<br>&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp; RX bytes:10283222 acl:386 sco:201151 events:719 errors:0<b=
r>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; TX bytes:10319322 acl:347 sco:=
202172 commands:192 errors:0<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
Features: 0xbf 0xfe 0x8d 0x78 0x08=0A 0x18 0x00 0x00<br>&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp; Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3<br=
>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Link policy: RSWITCH HOLD SNIFF=
 PARK<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Link mode: SLAVE ACCEPT=
<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Name: 'BlueZ (0)'<br>&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Class: 0x080100<br>&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp; Service Classes: Capturing<br>&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp; Device Class: Computer, Uncategorized<br>&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp; HCI Ver: 1.2 (0x2) HCI Rev: 0x1fe LMP Ver: 1.=
2 (0x2) LMP Subver: 0x1fe<br>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Man=
ufacturer: Integrated System Solution Corp. (57)<br><br><div>I tried all op=
tion from list about sco but they never worked.<br>You too can try them. Bu=
t before that try replacing your BT dongle.<br>It will save your time.<br><=
br></div>Thanks and Best
 regards<br><br><div>Pramod<div style=3D"font-family: times new roman,new y=
ork,times,serif; font-size: 12pt;"><br><br><div style=3D"font-family: times=
 new roman,new york,times,serif; font-size: 12pt;">----- Original Message -=
---<br>From: Andrea Bondavalli &lt;Andrea.Bondavalli@qtm.it&gt;<br>To: Blue=
z-users@lists.sourceforge.net<br>Sent: Wednesday, 27 February, 2008 8:44:09=
 PM<br>Subject: [Bluez-users] BT headset doesn't work: SCO connection timeo=
ut<br><br>=0A=0A=0A =0A =0A=0A =0A=0A =0A=0A<style>=0A<!--=0A=0A /* Style D=
efinitions */=0A p.MsoNormal, li.MsoNormal, div.MsoNormal=0A=09{margin:0cm;=
margin-bottom:.0001pt;font-size:12.0pt;font-family:"Times New Roman";}=0Aa:=
link, span.MsoHyperlink=0A=09{color:blue;text-decoration:underline;}=0Aa:vi=
sited, span.MsoHyperlinkFollowed=0A=09{color:purple;text-decoration:underli=
ne;}=0Aspan.StileMessaggioDiPostaElettronica17=0A=09{font-family:Arial;colo=
r:windowtext;}=0A _filtered {margin:70.85pt 2.0cm 2.0cm 2.0cm;}=0Adiv.Secti=
on1=0A=09{}=0A-->=0A</style>=0A=0A=0A=0A<div class=3D"Section1">=0A=0A<p cl=
ass=3D"MsoNormal"><font face=3D"Arial" size=3D"2"><span style=3D"font-size:=
 10pt; font-family: Arial;" lang=3D"EN-GB">Dear all,</span></font></p> =0A=
=0A<p class=3D"MsoNormal"><font face=3D"Arial" size=3D"2"><span style=3D"fo=
nt-size: 10pt; font-family: Arial;" lang=3D"EN-GB"> &nbsp;</span></font></p=
> =0A=0A<p class=3D"MsoNormal"><font face=3D"Arial" size=3D"2"><span style=
=3D"font-size: 10pt; font-family: Arial;" lang=3D"EN-GB">I=E2=80=99ve got a=
 linux kernel 2.4.20 with bluez=0Alibs/utils 3.23 on a ARM linux platform.<=
/span></font></p> =0A=0A<p class=3D"MsoNormal"><font face=3D"Arial" size=3D=
"2"><span style=3D"font-size: 10pt; font-family: Arial;" lang=3D"EN-GB"> &n=
bsp;</span></font></p> =0A=0A<p class=3D"MsoNormal"><font face=3D"Arial" si=
ze=3D"2"><span style=3D"font-size: 10pt; font-family: Arial;" lang=3D"EN-GB=
">I can successfully ping and pair my headset, but I am=0Anot able to conne=
ct a SCO channel.</span></font></p> =0A=0A<p class=3D"MsoNormal"><font face=
=3D"Arial" size=3D"2"><span style=3D"font-size: 10pt; font-family: Arial;" =
lang=3D"EN-GB">As soon as I try to connect a SCO channel (using the=0Ascote=
st utility, and also other applications) the call always fails with a timeo=
ut=0Aerror.</span></font></p> =0A=0A<p class=3D"MsoNormal"><font face=3D"Ar=
ial" size=3D"2"><span style=3D"font-size: 10pt; font-family: Arial;" lang=
=3D"EN-GB"> &nbsp;</span></font></p> =0A=0A<p class=3D"MsoNormal"><font fac=
e=3D"Arial" size=3D"2"><span style=3D"font-size: 10pt; font-family: Arial;"=
 lang=3D"EN-GB">Here are some useful &nbsp;traces:</span></font></p> =0A=0A=
<p class=3D"MsoNormal"><font face=3D"Arial" size=3D"2"><span style=3D"font-=
size: 10pt; font-family: Arial;" lang=3D"EN-GB"> &nbsp;</span></font></p> =
=0A=0A<p class=3D"MsoNormal"><b><font face=3D"Arial" size=3D"2"><span style=
=3D"font-size: 10pt; font-family: Arial; font-weight: bold;" lang=3D"EN-GB"=
># hciconfig</span></font></b><font face=3D"Arial" size=3D"2"><span style=
=3D"font-size: 10pt; font-family: Arial;" lang=3D"EN-GB"><br>=0Ahci0:&nbsp;=
&nbsp; Type: UART<br>=0A&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; BD Addre=
ss: 00:80:E1:00:AB:BA ACL=0AMTU: 1021:4 SCO MTU: 64:0<br>=0A&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp; UP RUNNING PSCAN ISCAN<br>=0A&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; RX bytes:10150 acl:204 sco:0=0Aevents:326 errors:0=
<br>=0A&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; TX bytes:4097 acl:168 sco=
:0=0Acommands:81 errors:0</span></font></p> =0A=0A<p class=3D"MsoNormal"><f=
ont face=3D"Arial" size=3D"2"><span style=3D"font-size: 10pt; font-family: =
Arial;" lang=3D"EN-GB"> &nbsp;</span></font></p> =0A=0A<p class=3D"MsoNorma=
l"><b><font face=3D"Arial" size=3D"2"><span style=3D"font-size: 10pt; font-=
family: Arial; font-weight: bold;" lang=3D"EN-GB"># hciconfig hci0=0Arevisi=
on</span></font></b><b><span style=3D"font-weight: bold;" lang=3D"EN-GB"></=
span></b></p> =0A=0A<p class=3D"MsoNormal"><font face=3D"Times New Roman" s=
ize=3D"3"><span style=3D"font-size: 12pt;" lang=3D"EN-GB">&nbsp;</span></fo=
nt><font face=3D"Arial" size=3D"2"><span style=3D"font-size: 10pt; font-fam=
ily: Arial;" lang=3D"EN-GB">&nbsp;STLC2500 R4.2=0A12102005 12:40:14 ZAV1000=
12&nbsp; A7<br>=0A&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; HW Id=3D V440B=
AA</span></font></p> =0A=0A<p class=3D"MsoNormal"><font face=3D"Arial" size=
=3D"2"><span style=3D"font-size: 10pt; font-family: Arial;" lang=3D"EN-GB">=
 &nbsp;</span></font></p> =0A=0A<p class=3D"MsoNormal"><b><font face=3D"Ari=
al" size=3D"2"><span style=3D"font-size: 10pt; font-family: Arial; font-wei=
ght: bold;" lang=3D"EN-GB"># hciconfig hci0=0Aversion</span></font></b><fon=
t face=3D"Arial" size=3D"2"><span style=3D"font-size: 10pt; font-family: Ar=
ial;" lang=3D"EN-GB"><br>=0Ahci0:&nbsp;&nbsp; Type: UART<br>=0A&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; BD Address: 00:80:E1:00:AB:BA ACL=0AMTU: 102=
1:4 SCO MTU: 64:0<br>=0A&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; HCI Ver:=
 2.0 (0x3) HCI Rev: 0x402=0ALMP Ver: 2.0 (0x3) LMP Subver: 0x520<br>=0A&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Manufacturer: ST Microelectronics=0A=
(48)&nbsp;&nbsp;<br>=0A----------------------------------------------------=
----------------</span></font></p> =0A=0A<p class=3D"MsoNormal"><font face=
=3D"Arial" size=3D"2"><span style=3D"font-size: 10pt; font-family: Arial;" =
lang=3D"EN-GB">Ping</span></font><font face=3D"Arial" size=3D"2"><span styl=
e=3D"font-size: 10pt; font-family: Arial;" lang=3D"EN-GB">=0Aoutput is OK:<=
/span></font></p> =0A=0A<p class=3D"MsoNormal"><b><font face=3D"Arial" size=
=3D"2"><span style=3D"font-size: 10pt; font-family: Arial; font-weight: bol=
d;" lang=3D"EN-GB"> &nbsp;</span></font></b></p> =0A=0A<p class=3D"MsoNorma=
l"><b><font face=3D"Arial" size=3D"2"><span style=3D"font-size: 10pt; font-=
family: Arial; font-weight: bold;" lang=3D"EN-GB"># passkey-agent=0A0000 00=
:12:1C:BB:01:98 &amp;<br>=0A# l2ping 00:12:1C:BB:01:98</span></font></b><fo=
nt face=3D"Arial" size=3D"2"><span style=3D"font-size: 10pt; font-family: A=
rial;" lang=3D"EN-GB"><br>=0APasskey request for device 00:12:1C:BB:01:98<b=
r>=0APasskey service has been released<br>=0A Ping : 00:12:1C:BB:01:98 from=
 00:80:E1:00:AB:BA=0A(data size 44) ...<br>=0A0 bytes from 00:12:1C:BB:01:9=
8 id 0 time 101.29ms<br>=0A0 bytes from 00:12:1C:BB:01:98 id 1 time 48.42ms=
<br>=0A0 bytes from 00:12:1C:BB:01:98 id 2 time 52.15ms<br>=0A0 bytes from =
00:12:1C:BB:01:98 id 3 time 36.95ms<br>=0A0 bytes from 00:12:1C:BB:01:98 id=
 4 time 60.60ms<br>=0A0 bytes from 00:12:1C:BB:01:98 id 5 time 43.05ms<br>=
=0A0 bytes from 00:12:1C:BB:01:98 id 6 time 48.42ms<br>=0A0 bytes from 00:1=
2:1C:BB:01:98 id 7 time 96.63ms<br>=0A0 bytes from 00:12:1C:BB:01:98 id 8 t=
ime 60.66ms<br>=0A0 bytes from 00:12:1C:BB:01:98 id 9 time 62.69ms<br>=0A0 =
bytes from 00:12:1C:BB:01:98 id 10 time 41.35ms<br>=0A11 sent, 11 received,=
 0% loss<b><span style=3D"font-weight: bold;"></span></b></span></font></p>=
 =0A=0A<p class=3D"MsoNormal"><b><font face=3D"Arial" size=3D"2"><span styl=
e=3D"font-size: 10pt; font-family: Arial; font-weight: bold;" lang=3D"EN-GB=
"> &nbsp;</span></font></b></p> =0A=0A<p class=3D"MsoNormal"><b><font face=
=3D"Arial" size=3D"2"><span style=3D"font-size: 10pt; font-family: Arial; f=
ont-weight: bold;" lang=3D"EN-GB"> &nbsp;</span></font></b></p> =0A=0A<p cl=
ass=3D"MsoNormal"><font face=3D"Arial" size=3D"2"><span style=3D"font-size:=
 10pt; font-family: Arial;" lang=3D"EN-GB">--------------------------------=
------------------------------------</span></font></p> =0A=0A<p class=3D"Ms=
oNormal"><font face=3D"Arial" size=3D"2"><span style=3D"font-size: 10pt; fo=
nt-family: Arial;" lang=3D"EN-GB">scotest (from bluez-utils-3.23) output</s=
pan></font></p> =0A=0A<p class=3D"MsoNormal"><font face=3D"Arial" size=3D"2=
"><span style=3D"font-size: 10pt; font-family: Arial;" lang=3D"EN-GB"> &nbs=
p;</span></font></p> =0A=0A<p class=3D"MsoNormal"><b><font face=3D"Arial" s=
ize=3D"2"><span style=3D"font-size: 10pt; font-family: Arial; font-weight: =
bold;" lang=3D"EN-GB"># hcidump -X</span></font></b><font face=3D"Arial" si=
ze=3D"2"><span style=3D"font-size: 10pt; font-family: Arial;" lang=3D"EN-GB=
"><br>=0AHCI sniffer - Bluetooth packet analyzer ver 1.40<br>=0Adevice: hci=
0 snap_len: 1028 filter: 0xffffffff</span></font></p> =0A=0A<p class=3D"Mso=
Normal"><b><font face=3D"Arial" size=3D"2"><span style=3D"font-size: 10pt; =
font-family: Arial; font-weight: bold;" lang=3D"EN-GB"># passkey-agent=0A00=
00 00:12:1C:BB:01:98 &amp;</span></font></b><font face=3D"Arial" size=3D"2"=
><span style=3D"font-size: 10pt; font-family: Arial;" lang=3D"EN-GB"></span=
></font></p> =0A=0A<p class=3D"MsoNormal"><b><font face=3D"Arial" size=3D"2=
"><span style=3D"font-size: 10pt; font-family: Arial; font-weight: bold;" l=
ang=3D"EN-GB"># scotest -s=0A00:12:1C:BB:01:98 &amp;</span></font></b><b><s=
pan style=3D"font-weight: bold;" lang=3D"EN-GB"></span></b></p> =0A=0A<p cl=
ass=3D"MsoNormal"><b><font face=3D"Times New Roman" size=3D"3"><span style=
=3D"font-size: 12pt; font-weight: bold;" lang=3D"EN-GB">&nbsp;</span></font=
></b></p> =0A=0A<p class=3D"MsoNormal"><font face=3D"Arial" size=3D"2"><spa=
n style=3D"font-size: 10pt; font-family: Arial;" lang=3D"EN-GB">&lt; HCI Co=
mmand: Create Connection (0x01|0x0005)=0Aplen 13<br>=0A&nbsp; 0000: 98 01 b=
b 1c 12 00 18 cc&nbsp; 02 00 00 00=0A01&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp; .............<br>=0A&gt; HCI Event: Command Status=
 (0x0f) plen 4<br>=0A&nbsp; 0000: 00 01 05=0A04&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=0A....<br>=0A&gt; HCI Ev=
ent: Role Change (0x12) plen 8<br>=0A&nbsp; 0000: 00 98 01 bb 1c 12 00=0A01=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;=0A........<br>=0A&gt; HCI Event: Link Key Request (0x17) plen 6<br>=
=0A&nbsp; 0000: 98 01 bb 1c 12=0A00&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;=0A......<br>=0A&lt; HCI Command: Link Key Request Negative Reply (0x01|0=
x000c) plen 6<br>=0A&nbsp; 0000: 98 01 bb 1c 12=0A00&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;=0A......<br>=0A&gt; HCI Event: Command Complete (0x0e) =
plen 10<br>=0A&nbsp; 0000: 01 0c 04 00 98 01 bb 1c&nbsp; 12=0A00&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;=0A..........<br>=0A&gt; HCI Event: PIN Code Re=
quest (0x16) plen 6<br>=0A&nbsp; 0000: 98 01 bb 1c 12=0A00&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;=0A......<br>=0APasskey request for device 00:12:1=
C:BB:01:98<br>=0A&lt; HCI Command: PIN Code Request Reply (0x01|0x000d) ple=
n 23<br>=0A&nbsp; 0000: 98 01 bb 1c 12 00 04 30&nbsp; 30 30 30 00 00 00 00 =
00&nbsp;=0A.......0000.....<br>=0A&nbsp; 0010: 00 00 00 00 00 00=0A00&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;=0A.......<br>=0APasskey service has been released<br>=0A=
&gt; HCI Event: Command Complete (0x0e) plen 10<br>=0A&nbsp; 0000: 01 0d 04=
 00 98 01 bb 1c&nbsp; 12=0A00&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=0A....=
.......<br>=0A&gt; HCI Event: Link Key Notification (0x18) plen 23<br>=0A&nb=
sp; 0000: 98 01 bb 1c 12 00 11 a5&nbsp; 89 24 9a 6a 5b d8 44 07&nbsp;=0A...=
.......$.j[.D.<br>=0A&nbsp; 0010: 3a e8 13 4e 0f =0A06=0A00&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;=0A:..N...<br>=0A&gt; HCI Event: Connect Complete (0x03) plen 11<br>=
=0A&nbsp; 0000: 00 01 00 98 01 bb 1c 12&nbsp; 00 01=0A00&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;=0A...........<br>=0A&gt; HCI Event: Command Status (0x0f) plen 4<br>=0A&=
nbsp; 0000: 00 02 00=0A00&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;=0A....<br>=0A&lt; HCI Command: Write Link Poli=
cy Settings (0x02|0x000d) plen 4<br>=0A&nbsp; 0000: 01 00 0f =0A00&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=0A...=
..<br>=0A&gt; HCI Event: Max Slots Change (0x1b) plen 3<br>=0A&nbsp; 0000: 0=
1 00=0A05&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=0A...<br>=0A&gt; HCI Event: Command Complete=
 (0x0e) plen 6<br>=0A&nbsp; 0000: 02 0d 08 00 01=0A00&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;=0A......<br>=0A<b><span style=3D"font-weight: bold;">&=
lt; HCI Command: Add SCO Connection=0A(0x01|0x0007) plen 4<br>=0A&nbsp; 000=
0: 01 00 a0=0A00&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;=0A....<br>=0A&gt; HCI Event: Command Complete (0x0e) pl=
en 4<br>=0A&nbsp; 0000: 02 07 04=0A01&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=0A....<br>=0A</span></b>&lt; HCI C=
ommand: Remote Name Request (0x01|0x0019) plen 10<br>=0A&nbsp; 0000: 98 01 =
bb 1c 12 00 02 00&nbsp; 00 00&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=0A....=
.......<br>=0A&gt; HCI Event: Command Status (0x0f) plen 4<br>=0A&nbsp; 0000=
: 00 01 19=0A04&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;=0A....<br>=0A&gt; HCI Event: Remote Name Req Complete (0=
x07) plen 255<br>=0A&nbsp; 0000: 00 98 01 bb 1c 12 00 50&nbsp; 61 72 72=0A =
6f 74 20 4d 4b&nbsp; .......Parrot=0AMK<br>=0A&nbsp; 0010: 36 30 30 30 76 3=
1 2e 30&nbsp; 31 63 00 00 00 00 00 00&nbsp;=0A6000v1.01c......<br>=0A&nbsp;=
 0020: 00 00 00 00 00 00 00 00&nbsp; 00 00 00 00 00 00 00 00&nbsp;=0A......=
...........<br>=0A&nbsp; 0030: 00 00 00 00 00 00 00 00&nbsp; 00 00 00 00 00 =
00 00 00&nbsp;=0A................<br>=0A&nbsp; 0040: 00 00 00 00 00 00 00 0=
0&nbsp; 00 00 00 00 00 00 00 00&nbsp;=0A................<br>=0A&nbsp; 0050:=
 00 00 00 00 00 00 00 00&nbsp; 00 00 00 00 00 00 00 00&nbsp;=0A............=
.....<br>=0A&nbsp; 0060: 00 00 00 00 00 00 00 00&nbsp; 00 00 00 00 00 00 00 =
00&nbsp;=0A................<br>=0A&nbsp; 0070: 00 00 00 00 00 00 00 00&nbsp=
; 00 00 00 00 00 00 00 00&nbsp;=0A................<br>=0A&nbsp; 0080: 00 00=
 00 00 00 00 00 00&nbsp; 00 00 00 00 00 00 00 00&nbsp;=0A................<b=
r>=0A&nbsp; 0090: 00 00 00 00 00 00 00 00&nbsp; 00 00 00 00 00 00 00 00&nbs=
p;=0A................<br>=0A&nbsp; 00a0: 00 00 00 00 00 00 00 00&nbsp; 00 0=
0 00 00 00 00 00 00&nbsp;=0A................<br>=0A&nbsp; 00b0: 00 00 00 00=
 00 00 00 00&nbsp; 00 00 00 00 00 00 00 00&nbsp;=0A................<br>=0A&=
nbsp; 00c0: 00 00 00 00 00 00 00 00&nbsp; 00 00 00 00 00 00 00 00&nbsp;=0A.=
................<br>=0A&nbsp; 00d0: 00 00 00 00 00 00 00 00&nbsp; 00 00 00 0=
0 00 00 00 00&nbsp;=0A................<br>=0A&nbsp; 00e0: 00 00 00 00 00 00=
 00 00&nbsp; 00 00 00 00 00 00 00 00&nbsp;=0A................<br>=0A&nbsp; =
00f0: 00 00 00 00 00 00 00 00&nbsp; 00 00 00 00 00 00=0A00&nbsp;&nbsp;&nbsp=
;&nbsp; ...............<br>=0A&gt; HCI Event: Command Status (0x0f) plen 4<=
br>=0A&nbsp; 0000: 00 02 00=0A00&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=0A....<br>=0A&lt; HCI Command: Read Rem=
ote Version Information (0x01|0x001d) plen 2<br>=0A&nbsp; 0000: 01=0A00&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=0A..<br>=0A&gt; HCI Event: Command Stat=
us (0x0f) plen 4<br>=0A&nbsp; 0000: 00 01 1d=0A04&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=0A....<br>=0A&gt; HCI =
Event: Read Remote Ver Info Complete (0x0c) plen 8<br>=0A&nbsp; 0000: 00 01=
 00 02 43 00 1c=0A01&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;=0A....C...<br>=0A&gt; HCI Event: Command Status =
(0x0f) plen 4<br>=0A&nbsp; 0000: 00 02 00=0A00&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=0A....<br>=0A<b><span sty=
le=3D"font-weight: bold;">scotest[104]: Can't connect: Connection timed=0Ao=
ut (110)</span></b><br>=0A<br>=0A</span></font><span lang=3D"EN-GB"></span>=
</p> =0A=0A<p class=3D"MsoNormal"><font face=3D"Arial" size=3D"2"><span sty=
le=3D"font-size: 10pt; font-family: Arial;" lang=3D"EN-GB">It seems that th=
e only reply to the Add SCO=0AConnection command is an unexpected Command C=
omplete event and than the=0Aconnect() system call fails with a timeout (40=
sec) error.</span></font></p> =0A=0A<p class=3D"MsoNormal"><font face=3D"Ar=
ial" size=3D"2"><span style=3D"font-size: 10pt; font-family: Arial;" lang=
=3D"EN-GB">As far as I know the only possible replies to the Add=0ASCO Conn=
ection &nbsp;command should be the Command Status event and the Command Com=
plete=0Aevent.</span></font></p> =0A=0A<p class=3D"MsoNormal"><font face=3D=
"Arial" size=3D"2"><span style=3D"font-size: 10pt; font-family: Arial;" lan=
g=3D"EN-GB"> &nbsp;</span></font></p> =0A=0A<p class=3D"MsoNormal"><font fa=
ce=3D"Arial" size=3D"2"><span style=3D"font-size: 10pt; font-family: Arial;=
" lang=3D"EN-GB">Have you ever experienced this problem ? Any hints ?</span=
></font></p> =0A=0A<p class=3D"MsoNormal"><font face=3D"Arial" size=3D"2"><=
span style=3D"font-size: 10pt; font-family: Arial;" lang=3D"EN-GB"> &nbsp;<=
/span></font></p> =0A=0A<p class=3D"MsoNormal"><font face=3D"Arial" size=3D=
"2"><span style=3D"font-size: 10pt; font-family: Arial;" lang=3D"EN-GB">Tha=
nk you a lot in advance,</span></font></p> =0A=0A<p class=3D"MsoNormal"><fo=
nt face=3D"Arial" size=3D"2"><span style=3D"font-size: 10pt; font-family: A=
rial;" lang=3D"EN-GB">Andrea Bondavalli</span></font></p> =0A=0A<p class=3D=
"MsoNormal"><font face=3D"Arial" size=3D"2"><span style=3D"font-size: 10pt;=
 font-family: Arial;" lang=3D"EN-GB"> &nbsp;</span></font></p> =0A=0A<p cla=
ss=3D"MsoNormal"><font face=3D"Arial" size=3D"2"><span style=3D"font-size: =
10pt; font-family: Arial;" lang=3D"EN-GB"> &nbsp;</span></font></p> =0A=0A<=
/div>=0A=0A<!-- kill --><div><br><br>-----Inline Attachment Follows-----<br=
><br>----------------------------------------------------------------------=
---<br>This =0ASF.net =0Aemail =0Ais =0Asponsored =0Aby: =0AMicrosoft<br>De=
fy =0Aall =0Achallenges. =0AMicrosoft(R) =0AVisual =0AStudio =0A2008.<br><a=
 href=3D"http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/" target=3D=
"_blank">http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/</a></div><=
!-- kill --><div><br><br>-----Inline Attachment Follows-----<br><br>_______=
________________________________________<br>Bluez-users =0Amailing =0Alist<=
br><a ymailto=3D"mailto:Bluez-users@lists.sourceforge.net" href=3D"mailto:B=
luez-users@lists.sourceforge.net">Bluez-users@lists.sourceforge.net</a><br>=
<a href=3D"https://lists.sourceforge.net/lists/listinfo/bluez-users" target=
=3D"_blank">https://lists.sourceforge.net/lists/listinfo/bluez-users</a><br=
></div></div><br></div></div></div><br>=0A=0A=0A      <!--5--><hr size=3D1>=
</hr> Now you can chat without downloading messenger. <a href=3D"http://in.=
rd.yahoo.com/tagline_webmessenger_5/*http://in.messenger.yahoo.com/webmesse=
ngerpromo.php">Click here</a> to know how.</body></html>
--0-773819792-1204169087=:33243--



--===============1369351274==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
--===============1369351274==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

--===============1369351274==--
