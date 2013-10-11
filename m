Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 7/8] Bluetooth: Remove pointless parameter check in hci_uart_send_frame()
Date: Fri, 11 Oct 2013 07:01:03 -0700
Message-Id: <1381500064-24414-8-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The hdev parameter of hci_uart_send_frame() is always valid. If it
were not valid, then it would have crashed earlier in the call chain.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 drivers/bluetooth/hci_ldisc.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/drivers/bluetooth/hci_ldisc.c b/drivers/bluetooth/hci_ldisc.c
index b040546..6e06f6f 100644
--- a/drivers/bluetooth/hci_ldisc.c
+++ b/drivers/bluetooth/hci_ldisc.c
@@ -236,18 +236,11 @@ static int hci_uart_close(struct hci_dev *hdev)
 /* Send frames from HCI layer */
 static int hci_uart_send_frame(struct hci_dev *hdev, struct sk_buff *skb)
 {
-	struct hci_uart *hu;
-
-	if (!hdev) {
-		BT_ERR("Frame for unknown device (hdev=NULL)");
-		return -ENODEV;
-	}
+	struct hci_uart *hu = hci_get_drvdata(hdev);
 
 	if (!test_bit(HCI_RUNNING, &hdev->flags))
 		return -EBUSY;
 
-	hu = hci_get_drvdata(hdev);
-
 	BT_DBG("%s: type %d len %d", hdev->name, bt_cb(skb)->pkt_type, skb->len);
 
 	hu->proto->enqueue(hu, skb);
-- 
1.8.3.1

