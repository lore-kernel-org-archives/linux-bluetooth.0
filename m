Return-Path: <bluez-users-admin@lists.sourceforge.net>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C55AE3.CF40F928"
Subject: RE: [Bluez-users] 3COM PCMCIA Bluetooth question
Message-ID: <B7A120329D087840A54E2A221FCCE8D074732C@PSCMAIL01.rochester.itsphoenix.com>
From: "John G. Moose" <jmoose@itsphoenix.com>
To: <bluez-users@lists.sourceforge.net>
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
Date: Tue, 17 May 2005 09:24:53 -0400

This is a multi-part message in MIME format.

------_=_NextPart_001_01C55AE3.CF40F928
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Marcel,
=20
Yes, I see two new tty devices:
=20
ttyS03  at  port  0xF6000000  (irq =3D 153)  is  a  16C950/954
ttyS04  at  port  0xF6000008  (irq =3D 153)  is  a  8250
=20
John

=20
________________________________

From: bluez-users-admin@lists.sourceforge.net on behalf of Marcel =
Holtmann
Sent: Tue 5/17/2005 7:28 AM
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] 3COM PCMCIA Bluetooth question



Hi John,

> Can anyone provide some insight/directions/help getting the 3COM
> Bluetooth PCMCIA
> card ( 3CRWB6096B  ver3 ) to work with Debian Linux at kernel version
> 2.4.27.vrs1 running
> on an arm-linux platform (PXA255 Xscale w/ SA1111 I/O processor).
> Should this device 'just work' at this kernel level provided config
> files are correct??

do you see another ttySx device when you call dmesg after you plugged in
this card? Check your syslog to see what happens.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by Oracle Space Sweepstakes
Want to be the first software developer in space?
Enter now for the Oracle Space Sweepstakes!
http://ads.osdn.com/?ad_id=3D7412&alloc_id=3D16344&op=3Dclick
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users



------_=_NextPart_001_01C55AE3.CF40F928
Content-Type: text/html;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; =
charset=3Diso-8859-1">=0A=
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2//EN">=0A=
<HTML>=0A=
<HEAD>=0A=
=0A=
<META NAME=3D"Generator" CONTENT=3D"MS Exchange Server version =
6.5.7226.0">=0A=
<TITLE>Re: [Bluez-users] 3COM PCMCIA Bluetooth question</TITLE>=0A=
</HEAD>=0A=
<BODY>=0A=
<DIV id=3DidOWAReplyText32208 dir=3Dltr>=0A=
<DIV dir=3Dltr><FONT face=3DArial color=3D#000000 =
size=3D2>Marcel,</FONT></DIV>=0A=
<DIV dir=3Dltr><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>=0A=
<DIV dir=3Dltr><FONT face=3DArial size=3D2>Yes, I see two new tty =0A=
devices:</FONT></DIV>=0A=
<DIV dir=3Dltr><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>=0A=
<DIV dir=3Dltr><FONT face=3DArial size=3D2>ttyS03&nbsp; at&nbsp; =
port&nbsp; =0A=
0xF6000000&nbsp; (irq =3D 153)&nbsp; is&nbsp; a&nbsp; =
16C950/954</FONT></DIV>=0A=
<DIV dir=3Dltr><FONT face=3DArial size=3D2>ttyS04&nbsp; at&nbsp; =
port&nbsp; =0A=
0xF6000008&nbsp; (irq =3D 153)&nbsp; is&nbsp; a&nbsp; =
8250</FONT></DIV></DIV>=0A=
<DIV dir=3Dltr>&nbsp;</DIV>=0A=
<DIV dir=3Dltr>John</DIV>=0A=
<DIV dir=3Dltr><BR>&nbsp;</DIV>=0A=
<DIV dir=3Dltr>=0A=
<HR tabIndex=3D-1>=0A=
</DIV>=0A=
<DIV dir=3Dltr><FONT face=3DTahoma size=3D2><B>From:</B> =0A=
bluez-users-admin@lists.sourceforge.net on behalf of Marcel =0A=
Holtmann<BR><B>Sent:</B> Tue 5/17/2005 7:28 AM<BR><B>To:</B> =0A=
bluez-users@lists.sourceforge.net<BR><B>Subject:</B> Re: [Bluez-users] =
3COM =0A=
PCMCIA Bluetooth question<BR></FONT><BR></DIV>=0A=
<DIV>=0A=
<P><FONT size=3D2>Hi John,<BR><BR>&gt; Can anyone provide some =0A=
insight/directions/help getting the 3COM<BR>&gt; Bluetooth =
PCMCIA<BR>&gt; card ( =0A=
3CRWB6096B&nbsp; ver3 ) to work with Debian Linux at kernel =
version<BR>&gt; =0A=
2.4.27.vrs1 running<BR>&gt; on an arm-linux platform (PXA255 Xscale w/ =
SA1111 =0A=
I/O processor).<BR>&gt; Should this device 'just work' at this kernel =
level =0A=
provided config<BR>&gt; files are correct??<BR><BR>do you see another =
ttySx =0A=
device when you call dmesg after you plugged in<BR>this card? Check your =
syslog =0A=
to see what =0A=
happens.<BR><BR>Regards<BR><BR>Marcel<BR><BR><BR><BR><BR>----------------=
---------------------------------------<BR>This =0A=
SF.Net email is sponsored by Oracle Space Sweepstakes<BR>Want to be the =
first =0A=
software developer in space?<BR>Enter now for the Oracle Space =0A=
Sweepstakes!<BR><A =0A=
href=3D"http://ads.osdn.com/?ad_id=3D7412&amp;alloc_id=3D16344&amp;op=3Dc=
lick">http://ads.osdn.com/?ad_id=3D7412&amp;alloc_id=3D16344&amp;op=3Dcli=
ck</A><BR>_______________________________________________<BR>Bluez-users =0A=
mailing list<BR>Bluez-users@lists.sourceforge.net<BR><A =0A=
href=3D"https://lists.sourceforge.net/lists/listinfo/bluez-users">https:/=
/lists.sourceforge.net/lists/listinfo/bluez-users</A><BR></FONT></P></DIV=
>=0A=
=0A=
</BODY>=0A=
</HTML>
------_=_NextPart_001_01C55AE3.CF40F928--


-------------------------------------------------------
This SF.Net email is sponsored by Oracle Space Sweepstakes
Want to be the first software developer in space?
Enter now for the Oracle Space Sweepstakes!
http://ads.osdn.com/?ad_id=7412&alloc_id=16344&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
