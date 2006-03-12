Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] New PIN helper, how to include with BlueZ?
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-devel@lists.sourceforge.net
In-Reply-To: <20060312205157.1092b7d7.fotopiper@o2.pl>
References: <20060311190606.236f7cbd.fotopiper@o2.pl>
	 <1142185809.4620.3.camel@aeonflux.holtmann.net>
	 <20060312201345.1846901c.fotopiper@o2.pl>
	 <1142191960.4620.8.camel@aeonflux.holtmann.net>
	 <20060312205157.1092b7d7.fotopiper@o2.pl>
Content-Type: text/plain
Message-Id: <1142207662.4468.2.camel@aeonflux.holtmann.net>
Mime-Version: 1.0
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
Date: Mon, 13 Mar 2006 00:54:22 +0100

Hi Radek,

> > the /etc/bluetooth/pin support is removed from the current CVS. And I
> > even removed the PIN helper script support completely. So it is the
> > near future with the next blue-utils release which has been targeted
> > for in two weeks.
> > 
> > The syntax of the pincodes file is easy. It is a BD_ADDR and PIN code
> > pair per line. Like the names file etc.
> 
> Thank you.
> Will this stay for the next releses, or is it only a temporary solution?

for now it will stay. However you can emulate the same behavior with a
D-Bus passkey agent and so it might be removed at some point, but not in
the near future.
 
> > > Great, and what about those systems where d-bus is not present?
> > > I hope the D-Bus will still be complemented by some list of devices
> > > and pins.
> > 
> > And what kind of system should that be? All desktop systems are using
> > D-Bus and even the Nokia 770 and the new platform from PalmSource are
> > supporting it by default. So no reason to use something different than
> > D-Bus for PIN handling.
> 
> Well, I'm not using D-Bus on WIndow Maker, Opie has no D-bus support
> (for now). But I don't mean interactive systems. Rather those which
> either have no X, or have no direct input methods at all (home server
> sollusions, no screen, no keyboard).
> I'm using an old PC as an BT gateway for couple of PDAs.

The D-Bus has nothing to do with any special window manager or desktop
system. It is a bus system to exchange messages between programs.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
