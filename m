Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: James Cameron <james.cameron@hp.com>
To: 256436@bugs.debian.org, bluez-devel@lists.sourceforge.net
Message-ID: <20040627133325.GA23996@hp.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="f2QGlHpHGjS2mn6Y"
Subject: [Bluez-devel] [PATCH] pand/main.c, restore signals for dev-up script
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Sun, 27 Jun 2004 23:33:25 +1000


--f2QGlHpHGjS2mn6Y
Content-Type: multipart/mixed; boundary="pWyiEgJYm5f9v55/"
Content-Disposition: inline


--pWyiEgJYm5f9v55/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Problem: pand dev-up script on Debian fails to "ifup bnep0", the error
is "Failed to bring up bnep0".

Diagnosis: dev-up script inherits the SIG_IGN of SIGCHLD and SIGPIPE
done by pand/main.c, in addition to some open sockets.  The ifup program
requires signals in default state.

Solution: restore signals to SIG_DFL, close some of the sockets.  A
patch for this is attached, less comments.  The patch applies cleanly to
both the Debian revision of pand/main.c 1.3, and to the current revision
1.4 in CVS.


Discussion:

Restoring the signals takes a call to sigaction() after fork() but
before exec().  This call undoes the initialisation call in main().

Closing the sockets can be done automatically on fork(), or manually.
My patch does it manually.

Closing the sockets automatically would require setting FD_CLOEXEC on
them after they are created.  fcntl(sk, F_SETFD, FD_CLOEXEC);

Closing the sockets manually requires the socket file descriptors to be
sent to run_devup(); this seems ugly to me, I'm not altogether happy
with the way I've done it and I hope the maintainer will rethink this
for me.  Perhaps making the socket numbers global would make more sense.

Even then, tests show that there are *three* file descriptors inherited
by the dev-up script, and I've only been able to find two.  Hopefully
the maintainer knows where the other one is; bnep_init()?

Here's how I found the open sockets ... (a) place a "sleep 30m" in
dev-up, (b) cause pand to run dev-up, (c) find pid of sleep, (d) run
lsof -p ...

sleep   16393 root    0u   CHR    1,3         163834 /dev/null
sleep   16393 root    1w   REG    3,4     258  48965 /tmp/dev-up.16391.log
sleep   16393 root    2w   REG    3,4     258  48965 /tmp/dev-up.16391.log
sleep   16393 root    3u  sock    0,4           4477 can't identify protocol
sleep   16393 root    5u  sock    0,4           4480 can't identify protocol
sleep   16393 root    6u  sock    0,4          27277 can't identify protocol

The signals were found using "cat /proc/${pid}/status", and confirmed
with strace.

Please let me know if my patch is applied.  Thanks!

--=20
James Cameron                         http://quozl.netrek.org/
HP Open Source, Volunteer             http://opensource.hp.com/
PPTP Client Project, Release Engineer http://pptpclient.sourceforge.net/

--pWyiEgJYm5f9v55/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="pand-256436.patch"
Content-Transfer-Encoding: quoted-printable

--- bluez-utils-2.7/pand/main.c	2004-05-09 20:39:43.000000000 +1000
+++ bluez-utils-2.7-4-jc1/pand/main.c	2004-06-27 23:02:00.000000000 +1000
@@ -84,9 +84,10 @@
 	KILL
 } modes;
=20
-static void run_devup(char *dev, char *dst)
+static void run_devup(char *dev, char *dst, int sk, int nsk)
 {
 	char *argv[4], prog[40];
+	struct sigaction sa;
=20
 	sprintf(prog, "%s/%s", PAND_CONFIG_DIR, PAND_DEVUP_CMD);
=20
@@ -96,6 +97,15 @@
 	if (fork())
 		return;
=20
+	close(sk);
+	if (nsk !=3D -1)
+		close(nsk);
+=09
+	memset(&sa, 0, sizeof(sa));
+	sa.sa_handler =3D SIG_DFL;
+	sigaction(SIGCHLD, &sa, NULL);
+	sigaction(SIGPIPE, &sa, NULL);
+
 	argv[0] =3D prog;
 	argv[1] =3D dev;
 	argv[2] =3D dst;
@@ -184,7 +194,7 @@
=20
 			syslog(LOG_INFO, "New connection from %s %s", str, netdev);
=20
-			run_devup(netdev, str);
+			run_devup(netdev, str, sk, nsk);
 		} else {
 			syslog(LOG_ERR, "Connection failed. %s(%d)",
 					strerror(errno), errno);
@@ -274,7 +284,7 @@
=20
 		syslog(LOG_INFO, "%s connected", netdev);
=20
-		run_devup(netdev, dst);
+		run_devup(netdev, dst, sk, -1);
=20
 		if (persist)
 			w4_hup(sk);

--pWyiEgJYm5f9v55/--

--f2QGlHpHGjS2mn6Y
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQFA3sylIiWKUhK+Mj4RAligAKCQwMBeTT0A+4kSjq/uDgZtkYX0+wCggCZ9
wv5XKsw886KBCvzuqvDvauU=
=PQ1W
-----END PGP SIGNATURE-----

--f2QGlHpHGjS2mn6Y--


-------------------------------------------------------
This SF.Net email sponsored by Black Hat Briefings & Training.
Attend Black Hat Briefings & Training, Las Vegas July 24-29 - 
digital self defense, top technical experts, no vendor pitches, 
unmatched networking opportunities. Visit www.blackhat.com
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
