Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/4] Bluetooth: Set HCI_QUIRK_INVALID_BADDR for Intel USB default address
Date: Fri,  4 Jul 2014 16:54:38 +0200
Message-Id: <1404485680-1682-2-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

When the Intel USB controller has a default address, then set the quirk
so the Bluetooth core knows that controller configuration is required.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 drivers/bluetooth/btusb.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 3244e311ca29..825f3e16651f 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -1216,9 +1216,11 @@ static int btusb_check_bdaddr_intel(struct hci_dev *hdev)
 	 * fully operational, but have the danger of duplicate addresses
 	 * and that in turn can cause problems with Bluetooth operation.
 	 */
-	if (!bacmp(&rp->bdaddr, BDADDR_INTEL))
+	if (!bacmp(&rp->bdaddr, BDADDR_INTEL)) {
 		BT_ERR("%s found Intel default device address (%pMR)",
 		       hdev->name, &rp->bdaddr);
+		set_bit(HCI_QUIRK_INVALID_BDADDR, &hdev->quirks);
+	}
 
 	kfree_skb(skb);
 
-- 
1.9.3

