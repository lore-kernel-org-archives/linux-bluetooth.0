Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Subject: Re: [Bluez-devel] urb timeout with bluetooth USB HCI on ARM
	(2.6.11-rc3)
From: Marcel Holtmann <marcel@holtmann.org>
To: BlueZ Mailing List <bluez-devel@lists.sourceforge.net>
In-Reply-To: <7d01f9f00502210904ac37fae@mail.gmail.com>
References: <7d01f9f00502210904ac37fae@mail.gmail.com>
Content-Type: text/plain
Message-Id: <1109025926.7626.2.camel@pegasus>
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
Date: Mon, 21 Feb 2005 23:45:26 +0100

Hi Tia,

> I'm writing to that list as my last resort in trying to fix a bug i'm
> facing. First of all let me say that this bug looks rather intricate
> to me, that I'm not certain that USB HCI is at fault (though I suspect
> it is, see detail below), and that I've spent a fair amount of time
> digging into code and documentation trying to find out what's going
> wrong. Apologies for the lengthy mail either.
> 
> I'm using 2.6.11-rc3 + AT91RM9200 patches, cross-compiled with gcc 3.3.3.
> 
> The issue happens when I try to use a bluetooth USB dongle on an ARM
> demo board: I can configure it, but I can't create any connection nor
> scan the local network (with 'hcitool'), for I take urb timeout errors
> when doing so.
> 
> Here's a sample of the system logs when the bug happens (with both
> OHCI verbose debug and HCI USB verbose debug enabled):
> 
> Jan  1 01:01:17 ptx-ek kernel: hci_usb_tx_process: hci0
> Jan  1 01:01:17 ptx-ek kernel: drivers/usb/host/ohci-dbg.c: RET
> c03eaa78 dev=2 ep=1in-intr flags=0 len=6/16 stat=0
> Jan  1 01:01:17 ptx-ek kernel: drivers/usb/host/ohci-dbg.c:
> data(6/16): 0e 04 01 16 0c 00 stat:0
> Jan  1 01:01:17 ptx-ek kernel: hci_usb_rx_complete: hci0 urb c03eaa78
> type 4 status 0 count 6 flags 0
> Jan  1 01:01:17 ptx-ek kernel: __recv_frame: hci0 type 4 data c1c28f84 count 6
> Jan  1 01:01:17 ptx-ek kernel: __recv_frame: new packet len 6
> Jan  1 01:01:17 ptx-ek kernel: drivers/usb/host/ohci-dbg.c: SUB
> c03eaa78 dev=2 ep=1in-intr flags=0 len=0/16 stat=-115
> Jan  1 01:01:17 ptx-ek kernel: hci_usb_rx_complete: hci0 urb c03eaa78
> type 4 resubmit status 0
> Jan  1 01:01:17 ptx-ek kernel: at91rm9200-ohci at91rm9200-ohci: urb
> c03eab04 path 2 ep2in 5c160000 cc 5 --> status -110
> Jan  1 01:01:18 ptx-ek kernel: at91rm9200-ohci at91rm9200-ohci: urb c03eab04 td
> ffc070c0 (1) cc 5, len=0/1028
> Jan  1 01:01:18 ptx-ek kernel: drivers/usb/host/ohci-dbg.c: RET
> c03eab04 dev=2 ep=2in-bulk flags=0 len=0/1028 stat=-110
> Jan  1 01:01:18 ptx-ek kernel: drivers/usb/host/ohci-dbg.c:
> data(0/1028): stat:-110
> Jan  1 01:01:18 ptx-ek kernel: hci_usb_rx_complete: hci0 urb c03eab04
> type 2 status -110 count 0 flags 0
> Jan  1 01:01:18 ptx-ek kernel: drivers/usb/host/ohci-dbg.c: SUB
> c03eab04 dev=2 ep=2in-bulk flags=0 len=0/1028 stat=-115
> Jan  1 01:01:18 ptx-ek kernel: hci_usb_rx_complete: hci0 urb c03eab04
> type 2 resubmit status 0
> Jan  1 01:01:18 ptx-ek kernel: at91rm9200-ohci at91rm9200-ohci: urb
> c03eab04 path 2 ep2in 5c160000 cc 5 --> status -110
> Jan  1 01:01:18 ptx-ek kernel: at91rm9200-ohci at91rm9200-ohci: urb c03eab04 td
> ffc07100 (1) cc 5, len=0/1028
> Jan  1 01:01:18 ptx-ek kernel: drivers/usb/host/ohci-dbg.c: RET
> c03eab04 dev=2 ep=2in-bulk flags=0 len=0/1028 stat=-110
> Jan  1 01:01:18 ptx-ek kernel: drivers/usb/host/ohci-dbg.c:
> data(0/1028): stat:-110
> Jan  1 01:01:18 ptx-ek kernel: hci_usb_rx_complete: hci0 urb c03eab04
> type 2 status -110 count 0 flags 0
> Jan  1 01:01:18 ptx-ek kernel: drivers/usb/host/ohci-dbg.c: SUB
> c03eab04 dev=2 ep=2in-bulk flags=0 len=0/1028 stat=-115
> Jan  1 01:01:18 ptx-ek kernel: hci_usb_rx_complete: hci0 urb c03eab04
> type 2 resubmit status 0
> Jan  1 01:01:18 ptx-ek kernel: hci_usb_send_frame: hci0 type 1 len 4
> Jan  1 01:01:18 ptx-ek kernel: hci_usb_tx_process: hci0
> Jan  1 01:01:18 ptx-ek kernel: hci_usb_send_ctrl: hci0 skb c030ae94 len 4
> Jan  1 01:01:18 ptx-ek kernel: __tx_submit: hci0 urb c15708d4 type 1
> Jan  1 01:01:18 ptx-ek kernel: drivers/usb/host/ohci-dbg.c: SUB
> c15708d4 dev=2 ep=0out-ctrl flags=0 len=0/4 stat=-115
> Jan  1 01:01:18 ptx-ek kernel: drivers/usb/host/ohci-dbg.c: setup(8):
> 20 00 00 00 00 00 04 00
> Jan  1 01:01:18 ptx-ek kernel: drivers/usb/host/ohci-dbg.c: data(0/4): 1a 0c 01
> 03 stat:-115
> Jan  1 01:01:18 ptx-ek kernel: drivers/usb/host/ohci-dbg.c: RET
> c15708d4 dev=2 ep=0out-ctrl flags=0 len=4/4 stat=0
> Jan  1 01:01:18 ptx-ek kernel: hci_usb_tx_complete: hci0 urb c15708d4
> status 0 flags 0
> Jan  1 01:01:18 ptx-ek kernel: hci_usb_tx_process: hci0
> 
> 
> As one can see, at some point when processing received frames, a
> timeout occurs ("status = -110") on endpoint 2 IN (bulk endpoint). The
> faulty endpoint is always the same, and that fact, plus the fact that
> it is OHCI complaining, first led me to think it was an OHCI bug.
> 
> I have posted to the linux-usb-devel mailing list for about that:
> http://marc.theaimsgroup.com/?l=linux-usb-devel&m=110839632914184&w=2
> http://marc.theaimsgroup.com/?l=linux-usb-devel&m=110872463928902&w=2
> 
> but the answer I got pointed me toward either a hardware bug from the
> device (dismissed as it works fine on a x86 machine and the bug is
> reproducible with various dongles) or *maybe* a bug in the BT HCI USB
> driver.
> 
> Besides, of all the devices I've been able to test on that machine
> (mice, hubs, mass storage, usbnet...), BT dongles are the *only ones
> failing*, hence my suspecting that the HCI driver is the culprit
> somehow.
> 
> Back to the log I've pasted: I've looked at the hci_usb_rx_complete()
> code, and as the log shows, when the timeout is caught, the urb is
> resubmitted and (as it seems) finaly accepted by the USB subsystem
> ("resubmit status 0"). However, hcitool will timeout anyway:
> 
> # hcitool scan
> Scanning ...
> Inquiry failed: Connection timed out
> 
> I also noticed that "count" remains null for all the fauly urbs, which
> surprised me a bit (wouldn't it grow if data is processed?).
> 
> So my questions are:
> 
> 1) Is that a known bug? (who knows... :-) )

not that I know of.

> 2) Is it possible that I'm hitting some corner case bug in the HCI driver?

Yes, this is maybe possible. The hci_usb driver is not the cleanest one,
but it works quite good for almost every system at the moment.

> 3) Any clue about how to fix this?

The hci_usb driver contains some extra parameters that may can help you.
Try "isoc=0" or "reset=1" and post the content of /proc/bus/usb/devices.

Regards

Marcel




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
