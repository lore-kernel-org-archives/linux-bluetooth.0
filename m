Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFC 5/5 v2] Bluetooth: recalculate priorities when channels are starving
Date: Wed, 17 Aug 2011 16:23:04 +0300
Message-Id: <1313587384-2653-6-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1313587384-2653-1-git-send-email-luiz.dentz@gmail.com>
References: <1313587384-2653-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

To avoid starvation the priority is recalculated so that the starving
channels are promoted to HCI_PRIO_MAX - 1 (6).

HCI_PRIO_MAX (7) is considered special, because it requires CAP_NET_ADMIN
capability which can be used to provide more guaranties, so it is not used
when promoting.

Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 net/bluetooth/hci_core.c |   63 ++++++++++++++++++++++++++++++++++++++++++++-
 1 files changed, 61 insertions(+), 2 deletions(-)

diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 3a4c3a2..eabe84e 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -2184,7 +2184,7 @@ static inline struct hci_chan *hci_chan_sent(struct hci_dev *hdev, __u8 type,
 
 			tmp = list_entry(c, struct hci_chan, list);
 
-			if (skb_queue_empty(&tmp->data_q))
+			if (tmp->sent || skb_queue_empty(&tmp->data_q))
 				continue;
 
 			skb = skb_peek(&tmp->data_q);
@@ -2234,6 +2234,58 @@ static inline struct hci_chan *hci_chan_sent(struct hci_dev *hdev, __u8 type,
 	return chan;
 }
 
+static void hci_prio_recalculate(struct hci_dev *hdev, __u8 type)
+{
+	struct hci_conn_hash *h = &hdev->conn_hash;
+	struct list_head *p, *c;
+	int num = 0;
+
+	BT_DBG("%s", hdev->name);
+
+	list_for_each(p, &h->list) {
+		struct hci_conn *conn;
+		struct hci_chan_hash *ch;
+
+		conn = list_entry(p, struct hci_conn, list);
+		ch = &conn->chan_hash;
+
+		if (conn->type != type)
+			continue;
+
+		if (conn->state != BT_CONNECTED && conn->state != BT_CONFIG)
+			continue;
+
+		num++;
+
+		list_for_each(c, &ch->list) {
+			struct hci_chan *chan;
+			struct sk_buff *skb;
+
+			chan = list_entry(c, struct hci_chan, list);
+
+			if (chan->sent) {
+				chan->sent = 0;
+				continue;
+			}
+
+			if (skb_queue_empty(&chan->data_q))
+				continue;
+
+			skb = skb_peek(&chan->data_q);
+			if (skb->priority >= HCI_PRIO_MAX - 1)
+				continue;
+
+			skb->priority = HCI_PRIO_MAX - 1;
+
+			BT_DBG("chan %p skb %p promoted to %d", chan, skb,
+								skb->priority);
+		}
+
+		if (hci_conn_num(hdev, type) == num)
+			break;
+	}
+}
+
 static inline void hci_sched_acl(struct hci_dev *hdev)
 {
 	struct hci_conn *conn;
@@ -2288,6 +2340,9 @@ static inline void hci_sched_acl(struct hci_dev *hdev)
 			chan->conn->sent++;
 		}
 	}
+
+	if (cnt != hdev->acl_cnt)
+		hci_prio_recalculate(hdev, ACL_LINK);
 }
 
 /* Schedule SCO */
@@ -2342,7 +2397,7 @@ static inline void hci_sched_le(struct hci_dev *hdev)
 	struct hci_conn *conn;
 	struct hci_chan *chan;
 	struct sk_buff *skb;
-	int quote, cnt;
+	int quote, cnt, tmp;
 
 	BT_DBG("%s", hdev->name);
 
@@ -2370,6 +2425,7 @@ static inline void hci_sched_le(struct hci_dev *hdev)
 		}
 	}
 
+	tmp = cnt;
 	while (cnt && (chan = hci_chan_sent(hdev, LE_LINK, &quote))) {
 		while (quote-- && (skb = skb_dequeue(&chan->data_q))) {
 			BT_DBG("chan %p skb %p len %d priority %u", chan, skb,
@@ -2388,6 +2444,9 @@ static inline void hci_sched_le(struct hci_dev *hdev)
 		hdev->le_cnt = cnt;
 	else
 		hdev->acl_cnt = cnt;
+
+	if (cnt != tmp)
+		hci_prio_recalculate(hdev, LE_LINK);
 }
 
 static void hci_tx_task(unsigned long arg)
-- 
1.7.6

