Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] bluez and billionton pcbtc1
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <b5c638dc050329084145c6fecd@mail.gmail.com>
References: <b5c638dc05032815321b2739c5@mail.gmail.com>
	 <1112075117.9016.60.camel@pegasus>
	 <b5c638dc05032907582bf771dc@mail.gmail.com>
	 <1112114217.9016.92.camel@pegasus>
	 <b5c638dc050329084145c6fecd@mail.gmail.com>
Content-Type: text/plain
Message-Id: <1112114986.9016.94.camel@pegasus>
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
Date: Tue, 29 Mar 2005 18:49:46 +0200

Hi David,

> yep i saw that last time i stuck the card in, but didn't quite figure it out 
> 
> here's the output from dmesg:
> 
> ttyS14 at I/O 0x400 (irq = 3) is a 16C950/954

and now you only need to find the right hciattach parameters to get this
serial port attached to the Bluetooth subsystem.

Regards

Marcel




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
