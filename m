Return-Path: <bluez-users-admin@lists.sourceforge.net>
Message-ID: <42294598.6010004@adamis.de>
From: Mathias Adam <a2@adamis.de>
MIME-Version: 1.0
To: bluez-users@lists.sourceforge.net
Subject: Re: [Bluez-users] Once again: Socket CF card and Kernel 2.6
References: <20050226031901.GL11723@adamis.de>	 <1109578431.17256.9.camel@pegasus>  <20050228220209.GA8151@adamis.de> <1109665776.17256.122.camel@pegasus>
In-Reply-To: <1109665776.17256.122.camel@pegasus>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
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
Date: Sat, 05 Mar 2005 06:37:28 +0100

Hi,

I just got it working by doing a little change in the serial driver 
(8250.c). I tested it with 2.6.11 but I think it could work for any 2.6 
kernel.

Marcel Holtmann schrieb:
> I am not an serial card expert. This is a problem in the serial
> subsystem and a BlueZ problem.

That proved to be true.

Marcel: One thing I discovered while debugging this: the hci_uart driver 
seems to initialize the actual UART with only 230400 baud. Is this 
really the case or are those UARTs clocked at nonstandard (higher) 
frequencies so that this setting does result in a higher real baud rate?


Regards,
Mathias


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
