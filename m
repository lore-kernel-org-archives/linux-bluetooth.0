Return-Path: <bluez-users-bounces@lists.sourceforge.net>
From: Daniel Rindt <drindt@mx-solutions.de>
To: bluez-users@lists.sourceforge.net
Date: Thu, 5 Jul 2007 13:26:14 +0200
MIME-Version: 1.0
Message-Id: <200707051326.19875.drindt@mx-solutions.de>
Subject: [Bluez-users] how to initialize the bluetooth dongle?
Reply-To: drindt@mx-solutions.de,
        BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============0709271845=="
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

--===============0709271845==
Content-Type: multipart/signed; boundary="nextPart1940401.VHZI9ASHWo";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Content-Transfer-Encoding: 7bit

--nextPart1940401.VHZI9ASHWo
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hello,

my question is how to initialize the bt-dongle on the usb port. My applicat=
ion=20
should run directly after booting the kernel. But currently it needs to run=
=20
hcid -n -f hcid.conf to initialize it first.
Someone please can tell me how i can this built in directly in my app?

Thanks
Daniel

--nextPart1940401.VHZI9ASHWo
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (GNU/Linux)

iD8DBQBGjNVXXpNwE9507IoRAqOgAJ0S7BmmzcU3wh5PP26KM80lfBOaTgCZAUIs
p+pb529F824u/xRIth3eP4Q=
=I4hj
-----END PGP SIGNATURE-----

--nextPart1940401.VHZI9ASHWo--


--===============0709271845==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
--===============0709271845==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

--===============0709271845==--
