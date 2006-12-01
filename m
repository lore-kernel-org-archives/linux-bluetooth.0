Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Olivier =?ISO-8859-1?Q?Cr=EAte?= <tester@tester.ca>
To: Douglas Ward <douglas.ward@prolly.org>
Date: Thu, 30 Nov 2006 21:21:23 -0500
Message-Id: <1164939683.18828.24.camel@TesterBox.tester.ca>
Mime-Version: 1.0
Cc: bluez-devel <bluez-devel@lists.sourceforge.net>
Subject: [Bluez-devel] mx5000tools 0.1
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============1241052020=="
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net


--===============1241052020==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-SlM0ma0iecfBBf9v+bkY"


--=-SlM0ma0iecfBBf9v+bkY
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Hi,

I ported mx5000lib[1] .NET library to Linux and I made mx5000tools[2].=20

It currently supports most operations that control the content of the
screen. Only 2 operations that SetPoint does on windows are not
supported, because I haven't managed to make them work. One is to
display images, I can decode the sent data[3], but when I try re-sending
the same data, it doesn't show up on the screen. The second is to change
the content of the menus there again, the keyboard doesn't seem to be
responsive to the commands that I send.

It currently only works in HID mode because the bluez code does not yet
support full HID with hiddev.

I should have a homepage and a SVN tree for it soon, I'll post the
address when I set it up.


[1] http://sourceforge.net/projects/mx5000lib/
[2] http://dev.gentoo.org/~tester/dist/mx5000tools-0.1.tar.gz
[3] http://dev.gentoo.org/~tester/image-drawer.c

--=20
Olivier Cr=EAte
tester@tester.ca

--=-SlM0ma0iecfBBf9v+bkY
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQBFb5GjHTiOWk7ZorsRAss0AJ4lm8VcwIOHsItofaJk1zqUSRI2LwCdEtLq
ifhF4lnoNv751PkWQOP/iyA=
=70jR
-----END PGP SIGNATURE-----

--=-SlM0ma0iecfBBf9v+bkY--


--===============1241052020==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--===============1241052020==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--===============1241052020==--
