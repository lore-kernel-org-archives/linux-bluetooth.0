Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: Florian Echtler <echtler@fs.tum.de>
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] l2ping working only in one direction
In-Reply-To: <Pine.LNX.4.63.0507060905270.7056@block.bubble>
Message-ID: <Pine.LNX.4.63.0507060942310.7056@block.bubble>
References: <Pine.LNX.4.63.0507060905270.7056@block.bubble>
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
Date: Wed, 6 Jul 2005 09:45:49 +0200 (CEST)

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Okay, sorry to have bothered you, just solved the problem myself:

> Here's hciconfig -a from the desktop:
> 	Link mode: ACCEPT MASTER

> And this is hciconfig -a from the router, where l2ping fails:
> 	Link mode: ACCEPT MASTER

Obviously, not both sides can be master, so I changed the router
to use only "lm accept;", and now everything works, including
the headset (which I consider somewhat interesting, because it
worked with the desktop machine, which used "lm accept,master;"
all the time).

How is it determined which side will become master when both try
to be? Just timing issues?

Yours, Florian
- -- 
Preserve wildlife - pickle a squirrel today!
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFCy4wv7CzyshGvatgRAqndAJ0T4D3yROQd/U1UOhtTWZNGWhNZbACggcBw
sZXWqUganh0UWc/SNCGuBuc=
=HgXx
-----END PGP SIGNATURE-----


-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
