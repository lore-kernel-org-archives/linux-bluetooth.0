Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] New PIN helper, how to include with BlueZ?
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-devel@lists.sourceforge.net
In-Reply-To: <20060312201345.1846901c.fotopiper@o2.pl>
References: <20060311190606.236f7cbd.fotopiper@o2.pl>
	 <1142185809.4620.3.camel@aeonflux.holtmann.net>
	 <20060312201345.1846901c.fotopiper@o2.pl>
Content-Type: text/plain
Message-Id: <1142191960.4620.8.camel@aeonflux.holtmann.net>
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
Date: Sun, 12 Mar 2006 20:32:40 +0100

Hi Radek,

> > The /var/lib/bluetooth/<bdaddr>/pincodes file is supported for
> > outgoing connection for quite some time. The
> > default /etc/bluetooth/pin has been already removed and the complete
> > PIN helper script support will be remove really soon, too.
> 
> Hmm.. I see that BlueZ is even less documented then I thought.
> What is the syntax of the file?
> PS. I'm using the current stable version, and the /etc/bluetooth/pin is
> still there.. so I suppose it's still rather for the future. (but
> rather not far future).

the /etc/bluetooth/pin support is removed from the current CVS. And I
even removed the PIN helper script support completely. So it is the near
future with the next blue-utils release which has been targeted for in
two weeks.

The syntax of the pincodes file is easy. It is a BD_ADDR and PIN code
pair per line. Like the names file etc.

> > The new
> > way for the having a flexible way of PIN handling will be over D-Bus.
> > At some not so far point in the future the bluez-utils package will
> > depend on D-Bus anyway.
> 
> Great, and what about those systems where d-bus is not present?
> I hope the D-Bus will still be complemented by some list of devices and
> pins.

And what kind of system should that be? All desktop systems are using
D-Bus and even the Nokia 770 and the new platform from PalmSource are
supporting it by default. So no reason to use something different than
D-Bus for PIN handling.

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
