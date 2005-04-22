Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <312a181605042212245acad558@mail.gmail.com>
From: =?ISO-8859-1?Q?=C1lvaro_Lopes?= <alvieboy@gmail.com>
To: bluez-users@lists.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Subject: [Bluez-users] Multicast over BNET
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
Date: Fri, 22 Apr 2005 20:24:07 +0100

Hello list

I'm having a problem with multicast filters. When BNEP multicast
filters are activated in the kernel (2.6.11, also in others) I cannot
send multicast packets over the interface.

If I do a "tcpdump -i bnep0" the packets I am sending (to 224.0.0.133)
show up, but they aren't actually sent over the "air" (in fact, a
hcidump shows no activity).

I've set up a route for the interface (eg, route add -net 224.0.0.0
netmask 240.0.0.0 dev bnep0).

I am not a member of that group. Even if I join the MC group (using
only setsockopt, not using SIOCADDMULTI ioctl), it still doesn't
transmit the packets.

If I disable the multicast filters, all goes OK. The packets are
really sent and received by my peer.

The box receives all multicast traffic OK, just those packets I wish
to send do not reach my peer.

My question: Is there a way (simple) to get around this w/o
recompiling the kernel? I also have another problem because the
application we're using is Java(tm) based...

Thanks in advance for any pointers/help on this.

=C1lvaro Lopes


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
