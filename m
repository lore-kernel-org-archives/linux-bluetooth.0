Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: Pierre N <pierren@mac.com>
To: bluez-users@lists.sourceforge.net
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-m/gl3xKX49HU+TSjVJd0"
Message-Id: <1082711899.23022.10.camel@localhost>
Mime-Version: 1.0
Subject: [Bluez-users] bluez-utils2: Bluetooth header files not found
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
Date: Fri, 23 Apr 2004 11:18:19 +0200


--=-m/gl3xKX49HU+TSjVJd0
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Hi,

Trying to compile bluez-utils2 out from CVS. I get this error message on
./configure:

checking for unistd.h... yes
checking bluetooth/bluetooth.h usability... no
checking bluetooth/bluetooth.h presence... no
checking for bluetooth/bluetooth.h... no
configure: error: Bluetooth header files not found

I tried ./configure --without-bluetooth
./configure --with-bluetooth=3D/usr/src/kernel-headers-2.4.22 I always get
the same error message.

Using 2.4.22 on powerpc. What else do you guys need?

--
Pierre


--=-m/gl3xKX49HU+TSjVJd0
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBAiN9bZkVEuKKlE7gRApyqAKDMWy7VI2Zd+VfnPU34OzUZHYQ9wgCgrvWr
N0CD6/hjUtL79+its/Xvq28=
=hL5U
-----END PGP SIGNATURE-----

--=-m/gl3xKX49HU+TSjVJd0--



-------------------------------------------------------
This SF.net email is sponsored by: The Robotic Monkeys at ThinkGeek
For a limited time only, get FREE Ground shipping on all orders of $35
or more. Hurry up and shop folks, this offer expires April 30th!
http://www.thinkgeek.com/freeshipping/?cpg=12297
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
