Return-Path: <cyrus@holtmann.org>
Date: Wed, 8 Apr 2009 15:36:40 -0400
From: Zygo Blaxell <zblaxell@feedme.hungrycats.org>
To: Gene Heskett <gene.heskett@verizon.net>
Cc: Zygo Blaxell <zblaxell@feedme.hungrycats.org>,
	Bastien Nocera <hadess@hadess.net>,
	Zygo Blaxell <zblaxell@dactyl.vpn7.hungrycats.org>,
	jayjwa <jayjwa@atr2.ath.cx>, linux-bluetooth@vger.kernel.org
Subject: Re: The link I had working quit.  Help
Message-ID: <20090408193640.GF18671@hungrycats.org>
References: <200904041636.25409.gene.heskett@verizon.net> <200904081450.37424.gene.heskett@verizon.net> <20090408193008.GE18671@hungrycats.org> <200904081535.05157.gene.heskett@verizon.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="gneEPciiIl/aKvOT"
In-Reply-To: <200904081535.05157.gene.heskett@verizon.net>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>


--gneEPciiIl/aKvOT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 08, 2009 at 03:35:04PM -0400, Gene Heskett wrote:
> This is slightly different:
> [root@coyote test]# cu -l /dev/rfcomm0 -s 9600
> cu: open (/dev/rfcomm0): No route to host
> cu: /dev/rfcomm0: Line in use
>=20
> Line in use?

"Line in use" means that cu couldn't lock the device or open it.
It's not an OS-level error.

--gneEPciiIl/aKvOT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAknc/MgACgkQgfmLGlazG5y0ywCffGk3D8hW9N4zuFL2hbmSqj/a
XrcAnR/0PwuFKjQUqImRpFkEVChk+Su/
=eFgd
-----END PGP SIGNATURE-----

--gneEPciiIl/aKvOT--
