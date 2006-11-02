Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <00c501c6fed4$71fb6320$dc5210ac@homeevstaf>
From: "Michael Evstafiev" <m.evstafyev@mail-r.ru>
To: "BlueZ development" <bluez-devel@lists.sourceforge.net>
References: <B9FFC3F97441D04093A504CEA31B7C41EF9A68@msilexch01.marvell.com>
Date: Fri, 3 Nov 2006 02:12:36 +0300
MIME-Version: 1.0
Subject: Re: [Bluez-devel] hcitool failure with BCSP interface
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============0387191147=="
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

This is a multi-part message in MIME format.

--===============0387191147==
Content-Type: multipart/alternative;
	boundary="----=_NextPart_000_00C2_01C6FEED.8799B6A0"

This is a multi-part message in MIME format.

------=_NextPart_000_00C2_01C6FEED.8799B6A0
Content-Type: text/plain;
	charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi,

Check that you have running hcid and sdpd daemons.

BR,
Mikhail
  ----- Original Message -----=20
  From: Shadi Ammouri=20
  To: bluez-devel@lists.sourceforge.net=20
  Sent: Wednesday, November 01, 2006 6:59 PM
  Subject: [Bluez-devel] hcitool failure with BCSP interface


  Hi,

  =20

  I'm using a CSR Bluetooth device, connected to my system through the =
BCSP interface.

  =20

  I managed to attach the device to the system (hciattach ttyS0 bcsp =
noflow).

  When I try to perform a scan, I don't get any result back.

  =20

  ~#hcitool -I hci0 scan

  Scanning.

  ~#

  =20

  I checked that my cell-phone is properly configured and that it is =
discoverable by other phones.

  =20

  BTW, I'm also unable to see the CSR Bluetooth device from other =
Bluetooth devices in the room.

  =20

  When I perform the above test with the USB connection, it does work =
properly.

  =20

  Thanks in advance.

  Shadi.

  =20



-------------------------------------------------------------------------=
-----


  =
-------------------------------------------------------------------------=

  Using Tomcat but need to do more? Need to support web services, =
security?
  Get stuff done quickly with pre-integrated technology to make your job =
easier
  Download IBM WebSphere Application Server v.1.0.1 based on Apache =
Geronimo
  =
http://sel.as-us.falkag.net/sel?cmd=3Dlnk&kid=3D120709&bid=3D263057&dat=3D=
121642


-------------------------------------------------------------------------=
-----


  _______________________________________________
  Bluez-devel mailing list
  Bluez-devel@lists.sourceforge.net
  https://lists.sourceforge.net/lists/listinfo/bluez-devel

------=_NextPart_000_00C2_01C6FEED.8799B6A0
Content-Type: text/html;
	charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML xmlns=3D"http://www.w3.org/TR/REC-html40" xmlns:o =3D=20
"urn:schemas-microsoft-com:office:office" xmlns:w =3D=20
"urn:schemas-microsoft-com:office:word"><HEAD>
<META http-equiv=3DContent-Type content=3D"text/html; =
charset=3Diso-8859-1">
<META content=3D"MSHTML 6.00.2900.2180" name=3DGENERATOR>
<STYLE>@page Section1 {size: 8.5in 11.0in; margin: 1.0in 1.25in 1.0in =
1.25in; }
P.MsoNormal {
	FONT-SIZE: 12pt; MARGIN: 0in 0in 0pt; FONT-FAMILY: "Times New Roman"
}
LI.MsoNormal {
	FONT-SIZE: 12pt; MARGIN: 0in 0in 0pt; FONT-FAMILY: "Times New Roman"
}
DIV.MsoNormal {
	FONT-SIZE: 12pt; MARGIN: 0in 0in 0pt; FONT-FAMILY: "Times New Roman"
}
A:link {
	COLOR: blue; TEXT-DECORATION: underline
}
SPAN.MsoHyperlink {
	COLOR: blue; TEXT-DECORATION: underline
}
A:visited {
	COLOR: purple; TEXT-DECORATION: underline
}
SPAN.MsoHyperlinkFollowed {
	COLOR: purple; TEXT-DECORATION: underline
}
SPAN.EmailStyle17 {
	COLOR: windowtext; FONT-FAMILY: Arial; mso-style-type: personal-compose
}
DIV.Section1 {
	page: Section1
}
</STYLE>
</HEAD>
<BODY lang=3DEN-US vLink=3Dpurple link=3Dblue bgColor=3D#ffffff>
<DIV><FONT face=3DArial size=3D2>Hi,</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>Check that you have running hcid and =
sdpd=20
daemons.</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>BR,</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>Mikhail</FONT></DIV>
<BLOCKQUOTE=20
style=3D"PADDING-RIGHT: 0px; PADDING-LEFT: 5px; MARGIN-LEFT: 5px; =
BORDER-LEFT: #000000 2px solid; MARGIN-RIGHT: 0px">
  <DIV style=3D"FONT: 10pt arial">----- Original Message ----- </DIV>
  <DIV=20
  style=3D"BACKGROUND: #e4e4e4; FONT: 10pt arial; font-color: =
