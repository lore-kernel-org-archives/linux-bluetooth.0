Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] problem building btsco.
From: Stephen Crane <steve.crane@rococosoft.com>
To: bluez-users@lists.sourceforge.net
In-Reply-To: <42BC17FC.6080506@ibdcon.org.br>
References: <42BC08BA.10603@ibdcon.org.br>
	 <1119620816.3896.210.camel@baroque.rococosoft.com>
	 <42BC17FC.6080506@ibdcon.org.br>
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-0M2F43JV4k5pKQQZIKjm"
Message-Id: <1119623544.3896.221.camel@baroque.rococosoft.com>
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
Date: Fri, 24 Jun 2005 15:32:24 +0100


--=-0M2F43JV4k5pKQQZIKjm
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Hi Paolo,
What distribution is this? (You can kludge around your problem by
softlinking libsdp.so.2 to libbluetooth.so but this a hack.)

Update kbtobexsrv or rebuild it from source.

Cheers,
Steve

On Fri, 2005-06-24 at 11:26 -0300, Paulo Wollny wrote:
> Hi Steve,
>=20
> i did update of all teh bluez packages, but when trying to run=20
> ktbobexsrv, i get the following message:
>=20
> kbtobexsrv: error while loading shared libraries: libsdp.so.2: cannot=20
> open shared object file
>=20
> Any hint?
>=20
> I was able to build btsco.
>=20
> Best regards,
>=20
> Paulo Wollny
>=20
>=20
> Stephen Crane wrote:
> > Hi Paolo
> > It looks as if your version of bluez-libs is very old. Recent versions
> > have the sdp library merged in.
> >=20
> > Cheers,
> > Steve
> >=20
> > On Fri, 2005-06-24 at 10:20 -0300, Paulo Wollny wrote:
> >=20
> >>Hi,
> >>
> >>i'm trying o build the btsco and am getting the following error. Does=20
> >>anyone knows how to solve it?
> >>
> >>Kind regards,
> >>
> >>Paulo Wollny
> >>
> >>gcc -DHAVE_CONFIG_H -I. -I. -I..     -Wall -O2 -c `test -f 'sbcinfo.c'=20
> >>|| echo './'`sbcinfo.c
> >>gcc  -Wall -O2   -o sbcinfo  sbcinfo.o  -lasound -lm -ldl -lpthread
> >>gcc -DHAVE_CONFIG_H -I. -I. -I..     -Wall -O2 -c `test -f 'sbcenc.c' |=
|=20
> >>echo './'`sbcenc.c
> >>gcc  -Wall -O2   -o sbcenc  sbcenc.o libsbc.a -lasound -lm -ldl -lpthre=
ad
> >>gcc -DHAVE_CONFIG_H -I. -I. -I..     -Wall -O2 -c `test -f 'rcplay.c' |=
|=20
> >>echo './'`rcplay.c
> >>gcc  -Wall -O2   -o rcplay  rcplay.o -lbluetooth -lasound -lm -ldl -lpt=
hread
> >>rcplay.o(.text+0xd0): In function `main':
> >>: undefined reference to `sdp_connect'
> >>rcplay.o(.text+0xed): In function `main':
> >>: undefined reference to `sdp_uuid16_create'
> >>rcplay.o(.text+0xf7): In function `main':
> >>: undefined reference to `sdp_list_append'
> >>rcplay.o(.text+0x11b): In function `main':
> >>: undefined reference to `sdp_list_append'
> >>rcplay.o(.text+0x12c): In function `main':
> >>: undefined reference to `sdp_list_append'
> >>rcplay.o(.text+0x141): In function `main':
> >>: undefined reference to `sdp_service_search_attr_req'
> >>rcplay.o(.text+0x14c): In function `main':
> >>: undefined reference to `sdp_close'
> >>rcplay.o(.text+0x18f): In function `main':
> >>: undefined reference to `sdp_get_access_protos'
> >>rcplay.o(.text+0x1a6): In function `main':
> >>: undefined reference to `sdp_get_proto_port'
> >>collect2: ld returned 1 exit status
> >>make[2]: *** [rcplay] Fehler 1
> >>make[2]: Leaving directory `/home/paulo/Bluetooth-Linux/btsco-0.4/sbc'
> >>make[1]: *** [all-recursive] Fehler 1
> >>make[1]: Leaving directory `/home/paulo/Bluetooth-Linux/btsco-0.4'
> >>make: *** [all] Fehler 2
> >>
> >>
> >>-------------------------------------------------------
> >>SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
> >>from IBM. Find simple to follow Roadmaps, straightforward articles,
> >>informative Webcasts and more! Get everything you need to get up to
> >>speed, fast. http://ads.osdn.com/?ad_id=3D7477&alloc_id=3D16492&op=3Dcl=
ick
> >>_______________________________________________
> >>Bluez-users mailing list
> >>Bluez-users@lists.sourceforge.net
> >>https://lists.sourceforge.net/lists/listinfo/bluez-users
>=20
>=20
> -------------------------------------------------------
> SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
> from IBM. Find simple to follow Roadmaps, straightforward articles,
> informative Webcasts and more! Get everything you need to get up to
> speed, fast. http://ads.osdn.com/?ad_id=3D7477&alloc_id=3D16492&op=3Dclic=
k
> _______________________________________________
> Bluez-users mailing list
> Bluez-users@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-users
--=20
Stephen Crane, Rococo Software Ltd. http://www.rococosoft.com
steve.crane@rococosoft.com +353-1-6601315 (ext 209)

--=-0M2F43JV4k5pKQQZIKjm
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBCvBl4lgMqgVzLyWcRAv3eAJ9xR3T7G2F2OLe3TWdQlRAjlJ+iXgCeNHqE
/L0NlTak5KoljtTtUOwv5Js=
=aN8K
-----END PGP SIGNATURE-----

--=-0M2F43JV4k5pKQQZIKjm--



-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
