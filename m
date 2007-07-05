Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Date: Thu, 05 Jul 2007 13:26:39 +0200
From: Ismael Valladolid Torres <ivalladt@punkass.com>
To: bluez-users@lists.sourceforge.net
Message-id: <20070705112639.GB3575@punkass.com>
MIME-version: 1.0
Subject: [Bluez-users] Error trying to build bluez-utils
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============1371189885=="
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net


--===============1371189885==
Content-type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary=sdtB3X0nJg68CQEu
Content-disposition: inline


--sdtB3X0nJg68CQEu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

test -f lexer.c || /bin/sh ../ylwrap lexer.l .c lexer.c -- /bin/sh /usr/src=
/bluez/utils/missing --run flex =20
/usr/src/bluez/utils/hcid/ylwrap20111
make[3]: *** [lexer.c] Error 1
make[3]: Leaving directory `/usr/src/bluez/utils/hcid'
make[2]: *** [all] Error 2
make[2]: Leaving directory `/usr/src/bluez/utils/hcid'
make[1]: *** [all-recursive] Error 1
make[1]: Leaving directory `/usr/src/bluez/utils'
make: *** [all] Error 2

On my Debian sid I've instaled these packages apart from
build-essential which was already installed: automake, libtool,
libdbus-1-dev, bison and flex.

Any ideas welcome.

Cordially, Ismael
--=20
Ismael Valladolid Torres        GnuPG key: DE721AF4
                                   Jabber: ivalladt@gmail.com
http://linuxav.blogspot.com         Skype: ivalladt
http://lamediahostia.blogspot.com/

--sdtB3X0nJg68CQEu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFGjNVv59Nokt5yGvQRAllVAJ9wnwIhZX0d+WyRhoYTwuyI1nBE2wCfQwSR
a4Bl2/DmW6rKYdrOtMjwEbs=
=b3Zp
-----END PGP SIGNATURE-----

--sdtB3X0nJg68CQEu--


--===============1371189885==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
--===============1371189885==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

--===============1371189885==--
