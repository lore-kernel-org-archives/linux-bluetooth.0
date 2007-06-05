Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <4665E314.8050609@gmail.com>
Date: Tue, 05 Jun 2007 16:26:28 -0600
From: Jarom Hatch <jshatch@gmail.com>
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
Subject: [Bluez-devel] dfutool problems
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============1043535413=="
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--===============1043535413==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig8F1DF9FAF6EE4049D52EE4EF"

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig8F1DF9FAF6EE4049D52EE4EF
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

All,

I recently ran "dfutool archive foo" on my IBM bluetooth adapter
(Broadcom) thinking it would save my firmware to the file "foo".  It
created a zero-length file, said that the operation timed out, and
exited.  Ever since, by bluetooth adapter has been stuck in DFU mode:

# dfutool archive foo
Available devices with DFU support:

         1) Bus 003 Device 034: ID 0a5c:2000 Interface 0 (DFU mode)

Select device (abort with 0): 1

Firmware upload ...
Can't upload next block: Connection timed out (110)

from dmesg:
usb 3-1: Product: Broadcom Bluetooth Download Device

Does anyone know why it did that and how to get the adapter out of DFU
mode?  I don't want to have to buy a new adapter... :)

Thanks.

Jarom Hatch


--------------enig8F1DF9FAF6EE4049D52EE4EF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQFGZeMX3FKK1nagbwsRAr64AKCZvBMTcF7oZ16aQAEHyesnm4gQUgCgyuP7
2Xu1ZhrmcEJdXBL+8HhUwBk=
=lMzf
-----END PGP SIGNATURE-----

--------------enig8F1DF9FAF6EE4049D52EE4EF--


--===============1043535413==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
--===============1043535413==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--===============1043535413==--
