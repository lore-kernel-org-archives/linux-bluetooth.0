Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Fix memory leaking when hdev->send returns an error
Date: Sun,  6 Jul 2014 15:36:15 +0200
Message-Id: <1404653775-2386-1-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The drivers are allowed to just return an error from hdev->send callback
and in that case the driver does not own the SKB. Which means that the
caller has to free the SKB.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 net/bluetooth/hci_core.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index fc7abd3c012d..b02454ab07ee 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -4339,6 +4339,8 @@ EXPORT_SYMBOL(hci_unregister_cb);
 
 static void hci_send_frame(struct hci_dev *hdev, struct sk_buff *skb)
 {
+	int err;
+
 	BT_DBG("%s type %d len %d", hdev->name, bt_cb(skb)->pkt_type, skb->len);
 
 	/* Time stamp */
@@ -4355,8 +4357,11 @@ static void hci_send_frame(struct hci_dev *hdev, struct sk_buff *skb)
 	/* Get rid of skb owner, prior to sending to the driver. */
 	skb_orphan(skb);
 
-	if (hdev->send(hdev, skb) < 0)
-		BT_ERR("%s sending frame failed", hdev->name);
+	err = hdev->send(hdev, skb);
+	if (err < 0) {
+		BT_ERR("%s sending frame failed (%d)", hdev->name, err);
+		kfree_skb(skb);
+	}
 }
 
 void hci_req_init(struct hci_request *req, struct hci_dev *hdev)
-- 
1.9.3

