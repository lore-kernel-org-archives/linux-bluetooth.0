Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <000e01c4145d$904fa7f0$fcca010a@lysydziadek>
From: "zubiwat" <zubiwat@poczta.onet.pl>
To: "devel Bluetooth" <bluez-devel@lists.sourceforge.net>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_NextPart_000_000B_01C41465.F1E33BF0"
Subject: [Bluez-devel] Unknown answer
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
Date: Sun, 28 Mar 2004 01:42:35 +0100

This is a multi-part message in MIME format.

------=_NextPart_000_000B_01C41465.F1E33BF0
Content-Type: text/plain;
	charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable

Hi=20
I'm sending these commands :
0x01 0x05  0x10  0x00
0x01 0x09  0x10  0x00

and I don't understand why I get answer like this:

04 FF 13 C2 01 00 09 00 02 00 02 68 00 00 BF 0E 00 00 00 00 00 00 04 0E =
0B 01 05 10 00 C0 00 40 08 00 08 00 04 0E 0A 01 09 10 00 04 00 20 DD 09 =
00=20

Why when I'm trying to read buffer size (0x01 0x05  0x10  0x00) and read =
BT ADDR (0x01 0x09  0x10  0x00) I get so many events? It's strange =
because when I'm trying to read, device answers that it can't for =
example connect because of connection rejected due to security reasons =
(04 0E 0B 01 05 10 00 C0 00 40 08 00 08 00 ) or am I wrong?
=20
Regards=20

Maciej Zubilewicz

------=_NextPart_000_000B_01C41465.F1E33BF0
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
<DIV><FONT face=3DArial size=3D2>I'm sending these commands =
:</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>
<DIV><FONT face=3DArial size=3D2>0x01 0x05&nbsp; 0x10&nbsp; =
0x00</FONT></DIV>0x01=20
0x09&nbsp; 0x10&nbsp; 0x00</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>and I don't understand why I get answer =
like=20
this:</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>04 FF 13 C2 01 00 09 00 02 00 02 68 00 =
00 BF 0E 00=20
00 00 00 00 00 04 0E 0B 01 05 10 00 C0 00 40 08 00 08 00 04 0E 0A 01 09 =
10 00 04=20
00 20 DD 09 00 </FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>Why when I'm trying to read buffer size =
(0x01=20
0x05&nbsp; 0x10&nbsp; 0x00) and read BT ADDR (0x01 0x09&nbsp; 0x10&nbsp; =
0x00) I=20
get so many events? It's strange because when I'm trying to&nbsp;read, =
device=20
answers that it can't for example connect because of connection rejected =
due to=20
security reasons (04 0E 0B 01 05 10 00 C0 00 40 08 00 08 00 ) or am I=20
wrong?</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>&nbsp;</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>Regards </FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>Maciej =
Zubilewicz</FONT></DIV></BODY></HTML>

------=_NextPart_000_000B_01C41465.F1E33BF0--



-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
