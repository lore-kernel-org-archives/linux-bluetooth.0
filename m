Return-Path: <nacc@us.ibm.com>
Date: Tue, 8 Feb 2005 22:36:50 -0800
From: Nishanth Aravamudan <nacc@us.ibm.com>
To: marcel@holtmann.org, maxk@qualcomm.com
Cc: bluez-devel@lists.sourceforge.net, greg@kroah.com
Subject: [PATCH 50/63] bluetooth/bfusb: change parameters of usb_{control,bulk}_msg() to msecs
Message-ID: <20050209063650.GU1419@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-ID: <bluez-devel.lists.sourceforge.net>

Hi,

Description: Change units of parameters being passed to
usb_{control,bulk}_msg() to milliseconds. Patch is compile-tested.

Signed-off-by: Nishanth Aravamudan <nacc@us.ibm.com>

--- 2.6.11-rc3-kj-v/drivers/bluetooth/bfusb.c	2005-02-03 16:57:40.000000000 -0800
+++ 2.6.11-rc3-kj/drivers/bluetooth/bfusb.c	2005-02-08 14:15:10.000000000 -0800
@@ -63,7 +63,7 @@ MODULE_DEVICE_TABLE(usb, bfusb_table);
 
 #define BFUSB_MAX_BLOCK_SIZE	256
 
-#define BFUSB_BLOCK_TIMEOUT	(HZ * 3)
+#define BFUSB_BLOCK_TIMEOUT	3000
 
 #define BFUSB_TX_PROCESS	1
 #define BFUSB_TX_WAKEUP		2
@@ -582,7 +582,7 @@ static int bfusb_load_firmware(struct bf
 	pipe = usb_sndctrlpipe(bfusb->udev, 0);
 
 	if (usb_control_msg(bfusb->udev, pipe, USB_REQ_SET_CONFIGURATION,
-				0, 1, 0, NULL, 0, HZ * USB_CTRL_SET_TIMEOUT) < 0) {
+				0, 1, 0, NULL, 0, USB_CTRL_SET_TIMEOUT) < 0) {
 		BT_ERR("Can't change to loading configuration");
 		return -EBUSY;
 	}
@@ -623,7 +623,7 @@ static int bfusb_load_firmware(struct bf
 	pipe = usb_sndctrlpipe(bfusb->udev, 0);
 
         if ((err = usb_control_msg(bfusb->udev, pipe, USB_REQ_SET_CONFIGURATION,
-				0, 2, 0, NULL, 0, HZ * USB_CTRL_SET_TIMEOUT)) < 0) {
+				0, 2, 0, NULL, 0, USB_CTRL_SET_TIMEOUT)) < 0) {
 		BT_ERR("Can't change to running configuration");
 		goto error;
 	}
@@ -641,7 +641,7 @@ error:
 	pipe = usb_sndctrlpipe(bfusb->udev, 0);
 
 	usb_control_msg(bfusb->udev, pipe, USB_REQ_SET_CONFIGURATION,
-				0, 0, 0, NULL, 0, HZ * USB_CTRL_SET_TIMEOUT);
+				0, 0, 0, NULL, 0, USB_CTRL_SET_TIMEOUT);
 
 	return err;
 }
