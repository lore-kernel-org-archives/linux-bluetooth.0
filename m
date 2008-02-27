Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Date: Wed, 27 Feb 2008 16:14:09 +0100
Message-ID: <B8ACF3CFC539C84FB73B6E53E8A21F4834EB62@qtmsrv01.HQ.qtm.it>
From: "Andrea Bondavalli" <Andrea.Bondavalli@qtm.it>
To: <Bluez-users@lists.sourceforge.net>
Subject: [Bluez-users] BT headset doesn't work: SCO connection timeout
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============0485740310=="
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

This is a multi-part message in MIME format.

--===============0485740310==
Content-class: urn:content-classes:message
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C87953.675599AE"

This is a multi-part message in MIME format.

------_=_NextPart_001_01C87953.675599AE
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Dear all,

=20

I've got a linux kernel 2.4.20 with bluez libs/utils 3.23 on a ARM linux
platform.

=20

I can successfully ping and pair my headset, but I am not able to
connect a SCO channel.

As soon as I try to connect a SCO channel (using the scotest utility,
and also other applications) the call always fails with a timeout error.

=20

Here are some useful  traces:

=20

# hciconfig
hci0:   Type: UART
        BD Address: 00:80:E1:00:AB:BA ACL MTU: 1021:4 SCO MTU: 64:0
        UP RUNNING PSCAN ISCAN
        RX bytes:10150 acl:204 sco:0 events:326 errors:0
        TX bytes:4097 acl:168 sco:0 commands:81 errors:0

=20

# hciconfig hci0 revision

  STLC2500 R4.2 12102005 12:40:14 ZAV100012  A7
        HW Id=3D V440BAA

=20

# hciconfig hci0 version
hci0:   Type: UART
        BD Address: 00:80:E1:00:AB:BA ACL MTU: 1021:4 SCO MTU: 64:0
        HCI Ver: 2.0 (0x3) HCI Rev: 0x402 LMP Ver: 2.0 (0x3) LMP Subver:
0x520
        Manufacturer: ST Microelectronics (48) =20
--------------------------------------------------------------------

Ping output is OK:

=20

# passkey-agent 0000 00:12:1C:BB:01:98 &
# l2ping 00:12:1C:BB:01:98
Passkey request for device 00:12:1C:BB:01:98
Passkey service has been released
Ping: 00:12:1C:BB:01:98 from 00:80:E1:00:AB:BA (data size 44) ...
0 bytes from 00:12:1C:BB:01:98 id 0 time 101.29ms
0 bytes from 00:12:1C:BB:01:98 id 1 time 48.42ms
0 bytes from 00:12:1C:BB:01:98 id 2 time 52.15ms
0 bytes from 00:12:1C:BB:01:98 id 3 time 36.95ms
0 bytes from 00:12:1C:BB:01:98 id 4 time 60.60ms
0 bytes from 00:12:1C:BB:01:98 id 5 time 43.05ms
0 bytes from 00:12:1C:BB:01:98 id 6 time 48.42ms
0 bytes from 00:12:1C:BB:01:98 id 7 time 96.63ms
0 bytes from 00:12:1C:BB:01:98 id 8 time 60.66ms
0 bytes from 00:12:1C:BB:01:98 id 9 time 62.69ms
0 bytes from 00:12:1C:BB:01:98 id 10 time 41.35ms
11 sent, 11 received, 0% loss

=20

=20

--------------------------------------------------------------------

scotest (from bluez-utils-3.23) output

=20

# hcidump -X
HCI sniffer - Bluetooth packet analyzer ver 1.40
device: hci0 snap_len: 1028 filter: 0xffffffff

# passkey-agent 0000 00:12:1C:BB:01:98 &

# scotest -s 00:12:1C:BB:01:98 &

=20

< HCI Command: Create Connection (0x01|0x0005) plen 13
  0000: 98 01 bb 1c 12 00 18 cc  02 00 00 00 01           .............
