Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: Ian Gulliver <ian@penguinhosting.net>
To: bluez-users@lists.sourceforge.net
Message-ID: <20050109212302.GB5291@penguinhosting.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Fig2xvG2VGoz8o/s"
Subject: [Bluez-users] Apple keyboard problem
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
Reply-To: bluez-users@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Sun, 9 Jan 2005 16:23:03 -0500


--Fig2xvG2VGoz8o/s
Content-Type: multipart/mixed; boundary="NDin8bjvE/0mNLFQ"
Content-Disposition: inline


--NDin8bjvE/0mNLFQ
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I have an Apple bluetooth keyboard and mouse.  I can connect to and use
the mouse as expected.  However, attempting to connect to the keyboard:

sheba% sudo hcitool scan
Scanning ...
	00:0A:95:3A:4E:1C	ian=E2=80=99s keyboard

gives me:

sheba% sudo hidd --search
Bluetooth: HIDP (Human Interface Emulation) ver 1.0
Searching ...
        Connecting to device 00:0A:95:3A:4E:1C
Can't create HID control channel: Function not implemented

I never get a PIN entry request (as I did with the mouse) or any other
error.  There's a long pause between the "Connecting to device" and the
"Can't create".  According to lib.c in the kernel, ENOSYS is returned
on an unrecognized error code, but I don't know enough about the packet
formats to figure out what byte is the error code, or what else it might
mean.  Attached is an hcidump during the "hidd --search" run.

Any suggestions would be *greatly* appreciated.

--=20
Ian Gulliver
Penguin Hosting
"Failure is not an option; it comes bundled with your Microsoft products."

--NDin8bjvE/0mNLFQ
Content-Type: application/octet-stream
Content-Disposition: attachment; filename="keyboard-problem.dump"
Content-Transfer-Encoding: base64

CQAAAJGU4UGIoAEAAQEEBTOLngjIBwABAJGU4UEbsgEABA8EAAEBBBIAAQCSlOFB07kOAAQC
DwEcTjqVCgABAABAJQAXGQQAAQCblOFBE2oFAAQBAQARAAAAm5ThQcdsBQABBQQNHE46lQoA
GMwBABeZAQcAAQCblOFBjNMFAAQPBAABBQQOAAEAupThQQyQAgAEAwsiKQAcTjqVCgABAA==

--NDin8bjvE/0mNLFQ--

--Fig2xvG2VGoz8o/s
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFB4aC2efI+qeoOjxURAu7RAJ4xhTWtQCr5y+DT/RQQpZ/p3hGj6QCfWjru
2KjKTuq4CqZqLUFwtrM5Wjw=
=zPXh
-----END PGP SIGNATURE-----

--Fig2xvG2VGoz8o/s--


-------------------------------------------------------
The SF.Net email is sponsored by: Beat the post-holiday blues
Get a FREE limited edition SourceForge.net t-shirt from ThinkGeek.
It's fun and FREE -- well, almost....http://www.thinkgeek.com/sfshirt
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
