Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <001901c5cfe1$29a64180$6701a8c0@mainframe>
From: "Jonathan Leong" <aptos@gmx.net>
To: <bluez-users@lists.sourceforge.net>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_NextPart_000_0016_01C5D024.3606E9F0"
Subject: [Bluez-users] Help with Digianswer protocol analyzer
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
Reply-To: bluez-users@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Thu, 13 Oct 2005 18:30:39 +0800

This is a multi-part message in MIME format.

------=_NextPart_000_0016_01C5D024.3606E9F0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hello,

I have a digianswer protocol analyzer connected to my computer via usb.
Problem is I can't seem to get it up running.

hciconfig -a , produces the following

hci0:    Type: USB
            BD Address: 00:00:00:00:00:00 ACL MTU: 0 :0 SCO MTU: 0:0
            DOWN

hciconfig hci0 up

Can't init device hci0: Commection timed out (110)

I am currently slackware 2.6.11.8, with bluez-libs 2.21 installed.

lsmod displays the following

hci_usb            14344    0
bluetooth          43268    1    hci_usb


I'm guessing it detects the device but I havent got the right driver =
loaded?


Warmest Regards,

Jonathan Leong
------=_NextPart_000_0016_01C5D024.3606E9F0
Content-Type: text/html;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META http-equiv=3DContent-Type content=3D"text/html; =
charset=3Diso-8859-1">
<META content=3D"MSHTML 6.00.2900.2604" name=3DGENERATOR>
<STYLE></STYLE>
</HEAD>
<BODY bgColor=3D#ffffff>
<DIV><FONT face=3DArial size=3D2>Hello,</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>I have a digianswer protocol analyzer =
connected to=20
my computer via usb.</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>Problem is I can't seem to get it up=20
running.</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>hciconfig -a , produces the =
following</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>hci0:&nbsp;&nbsp;&nbsp; Type: =
USB</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;=20
&nbsp;&nbsp;&nbsp; BD Address: 00:00:00:00:00:00 ACL MTU: 0 :0 SCO MTU:=20
0:0</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>&nbsp;&nbsp;&nbsp; &nbsp;&nbsp;&nbsp;=20
&nbsp;&nbsp;&nbsp; DOWN</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>hciconfig hci0 up</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>Can't init device hci0: Commection =
timed out=20
(110)</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>I am currently slackware 2.6.11.8, with =
bluez-libs=20
2.21 installed.</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>lsmod displays the =
following</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>hci_usb&nbsp;&nbsp;&nbsp; =
&nbsp;&nbsp;&nbsp;=20
&nbsp;&nbsp;&nbsp; 14344&nbsp;&nbsp;&nbsp; 0</FONT></DIV>
<DIV><FONT face=3DArial=20
size=3D2>bluetooth&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&=
nbsp;43268&nbsp;&nbsp;&nbsp;=20
1&nbsp;&nbsp;&nbsp; hci_usb</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>I'm guessing it detects the device but =
I havent got=20
the right driver loaded?</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>Warmest Regards,</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>Jonathan =
Leong</FONT></DIV></BODY></HTML>

------=_NextPart_000_0016_01C5D024.3606E9F0--



-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
