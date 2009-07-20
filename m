Return-Path: <cyrus@holtmann.org>
From: Vincenzo Ampolo <vincenzo.ampolo@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: Bluetooth honeypot - hci socket that reads package problem -
Date: Mon, 20 Jul 2009 09:38:32 +0200
Cc: Stefano Zanero <zanero@elet.polimi.it>
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1992165.7sPh4d1qg4";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Message-Id: <200907200938.35808.vincenzo.ampolo@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

--nextPart1992165.7sPh4d1qg4
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

=46or my thesis, i'm trying to write a bluez based honeypot.
The basic concept is to listen at the hci level and perform actions. (switc=
h=20
on sockets in rfcomm or l2cap channels or addresses to audit the data)

I started studying the hcidump code and the hci socket. The main problem i'=
m=20
having is that the hci socket which is created in this way

	sk =3D socket(AF_BLUETOOTH, SOCK_RAW, BTPROTO_HCI);

does not "pop" the package from the bluez stack, it just reads but the pack=
age=20
will continue to be processed by the stack. So if there is an attempt for a=
=20
connection it will find a closed socket. Is there a way to "pop" the packag=
e=20
from the stack, so i can read the destination channel or address of the=20
package and turn on a socket on that specified channel or address and then=
=20
"push" again the package into the stack?

If it's not possible, the only way to set my bluetooth honeypot up is to op=
en=20
a socket for each rfcomm and l2cap channel and address and wait for data to=
=20
audit.

Thanks. =20
=2D-=20
Vincenzo Ampolo
http://goshawknest.wordpress.com/
http://vincenzo-ampolo.net

GnuPG Key:=20
http://keyserver.ubuntu.com:11371/pks/lookup?op=3Dget&search=3D0x9BF47CA71E=
506DE9

--nextPart1992165.7sPh4d1qg4
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEABECAAYFAkpkHvkACgkQm/R8px5QbeklBgCgiZDNYCcqbUdmXCQNPbXafcxH
eM8An0o1B9quhfnEBjONfQs3GMPYkFJC
=L2j9
-----END PGP SIGNATURE-----

--nextPart1992165.7sPh4d1qg4--
