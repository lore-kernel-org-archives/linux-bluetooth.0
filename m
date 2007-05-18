Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Date: Fri, 18 May 2007 11:24:41 +0200
From: Ismael Valladolid Torres <ivalladt@punkass.com>
In-reply-to: <1179419354.10069.144.camel@violet>
To: bluez-users@lists.sourceforge.net
Message-id: <20070518092441.GE3629@punkass.com>
MIME-version: 1.0
References: <464C8133.9010901@gmail.com> <1179419354.10069.144.camel@violet>
Subject: Re: [Bluez-users] How do I enable rfcomm?
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============0538285870=="
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net


--===============0538285870==
Content-type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="B4IIlcmfBL/1gGOG"
Content-disposition: inline


--B4IIlcmfBL/1gGOG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Marcel Holtmann escribe:
> the next bluez-utils release will provide a nice D-Bus interface to make
> that a lot easier and deprecate the use of rfcomm at all. Until then
> simply call "rfcomm bind all".

Then you can use "rfcomm -a" or simply "rfcomm" to check whether
they've been binded properly.

Take into account that "bind" and "connect" are different verbs!

Cordially, Ismael
--=20
Ismael Valladolid Torres  m. +34679156321
La media hostia           j. ivalladt@gmail.com

http://lamediahostia.blogspot.com/

--B4IIlcmfBL/1gGOG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFGTXDZ59Nokt5yGvQRAtWEAJ9Rus0bHyLVir97a5HRt52/p6eTngCgnBDA
aahg5lQrsceS+2wOtS9UD+0=
=ZWCB
-----END PGP SIGNATURE-----

--B4IIlcmfBL/1gGOG--


--===============0538285870==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
--===============0538285870==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

--===============0538285870==--
