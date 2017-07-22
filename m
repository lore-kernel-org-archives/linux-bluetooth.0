Return-Path: <sebastian.reichel@collabora.co.uk>
Date: Sat, 22 Jul 2017 23:16:59 +0200
From: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: hci_nokia: select BT_BCM for
 btbcm_set_bdaddr()
Message-ID: <20170722211658.fdfcwoqshtrxqvwj@earth>
References: <20170722095747.101069-1-marcel@holtmann.org>
 <20170722190323.mt5mrnioql7z2uj2@earth>
 <DC17CA45-3AB5-4272-A12A-1C7BD4811258@holtmann.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="nz574ba2njvxpxqy"
In-Reply-To: <DC17CA45-3AB5-4272-A12A-1C7BD4811258@holtmann.org>
List-ID: <linux-bluetooth.vger.kernel.org>


--nz574ba2njvxpxqy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Sat, Jul 22, 2017 at 09:08:15PM +0200, Marcel Holtmann wrote:
> >> The Nokia devices require the setup of its Public Bluetooth Device
> >> Address and for that it is required to depend on vendor specific
> >> commands. For Broadcom based Nokia devices, that is part of btbcm
> >> module and can be selected via BT_BCM config option.
> >>=20
> >> Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
> >=20
> > Reviewed-by: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
>=20
> btw. we need to also provide the set_bdaddr for TI chips.

The TI based chip in Nokia N950 has a proper address configured, so
it works without set_bdaddr (it would still be nice of course). It
also seems to be missing for hci_ll, though. So the required command
is completly unknown?

-- Sebastian

--nz574ba2njvxpxqy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAllzwMQACgkQ2O7X88g7
+poPyRAAir4Tv0m5ML1KWh+4umexUSY4cIft8g3RrjQe/gJio1krCij+atlopkeX
r9k75tjvUAen82HCApC78OXXIDl0Jkqy85J5d6fZybUugAtJo5m1pXBSoXr/CZ/x
t5zBbhMcIRsMD5js0WFye9Z+TXWigV8lKWkYJV9DNFSsuVml4oY+MKUZ34l6zaZ4
kjOeGsocpAysiwwUJ3P48X8JWMKLvpbGM+OvpYeZfmWxVkYbWoQEj+aadiwAwtOa
M/G2hbgApcgB0FME9rsIyrLmPuRyRI6KLqSTBDWrOoP/FZCJe5rPaoT73ULRiCkk
p7taLMW4PUeHZysCuI4dUWaTNPWJjPXHBynShF/NsgbPLh/pgZhB+x7aOjmLqQC6
rdqnqSbE9AOPr2+U3XnyjOcUQ5+4WbqEOzZ6YLb0ee0onSjMnpWC2jNor1HmFSDP
/7KAZWgUlwMyvDk7BFWQf/Afzivgk1NjLZ5B7hZZCKWW7bKT/Je6a6Vmuu5g0nx4
UxIcyDEu3hiJbZkuLbYH05vlvLeph3ov3wugr0UmpPqpm1fcv54mUVRxtrduMQZ5
tg4n2VTXpoyNU41Go4hANle8SQOnaYE1cIezLoSF++jVW3axo1lVg1D0TKPozh/m
3pUREcwiSWlt02RqnaK4Jh0SYb5IQGrQc8UnB8/1iGFW563T4FQ=
=ufUM
-----END PGP SIGNATURE-----

--nz574ba2njvxpxqy--
