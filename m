Return-Path: <cyrus@holtmann.org>
Date: Tue, 7 Apr 2009 17:56:19 -0400
From: Zygo Blaxell <zblaxell@feedme.hungrycats.org>
To: Gene Heskett <gene.heskett@verizon.net>
Cc: Zygo Blaxell <zblaxell@feedme.hungrycats.org>,
	Zygo Blaxell <zblaxell@dactyl.hungrycats.org>,
	jayjwa <jayjwa@atr2.ath.cx>, linux-bluetooth@vger.kernel.org
Subject: Re: The link I had working quit.  Help
Message-ID: <20090407215619.GC18671@hungrycats.org>
References: <200904041636.25409.gene.heskett@verizon.net> <200904071454.54317.gene.heskett@verizon.net> <20090407200201.GA18671@hungrycats.org> <200904071735.28381.gene.heskett@verizon.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="uh9ZiVrAOUUm9fzH"
In-Reply-To: <200904071735.28381.gene.heskett@verizon.net>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>


--uh9ZiVrAOUUm9fzH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 07, 2009 at 05:35:28PM -0400, Gene Heskett wrote:
> [root@coyote test]# ls -l /dev/rfcomm*
> crw------- 1 root root 216, 0 2009-04-07 17:25 /dev/rfcomm0
>=20
> [root@coyote test]# minicom
> minicom: cannot open /dev/rfcomm0: No such file or directory
>=20
> [root@coyote test]# ls -l /dev/rfcomm*
> crw------- 1 root root 216, 0 2009-04-07 17:25 /dev/rfcomm0

Hmmm...

Maybe try simply 'cat /dev/rfcomm0'?  Or use 'screen' or 'cu'.

While the 'cat' process is running, you can adjust terminal settings
=66rom another shell using 'stty', e.g. 'stty </dev/rfcomm0 9600 -echo'.

I am guessing when you try 'cat /dev/rfcomm0' it will exit immediately,
either with an EOF (which will print nothing) or an I/O error, or even
with 'Host is down'.

> If it doesn't exist, why can I see it in the /dev directory?

Because minicom is to testing raw serial connections what Roman numerals
are to the square root of Pi.  :-P

> I didn't even have to pair it to make it work late friday evening, and fo=
r=20
> several hours last saturday.  But I thought I'd change the default PIN an=
d it=20
> hasn't worked since.

It's possible to turn off security on the eb101 device (says the manual).
Maybe changing the default PIN turns it on?

> >Maybe try 'l2ping' to verify the remote device is still on?
> Variations on the theme:
> [root@coyote test]# l2ping 00:0c:84:00:86:F8
> Can't connect: Host is down
> [root@coyote test]# l2ping -i hci0 00:0c:84:00:86:F8
> Can't connect: Host is down
> [root@coyote test]# l2ping -i /dev/rfcomm0 00:0c:84:00:86:F8
> Can't connect: Host is down
>=20
> So maybe there is a clue here?

Could be that the USB dongle has hung on the Linux side, or the
eb101 device has shut itself down or been shut down by the Coco.
It would really help to have the eb101's status information.


--uh9ZiVrAOUUm9fzH
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAknbzAMACgkQgfmLGlazG5xc/gCdH9iO1pJMA/uAKVc0jv9rhNHN
0usAoNt8YiCuSyOcw8HnXMZKzXGaAGkI
=zm7q
-----END PGP SIGNATURE-----

--uh9ZiVrAOUUm9fzH--
