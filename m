Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] First HCI command sent to a device
From: Marcel Holtmann <marcel@holtmann.org>
To: Steven Singer <steven.singer@csr.com>
Cc: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <404749F3.9090006@csr.com>
References: <1078411850.5347.43.camel@pegasus>  <404749F3.9090006@csr.com>
Content-Type: text/plain
Message-Id: <1078415736.5347.62.camel@pegasus>
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
Date: Thu, 04 Mar 2004 16:55:36 +0100

Hi Steven,

> Sending an HCI_Reset to a CSR device running firmware earlier than 12.0
> will cause the device to perform a full system reset. This means that
> the host transport will be reset (USB devices will drop off the bus and
> reattach, BCSP devices will need to perform link establishment) and it
> means that settings will be reloaded from persistent store (so the baud
> rate will reset).
> 
> Firmware version 12.0 and later are better behaved and will reset all
> the LM and LC settings (drop all links etc.) but leave the host
> transport up and running.

thanks for reminding me. I thought the reason was some of the Ericsson
ROK's that had a problem, but in fact the old CSR firmware don't likes
this command ;)

The i-Tec dongle needs the HCI_Reset command to switch from HID to HCI
mode and I don't wanna break support for the old CSR firmware, because
some of my dongles and some iPAQ's still run HCI 11.x or younger. How do
we solve this?

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
