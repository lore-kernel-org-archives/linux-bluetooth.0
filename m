Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] irattach and pseudo tty
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <20050314223925.04FDC2DE@arbetsmyra.dyndns.org>
References: <20050314223925.04FDC2DE@arbetsmyra.dyndns.org>
Content-Type: text/plain
Message-Id: <1110872420.8820.0.camel@pegasus>
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
Date: Tue, 15 Mar 2005 08:40:20 +0100

Hi Ronny,

> I have a question about interfaceing a BT device via UART.
> 
> Is it possible to use irattach with a pseudo TTY? (This may sound a bit 
> strange perhaps but my device is avilible through a tunneld remote 
> serial port). Or is currently only "real" TTYs supported?

use the hci_vhci driver for these kind of devices.

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
