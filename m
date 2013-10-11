Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 4/8] Bluetooth: Remove pointless parameter check in btmrvl_send_frame()
Date: Fri, 11 Oct 2013 07:01:00 -0700
Message-Id: <1381500064-24414-5-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The hdev parameter of btmrvl_send_frame() is always valid. If it were
not valid, then it would have crashed earlier in the call chain.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 drivers/bluetooth/btmrvl_main.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/drivers/bluetooth/btmrvl_main.c b/drivers/bluetooth/btmrvl_main.c
index 547a447..5cf31c4 100644
--- a/drivers/bluetooth/btmrvl_main.c
+++ b/drivers/bluetooth/btmrvl_main.c
@@ -357,17 +357,10 @@ static void btmrvl_free_adapter(struct btmrvl_private *priv)
 
 static int btmrvl_send_frame(struct hci_dev *hdev, struct sk_buff *skb)
 {
-	struct btmrvl_private *priv = NULL;
+	struct btmrvl_private *priv = hci_get_drvdata(hdev);
 
 	BT_DBG("type=%d, len=%d", skb->pkt_type, skb->len);
 
-	if (!hdev) {
-		BT_ERR("Frame for unknown HCI device");
-		return -ENODEV;
-	}
-
-	priv = hci_get_drvdata(hdev);
-
 	if (!test_bit(HCI_RUNNING, &hdev->flags)) {
 		BT_ERR("Failed testing HCI_RUNING, flags=%lx", hdev->flags);
 		print_hex_dump_bytes("data: ", DUMP_PREFIX_OFFSET,
-- 
1.8.3.1

