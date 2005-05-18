Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <002701c55bcb$f9fc08e0$8300a8c0@priveiqvfluhp9>
From: "Pieter De Mil" <mil@pandora.be>
To: <bluez-devel@lists.sourceforge.net>
References: <C02F8682928AE540A048CD0B1E073C5C01046BAE@ES21SNLNT.srn.sandia.gov>
Subject: Re: [Bluez-devel] iPAQ with Linux and an iPAQ with PocketPC
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_NextPart_000_0024_01C55BDC.BD6F7C20"
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
Date: Wed, 18 May 2005 19:06:47 +0200

This is a multi-part message in MIME format.

------=_NextPart_000_0024_01C55BDC.BD6F7C20
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

iPAQ with Linux and an iPAQ with PocketPCHello Stephen,

On the PocketPC site you can write a C#.Net Compact Framework =
application.
You can open a COM-port (8:outbound or 5:inbound).

If you want the pocketpc to start the communication, you'll have to =
offer a service on the linux ipaq.
I do it the other way, my linuxmachine is starting the connection. So I =
use com5 on the pocketpc. Search for the NETSerial library.

On linux, you can work with the rfcomm-tool.

If you manage to offer a service, and let the pocketpc start the =
connection, let us know :)

regards,
Pieter



  ----- Original Message -----=20
  From: Mclean, Stephen=20
  To: bluez-devel@lists.sourceforge.net=20
  Sent: Wednesday, May 18, 2005 6:41 PM
  Subject: [Bluez-devel] iPAQ with Linux and an iPAQ with PocketPC


  Hello,=20

  I'm fairly new with Linux and Bluetooth.  I'm trying to send a message =
from one PDA using PocketPC and reading the same message on the Linux =
iPAQ (using GPE).  A good goal for right now, would be to be able to =
send "Hello, World!" to a PDA and have the other PDA respond back with =
"I got your message" or something like that.  Does anyone know of any =
good links on the website to learn how to do this?  Maybe a list of =
general commands in Linux that I could look at and figure out how to =
send messages over bluetooth to PocketPC?  I'd appreciate any help.  =
Thanks!

  Stephen=20

------=_NextPart_000_0024_01C55BDC.BD6F7C20
Content-Type: text/html;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD><TITLE>iPAQ with Linux and an iPAQ with PocketPC</TITLE>
<META http-equiv=3DContent-Type content=3D"text/html; =
charset=3Diso-8859-1">
<META content=3D"MSHTML 6.00.2900.2627" name=3DGENERATOR>
<STYLE></STYLE>
</HEAD>
<BODY bgColor=3D#ffffff>
<DIV><FONT face=3DArial size=3D2>Hello Stephen,</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>On the PocketPC site you can write a =
C#.Net Compact=20
Framework application.</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>You can open a COM-port (8:outbound or=20
5:inbound).</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>If you want the pocketpc to start the=20
communication, you'll have to offer a service on the linux =
ipaq.</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>I do it the other way, my linuxmachine =
is starting=20
the connection. So I use com5 on the pocketpc. Search for the NETSerial=20
library.</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>On linux, you can&nbsp;work with the=20
rfcomm-tool.</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>If you manage to offer a service, and =
let the=20
pocketpc start the connection, let us know :)</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>regards,</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>Pieter</FONT></DIV>
<DIV>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<BLOCKQUOTE dir=3Dltr=20
style=3D"PADDING-RIGHT: 0px; PADDING-LEFT: 5px; MARGIN-LEFT: 5px; =
BORDER-LEFT: #000000 2px solid; MARGIN-RIGHT: 0px">
  <DIV style=3D"FONT: 10pt arial">----- Original Message ----- </DIV>
  <DIV=20
  style=3D"BACKGROUND: #e4e4e4; FONT: 10pt arial; font-color: =
black"><B>From:</B>=20
  <A title=3Dsmclean@sandia.gov =
href=3D"mailto:smclean@sandia.gov">Mclean,=20
  Stephen</A> </DIV>
  <DIV style=3D"FONT: 10pt arial"><B>To:</B> <A=20
  title=3Dbluez-devel@lists.sourceforge.net=20
  =
href=3D"mailto:bluez-devel@lists.sourceforge.net">bluez-devel@lists.sourc=
eforge.net</A>=20
  </DIV>
  <DIV style=3D"FONT: 10pt arial"><B>Sent:</B> Wednesday, May 18, 2005 =
6:41=20
  PM</DIV>
  <DIV style=3D"FONT: 10pt arial"><B>Subject:</B> [Bluez-devel] iPAQ =
with Linux=20
  and an iPAQ with PocketPC</DIV>
  <DIV><BR></DIV><!-- Converted from text/rtf format -->
  <P><FONT face=3DArial size=3D2>Hello,</FONT> </P>
  <P><FONT face=3DArial size=3D2>I'm fairly new with Linux and =
Bluetooth.&nbsp; I'm=20
  trying to send a message from one PDA using PocketPC and reading the =
same=20
  message on the Linux iPAQ (using GPE).&nbsp; A good goal for right =
now, would=20
  be to be able to send "Hello, World!" to a PDA and have the other PDA =
respond=20
  back with "I got your message" or something like that.&nbsp; Does =
anyone know=20
  of any good links on the website to learn how to do this?&nbsp; Maybe =
a list=20
  of general commands in Linux that I could look at and figure out how =
to send=20
  messages over bluetooth to PocketPC?&nbsp; I'd appreciate any =
help.&nbsp;=20
  Thanks!</FONT></P>
  <P><FONT face=3DArial size=3D2>Stephen =
</FONT></P></BLOCKQUOTE></BODY></HTML>

------=_NextPart_000_0024_01C55BDC.BD6F7C20--




-------------------------------------------------------
This SF.Net email is sponsored by Oracle Space Sweepstakes
Want to be the first software developer in space?
Enter now for the Oracle Space Sweepstakes!
http://ads.osdn.com/?ad_id=7412&alloc_id=16344&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
