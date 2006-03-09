Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: Radek Rurarz <fotopiper@o2.pl>
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] PIN helper
Message-Id: <20060309192953.52ee8c2e.fotopiper@o2.pl>
In-Reply-To: <20060309061255.GC4516@beta.private.mielke.cc>
References: <20060308221925.17d20407.fotopiper@o2.pl>
	<20060308214031.GZ4516@beta.private.mielke.cc>
	<20060308230109.202dc5ff.fotopiper@o2.pl>
	<20060308221644.GA4516@beta.private.mielke.cc>
	<20060309064424.584539d2.fotopiper@o2.pl>
	<20060309055552.GB4516@beta.private.mielke.cc>
	<20060309070649.007fba22.fotopiper@o2.pl>
	<20060309061255.GC4516@beta.private.mielke.cc>
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
Date: Thu, 9 Mar 2006 19:29:53 +0100

On Thu, 9 Mar 2006 01:12:55 -0500
Dave Mielke <dave@mielke.cc> wrote:

> [quoted lines by Radek Rurarz on 2006/03/09 at 07:06 +0100]
>=20
> >A simpler method would be to relly on another pinhelper (for
> >instance one from the bluez-utlis) set in a config file.. juts pass
> >the arguments to it.. and see if it returns a propper pin.. if not
> >fall back to the internal methods (promp if allowed, the pin file
> >shoud be checked first).
>=20
> Do you think it should be just one, or should multiple specifications
> of the option accumulate a set of helpers to try?

Good question..
For security reasons an simplicyty...  one is a good idea.
But having an option to try more then one is more universal (but not
nessesary).
If it's not a big problem (both for you to implement and for the system
to compute..) it would be a nice feature.
=20
> >Sorry, didn't noticed that... I need to work on my sh skills ;)
>=20
> I'm grateful that you didn't as that gave me the idea to document the
> "feature".

It would be nice ;) still the bluz is poorly documented as whole.. an
you're prepering the helper... The documentation is usually prepered
after something is ready ;)

Ps.
I prefer a working program, then a problematic one with documentation ;)

My regards.

Ps.
Sorry for any spelling mistakes...

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
