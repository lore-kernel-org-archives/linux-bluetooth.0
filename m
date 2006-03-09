Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: Radek Rurarz <fotopiper@o2.pl>
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] PIN helper
Message-Id: <20060309070649.007fba22.fotopiper@o2.pl>
In-Reply-To: <20060309055552.GB4516@beta.private.mielke.cc>
References: <20060308221925.17d20407.fotopiper@o2.pl>
	<20060308214031.GZ4516@beta.private.mielke.cc>
	<20060308230109.202dc5ff.fotopiper@o2.pl>
	<20060308221644.GA4516@beta.private.mielke.cc>
	<20060309064424.584539d2.fotopiper@o2.pl>
	<20060309055552.GB4516@beta.private.mielke.cc>
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
Date: Thu, 9 Mar 2006 07:06:49 +0100

On Thu, 9 Mar 2006 00:55:52 -0500
Dave Mielke <dave@mielke.cc> wrote:


> >> >possibly to chose another pinhelper if there
> >> >is no pin (for instance the one for X, if that fails to create a
> >> >promp).
>=20
> This one will take some thought. It could check to see if X is
> running, and then run the X one if so and do the text-mode thing
> otherwise. If that's okay, the option would be something like:
> -x /etc/bluetooth/xbluepin

A simpler method would be to relly on another pinhelper (for
instance one from the bluez-utlis) set in a config file.. juts pass the
arguments to it.. and see if it returns a propper pin.. if not fall
back to the internal methods (promp if allowed, the pin file shoud be
checked first).

Then it could be a standard pinhelper.. even with kde/gnome/opie/gpe
(last two on handhelds) on top.

> >> >3. In the pins file another 'slot' for the name of the device
> >> >(not nessesary the one advertised by it, rather to have an idea
> >> >whot is it)
>=20
> The script actually already did that, i.e. it ignores data after the
> PIN. Now it's documented, though, and even with an example.

Sorry, didn't noticed that... I need to work on my sh skills ;)

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
