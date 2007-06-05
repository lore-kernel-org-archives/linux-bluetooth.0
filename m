Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <4665E3BA.1040309@gmail.com>
Date: Tue, 05 Jun 2007 16:29:14 -0600
From: Jarom Hatch <jshatch@gmail.com>
MIME-Version: 1.0
To: bluez-users@lists.sourceforge.net
Subject: [Bluez-users] dfutool problems
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============1883965724=="
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--===============1883965724==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enigC25FC9B84E0A022338E612D5"

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigC25FC9B84E0A022338E612D5
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
mode?  I don't want to have to buy a new adapter...  :)

Thanks.

Jarom Hatch


--------------enigC25FC9B84E0A022338E612D5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQFGZeO63FKK1nagbwsRAoLsAJ9i7ssjK6QD8wLwDWm57gEQ+yO/5wCgkSU+
MSoXqmGfTzDYSSFJB6Bvlaw=
=puDa
-----END PGP SIGNATURE-----

--------------enigC25FC9B84E0A022338E612D5--


--===============1883965724==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
--===============1883965724==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

--===============1883965724==--
