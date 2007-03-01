Return-Path: <cebbert@redhat.com>
Message-ID: <45E6F530.6000503@redhat.com>
Date: Thu, 01 Mar 2007 10:45:52 -0500
From: Chuck Ebbert <cebbert@redhat.com>
MIME-Version: 1.0
To: Marcel Holtmann <marcel@holtmann.org>
CC: bluez-devel@lists.sourceforge.net
Subject: bluetooth: Another blacklisted device (based on BCM2035)
Content-Type: multipart/mixed;
 boundary="------------050505010306040501080800"
List-ID: <bluez-devel.lists.sourceforge.net>

This is a multi-part message in MIME format.
--------------050505010306040501080800
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit


--------------050505010306040501080800
Content-Type: text/plain;
 name="linux-2.6-20_bluetooth_broadcom_quirk.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="linux-2.6-20_bluetooth_broadcom_quirk.patch"

From: Andy Shevchenko <andy@smile.org.ua>
Yet another blacklisted Bluetooth device (based on BCM2035)

Signed-off-by: Andy Shevchenko <andy@smile.org.ua>

--- a/drivers/bluetooth/hci_usb.c
+++ b/drivers/bluetooth/hci_usb.c
@@ -111,6 +111,7 @@ static struct usb_device_id blacklist_ids[] = {
 	{ USB_DEVICE(0x0a5c, 0x2033), .driver_info = HCI_IGNORE },
 
 	/* Broadcom BCM2035 */
+	{ USB_DEVICE(0x0a5c, 0x2035), .driver_info = HCI_RESET | HCI_WRONG_SCO_MTU },
 	{ USB_DEVICE(0x0a5c, 0x200a), .driver_info = HCI_RESET | HCI_WRONG_SCO_MTU },
 	{ USB_DEVICE(0x0a5c, 0x2009), .driver_info = HCI_BCM92035 },
 

--------------050505010306040501080800--
