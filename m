Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 3/4] Bluetooth: Set HCI_QUIRK_INVALID_BADDR for BCM20702A0 default address
Date: Fri,  4 Jul 2014 16:54:39 +0200
Message-Id: <1404485680-1682-3-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

When the Broadcom USB controller has a default address, then set the quirk
so the Bluetooth core knows that controller configuration is required.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 drivers/bluetooth/btusb.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 825f3e16651f..61d8385666e9 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -1624,9 +1624,11 @@ reset_fw:
 	/* The address 00:20:70:02:A0:00 indicates a BCM20702A0 controller
 	 * with no configured address.
 	 */
-	if (!bacmp(&bda->bdaddr, BDADDR_BCM20702A0))
+	if (!bacmp(&bda->bdaddr, BDADDR_BCM20702A0)) {
 		BT_INFO("%s: BCM: using default device address (%pMR)",
 			hdev->name, &bda->bdaddr);
+		set_bit(HCI_QUIRK_INVALID_BDADDR, &hdev->quirks);
+	}
 
 	kfree_skb(skb);
 
-- 
1.9.3

