Return-Path: <bluez-users-admin@lists.sourceforge.net>
Subject: Re: [Bluez-users] H5 3 wire UART connect problem
From: Marcel Holtmann <marcel@holtmann.org>
To: bluez-users@lists.sourceforge.net
In-Reply-To: <f16b04cf05070405392568477e@mail.gmail.com>
References: <f16b04cf050630083549f68fef@mail.gmail.com>
	 <1120157509.15397.152.camel@pegasus>
	 <f16b04cf05070102493b480412@mail.gmail.com>
	 <1120213256.15397.187.camel@pegasus>
	 <f16b04cf05070103496a3e64e6@mail.gmail.com>
	 <1120224082.15397.197.camel@pegasus>
	 <f16b04cf0507032307413fcef@mail.gmail.com>
	 <f16b04cf05070405321b3bc41b@mail.gmail.com>
	 <f16b04cf05070405392568477e@mail.gmail.com>
Content-Type: text/plain
Message-Id: <1120482028.10273.154.camel@pegasus>
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
Date: Mon, 04 Jul 2005 15:00:28 +0200

Hi Hariharan,

>  Presently we are working in 3 WIRE UART Bluetooth transport protocol
>  implementation.
>  We are in implementation of 3 WIRE UART in hciattach.c.
>  
>  Our Specification:
>  Linux kernel - 2.4.20.

this kernel version is a little bit problematic. Do your development
with the 2.6.12 kernel and then backport it. Otherwise nobody will
review it and it may become useless.

>  Module - Solicon wave Serial port Bluetooth Module.

I can test it out with a Casira and a BlueCore4.
 
>  In the HCI attach, We are following the procedure of given below.
>  
>  Host side  -> SYNC Command -> BT Device 
>  Host side <-  SYNC Response <- BT Device
>  Host Side <-  SYNC Command <- BT Device
>  Host Side -> SYNC Response -> BT Device
>  Host side <- Config Command <- BT Device
>  Host side -> Config Response -> BT Device
> 
> Here after the device does not respond for any of the commands

Actually I have no idea why that happens, but I also don't have any
Silicon Wave development kit at hand.

> Please advise us whether our command sequence for the HCI attach of 3 WIRE
> bluetooth device.

Check the specification. I have no idea.

> Our progress plan in the Implementation of H5 3 WIRE in Bluez.
> First we attach the module HCI layer with the bluez stack.
> Second we build the driver to usr 3 WIRE stack.
> our plan is a proper one or not. Advise.

You add the basic configuration stuff to hciattach like it was done for
BCSP and then you set the TTY line discipline to N_HCI and switch to the
3-Wire UART protocol. However this must be implemented in hci_3wire.c
and linked correctly into the hci_uart.ko driver. The complete protocol
handling then has to be done inside the kernel.

Regards

Marcel




-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
