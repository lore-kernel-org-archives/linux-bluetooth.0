Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: Radek Rurarz <fotopiper@o2.pl>
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] PIN helper
Message-Id: <20060309064424.584539d2.fotopiper@o2.pl>
In-Reply-To: <20060308221644.GA4516@beta.private.mielke.cc>
References: <20060308221925.17d20407.fotopiper@o2.pl>
	<20060308214031.GZ4516@beta.private.mielke.cc>
	<20060308230109.202dc5ff.fotopiper@o2.pl>
	<20060308221644.GA4516@beta.private.mielke.cc>
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
Date: Thu, 9 Mar 2006 06:44:24 +0100

On Wed, 8 Mar 2006 17:16:44 -0500
Dave Mielke <dave@mielke.cc> wrote:

> [quoted lines by Radek Rurarz on 2006/03/08 at 23:01 +0100]
>=20
> >Some things I would like to have:
> >1. checking the permissions of the file
>=20
> Do you mean that you'd like it to log via syslog if the permissions
> are unsafe?

That would be nice. But first of all, if the permissions are wrong (the
propper ones set in a config file, or in the script itself) the script
should not use the file and either refuse the connection =3D ERR (and
syslog the error) or fallback to other methods of geting the PIN (if
allowed).

> >2. an option to chose wheather a promp should be used even if there
> >is no pin in the file, possibly to chose another pinhelper if there
> >is no pin (for instance the one for X, if that fails to create a
> >promp).
> >
> >3. In the pins file another 'slot' for the name of the device
> >(not nessesary the one advertised by it, rather to have an idea whot
> >is it)
>=20
> These are good ideas. Thanks. I'll do them.

I'll be greatful :)

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
