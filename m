Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Problems with RS232 and BT - Can't init device
	hci0
From: Marcel Holtmann <marcel@holtmann.org>
To: zubiwat@poczta.onet.pl
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <200403022357.51574.zubiwat@poczta.onet.pl>
References: <200403021801.11637.zubiwat@poczta.onet.pl>
	 <1078257013.1942.200.camel@pegasus>
	 <200403022357.51574.zubiwat@poczta.onet.pl>
Content-Type: text/plain
Message-Id: <1078269173.2787.10.camel@pegasus>
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
Date: Wed, 03 Mar 2004 00:12:53 +0100

Hi Maciej

> I think that it is not capable but how to check it?
> I think that this chip default is set to 921600 bauds. How can I cope with it, 
> how to change it to 115200. How could I check what's wrong and why it doesn't 
> want to hciattach. How to make it work with my PC. On the chip it is written 
> sth like this:
> CSR
> BC212
> 015BD
> 345AC
> 
> Please tell me why it doesn't work. I have to connect 2 PC's together to 
> communicate each other with this chip.

try to run "hciattach ttyS0 csr". If your Bluetooth chip really boots
with 921600 baud you have to buy a serial card that is capable of it.

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
