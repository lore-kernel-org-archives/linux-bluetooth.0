Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] bluetooth and wireless lan horror
From: Marcel Holtmann <marcel@holtmann.org>
To: Steven Singer <steven.singer@csr.com>
Cc: Peter Bergmann <bergmann.peter@gmx.net>,
   BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <3F7D5B72.1050900@csr.com>
References: <1065171540.1734.97.camel@pegasus>
	<28385.1065174121@www39.gmx.net> <1065174943.1734.101.camel@pegasus>
	<3F7D5B72.1050900@csr.com>
Content-Type: text/plain
Message-Id: <1065443556.21958.39.camel@pegasus>
Mime-Version: 1.0
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Id: <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: 06 Oct 2003 14:32:30 +0200

Hi Steven,

> A technique that might be useful for both BT 1.1 and 1.2 devices is
> to use sniff. If you chose a relatively long sniff interval (several
> hundred milliseconds) then when the link is idle the Bluetooth devices
> will communicate only once per interval (as opposed to the default of
> about once every 25 ms). If you also chose a fairly high timeout then
> once data starts flowing it should be able to stream smoothly. The
> only disadvantage of this technique is that when data flow stops you
> may get a delay of up to the sniff interval before it can restart.
> 
> This should be relatively easy to test. Use the HCI command line tools
> to put the link in sniff mode. I suggest parameters of min_interval =
> 0x200, max_interval = 0x400, attempts = 4, timeout = 40.
> 
> In theory it would be possible for BlueZ to detect that the rfcomm
> link has gone quiet (a simple timer from the last packet sent or
> received) and then automatically switch into sniff mode. An advantage
> of this technique is that BlueZ can gradually increase the sniff
> interval the longer the link's been idle. The longer the sniff
> interval, the longer the latency from when either host sends data
> till it can be sent over the air. This would mean that if the link
> was idle only briefly you'd get low latency but if you didn't use
> the link for a while then it'd take a while for data to flow.

this idea is nice and it sounds like a useful feature. But it can't
depend on the RFCOMM traffic. It must depend on the ACL traffic and the
BlueZ core must handle it.

Regards

Marcel




-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
