Return-Path: <sebastian.reichel@collabora.co.uk>
Date: Mon, 24 Jul 2017 17:27:34 +0200
From: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Bluetooth: hci_nokia: select BT_BCM for
 btbcm_set_bdaddr()
Message-ID: <20170724152734.eftsg7vgouxa4zwz@earth>
References: <20170722095747.101069-1-marcel@holtmann.org>
 <20170722190323.mt5mrnioql7z2uj2@earth>
 <DC17CA45-3AB5-4272-A12A-1C7BD4811258@holtmann.org>
 <20170722211658.fdfcwoqshtrxqvwj@earth>
 <6FFF415F-F875-481B-A6D6-3DD7159C7DDD@holtmann.org>
 <20170724102357.cj73ujrukrqnl47s@earth>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="a5vrgvkp7exbsj2s"
In-Reply-To: <20170724102357.cj73ujrukrqnl47s@earth>
List-ID: <linux-bluetooth.vger.kernel.org>


--a5vrgvkp7exbsj2s
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Jul 24, 2017 at 12:23:57PM +0200, Sebastian Reichel wrote:
> On Sun, Jul 23, 2017 at 09:32:23AM +0200, Marcel Holtmann wrote:
> > >>>> The Nokia devices require the setup of its Public Bluetooth Device
> > >>>> Address and for that it is required to depend on vendor specific
> > >>>> commands. For Broadcom based Nokia devices, that is part of btbcm
> > >>>> module and can be selected via BT_BCM config option.
> > >>>>=20
> > >>>> Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
> > >>>=20
> > >>> Reviewed-by: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
> > >>=20
> > >> btw. we need to also provide the set_bdaddr for TI chips.
> > >=20
> > > The TI based chip in Nokia N950 has a proper address configured, so
> > > it works without set_bdaddr (it would still be nice of course). It
> > > also seems to be missing for hci_ll, though. So the required command
> > > is completly unknown?
> >=20
> > are these a TI address or a Nokia address? I doubt Nokia would
> > have actually shipped any hardware using an IEEE assigned address
> > to TI.
>=20
> I can check this later.

The BD address on my N950 starts with B4:EE:D4, which belongs
to TI as far as I can see. Note, that N950 is a developer only
device.

-- Sebastian

--a5vrgvkp7exbsj2s
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAll2Ed0ACgkQ2O7X88g7
+poOhxAAqec9ennFvWbliqx5H8aFg2zdoM8E/owlYYXo3Rlj2vDMoOVe7JN6YDq9
Dglbxeie3pBSr0guBUdvHHmw1UdOw5sjkdPby8Lswtj43xrVKu5XEVKM4gXOmTdY
oQy78rXORi1j20gp8g0nYkIDI8ALj22I9uk54Os4AJji4Wt3fWrnaYGfqZsFF4l+
8Z3Y876EyR4MyY3CGz1jhZvYX5ALq0WRT8tP8JsEWEYbtsb3oLa0Xz4XVBps/0wk
qFISiyPVgAryU9E7YIFWuiiG6seFLUM0Yj33tmT7JPw7NJn8oSMoee4t1wAoIA6l
qLdj9i0fiBn/wQQpq3yr6ABfs8o96AQx+DUkw3YQY0WEy8Z4/2ZZU1CSaWM5s9dZ
l68dwhm9NSrwg/7hddXdr2BG4mTH2uR2lJIGXSJ4YA4/U/s2WNLuRNrvYJ9j+7+v
qamKrVN7S7plNr/Q0C4U63EuVwSYbdPvl6SsVs/1umbdo/oIAer9scd+N+9RPzfT
KEsXz2bqEHimOhx7RfppJ0VcBfkh8BuhuhgU+Zh0zV2m1Tx6Iz2BiiPP+/sOP9XY
x7NPilJsNk/kn9ZV7f3dU5/DxvvIsXzRrWW8vLK/86q9X1tkd29eiiZagVtSnIng
JgTv9cW8j060wMiHiT2zkj6TEGtn15E2iU2qYy5zVcd3r/3H8G8=
=McYY
-----END PGP SIGNATURE-----

--a5vrgvkp7exbsj2s--
