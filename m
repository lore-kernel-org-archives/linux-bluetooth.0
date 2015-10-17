Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 2/3] Bluetooth: btintel: Set quirk for non-persistent diagnostic settings
Date: Sat, 17 Oct 2015 16:00:27 +0200
Message-Id: <1445090428-75287-2-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

For Intel controllers the diagnostics settings are not persistent over
HCI Reset. So set the quirk to programm them again on every power up.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 drivers/bluetooth/btintel.c | 5 ++---
 drivers/bluetooth/btusb.c   | 1 +
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/bluetooth/btintel.c b/drivers/bluetooth/btintel.c
index 95652aa12454..8d4891725e3b 100644
--- a/drivers/bluetooth/btintel.c
+++ b/drivers/bluetooth/btintel.c
@@ -97,9 +97,6 @@ int btintel_set_diag(struct hci_dev *hdev, bool enable)
 	u8 param[3];
 	int err;
 
-	if (!test_bit(HCI_RUNNING, &hdev->flags))
-		return -ENETDOWN;
-
 	if (enable) {
 		param[0] = 0x03;
 		param[1] = 0x03;
@@ -113,6 +110,8 @@ int btintel_set_diag(struct hci_dev *hdev, bool enable)
 	skb = __hci_cmd_sync(hdev, 0xfc43, 3, param, HCI_INIT_TIMEOUT);
 	if (IS_ERR(skb)) {
 		err = PTR_ERR(skb);
+		if (err == -ENODATA)
+			return 0;
 		BT_ERR("%s: Changing Intel diagnostic mode failed (%d)",
 		       hdev->name, err);
 		return err;
diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
index 27830da67063..ab82c02d7e92 100644
--- a/drivers/bluetooth/btusb.c
+++ b/drivers/bluetooth/btusb.c
@@ -2894,6 +2894,7 @@ static int btusb_probe(struct usb_interface *intf,
 		hdev->set_diag = btintel_set_diag;
 		hdev->set_bdaddr = btintel_set_bdaddr;
 		set_bit(HCI_QUIRK_STRICT_DUPLICATE_FILTER, &hdev->quirks);
+		set_bit(HCI_QUIRK_NON_PERSISTENT_DIAG, &hdev->quirks);
 	}
 
 	if (id->driver_info & BTUSB_MARVELL)
-- 
2.4.3

