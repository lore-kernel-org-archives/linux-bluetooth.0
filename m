Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 6/8] Bluetooth: Remove pointless parameter check in dtl1_hci_send_frame()
Date: Fri, 11 Oct 2013 07:01:02 -0700
Message-Id: <1381500064-24414-7-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The hdev parameter of dtl1_hci_send_frame() is always valid. If it
were not valid, then it would have crashed earlier in the call chain.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 drivers/bluetooth/dtl1_cs.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/drivers/bluetooth/dtl1_cs.c b/drivers/bluetooth/dtl1_cs.c
index ad1a2f9..52eed1f 100644
--- a/drivers/bluetooth/dtl1_cs.c
+++ b/drivers/bluetooth/dtl1_cs.c
@@ -384,17 +384,10 @@ static int dtl1_hci_close(struct hci_dev *hdev)
 
 static int dtl1_hci_send_frame(struct hci_dev *hdev, struct sk_buff *skb)
 {
-	dtl1_info_t *info;
+	dtl1_info_t *info = hci_get_drvdata(hdev);
 	struct sk_buff *s;
 	nsh_t nsh;
 
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

