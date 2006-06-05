Return-Path: <bluez-users-bounces@lists.sourceforge.net>
From: Didier LINK <didier.link@wanadoo.fr>
To: BlueZ users <bluez-users@lists.sourceforge.net>
Date: Mon, 05 Jun 2006 23:42:30 +0200
Message-Id: <1149543750.14142.11.camel@neutrino.cosmos.net>
Mime-Version: 1.0
Subject: [Bluez-users] crazy mouse
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============0172851983=="
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net


--===============0172851983==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-dsGkwwNQof1RHnclAB4A"


--=-dsGkwwNQof1RHnclAB4A
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Hello all,

Thanks to Marcel to have so quickly publish the patch 2.6.16-mh1 after
my request ! I've patched a 2.6.16.19 kernel and all seems to works
after the reboot.

But my mouse (Logitech MX900 BT) move strangely. The movement seems to
be by "hop" on the screen, I've never see this before, it's annoying ...

For a better explanation, its as if the mouse send is move data normally
but X and the console (gpm) receive it asynchronously and at a point the
cursor "freeze" a 1/4 of second and move quickly at the real position,
all along the move of the mouse ...

Very strange no ?

After rebooting on my 2.6.15-mh2 kernel all works good !

Any idea ? Or maybe a procedure to debug that I can do ?

I've a Gentoo on amd64, full 64 bits, last bluez utilities on gentoo.
For more information just ask me.

Best regards.

Didier Link

--=20
Didier Link <didier.link@wanadoo.fr>
Jabber : zanfib@ims.kelkoo.net
MSN : zanfib@hotmail.fr
SIP : Zanfib@ekiga.net

Cl=E9 GPG : 75BAC9EE

--=-dsGkwwNQof1RHnclAB4A
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: Ceci est une partie de message
	=?ISO-8859-1?Q?num=E9riquement?= =?ISO-8859-1?Q?_sign=E9e?=

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (GNU/Linux)

iD8DBQBEhKVGkyPwinW6ye4RAiTnAKCBkzU99fRZDI6fNFdk55RlgBKa2QCfbiF9
nyKPiDmq7lqpRdeeNl8O9FE=
=zjVH
-----END PGP SIGNATURE-----

--=-dsGkwwNQof1RHnclAB4A--



--===============0172851983==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0172851983==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

--===============0172851983==--