> HCI Event: Command Status (0x0f) plen 4
  0000: 00 01 05 04                                       ....
> HCI Event: Role Change (0x12) plen 8
  0000: 00 98 01 bb 1c 12 00 01                           ........
> HCI Event: Link Key Request (0x17) plen 6
  0000: 98 01 bb 1c 12 00                                 ......
< HCI Command: Link Key Request Negative Reply (0x01|0x000c) plen 6
  0000: 98 01 bb 1c 12 00                                 ......
> HCI Event: Command Complete (0x0e) plen 10
  0000: 01 0c 04 00 98 01 bb 1c  12 00                    ..........
> HCI Event: PIN Code Request (0x16) plen 6
  0000: 98 01 bb 1c 12 00                                 ......
Passkey request for device 00:12:1C:BB:01:98
< HCI Command: PIN Code Request Reply (0x01|0x000d) plen 23
  0000: 98 01 bb 1c 12 00 04 30  30 30 30 00 00 00 00 00
.......0000.....
  0010: 00 00 00 00 00 00 00                              .......
Passkey service has been released
> HCI Event: Command Complete (0x0e) plen 10
  0000: 01 0d 04 00 98 01 bb 1c  12 00                    ..........
> HCI Event: Link Key Notification (0x18) plen 23
  0000: 98 01 bb 1c 12 00 11 a5  89 24 9a 6a 5b d8 44 07
