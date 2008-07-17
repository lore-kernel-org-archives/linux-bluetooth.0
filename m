Return-Path: <cyrus@holtmann.org>
Message-ID: <BAY114-DS24A2B922C2792A07D58A2B18E0@phx.gbl>
From: "shy" <shyboysby@hotmail.com>
To: "'BlueZ users'" <bluez-users@lists.sourceforge.net>
References: <005501c8e76e$bfbd1d40$3f3757c0$@savary@kerlink.fr>
Date: Thu, 17 Jul 2008 10:37:14 +0800
MIME-Version: 1.0
In-Reply-To: <005501c8e76e$bfbd1d40$3f3757c0$@savary@kerlink.fr>
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
Content-Type: multipart/mixed; boundary="===============2113856969=="
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

--===============2113856969==
Content-Type: multipart/alternative;
	boundary="----=_NextPart_000_0058_01C8E7F9.13FD4EE0"

------=_NextPart_000_0058_01C8E7F9.13FD4EE0
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: quoted-printable

Hi,Pierre
>>From the log, your device can be connected, but something wrong with =
sdp.
For sdp requested some attributes, but the response always was null:
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


  _____ =20

From: bluez-users-bounces@lists.sourceforge.net
[mailto:bluez-users-bounces@lists.sourceforge.net] On Behalf Of Pierre
Savary
Sent: 2008=C4=EA7=D4=C217=C8=D5 02:07
To: bluez-users@lists.sourceforge.net; BlueZ-Dev
Subject: [Bluez-users] connection failed with bluez 3.30



Hi all,

I updated my design (ARM9 + linux-2.6.23) with the bluez (libs and =
utils) 3.
30-3. I also uptaded all the necessary libraries, dbus, etc=A1=AD Since =
this
update my nokia 6120, N95 and E60 cannot be connected=A1=AD and it =
worked before
(bluez 3.16). Some others phone work fine (all SonyEricsson, Nokia =
6234).

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


------=_NextPart_000_0058_01C8E7F9.13FD4EE0
Content-Type: text/html; charset="gb2312"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML xmlns=3D"http://www.w3.org/TR/REC-html40" xmlns:v =3D=20
"urn:schemas-microsoft-com:vml" xmlns:o =3D=20
"urn:schemas-microsoft-com:office:office" xmlns:w =3D=20
"urn:schemas-microsoft-com:office:word" xmlns:m =3D=20
"http://schemas.microsoft.com/office/2004/12/omml"><HEAD>
<META http-equiv=3DContent-Type content=3D"text/html; charset=3Dgb2312">
<META content=3D"MSHTML 6.00.2900.3354" name=3DGENERATOR>
<STYLE>@font-face {
	font-family: Cambria Math;
}
@font-face {
	font-family: Calibri;
}
@page Section1 {size: 612.0pt 792.0pt; margin: 70.85pt 70.85pt 70.85pt =
70.85pt; }
P.MsoNormal {
	FONT-SIZE: 11pt; MARGIN: 0cm 0cm 0pt; FONT-FAMILY: =
"Calibri","sans-serif"
}
LI.MsoNormal {
	FONT-SIZE: 11pt; MARGIN: 0cm 0cm 0pt; FONT-FAMILY: =
"Calibri","sans-serif"
}
DIV.MsoNormal {
	FONT-SIZE: 11pt; MARGIN: 0cm 0cm 0pt; FONT-FAMILY: =
"Calibri","sans-serif"
}
A:link {
	COLOR: blue; TEXT-DECORATION: underline; mso-style-priority: 99
}
SPAN.MsoHyperlink {
	COLOR: blue; TEXT-DECORATION: underline; mso-style-priority: 99
}
A:visited {
	COLOR: purple; TEXT-DECORATION: underline; mso-style-priority: 99
}
SPAN.MsoHyperlinkFollowed {
	COLOR: purple; TEXT-DECORATION: underline; mso-style-priority: 99
}
SPAN.EmailStyle17 {
	COLOR: windowtext; FONT-FAMILY: "Calibri","sans-serif"; mso-style-type: =
personal
}
SPAN.EmailStyle18 {
	COLOR: windowtext; FONT-FAMILY: "Calibri","sans-serif"; mso-style-type: =
personal-reply
}
.MsoChpDefault {
	FONT-SIZE: 10pt; mso-style-type: export-only
}
DIV.Section1 {
	page: Section1
}
</STYLE>
<!--[if gte mso 9]><xml>
 <o:shapedefaults v:ext=3D"edit" spidmax=3D"1026" />
</xml><![endif]--><!--[if gte mso 9]><xml>
 <o:shapelayout v:ext=3D"edit">
  <o:idmap v:ext=3D"edit" data=3D"1" />
 </o:shapelayout></xml><![endif]--></HEAD>
