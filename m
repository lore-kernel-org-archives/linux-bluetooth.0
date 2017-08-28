Return-Path: <ioan.moldovan1999@gmail.com>
To: linux-bluetooth@vger.kernel.org, marcel@holtmann.org
From: Ioan Moldovan <ioan.moldovan1999@gmail.com>
Subject: [PATCH] Add a new 04ca:3015 QCA_ROME device
Message-ID: <63e310ac-c932-2792-da81-b17ad11bb4f9@gmail.com>
Date: Mon, 28 Aug 2017 16:10:47 +0300
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
List-ID: <linux-bluetooth.vger.kernel.org>

This patch adds the 04ca:3015 (from a QCA9377 board) Bluetooth device to 
the btusb blacklist and makes the kernel use the btqca module instead of 
btusb.

This patch is necessary because, without it the 04ca:3015 device 
defaults to using the btusb driver, which makes the WIFI side of the 
QCA9377 board unusable (obtains 0 MBps in speedtest, when the 04ca:3015 
bluetooth is used with an audio headset).

--- btusb.c.orig	2017-08-28 15:46:22.584644604 +0300
+++ btusb.c	2017-08-28 15:48:22.989042129 +0300
@@ -268,6 +268,7 @@ static const struct usb_device_id blackl
  	{ USB_DEVICE(0x0489, 0xe092), .driver_info = BTUSB_QCA_ROME },
  	{ USB_DEVICE(0x0489, 0xe0a2), .driver_info = BTUSB_QCA_ROME },
  	{ USB_DEVICE(0x04ca, 0x3011), .driver_info = BTUSB_QCA_ROME },
+	{ USB_DEVICE(0x04ca, 0x3015), .driver_info = BTUSB_QCA_ROME },

  	/* Broadcom BCM2035 */
  	{ USB_DEVICE(0x0a5c, 0x2009), .driver_info = BTUSB_BCM92035 },


Signed-off-by: Ioan Moldovan <ioan.moldovan1999@gmail.com>
