Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: martin f krafft <madduck@madduck.net>
To: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
Subject: Re: [Bluez-users] connection timeout after interrupted software
Message-ID: <20050209014831.GA12067@cirrus.madduck.net>
References: <20050208143303.GA5194@cirrus.madduck.net> <1107880590.7327.180.camel@pegasus>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="T4sUOijqQbZv57TR"
In-Reply-To: <1107880590.7327.180.camel@pegasus>
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
Date: Wed, 9 Feb 2005 02:48:31 +0100


--T4sUOijqQbZv57TR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

first of all, sorry for sending an incomplete report. anyway,
i don't think i can provide more information this time...

also sprach Marcel Holtmann <marcel@holtmann.org> [2005.02.08.1736 +0100]:
> the shouldn't be any problems, but anyway what kernel version is this

2.6.10-1-686 (Debian)

> and what does hciconfig show after you discover this problem.

looks good, the same as before

hci0: Type: USB
  BD Address: 08:00:17:1D:32:4D ACL MTU: 339:4  SCO MTU: 60:9
  UP RUNNING PSCAN ISCAN=20
  RX bytes:7621 acl:167 sco:0 events:119 errors:0
  TX bytes:2823 acl:118 sco:0 commands:30 errors:0
  Features: 0xff 0x3b 0x05 0x00 0x00 0x00 0x00 0x00
  Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3=20
  Link policy: HOLD SNIFF PARK=20
  Link mode: SLAVE ACCEPT=20
  Name: 'cirrus'
  Class: 0xf20100
  Service Classes: Networking, Object Transfer, Audio, Telephony, Informati=
on
  Device Class: Computer, Uncategorized
  HCI Ver: 1.1 (0x1) HCI Rev: 0x180 LMP Ver: 1.1 (0x1) LMP Subver: 0x180
  Manufacturer: RTX Telecom A/S (21)

> Are there any other information in dmesg or the logfiles?

no, nothing there...

--=20
martin;              (greetings from the heart of the sun.)
  \____ echo mailto: !#^."<*>"|tr "<*> mailto:" net@madduck
=20
invalid/expired pgp subkeys? use subkeys.pgp.net as keyserver!
spamtraps: madduck.bogus@madduck.net
=20
micro$oft windoze - the best solitaire game you can buy.

--T4sUOijqQbZv57TR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQFCCWvvIgvIgzMMSnURAntrAKDM6e/YB6IZhg88xOcWHqMLDEzvKwCfY4L4
dA7iaNVcWmQj6AAR3sJORrM=
=Oa0Q
-----END PGP SIGNATURE-----

--T4sUOijqQbZv57TR--


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
