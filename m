Return-Path: <cyrus@holtmann.org>
From: Chan-yeol Park <chanyeol.park@samsung.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 2/2] Bluetooth: hci_uart: Fix dereferencing of ERR_PTR
Date: Wed, 17 Jun 2015 13:59:09 +0900
Message-id: <1434517149-1728-2-git-send-email-chanyeol.park@samsung.com>
In-reply-to: <1434517149-1728-1-git-send-email-chanyeol.park@samsung.com>
References: <1434517149-1728-1-git-send-email-chanyeol.park@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

If h4_recv_buff() return ERR_PTR, h4->rx_skb should not be dereferenced.

Signed-off-by: Chan-yeol Park <chanyeol.park@samsung.com>
---
 drivers/bluetooth/hci_h4.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/bluetooth/hci_h4.c b/drivers/bluetooth/hci_h4.c
index f7190f0..54116464 100644
--- a/drivers/bluetooth/hci_h4.c
+++ b/drivers/bluetooth/hci_h4.c
@@ -92,7 +92,8 @@ static int h4_close(struct hci_uart *hu)
 
 	skb_queue_purge(&h4->txq);
 
-	kfree_skb(h4->rx_skb);
+	if (!IS_ERR(h4->rx_skb))
+		kfree_skb(h4->rx_skb);
 
 	hu->priv = NULL;
 	kfree(h4);
@@ -173,7 +174,7 @@ struct sk_buff *h4_recv_buf(struct hci_dev *hdev, struct sk_buff *skb,
 	while (count) {
 		int i, len;
 
-		if (!skb) {
+		if (IS_ERR_OR_NULL(skb)) {
 			for (i = 0; i < pkts_count; i++) {
 				if (buffer[0] != (&pkts[i])->type)
 					continue;
-- 
2.1.4

