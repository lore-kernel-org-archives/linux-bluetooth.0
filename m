Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: "Deepesh S Gujarathi" <d_gujarathi@hotmail.com>
To: <bluez-devel@lists.sourceforge.net>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_NextPart_000_0098_01C3C006.AACF6080"
Message-ID: <Law11-OE56C4Mkg3fDM00007728@hotmail.com>
Subject: [Bluez-devel] HID testing
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
Date: Thu, 11 Dec 2003 16:48:56 +0530

This is a multi-part message in MIME format.

------=_NextPart_000_0098_01C3C006.AACF6080
Content-Type: text/plain;
	charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable


Hi Folks,

I have been playing around with the BlueZ stack for last couple of days =
and I would say that you guys have done an wonderful job. The stack =
appears to be fairly stable and rich with features and tools. However =
the most important feature is the socket interface provided which is =
missing in other stacks. Kudos to Max, Marcel at rest of the team.

Also I have tested the stack to work with TDK,EPoX,Belkin dongles =
without a hitch. Maybe these brands can be updated on the "BlueZ =
Supported hardware" page.

I am working on the developing HID profile (firmware) for a pointing =
device and utilising BlueZ as a host side testing tool.

I would appreciate few pointers for the following.

1. What could be the best way to test the HID device firmware from the =
host side using BlueZ ? I believe there are two alternatives, the bthid =
program by Peter and an alternate hid program by Marcel. I was not =
successful in getting the bthid working. My system is Mandrake 9.2 with =
Linux 2.4.21-0.13mdk and I have installed BlueZ from rpms. Basically I =
want to test my HID firmware implementation for HID compliance.

2. Is there a way to disconnect individual L2CAP connection from within =
user space program ? I saw a call  l2cap_sock_close in l2cap.c file, is =
there a way to call this function from a user program. I have already =
tried to use the close(socket) call but it closes down the ACL =
connection instead of closing the _individual_ L2CAP connection.

do advise....

thanks
Saturn
------=_NextPart_000_0098_01C3C006.AACF6080
Content-Type: text/html;
	charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META http-equiv=3DContent-Type content=3D"text/html; =
charset=3Dwindows-1252">
<META content=3D"MSHTML 6.00.2800.1106" name=3DGENERATOR>
<STYLE></STYLE>
</HEAD>
<BODY bgColor=3D#ffffff>
<DIV><FONT size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT size=3D2>Hi Folks,</FONT></DIV>
<DIV><FONT size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT size=3D2>I have been playing around with the BlueZ stack for =
last=20
couple of days and I would say that you guys have done an&nbsp;wonderful =
job.=20
The stack appears to be fairly stable and rich with features and tools. =
However=20
the most important feature is the socket interface provided which is =
missing in=20
other stacks. Kudos to Max, Marcel at rest of the team.</FONT></DIV>
<DIV><FONT size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT size=3D2>Also I have tested the stack to work with =
TDK,EPoX,Belkin=20
dongles without a hitch. Maybe these brands can be updated on the "BlueZ =

Supported hardware" page.</FONT></DIV>
<DIV><FONT size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT size=3D2>I&nbsp;am working on the&nbsp;developing HID profile =

(firmware)&nbsp;for a pointing device and utilising BlueZ as a host side =
testing=20
tool.</FONT></DIV>
<DIV><FONT size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT size=3D2>I would appreciate few pointers for the=20
following.</FONT></DIV>
<DIV><FONT size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT size=3D2>1. What could be the best way to test the HID device =
firmware=20
from the host side using BlueZ ? I believe there are two alternatives, =
the bthid=20
program by Peter and an alternate hid program&nbsp;by Marcel. =
</FONT><FONT=20
size=3D2>I was not successful in getting the bthid working. My system is =
Mandrake=20
9.2 with Linux 2.4.21-0.13mdk and I have installed BlueZ from rpms. =
Basically I=20
want to test my HID firmware implementation for HID =
compliance.</FONT></DIV>
<DIV><FONT size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT size=3D2>2. Is there a way to disconnect individual L2CAP =
connection=20
from within user space program ? I saw a call&nbsp; =
l2cap_sock_close&nbsp;in=20
l2cap.c file, is there a way to call this function from a user program. =
I have=20
already tried to use the close(socket)&nbsp;call but it closes down the =
ACL=20
connection instead of closing the _individual_ L2CAP=20
connection.</FONT></DIV><FONT size=3D2></FONT>
<DIV><FONT size=3D2></FONT><FONT size=3D2></FONT><FONT =
size=3D2></FONT><FONT=20
size=3D2></FONT><FONT size=3D2></FONT><FONT size=3D2></FONT><FONT =
size=3D2></FONT><FONT=20
size=3D2></FONT><FONT size=3D2></FONT><FONT size=3D2></FONT><BR><FONT =
size=3D2>do=20
advise....</FONT></DIV>
<DIV><FONT size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT size=3D2>thanks</FONT></DIV>
<DIV><FONT size=3D2>Saturn</FONT></DIV></BODY></HTML>

------=_NextPart_000_0098_01C3C006.AACF6080--


-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?  SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
