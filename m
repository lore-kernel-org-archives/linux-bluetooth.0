Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: Radek Rurarz <fotopiper@o2.pl>
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] New PIN helper, how to include with BlueZ?
Message-Id: <20060312201345.1846901c.fotopiper@o2.pl>
In-Reply-To: <1142185809.4620.3.camel@aeonflux.holtmann.net>
References: <20060311190606.236f7cbd.fotopiper@o2.pl>
	<1142185809.4620.3.camel@aeonflux.holtmann.net>
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
Date: Sun, 12 Mar 2006 20:13:45 +0100

On Sun, 12 Mar 2006 18:50:09 +0100
Marcel Holtmann <marcel@holtmann.org> wrote:

> The /var/lib/bluetooth/<bdaddr>/pincodes file is supported for
> outgoing connection for quite some time. The
> default /etc/bluetooth/pin has been already removed and the complete
> PIN helper script support will be remove really soon, too.

Hmm.. I see that BlueZ is even less documented then I thought.
What is the syntax of the file?
PS. I'm using the current stable version, and the /etc/bluetooth/pin is
still there.. so I suppose it's still rather for the future. (but
rather not far future).

> The new
> way for the having a flexible way of PIN handling will be over D-Bus.
> At some not so far point in the future the bluez-utils package will
> depend on D-Bus anyway.

Great, and what about those systems where d-bus is not present?
I hope the D-Bus will still be complemented by some list of devices and
pins.

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
