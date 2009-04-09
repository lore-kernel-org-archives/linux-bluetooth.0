Return-Path: <cyrus@holtmann.org>
Date: Thu, 9 Apr 2009 10:55:06 -0400
From: Zygo Blaxell <zblaxell@faye.furryterror.org>
To: Gene Heskett <gene.heskett@verizon.net>
Cc: Zygo Blaxell <zblaxell@feedme.hungrycats.org>,
	Bastien Nocera <hadess@hadess.net>,
	Zygo Blaxell <zblaxell@dactyl.vpn7.hungrycats.org>,
	jayjwa <jayjwa@atr2.ath.cx>, linux-bluetooth@vger.kernel.org
Subject: Re: The link I had working quit.  Help
Message-ID: <20090409145506.GB22527@faye.furryterror.org>
References: <200904041636.25409.gene.heskett@verizon.net> <200904081535.05157.gene.heskett@verizon.net> <20090408193640.GF18671@hungrycats.org> <200904082240.11543.gene.heskett@verizon.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="HlL+5n6rz5pIUxbD"
In-Reply-To: <200904082240.11543.gene.heskett@verizon.net>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>


--HlL+5n6rz5pIUxbD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 08, 2009 at 10:40:11PM -0400, Gene Heskett wrote:
> Anyway the a7 eb101 responses are as follows:
>=20
> get address local returns the correct bdaddr of that device.
> get address remote	err 4
> get connectable		on

connectable is good...

> get ecbonding		responder
> get ecconnection	auto
> get encryption		on
> get esschar		+
> get flow		hardware  (this changed to none after I did an 'rst factory'
> get linktimeout		0
> get name local		eb101
> get name remote		err 4
> get parity		none
> get security		off

security off is interesting, given encryption is on...you might want
to try the other three combinations of those flags.

> get sleep		off
> get sniff		on
> get status		false
> get trustedlist		empty return

Now that's a problem.  You should have the address of the USB dongle here
if you've paired with it.  That suggests that pairing maybe isn't working
on the eb101?  Or maybe you have to use 'set trustedlist'?

> get txpower		10
> get visible		11:11:11:11:11:11
>=20
> And finally, a 'con 11:11:11:11:11:11' munches along for several seconds=
=20
> before returning an 'err 14'

That makes sense...you haven't set up a serial port service on the Linux
machine for the eb101 to connect to.

> Did anyone take a look at that tarball I sent yet?

Not yet, although from eyeballing quickly it looks like bluetoothd has
done service discovery and picked up service records.  I'll decode it
the next time I have the tarball, the Bluetooth spec, and some time all
together in one place.


--HlL+5n6rz5pIUxbD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkneDEkACgkQqGx8JJsA/TKJ3ACdEqgKg7HC7Icj7Uv/01Pb02vQ
h8gAnjr7NH0rGgjj0G0xBf3BtiS0QTGA
=iLkC
-----END PGP SIGNATURE-----

--HlL+5n6rz5pIUxbD--
