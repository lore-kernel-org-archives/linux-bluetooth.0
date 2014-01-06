Return-Path: <cyrus@holtmann.org>
Message-ID: <1389024405.2739.2.camel@tenshi>
Subject: Re: A problem with "rfcomm bind" and wvdial
From: Andrey Vihrov <andrey.vihrov@gmail.com>
To: Gianluca Anzolin <gianluca@sottospazio.it>
Cc: peter@hurleysoftware.com, marcel@holtmann.org,
 gregkh@linuxfoundation.org,  jslaby@suse.cz, linux-bluetooth@vger.kernel.org
Date: Mon, 06 Jan 2014 18:06:45 +0200
In-Reply-To: <20140106113353.GA21381@sottospazio.it>
References: <20140105154942.GA12621@sottospazio.it>
	 <20140106113353.GA21381@sottospazio.it>
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature";
	boundary="=-q1s74ohdL6VMMoGtTcWm"
Mime-Version: 1.0
List-ID: <linux-bluetooth.vger.kernel.org>


--=-q1s74ohdL6VMMoGtTcWm
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

Thanks for the update. I applied the patch to the bluetooth-next
kernel and it seems to work as expected. I ran wvdial several times in a
row, and it was able to connect every time.

> On Sun, Jan 05, 2014 at 04:49:42PM +0100, Gianluca Anzolin wrote:
> > Hello,
> >=20
> > I looked at your problem this afternoon and I think I know what's happe=
ning:
> > wvdial is opening the port with the flag O_NONBLOCK. As expected the rf=
comm
> > code returns immediately instead of waiting for the BT connection to co=
me
> > up. Then wvdial sends the AT commands and the writes fail.
>=20
> Hi,
>=20
> could you please test the attached patch?
>=20
> If it works and people are ok with it I'll submit it along with the other=
 fixes
> I already sent to the list.
>=20
> Thank you,
> Gianluca

--=20
Andrey Vihrov <andrey.vihrov@gmail.com>


--=-q1s74ohdL6VMMoGtTcWm
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEABECAAYFAlLK1JUACgkQ9lMsMEZuiz5CMgCfY4Trc17DunAjbMR27kxv05P2
2G0AniyqTDDuBKZX1LAQjS7gVWnMspol
=4JNY
-----END PGP SIGNATURE-----

--=-q1s74ohdL6VMMoGtTcWm--
