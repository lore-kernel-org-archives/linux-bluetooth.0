Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <009401c4142a$b06be720$fcca010a@lysydziadek>
From: "zubiwat" <zubiwat@poczta.onet.pl>
To: "devel Bluetooth" <bluez-devel@lists.sourceforge.net>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_NextPart_000_0091_01C41433.120D0FB0"
Subject: [Bluez-devel] BT Initialization
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Sat, 27 Mar 2004 19:38:25 +0100

This is a multi-part message in MIME format.

------=_NextPart_000_0091_01C41433.120D0FB0
Content-Type: text/plain;
	charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable

Hi=20
I'm setting CSR BT device using code from blueZ hciattach.c
and after this when I'm trying to send some commands I get only this:
04 FF 13 C2 01 00 09 00 02 00 02 68 00 00 BF 0E 00 00 00 00 00 00
I get this even when I'm not sending anything. I looked for this event =
into specification and couldn't find it.
I think that I have to send some command to set BT up and then it will =
listen to my other commands like reading BT ADDR.
If someone could send me a code how to set up BT device and read BT ADDR =
for example I would be greatfull.

Regards

Maciej Zubilewicz

------=_NextPart_000_0091_01C41433.120D0FB0
Content-Type: text/html;
	charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META http-equiv=3DContent-Type content=3D"text/html; =
charset=3Diso-8859-2">
<META content=3D"MSHTML 5.50.4134.600" name=3DGENERATOR>
<STYLE></STYLE>
</HEAD>
<BODY bgColor=3D#ffffff>
<DIV><FONT face=3DArial size=3D2>Hi </FONT></DIV>
<DIV><FONT face=3DArial size=3D2>I'm setting CSR BT device using code =
from blueZ=20
hciattach.c</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>and after this when I'm trying to send =
some=20
commands I get only this:</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>04 FF 13 C2 01 00 09 00 02 00 02 68 00 =
00 BF 0E 00=20
00 00 00 00 00</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>I get this even when I'm not sending =
anything. I=20
looked for this event into specification and couldn't find =
it.</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>I think that I have to send some =
command to set BT=20
up and then it will listen to my other commands like reading BT=20
ADDR.</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>If someone could send me a code how to =
set up BT=20
device and read BT&nbsp;ADDR for example I would be =
greatfull.</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>Regards</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>Maciej =
Zubilewicz</FONT></DIV></BODY></HTML>

------=_NextPart_000_0091_01C41433.120D0FB0--



-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
