Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: hci_uart: Remove unused h4->rx_skb field
Date: Sat,  4 Apr 2015 20:25:50 -0700
Message-Id: <1428204350-31714-1-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The h4->rx_skb is not used anymore and with that just remove it. Seems
this was a leftover and even the kfree_skb call freeing it is rather
pointless since it got never allocated.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 drivers/bluetooth/hci_h4.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/bluetooth/hci_h4.c b/drivers/bluetooth/hci_h4.c
index 66db9a803373..3ea8f0886ed1 100644
--- a/drivers/bluetooth/hci_h4.c
+++ b/drivers/bluetooth/hci_h4.c
@@ -51,7 +51,6 @@
 struct h4_struct {
 	unsigned long rx_state;
 	unsigned long rx_count;
-	struct sk_buff *rx_skb;
 	struct sk_buff_head txq;
 };
 
@@ -95,8 +94,6 @@ static int h4_close(struct hci_uart *hu)
 
 	skb_queue_purge(&h4->txq);
 
-	kfree_skb(h4->rx_skb);
-
 	hu->priv = NULL;
 	kfree(h4);
 
-- 
2.1.0

