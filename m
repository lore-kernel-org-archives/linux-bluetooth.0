Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Date: Sat, 26 May 2007 19:15:39 +0200
From: Matthias Hensler <matthias@wspse.de>
To: bluez-devel@lists.sourceforge.net
Message-ID: <20070526171539.GA16843@kobayashi-maru.wspse.de>
MIME-Version: 1.0
Subject: [Bluez-devel] bluetooth-audio and bug in a2dpd (Patch included)
Reply-To: Matthias Hensler <matthias@wspse.de>,
        BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============1779493705=="
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net


--===============1779493705==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="JP+T4n/bALQSJXh8"
Content-Disposition: inline


--JP+T4n/bALQSJXh8
Content-Type: multipart/mixed; boundary="0OAP2g/MAC+5xKAE"
Content-Disposition: inline


--0OAP2g/MAC+5xKAE
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline

Hi!

Playing with the current plugz from CVS and a2dpd I experienced a lot of
choppy audio with a BW-HF02 bluetooth audio receiver. I tracked down the
problem to the transmit loop in a2dpd_output_a2dp.c. My receiver has an
own buffer which runs full after around 3-4 seconds. In that case the
write will fail with EAGAIN. The loop should take care of that and
retry, however errno gets lost in the current implementation, so no
single retry is made.

Furthermore there is only one retry round and a too small usleep value.
To make a2dpd finally work without any problems I had to fix the retry
issue, increase the usleep to 150ms and try up to 200 times again. A
patch for this is attached.

Please note that this is only a quick, but no optimal fix. In case of
XMMS for example the spectrum analyzer is not smooth while a2dpd is
spending its time in the loop waiting for the receiver to have some new
free bufferspace.

Without my patch it goes: 4 seconds filling the buffer then breaking
because of a full buffer interrupting the audio for around 1-2 seconds
(the connection to the receiver is closed and opened again).

With my patch it is: 4 seconds filling the buffer, waiting up to 500ms
(spectrum analyzer in XMMS stops), 2-3 seconds filling the buffer
(spectrum analyzer runs smoothly), waiting again for 500ms, and so on.

A proper solution would be to fill the buffer more constantly using a
kind of dynamic adaption (I tried a delay of 10ms after every transmit
which was a satisfying solution for my receiver).

Regards,
Matthias

--0OAP2g/MAC+5xKAE
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: attachment; filename="a2dpd-retry-fix.patch"
Content-Transfer-Encoding: quoted-printable

--- plugz/alsa-plugins/a2dpd/a2dpd_output_a2dp.c.orig	2007-05-26 17:51:01.0=
00000000 +0200
+++ plugz/alsa-plugins/a2dpd/a2dpd_output_a2dp.c	2007-05-26 19:14:57.000000=
000 +0200
@@ -475,21 +475,23 @@
 				// However, we may safely simulate a failed write
 				if (!a2dp->pause_writing) {
 					int count =3D 0;
+					int retry =3D 0;
 					static struct timeval send_date =3D { 0,0 };
 					static struct timeval prev_date =3D { 0,0 };
 					struct timeval send_delay =3D { 0,0 };
 					do {
 						gettimeofday(&send_date, NULL);
 						written =3D write(a2dp->sk, a2dp->buf, a2dp->len);
+						retry =3D (errno =3D=3D EAGAIN);
=20
 						if(prev_date.tv_sec !=3D 0) {
 							timersub(&send_date, &prev_date, &send_delay);
 							DBG8("send (delay=3D%ld ms)", (long)(send_delay.tv_sec*1000 + send_=
delay.tv_usec/1000));
 						}
 						prev_date =3D send_date;
-						if(written < 0 && errno =3D=3D EAGAIN)
-							usleep(1);
-					} while (count++ < 2 && written < 0 && errno =3D=3D EAGAIN);
+						if(written < 0 && retry)
+							usleep(150000);
+					} while (count++ < 200 && written < 0 && retry);
=20
 					// Send our data
 					if (written !=3D a2dp->len) {

--0OAP2g/MAC+5xKAE--

--JP+T4n/bALQSJXh8
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.7 (GNU/Linux)

iQCVAwUBRlhrNIagCBsispUdAQJArgP+LzXssB8hN2mwerkN4+Za7HOAwnUO+qyz
2P69bRf5ZB1RtY5ElbnqxXPgvF5U1n0TPnNvSrWjBnzdmgfo4DdjMPhoCie9x07w
ajjmK0F+fP3Oeub9kweOGdmIZk0/GObeFYibHvP0QG8qIMl3ldDdgFk/q2Q8Zhp2
MgBVZUNmn8w=
=Uhcm
-----END PGP SIGNATURE-----

--JP+T4n/bALQSJXh8--


--===============1779493705==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
--===============1779493705==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--===============1779493705==--
