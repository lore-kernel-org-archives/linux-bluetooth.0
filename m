Return-Path: <cyrus@holtmann.org>
Date: Sat, 10 Jan 2015 22:40:04 +0100
From: Reinhard Speyerer <rspmn@arcor.de>
To: linux-bluetooth@vger.kernel.org
Cc: Reinhard Speyerer <rspmn@arcor.de>
Subject: [RFC] make Belkin F8T013 devices work again by adding
 BTUSB_BROKEN_STORED_LINK_KEY flag
Message-ID: <54b19c34.HFakUiNRADxA91CC0vhvfVD1@arcor.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi,

when trying to use a Belkin F8T013 Bluetooth adapter with Knoppix 7.4.2 (which
uses BlueZ 5.21 and Linux kernel 3.16.3) I noticed that it could no longer be
initialized correctly (hciconfig state DOWN). This adapter used to work with
Knoppix 6.7.1 (which uses BlueZ 4.96 and Linux kernel 3.0.4).

When looking at the corresponding btmon log it can be seen that initialization
fails at

< HCI Command: Delete Stored Link Key (0x03|0x0012) plen 7     [hci0] 1.041907
        Address: 00:00:00:00:00:00 (OUI 00-00-00)
        Delete all: 0x01
> HCI Event: Command Complete (0x0e) plen 4                    [hci0] 1.045129
      Delete Stored Link Key (0x03|0x0012) ncmd 1
        Status: Unsupported Feature or Parameter Value (0x11)

although it claims to support Delete Stored Link Key according to the Read
Local Supported Commands output.

Adding a BTUSB_BROKEN_STORED_LINK_KEY flag for the Belkin F8T013 adapter which
sets the HCI_QUIRK_BROKEN_STORED_LINK_KEY quirk in btusb_probe made the
adapter work again for me:

# hciconfig -a
hci0:	Type: BR/EDR  Bus: USB
	BD Address: <BDADDR>  ACL MTU: 1017:8  SCO MTU: 64:8
	UP RUNNING 
	RX bytes:1034 acl:0 sco:0 events:25 errors:0
	TX bytes:90 acl:0 sco:0 commands:25 errors:0
	Features: 0xff 0xfb 0x8d 0xfe 0x9f 0xf9 0x00 0x80
	Packet type: DM1 DM3 DM5 DH1 DH3 DH5 HV1 HV2 HV3 
	Link policy: RSWITCH HOLD SNIFF PARK 
	Link mode: SLAVE ACCEPT 
	Name: 'Belkin Bluetooth Device'
	Class: 0x000000
	Service Classes: Unspecified
	Device Class: Miscellaneous, 
	HCI Version: 2.0 (0x3)  Revision: 0x2073
	LMP Version: 2.0 (0x3)  Subversion: 0x410e
	Manufacturer: Broadcom Corporation (15)

# hciconfig hci0 revision
hci0:	Type: BR/EDR  Bus: USB
	BD Address: <BDADDR>  ACL MTU: 1017:8  SCO MTU: 64:8
	Firmware 115.65 / 14

Please tell me whether the patch below would be acceptable to make this
Bluetooth adapter work again with Linux. If yes on which Linux kernel version
should it be based to take the current BTUSB_* flag list into account?

Regards,
Reinhard

--- drivers/bluetooth/btusb.c-std	2014-08-04 00:25:02.000000000 +0200
+++ drivers/bluetooth/btusb.c	2015-01-10 21:34:17.838942903 +0100
@@ -50,6 +50,7 @@ static struct usb_driver btusb_driver;
 #define BTUSB_ATH3012		0x80
 #define BTUSB_INTEL		0x100
 #define BTUSB_BCM_PATCHRAM	0x200
+#define BTUSB_BROKEN_STORED_LINK_KEY	0x400
 
 static const struct usb_device_id btusb_table[] = {
 	/* Generic Bluetooth USB device */
@@ -208,7 +209,8 @@ static const struct usb_device_id blackl
 
 	/* Belkin F8T012 and F8T013 devices */
 	{ USB_DEVICE(0x050d, 0x0012), .driver_info = BTUSB_WRONG_SCO_MTU },
-	{ USB_DEVICE(0x050d, 0x0013), .driver_info = BTUSB_WRONG_SCO_MTU },
+	{ USB_DEVICE(0x050d, 0x0013),
+	  .driver_info = BTUSB_WRONG_SCO_MTU | BTUSB_BROKEN_STORED_LINK_KEY },
 
 	/* Asus WL-BTD202 device */
 	{ USB_DEVICE(0x0b05, 0x1715), .driver_info = BTUSB_WRONG_SCO_MTU },
@@ -1655,6 +1657,10 @@ static int btusb_probe(struct usb_interf
 	if (id->driver_info & BTUSB_BROKEN_ISOC)
 		data->isoc = NULL;
 
+	if (id->driver_info & BTUSB_BROKEN_STORED_LINK_KEY) {
+		set_bit(HCI_QUIRK_BROKEN_STORED_LINK_KEY, &hdev->quirks);
+	}
+
 	if (id->driver_info & BTUSB_DIGIANSWER) {
 		data->cmdreq_type = USB_TYPE_VENDOR;
 		set_bit(HCI_QUIRK_RESET_ON_CLOSE, &hdev->quirks);
