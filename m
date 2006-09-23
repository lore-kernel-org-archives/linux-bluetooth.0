Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <451534E4.6010609@korrnet.org>
Date: Sat, 23 Sep 2006 09:21:40 -0400
From: Kirby <kirby@korrnet.org>
MIME-Version: 1.0
To: bluez-users@lists.sourceforge.net
Subject: [Bluez-users] Problems with Philips VOX150
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============1395927020=="
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--===============1395927020==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="------------enig541B87BDB5E40533CB3B2A92"

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig541B87BDB5E40533CB3B2A92
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

I am trying to use a Philips VOX150 with my laptop. The output from
btsco -vr <DEVICEID> is

btsco v0.42
Device is 2:0
Voice setting: 0x0060
RFCOMM channel 1 connected
Using interface hci0
recieved AT+VGS=3D15
Sending up speaker change 15

When I start xmms, I get

speaker volume: 15 mic volume: 1
i/o needed: connecting sco...
connected SCO channel
Done setting sco fd

but there is never any sound and xmms immediately stops playback. When I
 exit xmms I see

speaker volume: 15 mic volume: 1
driver is not in use
disconnected SCO channel

Any suggestions?


--------------enig541B87BDB5E40533CB3B2A92
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org

iD8DBQFFFTTp6Xt+NmMbdFARApKYAJ9otU3+FTOqFxwmrpWNscsIoreE/wCeIB9p
DwTIgs8DinX8bdbQlfY8FTw=
=yp6U
-----END PGP SIGNATURE-----

--------------enig541B87BDB5E40533CB3B2A92--


--===============1395927020==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--===============1395927020==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users

--===============1395927020==--
