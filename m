Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <00a101c4c029$2c66e730$2301a8c0@boris>
From: =?iso-8859-1?Q?Boris_W=FCst?= <Boris.Wuest@HdM-Stuttgart.de>
To: <bluez-devel@lists.sourceforge.net>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_NextPart_000_009E_01C4C031.8A1F3CD0"
Subject: [Bluez-devel] Development of a Bluetooth-LAN-Accesspoint
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
Date: Mon, 1 Nov 2004 16:40:47 +0100

This is a multi-part message in MIME format.

------=_NextPart_000_009E_01C4C031.8A1F3CD0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi folks,

still i have more a logical than a technical problem. i hope someone can =
help:

we (my projectteam) want to develop an bluetooth-lan-accesspoint based =
on the BlueTarget-Controller from SND (perhaps someone knows the =
controller) for our university. i have thought about to use the =
rfcomm-layer to handle the connections and the low level data transfer. =
on top of the rfcomm-connections i want to set up an normal =
ppp-connection. speaks something against this concept? have anyone a =
better solution?

now to the problem(s):

(1) we want to design an accesspoint that connects automatically to all =
bt-devices that are located in its range, so that a lan-access supported =
immediately and it's guaranteed that the bt-accesspoint is the master at =
all communications? how can we implement an automatic connection =
establishment on the rfcomm-layer and how we can make sure that the =
bt-accesspoint is always master that parks and activates the devices =
automatically depended on the data transfer(so that can be more devices =
than 7 connected to the lan)? what do we have to consider with the =
authentication? can we avoid it or switch it off at both sides of =
connection? when the connections established how we can manage them and =
the different channels to the connections?

(2) when we use a ppp-connection from bt-devices to the accesspoint, =
every device needs an ip and the accesspoint as gateway. how can we =
realize the assignment of the ip-adresses an the gateway to the =
bt-devices controlled by the accesspoint? the major problem at this =
concept is that the BlueTarget-Controller is a pure microcontroller an =
provides a own bt-stack. so on it can't be run services how pppd or =
pand. but the controller as an lan-interface and must therefor =
understand tcp/ip. how we can emulate a ppp-connection with a =
bt-stack(bluez) avoiding high expense of development? are there some =
documentations and/or program examples about this topic?? have anyone =
implemented something compareable??

(3)the last problem is the connection speed. we have set up an test =
environment composed of a PDA and a linuxsystem with the bluez-stack and =
a bt-usb-donlge. we have only achieved max. 16KB/s at the best =
bt-connection qualtity, only one bt-connection and ACL. why can't we =
achieve approximately the max. speed (95KB/s) of the connection? how =
does it look with serveral connections? share all connections these =
16KB/s? how we can advance the connection-speed? is one possibility to =
use more than one rfcomm-connection (more than one channel) for a =
ppp-connection? have anyone a solution?

i hope you guys can help me with these problems. perhaps also by =
documentations of previous projects or links to the web. when someone of =
you have a lot of experience in the development in this direction, i =
would be grateful when you lend yourself as permanent contact person. =
thanks to everyone who helps ;D

best regards, Boris

p.s.: plz apologize my weird englisch *g*

------=_NextPart_000_009E_01C4C031.8A1F3CD0
Content-Type: text/html;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META http-equiv=3DContent-Type content=3D"text/html; =
charset=3Diso-8859-1">
<META content=3D"MSHTML 6.00.2800.1476" name=3DGENERATOR>
<STYLE></STYLE>
</HEAD>
<BODY bgColor=3D#ffffff>
<DIV><FONT face=3DArial size=3D2>
<DIV><FONT face=3DArial size=3D2>
<P>Hi folks,</P>
<P>still i have more a logical than a technical problem. i hope someone =
can=20
help:</P>
<P>we (my projectteam) want to develop an bluetooth-lan-accesspoint =
based on the=20
BlueTarget-Controller from SND (perhaps someone knows the controller) =
for our=20
university. i have thought about to use the rfcomm-layer to handle the=20
connections and the low level data transfer. on top of the =
rfcomm-connections i=20
want to set up an normal ppp-connection. speaks something against this =
concept?=20
have anyone a better solution?</P>
<P>now to the problem(s):</P>
<P>(1) we want to design an accesspoint that connects automatically to =
all=20
bt-devices that are located in its range, so that a lan-access supported =

immediately and it's guaranteed that the bt-accesspoint is the master at =
all=20
communications? how can we implement an automatic connection =
establishment on=20
the rfcomm-layer and how we can make sure that the bt-accesspoint is =
always=20
master that parks and activates the devices automatically depended on =
the data=20
transfer(so that can be more devices than 7 connected to the lan)? what =
do we=20
have to consider with the authentication? can we avoid it or switch it =
off at=20
both sides of connection? when the connections established how we can =
manage=20
them and the different channels to the connections?</P>
<P>(2) when we use a ppp-connection from bt-devices to the accesspoint, =
every=20
device needs an ip and the accesspoint as gateway. how can we realize =
the=20
assignment of the ip-adresses an the gateway to the bt-devices =
controlled by the=20
accesspoint? the major problem at this concept is that the =
BlueTarget-Controller=20
is a pure microcontroller an provides a own bt-stack. so on it can't be =
run=20
services how pppd or pand. but the controller as an lan-interface and =
must=20
therefor understand tcp/ip. how we can emulate a ppp-connection with a=20
bt-stack(bluez) avoiding high expense of development? are there some=20
documentations and/or program examples about this topic?? have anyone=20
implemented something compareable??</P>
<P>(3)the last problem is the connection speed. we have set up an test=20
environment composed of a PDA and a linuxsystem with the bluez-stack and =
a=20
bt-usb-donlge. we have only achieved max. 16KB/s at the best =
bt-connection=20
qualtity, only one bt-connection and ACL. why can't we achieve =
approximately the=20
max. speed (95KB/s) of the connection? how does it look with serveral=20
connections? share all connections these 16KB/s? how we can advance the=20
connection-speed? is one possibility to use more than one =
rfcomm-connection=20
(more than one channel) for a ppp-connection? have anyone a =
solution?</P>
<P>i hope you guys can help me with these problems. perhaps also by=20
documentations of previous projects or links to the web. when someone of =
you=20
have a lot of experience in the development in this direction, i would =
be=20
grateful when you lend yourself as permanent contact person. thanks to =
everyone=20
who helps ;D</P><FONT face=3DArial size=3D2>
<P>best regards, Boris</P>
<P>p.s.: plz apologize my weird englisch=20
*g*</P></FONT></FONT></DIV></FONT></DIV></BODY></HTML>

------=_NextPart_000_009E_01C4C031.8A1F3CD0--



-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
