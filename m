Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] Socket error: No such file or directory
From: Stephen Crane <steve.crane@rococosoft.com>
To: bluez-devel@lists.sourceforge.net
In-Reply-To: <41A705AA000053C5@mta02.ono.com>
References: <41A705AA000053C5@mta02.ono.com>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-46qtqOiYFDHXt5bzHYEj"
Message-Id: <1102093748.17476.167.camel@baroque.rococosoft.com>
Mime-Version: 1.0
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
Reply-To: bluez-devel@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Fri, 03 Dec 2004 17:09:08 +0000


--=-46qtqOiYFDHXt5bzHYEj
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Is the rfcomm module loaded?

On Fri, 2004-12-03 at 17:57 +0100, kwyjibo@ono.com wrote:
> Hi,
>=20
> I'm trying to open a socket with this:
>=20
> servSockBluez =3D socket(PF_BLUETOOTH, SOCK_STREAM, BTPROTO_RFCOMM)
>=20
> but I get an error: "No such file or directory", wich I don't understant
> it at all.
>=20
> What's exactly the problem?
>=20
> Thanks in advance.
>=20
>=20
>=20
> -------------------------------------------------------
> SF email is sponsored by - The IT Product Guide
> Read honest & candid reviews on hundreds of IT Products from real users.
> Discover which products truly live up to the hype. Start reading now.=20
> http://productguide.itmanagersjournal.com/
> _______________________________________________
> Bluez-devel mailing list
> Bluez-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-devel

--=-46qtqOiYFDHXt5bzHYEj
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQBBsJ2zlgMqgVzLyWcRAmt8AJ0fQKIiJWyEHjp+AhCPeKfMwJmFjwCfYyE5
usITVhznwb4mKzzG9VAVhJI=
=Iztc
-----END PGP SIGNATURE-----

--=-46qtqOiYFDHXt5bzHYEj--



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