.........$.j[.D.
  0010: 3a e8 13 4e 0f 06 00                              :..N...
> HCI Event: Connect Complete (0x03) plen 11
  0000: 00 01 00 98 01 bb 1c 12  00 01 00                 ...........
> HCI Event: Command Status (0x0f) plen 4
  0000: 00 02 00 00                                       ....
< HCI Command: Write Link Policy Settings (0x02|0x000d) plen 4
  0000: 01 00 0f 00                                       ....
> HCI Event: Max Slots Change (0x1b) plen 3
  0000: 01 00 05                                          ...
> HCI Event: Command Complete (0x0e) plen 6
  0000: 02 0d 08 00 01 00                                 ......
< HCI Command: Add SCO Connection (0x01|0x0007) plen 4
  0000: 01 00 a0 00                                       ....
> HCI Event: Command Complete (0x0e) plen 4
  0000: 02 07 04 01                                       ....
< HCI Command: Remote Name Request (0x01|0x0019) plen 10
  0000: 98 01 bb 1c 12 00 02 00  00 00                    ..........
> HCI Event: Command Status (0x0f) plen 4
  0000: 00 01 19 04                                       ....
> HCI Event: Remote Name Req Complete (0x07) plen 255
  0000: 00 98 01 bb 1c 12 00 50  61 72 72 6f 74 20 4d 4b  .......Parrot
MK
  0010: 36 30 30 30 76 31 2e 30  31 63 00 00 00 00 00 00
6000v1.01c......
  0020: 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00
................
  0030: 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00
................
  0040: 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00
................
  0050: 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00
................
  0060: 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00
................
  0070: 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00
................
  0080: 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00
................
  0090: 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00
................
  00a0: 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00
................
  00b0: 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00
................
  00c0: 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00
................
  00d0: 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00
................
  00e0: 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00 00
................
  00f0: 00 00 00 00 00 00 00 00  00 00 00 00 00 00 00
...............
> HCI Event: Command Status (0x0f) plen 4
  0000: 00 02 00 00                                       ....
< HCI Command: Read Remote Version Information (0x01|0x001d) plen 2
  0000: 01 00                                             ..
> HCI Event: Command Status (0x0f) plen 4
  0000: 00 01 1d 04                                       ....
> HCI Event: Read Remote Ver Info Complete (0x0c) plen 8
  0000: 00 01 00 02 43 00 1c 01                           ....C...
> HCI Event: Command Status (0x0f) plen 4
  0000: 00 02 00 00                                       ....
scotest[104]: Can't connect: Connection timed out (110)



It seems that the only reply to the Add SCO Connection command is an
unexpected Command Complete event and than the connect() system call
fails with a timeout (40sec) error.

As far as I know the only possible replies to the Add SCO Connection
command should be the Command Status event and the Command Complete
event.

=20

Have you ever experienced this problem ? Any hints ?

=20

Thank you a lot in advance,

Andrea Bondavalli

=20

=20


------_=_NextPart_001_01C87953.675599AE
Content-Type: text/html;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<html xmlns:o=3D"urn:schemas-microsoft-com:office:office" =
xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:st1=3D"urn:schemas-microsoft-com:office:smarttags" =
xmlns=3D"http://www.w3.org/TR/REC-html40">

<head>
<META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; =
charset=3Dus-ascii">
<meta name=3DGenerator content=3D"Microsoft Word 11 (filtered medium)">
<o:SmartTagType =
namespaceuri=3D"urn:schemas-microsoft-com:office:smarttags"
 name=3D"place"/>
<o:SmartTagType =
namespaceuri=3D"urn:schemas-microsoft-com:office:smarttags"
 name=3D"metricconverter"/>
<!--[if !mso]>
<style>
st1\:*{behavior:url(#default#ieooui) }
</style>
<![endif]-->
<style>
<!--
 /* Style Definitions */
 p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0cm;
	margin-bottom:.0001pt;
	font-size:12.0pt;
	font-family:"Times New Roman";}
a:link, span.MsoHyperlink
	{color:blue;
	text-decoration:underline;}
a:visited, span.MsoHyperlinkFollowed
	{color:purple;
	text-decoration:underline;}
span.StileMessaggioDiPostaElettronica17
	{mso-style-type:personal-compose;
	font-family:Arial;
	color:windowtext;}
@page Section1
	{size:595.3pt 841.9pt;
	margin:70.85pt 2.0cm 2.0cm 2.0cm;}
div.Section1
	{page:Section1;}
-->
</style>

</head>

<body lang=3DIT link=3Dblue vlink=3Dpurple>

<div class=3DSection1>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-GB =
style=3D'font-size:
10.0pt;font-family:Arial'>Dear all,<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-GB =
style=3D'font-size:
10.0pt;font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-GB =
style=3D'font-size:
10.0pt;font-family:Arial'>I&#8217;ve got a linux kernel 2.4.20 with =
bluez
libs/utils 3.23 on a ARM linux platform.<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-GB =
style=3D'font-size:
10.0pt;font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-GB =
style=3D'font-size:
10.0pt;font-family:Arial'>I can successfully ping and pair my headset, =
but I am
not able to connect a SCO channel.<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-GB =
style=3D'font-size:
10.0pt;font-family:Arial'>As soon as I try to connect a SCO channel =
(using the
scotest utility, and also other applications) the call always fails with =
a timeout
error.<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-GB =
style=3D'font-size:
10.0pt;font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-GB =
style=3D'font-size:
10.0pt;font-family:Arial'>Here are some useful =
&nbsp;traces:<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-GB =
style=3D'font-size:
10.0pt;font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><b><font size=3D2 face=3DArial><span lang=3DEN-GB
style=3D'font-size:10.0pt;font-family:Arial;font-weight:bold'># =
hciconfig</span></font></b><font
size=3D2 face=3DArial><span lang=3DEN-GB =
style=3D'font-size:10.0pt;font-family:Arial'><br>
hci0:&nbsp;&nbsp; Type: UART<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; BD Address: 00:80:E1:00:AB:BA =
ACL
MTU: 1021:4 SCO MTU: 64:0<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; UP RUNNING PSCAN ISCAN<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; RX bytes:10150 acl:204 sco:0
events:326 errors:0<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; TX bytes:4097 acl:168 sco:0
commands:81 errors:0<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-GB =
style=3D'font-size:
10.0pt;font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><b><font size=3D2 face=3DArial><span lang=3DEN-GB
style=3D'font-size:10.0pt;font-family:Arial;font-weight:bold'># =
hciconfig hci0
revision</span></font></b><b><span lang=3DEN-GB =
style=3D'font-weight:bold'><o:p></o:p></span></b></p>

<p class=3DMsoNormal><font size=3D3 face=3D"Times New Roman"><span =
lang=3DEN-GB
style=3D'font-size:12.0pt'>&nbsp;</span></font><font size=3D2 =
face=3DArial><span
lang=3DEN-GB style=3D'font-size:10.0pt;font-family:Arial'>&nbsp;STLC2500 =
R4.2
12102005 12:40:14 ZAV100012&nbsp; A7<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; HW Id=3D =
V440BAA<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-GB =
style=3D'font-size:
10.0pt;font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><b><font size=3D2 face=3DArial><span lang=3DEN-GB
style=3D'font-size:10.0pt;font-family:Arial;font-weight:bold'># =
hciconfig hci0
version</span></font></b><font size=3D2 face=3DArial><span lang=3DEN-GB
style=3D'font-size:10.0pt;font-family:Arial'><br>
hci0:&nbsp;&nbsp; Type: UART<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; BD Address: 00:80:E1:00:AB:BA =
ACL
MTU: 1021:4 SCO MTU: 64:0<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; HCI Ver: 2.0 (0x3) HCI Rev: =
0x402
LMP Ver: 2.0 (0x3) LMP Subver: 0x520<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Manufacturer: ST =
Microelectronics
(48)&nbsp;&nbsp;<br>
--------------------------------------------------------------------<o:p>=
</o:p></span></font></p>

<p class=3DMsoNormal><st1:place w:st=3D"on"><font size=3D2 =
face=3DArial><span
 lang=3DEN-GB =
style=3D'font-size:10.0pt;font-family:Arial'>Ping</span></font></st1:plac=
e><font
size=3D2 face=3DArial><span lang=3DEN-GB =
style=3D'font-size:10.0pt;font-family:Arial'>
output is OK:<o:p></o:p></span></font></p>

<p class=3DMsoNormal><b><font size=3D2 face=3DArial><span lang=3DEN-GB
style=3D'font-size:10.0pt;font-family:Arial;font-weight:bold'><o:p>&nbsp;=
</o:p></span></font></b></p>

<p class=3DMsoNormal><b><font size=3D2 face=3DArial><span lang=3DEN-GB
style=3D'font-size:10.0pt;font-family:Arial;font-weight:bold'># =
passkey-agent
0000 00:12:1C:BB:01:98 &amp;<br>
# l2ping 00:12:1C:BB:01:98</span></font></b><font size=3D2 =
face=3DArial><span
lang=3DEN-GB style=3D'font-size:10.0pt;font-family:Arial'><br>
Passkey request for device 00:12:1C:BB:01:98<br>
Passkey service has been released<br>
<st1:place w:st=3D"on">Ping</st1:place>: 00:12:1C:BB:01:98 from =
00:80:E1:00:AB:BA
(data size 44) ...<br>
0 bytes from 00:12:1C:BB:01:98 id 0 time 101.29ms<br>
0 bytes from 00:12:1C:BB:01:98 id 1 time 48.42ms<br>
0 bytes from 00:12:1C:BB:01:98 id 2 time 52.15ms<br>
0 bytes from 00:12:1C:BB:01:98 id 3 time 36.95ms<br>
0 bytes from 00:12:1C:BB:01:98 id 4 time 60.60ms<br>
0 bytes from 00:12:1C:BB:01:98 id 5 time 43.05ms<br>
0 bytes from 00:12:1C:BB:01:98 id 6 time 48.42ms<br>
0 bytes from 00:12:1C:BB:01:98 id 7 time 96.63ms<br>
0 bytes from 00:12:1C:BB:01:98 id 8 time 60.66ms<br>
0 bytes from 00:12:1C:BB:01:98 id 9 time 62.69ms<br>
0 bytes from 00:12:1C:BB:01:98 id 10 time 41.35ms<br>
11 sent, 11 received, 0% loss<b><span =
style=3D'font-weight:bold'><o:p></o:p></span></b></span></font></p>

<p class=3DMsoNormal><b><font size=3D2 face=3DArial><span lang=3DEN-GB
style=3D'font-size:10.0pt;font-family:Arial;font-weight:bold'><o:p>&nbsp;=
</o:p></span></font></b></p>

<p class=3DMsoNormal><b><font size=3D2 face=3DArial><span lang=3DEN-GB
style=3D'font-size:10.0pt;font-family:Arial;font-weight:bold'><o:p>&nbsp;=
</o:p></span></font></b></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-GB =
style=3D'font-size:
10.0pt;font-family:Arial'>-----------------------------------------------=
---------------------<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-GB =
style=3D'font-size:
10.0pt;font-family:Arial'>scotest (from bluez-utils-3.23) =
output<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-GB =
style=3D'font-size:
10.0pt;font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><b><font size=3D2 face=3DArial><span lang=3DEN-GB
style=3D'font-size:10.0pt;font-family:Arial;font-weight:bold'># hcidump =
-X</span></font></b><font
size=3D2 face=3DArial><span lang=3DEN-GB =
style=3D'font-size:10.0pt;font-family:Arial'><br>
HCI sniffer - Bluetooth packet analyzer ver 1.40<br>
device: hci0 snap_len: 1028 filter: =
0xffffffff<o:p></o:p></span></font></p>

<p class=3DMsoNormal><b><font size=3D2 face=3DArial><span lang=3DEN-GB
style=3D'font-size:10.0pt;font-family:Arial;font-weight:bold'># =
passkey-agent
0000 00:12:1C:BB:01:98 &amp;</span></font></b><font size=3D2 =
face=3DArial><span
lang=3DEN-GB =
style=3D'font-size:10.0pt;font-family:Arial'><o:p></o:p></span></font></p=
>

<p class=3DMsoNormal><b><font size=3D2 face=3DArial><span lang=3DEN-GB
style=3D'font-size:10.0pt;font-family:Arial;font-weight:bold'># scotest =
-s
00:12:1C:BB:01:98 &amp;</span></font></b><b><span lang=3DEN-GB =
style=3D'font-weight:
bold'><o:p></o:p></span></b></p>

<p class=3DMsoNormal><b><font size=3D3 face=3D"Times New Roman"><span =
lang=3DEN-GB
style=3D'font-size:12.0pt;font-weight:bold'>&nbsp;<o:p></o:p></span></fon=
t></b></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-GB =
style=3D'font-size:
10.0pt;font-family:Arial'>&lt; HCI Command: Create Connection =
(0x01|0x0005)
plen 13<br>
&nbsp; 0000: 98 01 bb 1c 12 00 18 cc&nbsp; 02 00 00 00
01&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
.............<br>
&gt; HCI Event: Command Status (0x0f) plen 4<br>
&nbsp; 0000: 00 01 05
04&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;
....<br>
&gt; HCI Event: Role Change (0x12) plen 8<br>
&nbsp; 0000: 00 98 01 bb 1c 12 00
01&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;
........<br>
&gt; HCI Event: Link Key Request (0x17) plen 6<br>
&nbsp; 0000: 98 01 bb 1c 12
00&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
......<br>
&lt; HCI Command: Link Key Request Negative Reply (0x01|0x000c) plen =
6<br>
&nbsp; 0000: 98 01 bb 1c 12
00&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
......<br>
&gt; HCI Event: Command Complete (0x0e) plen 10<br>
&nbsp; 0000: 01 0c 04 00 98 01 bb 1c&nbsp; 12
00&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
..........<br>
&gt; HCI Event: PIN Code Request (0x16) plen 6<br>
&nbsp; 0000: 98 01 bb 1c 12
00&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
......<br>
Passkey request for device 00:12:1C:BB:01:98<br>
&lt; HCI Command: PIN Code Request Reply (0x01|0x000d) plen 23<br>
&nbsp; 0000: 98 01 bb 1c 12 00 04 30&nbsp; 30 30 30 00 00 00 00 00&nbsp;
.......0000.....<br>
&nbsp; 0010: 00 00 00 00 00 00
00&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
.......<br>
Passkey service has been released<br>
&gt; HCI Event: Command Complete (0x0e) plen 10<br>
&nbsp; 0000: 01 0d 04 00 98 01 bb 1c&nbsp; 12
00&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
..........<br>
&gt; HCI Event: Link Key Notification (0x18) plen 23<br>
&nbsp; 0000: 98 01 bb 1c 12 00 11 a5&nbsp; 89 24 9a 6a 5b d8 44 07&nbsp;
.........$.j[.D.<br>
&nbsp; 0010: 3a e8 13 4e <st1:metricconverter ProductID=3D"0f" =
w:st=3D"on">0f</st1:metricconverter>
06
00&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
:..N...<br>
&gt; HCI Event: Connect Complete (0x03) plen 11<br>
&nbsp; 0000: 00 01 00 98 01 bb 1c 12&nbsp; 00 01
00&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;
...........<br>
&gt; HCI Event: Command Status (0x0f) plen 4<br>
&nbsp; 0000: 00 02 00
00&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;
....<br>
&lt; HCI Command: Write Link Policy Settings (0x02|0x000d) plen 4<br>
&nbsp; 0000: 01 00 <st1:metricconverter ProductID=3D"0f" =
w:st=3D"on">0f</st1:metricconverter>
00&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;
....<br>
&gt; HCI Event: Max Slots Change (0x1b) plen 3<br>
&nbsp; 0000: 01 00
05&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
...<br>
&gt; HCI Event: Command Complete (0x0e) plen 6<br>
&nbsp; 0000: 02 0d 08 00 01
00&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
......<br>
<b><span style=3D'font-weight:bold'>&lt; HCI Command: Add SCO Connection
(0x01|0x0007) plen 4<br>
&nbsp; 0000: 01 00 a0
00&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;
....<br>
&gt; HCI Event: Command Complete (0x0e) plen 4<br>
&nbsp; 0000: 02 07 04
01&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;
....<br>
</span></b>&lt; HCI Command: Remote Name Request (0x01|0x0019) plen =
10<br>
&nbsp; 0000: 98 01 bb 1c 12 00 02 00&nbsp; 00 =
00&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
..........<br>
&gt; HCI Event: Command Status (0x0f) plen 4<br>
&nbsp; 0000: 00 01 19
04&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;
....<br>
&gt; HCI Event: Remote Name Req Complete (0x07) plen 255<br>
&nbsp; 0000: 00 98 01 bb 1c 12 00 50&nbsp; 61 72 72 <st1:metricconverter
ProductID=3D"6f" w:st=3D"on">6f</st1:metricconverter> 74 20 4d 4b&nbsp; =
.......Parrot
MK<br>
&nbsp; 0010: 36 30 30 30 76 31 2e 30&nbsp; 31 63 00 00 00 00 00 00&nbsp;
6000v1.01c......<br>
&nbsp; 0020: 00 00 00 00 00 00 00 00&nbsp; 00 00 00 00 00 00 00 00&nbsp;
................<br>
&nbsp; 0030: 00 00 00 00 00 00 00 00&nbsp; 00 00 00 00 00 00 00 00&nbsp;
................<br>
&nbsp; 0040: 00 00 00 00 00 00 00 00&nbsp; 00 00 00 00 00 00 00 00&nbsp;
................<br>
&nbsp; 0050: 00 00 00 00 00 00 00 00&nbsp; 00 00 00 00 00 00 00 00&nbsp;
................<br>
&nbsp; 0060: 00 00 00 00 00 00 00 00&nbsp; 00 00 00 00 00 00 00 00&nbsp;
................<br>
&nbsp; 0070: 00 00 00 00 00 00 00 00&nbsp; 00 00 00 00 00 00 00 00&nbsp;
................<br>
&nbsp; 0080: 00 00 00 00 00 00 00 00&nbsp; 00 00 00 00 00 00 00 00&nbsp;
................<br>
&nbsp; 0090: 00 00 00 00 00 00 00 00&nbsp; 00 00 00 00 00 00 00 00&nbsp;
................<br>
&nbsp; 00a0: 00 00 00 00 00 00 00 00&nbsp; 00 00 00 00 00 00 00 00&nbsp;
................<br>
&nbsp; 00b0: 00 00 00 00 00 00 00 00&nbsp; 00 00 00 00 00 00 00 00&nbsp;
................<br>
&nbsp; 00c0: 00 00 00 00 00 00 00 00&nbsp; 00 00 00 00 00 00 00 00&nbsp;
................<br>
&nbsp; 00d0: 00 00 00 00 00 00 00 00&nbsp; 00 00 00 00 00 00 00 00&nbsp;
................<br>
&nbsp; 00e0: 00 00 00 00 00 00 00 00&nbsp; 00 00 00 00 00 00 00 00&nbsp;
................<br>
&nbsp; 00f0: 00 00 00 00 00 00 00 00&nbsp; 00 00 00 00 00 00
00&nbsp;&nbsp;&nbsp;&nbsp; ...............<br>
&gt; HCI Event: Command Status (0x0f) plen 4<br>
&nbsp; 0000: 00 02 00
00&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;
....<br>
&lt; HCI Command: Read Remote Version Information (0x01|0x001d) plen =
2<br>
&nbsp; 0000: 01
00&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
..<br>
&gt; HCI Event: Command Status (0x0f) plen 4<br>
&nbsp; 0000: 00 01 1d
04&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;
....<br>
&gt; HCI Event: Read Remote Ver Info Complete (0x0c) plen 8<br>
&nbsp; 0000: 00 01 00 02 43 00 1c
01&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;
....C...<br>
&gt; HCI Event: Command Status (0x0f) plen 4<br>
&nbsp; 0000: 00 02 00
00&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;&nbsp;
....<br>
<b><span style=3D'font-weight:bold'>scotest[104]: Can't connect: =
Connection timed
out (110)</span></b><br>
<br>
</span></font><span lang=3DEN-GB><o:p></o:p></span></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-GB =
style=3D'font-size:
10.0pt;font-family:Arial'>It seems that the only reply to the Add SCO
Connection command is an unexpected Command Complete event and than the
connect() system call fails with a timeout (40sec) =
error.<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-GB =
style=3D'font-size:
10.0pt;font-family:Arial'>As far as I know the only possible replies to =
the Add
SCO Connection &nbsp;command should be the Command Status event and the =
Command Complete
event.<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-GB =
style=3D'font-size:
10.0pt;font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-GB =
style=3D'font-size:
10.0pt;font-family:Arial'>Have you ever experienced this problem ? Any =
hints ?<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-GB =
style=3D'font-size:
10.0pt;font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-GB =
style=3D'font-size:
10.0pt;font-family:Arial'>Thank you a lot in =
advance,<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-GB =
style=3D'font-size:
10.0pt;font-family:Arial'>Andrea Bondavalli<o:p></o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-GB =
style=3D'font-size:
10.0pt;font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

<p class=3DMsoNormal><font size=3D2 face=3DArial><span lang=3DEN-GB =
style=3D'font-size:
10.0pt;font-family:Arial'><o:p>&nbsp;</o:p></span></font></p>

</div>

</body>

</html>

------_=_NextPart_001_01C87953.675599AE--


--===============0485740310==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
--===============0485740310==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

--===============0485740310==--
