Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-Id: <5.1.0.14.2.20030721154456.0936f098@unixmail.qualcomm.com>
To: James Courtier-Dutton <James@superbug.demon.co.uk>, bluez Dev <bluez-devel@lists.sourceforge.net>
From: Max Krasnyansky <maxk@qualcomm.com>
Subject: Re: [Bluez-devel] Headset via usb dongle devel problems.
In-Reply-To: <3F0EF99B.6000400@superbug.demon.co.uk>
Mime-Version: 1.0
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: 
	<https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: 
	<http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Mon, 21 Jul 2003 16:13:24 -0700
Content-Type: text/plain; CHARSET=us-ascii

At 10:53 AM 7/11/2003, James Courtier-Dutton wrote:
>Hi,
>
>I have discovered that the performance of the bluez stack is a problem when using the hci_usb.c driver.
>I cannot get it to send SCO packets quicker than one urb per 40ms.
>As the headset needs one urb per 3ms, this is quite a problem.
Interesting. We shouldn't have any limitations in this area.

>I would also assume that other applications like file transfer over bluetooth would be bad.
They aren't :). L2CAP, RFCOMM, BNEP transfers using USB devices easily achieve max Bluetooth
throughput. And if you do it over HCIEmu you get numbers like 5Mbytes/sec. So HCI core and
ACL scheduler is pretty darn fast :)

>Would it be ok for the hci_usb.c driver to implement say 100 urbs per type. I.E. 100 output urbs for BULK, 100 output urbs for SCO etc.
This is not needed. I did quite a bit of testing with URB queuing, submitting more than 4 tx/rx 
URBs does not seem to improve performance. In fact you can easily saturate Bluetooth link even if 
use submit one URB at a time and wait for completion. I'm talking about bulk URBs here, like you 
showed in prev emails emails isoc is different.

>Also, I need to know what the intended buffer management in the bluez driver is.
>1) Application allocs some memory.
>2) Application fills memory with data
>3) Application calls bluez with pointer and length of memory.
>4) What does bluez do now?
>Does it: -
>5) memcpy the data from user memory (maybe copyfromuser), add headers to it creating a packet, cutting it up into multiple packets if needed. (E.g. adding connection numbers etc.)
>6) calls the low level device driver with pointer and length of packet.
>7) low level device driver queues it for output. blocks here is the queue is full.
>8) Returns control back to application.
>9) low level device driver outputs the packet, and calls tx_complete callback.
>10) tx_complete callback signals to higher layers in bluez that the tx is complete, and the higher layers release the memory.
Very very close :).

Here is what happens in case when for example L2CAP application calls send() on L2CAP socket:

1) L2CAP allocates new SKB, does copy_from_user() and passes SKB to the HCI core.
2) HCI core adds HCI headers (SKB has room reserved for that), puts SKB into TX queue
of the appropriate ACL connection and schedules TX task.
3) TX task wakes up, decides which packets to send now (based on various counters) 
and hands those packets over to the HCI driver (let's say HCI USB driver).
4) HCI USB driver allocates URB (URB is initialized to use data buffer of the SKB) and
submits URB.
5) Once transfer is complete USB core calls hci_usb_tx_complete() call back which destroys 
SKB.

So, the answer is - yes we do only one copy.

Max



-------------------------------------------------------
This SF.net email is sponsored by: VM Ware
With VMware you can run multiple operating systems on a single machine.
WITHOUT REBOOTING! Mix Linux / Windows / Novell virtual machines at the
same time. Free trial click here: http://www.vmware.com/wl/offer/345/0
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
