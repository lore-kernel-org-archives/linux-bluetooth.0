Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: Wolfram Quester <wolfi@mittelerde.physik.uni-konstanz.de>
To: bluez-devel@lists.sourceforge.net
Cc: Ville Tervo <ville.tervo@nokia.com>
Subject: Re: [Bluez-devel] rfcomm oops
Message-ID: <20050704153704.GG20510@halley.zuhause>
References: <1120490370.30194.50.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="WkfBGePaEyrk4zXB"
In-Reply-To: <1120490370.30194.50.camel@localhost.localdomain>
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
Date: Mon, 4 Jul 2005 17:37:05 +0200


--WkfBGePaEyrk4zXB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Ville,

On Mon, Jul 04, 2005 at 06:19:30PM +0300, Ville Tervo wrote:
> Hi,
>=20
> I found reproducible way to make rfcomm layer oops. I attached oops and
> some notes how they were produced. I used several Nokia phones and IBM
> T40 laptop in these tests.
>=20
>=20
> PPP Deflate Compression module registered
> atkbd.c: Keyboard on isa0060/serio0 reports too many keys pressed.
> Unable to handle kernel NULL pointer dereference at virtual address
> 00000047
>  printing eip:
> c0294798
> *pde =3D 00000000
> Oops: 0000 [#1]
> PREEMPT
What happens if you disable CONFIG_PREEMPT? At least on ppc this leads
to crashes quite oft, I don't know ho well it works on i386.=20

HTH,

Wolfi

--WkfBGePaEyrk4zXB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFCyVegH0o2mefAfsQRAi1ZAJoD9EqLl8fsL7lhEKFoMITDzlAnogCdEOwo
OB9V0Wvx5bFaosbWRkGPHeg=
=lU+V
-----END PGP SIGNATURE-----

--WkfBGePaEyrk4zXB--


-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
