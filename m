Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Once again: Socket CF card and Kernel 2.6
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <42294598.6010004@adamis.de>
References: <20050226031901.GL11723@adamis.de>
	 <1109578431.17256.9.camel@pegasus>  <20050228220209.GA8151@adamis.de>
	 <1109665776.17256.122.camel@pegasus>  <42294598.6010004@adamis.de>
Content-Type: text/plain
Message-Id: <1110021859.8058.111.camel@pegasus>
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
Date: Sat, 05 Mar 2005 12:24:19 +0100

Hi Mathias,

> I just got it working by doing a little change in the serial driver 
> (8250.c). I tested it with 2.6.11 but I think it could work for any 2.6 
> kernel.

please provide a patch for your change.

> One thing I discovered while debugging this: the hci_uart driver 
> seems to initialize the actual UART with only 230400 baud. Is this 
> really the case or are those UARTs clocked at nonstandard (higher) 
> frequencies so that this setting does result in a higher real baud rate?

The hci_uart is only a line discipline. Every initialization and baud
rate settings are done with hciattach.

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
