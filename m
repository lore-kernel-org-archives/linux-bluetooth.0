Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/4] Bluetooth: hci_uart: Use h4_recv_buf helper for H:4 protocol
Date: Sat,  4 Apr 2015 21:59:25 -0700
Message-Id: <1428209967-20757-2-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Instead of using hci_recv_stream_fragment, use the local available
h4_recv_buf helper function.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 drivers/bluetooth/hci_h4.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/drivers/bluetooth/hci_h4.c b/drivers/bluetooth/hci_h4.c
index 09270bc26654..d8414540f743 100644
--- a/drivers/bluetooth/hci_h4.c
+++ b/drivers/bluetooth/hci_h4.c
@@ -49,6 +49,7 @@
 #define VERSION "1.2"
 
 struct h4_struct {
+	struct sk_buff *rx_skb;
 	struct sk_buff_head txq;
 };
 
@@ -92,6 +93,8 @@ static int h4_close(struct hci_uart *hu)
 
 	skb_queue_purge(&h4->txq);
 
+	kfree_skb(h4->rx_skb);
+
 	hu->priv = NULL;
 	kfree(h4);
 
@@ -115,15 +118,16 @@ static int h4_enqueue(struct hci_uart *hu, struct sk_buff *skb)
 /* Recv data */
 static int h4_recv(struct hci_uart *hu, const void *data, int count)
 {
-	int ret;
+	struct h4_struct *h4 = hu->priv;
 
 	if (!test_bit(HCI_UART_REGISTERED, &hu->flags))
 		return -EUNATCH;
 
-	ret = hci_recv_stream_fragment(hu->hdev, data, count);
-	if (ret < 0) {
-		BT_ERR("Frame Reassembly Failed");
-		return ret;
+	h4->rx_skb = h4_recv_buf(hu->hdev, h4->rx_skb, data, count);
+	if (IS_ERR(h4->rx_skb)) {
+		int err = PTR_ERR(h4->rx_skb);
+		BT_ERR("%s: Frame reassembly failed (%d)", hu->hdev->name, err);
+		return err;
 	}
 
 	return count;
-- 
2.1.0

