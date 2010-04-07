Return-Path: <cyrus@holtmann.org>
Date: Wed, 7 Apr 2010 15:53:58 +0300
From: "Kim B. Heino" <Kim.Heino@bluegiga.com>
To: linux-bluetooth@vger.kernel.org, marcel@holtmann.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH] btusb: Raw mode and ACL/SCO data
Message-ID: <20100407155358.083823f9@bluegiga.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-ID: <linux-bluetooth.vger.kernel.org>

This patch allows sending ACL/SCO packets if device is in RAW mode.
Previously only command packets were allowed.

Signed-off-by: Kim B. Heino <Kim.Heino@bluegiga.com>


diff -ur orig/drivers/bluetooth/btusb.c linux-2.6.33.2/drivers/bluetooth/btusb.c
--- orig/drivers/bluetooth/btusb.c	2010-04-02 02:02:33.000000000 +0300
+++ linux-2.6.33.2/drivers/bluetooth/btusb.c	2010-04-07 15:17:55.696672710 +0300
@@ -663,7 +663,9 @@
 		break;
 
 	case HCI_ACLDATA_PKT:
-		if (!data->bulk_tx_ep || hdev->conn_hash.acl_num < 1)
+		if (!data->bulk_tx_ep ||
+		    (!test_bit(HCI_RAW, &hdev->flags) &&
+		     hdev->conn_hash.acl_num < 1))
 			return -ENODEV;
 
 		urb = usb_alloc_urb(0, GFP_ATOMIC);
@@ -680,7 +682,9 @@
 		break;
 
 	case HCI_SCODATA_PKT:
-		if (!data->isoc_tx_ep || hdev->conn_hash.sco_num < 1)
+		if (!data->isoc_tx_ep ||
+		    (!test_bit(HCI_RAW, &hdev->flags) &&
+		     hdev->conn_hash.sco_num < 1))
 			return -ENODEV;
 
 		urb = usb_alloc_urb(BTUSB_MAX_ISOC_FRAMES, GFP_ATOMIC);
