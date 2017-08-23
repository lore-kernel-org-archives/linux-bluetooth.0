Return-Path: <maxime.ripard@free-electrons.com>
Date: Wed, 23 Aug 2017 16:12:15 +0200
From: Maxime Ripard <maxime.ripard@free-electrons.com>
To: Loic Poulain <loic.poulain@gmail.com>
Cc: Stefan Wahren <stefan.wahren@i2se.com>, robh+dt@kernel.org,
	rjui@broadcom.com, sbranden@broadcom.com, f.fainelli@gmail.com,
	marcel@holtmann.org, johan.hedberg@gmail.com,
	linux-rpi-kernel@lists.infradead.org,
	linux-bluetooth@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v2 1/3] dt-bindings: net: bluetooth: Add
 broadcom-bluetooth
Message-ID: <20170823141215.5gbwwmbshz7p2sbd@flea.home>
References: <1501576704-26423-1-git-send-email-loic.poulain@gmail.com>
 <20170822074726.e424lflqxn6mb4xd@flea.lan>
 <f2fcf522-cd1e-e748-0ee7-ad28bbf8ae5d@i2se.com>
 <4c23bcb6-1b90-c41e-6e47-7d8315e760ae@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="jayo6t3wqxqw5lmy"
In-Reply-To: <4c23bcb6-1b90-c41e-6e47-7d8315e760ae@gmail.com>
List-ID: <linux-bluetooth.vger.kernel.org>


--jayo6t3wqxqw5lmy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Loic,

On Tue, Aug 22, 2017 at 10:27:43PM +0200, Loic Poulain wrote:
> Hi Maxime,
>=20
> > > Thanks a lot for working on that, I've made a similar attempt a few
> > > weeks ago but didn't manage to get it to work.
> > >=20
> > > The way it's hooked in our boards is a bit more complex though, even
> > > if it could be because we're using a different part.
> > >=20
> > > In order to get it running we need:
> > >    - two clocks, called in the broadcom datasheets lpo and tcxo.
> > >    - three GPIOs, device wakeup, host wakeup and a shutdown GPIO (whi=
ch
> > >      might be the BT_ON you were discussing about)
> > >    - two regulators called vbat and reg-en for us (I guess they're
> > >      meant to power the chip, and its registers >>
> > > Do you know if you're also using those? Or could it be that it's just
> > > hardwired to some non-gatable crystal / regulator on the RPI?
>=20
> Not on Pi3, but the three gpios and the clock are pretty common for
> Broadcom bt controller (cf v4 of dt-bindings patch).
>=20
> This is already partially supported in the hci_bcm driver.
> Today this driver registers a platform_driver(legacy/ACPI) and a
> serdev_device_driver (new/DT).
>=20
> The platform driver retrieves the gpios and mainly uses them in pm ops.
> Once the ACPI for serdev will be supported, this plat driver should be
> removed.
>=20
> The serdev driver does no support this yet because I used the RPi3
> as dev platform. But this is something we want to have as well.

I'll give it a shot then. Thanks!
Maxime

--=20
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com

--jayo6t3wqxqw5lmy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBAgAGBQJZnY0/AAoJEBx+YmzsjxAg0DwP/jtO6+7om0QpVOxBaFXUE/lX
o0sJUPj5OsbFB/1feyCXWGEkMTrQdBCIl1EkLsm5tezea5dKEZZnspmyUybNcSUU
xd3EkmRrUdP4x+ZA6W36k8x+FvUcdwV/zqDBWwn2WB1rXicinC20sjJVxkGC3sM6
qyHmc6CHiBFp8KH+RUeVWz4Yoee2s1zGcPQY+lfUz1n9mXqBTRv7TxkIAoMyIqgM
TJ/cNsAgx8/mBhQtvj+IN9dIghczIhmruHU6nrFsSVTu6pMpP8NBGvIsfhubE0wg
b9hLZsBRJrM7osaIK+jUTtQ0lerRvuU4pbv5DZLXFJ3r6WcJyAeH9ZhTvxlLyNP0
ZRnlsept8zt19mCUeGfo+806AwplXKFgZMdFyQfExNxvnh7Xaap6Sgeomw6Lppgk
VxrqWvZT2kZ9/6QSWEVZSdY8TGKy8XOzMRwG1PG95/p4+PY1mvi1zsbW4JVmi3P2
CRM+78ov7xWyzjcxb5PRc+70igvo8pn6rdGLUZBjH8bd69WAGeaVkTw13HzILBwb
/1i5T5EL/X4zWB8A3WgC4QlSvqGMy/gS9EplWrodGPgsEQ8KBmJFrb3JuTcbRggl
YLFrL2sYpLu+LreXAYQFcCta/8GhGQgkt81D67VSeiJNYtbtx/pioTwxdR621E67
BKEsGlAmmRy+uwyUmbq6
=F193
-----END PGP SIGNATURE-----

--jayo6t3wqxqw5lmy--
