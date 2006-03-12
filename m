Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: Radek Rurarz <fotopiper@o2.pl>
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] New PIN helper, how to include with BlueZ?
Message-Id: <20060312205157.1092b7d7.fotopiper@o2.pl>
In-Reply-To: <1142191960.4620.8.camel@aeonflux.holtmann.net>
References: <20060311190606.236f7cbd.fotopiper@o2.pl>
	<1142185809.4620.3.camel@aeonflux.holtmann.net>
	<20060312201345.1846901c.fotopiper@o2.pl>
	<1142191960.4620.8.camel@aeonflux.holtmann.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-2
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
Date: Sun, 12 Mar 2006 20:51:57 +0100

On Sun, 12 Mar 2006 20:32:40 +0100
Marcel Holtmann <marcel@holtmann.org> wrote:

> the /etc/bluetooth/pin support is removed from the current CVS. And I
> even removed the PIN helper script support completely. So it is the
> near future with the next blue-utils release which has been targeted
> for in two weeks.
>=20
> The syntax of the pincodes file is easy. It is a BD_ADDR and PIN code
> pair per line. Like the names file etc.

Thank you.
Will this stay for the next releses, or is it only a temporary solution?
=20
> > Great, and what about those systems where d-bus is not present?
> > I hope the D-Bus will still be complemented by some list of devices
> > and pins.
>=20
> And what kind of system should that be? All desktop systems are using
> D-Bus and even the Nokia 770 and the new platform from PalmSource are
> supporting it by default. So no reason to use something different than
> D-Bus for PIN handling.

Well, I'm not using D-Bus on WIndow Maker, Opie has no D-bus support
(for now). But I don't mean interactive systems. Rather those which
either have no X, or have no direct input methods at all (home server
sollusions, no screen, no keyboard).
I'm using an old PC as an BT gateway for couple of PDAs.

The truth is that, both for WM and my small gateway, I only need the
device-pin list and a way to disable any kind of prompt for PIN
for unknown devices.
If the support for the pincodes file is a permanent sollusion (one that
will remain in the next relese) then the D-Bus approach is as good for
me, as any other one.

My regards.

--=20
Rados=B3aw Rurarz
Warsaw Poland
GG: 7249330


-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
