Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <001f01c5041d$7ac09010$8a8115ac@stu.nus.edu.sg>
From: "Khoo Teck Ping" <eng10166@nus.edu.sg>
To: <bluez-devel@lists.sourceforge.net>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_NextPart_000_001A_01C50460.8568DA20"
Subject: [Bluez-devel] Question about issuing AT commands via cu when rfcomm connected to bluetooth phone
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
Date: Thu, 27 Jan 2005 11:08:25 +0800

This is a multi-part message in MIME format.

------=_NextPart_000_001A_01C50460.8568DA20
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Dear All

I desire to issue some AT commands to my bluetooth phone as follows

# rfcomm bind rfcomm0 00:0a:d9:xx:xx:xx 15
After this I set the permission of the device rfcomm0 to being able to =
read, write and execute by all users.=20

I have the uucp package installed. Next I issued

#cu -l rfcomm0 -s 9600
The terminal reflected "Connected" soon after.=20

However, beyond this point I have tried to issue AT commands to my phone =
without success.

I understand that to use cu, I have to use % before issuing the =
commands.

Please do enlighten me on how I may use AT commands via cu.

Thank You

Teck Ping



------=_NextPart_000_001A_01C50460.8568DA20
Content-Type: text/html;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META http-equiv=3DContent-Type content=3D"text/html; =
charset=3Diso-8859-1">
<META content=3D"MSHTML 6.00.2900.2523" name=3DGENERATOR>
<STYLE></STYLE>
</HEAD>
<BODY bgColor=3D#ffffff>
<DIV><FONT face=3DArial size=3D2>Dear All</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>I desire to issue some AT commands to =
my bluetooth=20
phone as follows</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2># rfcomm bind rfcomm0 00:0a:d9:xx:xx:xx =

15</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>After this I set the permission of the =
device=20
rfcomm0 to being able to read, write and execute by all users. =
</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>I have the uucp package installed. Next =
I=20
issued</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>#cu -l rfcomm0 -s 9600</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>The terminal reflected "Connected" soon =
after.=20
</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV>However, beyond this point I have tried to issue AT commands to my =
phone=20
without success.<BR><BR>I understand that to use cu, I have to use % =
before=20
issuing the commands.<BR><BR>Please do enlighten me on how I may use AT =
commands=20
via cu.</DIV>
<DIV>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>Thank You</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>Teck Ping</FONT></DIV>
<DIV><BR><BR></DIV></BODY></HTML>

------=_NextPart_000_001A_01C50460.8568DA20--



-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
