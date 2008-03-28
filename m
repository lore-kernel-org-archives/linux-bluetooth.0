Return-Path: <cyrus@holtmann.org>
Message-ID: <019401c8912b$e1876ff0$6701a8c0@freqonedev>
From: "David Stockwell" <dstockwell@frequency-one.com>
To: "BlueZ development" <bluez-devel@lists.sourceforge.net>
Date: Fri, 28 Mar 2008 18:31:40 -0500
MIME-Version: 1.0
Subject: [Bluez-devel] Experimental Mode: org.bluez.Adapter Methods/Signals
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============0252677614=="
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

This is a multi-part message in MIME format.

--===============0252677614==
Content-Type: multipart/alternative;
	boundary="----=_NextPart_000_0191_01C89101.F6E7A470"

This is a multi-part message in MIME format.

------=_NextPart_000_0191_01C89101.F6E7A470
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

In the adapter.c code (bluez-utils-3.29), there are a number of 4.x =
methods and signals, which are enabled when hcid is run in experimental =
mode (-x in startup).

There are a whole lot of others that are labeled as "deprecated", but =
which are currently available when hcid is in experimental mode, as well =
as when it is not.  Are these in fact going to be dropped when 4.x is =
released?

On a similar topic:

When the 4.x methods are registered, they register on bus "org.bluez", =
with interface "org.bluez.Adapter", but unlike 3.x, the path they use is =
not "/org/bluez/hci0" but just "/hci0" (for the default case).  Is this =
intentional and the future direction of bluez-dbus?

I ask because when I tried calling DiscoverDevices, it would fail when I =
called with path "/org/bluez/hci0", but would run when I called it with =
path "/hci0".  But, the funny thing is that because the =
RemoteDeviceFound signal is registered to both the old path and the new =
path, the signals come back on "/org/bluez/hci0".

Interestingly enough, when I register callbacks for DiscoveryStarted, =
RemoteDeviceFound, and DiscoveryCompleted against proxies that reference =
both the old and new path, I find that signals for DiscoveryStarted and =
DiscoveryCompleted come back against both paths, but the actual =
RemoteDeviceFound (and RemoteNameUpdated) comes back only against the =
3.x path.

before dbus_g_proxy_call: DiscoverDevices
 bus:       org.bluez
 path:      /hci0
 interface: org.bluez.Adapter

Signal from org.bluez.Adapter path: /org/bluez/hci0
DiscoveryStarted()

Signal from org.bluez.Adapter path: /hci0
DiscoveryStarted()

Signal from org.bluez.Adapter path: /org/bluez/hci0
RemoteDeviceFound(00:1C:CC:D6:90:3F,7a020c,0)

Signal from org.bluez.Adapter path: /org/bluez/hci0
RemoteNameUpdated(00:1C:CC:D6:90:3F,BlackBerry 8320)

Signal from org.bluez.Adapter path: /hci0
DiscoveryCompleted()


Signal from org.bluez.Adapter path: /org/bluez/hci0
DiscoveryCompleted()

I would appreciate a sense of direction, because I am working on =
avrcp/control, and want to make sure I am aligned with your plans going =
forward.

David Stockwell
------=_NextPart_000_0191_01C89101.F6E7A470
Content-Type: text/html;
	charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META http-equiv=3DContent-Type content=3D"text/html; =
charset=3Diso-8859-1">
<META content=3D"MSHTML 6.00.6000.16608" name=3DGENERATOR>
<STYLE></STYLE>
</HEAD>
<BODY bgColor=3D#ffffff>
<DIV>
<DIV><FONT face=3DArial size=3D2>In the adapter.c code =
(bluez-utils-3.29), there are=20
a number of 4.x methods and signals, which are enabled when hcid is run =
in=20
experimental mode (-x in startup).</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>There are a whole lot of others that =
are labeled as=20
"deprecated", but which are currently available when hcid is in =
experimental=20
mode, as well as when it is not.&nbsp; Are these in fact going to be =
dropped=20
when 4.x is released?</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>On a similar topic:</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>When the 4.x methods are registered, =
they register=20
on bus "org.bluez", with interface "org.bluez.Adapter", but unlike 3.x, =
the path=20
they use is not "/org/bluez/hci0" but just "/hci0" (for the default =
case).&nbsp;=20
Is this intentional and the future direction of bluez-dbus?</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>I ask because when I tried calling =
DiscoverDevices,=20
it would fail when I called with path "/org/bluez/hci0", but would run =
when I=20
called it with path "/hci0".&nbsp; But, the funny thing is that because =
the=20
RemoteDeviceFound signal is registered to both the old path and the new =
path,=20
the signals come back on "/org/bluez/hci0".</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>Interestingly enough, when I register =
callbacks for=20
DiscoveryStarted, RemoteDeviceFound, and DiscoveryCompleted against =
proxies that=20
reference both the old and new path, I find that signals for =
DiscoveryStarted=20
and DiscoveryCompleted come back against both paths, but the actual=20
RemoteDeviceFound (and RemoteNameUpdated) comes back only against =
the&nbsp;3.x=20
path.</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV>before dbus_g_proxy_call:=20
DiscoverDevices<BR>&nbsp;bus:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
org.bluez<BR>&nbsp;path:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; =
/hci0<BR>&nbsp;interface:=20
org.bluez.Adapter<BR><BR>Signal from org.bluez.Adapter path:=20
/org/bluez/hci0<BR>DiscoveryStarted()<BR><BR>Signal from =
org.bluez.Adapter path:=20
/hci0<BR>DiscoveryStarted()<BR><BR>Signal from org.bluez.Adapter path:=20
/org/bluez/hci0<BR>RemoteDeviceFound(00:1C:CC:D6:90:3F,7a020c,0)<BR><BR>S=
ignal=20
from org.bluez.Adapter path:=20
/org/bluez/hci0<BR>RemoteNameUpdated(00:1C:CC:D6:90:3F,BlackBerry=20
8320)<BR><BR>Signal from org.bluez.Adapter path:=20
/hci0<BR>DiscoveryCompleted()<BR><BR><BR>Signal from org.bluez.Adapter =
path:=20
/org/bluez/hci0<BR>DiscoveryCompleted()<BR></DIV>
<DIV><FONT face=3DArial size=3D2>I would appreciate a sense&nbsp;of =
direction,=20
because I am working on avrcp/control, and want to make sure I am =
aligned with=20
your plans going forward.</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>David =
Stockwell</FONT></DIV></DIV></BODY></HTML>

------=_NextPart_000_0191_01C89101.F6E7A470--



--===============0252677614==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Check out the new SourceForge.net Marketplace.
It's the best place to buy or sell services for
just about anything Open Source.
http://ad.doubleclick.net/clk;164216239;13503038;w?http://sf.net/marketplace
--===============0252677614==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--===============0252677614==--
