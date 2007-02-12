Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
MIME-Version: 1.0
Date: Mon, 12 Feb 2007 11:09:18 -0500
Message-ID: <2EB6297382462046A9427D7324788A4801A3898D@MCLNEXVS06.resource.ds.bah.com>
From: "Williams, Richard" <williams_richard_b@bah.com>
To: <bluez-devel@lists.sourceforge.net>
Subject: [Bluez-devel] Oops with multiple hcitool commands
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============1665855069=="
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

This is a multi-part message in MIME format.

--===============1665855069==
Content-class: urn:content-classes:message
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C74EC0.26CD43CC"

This is a multi-part message in MIME format.

------_=_NextPart_001_01C74EC0.26CD43CC
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Hello All,
=20
I am building a project that will use multiple HCI devices on a single
Linux PC. I have a USB hub, and several Linksys Bluetooth dongles. On my
PC I open two terminal windows and then run the following commands:
=20
window 1#  hcitool -i hci0 info 00:18:C5:2C:5E:C2
window 2#  hcitool -i hci1 info 00:18:C5:2C:5E:C2
=20
The two commands must run simultaneously. Just these two commands run
quickly one after the other will almost always cause the oops. The
problem does not occur if the two hcitool info commands are examining
different remote devices. You must go after the same remote device.
=20
Its very easy to demonstrate the problem with two simple scripts:
=20
window 1 # while true
> do
> hcitool -i hci0 info 00:18:C5:2C:5E:C2
> sleep 1
> done
=20
and the same script in window 2 using hci1. Within a few seconds, you
will get a collision and then oops!
=20
=20
I am running Fedora Core 2.6.19-1.2895.fc6
Bluez-libs-3.9
Bluez-utils-3.9
=20
I realize that two hcitool info commands toward the same remote device
is probably not a good thing to do, but it should not cause an oops!
=20
Thanks very much.
=20
Rich Williams
New Jersey, USA
=20
=20
=20
=20
=20

------_=_NextPart_001_01C74EC0.26CD43CC
Content-Type: text/html;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META http-equiv=3DContent-Type content=3D"text/html; =
charset=3Dus-ascii">
<META content=3D"MSHTML 6.00.2900.3020" name=3DGENERATOR></HEAD>
<BODY>
<DIV><FONT face=3DArial size=3D2><SPAN class=3D289044215-12022007>Hello=20
All,</SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN=20
class=3D289044215-12022007></SPAN></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2><SPAN class=3D289044215-12022007>I am =
building a=20
project that will use multiple HCI devices on a single Linux PC. I have =
a USB=20
hub, and several Linksys Bluetooth dongles. On my PC I open two terminal =
windows=20
and then run the following commands:</SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN =
class=3D289044215-12022007></SPAN></FONT><FONT=20
face=3DArial size=3D2><SPAN =
class=3D289044215-12022007></SPAN></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2><SPAN class=3D289044215-12022007>window =
1#&nbsp;=20
hcitool -i hci0 info 00:18:C5:2C:5E:C2</SPAN></FONT></DIV>
<DIV><SPAN class=3D289044215-12022007><FONT face=3DArial size=3D2>window =
2#&nbsp;=20
hcitool -i hci1 info 00:18:C5:2C:5E:C2</FONT></SPAN></DIV>
<DIV><SPAN class=3D289044215-12022007><FONT face=3DArial=20
size=3D2></FONT></SPAN>&nbsp;</DIV>
<DIV><SPAN class=3D289044215-12022007><FONT face=3DArial size=3D2>The =
two commands=20
must run simultaneously. Just these two commands run quickly one after =
the other=20
will almost always cause the oops. The problem does not occur if the two =