<BODY lang=3DFR vLink=3Dpurple link=3Dblue>
<DIV dir=3Dltr align=3Dleft><FONT face=3D=CB=CE=CC=E5><SPAN =
class=3D000403102-17072008><FONT=20
size=3D2>Hi,<SPAN lang=3DEN-US>Pierre</SPAN></FONT></SPAN></FONT></DIV>
<DIV dir=3Dltr align=3Dleft><FONT face=3D=CB=CE=CC=E5 size=3D2><SPAN=20
class=3D000403102-17072008><SPAN lang=3DEN-US>From the log, your device =
can be=20
connected, but something wrong with sdp. For sdp requested some =
attributes, but=20
the response always was null:</SPAN></SPAN></FONT></DIV>
<DIV dir=3Dltr align=3Dleft><FONT face=3D=CB=CE=CC=E5><SPAN =
class=3D000403102-17072008><SPAN=20
lang=3DEN-US>
<P class=3DMsoNormal><SPAN lang=3DEN-US style=3D"FONT-SIZE: 10pt">&gt; =
ACL data:=20
handle 42 flags 0x02 dlen 17<o:p></o:p></SPAN></P>
<P class=3DMsoNormal><SPAN lang=3DEN-US style=3D"FONT-SIZE: =
10pt">&nbsp;&nbsp;&nbsp;=20
L2CAP(d): cid 0x0040 len 13 [psm 1]<o:p></o:p></SPAN></P>
<P class=3DMsoNormal><SPAN lang=3DEN-US=20
style=3D"FONT-SIZE: 10pt">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SDP =
SS Req:=20
tid 0x1 len 0x8<o:p></o:p></SPAN></P>
<P class=3DMsoNormal><SPAN lang=3DEN-US=20
style=3D"FONT-SIZE: =
10pt">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
pat uuid-16 0x110b (AudioSink)<o:p></o:p></SPAN></P>
<P class=3DMsoNormal><SPAN lang=3DEN-US=20
style=3D"FONT-SIZE: =
10pt">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
max 65535<o:p></o:p></SPAN></P>
<P class=3DMsoNormal><SPAN lang=3DEN-US=20
style=3D"FONT-SIZE: =
10pt">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
cont 00</SPAN></P>
<P class=3DMsoNormal><SPAN lang=3DEN-US style=3D"FONT-SIZE: 10pt">&lt; =
ACL data:=20
handle 42 flags 0x02 dlen 14<o:p></o:p></SPAN></P>
<P class=3DMsoNormal><SPAN lang=3DEN-US style=3D"FONT-SIZE: =
10pt">&nbsp;&nbsp;&nbsp;=20
L2CAP(d): cid 0x0040 len 10 [psm 1]<o:p></o:p></SPAN></P>
<P class=3DMsoNormal><SPAN lang=3DEN-US=20
style=3D"FONT-SIZE: 10pt">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SDP =
SS Rsp:=20
tid 0x1 len 0x5<o:p></o:p></SPAN></P>
<P class=3DMsoNormal><SPAN lang=3DEN-US=20
style=3D"FONT-SIZE: =
10pt">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
count 0<o:p></o:p></SPAN></P>
<P class=3DMsoNormal><SPAN lang=3DEN-US=20
style=3D"FONT-SIZE: =
10pt">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
cont 00</SPAN></P>
<P class=3DMsoNormal><SPAN lang=3DEN-US style=3D"FONT-SIZE: =
10pt"><o:p><SPAN=20
class=3D000403102-17072008>I think you could check your services, =
whether you=20
started them up or not.</SPAN></o:p></SPAN></P>
<P class=3DMsoNormal><SPAN lang=3DEN-US style=3D"FONT-SIZE: =
10pt"><o:p><SPAN=20
class=3D000403102-17072008>Brs</SPAN></o:p></SPAN></P>
<P class=3DMsoNormal><SPAN lang=3DEN-US style=3D"FONT-SIZE: =
10pt"><o:p><SPAN=20
class=3D000403102-17072008>Shi=20
Buyun</SPAN></o:p></SPAN></P></SPAN></SPAN></FONT></DIV><BR>
<DIV class=3DOutlookMessageHeader lang=3Den-us dir=3Dltr align=3Dleft>
<HR tabIndex=3D-1>
<FONT face=3DTahoma size=3D2><B>From:</B> =
bluez-users-bounces@lists.sourceforge.net=20
[mailto:bluez-users-bounces@lists.sourceforge.net] <B>On Behalf Of =
</B>Pierre=20
Savary<BR><B>Sent:</B> 2008=C4=EA7=D4=C217=C8=D5 02:07<BR><B>To:</B>=20
bluez-users@lists.sourceforge.net; BlueZ-Dev<BR><B>Subject:</B> =
[Bluez-users]=20
connection failed with bluez 3.30<BR></FONT><BR></DIV>
<DIV></DIV>
<DIV class=3DSection1>
<P class=3DMsoNormal><SPAN lang=3DEN-US>Hi all,<o:p></o:p></SPAN></P>
<P class=3DMsoNormal><SPAN lang=3DEN-US>I updated my design (ARM9 + =
linux-2.6.23)=20
with the bluez (libs and utils) 3.30-3. I also uptaded all the necessary =

