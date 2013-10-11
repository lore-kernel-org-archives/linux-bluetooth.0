Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/4] Bluetooth: Declare btusb_table[] and blacklist_table[] as const
Date: Fri, 11 Oct 2013 07:46:18 -0700
Message-Id: <1381502781-42826-1-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The btusb_table[] and blacklist_table[] USB device tables can be
declared as const.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 drivers/bluetooth/btusb.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 621069c..30868fa 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -50,7 +50,7 @@ static struct usb_driver btusb_driver;
 #define BTUSB_ATH3012		0x80
 #define BTUSB_INTEL		0x100
 
-static struct usb_device_id btusb_table[] = {
+static const struct usb_device_id btusb_table[] = {
 	/* Generic Bluetooth USB device */
 	{ USB_DEVICE_INFO(0xe0, 0x01, 0x01) },
 
@@ -121,7 +121,7 @@ static struct usb_device_id btusb_table[] = {
 
 MODULE_DEVICE_TABLE(usb, btusb_table);
 
-static struct usb_device_id blacklist_table[] = {
+static const struct usb_device_id blacklist_table[] = {
 	/* CSR BlueCore devices */
 	{ USB_DEVICE(0x0a12, 0x0001), .driver_info = BTUSB_CSR },
 
-- 
1.8.3.1

