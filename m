Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: Paul LeoNerd Evans <leonerd@leonerd.org.uk>
To: bluez-users@lists.sourceforge.net
Message-ID: <20050409015826.746a3add@nim.leo>
Mime-Version: 1.0
Content-Type: multipart/signed;
 boundary=Signature_Sat__9_Apr_2005_01_58_26_+0100_l3VZnT7fJBgmjmL2;
 protocol="application/pgp-signature"; micalg=pgp-sha1
Subject: [Bluez-users] Extra keys on a Logitech Cordless Desktop Elite keyboard
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
Reply-To: bluez-users@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Sat, 9 Apr 2005 01:58:26 +0100

--Signature_Sat__9_Apr_2005_01_58_26_+0100_l3VZnT7fJBgmjmL2
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

I have recently bought a Logitech Bluetooth keyboard/mouse combo, as
named above.. After much struggling, I've found that the -MH2 kernel
patch properly handles most of the behaviour.=20

The mouse connects fine, all buttons work except the weird 8th button on
the top, but that doesn't work on a wired equivalent of the mouse that I
have elsewhere, so I suspect that's not BlueZ's fault. It even reconnects
after I remove it from the charger base too; most of the other
implementations would lose connectivity due to the mouse shutting down
for charging.

The keyboard doesn't seem too bad either. The basic 105key layout works
as expected, but the extra keys around the top do not. There's the
standard complement of play/stop, volume, application launch, etc.. keys
there. If I press any of those, the "showkey" program on the console will
not show anything. Similarly, Xfree shows a complete lack of activity on
the "xev" output.

Any thoughts..? Has anyone else had any luck with this or a similar
keyboard in this regard..? Is it likely to be easy to fix..?

--=20
Paul "LeoNerd" Evans

leonerd@leonerd.org.uk
ICQ# 4135350       |  Registered Linux# 179460
http://www.leonerd.org.uk/

--Signature_Sat__9_Apr_2005_01_58_26_+0100_l3VZnT7fJBgmjmL2
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQFCVyi1vcPg11V/1hgRAoFBAJsHJ5udbY9QYefX732maHwc/y+79QCeK9Nd
5nYsA0N4zZxwHb8nIcZOu84=
=hKZQ
-----END PGP SIGNATURE-----

--Signature_Sat__9_Apr_2005_01_58_26_+0100_l3VZnT7fJBgmjmL2--


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
