Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Microsoft BT Dongle and other questions
From: Bryan Forbes <bryan@reigndropsfall.net>
To: bluez-users@lists.sourceforge.net
In-Reply-To: <1106245278.13562.8.camel@pegasus>
References: <1106236749.21181.17.camel@localhost.localdomain>
	 <1106245278.13562.8.camel@pegasus>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-k7ljiinjBb+Iyx1ewJRf"
Message-Id: <1106246506.21181.23.camel@localhost.localdomain>
Mime-Version: 1.0
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
Date: Thu, 20 Jan 2005 12:41:46 -0600


--=-k7ljiinjBb+Iyx1ewJRf
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Marcel,
> [snip]
> If this is the new 2.0 version then I am interested. Otherwise it is
> useless, because I already have two of the older ones. What does lsusb
> tell me about your dongle?

This is definately the 2.0 version.  It says "Transiever for Bluetooth
2.0" on the back of it.

> [snip]
> Maybe should do a "hciconfig hci0 noscan" to disable inquiry and page
> scan. This should save battery power. If you don't need this dongle at
> all you can load the hci_usb driver with "ignore=3D1" (maybe a newer
> kernel is needed).
>=20
> The PC notebooks have a hardware switch to physical disconnect the
> device from the USB bus. I don't know if a similar thing exists on the
> Apple machines.

I'll try this, thanks!

> [snip]
> I didn't had time to look at the suspend/resume support. On some
> machines it work and on some it don't.

How hard would it be to put this support in for the next patch cycle?


--=20
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Bryan Forbes
bryan@reigndropsfall.net
http://www.reigndropsfall.net

"It does not take a majority to prevail, but rather an irate, tireless
minority keen to set brush fires in people's minds."
        - Samuel Adams, an architect of the Constitution

Key fingerprint =3D 3D7D B728 713A BB7B B8B1  5B61 3888 17E0 70CA 0F3D

--=-k7ljiinjBb+Iyx1ewJRf
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQBB7/tqOIgX4HDKDz0RAn0rAJ4/k/daFDe5BhfQDcCtAcgCZcImLACgsFgz
mzW3jfyTZIq5mHPn6BRBMlY=
=lbTs
-----END PGP SIGNATURE-----

--=-k7ljiinjBb+Iyx1ewJRf--



-------------------------------------------------------
This SF.Net email is sponsored by: IntelliVIEW -- Interactive Reporting
Tool for open source databases. Create drag-&-drop reports. Save time
by over 75%! Publish reports on the web. Export to DOC, XLS, RTF, etc.
Download a FREE copy at http://www.intelliview.com/go/osdn_nl
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
