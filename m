Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <40329F44.5070603@vpop.net>
From: Matthew Reimer <mreimer@vpop.net>
MIME-Version: 1.0
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] How to configure a 723kbps connection?
References: <lists.bluez.users.1077037423.2665.72.camel@pegasus.SOMEWHERE> <lists.bluez.users.403291AD.7080601@csr.com>
In-Reply-To: <lists.bluez.users.403291AD.7080601@csr.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
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
Date: Tue, 17 Feb 2004 17:09:56 -0600

Steven Singer wrote:
> Marcel Holtmann wrote:
> 
>>no I don't missed the point here. But the thread was broken and if you
>>look at the beginning you see that I already told him that it can be a
>>problem with a too slow UART. This is true for the 3870.
> 
> 
> I read Matt's message as that he was asking for confirmation of your
> suggestion that the UART baud rate was the most likely limit and that
> he should stop wasting his time playing with the packet settings. Given
> the information he listed, particularly that the link quality was 255,
> I think it's unlikely to be a problem with the Bluetooth link and more
> likely to be a problem elsewhere in the system.

Yes, you read my message correctly.

> The next few messages in the thread were talking about whether the Zeevo
> chip was a bad chip or had a bad link manager. This appears to be
> irrelevant as the most likely source of the bandwidth limit is the Ipaq
> UART.
> 
> Although I'm normally quite happy to see our competitors' products
> maligned, I think that in this case, the conclusion was unwarranted.
> 
> 
>>>Also, although you're right that the RSSI has nothing to do with the
>>>chosen packet type, the link quality has a big effect. As the link
>>>quality falls, devices will tend to switch automatically from DH
>>>packets to the more robust DM packets.
>>
>>The link quality is problematic, because every chip manufacturer can
>>interpret this value different. For CSR this is bound to the BER. Had
>>you ever run any test with your chips against the old Zeevo TC2001
>>generation?
> 
> 
> The spec allows the link quality to be tied to anything, but module
> manufacturers will be aware that if they don't have at least some
> component of the link quality sensitive to whether DH packets are likely
> to get through, they're going to get support calls of the form "why am I
> getting only 400 kbps but get_link_quality says the link is perfect?"
> 
> However, since the logs Matt gave show him running hcitool to get
> the link quality, he must be getting it on the Linux side of the
> link which, according to his hciconfig, is a CSR device.

Correct; that was all from the linux side where the CSR device 
(Actiontec USB dongle) is connected.

> This tells us that the CSR device is has a BER for received packets
> that's low enough for DH5 packets to stream at 700 kbps. However, it
> tells us nothing about the BER for packets received at the Ipaq end.
> The link may not be symmetric. However, even if the link had switched
> to DM5 packets, we'd expect to see 470 kbps. To get 265 kbps the link
> would have to be atrocious (> 0.4% BER). I think it's unlikely that
> we'd have a 0.4% BER one way and < 0.0025% the other way.
> 
> There may be other issues. For example, poor choice of L2CAP MTU
> could limit the packet types that are allowed (for example, L2CAP
> MTUs sigificantly below 150 could limit the data rate). This would
> show up on an HCI trace. An HCI trace would also confirm which profile
> was being used for the connection.

Can I change the L2CAP MTU? Is that different than the ACL MTU that can 
be set via hciconfig? Can I get "an HCI trace" with hcidump, or is that 
what a protocol analyzer would be needed for?

I'm using the NAP profile (sorry for not mentioning that).

> It may be that the Ipaq is limited in the rate at which it can process
> data. This could cause it to assert UART flow control to the Bluetooth
> chip, stalling the data flow.
> 
> As for testing with Zeevo, it's probably safest if I say nothing. Most
> interoperability testing is covered by NDAs.
> 
> 	- Steven

Thanks for your insights!

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
