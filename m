Return-Path: <bluez-users-bounces@lists.sourceforge.net>
From: Didier LINK <didier.link@wanadoo.fr>
To: BlueZ users <bluez-users@lists.sourceforge.net>
In-Reply-To: <1149544649.7238.1.camel@localhost>
References: <1149543750.14142.11.camel@neutrino.cosmos.net>
	<1149544649.7238.1.camel@localhost>
Date: Tue, 06 Jun 2006 19:46:48 +0200
Message-Id: <1149616008.9380.11.camel@neutrino.cosmos.net>
Mime-Version: 1.0
Subject: Re: [Bluez-users] crazy mouse
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============1006857178=="
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net


--===============1006857178==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-Jh4mG4g3PkiS407pVnPk"


--=-Jh4mG4g3PkiS407pVnPk
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Le lundi 05 juin 2006 =E0 23:57 +0200, Marcel Holtmann a =E9crit :
> Hi Didier,

Hi,


> check your Xorg configuration. You might have configured two inputs and
> the events add up. There was a report about that some time ago.

Yes, I've seen this but this not apply to my case, I've not 2 inputs and
this is the same situation on the console (the linux one, not in X !)
with the gpm daemon. My device for mouse is only /dev/input/mice.

And by "hop" it's not a real acceleration, I will try to explain
better : between positions x and y at screen they have "a time", from x
and during the first quarter of this time the cursor move correctly and
sudenly freeze, at the end of the time the cursor move instantly at y.
This scenario again and again all along the move of the mouse :-/

This appear only with kernel 2.6.16.19-mh1, the 2.6.15-mh2 is perfect
with the same configuration !?!?

Any idea ??

I will retry this evening ...

Regards.

Didier

--=20
Didier Link <didier.link@wanadoo.fr>
Jabber : zanfib@ims.kelkoo.net
MSN : zanfib@hotmail.fr
SIP : Zanfib@ekiga.net

Cl=E9 GPG : 75BAC9EE

--=-Jh4mG4g3PkiS407pVnPk
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: Ceci est une partie de message
	=?ISO-8859-1?Q?num=E9riquement?= =?ISO-8859-1?Q?_sign=E9e?=

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (GNU/Linux)

iD8DBQBEhb+IkyPwinW6ye4RAhasAJ9vLgzxOBt5BxaIwePNjYwoSeMCWgCeKL5v
EHHTeHbHbgQGuY/X1ttOIXM=
=OU8t
-----END PGP SIGNATURE-----

--=-Jh4mG4g3PkiS407pVnPk--



--===============1006857178==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============1006857178==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

--===============1006857178==--