<STRONG>hcitool info</STRONG> commands are examining different remote =
devices.=20
You must go after the same remote device.</FONT></SPAN></DIV>
<DIV><SPAN class=3D289044215-12022007><FONT face=3DArial=20
size=3D2></FONT></SPAN>&nbsp;</DIV>
<DIV><SPAN class=3D289044215-12022007><FONT face=3DArial size=3D2>Its =
very easy to=20
demonstrate the problem with two simple scripts:</FONT></SPAN></DIV>
<DIV><SPAN class=3D289044215-12022007><FONT face=3DArial=20
size=3D2></FONT></SPAN>&nbsp;</DIV>
<DIV><SPAN class=3D289044215-12022007><FONT face=3DArial size=3D2>window =
1 # while=20
true</FONT></SPAN></DIV>
<DIV><SPAN class=3D289044215-12022007><FONT face=3DArial size=3D2>&gt;=20
do</FONT></SPAN></DIV>
<DIV><SPAN class=3D289044215-12022007><FONT face=3DArial size=3D2>&gt; =
hcitool -i hci0=20
info 00:18:C5:2C:5E:C2</FONT></SPAN></DIV>
<DIV><SPAN class=3D289044215-12022007><FONT face=3DArial size=3D2>&gt; =
sleep=20
1</FONT></SPAN></DIV>
<DIV><SPAN class=3D289044215-12022007><FONT face=3DArial size=3D2>&gt;=20
done</FONT></SPAN></DIV>
<DIV><SPAN class=3D289044215-12022007><FONT face=3DArial=20
size=3D2></FONT></SPAN>&nbsp;</DIV>
<DIV><SPAN class=3D289044215-12022007><FONT face=3DArial size=3D2>and =
the same script=20
in window 2 using hci1. Within a few seconds, you will get a collision =
and then=20
oops!</FONT></SPAN></DIV>
<DIV><SPAN class=3D289044215-12022007><FONT face=3DArial=20
size=3D2></FONT></SPAN>&nbsp;</DIV>
<DIV><SPAN class=3D289044215-12022007><FONT face=3DArial=20
size=3D2></FONT></SPAN>&nbsp;</DIV>
<DIV><SPAN class=3D289044215-12022007><FONT face=3DArial size=3D2>I am =
running Fedora=20
Core 2.6.19-1.2895.fc6</FONT></SPAN></DIV>
<DIV><SPAN class=3D289044215-12022007><FONT face=3DArial=20
size=3D2>Bluez-libs-3.9</FONT></SPAN></DIV>
<DIV><SPAN class=3D289044215-12022007><FONT face=3DArial=20
size=3D2>Bluez-utils-3.9</FONT></SPAN></DIV>
<DIV><SPAN class=3D289044215-12022007><FONT face=3DArial=20
size=3D2></FONT></SPAN>&nbsp;</DIV>
<DIV><SPAN class=3D289044215-12022007><FONT face=3DArial size=3D2>I =
realize that two=20
hcitool info commands toward the same remote device is probably not a =
good thing=20
to do, but it should not cause an oops!</FONT></SPAN></DIV>
<DIV><SPAN class=3D289044215-12022007><FONT face=3DArial=20
size=3D2></FONT></SPAN>&nbsp;</DIV>
<DIV><SPAN class=3D289044215-12022007><FONT face=3DArial size=3D2>Thanks =
very=20
much.</FONT></SPAN></DIV>
<DIV><SPAN class=3D289044215-12022007><FONT face=3DArial=20
size=3D2></FONT></SPAN>&nbsp;</DIV>
<DIV><SPAN class=3D289044215-12022007><FONT face=3DArial size=3D2>Rich=20
Williams</FONT></SPAN></DIV>
<DIV><SPAN class=3D289044215-12022007><FONT face=3DArial size=3D2>New =
Jersey,=20
USA</FONT></SPAN></DIV>
<DIV><SPAN class=3D289044215-12022007><FONT face=3DArial=20
size=3D2></FONT></SPAN>&nbsp;</DIV>
<DIV><SPAN class=3D289044215-12022007><FONT face=3DArial=20
size=3D2></FONT></SPAN>&nbsp;</DIV>
<DIV><SPAN class=3D289044215-12022007><FONT face=3DArial=20
size=3D2></FONT></SPAN>&nbsp;</DIV>
<DIV align=3Dleft><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV>&nbsp;</DIV></BODY></HTML>

------_=_NextPart_001_01C74EC0.26CD43CC--


--===============1665855069==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier.
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
--===============1665855069==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--===============1665855069==--
