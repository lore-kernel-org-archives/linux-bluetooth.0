Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Remove pointless check of hci_send_frame parameter
Date: Thu, 10 Oct 2013 13:29:57 -0700
Message-Id: <1381436997-51094-1-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The hdev parameter of hci_send_frame must be always valid. If the hdev
is not valid, it would not even make it to this stage. The callers
will have already accessed hdev at that point many times.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 net/bluetooth/hci_core.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 925bd47..47cf3a9 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -2699,11 +2699,6 @@ EXPORT_SYMBOL(hci_unregister_cb);
 
 static int hci_send_frame(struct hci_dev *hdev, struct sk_buff *skb)
 {
-	if (!hdev) {
-		kfree_skb(skb);
-		return -ENODEV;
-	}
-
 	BT_DBG("%s type %d len %d", hdev->name, bt_cb(skb)->pkt_type, skb->len);
 
 	/* Time stamp */
-- 
1.8.3.1

