Return-Path: <bluez-devel-admin@lists.sourceforge.net>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: [Bluez-devel] Dbus and RemoteDeviceFound API
Message-ID: <7A6DA545D7FDCC4B93DB651FDBC1EDDE46C733@eumonex01.palmsource.com>
From: "Renaud Malaval" <Renaud.Malaval@palmsource.com>
To: <bluez-devel@lists.sourceforge.net>
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
Reply-To: bluez-devel@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Wed, 17 May 2006 18:44:53 +0200

Hello, marcel=20

>
> Hi Renaud,
>=20
> >  I just discover that new API, and I have a remark.
> >=20
> >  Is it to possible to add to that message the class of device (as an
> > uint32) ?
> >  With this we can have complete information about discovered device=20
> > even if major or minor are not in "constant definition" of dbus API.
> >  This can also simplify programation in C (ie: filtering, displaying
> > icons,...)
>=20
> we did it this way on purpose. If definitions are missing,=20
> then this is a bug and needs to be fixed. What types are you missing?
>=20
> Another basic design idea behind the D-Bus API for BlueZ is=20
> not to use weird integer constants at all. We have clear text=20
> attributes which make it very easy to use them from scripting=20
> languages like Python. However this makes it harder for=20
> application written in C, but we accepted this disadvantage.
>=20
> Regards
>=20
> Marcel
>=20

 The LIMITED_DISCOVERABLE_MODE service class is missing and minor
classes for other major classes than Computer and Phone are not listed
in "constant definition" (ie: uncategorized, keyboard, pointing, combo
for Peripheral major class).
 I use the "class of device" to filter and/or display specific icon for
all couple of major and minor in an embedded device.
 Perhaps a new set of APIs could be better ?

Renaud


-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
