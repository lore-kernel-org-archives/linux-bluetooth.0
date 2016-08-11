Return-Path: <wsa@the-dreams.de>
Date: Thu, 11 Aug 2016 23:02:24 +0200
From: Wolfram Sang <wsa@the-dreams.de>
To: linux-usb@vger.kernel.org
Cc: Wolfram Sang <wsa-dev@sang-engineering.com>,
	Marcel Holtmann <marcel@holtmann.org>,
	Gustavo Padovan <gustavo@padovan.org>,
	Johan Hedberg <johan.hedberg@gmail.com>,
	linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] bluetooth: bcm203x: don't print error when allocating
 urb fails
Message-ID: <20160811210223.GC16719@katana>
References: <1470948695-23421-1-git-send-email-wsa@the-dreams.de>
 <1470948695-23421-2-git-send-email-wsa@the-dreams.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="R+My9LyyhiUvIEro"
In-Reply-To: <1470948695-23421-2-git-send-email-wsa@the-dreams.de>
List-ID: <linux-bluetooth.vger.kernel.org>


--R+My9LyyhiUvIEro
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 11, 2016 at 10:51:34PM +0200, Wolfram Sang wrote:
> From: Wolfram Sang <wsa-dev@sang-engineering.com>
>=20
> kmalloc will print enough information in case of failure.
>=20
> Signed-off-by: Wolfram Sang <wsa-dev@sang-engineering.com>

Sorry for the noise. This one was sent from the wrong email address :(


--R+My9LyyhiUvIEro
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJXrOffAAoJEBQN5MwUoCm2MHcQALVayb9jy2QVFaVnskcYD+0b
jmuep9seIf9BubHJuR+AkwvjP3oAaLvlKzvzmz+8S4QtxyJsMbKSedR5K0WIIZKJ
EUyYndz2LwS5t7X9Q0OTb6CXoLAZn/ZTHpzKSvRIPdj/KuIClGd1H7Rb0RHQxg42
w7J+mOGUMBfnA1wMA8bSx25u8jSDRADkFBVxAhx873IpmTTpAbZ7MjfmfaRorHju
6ItH/k98cm8mIMMQzaZfKJXtAcvOpEVcX4jfcMTqbOukzIjVvFzk6fIgL337q2SA
zVeXC/Ld+bd/KPXXgNw2sXt+TtKKheZ3zCGRVERfgvq8nNgViUAyt7mazE2UUUKd
cMsCh2nBxoo7olRtVE1BbYb3X9yGjENgnNzA9hm0lD4LREoEtu/Gsz79nnCLhnAl
33ciNEk3Cy/bdiD5B8pNw65IMas+x5rQEW1dhnAt63DBmFyHOAWfJy5Q+ldrF34c
n+/AlboZ4IDolmM5ooe4lAYoyr3+AvEyyTTOwiitbk3Wbn0jT+rPnoEgNk8kcD/R
P3vur8HkivgLDrr6TszfxFol6BYqGp+z/AshYkAKmWUn2PA7OZXz2tq9/3Sy6Cfp
HPrOyz68FyLagQ3sZYQtB2nuV0gGK9Fb7YlSe/tAzRzk82hywLD7c8O+P0+O9DYr
x8u/5vQcdqnc650wOWyq
=k34h
-----END PGP SIGNATURE-----

--R+My9LyyhiUvIEro--
