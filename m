Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] Re: Bluez setup and Bluetooth stack and 2.6
	kernel
From: Marcel Holtmann <marcel@holtmann.org>
To: gonzalo briceno <gonzaloother@yahoo.com>
Cc: BlueZ Mailing List <bluez-users@lists.sourceforge.net>
In-Reply-To: <20040826141810.46943.qmail@web52608.mail.yahoo.com>
References: <20040826141810.46943.qmail@web52608.mail.yahoo.com>
Content-Type: text/plain
Message-Id: <1093530808.2581.30.camel@pegasus>
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
Date: Thu, 26 Aug 2004 16:33:28 +0200

Hi Gonzalo,

> So what I gather is that the bluez.o module
> functionality is already part of the bluetooth.ko
> module.  Is there anything else I need to know in
> terms of what modules need to be loaded for things to
> work?  The reason for asking is that most
> documentation I have read so far is most likely old
> and refers to bluez.o.  To make a long story short
> does the following seem correct to get USB and
> Bluetooth to work (using kernel 2.6) barring any other
> problems: 
> 
> 1. load usbcore
> 2. load proper USB host driver (OHCI, UHCI, EHCI)
> 3. load bluetooth.ko
> 4. load (RFCOMM, L2CAP, BNEP, etc)

this is correct, but you can leave step 1 and 3 out, because the module
dependency will take of that these are also loaded. However you forgot
the Bluetooth hardware driver. In general this is the hci_usb driver for
the H:2 transport protocol support.

Regards

Marcel




-------------------------------------------------------
SF.Net email is sponsored by Shop4tech.com-Lowest price on Blank Media
100pk Sonic DVD-R 4x for only $29 -100pk Sonic DVD+R for only $33
Save 50% off Retail on Ink & Toner - Free Shipping and Free Gift.
http://www.shop4tech.com/z/Inkjet_Cartridges/9_108_r285
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
