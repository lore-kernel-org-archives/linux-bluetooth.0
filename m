Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Serial(HCI-UART) Bluetooth Module -
	Initialization timeout error
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <f54d8640503240501491f765e@mail.gmail.com>
References: <f54d8640503240350250aae5e@mail.gmail.com>
	 <1111666515.1916.62.camel@pegasus>
	 <f54d8640503240501491f765e@mail.gmail.com>
Content-Type: text/plain
Message-Id: <1111669608.1916.73.camel@pegasus>
Mime-Version: 1.0
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
Date: Thu, 24 Mar 2005 14:06:48 +0100

Hi Benny,

> Thanks Marcel for your reply. Yes we doing the same exercise debugging
> step by step using the hciattach source. Yes we have chosen the
> required configurations mentioned.
> 
> We are designing a Bluetooth remote device using a custom hardware
> interfaced to a standard Bluetooth module(headset+SPP). We are
> targeting this product for PC market.
> 
> So we have to suggest our customer a set of USB Bluetooth dongles
> which supports Bluez on the Linux PC. We are finding that the CSR
> based BT USB dongle is working fine under linux rather than the
> SiliconWave based BT USB dongle. I may be wrong in this regard, I
> might have missed some settings.
> 
> We have tried the following BT USB dongles:
> i) unknown make(CSR)  - Woking fine for Audio and data transfer.
> ii) Orchid (Silicon wave) - Not working for Audio but recieving data.
> iii) ANYCOM USB Adapter 240 (Silicon Wave) - Not working for Audio as
> well as data.
> 
> We are using linux kernel 2.6.9-1.667(Fedora Core 3) and using the
> latest CVS BT-SCO drivers.

the ACL part should work for any dongle without any problems. I have one
of the Anycom 240 adapters by myself and the data part is working fine.
For the SCO support you should really go with CSR based dongles, because
the Silicon Wave seem to behave somekind of strange. However I am not
fully working on this topic.

Regards

Marcel




-------------------------------------------------------
This SF.net email is sponsored by Microsoft Mobile & Embedded DevCon 2005
Attend MEDC 2005 May 9-12 in Vegas. Learn more about the latest Windows
Embedded(r) & Windows Mobile(tm) platforms, applications & content.  Register
by 3/29 & save $300 http://ads.osdn.com/?ad_id=6883&alloc_id=15149&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
