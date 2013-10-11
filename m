Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 8/8] Bluetooth: Remove pointless parameter check in vhci_send_frame()
Date: Fri, 11 Oct 2013 07:01:04 -0700
Message-Id: <1381500064-24414-9-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The hdev parameter of vhci_send_frame() is always valid. If it were
not valid, then it would have crashed earlier in the call chain.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 drivers/bluetooth/hci_vhci.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/drivers/bluetooth/hci_vhci.c b/drivers/bluetooth/hci_vhci.c
index e6f5919..7b16738 100644
--- a/drivers/bluetooth/hci_vhci.c
+++ b/drivers/bluetooth/hci_vhci.c
@@ -83,18 +83,11 @@ static int vhci_flush(struct hci_dev *hdev)
 
 static int vhci_send_frame(struct hci_dev *hdev, struct sk_buff *skb)
 {
-	struct vhci_data *data;
-
-	if (!hdev) {
-		BT_ERR("Frame for unknown HCI device (hdev=NULL)");
-		return -ENODEV;
-	}
+	struct vhci_data *data = hci_get_drvdata(hdev);
 
 	if (!test_bit(HCI_RUNNING, &hdev->flags))
 		return -EBUSY;
 
-	data = hci_get_drvdata(hdev);
-
 	memcpy(skb_push(skb, 1), &bt_cb(skb)->pkt_type, 1);
 	skb_queue_tail(&data->readq, skb);
 
-- 
1.8.3.1

