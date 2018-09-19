Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Date: Wed, 19 Sep 2018 16:03:54 +0200
From: Pavel Machek <pavel@ucw.cz>
To: linux-bluetooth@vger.kernel.org
Cc: szymon.janc@codecoup.pl
Subject: setting random address on a bluetooth low-energy adapter
Message-ID: <20180919140354.GA2739@amd>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="dDRMvlgZJXvWKvBx"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>


--dDRMvlgZJXvWKvBx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi!

I'm trying to use PC (with usb dongle) as a bluetooth low-energy
device -- similar to heart rate sensor. But the device I'm trying to
emulate is using random address and its control software seems to
expect it.

Is there way to override the address / set the random address?
https://elinux.org/images/3/32/Doing_Bluetooth_Low_Energy_on_Linux.pdf
says patch might be needed...

Pointer to the patch would be welcome.

Thanks,
									Pavel

--=20
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html

--dDRMvlgZJXvWKvBx
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iEYEARECAAYFAluiV0oACgkQMOfwapXb+vKycwCePes77U/IeBFhnVbFTCJW5mQO
/nAAnj1DnBIJywFhk+TouQeo6ln6OTKL
=QbHU
-----END PGP SIGNATURE-----

--dDRMvlgZJXvWKvBx--
