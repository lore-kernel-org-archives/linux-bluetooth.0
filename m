Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: Florian Echtler <echtler@fs.tum.de>
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] Re: strange btsco error
In-Reply-To: <cvad1d$8tb$1@sea.gmane.org>
Message-ID: <Pine.LNX.4.61.0502221045530.11660@block.bubble>
References: <Pine.LNX.4.61.0502191116450.10610@block.bubble> <cv89g9$399$1@sea.gmane.org>
 <Pine.LNX.4.61.0502200852440.15784@block.bubble> <cvad1d$8tb$1@sea.gmane.org>
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
Date: Tue, 22 Feb 2005 10:50:43 +0100 (CET)

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

> I found a thread in the mailing list:
> http://thread.gmane.org/gmane.linux.bluez.devel/4000
> Are you able to open the device using alsamixer as suggested by Lars
> Grunewaldt?
Yes, that works. The ALSA device exists and can be opened, however (as I
already stated twice now) the error is somewhere in the HwDep part of 
alsa-lib. After reading the above thread, it seems to me that not using
the separate alsa-drivers, but those in the kernel, might be a solution.

Any experiences with that? Better kernel ALSA or standalone ALSA?

Yours, Florian
- -- 
Preserve wildlife - pickle a squirrel today!
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQFCGwB37CzyshGvatgRAkOBAJ9NwaVkSBOBlXRnoHTaEA8YHPZSHwCg1Z3F
27jqM1q4U6SLTMUDL0EaApY=
=hWTL
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
