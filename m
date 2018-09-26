Return-Path: <bluez-users-admin@lists.sourceforge.net>
From: grpmind+bluez.users@boromir.vpop.net
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] How to configure a 723kbps connection?
References: <lists.bluez.users.40323EC2.8080203@csr.com>
Sender: bluez-users-admin@lists.sourceforge.net
Errors-To: bluez-users-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-users.lists.sourceforge.net>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
Date: Tue Feb 17 10:50:20 2004
Message-Id: <20040217174220.7E45532D2F@mail.rvs.uni-bielefeld.de>

Steven Singer wrote:

> Marcel, I don't think this is what Matt meant. I think he was asking
> that given that the link quality and power levels are good and given
> that he can't get more that 265 kbps regardless of packet type, is it
> likely that he's being limited by some component of the system other
> than the Bluetooth link - such as the UART baud rate on the Ipaq.

Steve's right. What I meant by "all this" was everything I had written,
not just the part about rssi, lq, and tpl.

> Is there an easy way to find out what baud rate the Ipaq is using?
> That would answer the question straight away. 265 kbps over the air
> is equivalent to roughly 350 kbps over the UART (assuming one start bit,
> one stop bit, no parity and large HCI packets).

Not presently, because it is running Pocket PC 2003. (If there is a way to
tell with PPC, let me know.) Hopefully soon Linux will be running well
on it and then maybe I could tell you; it is booting but not everything
works yet. Maybe http://michaelo.free.fr/pda/h2210/starterkit/bootlog
would give you an idea.

This is an ipaq 2215, which has Intel's PXA255 processor, which according
to the docs has a 920Kbps interface. But I suppose that doesn't mean HP
hooked it up optimally.

> Also, although you're right that the RSSI has nothing to do with the
> chosen packet type, the link quality has a big effect. As the link
> quality falls, devices will tend to switch automatically from DH
> packets to the more robust DM packets.

Could I use hcidump to tell what's going on?

Matt


-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
