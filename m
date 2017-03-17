Return-Path: <pavel@ucw.cz>
Date: Fri, 17 Mar 2017 16:25:47 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Sebastian Reichel <sre@kernel.org>
Cc: Marcel Holtmann <marcel@holtmann.org>,
	Gustavo Padovan <gustavo@padovan.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	Rob Herring <robh+dt@kernel.org>, Tony Lindgren <tony@atomide.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jslaby@suse.com>, Mark Rutland <mark.rutland@arm.com>,
	linux-bluetooth@vger.kernel.org, linux-serial@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 02/10] ARM: dts: N900: Add bluetooth
Message-ID: <20170317152547.GC8723@amd>
References: <20170304115833.3538-1-sre@kernel.org>
 <20170304115833.3538-3-sre@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="8X7/QrJGcKSMr1RN"
In-Reply-To: <20170304115833.3538-3-sre@kernel.org>
List-ID: <linux-bluetooth.vger.kernel.org>


--8X7/QrJGcKSMr1RN
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat 2017-03-04 12:58:25, Sebastian Reichel wrote:
> Add bcm2048 node and its system clock to the N900 device tree file.
> Apart from that a reference to the new clock has been added to
> wl1251 (which uses it, too).
>=20
> Signed-off-by: Sebastian Reichel <sre@kernel.org>

Acked-by: Pavel Machek <pavel@ucw.cz>

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--8X7/QrJGcKSMr1RN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAljL//sACgkQMOfwapXb+vLeDACgxIxA8ZkWurp0JVqG3fR3xgSY
gAYAoJgDJ0JUZ77Ewxb4bABD09TyYc9/
=bv0M
-----END PGP SIGNATURE-----

--8X7/QrJGcKSMr1RN--
