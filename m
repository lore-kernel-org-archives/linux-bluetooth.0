Return-Path: <cyrus@holtmann.org>
From: Mikel Astiz <mikel.astiz.oss@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Mikel Astiz <mikel.astiz@bmw-carit.de>,
	Mikel Astiz <mikel.astiz.oss@gmail.com>
Subject: [PATCH v0 4/6] Bluetooth: Simplify outgoing SCO scheduling code
Date: Wed, 11 Apr 2012 08:48:50 +0200
Message-Id: <1334126932-27327-5-git-send-email-mikel.astiz.oss@gmail.com>
In-Reply-To: <1334126932-27327-1-git-send-email-mikel.astiz.oss@gmail.com>
References: <1334126932-27327-1-git-send-email-mikel.astiz.oss@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Mikel Astiz <mikel.astiz@bmw-carit.de>

This patch refactors the SCO scheduling algorithm to remove code that is
not making any difference. There is no HCI SCO flow control in the
kernel so the scheduling can be simplified.

All data produced by userspace is sent to the controller without any
flow control. This was also the case before this patch, but now it's
more obvious and readable.

Signed-off-by: Mikel Astiz <mikel.astiz.oss@gmail.com>
---
 net/bluetooth/hci_core.c |   98 ++++++++++++++--------------------------------
 1 files changed, 30 insertions(+), 68 deletions(-)

diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 43760f1..7eb8c3f 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -2331,66 +2331,6 @@ EXPORT_SYMBOL(hci_send_sco);
 
 /* ---- HCI TX task (outgoing data) ---- */
 
-/* HCI Connection scheduler */
-static inline struct hci_conn *hci_low_sent(struct hci_dev *hdev, __u8 type, int *quote)
-{
-	struct hci_conn_hash *h = &hdev->conn_hash;
-	struct hci_conn *conn = NULL, *c;
-	unsigned int num = 0, min = ~0;
-
-	/* We don't have to lock device here. Connections are always
-	 * added and removed with TX task disabled. */
-
-	rcu_read_lock();
-
-	list_for_each_entry_rcu(c, &h->list, list) {
-		if (c->type != type || skb_queue_empty(&c->data_q))
-			continue;
-
-		if (c->state != BT_CONNECTED && c->state != BT_CONFIG)
-			continue;
-
-		num++;
-
-		if (c->sent < min) {
-			min  = c->sent;
-			conn = c;
-		}
-
-		if (hci_conn_num(hdev, type) == num)
-			break;
-	}
-
-	rcu_read_unlock();
-
-	if (conn) {
-		int cnt, q;
-
-		switch (conn->type) {
-		case ACL_LINK:
-			cnt = hdev->acl_cnt;
-			break;
-		case SCO_LINK:
-		case ESCO_LINK:
-			cnt = hdev->sco_cnt;
-			break;
-		case LE_LINK:
-			cnt = hdev->le_mtu ? hdev->le_cnt : hdev->acl_cnt;
-			break;
-		default:
-			cnt = 0;
-			BT_ERR("Unknown link type");
-		}
-
-		q = cnt / num;
-		*quote = q ? q : 1;
-	} else
-		*quote = 0;
-
-	BT_DBG("conn %p quote %d", conn, *quote);
-	return conn;
-}
-
 static inline void hci_link_tx_to(struct hci_dev *hdev, __u8 type)
 {
 	struct hci_conn_hash *h = &hdev->conn_hash;
@@ -2663,17 +2603,26 @@ static inline void hci_sched_acl(struct hci_dev *hdev)
 /* Schedule SCO */
 static inline void hci_sched_sco(struct hci_dev *hdev)
 {
+	struct hci_conn_hash *h = &hdev->conn_hash;
 	struct hci_conn *conn;
-	struct sk_buff *skb;
-	int quote;
 
 	BT_DBG("%s", hdev->name);
 
 	if (!hci_conn_num(hdev, SCO_LINK))
 		return;
 
-	while (hdev->sco_cnt && (conn = hci_low_sent(hdev, SCO_LINK, &quote))) {
-		while (quote-- && (skb = skb_dequeue(&conn->data_q))) {
+	rcu_read_lock();
+
+	list_for_each_entry_rcu(conn, &h->list, list) {
+		struct sk_buff *skb;
+
+		if (conn->type != SCO_LINK)
+			continue;
+
+		if (conn->state != BT_CONNECTED && conn->state != BT_CONFIG)
+			continue;
+
+		while ((skb = skb_dequeue(&conn->data_q)) != NULL) {
 			BT_DBG("skb %p len %d", skb, skb->len);
 			hci_send_frame(skb);
 
@@ -2682,21 +2631,32 @@ static inline void hci_sched_sco(struct hci_dev *hdev)
 				conn->sent = 0;
 		}
 	}
+
+	rcu_read_unlock();
 }
 
 static inline void hci_sched_esco(struct hci_dev *hdev)
 {
+	struct hci_conn_hash *h = &hdev->conn_hash;
 	struct hci_conn *conn;
-	struct sk_buff *skb;
-	int quote;
 
 	BT_DBG("%s", hdev->name);
 
 	if (!hci_conn_num(hdev, ESCO_LINK))
 		return;
 
-	while (hdev->sco_cnt && (conn = hci_low_sent(hdev, ESCO_LINK, &quote))) {
-		while (quote-- && (skb = skb_dequeue(&conn->data_q))) {
+	rcu_read_lock();
+
+	list_for_each_entry_rcu(conn, &h->list, list) {
+		struct sk_buff *skb;
+
+		if (conn->type != ESCO_LINK)
+			continue;
+
+		if (conn->state != BT_CONNECTED && conn->state != BT_CONFIG)
+			continue;
+
+		while ((skb = skb_dequeue(&conn->data_q)) != NULL) {
 			BT_DBG("skb %p len %d", skb, skb->len);
 			hci_send_frame(skb);
 
@@ -2705,6 +2665,8 @@ static inline void hci_sched_esco(struct hci_dev *hdev)
 				conn->sent = 0;
 		}
 	}
+
+	rcu_read_unlock();
 }
 
 static inline void hci_sched_le(struct hci_dev *hdev)
-- 
1.7.7.6

