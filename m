Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] How to configure a 723kbps connection?
From: Marcel Holtmann <marcel@holtmann.org>
To: Steven Singer <steven.singer@csr.com>
Cc: grpmind+bluez.users@boromir.vpop.net,
   BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <403291AD.7080601@csr.com>
References: <200402171142.i1HBgRV5023132@mail.holtmann.net>
	 <1077018777.2841.5.camel@pegasus> <40323EC2.8080203@csr.com>
	 <1077037423.2665.72.camel@pegasus>  <403291AD.7080601@csr.com>
Content-Type: text/plain
Message-Id: <1077058296.2665.129.camel@pegasus>
Mime-Version: 1.0
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
Date: Tue, 17 Feb 2004 23:51:37 +0100

Hi Steven,

> I read Matt's message as that he was asking for confirmation of your
> suggestion that the UART baud rate was the most likely limit and that
> he should stop wasting his time playing with the packet settings. Given
> the information he listed, particularly that the link quality was 255,
> I think it's unlikely to be a problem with the Bluetooth link and more
> likely to be a problem elsewhere in the system.
> 
> The next few messages in the thread were talking about whether the Zeevo
> chip was a bad chip or had a bad link manager. This appears to be
> irrelevant as the most likely source of the bandwidth limit is the Ipaq
> UART.

we know for sure that the 3870 has the problem with a too slow UART, but
the 3970 can go with full speed. So I assume that HP won't had this
problem with their newer 2xxx generation, but who knows :(

> The spec allows the link quality to be tied to anything, but module
> manufacturers will be aware that if they don't have at least some
> component of the link quality sensitive to whether DH packets are likely
> to get through, they're going to get support calls of the form "why am I
> getting only 400 kbps but get_link_quality says the link is perfect?"
> 
> However, since the logs Matt gave show him running hcitool to get
> the link quality, he must be getting it on the Linux side of the
> link which, according to his hciconfig, is a CSR device.
> 
> This tells us that the CSR device is has a BER for received packets
> that's low enough for DH5 packets to stream at 700 kbps. However, it
> tells us nothing about the BER for packets received at the Ipaq end.
> The link may not be symmetric. However, even if the link had switched
> to DM5 packets, we'd expect to see 470 kbps. To get 265 kbps the link
> would have to be atrocious (> 0.4% BER). I think it's unlikely that
> we'd have a 0.4% BER one way and < 0.0025% the other way.

Thanks for this explanation. It is good to know how and when the link
manager decides what packet types to use ;)

> There may be other issues. For example, poor choice of L2CAP MTU
> could limit the packet types that are allowed (for example, L2CAP
> MTUs sigificantly below 150 could limit the data rate). This would
> show up on an HCI trace. An HCI trace would also confirm which profile
> was being used for the connection.

Matt, please run "hcidump -w <file>" (as root) and post it to the list,
so Steven can take a look at it.

> It may be that the Ipaq is limited in the rate at which it can process
> data. This could cause it to assert UART flow control to the Bluetooth
> chip, stalling the data flow.

It is possible, because they no longer can use BCSP and have to deal
with bit errors on H4.

Regards

Marcel




-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
