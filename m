Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: Florian Echtler <echtler@fs.tum.de>
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] Re: strange btsco error
In-Reply-To: <cv89g9$399$1@sea.gmane.org>
Message-ID: <Pine.LNX.4.61.0502200852440.15784@block.bubble>
References: <Pine.LNX.4.61.0502191116450.10610@block.bubble> <cv89g9$399$1@sea.gmane.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
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
Date: Sun, 20 Feb 2005 08:59:24 +0100 (CET)

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

> > [root@block:/usr/src/btsco-20040219][0] $ ./btsco 00:0D:FD:.....
> > Device is 2:0
> > Error: btsco open (2-0): No such device or address
> Is your headset in the list of ALSA devices and the ALSA soundsystem
> started? (cat /proc/asound/cards)

1. No, it isn't. However, this should not matter, as I stated that this
   error happens _before_ any bluetooth specific code is executed, in
   btsco.c, line 356: snd_hwdep_open().

2. cat /proc/asound/cards:

0 [CK8            ]: NFORCE - NVidia CK8
                     NVidia CK8 with ALC650F at 0xe8000000, irq 21
1 [U0x46d0x8b0    ]: USB-Audio - USB Device 0x46d:0x8b0
                     USB Device 0x46d:0x8b0 at usb-0000:00:02.0-2.4, full speed
2 [Headset        ]: Bluetooth SCO - BT Headset
                     BT Headset 1

Yours, Florian
- -- 
Preserve wildlife - pickle a squirrel today!
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQFCGENg7CzyshGvatgRApfpAJ9imiZYq35qYnj975JU7E0/IaC3LACfWx2h
06k/NCPJ4OTlOljCSCbI66U=
=XN1E
-----END PGP SIGNATURE-----


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
