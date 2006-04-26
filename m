Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <015001c66921$76fe4390$030c1fc0@uranus>
From: "Thomas Brandl" <t.brandl@gmx.at>
To: <bluez-users@lists.sourceforge.net>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_NextPart_000_014D_01C66932.3A038BB0"
Subject: [Bluez-users] Rfcomm Problems
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
Date: Wed, 26 Apr 2006 13:06:26 +0200

This is a multi-part message in MIME format.

------=_NextPart_000_014D_01C66932.3A038BB0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hallo;

I have a problem concerning rfcomm conenction. Hopefully somebody can =
help me ;-))

Following Problem:=20

After=20
sdptool add --channel=3D2 SP, and
rfcomm listen rfcomm0 (I put it in an infinite loop so that reconnection =
will establish automatically)
I am waiting for an incoming connection. This connection is availiable =
after a few seconds. So no problems so far.=20

My problem now.=20
I have an application listening on rfcomm0, if something happens that =
causes an disconnection (with following reconnection) my apllication is =
not be able to receive from dev/rfcomm0=20

You can test it with simple cat /dev/rfcomm0. After disconnection cat is =
closing.=20
I need that cat /dev/rfcomm0 is kept open. Would it be possible to link =
to a specific script which is able to handle this?? Any other =
proposals??

Thanks

Thomas=20

------=_NextPart_000_014D_01C66932.3A038BB0
Content-Type: text/html;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META http-equiv=3DContent-Type content=3D"text/html; =
charset=3Diso-8859-1">
<META content=3D"MSHTML 6.00.2900.2873" name=3DGENERATOR>
<STYLE></STYLE>
</HEAD>
<BODY bgColor=3D#ffffff>
<DIV><FONT face=3DArial size=3D2>Hallo;</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>I have a problem concerning rfcomm =
conenction.=20
Hopefully somebody can help me ;-))</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>
<DIV><FONT face=3DArial size=3D2>Following Problem: </FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>After </FONT></DIV>
<DIV>sdptool add --channel=3D2 SP, and</DIV>
<DIV>rfcomm listen rfcomm0 (I put it in an infinite loop so that =
reconnection=20
will establish automatically)</DIV>
<DIV>I am waiting for an incoming connection. This connection is =
availiable=20
after a few seconds. So no problems so far. </DIV>
<DIV>&nbsp;</DIV>
<DIV>My problem now. </DIV>
<DIV>I have an application listening on rfcomm0, if something happens =
that=20
causes an disconnection (with following reconnection) my apllication is =
not be=20
able to receive from dev/rfcomm0 </DIV>
<DIV>&nbsp;</DIV>
<DIV>You can test it with simple cat /dev/rfcomm0. After disconnection =
cat is=20
closing. </DIV>
<DIV>I need that cat /dev/rfcomm0 is kept open. Would it be possible to =
link to=20
a specific script which is able to handle this?? Any other =
proposals??</DIV>
<DIV>&nbsp;</DIV>
<DIV>Thanks</DIV>
<DIV>&nbsp;</DIV>
<DIV>Thomas&nbsp;</DIV>
<DIV>&nbsp;</DIV></FONT></DIV></BODY></HTML>

------=_NextPart_000_014D_01C66932.3A038BB0--



-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
