Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <004501c4383b$36b36950$80c8fea9@Perigee.Perigeellc.com>
From: "Rob Taft" <rtaft@sensis.com>
To: <bluez-users@lists.sourceforge.net>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_NextPart_000_0042_01C43819.AC457EF0"
Subject: [Bluez-users] DHCPD and Bluetooth
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Wed, 12 May 2004 12:07:18 -0400

This is a multi-part message in MIME format.

------=_NextPart_000_0042_01C43819.AC457EF0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

I currently have a setup where I have a Bluetooth adapter on a Linux =
box, and one on Windows.  Everything is configured properly.  I connect =
from the Windows Bluetooth adapter to the Linux one via "Local Area =
Connection 2" in XP over TCP/IP.  I manually type "ifconfig bnep0 =
192.168.3.1" to assign the adapter an IP, then I have to restart DHCPD =
to acquire an IP address over Bluetooth.  This all works great.

My first question is:  Is there a way to recognize when a connection is =
made, so I can create a script or some code to automatically set bnep0 =
to 192.168.3.1 and restart the dhcp server?

I only have 2 Bluetooth adapters.  What if I used a 3rd from windows to =
connect to Linux at the same time another one is connected.  Will it =
allow multiple connections?  Will it show up as bnep1 or still use =
bnep0?



Rob Taft, Software Engineer
Perigee, A Division of Sensis Corporation
rtaft@sensis.com
315-453-7842, Ext. 25
------=_NextPart_000_0042_01C43819.AC457EF0
Content-Type: text/html;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META http-equiv=3DContent-Type content=3D"text/html; =
charset=3Diso-8859-1">
<META content=3D"MSHTML 6.00.2800.1400" name=3DGENERATOR>
<STYLE></STYLE>
</HEAD>
<BODY bgColor=3D#ffffff>
<DIV><FONT face=3DArial size=3D2>I currently have a setup where I have a =
Bluetooth=20
adapter on a Linux box, and one on Windows.&nbsp; Everything is =
configured=20
properly.&nbsp; I connect from the Windows Bluetooth adapter to the =
Linux one=20
via "Local Area Connection 2" in XP over TCP/IP.&nbsp; I manually type =
"ifconfig=20
bnep0 192.168.3.1" to assign the adapter an IP, then I have to restart =
DHCPD to=20
acquire an IP address over Bluetooth.&nbsp; This all works =
great.</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>My first question is:&nbsp; Is there a =
way to=20
recognize when a connection is made, so I can create a script or some =
code to=20
automatically set bnep0 to 192.168.3.1 and restart the dhcp =
server?</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>I only have 2 Bluetooth adapters.&nbsp; =
What if I=20
used a 3rd from windows to connect to Linux at the same time another one =
is=20
connected.&nbsp; Will it allow multiple connections?&nbsp; Will it show =
up as=20
bnep1 or still use bnep0?</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>Rob Taft, Software Engineer<BR>Perigee, =
A Division=20
of Sensis Corporation<BR><A=20
href=3D"mailto:rtaft@sensis.com">rtaft@sensis.com</A><BR>315-453-7842, =
Ext.=20
25</FONT></DIV></BODY></HTML>

------=_NextPart_000_0042_01C43819.AC457EF0--



-------------------------------------------------------
This SF.Net email is sponsored by Sleepycat Software
Learn developer strategies Cisco, Motorola, Ericsson & Lucent use to deliver
higher performing products faster, at low TCO.
http://www.sleepycat.com/telcomwpreg.php?From=osdnemail3
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
