Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: Bastian Ballmann <Crazydj@chaostal.de>
To: bluez-devel@lists.sourceforge.net
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-yj3ZWkTWqYGATPKQN+yr"
Message-Id: <1088271695.29447.5.camel@espy.crazydj.de>
Mime-Version: 1.0
Subject: [Bluez-devel] PAN and kernel 2.4.26
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
Date: Sat, 26 Jun 2004 19:41:36 +0200


--=-yj3ZWkTWqYGATPKQN+yr
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Hello,
I've got a little problem using PAN with a kernel 2.4.26.
If I start pand I'll get the error:
pand[698]: Bluetooth PAN daemon
pand[698]: Failed to get L2CAP options. Invalid argument(22)
I tried the same using kernel 2.6.7. and it works, but I have
to use kernel 2.4, because of a wlan driver, which is not supported
for kernel 2.6.
I tried to l2ping the bluetooth adapter, that works and I can also=20
open a l2cap socket on that host, so l2cap works.
I've installed the newest bluez packages and also patched the kernel
using patch-2.4.26-mh1.gz. No effect.
Any suggestions?
Thx & Greets

Basti

--=-yj3ZWkTWqYGATPKQN+yr
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iD8DBQBA3bVP3rCd3KdGxg4RApd+AJ0Sjzv3lcWT2ENJvVr3g7Bp6eH/fACeKC9c
QduQdbVq8+G03dpDmcVwJ4Q=
=sM1A
-----END PGP SIGNATURE-----

--=-yj3ZWkTWqYGATPKQN+yr--



-------------------------------------------------------
This SF.Net email sponsored by Black Hat Briefings & Training.
Attend Black Hat Briefings & Training, Las Vegas July 24-29 - 
digital self defense, top technical experts, no vendor pitches, 
unmatched networking opportunities. Visit www.blackhat.com
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
