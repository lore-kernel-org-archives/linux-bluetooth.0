Return-Path: <cyrus@holtmann.org>
From: Sergey Kondakov <virtuousfox@gmail.com>
Subject: Reaching out again for serious bug in sixaxis plugin
To: linux-bluetooth@vger.kernel.org
Cc: Bastien Nocera <hadess@hadess.net>,
	Antonio Ospite <ospite@studenti.unina.it>,
	Szymon Janc <szymon.janc@gmail.com>
Message-ID: <55A4BA19.6030109@gmail.com>
Date: Tue, 14 Jul 2015 12:28:25 +0500
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="MOUpLaIhNS94S37NmLhVCK5vVlH4UWlPl"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--MOUpLaIhNS94S37NmLhVCK5vVlH4UWlPl
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Since both my attempts, in kernel bugzilla and here, were ignored and
you still don't have your own bugtracker I repeat my plea from
previously with plugin's authors CCed in hope that bug's existence at
least would be acknowledged.

Details are in http://article.gmane.org/gmane.linux.bluez.kernel/62305
Moreover, this livecd is almost identical to my running system which is
based on it, so it may be used to reproduce the glitch (antimicro,
jstest and evtest should help):
http://sourceforge.net/projects/hackeurs-sans-frontieres/files/0.8.1%20-%=
20The%20White%20Devil/Linux%20Live%20-%20HSF%20-%200.8.1_20150708.iso/dow=
nload
If it could not be reproduce I'm afraid it may be a bug in handling my
BT controller.

Also, this kernel patch or a better alternative still hasn't been
applied and that's no good: https://patchwork.kernel.org/patch/1075972/


--MOUpLaIhNS94S37NmLhVCK5vVlH4UWlPl
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iF4EAREIAAYFAlWkuhkACgkQrPLi+0dgLoYf4QD9EYIVOO/IyUcyIDUa6f4gSj0l
PJzCKXLMIFZF71JAbE4BAI1WwlCMkb+n5cWVSJPAfSvfDFYNKGKVO46F2oajtYgr
=dRx1
-----END PGP SIGNATURE-----

--MOUpLaIhNS94S37NmLhVCK5vVlH4UWlPl--
