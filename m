Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
MIME-Version: 1.0
From: "Florian Schaefer" <listbox@netego.de>
To: BlueZ development <bluez-devel@lists.sourceforge.net>
Date: Sun, 28 Jan 2007 15:30:55 +0100
In-Reply-To: <E1HAsSn-0000V7-5M@washu.netego.de>
References: <E1HAsSn-0000V7-5M@washu.netego.de>
Message-Id: <E1HBB3Y-0000YF-QI@washu.netego.de>
Subject: Re: [Bluez-devel] aplay freezes with headsetd
Reply-To: Florian Schaefer <listbox@netego.de>,
        BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============1661152211=="
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

--===============1661152211==
Content-Type: multipart/signed;
	boundary="=====--===-=---==---=-=-=----=--=-----==-";
	micalg=pgp-sha1; protocol="application/pgp-signature"
Content-Disposition: inline

--=====--===-=---==---=-=-=----=--=-----==-
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

OK, so I'll start and reply to myself a bit...

On Sat, 27 Jan 2007 19:39:37 +0100, Florian Schaefer said:

> I'm currently trying to get my "Logitech Mobile Pro II" headset connected
> to my Debian box using the new and shiny headsetd. It seems that I get a
> connection between my notebook and the headset when starting a test run
> of aplay (the speaker of the headset is activated and emits some quiet
> static sounds) but that's all that happens. Aplay will just kind of
> freezes and that's it.
>=20
> But now the information in more order (my CVS checkouts are from today):
>=20
> root@washu:~ # hciconfig -a
> hci0:	Type: USB
> 	BD Address: 00:02:78:3D:18:DD ACL MTU: 1017:8 SCO MTU: 64:0
> 	UP RUNNING PSCAN=20
> 	RX bytes:397591 acl:21 sco:7760 events:50 errors:0
> 	TX bytes:806 acl:21 sco:0 commands:30 errors:0
> 	Features: 0xff 0xff 0x8d 0xfe 0x9b 0xfd 0x00 0x80
> 	Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3=20
> 	Link policy: RSWITCH HOLD SNIFF PARK=20
> 	Link mode: SLAVE ACCEPT=20
> 	Name: 'washu'
> 	Class: 0x3e0100
> 	Service Classes: Networking, Rendering, Capturing, Object
> Transfer, Audio
> 	Device Class: Computer, Uncategorized
> 	HCI Ver: 2.0 (0x3) HCI Rev: 0x20dc LMP Ver: 2.0 (0x3) LMP Subver:
> 0x415c
> 	Manufacturer: Broadcom Corporation (15)

Reading the bluetooth-alsa website once again, this USB-adapter seems to
be responsible:

root@washu:~ # hciconfig hci0 revision
hci0:	Type: USB
	BD Address: 00:02:78:3D:18:DD ACL MTU: 1017:8 SCO MTU: 64:0
	Firmware 220.65 / 92

I already tried to load hci_usb via "modprobe hci_usb force_scofix" as
advised by the contact website but that didn't change anything. I'm using
linux kernel 2.6.19 with the "plugz/patches/sco-flowcontrol-v3.0.diff"
patches here.

Does anyone have positive or negative experiences with this Broadcom
adapter?
Anything else I might try?

Ciao
Florian=


--=====--===-=---==---=-=-=----=--=-----==-
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)
Comment: Get my DSA key from: www.netego.de/hpc?p=download&l=en

iD8DBQBFvLOf+2lxodi1OoURAh+QAJ44/7x8d7wwQK23ueBTjvy1olHIAACdFiVK
4D5EbrpWw1eQ76L7nLISiD8=
=NTjQ
-----END PGP SIGNATURE-----

--=====--===-=---==---=-=-=----=--=-----==---



--===============1661152211==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--===============1661152211==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--===============1661152211==--
