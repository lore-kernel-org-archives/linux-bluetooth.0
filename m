Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: Elimar Riesebieter <riesebie@lxtec.de>
To: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
Subject: Re: [Bluez-users] Can't compile utils2
Message-ID: <20040411205300.GE13892@aragorn.home.lxtec.de>
References: <200404112025.35020.sergiofernandes@clix.pt> <20040411201712.GD13892@aragorn.home.lxtec.de> <200404112138.57311.sergiofernandes@clix.pt>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ZRyEpB+iJ+qUx0kp"
In-Reply-To: <200404112138.57311.sergiofernandes@clix.pt>
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Sun, 11 Apr 2004 22:53:00 +0200


--ZRyEpB+iJ+qUx0kp
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, 11 Apr 2004 the mental interface of
S=E9rgio Fernandes told:

[...]

> I forgot to mention that i compiled libs2 with prefix=3D/opt/bluetooth...=
=2E..

/opt/bluetooth/lib is not a usual place for libs. Do

$ echo /opt/bluetooth/lib >> /etc/ld.so.conf

and run ldconfig. utils2 will then search for libs in
/opt/bluetooth/lib as well ;-)

HANN

Elimar


--=20
  Do you smell something burning or ist it me?

--ZRyEpB+iJ+qUx0kp
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFAebAs3Ig8bsVPf7ARAm2uAKC9ClhLsToopsbhLaoNIxrkydyd7ACgtmsr
nI5DbvESBtdxNM4OclXjYxk=
=RFzM
-----END PGP SIGNATURE-----

--ZRyEpB+iJ+qUx0kp--


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
