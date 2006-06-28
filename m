Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <BAY116-DAV2A01D718F553CDD7A6939C77F0@phx.gbl>
From: "I-Chung Chane" <ichane@hotmail.com>
To: "BlueZ development" <bluez-devel@lists.sourceforge.net>
References: <BAY116-DAV738BD697D0EDB18FB509AC77F0@phx.gbl><6297d67c0606272049g55cc14cby52254c90863e727f@mail.gmail.com><BAY116-DAV22C2B995073A52F8216D6C77F0@phx.gbl>
	<6297d67c0606280257y1cda0a8bj5ebdec42e3b1079@mail.gmail.com>
Date: Wed, 28 Jun 2006 18:34:03 +0800
MIME-Version: 1.0
Subject: Re: [Bluez-devel] A2DP a2play and a2recv
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============2071695285=="
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

This is a multi-part message in MIME format.

--===============2071695285==
Content-Type: multipart/alternative;
	boundary="----=_NextPart_000_00EA_01C69AE1.6E680DF0"

This is a multi-part message in MIME format.

------=_NextPart_000_00EA_01C69AE1.6E680DF0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi, Mayank:

     The embeded ARM platform is little endian so I define FORCE_LITTLE.

      Yeah, a sharp spike noise can be heard in a 10 second interval =
while a2play is playing on the other side

      The a2recv version should be recent one. It runs ok on PC Linux.

thanks for helps,

Chane


  The above logs are OK. It means that the A2DP source is streaming to =
your target device.=20
  The only reason that you do not hear anything can be an endian =
problem. Maybe the endian type in which the SBC is decoded is different =
from the one that your device supports.
  Don't you even hear any noise?
  By the way are you using the latest version of a2recv?




------=_NextPart_000_00EA_01C69AE1.6E680DF0
Content-Type: text/html;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META http-equiv=3DContent-Type content=3D"text/html; =
charset=3Diso-8859-1">
<META content=3D"MSHTML 6.00.2900.2912" name=3DGENERATOR>
<STYLE></STYLE>
</HEAD>
<BODY bgColor=3D#ffffff>
<DIV><FONT face=3D&#26032;&#32048;&#26126;&#39636; size=3D2>Hi, =
Mayank:</FONT></DIV>
<DIV><FONT face=3D&#26032;&#32048;&#26126;&#39636; =
size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3D&#26032;&#32048;&#26126;&#39636; =
size=3D2>&nbsp;&nbsp;&nbsp;&nbsp; The embeded ARM platform is=20
little endian so I define FORCE_LITTLE.</FONT></DIV>
<DIV><FONT face=3D&#26032;&#32048;&#26126;&#39636; =
size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3D&#26032;&#32048;&#26126;&#39636; =
size=3D2>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Yeah, a sharp spike=20
noise can be heard in a 10 second interval while a2play is playing on =
the other=20
side</FONT></DIV>
<DIV><FONT face=3D&#26032;&#32048;&#26126;&#39636; =
size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3D&#26032;&#32048;&#26126;&#39636; =
size=3D2>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; The a2recv version=20
should be recent one. It runs ok on PC Linux.</FONT></DIV>
<DIV><FONT face=3D&#26032;&#32048;&#26126;&#39636; =
size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3D&#26032;&#32048;&#26126;&#39636; size=3D2>thanks for =
helps,</FONT></DIV>
<DIV><FONT face=3D&#26032;&#32048;&#26126;&#39636; =
size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3D&#26032;&#32048;&#26126;&#39636; =
size=3D2>Chane</FONT></DIV>
<BLOCKQUOTE=20
style=3D"PADDING-RIGHT: 0px; PADDING-LEFT: 5px; MARGIN-LEFT: 5px; =
BORDER-LEFT: #000000 2px solid; MARGIN-RIGHT: 0px">
  <DIV style=3D"FONT: 10pt &#26032;&#32048;&#26126;&#39636;"><FONT =
face=3D"&#27;$B?7:YL@qs&#27;(B"=20
  size=3D2></FONT>&nbsp;</DIV>
  <DIV>
  <DIV>&nbsp;</DIV>
  <DIV>The above logs are OK. It means that the A2DP source is streaming =
to your=20
  target device. </DIV>
  <DIV>The only reason that you do not hear anything can be an endian =
problem.=20
  Maybe the endian type in which the SBC is decoded is different from =
the one=20
  that your device supports.</DIV>
  <DIV>Don't you even hear any noise?</DIV>
  <DIV>By the way are you using the latest version of a2recv?</DIV>
  <DIV>&nbsp;</DIV><BR>
  <BLOCKQUOTE class=3Dgmail_quote=20
  style=3D"PADDING-LEFT: 1ex; MARGIN: 0px 0px 0px 0.8ex; BORDER-LEFT: =
#ccc 1px solid">
    <DIV>
    <DIV bgcolor=3D"#ffffff"><FONT =
face=3D&#26032;&#32048;&#26126;&#39636;=20
  =
size=3D2></FONT>&nbsp;</DIV></DIV></BLOCKQUOTE></DIV></BLOCKQUOTE></BODY>=
</HTML>

------=_NextPart_000_00EA_01C69AE1.6E680DF0--


--===============2071695285==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
--===============2071695285==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--===============2071695285==--
