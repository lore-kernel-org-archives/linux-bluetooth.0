Return-Path: <pavel@ucw.cz>
Date: Wed, 22 Mar 2017 10:32:14 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Sebastian Reichel <sre@kernel.org>
Cc: Marcel Holtmann <marcel@holtmann.org>,
	Gustavo Padovan <gustavo@padovan.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	Rob Herring <robh+dt@kernel.org>,
	Samuel Thibault <samuel.thibault@ens-lyon.org>,
	Tony Lindgren <tony@atomide.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jslaby@suse.com>, Mark Rutland <mark.rutland@arm.com>,
	linux-bluetooth@vger.kernel.org, linux-serial@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Rob Herring <robh@kernel.org>
Subject: Re: [PATCHv2 02/11] Bluetooth: hci_uart: add serdev driver support
 library
Message-ID: <20170322093214.GB26771@amd>
References: <20170321223216.11733-1-sre@kernel.org>
 <20170321223216.11733-3-sre@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="4SFOXa2GPu3tIq4H"
In-Reply-To: <20170321223216.11733-3-sre@kernel.org>
List-ID: <linux-bluetooth.vger.kernel.org>


--4SFOXa2GPu3tIq4H
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue 2017-03-21 23:32:07, Sebastian Reichel wrote:
> From: Rob Herring <robh@kernel.org>
>=20
> This adds library functions for serdev based BT drivers. This is largely
> copied from hci_ldisc.c and modified to use serdev calls. There's a little
> bit of duplication, but I avoided intermixing this as the ldisc code shou=
ld
> eventually go away.
>=20
> Signed-off-by: Rob Herring <robh@kernel.org>
> Cc: Marcel Holtmann <marcel@holtmann.org>
> Cc: Gustavo Padovan <gustavo@padovan.org>
> Cc: Johan Hedberg <johan.hedberg@gmail.com>
> Cc: linux-bluetooth@vger.kernel.org
> [Fix style issues reported by Pavel]
> Signed-off-by: Sebastian Reichel <sre@kernel.org>

Acked-by: Pavel Machek <pavel@ucw.cz>

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--4SFOXa2GPu3tIq4H
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAljSRJ4ACgkQMOfwapXb+vKGuwCgiR3daL4LX1g5laAOGWNXMTBS
uzYAnjAJVH3NJzwSGdlRx8ESntMlscEa
=qbEh
-----END PGP SIGNATURE-----

--4SFOXa2GPu3tIq4H--
