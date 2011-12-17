Return-Path: <cyrus@holtmann.org>
From: "Gustavo F. Padovan" <padovan@profusion.mobi>
To: linux-bluetooth@vger.kernel.org
Cc: "Gustavo F. Padovan" <padovan@profusion.mobi>
Subject: [RFC 11/22] Bluetooth: Use RCU to manipulate chan_list
Date: Sat, 17 Dec 2011 19:29:31 -0200
Message-Id: <1324157382-1815-12-git-send-email-padovan@profusion.mobi>
In-Reply-To: <1324157382-1815-11-git-send-email-padovan@profusion.mobi>
References: <1324157382-1815-1-git-send-email-padovan@profusion.mobi>
 <1324157382-1815-2-git-send-email-padovan@profusion.mobi>
 <1324157382-1815-3-git-send-email-padovan@profusion.mobi>
 <1324157382-1815-4-git-send-email-padovan@profusion.mobi>
 <1324157382-1815-5-git-send-email-padovan@profusion.mobi>
 <1324157382-1815-6-git-send-email-padovan@profusion.mobi>
 <1324157382-1815-7-git-send-email-padovan@profusion.mobi>
 <1324157382-1815-8-git-send-email-padovan@profusion.mobi>
 <1324157382-1815-9-git-send-email-padovan@profusion.mobi>
 <1324157382-1815-10-git-send-email-padovan@profusion.mobi>
 <1324157382-1815-11-git-send-email-padovan@profusion.mobi>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: "Gustavo F. Padovan" <padovan@profusion.mobi>

Instead of using tasklet_disable() to prevent acess to the channel use, we
can use RCU and improve the performance of our code.

Signed-off-by: Gustavo F. Padovan <padovan@profusion.mobi>
---
 net/bluetooth/hci_conn.c |   14 ++++++--------
 net/bluetooth/hci_core.c |   12 ++++++++++--
 2 files changed, 16 insertions(+), 10 deletions(-)

diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index e6d8a22..b044676 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -960,9 +960,7 @@ struct hci_chan *hci_chan_create(struct hci_conn *conn)
 	chan->conn = conn;
 	skb_queue_head_init(&chan->data_q);
 
-	tasklet_disable(&hdev->tx_task);
-	list_add(&conn->chan_list, &chan->list);
-	tasklet_enable(&hdev->tx_task);
+	list_add_rcu(&chan->list, &conn->chan_list);
 
 	return chan;
 }
@@ -974,9 +972,9 @@ int hci_chan_del(struct hci_chan *chan)
 
 	BT_DBG("%s conn %p chan %p", hdev->name, conn, chan);
 
-	tasklet_disable(&hdev->tx_task);
-	list_del(&chan->list);
-	tasklet_enable(&hdev->tx_task);
+	list_del_rcu(&chan->list);
+
+	synchronize_rcu();
 
 	skb_queue_purge(&chan->data_q);
 	kfree(chan);
@@ -986,10 +984,10 @@ int hci_chan_del(struct hci_chan *chan)
 
 void hci_chan_list_flush(struct hci_conn *conn)
 {
-	struct hci_chan *chan, *tmp;
+	struct hci_chan *chan;
 
 	BT_DBG("conn %p", conn);
 
-	list_for_each_entry_safe(chan, tmp, &conn->chan_list, list)
+	list_for_each_entry_rcu(chan, &conn->chan_list, list)
 		hci_chan_del(chan);
 }
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 1f0198b..f016a40 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -2136,7 +2136,9 @@ static inline struct hci_chan *hci_chan_sent(struct hci_dev *hdev, __u8 type,
 
 		conn_num++;
 
-		list_for_each_entry(tmp, &conn->chan_list, list) {
+		rcu_read_lock();
+
+		list_for_each_entry_rcu(tmp, &conn->chan_list, list) {
 			struct sk_buff *skb;
 
 			if (skb_queue_empty(&tmp->data_q))
@@ -2160,6 +2162,8 @@ static inline struct hci_chan *hci_chan_sent(struct hci_dev *hdev, __u8 type,
 			}
 		}
 
+		rcu_read_unlock();
+
 		if (hci_conn_num(hdev, type) == conn_num)
 			break;
 	}
@@ -2208,7 +2212,9 @@ static void hci_prio_recalculate(struct hci_dev *hdev, __u8 type)
 
 		num++;
 
-		list_for_each_entry(chan, &conn->chan_list, list) {
+		rcu_read_lock();
+
+		list_for_each_entry_rcu(chan, &conn->chan_list, list) {
 			struct sk_buff *skb;
 
 			if (chan->sent) {
@@ -2229,6 +2235,8 @@ static void hci_prio_recalculate(struct hci_dev *hdev, __u8 type)
 								skb->priority);
 		}
 
+		rcu_read_unlock();
+
 		if (hci_conn_num(hdev, type) == num)
 			break;
 	}
-- 
1.7.6.4

