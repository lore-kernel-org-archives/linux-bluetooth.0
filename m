Return-Path: <cyrus@holtmann.org>
From: Vincenzo Ampolo <vincenzo.ampolo@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: Bluetooth honeypot - hci socket that reads package problem -
Date: Mon, 20 Jul 2009 15:03:48 +0200
Cc: linux-bluetooth@vger.kernel.org,
 Stefano Zanero <zanero@elet.polimi.it>
References: <200907200938.35808.vincenzo.ampolo@gmail.com> <1248075928.4549.91.camel@violet>
In-Reply-To: <1248075928.4549.91.camel@violet>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1294354.PRFRKEA5tg";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Message-Id: <200907201503.51944.vincenzo.ampolo@gmail.com>
List-ID: <linux-bluetooth.vger.kernel.org>

--nextPart1294354.PRFRKEA5tg
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Monday 20 July 2009 09:45:28 am Marcel Holtmann wrote:
> You need to set the device into RAW mode. Otherwise the kernel will keep
> processing the HCI packets.

Do you mean that i've to use a special device that supports RAW mode or tha=
t i=20
can open a socket in RAW mode?

if it's the latter,i'm googlin for a while and i don't find any useful=20
information. How should i call the socket C function to accomplish it?

Thanks.

=2D-=20
Vincenzo Ampolo
http://goshawknest.wordpress.com/
http://vincenzo-ampolo.net

GnuPG Key:=20
http://keyserver.ubuntu.com:11371/pks/lookup?op=3Dget&search=3D0x9BF47CA71E=
506DE9

--nextPart1294354.PRFRKEA5tg
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkpkazQACgkQm/R8px5QbekUYQCgj4JV8pKw2z9u11oag03coudA
p+oAnj0e8rB8YYiMiLx9akUJh80sd1wu
=dN9W
-----END PGP SIGNATURE-----

--nextPart1294354.PRFRKEA5tg--
