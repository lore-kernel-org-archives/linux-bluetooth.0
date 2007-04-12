Return-Path: <bluez-users-bounces@lists.sourceforge.net>
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ users <bluez-users@lists.sourceforge.net>
In-Reply-To: <46150ADA.1000503@gmx.de>
References: <46150ADA.1000503@gmx.de>
Date: Thu, 12 Apr 2007 12:26:51 +0200
Message-Id: <1176373611.7049.14.camel@violet>
Mime-Version: 1.0
Subject: Re: [Bluez-users] raw mode
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

Hi Sebastian,

> if I simply change the product ID of my CSR dongle from
> 0a12:0001 to 0a12:0002 hciconfig will report "RAW" as device
> mode after rebooting:
> hci0:	Type: USB
> 	BD Address: 00:16:41:18:7A:8C ACL MTU: 0:0 SCO MTU: 0:0
> 	UP RUNNING RAW
> 	RX bytes:66 acl:0 sco:0 events:0 errors:0
> 	TX bytes:15 acl:0 sco:0 commands:5 errors:0
> 
> 
> Does the Bluetooth drivers only assume it must be a raw mode
> because of the product ID? Or is there a "real" raw mode detected?
> And if there is such a raw mode how can raw frames be retrieved?

the RAW flag for HCI indicates the kernel doesn't handle any higher
protocol like L2CAP or RFCOMM for this device. It means you have to do
everything by yourself. So in theory you can write your own Bluetooth
protocol stack in userspace accessing the HCI in RAW mode and make use
of the BlueZ transport drivers.

The RAW mode is not a sniffer mode. However it gets set if you attach a
Bluetooth dongle from Frontline. They look like normal HCI devices, but
they are not.

Regards

Marcel



-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
