Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: "Han Hoekstra" <Han.Hoekstra@WirelessValue.nl>
To: <bluez-users@lists.sourceforge.net>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_NextPart_000_0000_01C52AFD.EEDADB20"
Message-ID: <E1DBv62-0004qg-Ld@sc8-sf-mx1.sourceforge.net>
Subject: [Bluez-users] Has anyone seen these problems with the CSR BlueCore and BlueZ before ?
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
Date: Thu, 17 Mar 2005 14:30:56 +0100

This is a multi-part message in MIME format.

------=_NextPart_000_0000_01C52AFD.EEDADB20
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit

Hey All,
 
I'm developping an application on an ARM-7 based platform which is running
Linux 2.4.18 with the latest BlueZ version for that platform. In this
application there is a master device that can connect to up to 7 slaves
(master and slave devices are all the same, the external controller
determines which is master).
 
The application does the following, the external controller on the master
can send a single command to the Linux application, in the command is an
address field identifying to which slaves the command must be passed on. A
slave will pass the command on to its external controller, which will
respond to the command by sending a reply back to the Linux slave, which in
turn passes it on to the Linux master and is then handed over to the
external controller again. As soon as all addressed slaves have responded,
the sequence is repeated.
 
Now to what I see happening, when I run this with 5 slaves, I don't see any
problems for more than an hour, but when I run it with 6 or 7 slaves, I see
that the BlueCore resets itself, with 6 slaves after about 40 minutes and
with 7 slaves already after 5 to 10 minutes. When I eliminate the CRC check
I can run the 7 slaves configuration for up to about 40 minutes after it
crashes.
 
What I think happens is that the BlueCore receives data to fast over the air
and can not pass it on to the Linux CPU quick enough, so there is an
internal overflow in the BlueCore.
Communication between the BlueCore and the Linux CPU is done via BCSP at a
speed of 921600 baud.
 
Has anybody seen behaviour like this before and is there something I can do
about it ???
 
Greetings,
   Han
 
---
Han Hoekstra
Wireless Value B.V.
Waanderweg 30a
7812 HZ  Emmen
Tel: +31-591-633200
 

------=_NextPart_000_0000_01C52AFD.EEDADB20
Content-Type: text/html;
	charset="US-ASCII"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META http-equiv=3DContent-Type content=3D"text/html; =
charset=3Dus-ascii">
<META content=3D"MSHTML 6.00.2900.2604" name=3DGENERATOR></HEAD>
<BODY>
<DIV><SPAN class=3D156262013-17032005><FONT face=3DArial size=3D2>Hey=20
All,</FONT></SPAN></DIV>
<DIV><SPAN class=3D156262013-17032005><FONT face=3DArial=20
size=3D2></FONT></SPAN>&nbsp;</DIV>
<DIV><SPAN class=3D156262013-17032005><FONT face=3DArial size=3D2>I'm =
developping an=20
application on an ARM-7 based platform which is running Linux 2.4.18 =
with the=20
latest BlueZ version for that platform. In this application there is a =
master=20
device that can connect to up to 7 slaves (master and slave devices are =
all the=20
same, the external controller determines which is =
master).</FONT></SPAN></DIV>
<DIV><SPAN class=3D156262013-17032005><FONT face=3DArial=20
size=3D2></FONT></SPAN>&nbsp;</DIV>
<DIV><SPAN class=3D156262013-17032005><FONT face=3DArial size=3D2>The =
application does=20
the following, the external controller on the master can send a single =
command=20
to the Linux application, in the command is an address field identifying =
to=20
which slaves the command must be passed on. A slave will pass the =
command on to=20
its external controller, which will respond to the command by sending a =
reply=20
back to the Linux slave, which in turn passes it on to the Linux master =
and is=20
then handed over to the external controller again. As soon as all =
addressed=20
slaves have responded, the sequence is repeated.</FONT></SPAN></DIV>
<DIV><SPAN class=3D156262013-17032005><FONT face=3DArial=20
size=3D2></FONT></SPAN>&nbsp;</DIV>
<DIV><SPAN class=3D156262013-17032005><FONT face=3DArial size=3D2>Now to =
what I see=20
happening, when I run this with 5 slaves, I don't see any problems for =
more than=20
an hour, but when I run it with 6 or 7 slaves, I see that the BlueCore =
resets=20
itself, with 6 slaves after about 40 minutes and with 7 slaves already =
after 5=20
to 10 minutes. When I eliminate the CRC check I can run the 7 slaves=20
configuration for up to about 40 minutes after it =
crashes.</FONT></SPAN></DIV>
<DIV><SPAN class=3D156262013-17032005><FONT face=3DArial=20
size=3D2></FONT></SPAN>&nbsp;</DIV>
<DIV><SPAN class=3D156262013-17032005><FONT face=3DArial size=3D2>What I =
think happens=20
is that the BlueCore receives data to fast over the air and can not pass =
it on=20
to the Linux CPU quick enough, so there is an internal overflow in the=20
BlueCore.</FONT></SPAN></DIV>
<DIV><SPAN class=3D156262013-17032005><FONT face=3DArial =
size=3D2>Communication=20
between the BlueCore and the Linux CPU is done via BCSP at a speed of =
921600=20
baud.</FONT></SPAN></DIV>
<DIV><SPAN class=3D156262013-17032005><FONT face=3DArial=20
size=3D2></FONT></SPAN>&nbsp;</DIV>
<DIV><SPAN class=3D156262013-17032005><FONT face=3DArial size=3D2>
<DIV><SPAN class=3D156262013-17032005><FONT face=3DArial size=3D2>Has =
anybody seen=20
behaviour like this before and is there something I can do about it=20
???</FONT></SPAN></DIV>
<DIV><SPAN class=3D156262013-17032005></SPAN>&nbsp;</DIV>
<DIV><SPAN class=3D156262013-17032005>Greetings,</SPAN></DIV>
<DIV><SPAN class=3D156262013-17032005>&nbsp;&nbsp;=20
Han</SPAN></DIV></FONT></SPAN></DIV>
<DIV>&nbsp;</DIV>
<DIV align=3Dleft><FONT face=3DArial size=3D2>---</FONT></DIV>
<DIV align=3Dleft><FONT face=3DArial size=3D2>Han Hoekstra</FONT></DIV>
<DIV align=3Dleft><FONT face=3DArial size=3D2>Wireless Value =
B.V.</FONT></DIV>
<DIV align=3Dleft><FONT face=3DArial size=3D2>Waanderweg =
30a</FONT></DIV>
<DIV align=3Dleft><FONT face=3DArial size=3D2>7812 HZ&nbsp; =
Emmen</FONT></DIV>
<DIV align=3Dleft><FONT face=3DArial size=3D2>Tel: =
+31-591-633200</FONT></DIV>
<DIV>&nbsp;</DIV></BODY></HTML>

------=_NextPart_000_0000_01C52AFD.EEDADB20--



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