black"><B>From:</B>=20
  <A title=3Dshadi@marvell.com href=3D"mailto:shadi@marvell.com">Shadi =
Ammouri</A>=20
  </DIV>
  <DIV style=3D"FONT: 10pt arial"><B>To:</B> <A=20
  title=3Dbluez-devel@lists.sourceforge.net=20
  =
href=3D"mailto:bluez-devel@lists.sourceforge.net">bluez-devel@lists.sourc=
eforge.net</A>=20
  </DIV>
  <DIV style=3D"FONT: 10pt arial"><B>Sent:</B> Wednesday, November 01, =
2006 6:59=20
  PM</DIV>
  <DIV style=3D"FONT: 10pt arial"><B>Subject:</B> [Bluez-devel] hcitool =
failure=20
  with BCSP interface</DIV>
  <DIV><BR></DIV>
  <DIV class=3DSection1>
  <P class=3DMsoNormal><FONT face=3DArial size=3D2><SPAN=20
  style=3D"FONT-SIZE: 10pt; FONT-FAMILY: =
Arial">Hi,<o:p></o:p></SPAN></FONT></P>
  <P class=3DMsoNormal><FONT face=3DArial size=3D2><SPAN=20
  style=3D"FONT-SIZE: 10pt; FONT-FAMILY: =
Arial"><o:p>&nbsp;</o:p></SPAN></FONT></P>
  <P class=3DMsoNormal><FONT face=3DArial size=3D2><SPAN=20
  style=3D"FONT-SIZE: 10pt; FONT-FAMILY: Arial">I=92m using a CSR =
Bluetooth device,=20
  connected to my system through the BCSP=20
interface.<o:p></o:p></SPAN></FONT></P>
  <P class=3DMsoNormal><FONT face=3DArial size=3D2><SPAN=20
  style=3D"FONT-SIZE: 10pt; FONT-FAMILY: =
Arial"><o:p>&nbsp;</o:p></SPAN></FONT></P>
  <P class=3DMsoNormal><FONT face=3DArial size=3D2><SPAN=20
  style=3D"FONT-SIZE: 10pt; FONT-FAMILY: Arial">I managed to attach the =
device to=20
  the system (hciattach ttyS0 bcsp noflow).<o:p></o:p></SPAN></FONT></P>
  <P class=3DMsoNormal><FONT face=3DArial size=3D2><SPAN=20
  style=3D"FONT-SIZE: 10pt; FONT-FAMILY: Arial">When I try to perform a =
scan, I=20
  don=92t get any result back.<o:p></o:p></SPAN></FONT></P>
  <P class=3DMsoNormal><FONT face=3DArial size=3D2><SPAN=20
  style=3D"FONT-SIZE: 10pt; FONT-FAMILY: =
Arial"><o:p>&nbsp;</o:p></SPAN></FONT></P>
  <P class=3DMsoNormal><FONT face=3DArial size=3D2><SPAN=20
  style=3D"FONT-SIZE: 10pt; FONT-FAMILY: Arial">~#hcitool =96I hci0=20
  scan<o:p></o:p></SPAN></FONT></P>
  <P class=3DMsoNormal><FONT face=3DArial size=3D2><SPAN=20
  style=3D"FONT-SIZE: 10pt; FONT-FAMILY: =
