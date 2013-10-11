Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/8] Bluetooth: Remove pointless parameter check in bfusb_send_frame()
Date: Fri, 11 Oct 2013 07:00:57 -0700
Message-Id: <1381500064-24414-2-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The hdev parameter of bfusb_send_frame() is always valid. If it were
not valid, then it would have crashed earlier in the call chain.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 drivers/bluetooth/bfusb.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/drivers/bluetooth/bfusb.c b/drivers/bluetooth/bfusb.c
index a675849..cce2304 100644
--- a/drivers/bluetooth/bfusb.c
+++ b/drivers/bluetooth/bfusb.c
@@ -466,23 +466,16 @@ static int bfusb_close(struct hci_dev *hdev)
 
 static int bfusb_send_frame(struct hci_dev *hdev, struct sk_buff *skb)
 {
-	struct bfusb_data *data;
+	struct bfusb_data *data = hci_get_drvdata(hdev);
 	struct sk_buff *nskb;
 	unsigned char buf[3];
 	int sent = 0, size, count;
 
 	BT_DBG("hdev %p skb %p type %d len %d", hdev, skb, bt_cb(skb)->pkt_type, skb->len);
 
-	if (!hdev) {
-		BT_ERR("Frame for unknown HCI device (hdev=NULL)");
-		return -ENODEV;
-	}
-
 	if (!test_bit(HCI_RUNNING, &hdev->flags))
 		return -EBUSY;
 
-	data = hci_get_drvdata(hdev);
-
 	switch (bt_cb(skb)->pkt_type) {
 	case HCI_COMMAND_PKT:
 		hdev->stat.cmd_tx++;
-- 
1.8.3.1

