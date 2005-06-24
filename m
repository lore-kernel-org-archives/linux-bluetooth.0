Return-Path: <bluez-users-admin@lists.sourceforge.net>
To: bluez-users@lists.sourceforge.net
From: andreas knuth <andreas.knuth@daimlerchrysler.com>
Message-ID: <loom.20050624T174404-129@post.gmane.org>
References: <1119525688.17872.4.camel@sliver.usr.dsi.unimi.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Subject: [Bluez-users] Re: Connecting to a Nokia 6021
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
Date: Fri, 24 Jun 2005 15:50:22 +0000 (UTC)

Hi Sebastian,

Sebastiano Vigna <vigna <at> dsi.unimi.it> writes:

> 
...
>     L2CAP(d): cid 0x0040 len 4 [psm 3]
>       RFCOMM(s): SABM: cr 1 dlci 2 pf 1 ilen 0 fcs 0x59
> > HCI Event: Number of Completed Packets (0x13) plen 5
>   0000: 01 28 00 01 00                                    .(...
> > HCI Event: PIN Code Request (0x16) plen 6
>   0000: 10 26 00 70 13 00                                 .&.p..
> 
> And them the phone times out. The interesting point is that if you look at 
the included hcid.conf,
> I have a pin helper of my own, containing:
> 
> #!/bin/bash
> echo "Request $(date)" >>/tmp/req
> echo "PIN:112358"
> 
> This is never called by the stack.
> 
> I couldn't find any log anywhere to find out what's happening, so I'm
> really stuck.


In your hcid.conf there are two "PIN-HELPER"s active at the same time! You 
should have active only one at the same time. Try it out (deactivate 
dbus_pin_helper -> #dbus_pin_helper.

regards,
Andreas




-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
