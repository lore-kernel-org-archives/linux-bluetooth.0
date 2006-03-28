Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: Florian Echtler <floe@butterbrot.org>
To: bluez-devel@lists.sourceforge.net
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-3OskYJrz+epM6Fdc/QU7"
Message-Id: <1143530119.9151.5.camel@localhost>
Mime-Version: 1.0
Subject: [Bluez-devel] 2.4 Kernel hacking question
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
Date: Tue, 28 Mar 2006 09:15:19 +0200


--=-3OskYJrz+epM6Fdc/QU7
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Hello everybody,

as already mentioned in some earlier post, I've backported the most
recent BlueZ modules from kernel 2.4.31-mh1 to a custom kernel 2.4.20.

I know that the 2.4 branch is considered unsupported by now, but maybe
somebody can answer my question regardless:

in rfcomm/tty.c, line 592, a function tty_wakeup() is used that isn't
available in 2.4.20 yet. Can anybody tell me what exactly this function
is supposed to do so that I can look for a workaround? (*)

CU Florian

(*) I've already looked at the kernel source, of course. Still haven't
got a real clue, though.. :-/


--=-3OskYJrz+epM6Fdc/QU7
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: Dies ist ein digital signierter Nachrichtenteil

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)

iD8DBQBEKOKH7CzyshGvatgRAq9QAKDbEyYIkieyRfyw19B/dzOihfzEggCg1c1J
ONy0vEzmNtJmW829c7xJ6yU=
=fyYp
-----END PGP SIGNATURE-----

--=-3OskYJrz+epM6Fdc/QU7--



-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
