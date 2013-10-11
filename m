Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 3/8] Bluetooth: Remove pointless parameter check in bt3c_hci_send_frame()
Date: Fri, 11 Oct 2013 07:00:59 -0700
Message-Id: <1381500064-24414-4-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The hdev parameter of bt3c_hci_send_frame() is always valid. If it
were not valid, then it would have crashed earlier in the call chain.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 drivers/bluetooth/bt3c_cs.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/drivers/bluetooth/bt3c_cs.c b/drivers/bluetooth/bt3c_cs.c
index fcd5fe9..73d8799 100644
--- a/drivers/bluetooth/bt3c_cs.c
+++ b/drivers/bluetooth/bt3c_cs.c
@@ -417,16 +417,9 @@ static int bt3c_hci_close(struct hci_dev *hdev)
 
 static int bt3c_hci_send_frame(struct hci_dev *hdev, struct sk_buff *skb)
 {
-	bt3c_info_t *info;
+	bt3c_info_t *info = hci_get_drvdata(hdev);
 	unsigned long flags;
 
-	if (!hdev) {
-		BT_ERR("Frame for unknown HCI device (hdev=NULL)");
-		return -ENODEV;
-	}
-
-	info = hci_get_drvdata(hdev);
-
 	switch (bt_cb(skb)->pkt_type) {
 	case HCI_COMMAND_PKT:
 		hdev->stat.cmd_tx++;
-- 
1.8.3.1

