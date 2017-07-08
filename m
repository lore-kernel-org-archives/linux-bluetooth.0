Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Leif Liddy <leif.linux@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Leif Liddy <leif.linux@gmail.com>
Subject: [RFC PATCH v2] Bluetooth: btusb: fix QCA Rome suspend/resume
Date: Sat,  8 Jul 2017 20:55:32 +0200
Message-Id: <20170708185532.26785-1-leif.linux@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

**update: sent with 'git send-email'

There's been numerous reported instances where BTUSB_QCA_ROME
bluetooth controllers stop functioning upon resume from suspend. These
devices seem to be losing power during suspend. Patch will detect a status
change on resume and perform a reset.

Signed-off-by: Leif Liddy <leif.linux@gmail.com>
---
 drivers/bluetooth/btusb.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index fa24d69..0804a52 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -3067,6 +3067,11 @@ static int btusb_probe(struct usb_interface *intf,
 	if (id->driver_info & BTUSB_QCA_ROME) {
 		data->setup_on_usb = btusb_setup_qca;
 		hdev->set_bdaddr = btusb_set_bdaddr_ath3012;
+		/* QCA Rome devices lose their updated firmware over suspend,
+		 * but the USB hub doesn't notice any status change.
+		 * Explicitly request a device reset on resume.
+		 */
+		set_bit(BTUSB_RESET_RESUME, &data->flags);
 	}
 
 #ifdef CONFIG_BT_HCIBTUSB_RTL
-- 
2.9.4

