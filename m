Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 6/7] Bluetooth: recalculate priorities when channels are starving
Date: Tue,  1 Nov 2011 10:59:01 +0200
Message-Id: <1320137942-25780-6-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1320137942-25780-1-git-send-email-luiz.dentz@gmail.com>
References: <1320137942-25780-1-git-send-email-luiz.dentz@gmail.com>
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
 net/bluetooth/hci_core.c |   56 +++++++++++++++++++++++++++++++++++++++++++++-
 1 files changed, 55 insertions(+), 1 deletions(-)

diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 4ecf652..14f7d73 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -2188,6 +2188,53 @@ static inline struct hci_chan *hci_chan_sent(struct hci_dev *hdev, __u8 type,
 	return chan;
 }
 
+static void hci_prio_recalculate(struct hci_dev *hdev, __u8 type)
+{
+	struct hci_conn_hash *h = &hdev->conn_hash;
+	struct hci_conn *conn;
+	int num = 0;
+
+	BT_DBG("%s", hdev->name);
+
+	list_for_each_entry(conn, &h->list, list) {
+		struct hci_chan_hash *ch;
+		struct hci_chan *chan;
+
+		if (conn->type != type)
+			continue;
+
+		if (conn->state != BT_CONNECTED && conn->state != BT_CONFIG)
+			continue;
+
+		num++;
+
+		ch = &conn->chan_hash;
+		list_for_each_entry(chan, &ch->list, list) {
+			struct sk_buff *skb;
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
 	struct hci_chan *chan;
@@ -2233,6 +2280,9 @@ static inline void hci_sched_acl(struct hci_dev *hdev)
 			chan->conn->sent++;
 		}
 	}
+
+	if (cnt != hdev->acl_cnt)
+		hci_prio_recalculate(hdev, ACL_LINK);
 }
 
 /* Schedule SCO */
@@ -2286,7 +2336,7 @@ static inline void hci_sched_le(struct hci_dev *hdev)
 {
 	struct hci_chan *chan;
 	struct sk_buff *skb;
-	int quote, cnt;
+	int quote, cnt, tmp;
 
 	BT_DBG("%s", hdev->name);
 
@@ -2302,6 +2352,7 @@ static inline void hci_sched_le(struct hci_dev *hdev)
 	}
 
 	cnt = hdev->le_pkts ? hdev->le_cnt : hdev->acl_cnt;
+	tmp = cnt;
 	while (cnt && (chan = hci_chan_sent(hdev, LE_LINK, &quote))) {
 		u32 priority = (skb_peek(&chan->data_q))->priority;
 		while (quote-- && (skb = skb_peek(&chan->data_q))) {
@@ -2327,6 +2378,9 @@ static inline void hci_sched_le(struct hci_dev *hdev)
 		hdev->le_cnt = cnt;
 	else
 		hdev->acl_cnt = cnt;
+
+	if (cnt != tmp)
+		hci_prio_recalculate(hdev, LE_LINK);
 }
 
 static void hci_tx_task(unsigned long arg)
-- 
1.7.6.4

