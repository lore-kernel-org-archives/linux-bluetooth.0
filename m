Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: "Andrew Jones" <andrewjones@acselection.co.uk>
To: <bluez-users@lists.sourceforge.net>
Message-ID: <!~!UENERkVCMDkAAQACAAAAAAAAAAAAAAAAABgAAAAAAAAAkBwT9CxMpEGdJ0wBhZZ8JcKAAAAQAAAA6dBpOZC2R0mjNYo5QIcv4QEAAAAA@acselection.co.uk>
MIME-Version: 1.0
Content-Type: multipart/alternative;boundary="----=_NextPart_000_0056_01C5772B.92D419C0"
Subject: [Bluez-users] FW: bt3c_cs Module & bluez-bluefw
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
Date: Wed, 22 Jun 2005 13:09:07 +0100

This is a multi-part message in MIME format.

------=_NextPart_000_0056_01C5772B.92D419C0
Content-Type: text/plain;charset="iso-8859-1"
Content-Transfer-Encoding: 7bit

Good afternoon,
I am writing to enquire about an issue I'm having, it is as follows. I
have a Sony Vaio Laptop (VGN-B1XP) with Ubuntu Linux installed
(2.6.10-5-386) and a 3Com Bluetooth Card (3CRWB6096), I have installed
all of the bluez utilities and unzipped the firmware file from 3Com
(BT3CPCC.bin), when i insert the card i get the following error is
dmesg: 
 
bt3c_open: Firmware request failed 
bt3c_interrupt: Call if irq 3 for unknown device
 
And in syslog:
 
kernel: cs: pcmcia_socket: unable to supply power
cardmgr[6912]: socket 0: 3Com Bluetooth PC Card
cardmgr[6912]: executing: 'modprobe bt3c_cs'
kernel: bt3c_open: Firmware request failed 
kernel: bt3c_interrupt: Call if irq 3 for unknown device
cardmgr[6912]: get dev info on socket 0 failed: Resource temporarily
unavailable
 
It seems to me that the issue is that bt3c_cs cannot find the firmware
file, although i have tried everywhere noted on the net. I have also
tried changing the reference in bt3c_cs from BT3CPCC.bin to /T3CPCC.bin
and dropping that file in the system root.
 
I think its looking (for the firmare) somewhere specific to Ubuntu but i
can't find where.
 
If you have any ideas they would be greatly appreciated.
Many thanks,
 
Andy Jones


--------------------------------------------------------------------------------------------
This message contains confidential information and is intended only for the individual named.
If you are not the named addressee you should not disseminate, distribute or copy this e-mail.
Please notify the sender immediately by e-mail if you have received this e-mail by mistake and
delete this e-mail from your system. E-Mail transmission cannot be guaranteed to be secure or
error-free as information could be intercepted, corrupted, lost, destroyed, arrive late or 
incomplete, or contain viruses. The sender therefore does not accept liability for any errors
or omissions in the contents of this message, which arise as a result of e-mail transmission.
If verification is required please request a hard-copy version.
AC Selection Ltd. The Avenue, The Cross, Worcester, WR1 3QA. www.acselection.co.uk

------=_NextPart_000_0056_01C5772B.92D419C0
Content-Type: text/html;charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; =
charset=3Diso-8859-1">
<TITLE>Message</TITLE>

<META content=3D"MSHTML 6.00.2800.1498" name=3DGENERATOR></HEAD>
<BODY>
<DIV><FONT face=3DArial color=3D#0000ff size=3D2>Good afternoon,<BR>I am =
writing to=20
enquire about an issue I'm having, it is as follows. I have a Sony Vaio =
Laptop=20
(VGN-B1XP) with Ubuntu Linux installed (2.6.10-5-386) and a 3Com =
Bluetooth Card=20
(3CRWB6096), I have installed all of the bluez utilities and unzipped =
the=20
firmware file from 3Com (BT3CPCC.bin), when i insert the card i get the=20
following error is dmesg: </FONT></DIV>
<DIV>&nbsp;</DIV>
<DIV><FONT face=3DArial color=3D#0000ff size=3D2>bt3c_open: Firmware =
request failed=20
<BR>bt3c_interrupt: Call if irq 3 for unknown device</FONT></DIV>
<DIV>&nbsp;</DIV>
<DIV><FONT face=3DArial color=3D#0000ff size=3D2>And in =
syslog:</FONT></DIV>
<DIV>&nbsp;</DIV>
<DIV><FONT face=3DArial color=3D#0000ff size=3D2>kernel: cs: =
pcmcia_socket: unable to=20
supply power<BR>cardmgr[6912]: socket 0: 3Com Bluetooth PC=20
Card<BR>cardmgr[6912]: executing: 'modprobe bt3c_cs'<BR>kernel: =
bt3c_open:=20
Firmware request failed <BR>kernel: bt3c_interrupt: Call if irq 3 for =
unknown=20
device<BR>cardmgr[6912]: get dev info on socket 0 failed: Resource =
temporarily=20
unavailable</FONT></DIV>
<DIV>&nbsp;</DIV>
<DIV><FONT face=3DArial color=3D#0000ff size=3D2>It seems to me that the =
issue is that=20
bt3c_cs cannot find the firmware file, although i have tried everywhere =
noted on=20
the net. I have also tried changing the reference in bt3c_cs from =
BT3CPCC.bin to=20
/T3CPCC.bin and dropping that file in the system root.</FONT></DIV>
<DIV>&nbsp;</DIV>
<DIV><FONT face=3DArial color=3D#0000ff size=3D2>I think its looking =
(for the firmare)=20
somewhere specific to Ubuntu but i can't find where.</FONT></DIV>
<DIV>&nbsp;</DIV>
<DIV><FONT face=3DArial color=3D#0000ff size=3D2>If you have any ideas =
they would be=20
greatly appreciated.<BR>Many thanks,</FONT></DIV>
<DIV>&nbsp;</DIV>
<DIV><FONT face=3DArial color=3D#0000ff size=3D2>Andy =
Jones</FONT></DIV><BR>

--------------------------------------------------------------------------------------------
This message contains confidential information and is intended only for the individual named.
If you are not the named addressee you should not disseminate, distribute or copy this e-mail.
Please notify the sender immediately by e-mail if you have received this e-mail by mistake and
delete this e-mail from your system. E-Mail transmission cannot be guaranteed to be secure or
error-free as information could be intercepted, corrupted, lost, destroyed, arrive late or 
incomplete, or contain viruses. The sender therefore does not accept liability for any errors
or omissions in the contents of this message, which arise as a result of e-mail transmission.
If verification is required please request a hard-copy version.
AC Selection Ltd. The Avenue, The Cross, Worcester, WR1 3QA. www.acselection.co.uk
<BR></BODY></HTML>

------=_NextPart_000_0056_01C5772B.92D419C0--



-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