Arial">Scanning=85<o:p></o:p></SPAN></FONT></P>
  <P class=3DMsoNormal><FONT face=3DArial size=3D2><SPAN=20
  style=3D"FONT-SIZE: 10pt; FONT-FAMILY: =
Arial">~#<o:p></o:p></SPAN></FONT></P>
  <P class=3DMsoNormal><FONT face=3DArial size=3D2><SPAN=20
  style=3D"FONT-SIZE: 10pt; FONT-FAMILY: =
Arial"><o:p>&nbsp;</o:p></SPAN></FONT></P>
  <P class=3DMsoNormal><FONT face=3DArial size=3D2><SPAN=20
  style=3D"FONT-SIZE: 10pt; FONT-FAMILY: Arial">I checked that my =
cell-phone is=20
  properly configured and that it is discoverable by other=20
  phones.<o:p></o:p></SPAN></FONT></P>
  <P class=3DMsoNormal><FONT face=3DArial size=3D2><SPAN=20
  style=3D"FONT-SIZE: 10pt; FONT-FAMILY: =
Arial"><o:p>&nbsp;</o:p></SPAN></FONT></P>
  <P class=3DMsoNormal><FONT face=3DArial size=3D2><SPAN=20
  style=3D"FONT-SIZE: 10pt; FONT-FAMILY: Arial">BTW, I=92m also unable =
to see the=20
  CSR Bluetooth device from other Bluetooth devices in the=20
  room.<o:p></o:p></SPAN></FONT></P>
  <P class=3DMsoNormal><FONT face=3DArial size=3D2><SPAN=20
  style=3D"FONT-SIZE: 10pt; FONT-FAMILY: =
Arial"><o:p>&nbsp;</o:p></SPAN></FONT></P>
  <P class=3DMsoNormal><FONT face=3DArial size=3D2><SPAN=20
  style=3D"FONT-SIZE: 10pt; FONT-FAMILY: Arial">When I perform the above =
test with=20
  the USB connection, it does work =
properly.<o:p></o:p></SPAN></FONT></P>
  <P class=3DMsoNormal><FONT face=3DArial size=3D2><SPAN=20
  style=3D"FONT-SIZE: 10pt; FONT-FAMILY: =
Arial"><o:p>&nbsp;</o:p></SPAN></FONT></P>
  <P class=3DMsoNormal><FONT face=3DArial size=3D2><SPAN=20
  style=3D"FONT-SIZE: 10pt; FONT-FAMILY: Arial">Thanks in=20
  advance.<o:p></o:p></SPAN></FONT></P>
  <P class=3DMsoNormal><FONT face=3DArial size=3D2><SPAN=20
  style=3D"FONT-SIZE: 10pt; FONT-FAMILY: =
Arial">Shadi.<o:p></o:p></SPAN></FONT></P>
  <P class=3DMsoNormal><FONT face=3DArial size=3D2><SPAN=20
  style=3D"FONT-SIZE: 10pt; FONT-FAMILY: =
Arial"><o:p>&nbsp;</o:p></SPAN></FONT></P></DIV>
  <P>
  <HR>

  =
<P></P>------------------------------------------------------------------=
-------<BR>Using=20
  Tomcat but need to do more? Need to support web services, =
security?<BR>Get=20
  stuff done quickly with pre-integrated technology to make your job=20
  easier<BR>Download IBM WebSphere Application Server v.1.0.1 based on =
Apache=20
  =
Geronimo<BR>http://sel.as-us.falkag.net/sel?cmd=3Dlnk&amp;kid=3D120709&am=
p;bid=3D263057&amp;dat=3D121642
  <P>
  <HR>

  <P></P>_______________________________________________<BR>Bluez-devel =
mailing=20
  =
list<BR>Bluez-devel@lists.sourceforge.net<BR>https://lists.sourceforge.ne=
t/lists/listinfo/bluez-devel<BR></BLOCKQUOTE></BODY></HTML>

------=_NextPart_000_00C2_01C6FEED.8799B6A0--




--===============0387191147==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
--===============0387191147==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--===============0387191147==--
