Return-Path: <cyrus@holtmann.org>
From: "Gustavo F. Padovan" <padovan@profusion.mobi>
To: linux-bluetooth@vger.kernel.org
Cc: "Gustavo F. Padovan" <padovan@profusion.mobi>
Subject: [RFC 12/22] Bluetooth: convert conn hash to RCU
Date: Sat, 17 Dec 2011 19:29:32 -0200
Message-Id: <1324157382-1815-13-git-send-email-padovan@profusion.mobi>
In-Reply-To: <1324157382-1815-12-git-send-email-padovan@profusion.mobi>
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
 <1324157382-1815-12-git-send-email-padovan@profusion.mobi>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: "Gustavo F. Padovan" <padovan@profusion.mobi>

Handling hci_conn_hash with RCU make us avoid some locking and disable
tasklets.

Signed-off-by: Gustavo F. Padovan <padovan@profusion.mobi>
---
 include/net/bluetooth/hci_core.h |   45 ++++++++++++++++++++++++++-----------
 net/bluetooth/hci_conn.c         |   19 +++++++--------
 net/bluetooth/hci_core.c         |   34 ++++++++++++++++++----------
 3 files changed, 62 insertions(+), 36 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 14b200b..e832433 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -392,7 +392,7 @@ static inline void hci_conn_hash_init(struct hci_dev *hdev)
 static inline void hci_conn_hash_add(struct hci_dev *hdev, struct hci_conn *c)
 {
 	struct hci_conn_hash *h = &hdev->conn_hash;
-	list_add(&c->list, &h->list);
+	list_add_rcu(&c->list, &h->list);
 	switch (c->type) {
 	case ACL_LINK:
 		h->acl_num++;
@@ -410,7 +410,10 @@ static inline void hci_conn_hash_add(struct hci_dev *hdev, struct hci_conn *c)
 static inline void hci_conn_hash_del(struct hci_dev *hdev, struct hci_conn *c)
 {
 	struct hci_conn_hash *h = &hdev->conn_hash;
-	list_del(&c->list);
+
+	list_del_rcu(&c->list);
+	synchronize_rcu();
+
 	switch (c->type) {
 	case ACL_LINK:
 		h->acl_num--;
@@ -445,14 +448,18 @@ static inline struct hci_conn *hci_conn_hash_lookup_handle(struct hci_dev *hdev,
 								__u16 handle)
 {
 	struct hci_conn_hash *h = &hdev->conn_hash;
-	struct list_head *p;
 	struct hci_conn  *c;
 
-	list_for_each(p, &h->list) {
-		c = list_entry(p, struct hci_conn, list);
-		if (c->handle == handle)
+	rcu_read_lock();
+
+	list_for_each_entry_rcu(c, &h->list, list) {
+		if (c->handle == handle) {
+			rcu_read_unlock();
 			return c;
+		}
 	}
+	rcu_read_unlock();
+
 	return NULL;
 }
 
@@ -460,14 +467,19 @@ static inline struct hci_conn *hci_conn_hash_lookup_ba(struct hci_dev *hdev,
 							__u8 type, bdaddr_t *ba)
 {
 	struct hci_conn_hash *h = &hdev->conn_hash;
-	struct list_head *p;
 	struct hci_conn  *c;
 
-	list_for_each(p, &h->list) {
-		c = list_entry(p, struct hci_conn, list);
-		if (c->type == type && !bacmp(&c->dst, ba))
+	rcu_read_lock();
+
+	list_for_each_entry_rcu(c, &h->list, list) {
+		if (c->type == type && !bacmp(&c->dst, ba)) {
+			rcu_read_unlock();
 			return c;
+		}
 	}
+
+	rcu_read_unlock();
+
 	return NULL;
 }
 
@@ -475,14 +487,19 @@ static inline struct hci_conn *hci_conn_hash_lookup_state(struct hci_dev *hdev,
 							__u8 type, __u16 state)
 {
 	struct hci_conn_hash *h = &hdev->conn_hash;
-	struct list_head *p;
 	struct hci_conn  *c;
 
-	list_for_each(p, &h->list) {
-		c = list_entry(p, struct hci_conn, list);
-		if (c->type == type && c->state == state)
+	rcu_read_lock();
+
+	list_for_each_entry_rcu(c, &h->list, list) {
+		if (c->type == type && c->state == state) {
+			rcu_read_unlock();
 			return c;
+		}
 	}
+
+	rcu_read_unlock();
+
 	return NULL;
 }
 
diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index b044676..5e9e193 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -418,18 +418,17 @@ struct hci_conn *hci_conn_add(struct hci_dev *hdev, int type, bdaddr_t *dst)
 
 	hci_dev_hold(hdev);
 
-	tasklet_disable(&hdev->tx_task);
-
 	hci_conn_hash_add(hdev, conn);
-	if (hdev->notify)
+	if (hdev->notify) {
+		tasklet_disable(&hdev->tx_task);
 		hdev->notify(hdev, HCI_NOTIFY_CONN_ADD);
+		tasklet_enable(&hdev->tx_task);
+	}
 
 	atomic_set(&conn->devref, 0);
 
 	hci_conn_init_sysfs(conn);
 
-	tasklet_enable(&hdev->tx_task);
-
 	return conn;
 }
 
@@ -465,15 +464,15 @@ int hci_conn_del(struct hci_conn *conn)
 		}
 	}
 
-	tasklet_disable(&hdev->tx_task);
 
 	hci_chan_list_flush(conn);
 
 	hci_conn_hash_del(hdev, conn);
-	if (hdev->notify)
+	if (hdev->notify) {
+		tasklet_disable(&hdev->tx_task);
 		hdev->notify(hdev, HCI_NOTIFY_CONN_DEL);
-
-	tasklet_enable(&hdev->tx_task);
+		tasklet_enable(&hdev->tx_task);
+	}
 
 	skb_queue_purge(&conn->data_q);
 
@@ -808,7 +807,7 @@ void hci_conn_hash_flush(struct hci_dev *hdev)
 
 	BT_DBG("hdev %s", hdev->name);
 
-	list_for_each_entry(c, &h->list, list) {
+	list_for_each_entry_rcu(c, &h->list, list) {
 		c->state = BT_CLOSED;
 
 		hci_proto_disconn_cfm(c, HCI_ERROR_LOCAL_HOST_TERM);
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index f016a40..7654777 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -2051,7 +2051,10 @@ static inline struct hci_conn *hci_low_sent(struct hci_dev *hdev, __u8 type, int
 
 	/* We don't have to lock device here. Connections are always
 	 * added and removed with TX task disabled. */
-	list_for_each_entry(c, &h->list, list) {
+
+	rcu_read_lock();
+
+	list_for_each_entry_rcu(c, &h->list, list) {
 		if (c->type != type || skb_queue_empty(&c->data_q))
 			continue;
 
@@ -2069,6 +2072,8 @@ static inline struct hci_conn *hci_low_sent(struct hci_dev *hdev, __u8 type, int
 			break;
 	}
 
+	rcu_read_unlock();
+
 	if (conn) {
 		int cnt, q;
 
@@ -2104,14 +2109,18 @@ static inline void hci_link_tx_to(struct hci_dev *hdev, __u8 type)
 
 	BT_ERR("%s link tx timeout", hdev->name);
 
+	rcu_read_lock();
+
 	/* Kill stalled connections */
-	list_for_each_entry(c, &h->list, list) {
+	list_for_each_entry_rcu(c, &h->list, list) {
 		if (c->type == type && c->sent) {
 			BT_ERR("%s killing stalled connection %s",
 				hdev->name, batostr(&c->dst));
 			hci_acl_disconn(c, 0x13);
 		}
 	}
+
+	rcu_read_unlock();
 }
 
 static inline struct hci_chan *hci_chan_sent(struct hci_dev *hdev, __u8 type,
@@ -2125,7 +2134,9 @@ static inline struct hci_chan *hci_chan_sent(struct hci_dev *hdev, __u8 type,
 
 	BT_DBG("%s", hdev->name);
 
-	list_for_each_entry(conn, &h->list, list) {
+	rcu_read_lock();
+
+	list_for_each_entry_rcu(conn, &h->list, list) {
 		struct hci_chan *tmp;
 
 		if (conn->type != type)
@@ -2136,8 +2147,6 @@ static inline struct hci_chan *hci_chan_sent(struct hci_dev *hdev, __u8 type,
 
 		conn_num++;
 
-		rcu_read_lock();
-
 		list_for_each_entry_rcu(tmp, &conn->chan_list, list) {
 			struct sk_buff *skb;
 
@@ -2162,12 +2171,12 @@ static inline struct hci_chan *hci_chan_sent(struct hci_dev *hdev, __u8 type,
 			}
 		}
 
-		rcu_read_unlock();
-
 		if (hci_conn_num(hdev, type) == conn_num)
 			break;
 	}
 
+	rcu_read_unlock();
+
 	if (!chan)
 		return NULL;
 
@@ -2201,7 +2210,9 @@ static void hci_prio_recalculate(struct hci_dev *hdev, __u8 type)
 
 	BT_DBG("%s", hdev->name);
 
-	list_for_each_entry(conn, &h->list, list) {
+	rcu_read_lock();
+
+	list_for_each_entry_rcu(conn, &h->list, list) {
 		struct hci_chan *chan;
 
 		if (conn->type != type)
@@ -2212,8 +2223,6 @@ static void hci_prio_recalculate(struct hci_dev *hdev, __u8 type)
 
 		num++;
 
-		rcu_read_lock();
-
 		list_for_each_entry_rcu(chan, &conn->chan_list, list) {
 			struct sk_buff *skb;
 
@@ -2235,11 +2244,12 @@ static void hci_prio_recalculate(struct hci_dev *hdev, __u8 type)
 								skb->priority);
 		}
 
-		rcu_read_unlock();
-
 		if (hci_conn_num(hdev, type) == num)
 			break;
 	}
+
+	rcu_read_unlock();
+
 }
 
 static inline void hci_sched_acl(struct hci_dev *hdev)
-- 
1.7.6.4

