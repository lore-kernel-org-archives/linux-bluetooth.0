Return-Path: <cyrus@holtmann.org>
Message-ID: <BLU436-SMTP489DFA77355813D75F34209EA30@phx.gbl>
From: Xi Ruoyao <xry111@outlook.com>
To: Marcel Holtmann <marcel@holtmann.org>,
	Gustavo Padovan <gustavo@padovan.org>,
	Johan Hedberg <johan.hedberg@gmail.com>
CC: linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Daniel Drake <drake@endlessm.com>,
	Larry Finger <Larry.Finger@lwfinger.net>,
	Xi Ruoyao <xry111@outlook.com>
Subject: [PATCH] Bluetooth: btusb: Add Realtek devices into module device table
Date: Sun, 21 Jun 2015 05:53:45 +0800
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-bluetooth.vger.kernel.org>

In 'commit a2698a9bf9b0 ("Bluetooth: btusb: Add Realtek
8723A/8723B/8761A/8821A support"), support of some Realtek
devices was added to the Generic Bluetooth USB driver in kernel.
However, these devices are not in the module device table of 
btusb.ko, so the kernel wouldn't probe them at all.

To fix this, add four entries in the device table btusb_table,
based on code from <https://github.com/lwfinger/rtl8723au_bt>
('new' branch).

This enables bluetooth support in the Lenovo Ideapad Yoga 13
which has RTL8723AU USB device, with product ID 0bda:1724.

Signed-off-by: Xi Ruoyao <xry111@outlook.com>
---
 drivers/bluetooth/btusb.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 3c10d4d..dd87623 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -148,6 +148,12 @@ static const struct usb_device_id btusb_table[] = {
 	{ USB_DEVICE(0x8087, 0x0a5a),
 	  .driver_info = BTUSB_INTEL_BOOT | BTUSB_BROKEN_ISOC },
 
+	/* Realtek Bluetooth  */
+	{ USB_VENDOR_AND_INTERFACE_INFO(0x0bda, 0xe0, 0x01, 0x01) },
+	{ USB_VENDOR_AND_INTERFACE_INFO(0x0bd5, 0xe0, 0x01, 0x01) },
+	{ USB_VENDOR_AND_INTERFACE_INFO(0x13d3, 0xe0, 0x01, 0x01) },
+	{ USB_VENDOR_AND_INTERFACE_INFO(0x0489, 0xe0, 0x01, 0x01) },
+
 	{ }	/* Terminating entry */
 };
 
-- 
1.9.1
