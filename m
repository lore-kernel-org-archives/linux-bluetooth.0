Return-Path: <bluez-devel-admin@lists.sourceforge.net>
To: bluez-devel@lists.sourceforge.net
From: Jonathan Paisley <jp-www@dcs.gla.ac.uk>
Message-ID: <pan.2003.07.20.14.33.03.324941@dcs.gla.ac.uk>
References: <E19a5DI-0002jL-00@sc8-sf-list2.sourceforge.net>
	<3F1752C5.5020701@dsto.defence.gov.au>
	<3F17E4EF.5060401@superbug.demon.co.uk>
	<1058533496.25379.237.camel@pegasus> <3F17FD1A.9050003@superbug.demon.co.uk>
Mime-Version: 1.0
Subject: [Bluez-devel] Re: Re: Bluetooth headset with Bluetooth usb dongle
	status.
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
Date: Sun, 20 Jul 2003 15:33:10 +0100
Content-Type: text/plain; CHARSET=ISO-8859-1

On Fri, 18 Jul 2003 14:58:50 +0100, James Courtier-Dutton wrote:

>>>The playback problem is a scheduling problem. The "hci_usb_tx_complete"
>>>function uses the scheduler to kick off the next transmission, but the
>>>scheduler is too slow, and the correct method to use is getting the
>>>"hci_usb_tx_complete" function to retrieve the next packet to send from
>>>a ring buffer, and send it immeadiately during the"hci_usb_tx_complete"

I think this happens anyway:

	hci_usb_tx_complete() calls
	hci_usb_tx_wakeup() which calls
	hci_usb_tx_process() which calls
	hci_usb_send_isoc() which calls
	__tx_submit() which calls
	usb_submit_urb()

Thus, if there is a new packet queued when the old one completes, the new
one will be sent immediately.

I have managed to get playback and recording (with the PC acting as a
headset for my phone) to work well. I've made the following changes which
are included in the patch at the end:

	(1) submit two rx urbs (same as your proposed patch, but done at caller)
	(2) allow two pending isoc urbs instead of one
	(3) only use the 9 byte (single voice channel) isoc endpoint

Please let me know if you're able to reproduce this at your end.

Thanks.

diff -ur --exclude='.*' drivers/bluetooth.orig/hci_usb.c drivers/bluetooth/hci_usb.c
--- drivers/bluetooth.orig/hci_usb.c	2003-07-20 15:25:49.000000000 +0100
+++ drivers/bluetooth/hci_usb.c	2003-07-20 15:19:20.000000000 +0100
@@ -302,6 +302,7 @@
 
 #ifdef CONFIG_BLUEZ_USB_SCO
 		if (husb->isoc_iface)
+		    for (i = 0; i < HCI_MAX_ISOC_RX; i++)
 			hci_usb_isoc_rx_submit(husb);
 #endif
 	} else {
@@ -522,7 +523,7 @@
 #ifdef CONFIG_BLUEZ_USB_SCO
 		/* Process SCO queue */
 		q = __transmit_q(husb, HCI_SCODATA_PKT);
-		if (!atomic_read(__pending_tx(husb, HCI_SCODATA_PKT)) &&
+		if (atomic_read(__pending_tx(husb, HCI_SCODATA_PKT)) < HCI_MAX_ISOC_TX &&
 				(skb = skb_dequeue(q))) {
 			if (hci_usb_send_isoc(husb, skb) < 0)
 				skb_queue_head(q, skb);
@@ -830,7 +831,7 @@
 
 #ifdef CONFIG_BLUEZ_USB_SCO
 				case USB_ENDPOINT_XFER_ISOC:
-					if (ep->wMaxPacketSize < size)
+					if (ep->wMaxPacketSize != 9)
 						break;
 					size = ep->wMaxPacketSize;
 
Only in drivers/bluetooth: hci_usb.c.orig
diff -ur --exclude='.*' drivers/bluetooth.orig/hci_usb.h drivers/bluetooth/hci_usb.h
--- drivers/bluetooth.orig/hci_usb.h	2003-07-20 15:25:49.000000000 +0100
+++ drivers/bluetooth/hci_usb.h	2003-07-20 14:20:43.000000000 +0100
@@ -41,6 +41,9 @@
 #define HCI_MAX_BULK_TX     	4
 #define HCI_MAX_BULK_RX     	1
 
+#define HCI_MAX_ISOC_RX     	2
+#define HCI_MAX_ISOC_TX     	2
+
 #define HCI_MAX_ISOC_FRAMES     10
 
 struct _urb_queue {



-------------------------------------------------------
This SF.net email is sponsored by: VM Ware
With VMware you can run multiple operating systems on a single machine.
WITHOUT REBOOTING! Mix Linux / Windows / Novell virtual machines at the
same time. Free trial click here: http://www.vmware.com/wl/offer/345/0
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
