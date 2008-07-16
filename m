Return-Path: <cyrus@holtmann.org>
Message-ID: <01b901c8e786$b19ab840$6701a8c0@freqonedev>
From: "David Stockwell" <dstockwell@frequency-one.com>
To: "BlueZ development" <bluez-devel@lists.sourceforge.net>
References: <005501c8e76e$bfbd1d40$3f3757c0$@savary@kerlink.fr>
Date: Wed, 16 Jul 2008 15:58:21 -0500
MIME-Version: 1.0
Subject: Re: [Bluez-devel] connection failed with bluez 3.30 (and 3.36)
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============0114343658=="
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

This is a multi-part message in MIME format.

--===============0114343658==
Content-Type: multipart/alternative;
	boundary="----=_NextPart_000_01B6_01C8E75C.C53AC630"

This is a multi-part message in MIME format.

------=_NextPart_000_01B6_01C8E75C.C53AC630
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

I have also noticed this, with essentially the same hcidump, on =
AMD-based Linux (with Marcel's patches) with bluez-utils-3.36: once the =
pairing is complete, the last L2CAP connection is dropped and the ACL =
connection is dropped.  It seems to me that this happens in =
hcid/dbus-hci.c function hcid_dbus_binding_process_complete in the =
cleanup section, possibly in response to g_io_channel_close.

What is puzzling to me is that the HCI code is 0x13, which is not used =
in this section of code.

FWIW, it did try pressing beyond this dropped ACL by just allowing the =
remote-side application to reestablish its AVRCP connection and all =
seems to work OK.  However, I can also see how dropping the ACL =
connection after pairing would cause some/many devices to fail to =
connect.  This behavior was very unexpected for me, and I spent a week =
or so instrumenting the BlueZ code in adapter.c, device.c and dbus-hci.c =
before I reached this point, only to find that I could work around it =
(with the bonding already completed, the remote device can just simply =
connect, or so it seems).

DS
  ----- Original Message -----=20
  From: Pierre Savary=20
  To: bluez-users@lists.sourceforge.net ; BlueZ-Dev=20
  Sent: Wednesday, July 16, 2008 1:06 PM
  Subject: [Bluez-devel] connection failed with bluez 3.30


  Hi all,

  I updated my design (ARM9 + linux-2.6.23) with the bluez (libs and =
utils) 3.30-3. I also uptaded all the necessary libraries, dbus, etc. =
Since this update my nokia 6120, N95 and E60 cannot be connected. and it =
worked before (bluez 3.16). Some others phone work fine (all =
SonyEricsson, Nokia 6234).

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

------=_NextPart_000_01B6_01C8E75C.C53AC630
Content-Type: text/html;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML xmlns=3D"http://www.w3.org/TR/REC-html40" xmlns:v =3D=20
"urn:schemas-microsoft-com:vml" xmlns:o =3D=20
"urn:schemas-microsoft-com:office:office" xmlns:w =3D=20
"urn:schemas-microsoft-com:office:word" xmlns:m =3D=20
"http://schemas.microsoft.com/office/2004/12/omml"><HEAD>
<META http-equiv=3DContent-Type content=3D"text/html; =
charset=3Diso-8859-1">
<META content=3D"MSHTML 6.00.6000.16674" name=3DGENERATOR>
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
<BODY lang=3DFR vLink=3Dpurple link=3Dblue bgColor=3D#ffffff>
<DIV><FONT face=3DArial size=3D2>I have also noticed this, with =
essentially the same=20
hcidump,&nbsp;on AMD-based Linux (with Marcel's patches)&nbsp;with=20
bluez-utils-3.36: once the pairing is complete, the last L2CAP =
connection is=20
dropped and the ACL connection is dropped.&nbsp; It seems to me that =
this=20
happens in hcid/dbus-hci.c function hcid_dbus_binding_process_complete =
in the=20
cleanup section, possibly in response to =
g_io_channel_close.</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>What is puzzling to me is that the HCI =
code is=20
0x13, which is not used in this section of code.</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>FWIW, it did try pressing beyond this =
dropped ACL=20
by just allowing the remote-side application to reestablish its AVRCP =
connection=20
and all seems to work OK.&nbsp; However, I can also see how dropping the =
ACL=20
connection after pairing would cause some/many devices to fail to =
connect.&nbsp;=20
This behavior was very unexpected for me, and I spent a week or so =
instrumenting=20
the BlueZ code in adapter.c, device.c and dbus-hci.c before I reached =
this=20
point, only to find that I could work around it (with the bonding =
already=20
completed, the remote device can just simply connect, or so it=20
seems).</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>DS</FONT></DIV>
<BLOCKQUOTE dir=3Dltr=20
style=3D"PADDING-RIGHT: 0px; PADDING-LEFT: 5px; MARGIN-LEFT: 5px; =
BORDER-LEFT: #000000 2px solid; MARGIN-RIGHT: 0px">
  <DIV style=3D"FONT: 10pt arial">----- Original Message ----- </DIV>
  <DIV=20
  style=3D"BACKGROUND: #e4e4e4; FONT: 10pt arial; font-color: =
black"><B>From:</B>=20
  <A title=3Dpierre.savary@kerlink.fr=20
  href=3D"mailto:pierre.savary@kerlink.fr">Pierre Savary</A> </DIV>
  <DIV style=3D"FONT: 10pt arial"><B>To:</B> <A=20
  title=3Dbluez-users@lists.sourceforge.net=20
  =
href=3D"mailto:bluez-users@lists.sourceforge.net">bluez-users@lists.sourc=
eforge.net</A>=20
  ; <A title=3Dbluez-devel@lists.sourceforge.net=20
  href=3D"mailto:bluez-devel@lists.sourceforge.net">BlueZ-Dev</A> </DIV>
  <DIV style=3D"FONT: 10pt arial"><B>Sent:</B> Wednesday, July 16, 2008 =
1:06=20
  PM</DIV>
  <DIV style=3D"FONT: 10pt arial"><B>Subject:</B> [Bluez-devel] =
connection failed=20
  with bluez 3.30</DIV>
  <DIV><BR></DIV>
  <DIV class=3DSection1>
  <P class=3DMsoNormal><SPAN lang=3DEN-US>Hi all,<o:p></o:p></SPAN></P>
  <P class=3DMsoNormal><SPAN lang=3DEN-US>I updated my design (ARM9 + =
linux-2.6.23)=20
  with the bluez (libs and utils) 3.30-3. I also uptaded all the =
necessary=20
  libraries, dbus, etc=85 Since this update my nokia 6120, N95 and E60 =
cannot be=20
  connected=85 and it worked before (bluez 3.16). Some others phone work =
fine (all=20
  SonyEricsson, Nokia 6234).<o:p></o:p></SPAN></P>
  <P class=3DMsoNormal><SPAN lang=3DEN-US>Here the hcidump =
:<o:p></o:p></SPAN></P>
  <P class=3DMsoNormal><SPAN lang=3DEN-US><o:p>&nbsp;</o:p></SPAN></P>
  <P class=3DMsoNormal><B><SPAN lang=3DEN-US style=3D"FONT-SIZE: =
10pt">[root@kap=20
  /root]$hcidump<o:p></o:p></SPAN></B></P>
  <P class=3DMsoNormal><B><SPAN lang=3DEN-US style=3D"FONT-SIZE: =
10pt">HCI sniffer -=20
  Bluetooth packet analyzer ver 1.42<o:p></o:p></SPAN></B></P>
  <P class=3DMsoNormal><B><SPAN lang=3DEN-US style=3D"FONT-SIZE: =
10pt">device: hci0=20
  snap_len: 1028 filter: 0xffffffff<o:p></o:p></SPAN></B></P>
  <P class=3DMsoNormal><B><SPAN lang=3DEN-US style=3D"FONT-SIZE: =
10pt">&gt; HCI Event:=20
  Connect Request (0x04) plen 10<o:p></o:p></SPAN></B></P>
  <P class=3DMsoNormal><B><SPAN lang=3DEN-US style=3D"FONT-SIZE: =
10pt">&lt; HCI=20
  Command: Accept Connection Request (0x01|0x0009) plen=20
  7<o:p></o:p></SPAN></B></P>
  <P class=3DMsoNormal><B><SPAN lang=3DEN-US style=3D"FONT-SIZE: =
10pt">&gt; HCI Event:=20
  Command Status (0x0f) plen 4<o:p></o:p></SPAN></B></P>
  <P class=3DMsoNormal><B><SPAN lang=3DEN-US style=3D"FONT-SIZE: =
10pt">&gt; HCI Event:=20
  Connect Complete (0x03) plen 11<o:p></o:p></SPAN></B></P>
  <P class=3DMsoNormal><B><SPAN lang=3DEN-US style=3D"FONT-SIZE: =
10pt">&lt; HCI=20
  Command: Read Remote Supported Features (0x01|0x001b) plen=20
  2<o:p></o:p></SPAN></B></P>
  <P class=3DMsoNormal><B><SPAN style=3D"FONT-SIZE: 10pt">&gt; HCI =
Event: Page Scan=20
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
10pt">&lt; HCI=20
  Command: Write Link Policy Settings (0x02|0x000d) plen=20
  4<o:p></o:p></SPAN></B></P>
  <P class=3DMsoNormal><B><SPAN lang=3DEN-US style=3D"FONT-SIZE: =
10pt">&gt; HCI Event:=20
  Command Complete (0x0e) plen 6<o:p></o:p></SPAN></B></P>
  <P class=3DMsoNormal><B><SPAN lang=3DEN-US style=3D"FONT-SIZE: =
10pt">&lt; HCI=20
  Command: Change Connection Packet Type (0x01|0x000f) plen=20
  4<o:p></o:p></SPAN></B></P>
  <P class=3DMsoNormal><B><SPAN lang=3DEN-US style=3D"FONT-SIZE: =
10pt">&gt; HCI Event:=20
  Read Remote Supported Features (0x0b) plen =
11<o:p></o:p></SPAN></B></P>
  <P class=3DMsoNormal><B><SPAN lang=3DEN-US style=3D"FONT-SIZE: =
10pt">&gt; ACL data:=20
  handle 42 flags 0x02 dlen 12<o:p></o:p></SPAN></B></P>
  <P class=3DMsoNormal><B><SPAN lang=3DEN-US=20
  style=3D"FONT-SIZE: 10pt">&nbsp;&nbsp;&nbsp; L2CAP(s): Connect req: =
psm 1 scid=20
  0x0040<o:p></o:p></SPAN></B></P>
  <P class=3DMsoNormal><B><SPAN lang=3DEN-US style=3D"FONT-SIZE: =
10pt">&lt; ACL data:=20
  handle 42 flags 0x02 dlen 16<o:p></o:p></SPAN></B></P>
  <P class=3DMsoNormal><B><SPAN lang=3DEN-US=20
  style=3D"FONT-SIZE: 10pt">&nbsp;&nbsp;&nbsp; L2CAP(s): Connect rsp: =
dcid 0x0040=20
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
  style=3D"FONT-SIZE: 10pt">&nbsp;&nbsp;&nbsp; L2CAP(s): Info rsp: type =
2 result=20
  1<o:p></o:p></SPAN></B></P>
  <P class=3DMsoNormal><B><SPAN lang=3DEN-US=20
  style=3D"FONT-SIZE: 10pt">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Not=20
  supported<o:p></o:p></SPAN></B></P>
  <P class=3DMsoNormal><B><SPAN lang=3DEN-US style=3D"FONT-SIZE: =
10pt">&gt; HCI Event:=20
  Command Status (0x0f) plen 4<o:p></o:p></SPAN></B></P>
  <P class=3DMsoNormal><B><SPAN lang=3DEN-US style=3D"FONT-SIZE: =
10pt">&lt; HCI=20
  Command: Remote Name Request (0x01|0x0019) plen =
10<o:p></o:p></SPAN></B></P>
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
  style=3D"FONT-SIZE: 10pt">&nbsp;&nbsp;&nbsp; L2CAP(s): Config req: =
dcid 0x0040=20
  flags 0x00 clen 4<o:p></o:p></SPAN></B></P>
  <P class=3DMsoNormal><B><SPAN lang=3DEN-US=20
  style=3D"FONT-SIZE: 10pt">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; MTU=20
  65535<o:p></o:p></SPAN></B></P>
  <P class=3DMsoNormal><B><SPAN lang=3DEN-US style=3D"FONT-SIZE: =
10pt">&lt; ACL data:=20
  handle 42 flags 0x02 dlen 18<o:p></o:p></SPAN></B></P>
  <P class=3DMsoNormal><B><SPAN lang=3DEN-US=20
  style=3D"FONT-SIZE: 10pt">&nbsp;&nbsp;&nbsp; L2CAP(s): Config rsp: =
scid 0x0040=20
  flags 0x00 result 0 clen 4<o:p></o:p></SPAN></B></P>
  <P class=3DMsoNormal><B><SPAN lang=3DEN-US=20
  style=3D"FONT-SIZE: 10pt">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; MTU=20
  65535<o:p></o:p></SPAN></B></P>
  <P class=3DMsoNormal><B><SPAN lang=3DEN-US style=3D"FONT-SIZE: =
10pt">&lt; ACL data:=20
  handle 42 flags 0x02 dlen 12<o:p></o:p></SPAN></B></P>
  <P class=3DMsoNormal><B><SPAN lang=3DEN-US=20
  style=3D"FONT-SIZE: 10pt">&nbsp;&nbsp;&nbsp; L2CAP(s): Config req: =
dcid 0x0040=20
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
  style=3D"FONT-SIZE: 10pt">&nbsp;&nbsp;&nbsp; L2CAP(s): Config rsp: =
scid 0x0040=20
  flags 0x00 result 0 clen 4<o:p></o:p></SPAN></B></P>
  <P class=3DMsoNormal><B><SPAN lang=3DEN-US=20
  style=3D"FONT-SIZE: 10pt">&nbsp;&nbsp;&nbsp;&nbsp; &nbsp;MTU=20
  672<o:p></o:p></SPAN></B></P>
  <P class=3DMsoNormal><B><SPAN lang=3DEN-US style=3D"FONT-SIZE: =
10pt">&gt; ACL data:=20
  handle 42 flags 0x02 dlen 17<o:p></o:p></SPAN></B></P>
  <P class=3DMsoNormal><B><SPAN lang=3DEN-US=20
  style=3D"FONT-SIZE: 10pt">&nbsp;&nbsp;&nbsp; L2CAP(d): cid 0x0040 len =
13 [psm=20
  1]<o:p></o:p></SPAN></B></P>
  <P class=3DMsoNormal><B><SPAN lang=3DEN-US=20
  style=3D"FONT-SIZE: 10pt">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
SDP SS Req:=20
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
  style=3D"FONT-SIZE: 10pt">&nbsp;&nbsp;&nbsp; L2CAP(d): cid 0x0040 len =
10 [psm=20
  1]<o:p></o:p></SPAN></B></P>
  <P class=3DMsoNormal><B><SPAN lang=3DEN-US=20
  style=3D"FONT-SIZE: 10pt">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
SDP SS Rsp:=20
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
  style=3D"FONT-SIZE: 10pt">&nbsp;&nbsp;&nbsp; L2CAP(d): cid 0x0040 len =
13 [psm=20
  1]<o:p></o:p></SPAN></B></P>
  <P class=3DMsoNormal><B><SPAN lang=3DEN-US=20
  style=3D"FONT-SIZE: 10pt">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
SDP SS Req:=20
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
  style=3D"FONT-SIZE: 10pt">&nbsp;&nbsp;&nbsp; L2CAP(d): cid 0x0040 len =
10 [psm=20
  1]<o:p></o:p></SPAN></B></P>
  <P class=3DMsoNormal><B><SPAN lang=3DEN-US=20
  style=3D"FONT-SIZE: 10pt">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
SDP SS Rsp:=20
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
  style=3D"FONT-SIZE: 10pt">&nbsp;&nbsp;&nbsp; L2CAP(d): cid 0x0040 len =
13 [psm=20
  1]<o:p></o:p></SPAN></B></P>
  <P class=3DMsoNormal><B><SPAN lang=3DEN-US=20
  style=3D"FONT-SIZE: 10pt">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
SDP SS Req:=20
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
  style=3D"FONT-SIZE: 10pt">&nbsp;&nbsp;&nbsp; L2CAP(d): cid 0x0040 len =
10 [psm=20
  1]<o:p></o:p></SPAN></B></P>
  <P class=3DMsoNormal><B><SPAN lang=3DEN-US=20
  style=3D"FONT-SIZE: 10pt">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
SDP SS Rsp:=20
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
  style=3D"FONT-SIZE: 10pt">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
SDP SS Req:=20
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
  style=3D"FONT-SIZE: 10pt">&nbsp;&nbsp;&nbsp; L2CAP(d): cid 0x0040 len =
10 [psm=20
  1]<o:p></o:p></SPAN></B></P>
  <P class=3DMsoNormal><B><SPAN lang=3DEN-US=20
  style=3D"FONT-SIZE: 10pt">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
SDP SS Rsp:=20
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
  style=3D"FONT-SIZE: 10pt">&nbsp;&nbsp;&nbsp; L2CAP(d): cid 0x0040 len =
27 [psm=20
  1]<o:p></o:p></SPAN></B></P>
  <P class=3DMsoNormal><B><SPAN lang=3DEN-US=20
  style=3D"FONT-SIZE: 10pt">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
SDP SS Req:=20
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
  style=3D"FONT-SIZE: 10pt">&nbsp;&nbsp;&nbsp; L2CAP(d): cid 0x0040 len =
10 [psm=20
  1]<o:p></o:p></SPAN></B></P>
  <P class=3DMsoNormal><B><SPAN lang=3DEN-US=20
  style=3D"FONT-SIZE: 10pt">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
SDP SS Rsp:=20
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
  style=3D"FONT-SIZE: 10pt">&nbsp;&nbsp;&nbsp; L2CAP(s): Disconn req: =
dcid 0x0040=20
  scid 0x0040<o:p></o:p></SPAN></B></P>
  <P class=3DMsoNormal><B><SPAN lang=3DEN-US style=3D"FONT-SIZE: =
10pt">&lt; ACL data:=20
  handle 42 flags 0x02 dlen 12<o:p></o:p></SPAN></B></P>
  <P class=3DMsoNormal><B><SPAN lang=3DEN-US=20
  style=3D"FONT-SIZE: 10pt">&nbsp;&nbsp;&nbsp; L2CAP(s): Disconn rsp: =
dcid 0x0040=20
  scid 0x0040<o:p></o:p></SPAN></B></P>
  <P class=3DMsoNormal><B><SPAN lang=3DEN-US style=3D"FONT-SIZE: =
10pt">&gt; HCI Event:=20
  Number of Completed Packets (0x13) plen 5<o:p></o:p></SPAN></B></P>
  <P class=3DMsoNormal><B><SPAN lang=3DEN-US style=3D"FONT-SIZE: =
10pt">&lt; HCI=20
  Command: Disconnect (0x01|0x0006) plen 3<o:p></o:p></SPAN></B></P>
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
lang=3DEN-US>Pierre<o:p></o:p></SPAN></P></DIV></BLOCKQUOTE></BODY></HTML=
>

------=_NextPart_000_01B6_01C8E75C.C53AC630--



--===============0114343658==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.Net email is sponsored by the Moblin Your Move Developer's challenge
Build the coolest Linux based applications with Moblin SDK & win great prizes
Grand prize is a trip for two to an Open Source event anywhere in the world
http://moblin-contest.org/redirect.php?banner_id=100&url=/
--===============0114343658==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--===============0114343658==--
