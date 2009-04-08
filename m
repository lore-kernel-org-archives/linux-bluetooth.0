Return-Path: <cyrus@holtmann.org>
Date: Wed, 8 Apr 2009 15:30:08 -0400
From: Zygo Blaxell <zblaxell@feedme.hungrycats.org>
To: Gene Heskett <gene.heskett@verizon.net>
Cc: Zygo Blaxell <zblaxell@feedme.hungrycats.org>,
	Bastien Nocera <hadess@hadess.net>,
	Zygo Blaxell <zblaxell@dactyl.vpn7.hungrycats.org>,
	jayjwa <jayjwa@atr2.ath.cx>, linux-bluetooth@vger.kernel.org
Subject: Re: The link I had working quit.  Help
Message-ID: <20090408193008.GE18671@hungrycats.org>
References: <200904041636.25409.gene.heskett@verizon.net> <200904081106.11442.gene.heskett@verizon.net> <20090408161729.GD18671@hungrycats.org> <200904081450.37424.gene.heskett@verizon.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="8vCeF2GUdMpe9ZbK"
In-Reply-To: <200904081450.37424.gene.heskett@verizon.net>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>


--8vCeF2GUdMpe9ZbK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 08, 2009 at 02:50:37PM -0400, Gene Heskett wrote:
> >gnome-bluetooth is a fork of bluez-gnome.  You'd probably have to build =
it
> > out of svn at svn://svn.gnome.org/svn/gnome-bluetooth unless someone's
> > making binary packages somewhere.
> >
> I see.  Since I've built and installed bluezx-4.34, am I new enough?

bluez is the user-space part of the bluetooth stack.  gnome-bluetooth is th=
e UI.

> Got it, cu doesn't know the port(s) I named with the -p option.  And the=
=20
> manpage doesn't seem to describe that part either. :(

	cu -l /dev/ttyS0 -s 9600

or for rfcomm most likely just

	cu -l /dev/rfcomm0

though with a real RS-232 port on the remote device I don't
know if you have to match baud rates or not.


--8vCeF2GUdMpe9ZbK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAknc+0AACgkQgfmLGlazG5zOXQCgsF97UB8apHIfoLJqjjDIzOmA
5fwAoOuV4jyJBQPPz2wWKyVb7hQatPdj
=Wh+W
-----END PGP SIGNATURE-----

--8vCeF2GUdMpe9ZbK--
