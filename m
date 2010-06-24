Return-Path: <cyrus@holtmann.org>
Subject: Re: Users need to manually run "hid2hci --method dell -v 413c -p
 8158 --mode hci" even when udev rule is installed
From: Pacho Ramos <pacho@condmat1.ciencias.uniovi.es>
Reply-To: pacho@condmat1.ciencias.uniovi.es
To: Bastien Nocera <hadess@hadess.net>
Cc: linux-bluetooth@vger.kernel.org
In-Reply-To: <1277390082.9334.129.camel@localhost.localdomain>
References: <1277390082.9334.129.camel@localhost.localdomain>
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature"; boundary="=-+hVD1/4JVaUKpZS5oOcy"
Date: Thu, 24 Jun 2010 17:01:38 +0200
Message-ID: <1277391698.25546.37.camel@localhost.localdomain>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>


--=-+hVD1/4JVaUKpZS5oOcy
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

El jue, 24-06-2010 a las 15:34 +0100, Bastien Nocera escribi=C3=B3:
> > > > This is still affecting to some users, can anybody help us? At leas=
t,
> > > > how could we check if udev is, at least, trying to execute hid2hci =
from
> > > > 97-bluetooth-hid2hci.rules file?
> > >=20
> > > 2 things.
> > >=20
> > > This is already fixed in udev upstream, and hid2hci doesn't live in
> > > bluez, but in udev now.
> > >=20
> > > This was also fixed recently in Fedora 14.
> > >=20
> > > Cheers
> > >=20
> >=20
> > Really thanks a lot! Seems to solve the problem :-D
>=20
> Was that sarcastic. I hope not, I sent this in good faith, because I
> fixed that exact same bug a couple of days before sending the mail.
>=20
> Cheers
>=20
?!

NO! It wasn't sarcastic :-O!

Simply take a look on my Changelog entry downstream (sent some days
ago):
http://sources.gentoo.org/cgi-bin/viewvc.cgi/gentoo-x86/net-wireless/bluez/=
ChangeLog?view=3Dmarkup
*bluez-4.66-r1 (19 Jun 2010)

  19 Jun 2010; Pacho Ramos <pacho@gentoo.org> +bluez-4.66-r1.ebuild:
  Stop building hid2hci since it's replaced by >=3Dsys-fs/udev-146[extras]
  provided one. This should fix bug #315749 (reported by Balazs Nemeth,
  Marcin Kryczek and others). Thanks a lot to Bastien Nocera for the tip
in
  linux-bluetooth mailing list.

Sorry if I didn't express myself properly :-/, English is not my mother
tongue.

Best regards :-)

--=-+hVD1/4JVaUKpZS5oOcy
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.15 (GNU/Linux)

iEYEABECAAYFAkwjc1IACgkQCaWpQKGI+9SsNgCfTlGfR9SNJlrfP+lX3rf0AlvM
mIEAniUi/WY+HLs/Y+Tdy5ibGQBIfDIo
=cKtx
-----END PGP SIGNATURE-----

--=-+hVD1/4JVaUKpZS5oOcy--

