Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <40A27A5C.4080603@thomae-privat.de>
From: Matthias Thomae <bluez@thomae-privat.de>
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
Content-Type: text/plain; charset=us-ascii; format=flowed
Subject: [Bluez-devel] PAN and bridge problem when bnep0 disconnects before bnep1
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Wed, 12 May 2004 21:26:20 +0200

Hello,

I have a BlueZ NAP setup with bridging (essentially following the PAN
HOWTO), which works quite nicely (thanks to all developers :) except
when the first connected bnep0 client is killed before the 2nd client
(bnep1).

I am running a DHCP server on the server's bridge (pan0), and eth0 is
NOT part of the bridge, I use IP forwarding instead.

The problem is, that after bnep0 is removed (by killing it on the
respective client with 'pand -K'), bnep1 doesn't 'work' any longer,
meaning ping etc. don't work any more. And I couldn't find anything in
the syslogs, except that after a while the client's DHCP client starts
to issue DHCPDISCOVERs.

ifdown/ifup on bnep1 don't seem to help either, the only way I could
find to make it work again was to issue 'pand -K' on the server and
reconnect the clients.

If bnep1 disconnects before bnep0, no problem.

I'm using quite late BlueZ versions on all machines (at least kernel
2.6.5-mh3 and the latest Debian bluez-utils 2.6-1 and bluez-pan
1.1rel-4), and I can reproduce the behaviour also with a Windows client
on bnep0.

Any clues?

Regards.
Matthias



-------------------------------------------------------
This SF.Net email is sponsored by Sleepycat Software
Learn developer strategies Cisco, Motorola, Ericsson & Lucent use to deliver
higher performing products faster, at low TCO.
http://www.sleepycat.com/telcomwpreg.php?From=osdnemail3
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
