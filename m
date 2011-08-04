Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFC 1/3 v2] Bluetooth: prioritizing data over HCI
Date: Thu,  4 Aug 2011 16:15:19 +0300
Message-Id: <1312463719-3194-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This implement priority based scheduler using skbuffer priority set via
SO_PRIORITY socket option.

It reuses the quote calculation from old scheduler, but the difference is
that the number of connections used to calculate the quote is by priority,
so the quote may not be devided equally per connection if their priorities
are different.

To avoid starvation the priority is recalculated in a round robin fashion
so that the remaining queues are upgraded by 1 in priority until
HCI_PRIO_MAX - 1 (6).

HCI_PRIO_MAX (7) is considered special, it requires CAP_NET_ADMIN
capability and is used to send time critical command/respose for L2CAP
and RFCOMM to avoid timeouts, in addition to that it can be used to
provide exclusive use of bandwidth but may starve other connections thus
need to be used with care.

Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 include/net/bluetooth/hci_core.h |   22 ++++-
 net/bluetooth/hci_conn.c         |    8 +-
 net/bluetooth/hci_core.c         |  200 +++++++++++++++++++++++++++++---------
 net/bluetooth/rfcomm/sock.c      |    8 ++
 4 files changed, 187 insertions(+), 51 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 8f441b8..b393024 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -32,6 +32,10 @@
 #define HCI_PROTO_L2CAP	0
 #define HCI_PROTO_SCO	1
 
+/* HCI priority queues */
+#define HCI_PRIO_QUEUES	8
+#define HCI_PRIO_MAX	HCI_PRIO_QUEUES - 1
+
 /* HCI Core structures */
 struct inquiry_data {
 	bdaddr_t	bdaddr;
@@ -274,7 +278,7 @@ struct hci_conn {
 
 	unsigned int	sent;
 
-	struct sk_buff_head data_q;
+	struct sk_buff_head data_q[HCI_PRIO_QUEUES];
 
 	struct timer_list disc_timer;
 	struct timer_list idle_timer;
@@ -395,6 +399,22 @@ static inline void hci_conn_hash_del(struct hci_dev *hdev, struct hci_conn *c)
 	}
 }
 
