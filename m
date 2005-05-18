Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: Tobias Lang <tobias-lang@gmx.de>
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] Hama BT1000 Headset Problems
Message-ID: <20050518163116.149369f3@localhost.localdomain>
In-Reply-To: <4287BCAB.8050600@xmission.com>
References: <20050515145042.70745815.tobias-lang@gmx.de>
	<428761F9.7070805@xmission.com>
	<20050515192044.659654d3.tobias-lang@gmx.de>
	<4287A0A1.80309@xmission.com>
	<20050515223523.639551bf.tobias-lang@gmx.de>
	<4287BCAB.8050600@xmission.com>
Mime-Version: 1.0
Content-Type: multipart/signed;
 boundary="Signature_Wed__18_May_2005_16_31_16_+0200_Y/291mKZ0EleDgOy";
 protocol="application/pgp-signature"; micalg=pgp-sha1
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
Date: Wed, 18 May 2005 16:31:16 +0200

--Signature_Wed__18_May_2005_16_31_16_+0200_Y/291mKZ0EleDgOy
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sun, 15 May 2005 15:18:35 -0600
Brad Midgley <bmidgley@xmission.com> wrote:

> yes, the bluetooth adapter is more often the problem than the headset.
> 

Well, I tried the HS with a CSR Dongle:

~$ hciconfig -a
hci0:   Type: USB
        BD Address: 00:09:DD:10:75:75 ACL MTU: 192:8 SCO MTU: 64:8
        UP RUNNING PSCAN ISCAN
        RX bytes:235 acl:0 sco:0 events:28 errors:0
        TX bytes:393 acl:0 sco:0 commands:22 errors:0
        Features: 0xff 0xff 0x0f 0x00 0x00 0x00 0x00 0x00
        Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3
        Link policy: RSWITCH HOLD SNIFF PARK
        Link mode: SLAVE ACCEPT
        Name: 'BlueZ (0)'
        Class: 0x3e0100
        Service Classes: Networking, Rendering, Capturing
        Device Class: Computer, Uncategorized
        HCI Ver: 1.1 (0x1) HCI Rev: 0x175 LMP Ver: 1.1 (0x1) LMP Subver: 0x175
        Manufacturer: Cambridge Silicon Radio (10)

But now, I am even not able to connect to the HS (both in pairing and normal mode)

~$ btsco <headset> -v
	btsco v0.4b
	Device is 1:0
	Error: Failed to connect to SDP server: Permission denied
	Assuming channel 2

	Voice setting: 0x0060
	Can't connect RFCOMM channel: Permission denied

Does this mean, the HS is not compatible, or is there anything else really wrong?

Regards, Tobi
--Signature_Wed__18_May_2005_16_31_16_+0200_Y/291mKZ0EleDgOy
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQFCi1G7jxmcDuHlx5oRAm8hAKDL0kdPSzLaeVyUeSFL/CMKPjelEgCggl3m
kaHG2B6UjE4GQ9m/rwEtLFM=
=oMMW
-----END PGP SIGNATURE-----

--Signature_Wed__18_May_2005_16_31_16_+0200_Y/291mKZ0EleDgOy--


-------------------------------------------------------
This SF.Net email is sponsored by Oracle Space Sweepstakes
Want to be the first software developer in space?
Enter now for the Oracle Space Sweepstakes!
http://ads.osdn.com/?ad_id=7412&alloc_id=16344&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
