Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/2] Bluetooth: Remove unused h4_check_data_len() function
Date: Thu, 10 Oct 2013 16:52:42 -0700
Message-Id: <1381449163-19932-1-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The function h4_check_data_len() is actually not used. So just
remove it.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 drivers/bluetooth/hci_h4.c | 24 ------------------------
 1 file changed, 24 deletions(-)

diff --git a/drivers/bluetooth/hci_h4.c b/drivers/bluetooth/hci_h4.c
index 8ae9f1e..7048a58 100644
--- a/drivers/bluetooth/hci_h4.c
+++ b/drivers/bluetooth/hci_h4.c
@@ -124,30 +124,6 @@ static int h4_enqueue(struct hci_uart *hu, struct sk_buff *skb)
 	return 0;
 }
 
-static inline int h4_check_data_len(struct h4_struct *h4, int len)
-{
-	int room = skb_tailroom(h4->rx_skb);
-
-	BT_DBG("len %d room %d", len, room);
-
-	if (!len) {
-		hci_recv_frame(h4->rx_skb);
-	} else if (len > room) {
-		BT_ERR("Data length is too large");
-		kfree_skb(h4->rx_skb);
-	} else {
-		h4->rx_state = H4_W4_DATA;
-		h4->rx_count = len;
-		return len;
-	}
-
-	h4->rx_state = H4_W4_PACKET_TYPE;
-	h4->rx_skb   = NULL;
-	h4->rx_count = 0;
-
-	return 0;
-}
-
 /* Recv data */
 static int h4_recv(struct hci_uart *hu, void *data, int count)
 {
-- 
1.8.3.1

