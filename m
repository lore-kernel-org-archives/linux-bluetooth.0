Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <002801c3f55d$e5c9d800$7b6b7b8c@guang>
From: "Guang" <m9187@cn.ee.ccu.edu.tw>
To: <bluez-users@lists.sourceforge.net>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_NextPart_000_0025_01C3F5A0.F39DBF80"
Subject: [Bluez-users] headset connection problem
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
Date: Tue, 17 Feb 2004 21:56:52 +0800

This is a multi-part message in MIME format.

------=_NextPart_000_0025_01C3F5A0.F39DBF80
Content-Type: text/plain;
	charset="big5"
Content-Transfer-Encoding: quoted-printable

Hi  everybody:
I  find  a small problem which  Bluez communicate to headset.
 I  have a PC(red hat linux8.0), and headset( sony ericsson HBH-65).
And I inital bluez;
[root@Bluez bluetooth}#  hcid
[root@Bluez bluetooth}#  hciconfig
hci0:  Type:USB
          BD Address:  00:AA:.................

[root@Bluez bluetooth}#  hcitool  scan
Scanning ...
               00:0A:0A:AA:AA:AA     HBH-65

[root@Bluez bluetooth}# modprobe  l2cap
[root@Bluez bluetooth}#  modprobe  rfcomm
[root@Bluez bluetooth}#  l2ping 00:0A:0A:AA:AA:AA
Can't connect. : Permission denied
[root@Bluez bluetooth}# sdptool browse 00:0A:0A:AA:AA:AA
Failed to connect to SDP server on 00:0A:0A:AA:AA:AA  : Permission =
denied

What   is   happen?  Why  does headset deny permission? Should I enter  =
PIN number to tell headset ,or  others solution?

Please help me , thank you very much.











------=_NextPart_000_0025_01C3F5A0.F39DBF80
Content-Type: text/html;
	charset="big5"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META http-equiv=3DContent-Type content=3D"text/html; charset=3Dbig5">
<META content=3D"MSHTML 6.00.2800.1400" name=3DGENERATOR>
<STYLE></STYLE>
</HEAD>
<BODY bgColor=3D#ffffff>
<DIV><FONT size=3D2>Hi&nbsp; everybody:</FONT></DIV>
<DIV><FONT size=3D2>I&nbsp; find&nbsp; a small problem&nbsp;which =
&nbsp;Bluez=20
communicate to headset.</FONT></DIV>
<DIV><FONT size=3D2>&nbsp;I&nbsp; have a PC(red hat linux8.0), and =
headset(=20
sony&nbsp;ericsson HBH-65).</FONT></DIV>
<DIV><FONT size=3D2>And I inital bluez;</FONT></DIV>
<DIV><FONT size=3D2>[root@Bluez bluetooth}#&nbsp; hcid</FONT></DIV>
<DIV><FONT size=3D2>[root@Bluez =
bluetooth}#&nbsp;&nbsp;hciconfig</FONT></DIV>
<DIV><FONT size=3D2>hci0:&nbsp; Type:USB</FONT></DIV>
<DIV><FONT =
size=3D2>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;BD=20
Address:&nbsp; 00:AA:.................</FONT></DIV>
<DIV><FONT size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT size=3D2>[root@Bluez bluetooth}#&nbsp; hcitool&nbsp; =
scan</FONT></DIV>
<DIV><FONT size=3D2>Scanning ...</FONT></DIV>
<DIV><FONT=20
size=3D2>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;=20
00:0A:0A:AA:AA:AA&nbsp;&nbsp;&nbsp;&nbsp; HBH-65</FONT></DIV>
<DIV><FONT size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT size=3D2>
<DIV><FONT size=3D2>[root@Bluez bluetooth}#&nbsp;modprobe&nbsp; =
l2cap</FONT></DIV>
<DIV><FONT size=3D2>[root@Bluez bluetooth}#&nbsp; modprobe&nbsp;=20
rfcomm</FONT></DIV></FONT></DIV>
<DIV><FONT size=3D2>
<DIV><FONT size=3D2>
<DIV><FONT size=3D2>[root@Bluez bluetooth}#&nbsp; l2ping=20
00:0A:0A:AA:AA:AA</FONT></DIV>
<DIV><STRONG><EM>Can't connect. : Permission denied</EM></STRONG></DIV>
<DIV><FONT size=3D2>[root@Bluez bluetooth}#&nbsp;sdptool browse=20
00:0A:0A:AA:AA:AA</FONT></DIV>
<DIV><STRONG>Failed to connect to SDP server on 00:0A:0A:AA:AA:AA&nbsp; =
:=20
Permission denied</STRONG></DIV></FONT></DIV></FONT></DIV>
<DIV><FONT size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT size=3D2>What&nbsp;&nbsp; is&nbsp;&nbsp; happen?&nbsp; =
Why&nbsp; does=20
headset deny permission?&nbsp;Should I enter &nbsp;PIN number to tell =
headset=20
,or&nbsp; others solution?</FONT></DIV>
<DIV><FONT size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT size=3D2>Please help me , thank you very much.</FONT></DIV>
<DIV><FONT size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT size=3D2></FONT>&nbsp;</DIV></BODY></HTML>

------=_NextPart_000_0025_01C3F5A0.F39DBF80--



-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
