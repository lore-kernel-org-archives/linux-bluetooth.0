Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: Stefan Gold <stefan.gold@web.de>
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] Poor audio quality Headset using snd-bt-sco
References: <200503310022.16686.stefan.gold@web.de>
In-Reply-To: <200503310022.16686.stefan.gold@web.de>
MIME-Version: 1.0
Message-Id: <200503311853.08350.stefan.gold@web.de>
Content-Type: multipart/signed;
  boundary="nextPart14451855.xJSRXSNRR1";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
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
Date: Thu, 31 Mar 2005 18:53:08 +0200

--nextPart14451855.xJSRXSNRR1
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

some remarks to my problem: If I start hidd with "--master", then my=20
BT-Headset seems to work fine, but my mouse is fidgety and jumps while=20
moving.

Another strange thing is, that the connection to the headset is registered =
as=20
ACL, not as SCO like it should be:

positron:/# hcitool con
Connections:
        < ACL 00:06:C5:00:43:02 handle 47 state 1 lm MASTER
        > ACL 00:07:61:0D:08:E3 handle 44 state 1 lm MASTER AUTH ENCRYPT
        > ACL 00:07:61:17:19:F6 handle 41 state 1 lm MASTER

The first line is the headset.

Any ideas?

Stefan
=2D-=20
"Advertising has us chasing cars and clothes, working jobs we hate,so we
 can buy shit we don't need."
                                                               Tyler Durden

--nextPart14451855.xJSRXSNRR1
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQBCTCr0Fdd7dooRJzsRAtX4AJ45U3I94f1iIc1n1We9VH2QOmKZxACfYABI
3Ls6Ip4+W4p4DOBCN7rfzls=
=G/rn
-----END PGP SIGNATURE-----

--nextPart14451855.xJSRXSNRR1--


-------------------------------------------------------
This SF.net email is sponsored by Demarc:
A global provider of Threat Management Solutions.
Download our HomeAdmin security software for free today!
http://www.demarc.com/Info/Sentarus/hamr30
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
