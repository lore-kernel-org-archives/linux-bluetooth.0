Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <000a01c4170b$3c1e14e0$fcca010a@lysydziadek>
From: "zubiwat" <zubiwat@poczta.onet.pl>
To: "devel Bluetooth" <bluez-devel@lists.sourceforge.net>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_NextPart_000_0007_01C4171B.FF86D9C0"
Subject: [Bluez-devel] Connection
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
Date: Wed, 31 Mar 2004 12:30:49 +0200

This is a multi-part message in MIME format.

------=_NextPart_000_0007_01C4171B.FF86D9C0
Content-Type: text/plain;
	charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable

Hi
I have problems with identifying bytes when I'm trying to connect to the =
other BT. On my PC I'm looking for services and on the other BT I get =
this answer:
02 28 00 0C 00 08 DD 01 00 02 01 04 00 01 00 52 00 02 28 20 0C 00 08 00 =
01 00 02 02 04 00 01 00 53 00 04 05 04 00 28 00 13

I think this is ACL Data Packet according to BlueZ hci.h file where it's =
defined as :
#define HCI_ACLDATA_PKT  0x02

Am I wrong?

Please tell me what should I do to connect 2 BT donngles to send simple =
'a' or other ascii. What are steps while making connection between 2 BT =
through rfcomm?

Regards

Maciej

------=_NextPart_000_0007_01C4171B.FF86D9C0
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
<DIV><FONT face=3DArial size=3D2>Hi</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>I have problems with identifying bytes =
when I'm=20
trying to connect to the other BT. On my PC I'm looking for services and =
on the=20
other BT I get this answer:</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>02 28 00 0C 00 08 DD 01 00 02 01 04 00 =
01 00 52 00=20
02 28 20 0C 00 08 00 01 00 02 02 04 00 01 00 53 00 04 05 04 00 28 00=20
13</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>I think this is ACL Data Packet =
according to BlueZ=20
hci.h file where it's defined as :</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>#define HCI_ACLDATA_PKT =
&nbsp;0x02</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>Am I wrong?</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>Please tell me what should I do to =
connect 2 BT=20
donngles to send simple 'a' or other ascii. What are steps while making=20
connection between 2 BT through rfcomm?</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>Regards</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>Maciej</FONT></DIV></BODY></HTML>

------=_NextPart_000_0007_01C4171B.FF86D9C0--



-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
