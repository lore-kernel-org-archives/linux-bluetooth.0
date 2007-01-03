Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: Jon Barnett <jbarnett@pobox.com>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
In-Reply-To: <1167855219.20568.25.camel@violet>
References: <mailman.341782.1167746753.8777.bluez-devel@lists.sourceforge.net>
	<1167793130.3356.17.camel@localhost> <1167816533.20568.12.camel@violet>
	<1167843929.3164.1.camel@localhost> <1167844461.20568.18.camel@violet>
	<1167854661.3145.4.camel@localhost> <1167855219.20568.25.camel@violet>
Date: Wed, 03 Jan 2007 16:56:06 -0500
Message-Id: <1167861366.3367.2.camel@localhost>
Mime-Version: 1.0
Subject: Re: [Bluez-devel] Problems with Dell BCM2045 USB device
Reply-To: jbarnett@pobox.com,
        BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============0001991307=="
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net


--===============0001991307==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="=-aoKjc2gCuUlJd/UuBZz1"


--=-aoKjc2gCuUlJd/UuBZz1
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, 2007-01-03 at 21:13 +0100, Marcel Holtmann wrote:
> please call at least "hciconfig hci0 up". This is an adapter in down
> state.

Sorry too many things going on at once. I had some instability playing
with the WinTV-HVR-950.

Here's the results with it "up". ;)

hci0:   Type: USB
        BD Address: 00:16:CF:CE:C2:75 ACL MTU: 1017:8 SCO MTU: 64:0
        UP RUNNING PSCAN=20
        RX bytes:659 acl:0 sco:0 events:19 errors:0
        TX bytes:323 acl:0 sco:0 commands:19 errors:0
        Features: 0xff 0xff 0x8d 0xfe 0x9b 0xfd 0x00 0x80
        Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3=20
        Link policy: RSWITCH HOLD SNIFF PARK=20
        Link mode: SLAVE ACCEPT=20
        Name: 'BlueZ (0)'
        Class: 0x3e0100
        Service Classes: Networking, Rendering, Capturing, Object
Transfer, Audio
        Device Class: Computer, Uncategorized
        HCI Ver: 2.0 (0x3) HCI Rev: 0x20da LMP Ver: 2.0 (0x3) LMP
Subver: 0x4182
        Manufacturer: Broadcom Corporation (15)

Cheers,

Jon.

--=-aoKjc2gCuUlJd/UuBZz1
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBFnCZ2u2cEic/xsEARAgoZAJ9BaeLTWLPjTQ/wMj8ClvlIlOvLKwCfcf4w
45Wh4fvuwuz6Xguzij9pqRs=
=5p9y
-----END PGP SIGNATURE-----

--=-aoKjc2gCuUlJd/UuBZz1--



--===============0001991307==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--===============0001991307==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--===============0001991307==--
