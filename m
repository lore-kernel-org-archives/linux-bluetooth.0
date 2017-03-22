Return-Path: <pavel@ucw.cz>
Date: Wed, 22 Mar 2017 10:32:33 +0100
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
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCHv2 04/11] tty: serial: omap: add UPF_BOOT_AUTOCONF flag
 for DT init
Message-ID: <20170322093233.GC26771@amd>
References: <20170321223216.11733-1-sre@kernel.org>
 <20170321223216.11733-5-sre@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="wxDdMuZNg1r63Hyj"
In-Reply-To: <20170321223216.11733-5-sre@kernel.org>
List-ID: <linux-bluetooth.vger.kernel.org>


--wxDdMuZNg1r63Hyj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue 2017-03-21 23:32:09, Sebastian Reichel wrote:
> The UPF_BOOT_AUTOCONF flag is needed for proper
> flow control support.
>=20
> Signed-off-by: Sebastian Reichel <sre@kernel.org>

Acked-by: Pavel Machek <pavel@ucw.cz>

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--wxDdMuZNg1r63Hyj
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAljSRLEACgkQMOfwapXb+vIj1QCgsWwagN8B2+AMR3X7RcDn48g6
RwUAnAvEkYtt7sd1yd6luBwZVb+TyNwW
=vGsM
-----END PGP SIGNATURE-----

--wxDdMuZNg1r63Hyj--
