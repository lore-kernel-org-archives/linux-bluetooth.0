Return-Path: <cyrus@holtmann.org>
From: "Pierre Savary" <pierre.savary@kerlink.fr>
To: "'BlueZ users'" <bluez-users@lists.sourceforge.net>
References: <005501c8e76e$bfbd1d40$3f3757c0$@savary@kerlink.fr>
	<BAY114-DS24A2B922C2792A07D58A2B18E0@phx.gbl>
In-Reply-To: <BAY114-DS24A2B922C2792A07D58A2B18E0@phx.gbl>
Date: Thu, 17 Jul 2008 09:27:10 +0200
Message-ID: <003301c8e7de$87a93b30$96fbb190$@savary@kerlink.fr>
MIME-Version: 1.0
Subject: Re: [Bluez-users] connection failed with bluez 3.30
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============0988431334=="
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

Il s'agit d'un message à parties multiples au format MIME.

--===============0988431334==
Content-Type: multipart/alternative;
	boundary="----=_NextPart_000_0034_01C8E7EF.4B320B30"
Content-Language: fr

Il s'agit d'un message à parties multiples au format MIME.

------=_NextPart_000_0034_01C8E7EF.4B320B30
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Here it=E2=80=99s my services :

[root@kap /root]$sdptool browse local

Browsing FF:FF:FF:00:00:00 ...

Service Name: Serial Port

Service Description:=20

Service Provider: xxxxxx

Service RecHandle: 0x10000

Service Class ID List:

  "Serial Port" (0x1101)

Protocol Descriptor List:

  "L2CAP" (0x0100)

  "RFCOMM" (0x0003)

    Channel: 7

Profile Descriptor List:

  "Serial Port" (0x1101)

    Version: 0x0100

=20

Service Name: Handsfree

Service Description:

Service Provider: xxxxxx

Service RecHandle: 0x10001

Service Class ID List:

  "Handsfree" (0x111e)

  "Generic Audio" (0x1203)

Protocol Descriptor List:

  "L2CAP" (0x0100)

  "RFCOMM" (0x0003)

    Channel: 3

Profile Descriptor List:

  "Handsfree" (0x111e)

    Version: 0x0101

=20

Service Name: Obex server

Service Description:

Service Provider: xxxxxx

Service RecHandle: 0x10002

Service Class ID List:

  "OBEX Object Push" (0x1105)

Protocol Descriptor List:

  "L2CAP" (0x0100)

  "RFCOMM" (0x0003)

    Channel: 5

  "OBEX" (0x0008)

Profile Descriptor List:

  "OBEX Object Push" (0x1105)

    Version: 0x0100

=20

Pierre

=20

De : bluez-users-bounces@lists.sourceforge.net =
[mailto:bluez-users-bounces@lists.sourceforge.net] De la part de shy
Envoy=C3=A9 : jeudi 17 juillet 2008 04:37
=C3=80 : 'BlueZ users'
Objet : Re: [Bluez-users] connection failed with bluez 3.30

=20

Hi,Pierre

>>From the log, your device can be connected, but something wrong with =
sdp. For sdp requested some attributes, but the response always was =
null:

> ACL data: handle 42 flags 0x02 dlen 17

    L2CAP(d): cid 0x0040 len 13 [psm 1]

        SDP SS Req: tid 0x1 len 0x8

          pat uuid-16 0x110b (AudioSink)

          max 65535

          cont 00

< ACL data: handle 42 flags 0x02 dlen 14

    L2CAP(d): cid 0x0040 len 10 [psm 1]

        SDP SS Rsp: tid 0x1 len 0x5

          count 0

          cont 00

I think you could check your services, whether you started them up or =
not.

Brs

Shi Buyun

=20

  _____ =20

From: bluez-users-bounces@lists.sourceforge.net =
[mailto:bluez-users-bounces@lists.sourceforge.net] On Behalf Of Pierre =
Savary
Sent: 2008=E5=B9=B47=E6=9C=8817=E6=97=A5 02:07
To: bluez-users@lists.sourceforge.net; BlueZ-Dev
Subject: [Bluez-users] connection failed with bluez 3.30

Hi all,

I updated my design (ARM9 + linux-2.6.23) with the bluez (libs and =
utils) 3.30-3. I also uptaded all the necessary libraries, dbus, =
etc=E2=80=A6 Since this update my nokia 6120, N95 and E60 cannot be =
connected=E2=80=A6 and it worked before (bluez 3.16). Some others phone =
work fine (all SonyEricsson, Nokia 6234).

Here the hcidump :

=20

[root@kap /root]$hcidump

HCI sniffer - Bluetooth packet analyzer ver 1.42

device: hci0 snap_len: 1028 filter: 0xffffffff

> HCI Event: Connect Request (0x04) plen 10

< HCI Command: Accept Connection Request (0x01|0x0009) plen 7

> HCI Event: Command Status (0x0f) plen 4

> HCI Event: Connect Complete (0x03) plen 11

< HCI Command: Read Remote Supported Features (0x01|0x001b) plen 2

> HCI Event: Page Scan Repetition Mode Change (0x20) plen 7

> HCI Event: Max Slots Change (0x1b) plen 3

> HCI Event: Command Status (0x0f) plen 4

> HCI Event: Command Status (0x0f) plen 4

< HCI Command: Write Link Policy Settings (0x02|0x000d) plen 4

> HCI Event: Command Complete (0x0e) plen 6

< HCI Command: Change Connection Packet Type (0x01|0x000f) plen 4

> HCI Event: Read Remote Supported Features (0x0b) plen 11

> ACL data: handle 42 flags 0x02 dlen 12

    L2CAP(s): Connect req: psm 1 scid 0x0040

< ACL data: handle 42 flags 0x02 dlen 16

    L2CAP(s): Connect rsp: dcid 0x0040 scid 0x0040 result 0 status 0

      Connection successful

> HCI Event: Number of Completed Packets (0x13) plen 5

> ACL data: handle 42 flags 0x02 dlen 10

    L2CAP(s): Info req: type 2

< ACL data: handle 42 flags 0x02 dlen 12

    L2CAP(s): Info rsp: type 2 result 1

      Not supported

> HCI Event: Command Status (0x0f) plen 4

< HCI Command: Remote Name Request (0x01|0x0019) plen 10

> HCI Event: Number of Completed Packets (0x13) plen 5

> HCI Event: Connection Packet Type Changed (0x1d) plen 5

> HCI Event: Command Status (0x0f) plen 4

> HCI Event: Remote Name Req Complete (0x07) plen 255

> ACL data: handle 42 flags 0x02 dlen 16

    L2CAP(s): Config req: dcid 0x0040 flags 0x00 clen 4

      MTU 65535

< ACL data: handle 42 flags 0x02 dlen 18

    L2CAP(s): Config rsp: scid 0x0040 flags 0x00 result 0 clen 4

      MTU 65535

