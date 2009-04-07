Return-Path: <cyrus@holtmann.org>
Date: Tue, 7 Apr 2009 16:40:55 -0400
From: Zygo Blaxell <zblaxell@feedme.hungrycats.org>
To: Gene Heskett <gene.heskett@verizon.net>
Cc: Zygo Blaxell <zblaxell@dactyl.hungrycats.org>,
	linux-bluetooth@vger.kernel.org
Subject: Re: The link I had working quit.  Help
Message-ID: <20090407204055.GB18671@hungrycats.org>
References: <200904041636.25409.gene.heskett@verizon.net> <200904061457.02511.gene.heskett@verizon.net> <20090406221444.GA25011@dactyl.hungrycats.org> <200904070008.48621.gene.heskett@verizon.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="WhfpMioaduB5tiZL"
In-Reply-To: <200904070008.48621.gene.heskett@verizon.net>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>


--WhfpMioaduB5tiZL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 07, 2009 at 12:08:48AM -0400, Gene Heskett wrote:
> On Monday 06 April 2009, Zygo Blaxell wrote:
> >Do you seriously have a Coco3 wired up to Bluetooth?  How?  Presumably n=
ot
> >with a native stack...some kind of dongle?
> >
> Roger Taylor is selling a remake of the old Deluxe RS-232 pack, with an a=
7=20
> eb101 module taking the place of the db25 connector.  $65.  Uses the same=
 old=20
> rs-232 drivers.  He is one of the movers & shakers of the coco list on=20
> maltedmedia.com.

After reading http://www.a7eng.com/downloads/a7-ds-eb101.pdf it looks
like the device has an automatic discovery mode which is activated by
pressing a switch for more than 5 but less than 10 seconds.  It seems
to assume it's talking to another device which has a serial port profile
service enabled...maybe it only works with other eb101's.

It also has a command mode (http://www.a7eng.com/downloads/a7-qs-serial.pdf)
which lets you read things like the device settings and information about
remote devices from the module's point of view.  Especially interesting
ones (page 9) are:

	get connectable  (should be on)
	get trustedlist  (should include your paired bluez device)


--WhfpMioaduB5tiZL
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAknbulcACgkQgfmLGlazG5zbZwCeOWNy+AHAW1t3zSQgO/qH88Ny
74YAniQI7ZgFRAzmASn9jA0AC1ySWI4U
=8QzQ
-----END PGP SIGNATURE-----

--WhfpMioaduB5tiZL--
