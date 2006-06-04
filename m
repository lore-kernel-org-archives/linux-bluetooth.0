Return-Path: <pkg-bluetooth-maintainers-bounces@lists.alioth.debian.org>
Date: Sun, 4 Jun 2006 17:15:05 +0200
From: Filippo Giunchedi <filippo@debian.org>
To: 322732@bugs.debian.org
Message-ID: <20060604151505.GA16780@esaurito.net>
References: <20060519204815.GA8424@esaurito.net>
	<1148908581.31689.35.camel@localhost>
MIME-Version: 1.0
In-Reply-To: <1148908581.31689.35.camel@localhost>
Subject: Bug#322732: [Pkg-bluetooth-maintainers] Bug#322732: [Bluez-devel]
	more on this bug (was: rfcomm bind fails with obscure error message)
Cc: 322732-submitter@bugs.debian.org, bluez-devel@lists.sourceforge.net
Reply-To: Filippo Giunchedi <filippo@debian.org>, 322732@bugs.debian.org
List-Unsubscribe: <http://lists.alioth.debian.org/mailman/listinfo/pkg-bluetooth-maintainers>,
	<mailto:pkg-bluetooth-maintainers-request@lists.alioth.debian.org?subject=unsubscribe>
List-Archive: <http://lists.alioth.debian.org/pipermail/pkg-bluetooth-maintainers>
List-Post: <mailto:pkg-bluetooth-maintainers@lists.alioth.debian.org>
List-Help: <mailto:pkg-bluetooth-maintainers-request@lists.alioth.debian.org?subject=help>
List-Subscribe: <http://lists.alioth.debian.org/mailman/listinfo/pkg-bluetooth-maintainers>,
	<mailto:pkg-bluetooth-maintainers-request@lists.alioth.debian.org?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============2044096412=="
Mime-version: 1.0
Sender: pkg-bluetooth-maintainers-bounces@lists.alioth.debian.org
Errors-To: pkg-bluetooth-maintainers-bounces@lists.alioth.debian.org
List-ID: <bluez-devel.lists.sourceforge.net>


--===============2044096412==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="dc+cDN39EJAMEtIO"
Content-Disposition: inline


--dc+cDN39EJAMEtIO
Content-Type: multipart/mixed; boundary="n8g4imXOkfNTN/H1"
Content-Disposition: inline


--n8g4imXOkfNTN/H1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 29, 2006 at 03:16:21PM +0200, Marcel Holtmann wrote:
> > comments?=20
>=20
> check for EOPNOTSUPP error code and only then print this error.

allright, I fixed this with the attached patch

thanks,
filippo
--
Filippo Giunchedi - http://esaurito.net
PGP key: 0x6B79D401
random quote follows:

Either this man is dead or my watch has stopped.
-- Groucho Marx

--n8g4imXOkfNTN/H1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="010_rfcomm_tty.patch"
Content-Transfer-Encoding: quoted-printable

--- rfcomm/main.c	(revision 154)
+++ rfcomm/main.c	(working copy)
@@ -172,8 +172,12 @@
 			req.channel =3D 1;
 	}
=20
-	if ((err =3D ioctl(ctl, RFCOMMCREATEDEV, &req)) < 0 )
-		perror("Can't create device");
+	if ((err =3D ioctl(ctl, RFCOMMCREATEDEV, &req)) < 0 ) {
+		if (err =3D=3D EOPNOTSUPP)
+			fprintf(stderr, "RFCOMM TTY support not available\n");
+		else
+			perror("Can't create device");
+	}
=20
 	return err;
 }

--n8g4imXOkfNTN/H1--

--dc+cDN39EJAMEtIO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (GNU/Linux)

iD8DBQFEgvj5ABzeamt51AERAmIRAJ91rEp/hOYMh7D62GdZ+Zsfo7anJQCbB+m5
OTabAJpcIdJvS2ICMgwioq4=
=Wtaa
-----END PGP SIGNATURE-----

--dc+cDN39EJAMEtIO--



--===============2044096412==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Pkg-bluetooth-maintainers mailing list
Pkg-bluetooth-maintainers@lists.alioth.debian.org
http://lists.alioth.debian.org/mailman/listinfo/pkg-bluetooth-maintainers

--===============2044096412==--
