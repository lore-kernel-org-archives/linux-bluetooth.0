Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Once again: Socket CF card and Kernel 2.6
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <20050305141858.GA21208@adamis.de>
References: <20050226031901.GL11723@adamis.de>
	 <1109578431.17256.9.camel@pegasus> <20050228220209.GA8151@adamis.de>
	 <1109665776.17256.122.camel@pegasus> <42294598.6010004@adamis.de>
	 <1110021859.8058.111.camel@pegasus>  <20050305141858.GA21208@adamis.de>
Content-Type: text/plain
Message-Id: <1110046671.18555.3.camel@pegasus>
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
Date: Sat, 05 Mar 2005 19:17:50 +0100

Hi Mathias,

> > > I just got it working by doing a little change in the serial driver 
> > > (8250.c). I tested it with 2.6.11 but I think it could work for any 2.6 
> > > kernel.
> > 
> > please provide a patch for your change.
> 
> So - after some cleaning - here it is. A short description:
> 
> The BlueZ driver requests a baud rate
> of 230400 which is uartclk/8 (serial_cs sets uartclk=1843200). However
> serial8250_set_termios() refuses to program a baud rate larger than
> uartclk/16 which should be ok for most UARTs. I looked into the 2.4
> driver and found some code that changes the internal prescaler to values
> between 1:16 and 1:4 to support baud rates up to uartclk/4 respectively
> (this is done for 16C950 UARTs only). The datasheet of oxford's oxcf950
> chip confirms this feature.
> 
> Apply the patch to the file drivers/serial/8250.c
> 
> Please let me know if there are problems or if it does work.

I only have the old Socket cards (dtl1_cs driver) at hand and so I can't
test it, but my Xircom card is still not working.

> > > One thing I discovered while debugging this: the hci_uart driver 
> > > seems to initialize the actual UART with only 230400 baud. Is this 
> > > really the case or are those UARTs clocked at nonstandard (higher) 
> > > frequencies so that this setting does result in a higher real baud rate?
> > 
> > The hci_uart is only a line discipline. Every initialization and baud
> > rate settings are done with hciattach.
> 
> ok so it's hciattach that sets the baudrate - but that wasn't the point
> (or I misunderstood your answer?): I wonder if the bluetooth module is
> really accessed at only 230400 baud (that's the rate which is given to
> the 8250 driver) which seems a little bit slow thinking of bluetooths
> >700kbaud maximum rate...

For the Socket card the baud rate is 230400 and yes, this is to slow for
the full bandwith of a piconet. However I never did any bandwith test
with this card, but actually there are cards out there where the UART
limits the total possible bandwidth.

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
