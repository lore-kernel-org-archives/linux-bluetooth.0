Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: Sybren Stuvel <sybren@thirdtower.com>
To: bluez-devel@lists.sourceforge.net
MIME-Version: 1.0
Content-Type: multipart/signed;
  protocol="application/pgp-signature";
  micalg=pgp-sha1;
  boundary="Boundary-03=_uiLq/aSutLxOECk";
  charset="us-ascii"
Message-Id: <200311050945.34166.sybren@thirdtower.com>
Subject: [Bluez-devel] rfcomm patch
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Wed, 5 Nov 2003 09:45:20 +0100


--Boundary-03=_uiLq/aSutLxOECk
Content-Type: multipart/mixed;
  boundary="Boundary-01=_hiLq/npavUz0wTk"
Content-Transfer-Encoding: 7bit
Content-Description: signed data
Content-Disposition: inline

--Boundary-01=_hiLq/npavUz0wTk
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Description: body text
Content-Disposition: inline

Hi there,

I've been working with bluetooth for a few months now, trying to let BlueZ =
(on=20
my PC) talk to Affix (on my Zaurus). One difficulty is that rfcom doesn't=20
flush it's stdout when a new (incoming and/or outgoing) connection has been=
=20
made.

With the attached patch, scripts can use rfcomm to connect via bluetooth an=
d=20
fork() the process in order to start using the connection (ie. by running=20
pppd over it).

Greetings,
Sybren Stuvel
=2D-=20
(o_   Q: God, root, what is difference?
//\   A: God can change the byte order on the CPU, root can't.
V_/_


--Boundary-01=_hiLq/npavUz0wTk
Content-Type: text/x-diff;
  charset="us-ascii";
  name="bluez-utils-2.3-rfcomm.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="bluez-utils-2.3-rfcomm.patch"

=2D-- work/bluez-utils-2.3/rfcomm/main.c-orig	2003-01-27 12:42:07.000000000=
 +0100
+++ work/bluez-utils-2.3/rfcomm/main.c	2003-11-04 17:33:13.000000000 +0100
@@ -339,6 +339,11 @@
 	printf("Connected %s to %s on channel %d\n", devname, dst, req.channel);
 	printf("Press CTRL-C for hangup\n");
=20
+	/* Added by Sybren Stuvel <sybren AT thirdtower.com> - Flush
+	 * stdout so other scripts can benefit from rfcomm's output and
+	 * react to connections being made. */
+	fflush(stdout);
+
 	memset(&sa, 0, sizeof(sa));
 	sa.sa_flags   =3D SA_NOCLDSTOP;
 	sa.sa_handler =3D SIG_IGN;
@@ -443,6 +448,11 @@
 	printf("Connection from %s to %s\n", dst, devname);
 	printf("Press CTRL-C for hangup\n");
=20
+	/* Added by Sybren Stuvel <sybren AT thirdtower.com> - Flush
+	 * stdout so other scripts can benefit from rfcomm's output and
+	 * react to connections being made. */
+	fflush(stdout);
+
 	memset(&sa, 0, sizeof(sa));
 	sa.sa_flags   =3D SA_NOCLDSTOP;
 	sa.sa_handler =3D SIG_IGN;

--Boundary-01=_hiLq/npavUz0wTk--

--Boundary-03=_uiLq/aSutLxOECk
Content-Type: application/pgp-signature
Content-Description: signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.3 (GNU/Linux)

iD8DBQA/qLiuGr4j9oVQYfARAoWKAJ41vFAxtmz7M6SHY8E75kutaqKqEQCfZ5qu
4qUA4wSsa1cF8Byn5fvFyZs=
=dOLj
-----END PGP SIGNATURE-----

--Boundary-03=_uiLq/aSutLxOECk--



-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?   SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