libraries, dbus, etc=A1=AD Since this update my nokia 6120, N95 and E60 =
cannot be=20
connected=A1=AD and it worked before (bluez 3.16). Some others phone =
work fine (all=20
SonyEricsson, Nokia 6234).<o:p></o:p></SPAN></P>
<P class=3DMsoNormal><SPAN lang=3DEN-US>Here the hcidump =
:<o:p></o:p></SPAN></P>
<P class=3DMsoNormal><SPAN lang=3DEN-US><o:p>&nbsp;</o:p></SPAN></P>
<P class=3DMsoNormal><B><SPAN lang=3DEN-US style=3D"FONT-SIZE: =
10pt">[root@kap=20
/root]$hcidump<o:p></o:p></SPAN></B></P>
<P class=3DMsoNormal><B><SPAN lang=3DEN-US style=3D"FONT-SIZE: 10pt">HCI =
sniffer -=20
Bluetooth packet analyzer ver 1.42<o:p></o:p></SPAN></B></P>
<P class=3DMsoNormal><B><SPAN lang=3DEN-US style=3D"FONT-SIZE: =
10pt">device: hci0=20
snap_len: 1028 filter: 0xffffffff<o:p></o:p></SPAN></B></P>
<P class=3DMsoNormal><B><SPAN lang=3DEN-US style=3D"FONT-SIZE: =
10pt">&gt; HCI Event:=20
Connect Request (0x04) plen 10<o:p></o:p></SPAN></B></P>
<P class=3DMsoNormal><B><SPAN lang=3DEN-US style=3D"FONT-SIZE: =
10pt">&lt; HCI Command:=20
Accept Connection Request (0x01|0x0009) plen 7<o:p></o:p></SPAN></B></P>
<P class=3DMsoNormal><B><SPAN lang=3DEN-US style=3D"FONT-SIZE: =
10pt">&gt; HCI Event:=20
Command Status (0x0f) plen 4<o:p></o:p></SPAN></B></P>
<P class=3DMsoNormal><B><SPAN lang=3DEN-US style=3D"FONT-SIZE: =
10pt">&gt; HCI Event:=20
Connect Complete (0x03) plen 11<o:p></o:p></SPAN></B></P>
<P class=3DMsoNormal><B><SPAN lang=3DEN-US style=3D"FONT-SIZE: =
10pt">&lt; HCI Command:=20
Read Remote Supported Features (0x01|0x001b) plen =
2<o:p></o:p></SPAN></B></P>
<P class=3DMsoNormal><B><SPAN style=3D"FONT-SIZE: 10pt">&gt; HCI Event: =
Page Scan=20
Repetition Mode Change (0x20) plen 7<o:p></o:p></SPAN></B></P>
<P class=3DMsoNormal><B><SPAN lang=3DEN-US style=3D"FONT-SIZE: =
10pt">&gt; HCI Event:=20
Max Slots Change (0x1b) plen 3<o:p></o:p></SPAN></B></P>
<P class=3DMsoNormal><B><SPAN lang=3DEN-US style=3D"FONT-SIZE: =
10pt">&gt; HCI Event:=20
Command Status (0x0f) plen 4<o:p></o:p></SPAN></B></P>
<P class=3DMsoNormal><B><SPAN lang=3DEN-US style=3D"FONT-SIZE: =
10pt">&gt; HCI Event:=20
Command Status (0x0f) plen 4<o:p></o:p></SPAN></B></P>
<P class=3DMsoNormal><B><SPAN lang=3DEN-US style=3D"FONT-SIZE: =
10pt">&lt; HCI Command:=20
Write Link Policy Settings (0x02|0x000d) plen =
4<o:p></o:p></SPAN></B></P>
<P class=3DMsoNormal><B><SPAN lang=3DEN-US style=3D"FONT-SIZE: =
10pt">&gt; HCI Event:=20
Command Complete (0x0e) plen 6<o:p></o:p></SPAN></B></P>
<P class=3DMsoNormal><B><SPAN lang=3DEN-US style=3D"FONT-SIZE: =
10pt">&lt; HCI Command:=20
Change Connection Packet Type (0x01|0x000f) plen =
4<o:p></o:p></SPAN></B></P>
<P class=3DMsoNormal><B><SPAN lang=3DEN-US style=3D"FONT-SIZE: =
10pt">&gt; HCI Event:=20
Read Remote Supported Features (0x0b) plen 11<o:p></o:p></SPAN></B></P>
<P class=3DMsoNormal><B><SPAN lang=3DEN-US style=3D"FONT-SIZE: =
10pt">&gt; ACL data:=20
handle 42 flags 0x02 dlen 12<o:p></o:p></SPAN></B></P>
<P class=3DMsoNormal><B><SPAN lang=3DEN-US=20
style=3D"FONT-SIZE: 10pt">&nbsp;&nbsp;&nbsp; L2CAP(s): Connect req: psm =
1 scid=20
0x0040<o:p></o:p></SPAN></B></P>
<P class=3DMsoNormal><B><SPAN lang=3DEN-US style=3D"FONT-SIZE: =
10pt">&lt; ACL data:=20
handle 42 flags 0x02 dlen 16<o:p></o:p></SPAN></B></P>
<P class=3DMsoNormal><B><SPAN lang=3DEN-US=20
style=3D"FONT-SIZE: 10pt">&nbsp;&nbsp;&nbsp; L2CAP(s): Connect rsp: dcid =
0x0040=20
scid 0x0040 result 0 status 0<o:p></o:p></SPAN></B></P>
<P class=3DMsoNormal><B><SPAN lang=3DEN-US=20
style=3D"FONT-SIZE: 10pt">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Connection=20
successful<o:p></o:p></SPAN></B></P>
<P class=3DMsoNormal><B><SPAN lang=3DEN-US style=3D"FONT-SIZE: =
10pt">&gt; HCI Event:=20
Number of Completed Packets (0x13) plen 5<o:p></o:p></SPAN></B></P>
<P class=3DMsoNormal><B><SPAN lang=3DEN-US style=3D"FONT-SIZE: =
10pt">&gt; ACL data:=20
handle 42 flags 0x02 dlen 10<o:p></o:p></SPAN></B></P>
<P class=3DMsoNormal><B><SPAN lang=3DEN-US=20
style=3D"FONT-SIZE: 10pt">&nbsp;&nbsp;&nbsp; L2CAP(s): Info req: type=20
2<o:p></o:p></SPAN></B></P>
<P class=3DMsoNormal><B><SPAN lang=3DEN-US style=3D"FONT-SIZE: =
10pt">&lt; ACL data:=20
handle 42 flags 0x02 dlen 12<o:p></o:p></SPAN></B></P>
<P class=3DMsoNormal><B><SPAN lang=3DEN-US=20
style=3D"FONT-SIZE: 10pt">&nbsp;&nbsp;&nbsp; L2CAP(s): Info rsp: type 2 =
result=20
1<o:p></o:p></SPAN></B></P>
<P class=3DMsoNormal><B><SPAN lang=3DEN-US=20
style=3D"FONT-SIZE: 10pt">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Not=20
supported<o:p></o:p></SPAN></B></P>
<P class=3DMsoNormal><B><SPAN lang=3DEN-US style=3D"FONT-SIZE: =
10pt">&gt; HCI Event:=20
Command Status (0x0f) plen 4<o:p></o:p></SPAN></B></P>
<P class=3DMsoNormal><B><SPAN lang=3DEN-US style=3D"FONT-SIZE: =
10pt">&lt; HCI Command:=20
Remote Name Request (0x01|0x0019) plen 10<o:p></o:p></SPAN></B></P>
<P class=3DMsoNormal><B><SPAN lang=3DEN-US style=3D"FONT-SIZE: =
10pt">&gt; HCI Event:=20
Number of Completed Packets (0x13) plen 5<o:p></o:p></SPAN></B></P>
<P class=3DMsoNormal><B><SPAN lang=3DEN-US style=3D"FONT-SIZE: =
10pt">&gt; HCI Event:=20
Connection Packet Type Changed (0x1d) plen 5<o:p></o:p></SPAN></B></P>
<P class=3DMsoNormal><B><SPAN lang=3DEN-US style=3D"FONT-SIZE: =
10pt">&gt; HCI Event:=20
Command Status (0x0f) plen 4<o:p></o:p></SPAN></B></P>
<P class=3DMsoNormal><B><SPAN lang=3DEN-US style=3D"FONT-SIZE: =
10pt">&gt; HCI Event:=20
Remote Name Req Complete (0x07) plen 255<o:p></o:p></SPAN></B></P>
<P class=3DMsoNormal><B><SPAN lang=3DEN-US style=3D"FONT-SIZE: =
10pt">&gt; ACL data:=20
handle 42 flags 0x02 dlen 16<o:p></o:p></SPAN></B></P>
<P class=3DMsoNormal><B><SPAN lang=3DEN-US=20
style=3D"FONT-SIZE: 10pt">&nbsp;&nbsp;&nbsp; L2CAP(s): Config req: dcid =
0x0040=20
flags 0x00 clen 4<o:p></o:p></SPAN></B></P>
<P class=3DMsoNormal><B><SPAN lang=3DEN-US=20
style=3D"FONT-SIZE: 10pt">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; MTU=20
65535<o:p></o:p></SPAN></B></P>
<P class=3DMsoNormal><B><SPAN lang=3DEN-US style=3D"FONT-SIZE: =
10pt">&lt; ACL data:=20
handle 42 flags 0x02 dlen 18<o:p></o:p></SPAN></B></P>
<P class=3DMsoNormal><B><SPAN lang=3DEN-US=20
style=3D"FONT-SIZE: 10pt">&nbsp;&nbsp;&nbsp; L2CAP(s): Config rsp: scid =
0x0040=20
flags 0x00 result 0 clen 4<o:p></o:p></SPAN></B></P>
<P class=3DMsoNormal><B><SPAN lang=3DEN-US=20
style=3D"FONT-SIZE: 10pt">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; MTU=20
65535<o:p></o:p></SPAN></B></P>
<P class=3DMsoNormal><B><SPAN lang=3DEN-US style=3D"FONT-SIZE: =
10pt">&lt; ACL data:=20
handle 42 flags 0x02 dlen 12<o:p></o:p></SPAN></B></P>
<P class=3DMsoNormal><B><SPAN lang=3DEN-US=20
style=3D"FONT-SIZE: 10pt">&nbsp;&nbsp;&nbsp; L2CAP(s): Config req: dcid =
0x0040=20
flags 0x00 clen 0<o:p></o:p></SPAN></B></P>
<P class=3DMsoNormal><B><SPAN lang=3DEN-US style=3D"FONT-SIZE: =
10pt">&gt; HCI Event:=20
Number of Completed Packets (0x13) plen 5<o:p></o:p></SPAN></B></P>
<P class=3DMsoNormal><B><SPAN lang=3DEN-US style=3D"FONT-SIZE: =
10pt">&gt; HCI Event:=20
Number of Completed Packets (0x13) plen 5<o:p></o:p></SPAN></B></P>
<P class=3DMsoNormal><B><SPAN lang=3DEN-US style=3D"FONT-SIZE: =
10pt">&gt; ACL data:=20
handle 42 flags 0x02 dlen 18<o:p></o:p></SPAN></B></P>
<P class=3DMsoNormal><B><SPAN lang=3DEN-US=20
style=3D"FONT-SIZE: 10pt">&nbsp;&nbsp;&nbsp; L2CAP(s): Config rsp: scid =
0x0040=20
flags 0x00 result 0 clen 4<o:p></o:p></SPAN></B></P>
<P class=3DMsoNormal><B><SPAN lang=3DEN-US=20
style=3D"FONT-SIZE: 10pt">&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;MTU=20
672<o:p></o:p></SPAN></B></P>
<P class=3DMsoNormal><B><SPAN lang=3DEN-US style=3D"FONT-SIZE: =
10pt">&gt; ACL data:=20
handle 42 flags 0x02 dlen 17<o:p></o:p></SPAN></B></P>
<P class=3DMsoNormal><B><SPAN lang=3DEN-US=20
style=3D"FONT-SIZE: 10pt">&nbsp;&nbsp;&nbsp; L2CAP(d): cid 0x0040 len 13 =
[psm=20
1]<o:p></o:p></SPAN></B></P>
<P class=3DMsoNormal><B><SPAN lang=3DEN-US=20
style=3D"FONT-SIZE: 10pt">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SDP =
SS Req:=20
tid 0x1 len 0x8<o:p></o:p></SPAN></B></P>
<P class=3DMsoNormal><B><SPAN lang=3DEN-US=20
style=3D"FONT-SIZE: =
10pt">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
pat uuid-16 0x110b (AudioSink)<o:p></o:p></SPAN></B></P>
<P class=3DMsoNormal><B><SPAN lang=3DEN-US=20
style=3D"FONT-SIZE: =
10pt">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
max 65535<o:p></o:p></SPAN></B></P>
<P class=3DMsoNormal><B><SPAN lang=3DEN-US=20
style=3D"FONT-SIZE: =
10pt">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
cont 00<o:p></o:p></SPAN></B></P>
<P class=3DMsoNormal><B><SPAN lang=3DEN-US style=3D"FONT-SIZE: =
10pt">&lt; ACL data:=20
handle 42 flags 0x02 dlen 14<o:p></o:p></SPAN></B></P>
<P class=3DMsoNormal><B><SPAN lang=3DEN-US=20
style=3D"FONT-SIZE: 10pt">&nbsp;&nbsp;&nbsp; L2CAP(d): cid 0x0040 len 10 =
[psm=20
1]<o:p></o:p></SPAN></B></P>
<P class=3DMsoNormal><B><SPAN lang=3DEN-US=20
style=3D"FONT-SIZE: 10pt">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SDP =
SS Rsp:=20
tid 0x1 len 0x5<o:p></o:p></SPAN></B></P>
<P class=3DMsoNormal><B><SPAN lang=3DEN-US=20
style=3D"FONT-SIZE: =
10pt">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
count 0<o:p></o:p></SPAN></B></P>
<P class=3DMsoNormal><B><SPAN lang=3DEN-US=20
style=3D"FONT-SIZE: =
10pt">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
cont 00<o:p></o:p></SPAN></B></P>
<P class=3DMsoNormal><B><SPAN lang=3DEN-US style=3D"FONT-SIZE: =
10pt">&gt; HCI Event:=20
Number of Completed Packets (0x13) plen 5<o:p></o:p></SPAN></B></P>
<P class=3DMsoNormal><B><SPAN lang=3DEN-US style=3D"FONT-SIZE: =
10pt">&gt; ACL data:=20
handle 42 flags 0x02 dlen 17<o:p></o:p></SPAN></B></P>
<P class=3DMsoNormal><B><SPAN lang=3DEN-US=20
style=3D"FONT-SIZE: 10pt">&nbsp;&nbsp;&nbsp; L2CAP(d): cid 0x0040 len 13 =
[psm=20
1]<o:p></o:p></SPAN></B></P>
<P class=3DMsoNormal><B><SPAN lang=3DEN-US=20
style=3D"FONT-SIZE: 10pt">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SDP =
SS Req:=20
tid 0x2 len 0x8<o:p></o:p></SPAN></B></P>
<P class=3DMsoNormal><B><SPAN lang=3DEN-US=20
style=3D"FONT-SIZE: =
10pt">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
pat uuid-16 0x111e (Handsfree)<o:p></o:p></SPAN></B></P>
<P class=3DMsoNormal><B><SPAN lang=3DEN-US=20
style=3D"FONT-SIZE: =
10pt">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
max 65535<o:p></o:p></SPAN></B></P>
<P class=3DMsoNormal><B><SPAN lang=3DEN-US=20
style=3D"FONT-SIZE: =
10pt">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
cont 00<o:p></o:p></SPAN></B></P>
<P class=3DMsoNormal><B><SPAN lang=3DEN-US style=3D"FONT-SIZE: =
10pt">&lt; ACL data:=20
handle 42 flags 0x02 dlen 14<o:p></o:p></SPAN></B></P>
<P class=3DMsoNormal><B><SPAN lang=3DEN-US=20
style=3D"FONT-SIZE: 10pt">&nbsp;&nbsp;&nbsp; L2CAP(d): cid 0x0040 len 10 =
[psm=20
1]<o:p></o:p></SPAN></B></P>
<P class=3DMsoNormal><B><SPAN lang=3DEN-US=20
style=3D"FONT-SIZE: 10pt">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SDP =
SS Rsp:=20
tid 0x2 len 0x5<o:p></o:p></SPAN></B></P>
<P class=3DMsoNormal><B><SPAN lang=3DEN-US=20
style=3D"FONT-SIZE: =
10pt">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
count 0<o:p></o:p></SPAN></B></P>
<P class=3DMsoNormal><B><SPAN lang=3DEN-US=20
style=3D"FONT-SIZE: 10pt">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
&nbsp;&nbsp;&nbsp;&nbsp;cont 00<o:p></o:p></SPAN></B></P>
<P class=3DMsoNormal><B><SPAN lang=3DEN-US style=3D"FONT-SIZE: =
10pt">&gt; HCI Event:=20
Number of Completed Packets (0x13) plen 5<o:p></o:p></SPAN></B></P>
<P class=3DMsoNormal><B><SPAN lang=3DEN-US style=3D"FONT-SIZE: =
10pt">&gt; ACL data:=20
handle 42 flags 0x02 dlen 17<o:p></o:p></SPAN></B></P>
<P class=3DMsoNormal><B><SPAN lang=3DEN-US=20
style=3D"FONT-SIZE: 10pt">&nbsp;&nbsp;&nbsp; L2CAP(d): cid 0x0040 len 13 =
[psm=20
1]<o:p></o:p></SPAN></B></P>
<P class=3DMsoNormal><B><SPAN lang=3DEN-US=20
style=3D"FONT-SIZE: 10pt">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SDP =
SS Req:=20
tid 0x3 len 0x8<o:p></o:p></SPAN></B></P>
<P class=3DMsoNormal><B><SPAN lang=3DEN-US=20
style=3D"FONT-SIZE: =
10pt">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
pat uuid-16 0x1108 (Headset)<o:p></o:p></SPAN></B></P>
<P class=3DMsoNormal><B><SPAN lang=3DEN-US=20
style=3D"FONT-SIZE: =
10pt">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
max 65535<o:p></o:p></SPAN></B></P>
<P class=3DMsoNormal><B><SPAN lang=3DEN-US=20
style=3D"FONT-SIZE: =
10pt">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
cont 00<o:p></o:p></SPAN></B></P>
<P class=3DMsoNormal><B><SPAN lang=3DEN-US style=3D"FONT-SIZE: =
10pt">&lt; ACL data:=20
handle 42 flags 0x02 dlen 14<o:p></o:p></SPAN></B></P>
<P class=3DMsoNormal><B><SPAN lang=3DEN-US=20
style=3D"FONT-SIZE: 10pt">&nbsp;&nbsp;&nbsp; L2CAP(d): cid 0x0040 len 10 =
[psm=20
1]<o:p></o:p></SPAN></B></P>
<P class=3DMsoNormal><B><SPAN lang=3DEN-US=20
style=3D"FONT-SIZE: 10pt">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SDP =
SS Rsp:=20
tid 0x3 len 0x5<o:p></o:p></SPAN></B></P>
<P class=3DMsoNormal><B><SPAN lang=3DEN-US=20
style=3D"FONT-SIZE: =
10pt">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
count 0<o:p></o:p></SPAN></B></P>
<P class=3DMsoNormal><B><SPAN lang=3DEN-US=20
style=3D"FONT-SIZE: =
10pt">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
cont 00<o:p></o:p></SPAN></B></P>
<P class=3DMsoNormal><B><SPAN lang=3DEN-US style=3D"FONT-SIZE: =
10pt">&gt; HCI Event:=20
Number of Completed Packets (0x13) plen 5<o:p></o:p></SPAN></B></P>
<P class=3DMsoNormal><B><SPAN lang=3DEN-US style=3D"FONT-SIZE: =
10pt">&gt; ACL data:=20
handle 42 flags 0x02 dlen 17<o:p></o:p></SPAN></B></P>
<P class=3DMsoNormal><B><SPAN lang=3DEN-US style=3D"FONT-SIZE: =
10pt">&nbsp;=20
&nbsp;&nbsp;L2CAP(d): cid 0x0040 len 13 [psm =
1]<o:p></o:p></SPAN></B></P>
<P class=3DMsoNormal><B><SPAN lang=3DEN-US=20
style=3D"FONT-SIZE: 10pt">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SDP =
SS Req:=20
tid 0x4 len 0x8<o:p></o:p></SPAN></B></P>
<P class=3DMsoNormal><B><SPAN lang=3DEN-US=20
style=3D"FONT-SIZE: =
10pt">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
pat uuid-16 0x110c (AVRemTarget)<o:p></o:p></SPAN></B></P>
<P class=3DMsoNormal><B><SPAN lang=3DEN-US=20
style=3D"FONT-SIZE: =
10pt">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
max 65535<o:p></o:p></SPAN></B></P>
<P class=3DMsoNormal><B><SPAN lang=3DEN-US=20
style=3D"FONT-SIZE: =
10pt">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
cont 00<o:p></o:p></SPAN></B></P>
<P class=3DMsoNormal><B><SPAN lang=3DEN-US style=3D"FONT-SIZE: =
10pt">&lt; ACL data:=20
handle 42 flags 0x02 dlen 14<o:p></o:p></SPAN></B></P>
<P class=3DMsoNormal><B><SPAN lang=3DEN-US=20
style=3D"FONT-SIZE: 10pt">&nbsp;&nbsp;&nbsp; L2CAP(d): cid 0x0040 len 10 =
[psm=20
1]<o:p></o:p></SPAN></B></P>
<P class=3DMsoNormal><B><SPAN lang=3DEN-US=20
style=3D"FONT-SIZE: 10pt">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SDP =
SS Rsp:=20
tid 0x4 len 0x5<o:p></o:p></SPAN></B></P>
<P class=3DMsoNormal><B><SPAN lang=3DEN-US=20
style=3D"FONT-SIZE: =
10pt">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
count 0<o:p></o:p></SPAN></B></P>
<P class=3DMsoNormal><B><SPAN lang=3DEN-US=20
style=3D"FONT-SIZE: =
10pt">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
cont 00<o:p></o:p></SPAN></B></P>
<P class=3DMsoNormal><B><SPAN lang=3DEN-US style=3D"FONT-SIZE: =
10pt">&gt; HCI Event:=20
Number of Completed Packets (0x13) plen 5<o:p></o:p></SPAN></B></P>
<P class=3DMsoNormal><B><SPAN lang=3DEN-US style=3D"FONT-SIZE: =
10pt">&gt; ACL data:=20
handle 42 flags 0x02 dlen 31<o:p></o:p></SPAN></B></P>
<P class=3DMsoNormal><B><SPAN lang=3DEN-US=20
style=3D"FONT-SIZE: 10pt">&nbsp;&nbsp;&nbsp; L2CAP(d): cid 0x0040 len 27 =
[psm=20
1]<o:p></o:p></SPAN></B></P>
<P class=3DMsoNormal><B><SPAN lang=3DEN-US=20
style=3D"FONT-SIZE: 10pt">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SDP =
SS Req:=20
tid 0x5 len 0x16<o:p></o:p></SPAN></B></P>
<P class=3DMsoNormal><B><SPAN lang=3DEN-US=20
style=3D"FONT-SIZE: =
10pt">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
pat uuid-128 =
00005555-0000-1000-8000-0002ee000001<o:p></o:p></SPAN></B></P>
<P class=3DMsoNormal><B><SPAN lang=3DEN-US=20
style=3D"FONT-SIZE: =
10pt">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
max 65535<o:p></o:p></SPAN></B></P>
<P class=3DMsoNormal><B><SPAN lang=3DEN-US=20
style=3D"FONT-SIZE: =
10pt">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
cont 00<o:p></o:p></SPAN></B></P>
<P class=3DMsoNormal><B><SPAN lang=3DEN-US style=3D"FONT-SIZE: =
10pt">&lt; ACL data:=20
handle 42 flags 0x02 dlen 14<o:p></o:p></SPAN></B></P>
<P class=3DMsoNormal><B><SPAN lang=3DEN-US=20
style=3D"FONT-SIZE: 10pt">&nbsp;&nbsp;&nbsp; L2CAP(d): cid 0x0040 len 10 =
[psm=20
1]<o:p></o:p></SPAN></B></P>
<P class=3DMsoNormal><B><SPAN lang=3DEN-US=20
style=3D"FONT-SIZE: 10pt">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; SDP =
SS Rsp:=20
tid 0x5 len 0x5<o:p></o:p></SPAN></B></P>
<P class=3DMsoNormal><B><SPAN lang=3DEN-US=20
style=3D"FONT-SIZE: =
10pt">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
count 0<o:p></o:p></SPAN></B></P>
<P class=3DMsoNormal><B><SPAN lang=3DEN-US=20
style=3D"FONT-SIZE: =
10pt">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
cont 00<o:p></o:p></SPAN></B></P>
<P class=3DMsoNormal><B><SPAN lang=3DEN-US style=3D"FONT-SIZE: =
10pt">&gt; HCI Event:=20
Number of Completed Packets (0x13) plen 5<o:p></o:p></SPAN></B></P>
<P class=3DMsoNormal><B><SPAN lang=3DEN-US style=3D"FONT-SIZE: =
10pt">&gt; ACL data:=20
handle 42 flags 0x02 dlen 12<o:p></o:p></SPAN></B></P>
<P class=3DMsoNormal><B><SPAN lang=3DEN-US=20
style=3D"FONT-SIZE: 10pt">&nbsp;&nbsp;&nbsp; L2CAP(s): Disconn req: dcid =
0x0040=20
scid 0x0040<o:p></o:p></SPAN></B></P>
<P class=3DMsoNormal><B><SPAN lang=3DEN-US style=3D"FONT-SIZE: =
10pt">&lt; ACL data:=20
handle 42 flags 0x02 dlen 12<o:p></o:p></SPAN></B></P>
<P class=3DMsoNormal><B><SPAN lang=3DEN-US=20
style=3D"FONT-SIZE: 10pt">&nbsp;&nbsp;&nbsp; L2CAP(s): Disconn rsp: dcid =
0x0040=20
scid 0x0040<o:p></o:p></SPAN></B></P>
<P class=3DMsoNormal><B><SPAN lang=3DEN-US style=3D"FONT-SIZE: =
10pt">&gt; HCI Event:=20
Number of Completed Packets (0x13) plen 5<o:p></o:p></SPAN></B></P>
<P class=3DMsoNormal><B><SPAN lang=3DEN-US style=3D"FONT-SIZE: =
10pt">&lt; HCI Command:=20
Disconnect (0x01|0x0006) plen 3<o:p></o:p></SPAN></B></P>
<P class=3DMsoNormal><B><SPAN lang=3DEN-US style=3D"FONT-SIZE: =
10pt">&gt; HCI Event:=20
Command Status (0x0f) plen 4<o:p></o:p></SPAN></B></P>
<P class=3DMsoNormal><B><SPAN lang=3DEN-US style=3D"FONT-SIZE: =
10pt">&gt; HCI Event:=20
Disconn Complete (0x05) plen 4<o:p></o:p></SPAN></B></P>
<P class=3DMsoNormal><B><SPAN lang=3DEN-US=20
style=3D"FONT-SIZE: 10pt"><o:p>&nbsp;</o:p></SPAN></B></P>
<P class=3DMsoNormal><SPAN lang=3DEN-US>Thanks in advance for your=20
help.<o:p></o:p></SPAN></P>
<P class=3DMsoNormal><SPAN lang=3DEN-US>Best =
Regards<o:p></o:p></SPAN></P>
<P class=3DMsoNormal><SPAN lang=3DEN-US><o:p>&nbsp;</o:p></SPAN></P>
<P class=3DMsoNormal><SPAN=20
lang=3DEN-US>Pierre<o:p></o:p></SPAN></P></DIV></BODY></HTML>

------=_NextPart_000_0058_01C8E7F9.13FD4EE0--


--===============2113856969==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
--===============2113856969==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

--===============2113856969==--
