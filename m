Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: Matias Pablo Brutti <matiasbrutti@ciudad.com.ar>
Reply-To: matiasbrutti@ciudad.com.ar
To: bluez-users@lists.sourceforge.net
References: <200405041444.45061.menard.fabrice@wanadoo.fr>
In-Reply-To: <200405041444.45061.menard.fabrice@wanadoo.fr>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Message-Id: <200405041310.38396.matiasbrutti@ciudad.com.ar>
Subject: [Bluez-users] bluetooth keyboard not typing
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Tue, 4 May 2004 13:10:23 -0300

=2D----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

I got an apple bluetooth keyboard and a MX 900 mouse ...=20

I managed to connect both devices with linux .. the mouse was the easiest=20
one .. the keyboard was a little more complex ..=20
The problems comes when I try to type on the keyboard ..  The keyboards is=
=20
connected becuase to do that I have to type the PIN on the ekyboard and pre=
ss=20
ENTER to complete the pairing .. but when I try to typo so I will actually=
=20
work .. I does not work at alll ....=20
I read that I have to load keybdev .. maybe .. but in 2.6  there is no keyb=
dev=20
module ..  the bthid that I used it from this=20
website http://www.visi.com/~pmk/msbtkb-linux.html I

I use hid2hci=20
then hcid=20
then hciconfig hci0 up=20
then hcitool scan=20
then I connect my mouse and works bith  bthid -v <baddres> and the mouse wo=
rks=20

then I connect my keyboard and works bith  bthid  -a -e -v -v  <baddres>  h=
ere=20
the keyboards get connected but does not output when I type on it .=20


if you need some outputs let me know ..=20
Thanks =20

Matias P. Brutti=20
=2D----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.4 (GNU/Linux)

iQEVAwUBQJfAc2XJj+mzTB70AQL+aQf/ZGO5h7VHd5VSfR8A1Qk4REdPcmYlA/Vs
A/d8VqFdQm7l5EsmTVO5zxfR76QFoc2szys9lJ80wXOr699l0VPTuNRpFMHcLFJJ
lBuv0zhiFGFZusgDVoAJ1ZiSCusSq5eEKmr5C3CVK3EUl1OiHixTGRKIcFP+cu0z
6TjaWJOMA0PGrpg6JCJetpNXzifRM08A6b9/sLrdkH0H3pPyIulfL4z2Zd9fgPCz
U78qSNHQE+yJsB5uC6rGMMrHZf74fFJpclWY1ktjFhgqjtEE4dy08nQGkY6P73GZ
Sp97/ThFVTnMGCN3xl//hwSKlmT96OMCE/ulQuWm/5D+rbPoafUdzQ=3D=3D
=3D4gQ0
=2D----END PGP SIGNATURE-----


-------------------------------------------------------
This SF.Net email is sponsored by: Oracle 10g
Get certified on the hottest thing ever to hit the market... Oracle 10g. 
Take an Oracle 10g class now, and we'll give you the exam FREE.
http://ads.osdn.com/?ad_id=3149&alloc_id=8166&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