+static inline unsigned int hci_conn_num(struct hci_dev *hdev, __u8 type)
+{
+	struct hci_conn_hash *h = &hdev->conn_hash;
+	switch (type) {
+	case ACL_LINK:
+		return h->acl_num;
+	case LE_LINK:
+		return h->le_num;
+	case SCO_LINK:
+	case ESCO_LINK:
+		return h->sco_num;
+	default:
+		return 0;
+	}
+}
+
 static inline struct hci_conn *hci_conn_hash_lookup_handle(struct hci_dev *hdev,
 								__u16 handle)
 {
diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index ea7f031..4c09738 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -336,6 +336,7 @@ static void hci_conn_auto_accept(unsigned long arg)
 struct hci_conn *hci_conn_add(struct hci_dev *hdev, int type, bdaddr_t *dst)
 {
 	struct hci_conn *conn;
+	int i;
 
 	BT_DBG("%s dst %s", hdev->name, batostr(dst));
 
@@ -372,7 +373,8 @@ struct hci_conn *hci_conn_add(struct hci_dev *hdev, int type, bdaddr_t *dst)
 		break;
 	}
 
-	skb_queue_head_init(&conn->data_q);
+	for (i = 0; i < HCI_PRIO_QUEUES; i++)
+		skb_queue_head_init(&conn->data_q[i]);
 
 	setup_timer(&conn->disc_timer, hci_conn_timeout, (unsigned long)conn);
 	setup_timer(&conn->idle_timer, hci_conn_idle, (unsigned long)conn);
@@ -401,6 +403,7 @@ struct hci_conn *hci_conn_add(struct hci_dev *hdev, int type, bdaddr_t *dst)
 int hci_conn_del(struct hci_conn *conn)
 {
 	struct hci_dev *hdev = conn->hdev;
+	int i;
 
 	BT_DBG("%s conn %p handle %d", hdev->name, conn, conn->handle);
 
@@ -438,7 +441,8 @@ int hci_conn_del(struct hci_conn *conn)
 
 	tasklet_enable(&hdev->tx_task);
 
-	skb_queue_purge(&conn->data_q);
+	for (i = 0; i < HCI_PRIO_QUEUES; i++)
+		skb_queue_purge(&conn->data_q[i]);
 
 	hci_conn_put_device(conn);
 
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index ec0bc3f..d8b41e1 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -1975,10 +1975,21 @@ static void hci_add_acl_hdr(struct sk_buff *skb, __u16 handle, __u16 flags)
 	hdr->dlen   = cpu_to_le16(len);
 }
 
+static struct sk_buff_head *hci_prio_queue(struct hci_conn *conn, __u32 prio)
+{
+	BT_DBG("conn %p priority %u", conn, prio);
+
+	if (prio > HCI_PRIO_MAX)
+		prio = HCI_PRIO_MAX;
+
+	return &conn->data_q[prio];
+}
+
 void hci_send_acl(struct hci_conn *conn, struct sk_buff *skb, __u16 flags)
 {
 	struct hci_dev *hdev = conn->hdev;
 	struct sk_buff *list;
+	struct sk_buff_head *queue;
 
 	BT_DBG("%s conn %p flags 0x%x", hdev->name, conn, flags);
 
@@ -1986,12 +1997,14 @@ void hci_send_acl(struct hci_conn *conn, struct sk_buff *skb, __u16 flags)
 	bt_cb(skb)->pkt_type = HCI_ACLDATA_PKT;
 	hci_add_acl_hdr(skb, conn->handle, flags);
 
+	queue = hci_prio_queue(conn, skb->priority);
+
 	list = skb_shinfo(skb)->frag_list;
 	if (!list) {
 		/* Non fragmented */
 		BT_DBG("%s nonfrag skb %p len %d", hdev->name, skb, skb->len);
 
-		skb_queue_tail(&conn->data_q, skb);
+		skb_queue_tail(queue, skb);
 	} else {
 		/* Fragmented */
 		BT_DBG("%s frag %p len %d", hdev->name, skb, skb->len);
@@ -1999,9 +2012,9 @@ void hci_send_acl(struct hci_conn *conn, struct sk_buff *skb, __u16 flags)
 		skb_shinfo(skb)->frag_list = NULL;
 
 		/* Queue all fragments atomically */
-		spin_lock_bh(&conn->data_q.lock);
+		spin_lock_bh(&queue->lock);
 
-		__skb_queue_tail(&conn->data_q, skb);
+		__skb_queue_tail(queue, skb);
 
 		flags &= ~ACL_START;
 		flags |= ACL_CONT;
@@ -2014,10 +2027,10 @@ void hci_send_acl(struct hci_conn *conn, struct sk_buff *skb, __u16 flags)
 
 			BT_DBG("%s frag %p len %d", hdev->name, skb, skb->len);
 
-			__skb_queue_tail(&conn->data_q, skb);
+			__skb_queue_tail(queue, skb);
 		} while (list);
 
-		spin_unlock_bh(&conn->data_q.lock);
+		spin_unlock_bh(&queue->lock);
 	}
 
 	tasklet_schedule(&hdev->tx_task);
@@ -2029,6 +2042,7 @@ void hci_send_sco(struct hci_conn *conn, struct sk_buff *skb)
 {
 	struct hci_dev *hdev = conn->hdev;
 	struct hci_sco_hdr hdr;
+	struct sk_buff_head *queue;
 
 	BT_DBG("%s len %d", hdev->name, skb->len);
 
@@ -2042,7 +2056,8 @@ void hci_send_sco(struct hci_conn *conn, struct sk_buff *skb)
 	skb->dev = (void *) hdev;
 	bt_cb(skb)->pkt_type = HCI_SCODATA_PKT;
 
-	skb_queue_tail(&conn->data_q, skb);
+	queue = hci_prio_queue(conn, skb->priority);
+	skb_queue_tail(queue, skb);
 	tasklet_schedule(&hdev->tx_task);
 }
 EXPORT_SYMBOL(hci_send_sco);
@@ -2050,35 +2065,44 @@ EXPORT_SYMBOL(hci_send_sco);
 /* ---- HCI TX task (outgoing data) ---- */
 
 /* HCI Connection scheduler */
-static inline struct hci_conn *hci_low_sent(struct hci_dev *hdev, __u8 type, int *quote)
+static inline struct hci_conn *hci_prio_sent(struct hci_dev *hdev, __u8 type,
+					struct sk_buff_head **queue, int *quote)
 {
 	struct hci_conn_hash *h = &hdev->conn_hash;
 	struct hci_conn *conn = NULL;
-	int num = 0, min = ~0;
-	struct list_head *p;
+	int i;
 
 	/* We don't have to lock device here. Connections are always
 	 * added and removed with TX task disabled. */
-	list_for_each(p, &h->list) {
-		struct hci_conn *c;
-		c = list_entry(p, struct hci_conn, list);
+	for (i = HCI_PRIO_MAX; i >= 0; i--) {
+		int num = 0, min = ~0;
+		struct list_head *p;
+		int cnt, q;
 
-		if (c->type != type || skb_queue_empty(&c->data_q))
-			continue;
+		list_for_each(p, &h->list) {
+			struct hci_conn *c;
+			c = list_entry(p, struct hci_conn, list);
 
-		if (c->state != BT_CONNECTED && c->state != BT_CONFIG)
-			continue;
+			if (c->type != type || skb_queue_empty(&c->data_q[i]))
+				continue;
+
+			if (c->state != BT_CONNECTED && c->state != BT_CONFIG)
+				continue;
 
-		num++;
+			num++;
 
-		if (c->sent < min) {
-			min  = c->sent;
-			conn = c;
+			if (c->sent < min) {
+				min  = c->sent;
+				conn = c;
+				*queue = &c->data_q[i];
+			}
+
+			if (hci_conn_num(hdev, type) == num)
+				break;
 		}
-	}
 
-	if (conn) {
-		int cnt, q;
+		if (!conn)
+			continue;
 
 		switch (conn->type) {
 		case ACL_LINK:
@@ -2098,10 +2122,13 @@ static inline struct hci_conn *hci_low_sent(struct hci_dev *hdev, __u8 type, int
 
 		q = cnt / num;
 		*quote = q ? q : 1;
-	} else
-		*quote = 0;
+		BT_DBG("conn %p index %d quote %d", conn, i, *quote);
+		return conn;
+	}
 
-	BT_DBG("conn %p quote %d", conn, *quote);
+	*quote = 0;
+	*queue = NULL;
+	BT_DBG("conn %p queue %p quote %d", conn, queue, *quote);
 	return conn;
 }
 
@@ -2124,14 +2151,19 @@ static inline void hci_link_tx_to(struct hci_dev *hdev, __u8 type)
 	}
 }
 
-static inline void hci_sched_acl(struct hci_dev *hdev)
+static inline unsigned int hci_sched_acl(struct hci_dev *hdev)
 {
 	struct hci_conn *conn;
 	struct sk_buff *skb;
+	struct sk_buff_head *queue = NULL;
 	int quote;
+	unsigned int cnt;
 
 	BT_DBG("%s", hdev->name);
 
+	if (!hci_conn_num(hdev, ACL_LINK))
+		return 0;
+
 	if (!test_bit(HCI_RAW, &hdev->flags)) {
 		/* ACL tx timeout must be longer than maximum
 		 * link supervision timeout (40.9 seconds) */
@@ -2139,9 +2171,13 @@ static inline void hci_sched_acl(struct hci_dev *hdev)
 			hci_link_tx_to(hdev, ACL_LINK);
 	}
 
-	while (hdev->acl_cnt && (conn = hci_low_sent(hdev, ACL_LINK, &quote))) {
-		while (quote-- && (skb = skb_dequeue(&conn->data_q))) {
-			BT_DBG("skb %p len %d", skb, skb->len);
+	cnt = hdev->acl_cnt;
+
+	while (hdev->acl_cnt &&
+			(conn = hci_prio_sent(hdev, ACL_LINK, &queue, &quote))) {
+		while (quote-- && (skb = skb_dequeue(queue))) {
+			BT_DBG("skb %p len %d priority %u", skb, skb->len,
+							skb->priority);
 
 			hci_conn_enter_active_mode(conn, bt_cb(skb)->force_active);
 
@@ -2152,20 +2188,31 @@ static inline void hci_sched_acl(struct hci_dev *hdev)
 			conn->sent++;
 		}
 	}
+
+	return cnt - hdev->acl_cnt;
 }
 
 /* Schedule SCO */
-static inline void hci_sched_sco(struct hci_dev *hdev)
+static inline unsigned int hci_sched_sco(struct hci_dev *hdev)
 {
 	struct hci_conn *conn;
 	struct sk_buff *skb;
+	struct sk_buff_head *queue = NULL;
 	int quote;
+	unsigned int cnt;
 
 	BT_DBG("%s", hdev->name);
 
-	while (hdev->sco_cnt && (conn = hci_low_sent(hdev, SCO_LINK, &quote))) {
-		while (quote-- && (skb = skb_dequeue(&conn->data_q))) {
-			BT_DBG("skb %p len %d", skb, skb->len);
+	if (!hci_conn_num(hdev, SCO_LINK))
+		return 0;
+
+	cnt = hdev->sco_cnt;
+
+	while (hdev->sco_cnt &&
+			(conn = hci_prio_sent(hdev, SCO_LINK, &queue, &quote))) {
+		while (quote-- && (skb = skb_dequeue(queue))) {
+			BT_DBG("conn %p skb %p len %d priority %u", conn, skb,
+						skb->len, skb->priority);
 			hci_send_frame(skb);
 
 			conn->sent++;
@@ -2173,19 +2220,30 @@ static inline void hci_sched_sco(struct hci_dev *hdev)
 				conn->sent = 0;
 		}
 	}
+
+	return cnt - hdev->sco_cnt;
 }
 
-static inline void hci_sched_esco(struct hci_dev *hdev)
+static inline unsigned int hci_sched_esco(struct hci_dev *hdev)
 {
 	struct hci_conn *conn;
 	struct sk_buff *skb;
+	struct sk_buff_head *queue = NULL;
 	int quote;
+	unsigned int cnt;
 
 	BT_DBG("%s", hdev->name);
 
-	while (hdev->sco_cnt && (conn = hci_low_sent(hdev, ESCO_LINK, &quote))) {
-		while (quote-- && (skb = skb_dequeue(&conn->data_q))) {
-			BT_DBG("skb %p len %d", skb, skb->len);
+	if (!hci_conn_num(hdev, ESCO_LINK))
+		return 0;
+
+	cnt = hdev->sco_cnt;
+
+	while (hdev->sco_cnt &&
+			(conn = hci_prio_sent(hdev, ESCO_LINK, &queue, &quote))) {
+		while (quote-- && (skb = skb_dequeue(queue))) {
+			BT_DBG("conn %p skb %p len %d priority %u", conn, skb,
+						skb->len, skb->priority);
 			hci_send_frame(skb);
 
 			conn->sent++;
@@ -2193,16 +2251,23 @@ static inline void hci_sched_esco(struct hci_dev *hdev)
 				conn->sent = 0;
 		}
 	}
+
+	return cnt - hdev->sco_cnt;
 }
 
-static inline void hci_sched_le(struct hci_dev *hdev)
+static inline unsigned int hci_sched_le(struct hci_dev *hdev)
 {
 	struct hci_conn *conn;
 	struct sk_buff *skb;
+	struct sk_buff_head *queue = NULL;
 	int quote, cnt;
+	unsigned int tmp;
 
 	BT_DBG("%s", hdev->name);
 
+	if (!hci_conn_num(hdev, LE_LINK))
+		return 0;
+
 	if (!test_bit(HCI_RAW, &hdev->flags)) {
 		/* LE tx timeout must be longer than maximum
 		 * link supervision timeout (40.9 seconds) */
@@ -2212,9 +2277,10 @@ static inline void hci_sched_le(struct hci_dev *hdev)
 	}
 
 	cnt = hdev->le_pkts ? hdev->le_cnt : hdev->acl_cnt;
-	while (cnt && (conn = hci_low_sent(hdev, LE_LINK, &quote))) {
-		while (quote-- && (skb = skb_dequeue(&conn->data_q))) {
-			BT_DBG("skb %p len %d", skb, skb->len);
+	while (cnt && (conn = hci_prio_sent(hdev, LE_LINK, &queue, &quote))) {
+		while (quote-- && (skb = skb_dequeue(queue))) {
+			BT_DBG("conn %p skb %p len %d priority %u", conn, skb,
+						skb->len, skb->priority);
 
 			hci_send_frame(skb);
 			hdev->le_last_tx = jiffies;
@@ -2223,16 +2289,51 @@ static inline void hci_sched_le(struct hci_dev *hdev)
 			conn->sent++;
 		}
 	}
-	if (hdev->le_pkts)
+
+	if (hdev->le_pkts) {
+		tmp = hdev->le_cnt;
 		hdev->le_cnt = cnt;
-	else
+	} else {
+		tmp = hdev->acl_cnt;
 		hdev->acl_cnt = cnt;
+	}
+
+	return cnt - tmp;
+}
+
+static void hci_prio_recalculate(struct hci_dev *hdev)
+{
+	struct hci_conn_hash *h = &hdev->conn_hash;
+	int i;
+
+	BT_DBG("%s", hdev->name);
+
+	for (i = HCI_PRIO_MAX - 1; i > 0; i--) {
+		struct list_head *p;
+
+		list_for_each(p, &h->list) {
+			struct hci_conn *c;
+			c = list_entry(p, struct hci_conn, list);
+
+			if (c->sent || skb_queue_empty(&c->data_q[i - 1]))
+				continue;
+
+			if (c->state != BT_CONNECTED && c->state != BT_CONFIG)
+				continue;
+
+			BT_DBG("conn %p index %d promoted to %d", c, i - 1, i);
+
+			skb_queue_splice_tail_init(&c->data_q[i - 1],
+							&c->data_q[i]);
+		}
+	}
 }
 
 static void hci_tx_task(unsigned long arg)
 {
 	struct hci_dev *hdev = (struct hci_dev *) arg;
 	struct sk_buff *skb;
+	unsigned int acl_sent, sco_sent, le_sent;
 
 	read_lock(&hci_task_lock);
 
@@ -2241,18 +2342,21 @@ static void hci_tx_task(unsigned long arg)
 
 	/* Schedule queues and send stuff to HCI driver */
 
-	hci_sched_acl(hdev);
+	acl_sent = hci_sched_acl(hdev);
 
-	hci_sched_sco(hdev);
+	sco_sent = hci_sched_sco(hdev);
 
-	hci_sched_esco(hdev);
+	sco_sent += hci_sched_esco(hdev);
 
-	hci_sched_le(hdev);
+	le_sent = hci_sched_le(hdev);
 
 	/* Send next queued raw (unknown type) packet */
 	while ((skb = skb_dequeue(&hdev->raw_q)))
 		hci_send_frame(skb);
 
+	if (acl_sent || sco_sent || le_sent)
+		hci_prio_recalculate(hdev);
+
 	read_unlock(&hci_task_lock);
 }
 
diff --git a/net/bluetooth/rfcomm/sock.c b/net/bluetooth/rfcomm/sock.c
index 8f01e6b..0228e1f 100644
--- a/net/bluetooth/rfcomm/sock.c
+++ b/net/bluetooth/rfcomm/sock.c
@@ -561,6 +561,7 @@ static int rfcomm_sock_sendmsg(struct kiocb *iocb, struct socket *sock,
 	struct sock *sk = sock->sk;
 	struct rfcomm_dlc *d = rfcomm_pi(sk)->dlc;
 	struct sk_buff *skb;
+	u32 priority;
 	int sent = 0;
 
 	if (test_bit(RFCOMM_DEFER_SETUP, &d->flags))
@@ -572,6 +573,11 @@ static int rfcomm_sock_sendmsg(struct kiocb *iocb, struct socket *sock,
 	if (sk->sk_shutdown & SEND_SHUTDOWN)
 		return -EPIPE;
 
+	if (msg->msg_flags & MSG_TRYHARD)
+		priority = HCI_PRIO_MAX;
+	else
+		priority = sk->sk_priority;
+
 	BT_DBG("sock %p, sk %p", sock, sk);
 
 	lock_sock(sk);
@@ -597,6 +603,8 @@ static int rfcomm_sock_sendmsg(struct kiocb *iocb, struct socket *sock,
 			break;
 		}
 
+		skb->priority = priority;
+
 		err = rfcomm_dlc_send(d, skb);
 		if (err < 0) {
 			kfree_skb(skb);
-- 
1.7.6

