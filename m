Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: Florian Echtler <echtler@fs.tum.de>
To: bluez-users@lists.sourceforge.net
Message-ID: <Pine.LNX.4.61.0502191116450.10610@block.bubble>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Subject: [Bluez-users] strange btsco error
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
Date: Sat, 19 Feb 2005 11:25:31 +0100 (CET)

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Hello everyone,

I was trying to get my BT headset running with btsco today.
This has the following result:

[root@block:/usr/src/btsco-20040219][0] $ ./btsco 00:0D:FD:.....
Device is 2:0
Error: btsco open (2-0): No such device or address

[root@block:/usr/src/btsco-20040219][255] $ 

The same happens with btsco2 after a short pause, in which a
connection seems to be established for a moment (BTW, what's
the difference between btsco and btsco2?).

Obviously, the error happens in snd_hwdep_open(), and a bit of
digging showed that the real troublemaker is some alsa-lib sub-
routine called snd_config_search_alias_hooks(). I know that
this therefore is primarily an ALSA error, but maybe one of the
authors of btsco has an idea anyway? Do I need some additional
ALSA configuration to use this?

Thanks in advance,
Yours, Florian
- -- 
Preserve wildlife - pickle a squirrel today!
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.6 (GNU/Linux)

iD8DBQFCFxQf7CzyshGvatgRAgo6AKD97SZYWtG9MR0UlqIKf90aJ8zg8ACgslR4
n1v2jwYfOS19H8z2r4TknWU=
=Fsv8
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
