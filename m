Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] Port parameter negotiation?
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <200411291226.52638.harbaum@beecon.de>
References: <200411291226.52638.harbaum@beecon.de>
Content-Type: text/plain
Message-Id: <1101728078.7463.37.camel@pegasus>
Mime-Version: 1.0
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
Reply-To: bluez-devel@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Mon, 29 Nov 2004 12:34:38 +0100

Hi Till,

> does BlueZ implement rfcomm port paramater negotiation? This is required to 
> allow a bluetooth->rs232 converter so set the baud rate etc according to the 
> settings on the hosts virtual serial port. E.g. changing the baudrate on a 
> windows bluetooth com port changes the rs232 bit rate on the bt device as 
> well (ok, at least my widcomm/win98 notebook does this only for 57600 and 
> 115200 correctly).
> 
> So using something like 
>   stty -F /dev/rfcomm0 speed 9600 
> 
> should IMHO cause a rfcomm port negotiation packet to be sent on client side. 
> But i don't see this happen ...

as far as I remember we haven't fully implemented it. We only have code
to fulfill the Bluetooth qualification requirements. However the main
RFCOMM interface are sockets and there you don't have to worry about the
baud rate. Adding support for it should not be that hard. Find out what
IOCTL the command above triggers and prepare the correct negotiation
packet.

Regards

Marcel




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
