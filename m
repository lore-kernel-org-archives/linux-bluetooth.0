Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] PROBLEM: Apple Powerbook and apple keyboard,
	start up sequence fails
From: Matthew Grant <grantma@anathoth.gen.nz>
To: bluez-users@lists.sourceforge.net
In-Reply-To: <1100463431.21403.73.camel@pegasus>
References: <1100460997.6066.18.camel@localhost>
	 <1100463431.21403.73.camel@pegasus>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-i6UZn69Xp+ZcP2lAIjPE"
Message-Id: <1100507134.6064.8.camel@localhost>
Mime-Version: 1.0
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
Reply-To: bluez-users@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Mon, 15 Nov 2004 21:25:35 +1300


--=-i6UZn69Xp+ZcP2lAIjPE
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Mon, 2004-11-15 at 09:17, Marcel Holtmann wrote:
> Hi Matthew,
>=20
> > BT keyboard is connected on startup, but no keyboard output is
> > happening, and capslock light does not turn on when capslock key is
> > pressed.  This is not just the connection delay, as my mouse reconnects
> > successfully after boot. =20
>=20

No, there are definitely key press events coming through the BT stack.=20
The debug I sent shows it, and it has been confirmed with more than just
a cursory observation.  They are NOT getting into the HID layer.  That
is what I want to look at it, after checking correctness of incoming
events and negotiation.

> maybe the keyboard firmware is buggy. I read that Apple has a firmware
> update for their mouse and keyboard and I think it is worth to try it.

That is applied, to this keyboard, and the other one that does not
behave like this.

> Do you run your Bluetooth device in security mode 3?
>=20

Yes, I do not want to broadcast passwords for everyone to listen to.
Also, I have a second keyboard that does not behave like this...

We won't really know what is going on until things have been examined.=20
I was after some pointers on where to start looking at the hidp.ko
interface and the connection negotiation with the kernel HID core.  This
is obviously the first place to look and check from what has been
observed so far.

> > I believe the Apple Open firmware on the powerbook negotiates a
> > connection with the keyboard on power up or boot, and leaves the
> > built-in CSR USB dongle in USB HID emulation mode.  The keyboard starts
> > working after I switch it on and off, and it renegotiates a connection.=
=20

> It is all on the CSR BlueCore02 chip. The Apple firmware does nothing.

Thanks for that bit of info.

Regards,=20

Matthew Grant


> Regards
>=20
> Marcel
>=20
>=20
>=20
>=20
> -------------------------------------------------------
> This SF.Net email is sponsored by: InterSystems CACHE
> FREE OODBMS DOWNLOAD - A multidimensional database that combines
> robust object and relational technologies, making it a perfect match
> for Java, C++,COM, XML, ODBC and JDBC. www.intersystems.com/match8
> _______________________________________________
> Bluez-users mailing list
> Bluez-users@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-users/listinfo/bluez-u=
sers
--=20
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
Matthew Grant        /\  ^/\^   grantma@anathoth.gen.nz      /~~~~\
A Linux Network Guy /~~\^/~~\_/~~~~~\_______/~~~~~~~~~~\____/******\
=3D=3D=3DGPG KeyID: 2EE20270  FingerPrint: 8C2535E1A11DF3EA5EA19125BA4E790E=
2EE20270=3D=3D


--=-i6UZn69Xp+ZcP2lAIjPE
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBBmGf9uk55Di7iAnARAo9vAJ926TCk9z4Bq28i2G9wZo6KFKr4VACeKnJV
8PfiTazKaGu9EpdvCUzLpI8=
=/BEI
-----END PGP SIGNATURE-----

--=-i6UZn69Xp+ZcP2lAIjPE--



-------------------------------------------------------
This SF.Net email is sponsored by: InterSystems CACHE
FREE OODBMS DOWNLOAD - A multidimensional database that combines
robust object and relational technologies, making it a perfect match
for Java, C++,COM, XML, ODBC and JDBC. www.intersystems.com/match8
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users/listinfo/bluez-users
