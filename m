Return-Path: <bluez-devel-admin@lists.sourceforge.net>
From: wim delvaux <wim.delvaux@adaptiveplanet.com>
To: bluez-devel@lists.sourceforge.net
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200404120349.34338.wim.delvaux@adaptiveplanet.com>
Subject: [Bluez-devel] 2.6.5 problems turned to 2.6.3 but also problems
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
Date: Mon, 12 Apr 2004 03:49:34 +0200

Hi all,

I have checked the devel list like greg pointed me out and after applying all 
patches but with no help I turned back to 2.6.3.

However There I get bluetooth errors too.

hci_usb_isoc_rx_submit : hci0 isoc rx submit failed urb cec4e814 err -22

Two times

removing the usb dongle causes a kernel oops

call trace is  (Typed over by hand)

EIP is at uhci_remove_pending_qhs+0x63/0xb8 [uhci_hcd]
...
process : hcid

calltrace :

	uhci_irq+0x90/0x159 [uhci_hcd]
	usb_hcd_irq+0x36/0x67 [usbbcore]
	handle_IRQ_event+0x3a/0x64
	do_IRQ+0x94/0x136
	common_interrupt+0x18/0x20

That means that for I do not know what reason my two systems are completely 
messed up because of usb/bluetooth problems (*** crying tears like rivers 
***)

I tried with 2.4.25/2.4.26-rc2 2.6.3/2.6.5 and mm  and even applied patches on 
bluez download site

Then I can insert my dongle but when I unplug I get A WHOLE LOT of 

'bad atomic while scheduling'
and a call trace with top function schedule

HELP

W


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
