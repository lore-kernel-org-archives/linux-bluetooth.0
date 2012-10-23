Return-Path: <cyrus@holtmann.org>
Message-ID: <1350995487.13036.YahooMailNeo@web125402.mail.ne1.yahoo.com>
Date: Tue, 23 Oct 2012 05:31:27 -0700 (PDT)
From: Dwaine Garden VE3GIF <dwainegarden@rogers.com>
Reply-To: Dwaine Garden VE3GIF <dwainegarden@rogers.com>
Subject: [PATCH] Bluetooth: Add support for Atheros [04ca:3004] 
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>



Add another vendor specific ID for Atheros AR3012 device.
This chip is wrapped by Lite-On Technology Corp.

output of usb-devices:
Bus 001 Device 008: ID 04ca:3004 Lite-On Technology Corp. 
Device Descriptor:
  bLength                18

bDescriptorType         1
  bcdUSB               1.10
  bDeviceClass          224 Wireless
  bDeviceSubClass         1 Radio Frequency
  bDeviceProtocol         1 Bluetooth
  bMaxPacketSize0        64
  idVendor           0x04ca Lite-On Technology Corp.
  idProduct          0x3004 
  bcdDevice            0.02
  iManufacturer           1 Atheros Communications

iProduct                2 Bluetooth USB Host Controller
  iSerial                 3 Alaska Day 2006
  bNumConfigurations      1


Signed-off-by: Dwaine Garden <DwaineGarden@rogers.com>  ---

diff --git a/drivers/bluetooth/ath3k.c b/drivers/bluetooth/ath3k.c
index fc2de55..1486f15 100644
--- a/drivers/bluetooth/ath3k.c
+++ b/drivers/bluetooth/ath3k.c
@@ -75,6 +75,7 @@ static struct usb_device_id ath3k_table[] = {
{ USB_DEVICE(0x0CF3, 0x3004) },
{ USB_DEVICE(0x0CF3, 0x311D) },
{ USB_DEVICE(0x13d3, 0x3375) },
+    { USB_DEVICE(0x04CA, 0x3004) },
{ USB_DEVICE(0x04CA, 0x3005) },
{ USB_DEVICE(0x13d3, 0x3362) },
{ USB_DEVICE(0x0CF3, 0xE004) },
@@ -102,6 +103,7 @@ static struct usb_device_id ath3k_blist_tbl[] = {
{ USB_DEVICE(0x0cf3, 0x3004), .driver_info = BTUSB_ATH3012 },
{ USB_DEVICE(0x0cf3, 0x311D), .driver_info = BTUSB_ATH3012 },
{ USB_DEVICE(0x13d3, 0x3375), .driver_info = BTUSB_ATH3012 },
+    { USB_DEVICE(0x04ca, 0x3004), .driver_info = BTUSB_ATH3012 },
{ USB_DEVICE(0x04ca, 0x3005), .driver_info =
BTUSB_ATH3012 },
{
USB_DEVICE(0x13d3, 0x3362), .driver_info = BTUSB_ATH3012 },
{ USB_DEVICE(0x0cf3, 0xe004), .driver_info = BTUSB_ATH3012 },
diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index debda27..0529cee 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -132,6 +132,7 @@ static struct usb_device_id blacklist_table[] = {
{ USB_DEVICE(0x0cf3, 0x3004), .driver_info = BTUSB_ATH3012 },
{ USB_DEVICE(0x0cf3, 0x311d), .driver_info = BTUSB_ATH3012 },
{ USB_DEVICE(0x13d3, 0x3375), .driver_info = BTUSB_ATH3012 },
+    { USB_DEVICE(0x04ca, 0x3004), .driver_info = BTUSB_ATH3012 },
{ USB_DEVICE(0x04ca, 0x3005), .driver_info = BTUSB_ATH3012 },
{ USB_DEVICE(0x13d3, 0x3362), .driver_info = BTUSB_ATH3012 },
{ USB_DEVICE(0x0cf3, 0xe004), .driver_info = BTUSB_ATH3012 },  
