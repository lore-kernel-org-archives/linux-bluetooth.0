Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <008c01c50a35$c68c11e0$0100a8c0@hppav>
From: "Oliver" <urnenfel@tiscali.es>
To: <bluez-devel@lists.sourceforge.net>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_NextPart_000_0087_01C50A3E.256FEF30"
Subject: [Bluez-devel] USB drivers & architecture
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
Reply-To: bluez-devel@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Thu, 3 Feb 2005 22:17:28 +0100

This is a multi-part message in MIME format.

------=_NextPart_000_0087_01C50A3E.256FEF30
Content-Type: text/plain;
	charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable

Hi all !

I am new in the list and I hope I am not making a rethorical question,=20

I am looking at the linux source code and the architecture of BlueZ on =
the website.

I can see that in the folder /net/bluetooth/* there is the =
implementation of the layers HCI and L2CAP

Inside there is some foldwers like /bnep /rfcoom /hidp... which are =
layers on the top of L2CAP

The blueZ libs bring us the API to acces these last layers....=20

At this point if I am wong, I beg for a correction.

So my question is, where are the sources for the physical layers?
Where can I the drivers for the USB dongles etc?

What is exactily what I found in /drivers/usb/classa/bluetty ?

Thanks a lot

Oliver
------=_NextPart_000_0087_01C50A3E.256FEF30
Content-Type: text/html;
	charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META http-equiv=3DContent-Type content=3D"text/html; =
charset=3Dwindows-1252">
<META content=3D"MSHTML 6.00.2900.2523" name=3DGENERATOR>
<STYLE></STYLE>
</HEAD>
<BODY bgColor=3D#ffffff>
<DIV><FONT face=3DArial size=3D2>Hi all !</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>I am new in the list and I hope I am =
not making a=20
rethorical question, </FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>I am looking at the linux source code =
and the=20
architecture of BlueZ on the website.</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>I can see that in the folder =
/net/bluetooth/* there=20
is the implementation of the layers HCI and L2CAP</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>Inside there is some foldwers like =
/bnep /rfcoom=20
/hidp... which are layers on the top of L2CAP</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>The blueZ libs bring us the API to =
acces these last=20
layers.... </FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>At this point if I am wong, I beg for a =

correction.</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>So my question is, where are the =
sources for the=20
physical layers?</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>Where&nbsp;can I the drivers for the =
USB dongles=20
etc?</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>What is exactily what I found in=20
/drivers/usb/classa/bluetty ?</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>Thanks a lot</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>Oliver</FONT></DIV></BODY></HTML>

------=_NextPart_000_0087_01C50A3E.256FEF30--

___________________________________________________

Nueva tecnología de Yahoo! Búsquedas

¿te atreves a comparar?

http://busquedas.yahoo.es



-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
