Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] Ambicom BT2000C CF Card Driver
From: Marcel Holtmann <marcel@holtmann.org>
To: Colin Pinkney <bluez-devel@cpinkney.org.uk>
Cc: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <200403312311.00434.bluez-devel@cpinkney.org.uk>
References: <200403312311.00434.bluez-devel@cpinkney.org.uk>
Content-Type: text/plain
Message-Id: <1080772692.2536.21.camel@pegasus>
Mime-Version: 1.0
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Thu, 01 Apr 2004 00:38:12 +0200

Hi Colin,

> I've got a contact at Ambicom now that is being quite helpful with technical 
> questions and as I still have a BT2000C CF card on loan from someone I hope 
> to push forward with writing a driver for it (or modify an existing driver).
> 
> The Ambicom BT2000C card still uses the OX16c950 UART chip like the BT2000E 
> (which the bt950 driver is for), but now uses the CSR Bluetooth chip instead 
> of the Ericsson chip.
> 
> So I was wondering if there might be a quick(er) way of developing a driver. 
> Could I...
> 
> 1) Take the OX16c950 support from the bt950_cs and combine it with, say, the 
> CSR support in btuart_cs?
> 
> or
> 
> 2) Add OX16c950 support to hciattach and use hci_uart as is?

I really prefer method 2 and it could already work out of the box with
2.6, because there is a new serial driver core. On the other hand we saw
problems with some serial based cards and serial_cs. Some people should
try it and see what happens.

Regards

Marcel




-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
