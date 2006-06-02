Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Date: Fri, 2 Jun 2006 13:55:19 +0200
From: Filippo Giunchedi <filippo@esaurito.net>
To: bluez-devel@lists.sf.net
Message-ID: <20060602115519.GA17462@esaurito.net>
MIME-Version: 1.0
Subject: [Bluez-devel] [PATCH] rfcomm 'anycommand' bug
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============0766345773=="
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net


--===============0766345773==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="U+BazGySraz5kW0T"
Content-Disposition: inline


--U+BazGySraz5kW0T
Content-Type: multipart/mixed; boundary="/9DWx/yDrRhgMJTb"
Content-Disposition: inline


--/9DWx/yDrRhgMJTb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,
as reported in http://bugs.debian.org/cgi-bin/bugreport.cgi?bug=229167 rfcomm
silently exits (or better, does a print_dev_list()) if an unknown command
without parameters is passed. attached there is a patch (of the 'works-here'
type) which should solve the problem.

thanks,
filippo
--
Filippo Giunchedi - http://esaurito.net
PGP key: 0x6B79D401
random quote follows:

A child of five would understand this. Send someone to fetch a child of five.
-- Groucho Marx

--/9DWx/yDrRhgMJTb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="rfcomm_anycommand.patch"
Content-Transfer-Encoding: quoted-printable

--- rfcomm/main.c	(revision 154)
+++ rfcomm/main.c	(working copy)
@@ -621,8 +621,20 @@
 	argv +=3D optind;
 	optind =3D 0;
=20
-	if (argc < 2)
+	if (argc =3D=3D 0) {
+        show_all =3D 1;
+    }else if (argc =3D=3D 1){
+        for(i =3D 0; command[i].cmd; i++) {
+		    if ((strncmp(command[i].cmd, argv[0], 4) =3D=3D 0) &&
+                (strncmp(command[i].alt, argv[0], 4) =3D=3D 0) )
+			    break;
+           =20
+            if (command[i+1].cmd =3D=3D NULL)
+                usage();
+                exit(0);
+        }
 		show_all =3D 1;
+    }
=20
 	if ((ctl =3D socket(AF_BLUETOOTH, SOCK_RAW, BTPROTO_RFCOMM)) < 0 ) {
 		perror("Can't open RFCOMM control socket");

--/9DWx/yDrRhgMJTb--

--U+BazGySraz5kW0T
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3 (GNU/Linux)

iD8DBQFEgCcnABzeamt51AERAhguAJ4hOo+j4mhkACq0Xx5dQR8EFMIixQCfUCvw
j53hzV/nyuZLB4iBpZvYIrY=
=+afn
-----END PGP SIGNATURE-----

--U+BazGySraz5kW0T--


--===============0766345773==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============0766345773==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--===============0766345773==--
