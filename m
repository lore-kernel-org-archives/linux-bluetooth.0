Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <403FD968.6010004@superbug.demon.co.uk>
From: James Courtier-Dutton <James@superbug.demon.co.uk>
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
Content-Type: multipart/mixed;
 boundary="------------000908050406020005050508"
Subject: [Bluez-devel] [PATCH] Fix to enable bluez SCO USB urbs.
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
Date: Fri, 27 Feb 2004 23:57:28 +0000

This is a multi-part message in MIME format.
--------------000908050406020005050508
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Here is a patch for /usr/src/linux-2.6.3/drivers/bluetooth/hci_usb.c

Without the interval set, the latest kernel 2.6.3 usb code will reject 
the usb_submit_urb().

Without this patch no ISOC urbs are submitted, and thus no SCO data is 
passed.

The proper fix would really be to only enable these when a SCO 
connection is actually open.

Cheers
James

--------------000908050406020005050508
Content-Type: text/x-patch;
 name="sco-patch.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="sco-patch.diff"

--- hci_usb.c.org	2004-02-26 20:36:06.000000000 +0000
+++ hci_usb.c	2004-02-27 23:49:08.273537136 +0000
@@ -263,6 +263,7 @@
 
 	urb->context  = husb;
 	urb->dev      = husb->udev;
+	urb->interval = husb->isoc_in_ep->desc.bInterval;
 	urb->pipe     = usb_rcvisocpipe(husb->udev, husb->isoc_in_ep->desc.bEndpointAddress);
 	urb->complete = hci_usb_rx_complete;
 
@@ -490,6 +491,7 @@
 	
 	urb->context  = husb;
 	urb->dev      = husb->udev;
+	urb->interval = husb->isoc_out_ep->desc.bInterval;
 	urb->pipe     = usb_sndisocpipe(husb->udev, husb->isoc_out_ep->desc.bEndpointAddress);
 	urb->complete = hci_usb_tx_complete;
 	urb->transfer_flags = URB_ISO_ASAP;

--------------000908050406020005050508--


-------------------------------------------------------
SF.Net is sponsored by: Speed Start Your Linux Apps Now.
Build and deploy apps & Web services for Linux with
a free DVD software kit from IBM. Click Now!
http://ads.osdn.com/?ad_id=1356&alloc_id=3438&op=click
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
