Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] bluez-utils2: Bluetooth header files not found
From: Pierre N <pierren@mac.com>
To: bluez-users@lists.sourceforge.net
In-Reply-To: <1082717535.24548.16.camel@localhost>
References: <Pine.LNX.4.44.0404231939570.1728-100000@data.home>
	 <1082717535.24548.16.camel@localhost>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-ure2/ENiKJOHtnh3Xk/g"
Message-Id: <1082725021.10395.6.camel@localhost>
Mime-Version: 1.0
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Fri, 23 Apr 2004 14:57:01 +0200


--=-ure2/ENiKJOHtnh3Xk/g
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Well, I'm even more stupid than my wildest dreams. Forgot to run make,
now that I did it everything is fine. And my USB dongle is used for the
first time since switching to Linux!!! Great work. Thanks for all your
help guys and you should advertise hid2hci everywhere!!

--
Pierre


On Fri, 2004-04-23 at 12:52, Pierre N wrote:
> Done. Got libs (and after that libs2) from CVS.=20
> ./bootstrap
> ./configure=20
> Pointed --with-bluetooth to the proper path and now here is what I get:
>=20
> checking bluetooth/bluetooth.h usability... yes
> checking bluetooth/bluetooth.h presence... no
> configure: WARNING: bluetooth/bluetooth.h: accepted by the compiler,
> rejected by the preprocessor!
> configure: WARNING: bluetooth/bluetooth.h: proceeding with the
> compiler's result
> checking for bluetooth/bluetooth.h... yes
> checking for bt_inquiry in -lbluetooth... no
> configure: error: Bluetooth library not found
>=20
> Moving forward slowly...
>=20
> --
> Pierre
>=20
>=20
> On Fri, 2004-04-23 at 11:40, Geoff Shang wrote:
> > On Fri, 23 Apr 2004, Pierre N wrote:
> >=20
> > > checking bluetooth/bluetooth.h usability... no
> > > checking bluetooth/bluetooth.h presence... no
> > > checking for bluetooth/bluetooth.h... no
> > > configure: error: Bluetooth header files not found
> >=20
> > Have you compiled and installed bluez-libs?
> >=20
> > Geoff.
>=20

--=-ure2/ENiKJOHtnh3Xk/g
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBAiRKdZkVEuKKlE7gRAohaAKCVRaq+BsRhjAIJ2G+6SAX0DCg30ACgu1s2
oImlWfUjWAAvy7qeA/joJqE=
=VZWe
-----END PGP SIGNATURE-----

--=-ure2/ENiKJOHtnh3Xk/g--



-------------------------------------------------------
This SF.net email is sponsored by: The Robotic Monkeys at ThinkGeek
For a limited time only, get FREE Ground shipping on all orders of $35
or more. Hurry up and shop folks, this offer expires April 30th!
http://www.thinkgeek.com/freeshipping/?cpg=12297
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