< ACL data: handle 42 flags 0x02 dlen 12

    L2CAP(s): Config req: dcid 0x0040 flags 0x00 clen 0

> HCI Event: Number of Completed Packets (0x13) plen 5

> HCI Event: Number of Completed Packets (0x13) plen 5

> ACL data: handle 42 flags 0x02 dlen 18

    L2CAP(s): Config rsp: scid 0x0040 flags 0x00 result 0 clen 4

      MTU 672

> ACL data: handle 42 flags 0x02 dlen 17

    L2CAP(d): cid 0x0040 len 13 [psm 1]

        SDP SS Req: tid 0x1 len 0x8

          pat uuid-16 0x110b (AudioSink)

          max 65535

          cont 00

< ACL data: handle 42 flags 0x02 dlen 14

    L2CAP(d): cid 0x0040 len 10 [psm 1]

        SDP SS Rsp: tid 0x1 len 0x5

          count 0

          cont 00

> HCI Event: Number of Completed Packets (0x13) plen 5

> ACL data: handle 42 flags 0x02 dlen 17

    L2CAP(d): cid 0x0040 len 13 [psm 1]

        SDP SS Req: tid 0x2 len 0x8

          pat uuid-16 0x111e (Handsfree)

          max 65535

          cont 00

< ACL data: handle 42 flags 0x02 dlen 14

    L2CAP(d): cid 0x0040 len 10 [psm 1]

        SDP SS Rsp: tid 0x2 len 0x5

          count 0

          cont 00

> HCI Event: Number of Completed Packets (0x13) plen 5

> ACL data: handle 42 flags 0x02 dlen 17

    L2CAP(d): cid 0x0040 len 13 [psm 1]

        SDP SS Req: tid 0x3 len 0x8

          pat uuid-16 0x1108 (Headset)

          max 65535

          cont 00

< ACL data: handle 42 flags 0x02 dlen 14

    L2CAP(d): cid 0x0040 len 10 [psm 1]

        SDP SS Rsp: tid 0x3 len 0x5

          count 0

          cont 00

> HCI Event: Number of Completed Packets (0x13) plen 5

> ACL data: handle 42 flags 0x02 dlen 17

    L2CAP(d): cid 0x0040 len 13 [psm 1]

        SDP SS Req: tid 0x4 len 0x8

          pat uuid-16 0x110c (AVRemTarget)

          max 65535

          cont 00

< ACL data: handle 42 flags 0x02 dlen 14

    L2CAP(d): cid 0x0040 len 10 [psm 1]

        SDP SS Rsp: tid 0x4 len 0x5

          count 0

          cont 00

> HCI Event: Number of Completed Packets (0x13) plen 5

> ACL data: handle 42 flags 0x02 dlen 31

    L2CAP(d): cid 0x0040 len 27 [psm 1]

        SDP SS Req: tid 0x5 len 0x16

          pat uuid-128 00005555-0000-1000-8000-0002ee000001

          max 65535

          cont 00

< ACL data: handle 42 flags 0x02 dlen 14

    L2CAP(d): cid 0x0040 len 10 [psm 1]

        SDP SS Rsp: tid 0x5 len 0x5

          count 0

          cont 00

> HCI Event: Number of Completed Packets (0x13) plen 5

> ACL data: handle 42 flags 0x02 dlen 12

    L2CAP(s): Disconn req: dcid 0x0040 scid 0x0040

< ACL data: handle 42 flags 0x02 dlen 12

    L2CAP(s): Disconn rsp: dcid 0x0040 scid 0x0040

> HCI Event: Number of Completed Packets (0x13) plen 5

< HCI Command: Disconnect (0x01|0x0006) plen 3

> HCI Event: Command Status (0x0f) plen 4

> HCI Event: Disconn Complete (0x05) plen 4

=20

Thanks in advance for your help.

Best Regards

=20

Pierre


------=_NextPart_000_0034_01C8E7EF.4B320B30
Content-Type: text/html;
	charset="utf-8"
Content-Transfer-Encoding: quoted-printable

<META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; =
charset=3Dutf-8">
<html xmlns:v=3D"urn:schemas-microsoft-com:vml" =
xmlns:o=3D"urn:schemas-microsoft-com:office:office" =
xmlns:w=3D"urn:schemas-microsoft-com:office:word" =
xmlns:m=3D"http://schemas.microsoft.com/office/2004/12/omml" =
xmlns=3D"http://www.w3.org/TR/REC-html40">

<head>

