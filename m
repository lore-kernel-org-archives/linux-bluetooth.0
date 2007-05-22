Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Date: Tue, 22 May 2007 10:12:55 -0600
From: Rob Sims <bluez-z@robsims.com>
To: bluez-users@lists.sourceforge.net
Message-ID: <20070522161255.GA9813@robsims.com>
MIME-Version: 1.0
Subject: [Bluez-users] Sharing devices with dual-booted Windows
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============1045560577=="
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net


--===============1045560577==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="/04w6evG8XlLl3ft"
Content-Disposition: inline


--/04w6evG8XlLl3ft
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I have several devices that I use with both Linux and Windows on the
same laptop.  The issue is that the remote devices, such as my PDA, see
the laptop as the same device no matter what OS is running, and pairing
is broken.

I need some way to either make the Windows and Linux stacks present a
unified front in terms of pairing, or alter the adapter address while in
Linux so that the laptop appears to be a different device.  Altering the
name alone in hcid.conf is insufficient.

Currently, when switching OS, I must manually delete the pairing from my
PDA, then re-pair the device.

Is there a way to override the preprogrammed address with a user
specified one, as you can do with network MAC addresses?  The adapter is
a built-in hci_usb driven device.

Searching the list archives yielded nothing applicable.
--=20
Rob

--/04w6evG8XlLl3ft
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFGUxaHnvKppSZW8osRAqn9AJ9eaHcA2Xv3kiVOVUojQyu7oduj6QCffsTg
+ZwUicd3IBOXZF51ivK4Cgg=
=hudy
-----END PGP SIGNATURE-----

--/04w6evG8XlLl3ft--


--===============1045560577==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
--===============1045560577==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

--===============1045560577==--
