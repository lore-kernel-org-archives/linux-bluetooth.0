Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Date: Wed, 8 Nov 2006 21:00:57 +0000
From: Paul LeoNerd Evans <leonerd-bluez@leonerd.org.uk>
To: bluez-users@lists.sourceforge.net
Message-ID: <20061108210057.7c40adaa@nim.leo>
Mime-Version: 1.0
Subject: [Bluez-users] "Connect" button on Logitech bluetooth receiver
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============0009240640=="
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

--===============0009240640==
Content-Type: multipart/signed; boundary="Sig_s_+E0ypXJ84K9FR3uO/MvQ3";
	protocol="application/pgp-signature"; micalg=PGP-SHA1

--Sig_s_+E0ypXJ84K9FR3uO/MvQ3
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

I've got a Logitech bluetooth keyboard/mouse combo that comes with a
charging base for the mouse, which server also as the BT receiver. On it
is a button marked "connect".

When the receiver is working in "I'll do the bluetooth bit and just
pretend to be a USB keyboard and mouse", this is used to connect it to
the keyboard or mouse in question. When it is running as a real Bluetooth
receiver with the HID being done by Linux, this button appears to have no
effect.

I was wondering whether it might be possible to watch for this button
being pressed, and if so, trigger a

  hidd --search

command.

I ask because sometimes lately I've noticed the keyboard and/or mouse
will become disconnected, requiring the above command to be run
simultaneously to pressing the "connect" button on the keyboard/mouse.
When the mouse has done that, not too difficult. But if the keyboard
goes, it's obviously more difficult to recover :)

--=20
Paul "LeoNerd" Evans

leonerd@leonerd.org.uk
ICQ# 4135350       |  Registered Linux# 179460
http://www.leonerd.org.uk/

--Sig_s_+E0ypXJ84K9FR3uO/MvQ3
Content-Type: application/pgp-signature; name=signature.asc
Content-Disposition: attachment; filename=signature.asc

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQFFUkWNqRXzCRLr5iQRArZMAJ9vGmLf0kqSuZJo+AAHyZ5lbPs/mQCfbYvi
fYEV0wjCb+hRfliTmy8vz8Q=
=gmpL
-----END PGP SIGNATURE-----

--Sig_s_+E0ypXJ84K9FR3uO/MvQ3--


--===============0009240640==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
--===============0009240640==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

--===============0009240640==--
