Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 5/8] Bluetooth: Remove pointless parameter check in btuart_hci_send_frame()
Date: Fri, 11 Oct 2013 07:01:01 -0700
Message-Id: <1381500064-24414-6-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The hdev parameter of btuart_hci_send_frame() is always valid. If it
were not valid, then it would have crashed earlier in the call chain.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 drivers/bluetooth/btuart_cs.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/drivers/bluetooth/btuart_cs.c b/drivers/bluetooth/btuart_cs.c
index f567cd8..a03ecc2 100644
--- a/drivers/bluetooth/btuart_cs.c
+++ b/drivers/bluetooth/btuart_cs.c
@@ -425,14 +425,7 @@ static int btuart_hci_close(struct hci_dev *hdev)
 
 static int btuart_hci_send_frame(struct hci_dev *hdev, struct sk_buff *skb)
 {
-	btuart_info_t *info;
-
-	if (!hdev) {
-		BT_ERR("Frame for unknown HCI device (hdev=NULL)");
-		return -ENODEV;
-	}
-
-	info = hci_get_drvdata(hdev);
+	btuart_info_t *info = hci_get_drvdata(hdev);
 
 	switch (bt_cb(skb)->pkt_type) {
 	case HCI_COMMAND_PKT:
-- 
1.8.3.1