<meta name=3DGenerator content=3D"Microsoft Word 12 (filtered medium)">
<!--[if !mso]>
<style>
v\:* {behavior:url(#default#VML);}
o\:* {behavior:url(#default#VML);}
w\:* {behavior:url(#default#VML);}
.shape {behavior:url(#default#VML);}
</style>
<![endif]-->
<style>
<!--
 /* Font Definitions */
 @font-face
	{font-family:SimSun;
	panose-1:2 1 6 0 3 1 1 1 1 1;}
@font-face
	{font-family:"Cambria Math";
	panose-1:2 4 5 3 5 4 6 3 2 4;}
@font-face
	{font-family:Calibri;
	panose-1:2 15 5 2 2 2 4 3 2 4;}
@font-face
	{font-family:Tahoma;
	panose-1:2 11 6 4 3 5 4 4 2 4;}
@font-face
	{font-family:"\@SimSun";
	panose-1:0 0 0 0 0 0 0 0 0 0;}
 /* Style Definitions */
 p.MsoNormal, li.MsoNormal, div.MsoNormal
	{margin:0cm;
	margin-bottom:.0001pt;
	font-size:11.0pt;
	font-family:"Calibri","sans-serif";}
a:link, span.MsoHyperlink
	{mso-style-priority:99;
	color:blue;
	text-decoration:underline;}
a:visited, span.MsoHyperlinkFollowed
	{mso-style-priority:99;
	color:purple;
	text-decoration:underline;}
span.EmailStyle17
	{mso-style-type:personal;
	font-family:"Calibri","sans-serif";
	color:windowtext;}
span.EmailStyle18
	{mso-style-type:personal;
	font-family:"Calibri","sans-serif";
	color:windowtext;}
span.EmailStyle19
	{mso-style-type:personal-reply;
	font-family:"Calibri","sans-serif";
	color:windowtext;}
.MsoChpDefault
	{mso-style-type:export-only;
	font-size:10.0pt;}
@page Section1
	{size:612.0pt 792.0pt;
	margin:70.85pt 70.85pt 70.85pt 70.85pt;}
div.Section1
	{page:Section1;}
-->
</style>
<!--[if gte mso 9]><xml>
 <o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
 <o:shapelayout v:ext=3D"edit">
  <o:idmap v:ext=3D"edit" data=3D"1" />
 </o:shapelayout></xml><![endif]-->
</head>

<body lang=3DFR link=3Dblue vlink=3Dpurple>

<div class=3DSection1>

<p class=3DMsoNormal><span lang=3DEN-US>Here it=E2=80=99s my =
services&nbsp;:<o:p></o:p></span></p>

<p class=3DMsoNormal><b><span lang=3DEN-US =
style=3D'font-size:10.0pt'>[root@kap
/root]$sdptool browse local<o:p></o:p></span></b></p>

<p class=3DMsoNormal><b><span lang=3DEN-US =
style=3D'font-size:10.0pt'>Browsing
FF:FF:FF:00:00:00 ...<o:p></o:p></span></b></p>

<p class=3DMsoNormal><b><span lang=3DEN-US =
style=3D'font-size:10.0pt'>Service Name: Serial
Port<o:p></o:p></span></b></p>

<p class=3DMsoNormal><b><span style=3D'font-size:10.0pt'>Service =
Description: <o:p></o:p></span></b></p>

<p class=3DMsoNormal><b><span lang=3DEN-US =
style=3D'font-size:10.0pt'>Service
Provider: xxxxxx<o:p></o:p></span></b></p>

<p class=3DMsoNormal><b><span lang=3DEN-US =
style=3D'font-size:10.0pt'>Service
RecHandle: 0x10000<o:p></o:p></span></b></p>

<p class=3DMsoNormal><b><span lang=3DEN-US =
style=3D'font-size:10.0pt'>Service Class
ID List:<o:p></o:p></span></b></p>

<p class=3DMsoNormal><b><span lang=3DEN-US =
style=3D'font-size:10.0pt'>&nbsp; </span></b><b><span
style=3D'font-size:10.0pt'>&quot;Serial Port&quot; =
(0x1101)<o:p></o:p></span></b></p>

<p class=3DMsoNormal><b><span style=3D'font-size:10.0pt'>Protocol =
Descriptor List:<o:p></o:p></span></b></p>

<p class=3DMsoNormal><b><span style=3D'font-size:10.0pt'>&nbsp; =
&quot;L2CAP&quot;
(0x0100)<o:p></o:p></span></b></p>

<p class=3DMsoNormal><b><span style=3D'font-size:10.0pt'>&nbsp; =
&quot;RFCOMM&quot;
(0x0003)<o:p></o:p></span></b></p>

<p class=3DMsoNormal><b><span =
style=3D'font-size:10.0pt'>&nbsp;&nbsp;&nbsp;
Channel: 7<o:p></o:p></span></b></p>

<p class=3DMsoNormal><b><span style=3D'font-size:10.0pt'>Profile =
Descriptor List:<o:p></o:p></span></b></p>

<p class=3DMsoNormal><b><span style=3D'font-size:10.0pt'>&nbsp; =
&quot;Serial
Port&quot; (0x1101)<o:p></o:p></span></b></p>

<p class=3DMsoNormal><b><span =
style=3D'font-size:10.0pt'>&nbsp;&nbsp;&nbsp;
Version: 0x0100<o:p></o:p></span></b></p>

<p class=3DMsoNormal><b><span =
style=3D'font-size:10.0pt'><o:p>&nbsp;</o:p></span></b></p>

<p class=3DMsoNormal><b><span lang=3DEN-US =
style=3D'font-size:10.0pt'>Service Name: =
Handsfree<o:p></o:p></span></b></p>

<p class=3DMsoNormal><b><span lang=3DEN-US =
style=3D'font-size:10.0pt'>Service
Description:<o:p></o:p></span></b></p>

<p class=3DMsoNormal><b><span lang=3DEN-US =
style=3D'font-size:10.0pt'>Service
Provider: xxxxxx<o:p></o:p></span></b></p>

<p class=3DMsoNormal><b><span lang=3DEN-US =
style=3D'font-size:10.0pt'>Service
RecHandle: 0x10001<o:p></o:p></span></b></p>

<p class=3DMsoNormal><b><span lang=3DEN-US =
style=3D'font-size:10.0pt'>Service Class
ID List:<o:p></o:p></span></b></p>

<p class=3DMsoNormal><b><span lang=3DEN-US =
style=3D'font-size:10.0pt'>&nbsp;
&quot;Handsfree&quot; (0x111e)<o:p></o:p></span></b></p>

<p class=3DMsoNormal><b><span lang=3DEN-US =
style=3D'font-size:10.0pt'>&nbsp;
&quot;Generic Audio&quot; (0x1203)<o:p></o:p></span></b></p>

<p class=3DMsoNormal><b><span style=3D'font-size:10.0pt'>Protocol =
Descriptor List:<o:p></o:p></span></b></p>

<p class=3DMsoNormal><b><span style=3D'font-size:10.0pt'>&nbsp; =
&quot;L2CAP&quot;
(0x0100)<o:p></o:p></span></b></p>

<p class=3DMsoNormal><b><span style=3D'font-size:10.0pt'>&nbsp; =
&quot;RFCOMM&quot;
(0x0003)<o:p></o:p></span></b></p>

<p class=3DMsoNormal><b><span =
style=3D'font-size:10.0pt'>&nbsp;&nbsp;&nbsp;
Channel: 3<o:p></o:p></span></b></p>

<p class=3DMsoNormal><b><span style=3D'font-size:10.0pt'>Profile =
Descriptor List:<o:p></o:p></span></b></p>

<p class=3DMsoNormal><b><span style=3D'font-size:10.0pt'>&nbsp;
&quot;Handsfree&quot; (0x111e)<o:p></o:p></span></b></p>

<p class=3DMsoNormal><b><span =
style=3D'font-size:10.0pt'>&nbsp;&nbsp;&nbsp;
Version: 0x0101<o:p></o:p></span></b></p>

<p class=3DMsoNormal><b><span =
style=3D'font-size:10.0pt'><o:p>&nbsp;</o:p></span></b></p>

<p class=3DMsoNormal><b><span style=3D'font-size:10.0pt'>Service Name: =
Obex server<o:p></o:p></span></b></p>

<p class=3DMsoNormal><b><span style=3D'font-size:10.0pt'>Service =
Description:<o:p></o:p></span></b></p>

<p class=3DMsoNormal><b><span lang=3DEN-US =
style=3D'font-size:10.0pt'>Service
Provider: xxxxxx<o:p></o:p></span></b></p>

<p class=3DMsoNormal><b><span lang=3DEN-US =
style=3D'font-size:10.0pt'>Service
RecHandle: 0x10002<o:p></o:p></span></b></p>

<p class=3DMsoNormal><b><span lang=3DEN-US =
style=3D'font-size:10.0pt'>Service Class
ID List:<o:p></o:p></span></b></p>

<p class=3DMsoNormal><b><span lang=3DEN-US =
style=3D'font-size:10.0pt'>&nbsp;
&quot;OBEX Object Push&quot; (0x1105)<o:p></o:p></span></b></p>

<p class=3DMsoNormal><b><span lang=3DEN-US =
style=3D'font-size:10.0pt'>Protocol
Descriptor List:<o:p></o:p></span></b></p>

<p class=3DMsoNormal><b><span lang=3DEN-US =
style=3D'font-size:10.0pt'>&nbsp;
&quot;L2CAP&quot; (0x0100)<o:p></o:p></span></b></p>

<p class=3DMsoNormal><b><span lang=3DEN-US =
style=3D'font-size:10.0pt'>&nbsp;
&quot;RFCOMM&quot; (0x0003)<o:p></o:p></span></b></p>

<p class=3DMsoNormal><b><span lang=3DEN-US =
style=3D'font-size:10.0pt'>&nbsp;&nbsp;&nbsp;
Channel: 5<o:p></o:p></span></b></p>

<p class=3DMsoNormal><b><span lang=3DEN-US =
style=3D'font-size:10.0pt'>&nbsp;
&quot;OBEX&quot; (0x0008)<o:p></o:p></span></b></p>

<p class=3DMsoNormal><b><span style=3D'font-size:10.0pt'>Profile =
Descriptor List:<o:p></o:p></span></b></p>

<p class=3DMsoNormal><b><span style=3D'font-size:10.0pt'>&nbsp; =
&quot;OBEX Object
Push&quot; (0x1105)<o:p></o:p></span></b></p>

<p class=3DMsoNormal><b><span =
style=3D'font-size:10.0pt'>&nbsp;&nbsp;&nbsp;
Version: 0x0100<o:p></o:p></span></b></p>

<p class=3DMsoNormal><o:p>&nbsp;</o:p></p>

<p class=3DMsoNormal>Pierre<o:p></o:p></p>

<p class=3DMsoNormal><o:p>&nbsp;</o:p></p>

<div>

<div style=3D'border:none;border-top:solid #B5C4DF 1.0pt;padding:3.0pt =
0cm 0cm 0cm'>

<p class=3DMsoNormal><b><span =
style=3D'font-size:10.0pt;font-family:"Tahoma","sans-serif"'>De&nbsp;:</s=
pan></b><span
style=3D'font-size:10.0pt;font-family:"Tahoma","sans-serif"'> =
bluez-users-bounces@lists.sourceforge.net
[mailto:bluez-users-bounces@lists.sourceforge.net] <b>De la part de</b> =
shy<br>
<b>Envoy=C3=A9&nbsp;:</b> jeudi 17 juillet 2008 04:37<br>
<b>&Agrave;&nbsp;:</b> 'BlueZ users'<br>
<b>Objet&nbsp;:</b> Re: [Bluez-users] connection failed with bluez =
3.30<o:p></o:p></span></p>

</div>

</div>

<p class=3DMsoNormal><o:p>&nbsp;</o:p></p>

<p class=3DMsoNormal><span =
style=3D'font-size:10.0pt;font-family:"SimSun","serif"'>Hi,</span><span
lang=3DEN-US =
style=3D'font-size:10.0pt;font-family:"SimSun","serif"'>Pierre</span><spa=
n
style=3D'font-size:12.0pt;font-family:"SimSun","serif"'><o:p></o:p></span=
></p>

<p class=3DMsoNormal><span lang=3DEN-US =
style=3D'font-size:10.0pt;font-family:"SimSun","serif"'>From
the log, your device can be connected, but something wrong with sdp. For =
sdp
requested some attributes, but the response always was null:</span><span
style=3D'font-size:12.0pt;font-family:"SimSun","serif"'><o:p></o:p></span=
></p>

<p class=3DMsoNormal><span lang=3DEN-US style=3D'font-size:10.0pt'>&gt; =
ACL data:
handle 42 flags 0x02 dlen 17<o:p></o:p></span></p>

<p class=3DMsoNormal><span lang=3DEN-US =
style=3D'font-size:10.0pt'>&nbsp;&nbsp;&nbsp;
L2CAP(d): cid 0x0040 len 13 [psm 1]<o:p></o:p></span></p>

<p class=3DMsoNormal><span lang=3DEN-US =
style=3D'font-size:10.0pt'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
SDP SS Req: tid 0x1 len 0x8<o:p></o:p></span></p>

<p class=3DMsoNormal><span lang=3DEN-US =
style=3D'font-size:10.0pt'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;
pat uuid-16 0x110b (AudioSink)<o:p></o:p></span></p>

<p class=3DMsoNormal><span lang=3DEN-US =
style=3D'font-size:10.0pt'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;
max 65535<o:p></o:p></span></p>

<p class=3DMsoNormal><span lang=3DEN-US =
style=3D'font-size:10.0pt'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;
cont 00</span><span lang=3DEN-US><o:p></o:p></span></p>

<p class=3DMsoNormal><span lang=3DEN-US style=3D'font-size:10.0pt'>&lt; =
ACL data:
handle 42 flags 0x02 dlen 14<o:p></o:p></span></p>

<p class=3DMsoNormal><span lang=3DEN-US =
style=3D'font-size:10.0pt'>&nbsp;&nbsp;&nbsp;
L2CAP(d): cid 0x0040 len 10 [psm 1]<o:p></o:p></span></p>

<p class=3DMsoNormal><span lang=3DEN-US =
style=3D'font-size:10.0pt'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
SDP SS Rsp: tid 0x1 len 0x5<o:p></o:p></span></p>

<p class=3DMsoNormal><span lang=3DEN-US =
style=3D'font-size:10.0pt'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;
count 0<o:p></o:p></span></p>

<p class=3DMsoNormal><span lang=3DEN-US =
style=3D'font-size:10.0pt'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;
cont 00</span><span lang=3DEN-US><o:p></o:p></span></p>

<p class=3DMsoNormal><span lang=3DEN-US style=3D'font-size:10.0pt'>I =
think you could
check your services, whether you started them up or =
not.<o:p></o:p></span></p>

<p class=3DMsoNormal><span lang=3DEN-US =
style=3D'font-size:10.0pt'>Brs<o:p></o:p></span></p>

<p class=3DMsoNormal><span lang=3DEN-US style=3D'font-size:10.0pt'>Shi =
Buyun<o:p></o:p></span></p>

<p class=3DMsoNormal><span =
style=3D'font-size:12.0pt;font-family:"SimSun","serif"'><o:p>&nbsp;</o:p>=
</span></p>

<div class=3DMsoNormal align=3Dcenter style=3D'text-align:center'><span =
lang=3DEN-US
style=3D'font-size:12.0pt;font-family:"SimSun","serif"'>

<hr size=3D2 width=3D"100%" align=3Dcenter>

</span></div>

<p class=3DMsoNormal style=3D'margin-bottom:12.0pt'><b><span =
lang=3DEN-US
style=3D'font-size:10.0pt;font-family:"Tahoma","sans-serif"'>From:</span>=
</b><span
lang=3DEN-US =
style=3D'font-size:10.0pt;font-family:"Tahoma","sans-serif"'>
bluez-users-bounces@lists.sourceforge.net
[mailto:bluez-users-bounces@lists.sourceforge.net] <b>On Behalf Of =
</b>Pierre
Savary<br>
<b>Sent:</b> 2008</span><span lang=3DZH-CN =
style=3D'font-size:10.0pt;font-family:
"SimSun","serif"'>=E5=B9=B4</span><span lang=3DEN-US =
style=3D'font-size:10.0pt;font-family:
"Tahoma","sans-serif"'>7</span><span lang=3DZH-CN =
style=3D'font-size:10.0pt;
font-family:"SimSun","serif"'>=E6=9C=88</span><span lang=3DEN-US =
style=3D'font-size:10.0pt;
font-family:"Tahoma","sans-serif"'>17</span><span lang=3DZH-CN =
style=3D'font-size:
10.0pt;font-family:"SimSun","serif"'>=E6=97=A5</span><span lang=3DEN-US =
style=3D'font-size:
10.0pt;font-family:"Tahoma","sans-serif"'> 02:07<br>
<b>To:</b> bluez-users@lists.sourceforge.net; BlueZ-Dev<br>
<b>Subject:</b> [Bluez-users] connection failed with bluez =
3.30</span><span
lang=3DEN-US =
style=3D'font-size:12.0pt;font-family:"SimSun","serif"'><o:p></o:p></span=
></p>

<p class=3DMsoNormal><span lang=3DEN-US>Hi all,<o:p></o:p></span></p>

<p class=3DMsoNormal><span lang=3DEN-US>I updated my design (ARM9 + =
linux-2.6.23)
with the bluez (libs and utils) 3.30-3. I also uptaded all the necessary
libraries, dbus, etc=E2=80=A6 Since this update my nokia 6120, N95 and =
E60 cannot be
connected=E2=80=A6 and it worked before (bluez 3.16). Some others phone =
work fine (all
SonyEricsson, Nokia 6234).<o:p></o:p></span></p>

<p class=3DMsoNormal><span lang=3DEN-US>Here the hcidump =
:<o:p></o:p></span></p>

<p class=3DMsoNormal><span lang=3DEN-US><o:p>&nbsp;</o:p></span></p>

<p class=3DMsoNormal><b><span lang=3DEN-US =
style=3D'font-size:10.0pt'>[root@kap
/root]$hcidump<o:p></o:p></span></b></p>

<p class=3DMsoNormal><b><span lang=3DEN-US =
style=3D'font-size:10.0pt'>HCI sniffer -
Bluetooth packet analyzer ver 1.42<o:p></o:p></span></b></p>

<p class=3DMsoNormal><b><span lang=3DEN-US =
style=3D'font-size:10.0pt'>device: hci0
snap_len: 1028 filter: 0xffffffff<o:p></o:p></span></b></p>

<p class=3DMsoNormal><b><span lang=3DEN-US =
style=3D'font-size:10.0pt'>&gt; HCI Event:
Connect Request (0x04) plen 10<o:p></o:p></span></b></p>

<p class=3DMsoNormal><b><span lang=3DEN-US =
style=3D'font-size:10.0pt'>&lt; HCI
Command: Accept Connection Request (0x01|0x0009) plen =
7<o:p></o:p></span></b></p>

<p class=3DMsoNormal><b><span lang=3DEN-US =
style=3D'font-size:10.0pt'>&gt; HCI Event:
Command Status (0x0f) plen 4<o:p></o:p></span></b></p>

<p class=3DMsoNormal><b><span lang=3DEN-US =
style=3D'font-size:10.0pt'>&gt; HCI Event:
Connect Complete (0x03) plen 11<o:p></o:p></span></b></p>

<p class=3DMsoNormal><b><span lang=3DEN-US =
style=3D'font-size:10.0pt'>&lt; HCI
Command: Read Remote Supported Features (0x01|0x001b) plen =
2<o:p></o:p></span></b></p>

<p class=3DMsoNormal><b><span style=3D'font-size:10.0pt'>&gt; HCI Event: =
Page Scan
Repetition Mode Change (0x20) plen 7<o:p></o:p></span></b></p>

<p class=3DMsoNormal><b><span lang=3DEN-US =
style=3D'font-size:10.0pt'>&gt; HCI Event:
Max Slots Change (0x1b) plen 3<o:p></o:p></span></b></p>

<p class=3DMsoNormal><b><span lang=3DEN-US =
style=3D'font-size:10.0pt'>&gt; HCI Event:
Command Status (0x0f) plen 4<o:p></o:p></span></b></p>

<p class=3DMsoNormal><b><span lang=3DEN-US =
style=3D'font-size:10.0pt'>&gt; HCI Event:
Command Status (0x0f) plen 4<o:p></o:p></span></b></p>

<p class=3DMsoNormal><b><span lang=3DEN-US =
style=3D'font-size:10.0pt'>&lt; HCI
Command: Write Link Policy Settings (0x02|0x000d) plen =
4<o:p></o:p></span></b></p>

<p class=3DMsoNormal><b><span lang=3DEN-US =
style=3D'font-size:10.0pt'>&gt; HCI Event:
Command Complete (0x0e) plen 6<o:p></o:p></span></b></p>

<p class=3DMsoNormal><b><span lang=3DEN-US =
style=3D'font-size:10.0pt'>&lt; HCI
Command: Change Connection Packet Type (0x01|0x000f) plen =
4<o:p></o:p></span></b></p>

<p class=3DMsoNormal><b><span lang=3DEN-US =
style=3D'font-size:10.0pt'>&gt; HCI Event:
Read Remote Supported Features (0x0b) plen 11<o:p></o:p></span></b></p>

<p class=3DMsoNormal><b><span lang=3DEN-US =
style=3D'font-size:10.0pt'>&gt; ACL data:
handle 42 flags 0x02 dlen 12<o:p></o:p></span></b></p>

<p class=3DMsoNormal><b><span lang=3DEN-US =
style=3D'font-size:10.0pt'>&nbsp;&nbsp;&nbsp;
L2CAP(s): Connect req: psm 1 scid 0x0040<o:p></o:p></span></b></p>

<p class=3DMsoNormal><b><span lang=3DEN-US =
style=3D'font-size:10.0pt'>&lt; ACL data:
handle 42 flags 0x02 dlen 16<o:p></o:p></span></b></p>

<p class=3DMsoNormal><b><span lang=3DEN-US =
style=3D'font-size:10.0pt'>&nbsp;&nbsp;&nbsp;
L2CAP(s): Connect rsp: dcid 0x0040 scid 0x0040 result 0 status =
0<o:p></o:p></span></b></p>

<p class=3DMsoNormal><b><span lang=3DEN-US =
style=3D'font-size:10.0pt'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
Connection successful<o:p></o:p></span></b></p>

<p class=3DMsoNormal><b><span lang=3DEN-US =
style=3D'font-size:10.0pt'>&gt; HCI Event:
Number of Completed Packets (0x13) plen 5<o:p></o:p></span></b></p>

<p class=3DMsoNormal><b><span lang=3DEN-US =
style=3D'font-size:10.0pt'>&gt; ACL data:
handle 42 flags 0x02 dlen 10<o:p></o:p></span></b></p>

<p class=3DMsoNormal><b><span lang=3DEN-US =
style=3D'font-size:10.0pt'>&nbsp;&nbsp;&nbsp;
L2CAP(s): Info req: type 2<o:p></o:p></span></b></p>

<p class=3DMsoNormal><b><span lang=3DEN-US =
style=3D'font-size:10.0pt'>&lt; ACL data:
handle 42 flags 0x02 dlen 12<o:p></o:p></span></b></p>

<p class=3DMsoNormal><b><span lang=3DEN-US =
style=3D'font-size:10.0pt'>&nbsp;&nbsp;&nbsp;
L2CAP(s): Info rsp: type 2 result 1<o:p></o:p></span></b></p>

<p class=3DMsoNormal><b><span lang=3DEN-US =
style=3D'font-size:10.0pt'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
Not supported<o:p></o:p></span></b></p>

<p class=3DMsoNormal><b><span lang=3DEN-US =
style=3D'font-size:10.0pt'>&gt; HCI Event:
Command Status (0x0f) plen 4<o:p></o:p></span></b></p>

<p class=3DMsoNormal><b><span lang=3DEN-US =
style=3D'font-size:10.0pt'>&lt; HCI
Command: Remote Name Request (0x01|0x0019) plen =
10<o:p></o:p></span></b></p>

<p class=3DMsoNormal><b><span lang=3DEN-US =
style=3D'font-size:10.0pt'>&gt; HCI Event:
Number of Completed Packets (0x13) plen 5<o:p></o:p></span></b></p>

<p class=3DMsoNormal><b><span lang=3DEN-US =
style=3D'font-size:10.0pt'>&gt; HCI Event:
Connection Packet Type Changed (0x1d) plen 5<o:p></o:p></span></b></p>

<p class=3DMsoNormal><b><span lang=3DEN-US =
style=3D'font-size:10.0pt'>&gt; HCI Event:
Command Status (0x0f) plen 4<o:p></o:p></span></b></p>

<p class=3DMsoNormal><b><span lang=3DEN-US =
style=3D'font-size:10.0pt'>&gt; HCI Event:
Remote Name Req Complete (0x07) plen 255<o:p></o:p></span></b></p>

<p class=3DMsoNormal><b><span lang=3DEN-US =
style=3D'font-size:10.0pt'>&gt; ACL data:
handle 42 flags 0x02 dlen 16<o:p></o:p></span></b></p>

<p class=3DMsoNormal><b><span lang=3DEN-US =
style=3D'font-size:10.0pt'>&nbsp;&nbsp;&nbsp;
L2CAP(s): Config req: dcid 0x0040 flags 0x00 clen =
4<o:p></o:p></span></b></p>

<p class=3DMsoNormal><b><span lang=3DEN-US =
style=3D'font-size:10.0pt'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
MTU 65535<o:p></o:p></span></b></p>

<p class=3DMsoNormal><b><span lang=3DEN-US =
style=3D'font-size:10.0pt'>&lt; ACL data:
handle 42 flags 0x02 dlen 18<o:p></o:p></span></b></p>

<p class=3DMsoNormal><b><span lang=3DEN-US =
style=3D'font-size:10.0pt'>&nbsp;&nbsp;&nbsp;
L2CAP(s): Config rsp: scid 0x0040 flags 0x00 result 0 clen =
4<o:p></o:p></span></b></p>

<p class=3DMsoNormal><b><span lang=3DEN-US =
style=3D'font-size:10.0pt'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
MTU 65535<o:p></o:p></span></b></p>

<p class=3DMsoNormal><b><span lang=3DEN-US =
style=3D'font-size:10.0pt'>&lt; ACL data:
handle 42 flags 0x02 dlen 12<o:p></o:p></span></b></p>

<p class=3DMsoNormal><b><span lang=3DEN-US =
style=3D'font-size:10.0pt'>&nbsp;&nbsp;&nbsp;
L2CAP(s): Config req: dcid 0x0040 flags 0x00 clen =
0<o:p></o:p></span></b></p>

<p class=3DMsoNormal><b><span lang=3DEN-US =
style=3D'font-size:10.0pt'>&gt; HCI Event:
Number of Completed Packets (0x13) plen 5<o:p></o:p></span></b></p>

<p class=3DMsoNormal><b><span lang=3DEN-US =
style=3D'font-size:10.0pt'>&gt; HCI Event:
Number of Completed Packets (0x13) plen 5<o:p></o:p></span></b></p>

<p class=3DMsoNormal><b><span lang=3DEN-US =
style=3D'font-size:10.0pt'>&gt; ACL data:
handle 42 flags 0x02 dlen 18<o:p></o:p></span></b></p>

<p class=3DMsoNormal><b><span lang=3DEN-US =
style=3D'font-size:10.0pt'>&nbsp;&nbsp;&nbsp;
L2CAP(s): Config rsp: scid 0x0040 flags 0x00 result 0 clen =
4<o:p></o:p></span></b></p>

<p class=3DMsoNormal><b><span lang=3DEN-US =
style=3D'font-size:10.0pt'>&nbsp;&nbsp;&nbsp;&nbsp;
&nbsp;MTU 672<o:p></o:p></span></b></p>

<p class=3DMsoNormal><b><span lang=3DEN-US =
style=3D'font-size:10.0pt'>&gt; ACL data:
handle 42 flags 0x02 dlen 17<o:p></o:p></span></b></p>

<p class=3DMsoNormal><b><span lang=3DEN-US =
style=3D'font-size:10.0pt'>&nbsp;&nbsp;&nbsp;
L2CAP(d): cid 0x0040 len 13 [psm 1]<o:p></o:p></span></b></p>

<p class=3DMsoNormal><b><span lang=3DEN-US =
style=3D'font-size:10.0pt'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
SDP SS Req: tid 0x1 len 0x8<o:p></o:p></span></b></p>

<p class=3DMsoNormal><b><span lang=3DEN-US =
style=3D'font-size:10.0pt'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;
pat uuid-16 0x110b (AudioSink)<o:p></o:p></span></b></p>

<p class=3DMsoNormal><b><span lang=3DEN-US =
style=3D'font-size:10.0pt'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;
max 65535<o:p></o:p></span></b></p>

<p class=3DMsoNormal><b><span lang=3DEN-US =
style=3D'font-size:10.0pt'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;
cont 00<o:p></o:p></span></b></p>

<p class=3DMsoNormal><b><span lang=3DEN-US =
style=3D'font-size:10.0pt'>&lt; ACL data:
handle 42 flags 0x02 dlen 14<o:p></o:p></span></b></p>

<p class=3DMsoNormal><b><span lang=3DEN-US =
style=3D'font-size:10.0pt'>&nbsp;&nbsp;&nbsp;
L2CAP(d): cid 0x0040 len 10 [psm 1]<o:p></o:p></span></b></p>

<p class=3DMsoNormal><b><span lang=3DEN-US =
style=3D'font-size:10.0pt'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
SDP SS Rsp: tid 0x1 len 0x5<o:p></o:p></span></b></p>

<p class=3DMsoNormal><b><span lang=3DEN-US =
style=3D'font-size:10.0pt'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;
count 0<o:p></o:p></span></b></p>

<p class=3DMsoNormal><b><span lang=3DEN-US =
style=3D'font-size:10.0pt'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;
cont 00<o:p></o:p></span></b></p>

<p class=3DMsoNormal><b><span lang=3DEN-US =
style=3D'font-size:10.0pt'>&gt; HCI Event:
Number of Completed Packets (0x13) plen 5<o:p></o:p></span></b></p>

<p class=3DMsoNormal><b><span lang=3DEN-US =
style=3D'font-size:10.0pt'>&gt; ACL data:
handle 42 flags 0x02 dlen 17<o:p></o:p></span></b></p>

<p class=3DMsoNormal><b><span lang=3DEN-US =
style=3D'font-size:10.0pt'>&nbsp;&nbsp;&nbsp;
L2CAP(d): cid 0x0040 len 13 [psm 1]<o:p></o:p></span></b></p>

<p class=3DMsoNormal><b><span lang=3DEN-US =
style=3D'font-size:10.0pt'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
SDP SS Req: tid 0x2 len 0x8<o:p></o:p></span></b></p>

<p class=3DMsoNormal><b><span lang=3DEN-US =
style=3D'font-size:10.0pt'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;
pat uuid-16 0x111e (Handsfree)<o:p></o:p></span></b></p>

<p class=3DMsoNormal><b><span lang=3DEN-US =
style=3D'font-size:10.0pt'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;
max 65535<o:p></o:p></span></b></p>

<p class=3DMsoNormal><b><span lang=3DEN-US =
style=3D'font-size:10.0pt'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;
cont 00<o:p></o:p></span></b></p>

<p class=3DMsoNormal><b><span lang=3DEN-US =
style=3D'font-size:10.0pt'>&lt; ACL data:
handle 42 flags 0x02 dlen 14<o:p></o:p></span></b></p>

<p class=3DMsoNormal><b><span lang=3DEN-US =
style=3D'font-size:10.0pt'>&nbsp;&nbsp;&nbsp;
L2CAP(d): cid 0x0040 len 10 [psm 1]<o:p></o:p></span></b></p>

<p class=3DMsoNormal><b><span lang=3DEN-US =
style=3D'font-size:10.0pt'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
SDP SS Rsp: tid 0x2 len 0x5<o:p></o:p></span></b></p>

<p class=3DMsoNormal><b><span lang=3DEN-US =
style=3D'font-size:10.0pt'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;
count 0<o:p></o:p></span></b></p>

<p class=3DMsoNormal><b><span lang=3DEN-US =
style=3D'font-size:10.0pt'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
&nbsp;&nbsp;&nbsp;&nbsp;cont 00<o:p></o:p></span></b></p>

<p class=3DMsoNormal><b><span lang=3DEN-US =
style=3D'font-size:10.0pt'>&gt; HCI Event:
Number of Completed Packets (0x13) plen 5<o:p></o:p></span></b></p>

<p class=3DMsoNormal><b><span lang=3DEN-US =
style=3D'font-size:10.0pt'>&gt; ACL data:
handle 42 flags 0x02 dlen 17<o:p></o:p></span></b></p>

<p class=3DMsoNormal><b><span lang=3DEN-US =
style=3D'font-size:10.0pt'>&nbsp;&nbsp;&nbsp;
L2CAP(d): cid 0x0040 len 13 [psm 1]<o:p></o:p></span></b></p>

<p class=3DMsoNormal><b><span lang=3DEN-US =
style=3D'font-size:10.0pt'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
SDP SS Req: tid 0x3 len 0x8<o:p></o:p></span></b></p>

<p class=3DMsoNormal><b><span lang=3DEN-US =
style=3D'font-size:10.0pt'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;
pat uuid-16 0x1108 (Headset)<o:p></o:p></span></b></p>

<p class=3DMsoNormal><b><span lang=3DEN-US =
style=3D'font-size:10.0pt'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;
max 65535<o:p></o:p></span></b></p>

<p class=3DMsoNormal><b><span lang=3DEN-US =
style=3D'font-size:10.0pt'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;
cont 00<o:p></o:p></span></b></p>

<p class=3DMsoNormal><b><span lang=3DEN-US =
style=3D'font-size:10.0pt'>&lt; ACL data:
handle 42 flags 0x02 dlen 14<o:p></o:p></span></b></p>

<p class=3DMsoNormal><b><span lang=3DEN-US =
style=3D'font-size:10.0pt'>&nbsp;&nbsp;&nbsp;
L2CAP(d): cid 0x0040 len 10 [psm 1]<o:p></o:p></span></b></p>

<p class=3DMsoNormal><b><span lang=3DEN-US =
style=3D'font-size:10.0pt'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
SDP SS Rsp: tid 0x3 len 0x5<o:p></o:p></span></b></p>

<p class=3DMsoNormal><b><span lang=3DEN-US =
style=3D'font-size:10.0pt'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;
count 0<o:p></o:p></span></b></p>

<p class=3DMsoNormal><b><span lang=3DEN-US =
style=3D'font-size:10.0pt'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;
cont 00<o:p></o:p></span></b></p>

<p class=3DMsoNormal><b><span lang=3DEN-US =
style=3D'font-size:10.0pt'>&gt; HCI Event:
Number of Completed Packets (0x13) plen 5<o:p></o:p></span></b></p>

<p class=3DMsoNormal><b><span lang=3DEN-US =
style=3D'font-size:10.0pt'>&gt; ACL data:
handle 42 flags 0x02 dlen 17<o:p></o:p></span></b></p>

<p class=3DMsoNormal><b><span lang=3DEN-US =
style=3D'font-size:10.0pt'>&nbsp; &nbsp;&nbsp;L2CAP(d):
cid 0x0040 len 13 [psm 1]<o:p></o:p></span></b></p>

<p class=3DMsoNormal><b><span lang=3DEN-US =
style=3D'font-size:10.0pt'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
SDP SS Req: tid 0x4 len 0x8<o:p></o:p></span></b></p>

<p class=3DMsoNormal><b><span lang=3DEN-US =
style=3D'font-size:10.0pt'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;
pat uuid-16 0x110c (AVRemTarget)<o:p></o:p></span></b></p>

<p class=3DMsoNormal><b><span lang=3DEN-US =
style=3D'font-size:10.0pt'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;
max 65535<o:p></o:p></span></b></p>

<p class=3DMsoNormal><b><span lang=3DEN-US =
style=3D'font-size:10.0pt'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;
cont 00<o:p></o:p></span></b></p>

<p class=3DMsoNormal><b><span lang=3DEN-US =
style=3D'font-size:10.0pt'>&lt; ACL data:
handle 42 flags 0x02 dlen 14<o:p></o:p></span></b></p>

<p class=3DMsoNormal><b><span lang=3DEN-US =
style=3D'font-size:10.0pt'>&nbsp;&nbsp;&nbsp;
L2CAP(d): cid 0x0040 len 10 [psm 1]<o:p></o:p></span></b></p>

<p class=3DMsoNormal><b><span lang=3DEN-US =
style=3D'font-size:10.0pt'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
SDP SS Rsp: tid 0x4 len 0x5<o:p></o:p></span></b></p>

<p class=3DMsoNormal><b><span lang=3DEN-US =
style=3D'font-size:10.0pt'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;
count 0<o:p></o:p></span></b></p>

<p class=3DMsoNormal><b><span lang=3DEN-US =
style=3D'font-size:10.0pt'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;
cont 00<o:p></o:p></span></b></p>

<p class=3DMsoNormal><b><span lang=3DEN-US =
style=3D'font-size:10.0pt'>&gt; HCI Event:
Number of Completed Packets (0x13) plen 5<o:p></o:p></span></b></p>

<p class=3DMsoNormal><b><span lang=3DEN-US =
style=3D'font-size:10.0pt'>&gt; ACL data:
handle 42 flags 0x02 dlen 31<o:p></o:p></span></b></p>

<p class=3DMsoNormal><b><span lang=3DEN-US =
style=3D'font-size:10.0pt'>&nbsp;&nbsp;&nbsp;
L2CAP(d): cid 0x0040 len 27 [psm 1]<o:p></o:p></span></b></p>

<p class=3DMsoNormal><b><span lang=3DEN-US =
style=3D'font-size:10.0pt'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
SDP SS Req: tid 0x5 len 0x16<o:p></o:p></span></b></p>

<p class=3DMsoNormal><b><span lang=3DEN-US =
style=3D'font-size:10.0pt'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;
pat uuid-128 =
00005555-0000-1000-8000-0002ee000001<o:p></o:p></span></b></p>

<p class=3DMsoNormal><b><span lang=3DEN-US =
style=3D'font-size:10.0pt'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;
max 65535<o:p></o:p></span></b></p>

<p class=3DMsoNormal><b><span lang=3DEN-US =
style=3D'font-size:10.0pt'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;
cont 00<o:p></o:p></span></b></p>

<p class=3DMsoNormal><b><span lang=3DEN-US =
style=3D'font-size:10.0pt'>&lt; ACL data:
handle 42 flags 0x02 dlen 14<o:p></o:p></span></b></p>

<p class=3DMsoNormal><b><span lang=3DEN-US =
style=3D'font-size:10.0pt'>&nbsp;&nbsp;&nbsp;
L2CAP(d): cid 0x0040 len 10 [psm 1]<o:p></o:p></span></b></p>

<p class=3DMsoNormal><b><span lang=3DEN-US =
style=3D'font-size:10.0pt'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
SDP SS Rsp: tid 0x5 len 0x5<o:p></o:p></span></b></p>

<p class=3DMsoNormal><b><span lang=3DEN-US =
style=3D'font-size:10.0pt'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;
count 0<o:p></o:p></span></b></p>

<p class=3DMsoNormal><b><span lang=3DEN-US =
style=3D'font-size:10.0pt'>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;
cont 00<o:p></o:p></span></b></p>

<p class=3DMsoNormal><b><span lang=3DEN-US =
style=3D'font-size:10.0pt'>&gt; HCI Event:
Number of Completed Packets (0x13) plen 5<o:p></o:p></span></b></p>

<p class=3DMsoNormal><b><span lang=3DEN-US =
style=3D'font-size:10.0pt'>&gt; ACL data:
handle 42 flags 0x02 dlen 12<o:p></o:p></span></b></p>

<p class=3DMsoNormal><b><span lang=3DEN-US =
style=3D'font-size:10.0pt'>&nbsp;&nbsp;&nbsp;
L2CAP(s): Disconn req: dcid 0x0040 scid 0x0040<o:p></o:p></span></b></p>

<p class=3DMsoNormal><b><span lang=3DEN-US =
style=3D'font-size:10.0pt'>&lt; ACL data:
handle 42 flags 0x02 dlen 12<o:p></o:p></span></b></p>

<p class=3DMsoNormal><b><span lang=3DEN-US =
style=3D'font-size:10.0pt'>&nbsp;&nbsp;&nbsp;
L2CAP(s): Disconn rsp: dcid 0x0040 scid 0x0040<o:p></o:p></span></b></p>

<p class=3DMsoNormal><b><span lang=3DEN-US =
style=3D'font-size:10.0pt'>&gt; HCI Event:
Number of Completed Packets (0x13) plen 5<o:p></o:p></span></b></p>

<p class=3DMsoNormal><b><span lang=3DEN-US =
style=3D'font-size:10.0pt'>&lt; HCI
Command: Disconnect (0x01|0x0006) plen 3<o:p></o:p></span></b></p>

<p class=3DMsoNormal><b><span lang=3DEN-US =
style=3D'font-size:10.0pt'>&gt; HCI Event:
Command Status (0x0f) plen 4<o:p></o:p></span></b></p>

<p class=3DMsoNormal><b><span lang=3DEN-US =
style=3D'font-size:10.0pt'>&gt; HCI Event:
Disconn Complete (0x05) plen 4<o:p></o:p></span></b></p>

<p class=3DMsoNormal><b><span lang=3DEN-US =
style=3D'font-size:10.0pt'><o:p>&nbsp;</o:p></span></b></p>

<p class=3DMsoNormal><span lang=3DEN-US>Thanks in advance for your =
help.<o:p></o:p></span></p>

<p class=3DMsoNormal><span lang=3DEN-US>Best =
Regards<o:p></o:p></span></p>

<p class=3DMsoNormal><span lang=3DEN-US><o:p>&nbsp;</o:p></span></p>

<p class=3DMsoNormal><span lang=3DEN-US>Pierre<o:p></o:p></span></p>

</div>

</body>

</html>

------=_NextPart_000_0034_01C8E7EF.4B320B30--



--===============0988431334==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
--===============0988431334==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

--===============0988431334==--
