Return-Path: <zlynx@acm.org>
Subject: Re: [Bluez-devel] 2.6.21-rc4-mm1
From: Zan Lynx <zlynx@acm.org>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: BlueZ development <bluez-devel@lists.sourceforge.net>,
        linux-kernel@vger.kernel.org
In-Reply-To: <1174486370.15638.29.camel@aeonflux.holtmann.net>
References: <20070319205623.299d0378.akpm@linux-foundation.org>
	 <1174433034.62033.16.camel@localhost>
	 <20070320223643.d8cbc3f6.akpm@linux-foundation.org>
	 <1174486370.15638.29.camel@aeonflux.holtmann.net>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-sucEl6uUGBYi+kYCiXwt"
Date: Fri, 23 Mar 2007 13:45:54 -0600
Message-Id: <1174679154.289400.22.camel@localhost>
Mime-Version: 1.0
List-ID: <bluez-devel.lists.sourceforge.net>


--=-sucEl6uUGBYi+kYCiXwt
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, 2007-03-21 at 15:12 +0100, Marcel Holtmann wrote:
> Hi Andrew,
>=20
> > >       * Freezes immediately if I allow Bluetooth to configure.
> >=20
> > cc bluez-devel
>=20
> is the -mm specific or does this also happens with 2.6.21-rc4?

Bluetooth works now, so it isn't entirely -mm's fault. =20

I applied a posted patch for the Sonic Silicon Backplane.  I also set
all the older BCM43xx driver modules to N, and my freeze with wireless
went away.

On this laptop (a Compaq R3000) the Bluetooth and the wireless are
controlled by the same front panel button, so I wonder if they are
related in other ways as well.

If I get a chance to play with it this weekend I will see if I can
isolate the change that fixes/breaks it.
--=20
Zan Lynx <zlynx@acm.org>

--=-sucEl6uUGBYi+kYCiXwt
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.3 (GNU/Linux)

iD8DBQBGBC5yG8fHaOLTWwgRAlVtAKCSCnUhdf8C7zpWj4jSq8yWkmh+5QCfR6p6
d98lBKF95LpOMJRkXkEpZ8c=
=0Z65
-----END PGP SIGNATURE-----

--=-sucEl6uUGBYi+kYCiXwt--
