Return-Path: <bluez-devel-admin@lists.sourceforge.net>
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] The new D-Bus API specification
Message-ID: <20060304201511.GA2959@spring.luon.net>
References: <1140652705.4519.71.camel@localhost> <1140807942.7264.44.camel@localhost> <e1effdeb0603021302h2ffbcd80y1a9c46bf93e51278@mail.gmail.com> <1141394159.4814.3.camel@aeonflux.holtmann.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="3V7upXqbjpZ4EhLz"
In-Reply-To: <1141394159.4814.3.camel@aeonflux.holtmann.net>
From: sjoerd@spring.luon.net (Sjoerd Simons)
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
Date: Sat, 4 Mar 2006 21:15:11 +0100


--3V7upXqbjpZ4EhLz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 03, 2006 at 02:55:58PM +0100, Marcel Holtmann wrote:
> Hi Claudio,
>=20
> > I tested the latest bluez-utils CVS version with the recent D-Bus
> > changes and I have some comments:
> >=20
> > * Policy
> > I'm not sure, but I think some linux distributions use pam_console
> > instead of at_console. We sould investigate more to avoid future
> > problems. Another thing are the rules. at_console aims provide a way
> > to refer to users that are not physically sitting in front of the
> > computer. I tested send D-Bus messages from the local host or
> > connected through ssh and I didn't noticed differences. I mean, the
> > behaviour is the same. Remote users still able to send D-Bus messages.
>=20
> actually the at_console should be transparent between different Linux
> distributions. However we need to verify that it works on at least
> Fedora, SuSE, Debian and Ubuntu.

at_console currently doesn't work on Debian, but does on Ubuntu (using
pam-foreground not pam_console). However i intend to add pam-foreground sup=
port
to debian's dbus too, which would make at_console supported on debian too. =
=20

  Sjoerd
--=20
The moon may be smaller than Earth, but it's further away.

--3V7upXqbjpZ4EhLz
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2 (GNU/Linux)

iD8DBQFECfVPgTd+SodosdIRAmxMAKC9gPFS3mLDv9Nols0fm0/9ebotVACgvAvz
ijJAAEvoihpdkxNVoi2J9w0=
=x09b
-----END PGP SIGNATURE-----

--3V7upXqbjpZ4EhLz--


-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
