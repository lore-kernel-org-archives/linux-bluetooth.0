Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] How to configure a 723kbps connection?
From: Marcel Holtmann <marcel@holtmann.org>
To: Steven Singer <steven.singer@csr.com>
Cc: grpmind+bluez.users@boromir.vpop.net,
   BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <40323EC2.8080203@csr.com>
References: <200402171142.i1HBgRV5023132@mail.holtmann.net>
	 <1077018777.2841.5.camel@pegasus>  <40323EC2.8080203@csr.com>
Content-Type: text/plain
Message-Id: <1077037423.2665.72.camel@pegasus>
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
Date: Tue, 17 Feb 2004 18:03:43 +0100

Hi Steven,

> >> # hcitool rssi 00:04:3E:81:90:E0
> >> RSSI return value: 0
> >> # hcitool lq 00:04:3E:81:90:E0
> >> Link quality: 255
> >> # hcitool tpl 00:04:3E:81:90:E0
> >> Current transmit power level: -8
> >> 
> >> 
> >> Does all this mean that my ipaq has a slow UART?
> > 
> > No, because the link quality and the RSSI has nothing to do with the
> > choosen packet type.
> 
> Marcel, I don't think this is what Matt meant. I think he was asking
> that given that the link quality and power levels are good and given
> that he can't get more that 265 kbps regardless of packet type, is it
> likely that he's being limited by some component of the system other
> than the Bluetooth link - such as the UART baud rate on the Ipaq.

no I don't missed the point here. But the thread was broken and if you
look at the beginning you see that I already told him that it can be a
problem with a too slow UART. This is true for the 3870.

> Is there an easy way to find out what baud rate the Ipaq is using?
> That would answer the question straight away. 265 kbps over the air
> is equivalent to roughly 350 kbps over the UART (assuming one start bit,
> one stop bit, no parity and large HCI packets).

He said that it run Windows, so I can't tell :(

> Also, although you're right that the RSSI has nothing to do with the
> chosen packet type, the link quality has a big effect. As the link
> quality falls, devices will tend to switch automatically from DH
> packets to the more robust DM packets.

The link quality is problematic, because every chip manufacturer can
interpret this value different. For CSR this is bound to the BER. Had
you ever run any test with your chips against the old Zeevo TC2001
generation?

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
