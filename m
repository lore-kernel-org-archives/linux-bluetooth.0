Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Jon Barnett <jbarnett@pobox.com>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <459BD2C1.8090208@xmission.com>
References: <mailman.341782.1167746753.8777.bluez-devel@lists.sourceforge.net>
	<1167793130.3356.17.camel@localhost>  <459BD2C1.8090208@xmission.com>
Date: Mon, 08 Jan 2007 15:14:26 -0500
Message-Id: <1168287266.3174.3.camel@localhost>
Mime-Version: 1.0
Cc: Brad Midgley <bmidgley@xmission.com>
Subject: Re: [Bluez-devel] Problems with Dell BCM2045 USB device
Reply-To: jbarnett@pobox.com,
        BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============2075358452=="
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net


--===============2075358452==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-5sYSYUsJN3EiBFhLkaXX"


--=-5sYSYUsJN3EiBFhLkaXX
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, 2007-01-03 at 08:58 -0700, Brad Midgley wrote:
> Jon
>=20
> > new ALSA definitions. Adding the declaration:
> > #include <sound/typedefs.h>
> > fixed compiling the module.
>=20
> adding this in breaks compilation under 2.6.17 so btsco would need an=20
> interested volunteer to come up with the right precompiler condition.
>=20
> BCM2045 etc support has been rather hit-or-miss and I can't see what is=20
> missing.
>=20
> Brad

I think the following patch would be sufficient (unified patch) - my
apologies for the delay but I was tied up doing something else:

----- patch code start -----
--- btsco.c     2006-10-28 10:39:27.000000000 -0400
+++ btsco.new.c 2007-01-08 13:52:52.000000000 -0500
@@ -57,6 +57,9 @@
 #include <net/sock.h>
 #include <net/bluetooth/bluetooth.h>
=20
+#if LINUX_VERSION_CODE > KERNEL_VERSION(2,6,18)
+#include <sound/typedefs.h>
+#endif
 #include <sound/core.h>
 #include <sound/control.h>
 #include <sound/pcm.h>
----- patch code end -----


Cheers,

Jon

--=-5sYSYUsJN3EiBFhLkaXX
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBFoqYiu2cEic/xsEARAtPlAKCOHJld9rK59CwvevFeFb4zGw5c0QCg2Y12
/l5H2fj4U3wdO/PQkj9OMj8=
=dOds
-----END PGP SIGNATURE-----

--=-5sYSYUsJN3EiBFhLkaXX--



--===============2075358452==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--===============2075358452==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--===============2075358452==--
