Return-Path: <grantma@anathoth.gen.nz>
Subject: Re: [Bluez-users] Re: PROBLEM: Apple powerbook, Apple BT keyboard,
	keyboard does not reconnect on reboot
From: Matthew Grant <grantma@anathoth.gen.nz>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <1100372735.21403.1.camel@pegasus>
References: <1098654320.4635.16.camel@localhost>
	 <1098676528.6465.68.camel@pegasus>  <1099721547.5132.70.camel@localhost>
	 <1099744491.6919.39.camel@pegasus>  <1099771915.4563.9.camel@localhost>
	 <1099776680.6919.104.camel@pegasus>  <1099788984.4543.5.camel@localhost>
	 <1099795084.6896.3.camel@pegasus>  <1099942733.5806.7.camel@localhost>
	 <1099943605.29330.21.camel@pegasus>  <1100326156.6216.29.camel@localhost>
	 <1100350419.7349.43.camel@pegasus>  <1100371962.6564.4.camel@localhost>
	 <1100372735.21403.1.camel@pegasus>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-0f71Is0iQpCQ/bbBAtrO"
Message-Id: <1100375707.6564.7.camel@localhost>
Mime-Version: 1.0
Date: Sun, 14 Nov 2004 08:55:07 +1300
List-ID: <bluez-users.lists.sourceforge.net>


--=-0f71Is0iQpCQ/bbBAtrO
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Marcel,

Thanks for getting back so quick!

So the policy is not to produce 2.11.1 unless it is more serious than
this?

Cheers,

Matthew Grant

On Sun, 2004-11-14 at 08:05, Marcel Holtmann wrote:
> Hi Matthew,
>=20
> > Actually, maybe could a new release should be done for this?  It fixes =
a
> > lot of boot script problems on big-endian systems with things not being
> > shutdown properly for hidd.  I have observed that not having BT
> > connections cleanly closed off upsets my Apple keyboards.
>=20
> you are two days too late. I just released a new library version and
> there are other things that should be done first before I will release
> another version. However I think Edd will include the fix in the Debian
> package and this should be enough.
>=20
> Regards
>=20
> Marcel
>=20
--=20
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
Matthew Grant        /\  ^/\^   grantma@anathoth.gen.nz      /~~~~\
A Linux Network Guy /~~\^/~~\_/~~~~~\_______/~~~~~~~~~~\____/******\
=3D=3D=3DGPG KeyID: 2EE20270  FingerPrint: 8C2535E1A11DF3EA5EA19125BA4E790E=
2EE20270=3D=3D


--=-0f71Is0iQpCQ/bbBAtrO
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBBlmaauk55Di7iAnARAo7tAJ45S7u9aUkxdoOwU3yIKS4tDOsFgwCfQzaK
Ae3zTnwsNrddharO7N3nz28=
=PH8a
-----END PGP SIGNATURE-----

--=-0f71Is0iQpCQ/bbBAtrO--
