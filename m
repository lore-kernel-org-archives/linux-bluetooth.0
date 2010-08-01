Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
From: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
Date: Mon, 2 Aug 2010 06:23:22 +0900
Message-ID: <AANLkTimcf8nmrad8BP8aLw4OefAr1vNZANNRf7rPMrrG@mail.gmail.com>
Subject: [PATCH] bluetooth: Add support Bluetooth controller of Macbook Pro
	6,2 and 7,1
To: linux-bluetooth@vger.kernel.org
Cc: stable@kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Bluetooth controller of Macbook Pro 6,2 and 7,1 does not work.
Because Device Class of these controllers was set 255 (Vendor Sepecific Class).

Macbook Pro 7,1 :
Bus 004 Device 005: ID 05ac:8213 Apple, Inc.
Device Descriptor:
  bLength                18
  bDescriptorType         1
  bcdUSB               2.00
  bDeviceClass          255 Vendor Specific Class
  bDeviceSubClass         1
  bDeviceProtocol         1
  bMaxPacketSize0        64
  idVendor           0x05ac Apple, Inc.
  idProduct          0x8213
  bcdDevice            1.86
  iManufacturer           1 Apple Inc.
  iProduct                2 Bluetooth USB Host Controller
  iSerial                 3 5C5948C81B99
  bNumConfigurations      1

Signed-off-by: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>
---
 drivers/bluetooth/btusb.c |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 5d9cc53..00a6639 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -75,6 +75,12 @@ static struct usb_device_id btusb_table[] = {
 	/* Canyon CN-BTU1 with HID interfaces */
 	{ USB_DEVICE(0x0c10, 0x0000) },

+	/* Apple MacBookPro 6,2 */
+	{ USB_DEVICE(0x05ac, 0x8218) },
+
+	/* Apple MacBookPro 7,2 */
+	{ USB_DEVICE(0x05ac, 0x8213) },
+
 	{ }	/* Terminating entry */
 };

-- 
1.7.1
