Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/4] Bluetooth: prioritizing data over HCI
Date: Wed,  2 Nov 2011 15:52:01 +0200
Message-Id: <1320241924-2300-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This implement priority based scheduler using skbuffer priority set via
SO_PRIORITY socket option.

It introduces hci_chan_hash (list of HCI Channel/hci_chan) per connection,
each item in this list refer to a L2CAP connection and it is used to
queue the data for transmission.

Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
---
 include/net/bluetooth/hci_core.h |   43 +++++++++++-
 include/net/bluetooth/l2cap.h    |    1 +
 net/bluetooth/hci_conn.c         |   53 ++++++++++++++
 net/bluetooth/hci_core.c         |  143 ++++++++++++++++++++++++++++++++------
 net/bluetooth/l2cap_core.c       |   63 +++++++++--------
 net/bluetooth/smp.c              |    3 +-
 6 files changed, 251 insertions(+), 55 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 5a9db9a..f97792c 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -67,6 +67,12 @@ struct hci_conn_hash {
 	unsigned int     le_num;
 };
 
+struct hci_chan_hash {
+	struct list_head list;
+	spinlock_t       lock;
+	unsigned int     num;
+};
+
 struct bdaddr_list {
 	struct list_head list;
 	bdaddr_t bdaddr;
@@ -287,6 +293,7 @@ struct hci_conn {
 	unsigned int	sent;
 
 	struct sk_buff_head data_q;
+	struct hci_chan_hash chan_hash;
 
 	struct timer_list disc_timer;
 	struct timer_list idle_timer;
@@ -309,6 +316,14 @@ struct hci_conn {
 	void (*disconn_cfm_cb)	(struct hci_conn *conn, u8 reason);
 };
 
+struct hci_chan {
+	struct list_head list;
+
+	struct hci_conn *conn;
+	struct sk_buff_head data_q;
+	unsigned int	sent;
+};
+
 extern struct hci_proto *hci_proto[];
 extern struct list_head hci_dev_list;
 extern struct list_head hci_cb_list;
@@ -469,6 +484,28 @@ static inline struct hci_conn *hci_conn_hash_lookup_state(struct hci_dev *hdev,
 	return NULL;
 }
 
+static inline void hci_chan_hash_init(struct hci_conn *c)
+{
+	struct hci_chan_hash *h = &c->chan_hash;
+	INIT_LIST_HEAD(&h->list);
+	spin_lock_init(&h->lock);
+	h->num = 0;
+}
+
+static inline void hci_chan_hash_add(struct hci_conn *c, struct hci_chan *chan)
+{
+	struct hci_chan_hash *h = &c->chan_hash;
+	list_add(&chan->list, &h->list);
+	h->num++;
+}
+
+static inline void hci_chan_hash_del(struct hci_conn *c, struct hci_chan *chan)
+{
+	struct hci_chan_hash *h = &c->chan_hash;
+	list_del(&chan->list);
+	h->num--;
+}
+
 void hci_acl_connect(struct hci_conn *conn);
 void hci_acl_disconn(struct hci_conn *conn, __u8 reason);
 void hci_add_sco(struct hci_conn *conn, __u16 handle);
@@ -480,6 +517,10 @@ int hci_conn_del(struct hci_conn *conn);
 void hci_conn_hash_flush(struct hci_dev *hdev);
 void hci_conn_check_pending(struct hci_dev *hdev);
 
+struct hci_chan *hci_chan_create(struct hci_conn *conn);
+int hci_chan_del(struct hci_chan *chan);
+void hci_chan_hash_flush(struct hci_conn *conn);
+
 struct hci_conn *hci_connect(struct hci_dev *hdev, int type, bdaddr_t *dst,
 						__u8 sec_level, __u8 auth_type);
 int hci_conn_check_link_mode(struct hci_conn *conn);
@@ -849,7 +890,7 @@ int hci_register_notifier(struct notifier_block *nb);
 int hci_unregister_notifier(struct notifier_block *nb);
 
 int hci_send_cmd(struct hci_dev *hdev, __u16 opcode, __u32 plen, void *param);
-void hci_send_acl(struct hci_conn *conn, struct sk_buff *skb, __u16 flags);
+void hci_send_acl(struct hci_chan *chan, struct sk_buff *skb, __u16 flags);
 void hci_send_sco(struct hci_conn *conn, struct sk_buff *skb);
 
 void *hci_sent_cmd_data(struct hci_dev *hdev, __u16 opcode);
diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
index 5a0a9c8..38458d6 100644
--- a/include/net/bluetooth/l2cap.h
+++ b/include/net/bluetooth/l2cap.h
@@ -454,6 +454,7 @@ struct l2cap_ops {
 
 struct l2cap_conn {
 	struct hci_conn	*hcon;
+	struct hci_chan	*hchan;
 
 	bdaddr_t	*dst;
 	bdaddr_t	*src;
diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index 6e98ff3..e545376 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -374,6 +374,8 @@ struct hci_conn *hci_conn_add(struct hci_dev *hdev, int type, bdaddr_t *dst)
 
 	skb_queue_head_init(&conn->data_q);
 
+	hci_chan_hash_init(conn);
+
 	setup_timer(&conn->disc_timer, hci_conn_timeout, (unsigned long)conn);
 	setup_timer(&conn->idle_timer, hci_conn_idle, (unsigned long)conn);
 	setup_timer(&conn->auto_accept_timer, hci_conn_auto_accept,
@@ -432,6 +434,8 @@ int hci_conn_del(struct hci_conn *conn)
 
 	tasklet_disable(&hdev->tx_task);
 
+	hci_chan_hash_flush(conn);
+
 	hci_conn_hash_del(hdev, conn);
 	if (hdev->notify)
 		hdev->notify(hdev, HCI_NOTIFY_CONN_DEL);
@@ -950,3 +954,52 @@ int hci_get_auth_info(struct hci_dev *hdev, void __user *arg)
 
 	return copy_to_user(arg, &req, sizeof(req)) ? -EFAULT : 0;
 }
+
+struct hci_chan *hci_chan_create(struct hci_conn *conn)
+{
+	struct hci_dev *hdev = conn->hdev;
+	struct hci_chan *chan;
+
+	BT_DBG("%s conn %p", hdev->name, conn);
+
+	chan = kzalloc(sizeof(struct hci_chan), GFP_ATOMIC);
+	if (!chan)
+		return NULL;
+
+	chan->conn = conn;
+	skb_queue_head_init(&chan->data_q);
+
+	tasklet_disable(&hdev->tx_task);
+	hci_chan_hash_add(conn, chan);
+	tasklet_enable(&hdev->tx_task);
+
+	return chan;
+}
+
+int hci_chan_del(struct hci_chan *chan)
+{
+	struct hci_conn *conn = chan->conn;
+	struct hci_dev *hdev = conn->hdev;
+
+	BT_DBG("%s conn %p chan %p", hdev->name, conn, chan);
+
+	tasklet_disable(&hdev->tx_task);
+	hci_chan_hash_del(conn, chan);
+	tasklet_enable(&hdev->tx_task);
+
+	skb_queue_purge(&chan->data_q);
+	kfree(chan);
+
+	return 0;
+}
+
+void hci_chan_hash_flush(struct hci_conn *conn)
+{
+	struct hci_chan_hash *h = &conn->chan_hash;
+	struct hci_chan *chan, *tmp;
+
+	BT_DBG("conn %p", conn);
+
+	list_for_each_entry_safe(chan, tmp, &h->list, list)
+		hci_chan_del(chan);
+}
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index f2ec434..631327d 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -1937,23 +1937,18 @@ static void hci_add_acl_hdr(struct sk_buff *skb, __u16 handle, __u16 flags)
 	hdr->dlen   = cpu_to_le16(len);
 }
 
-void hci_send_acl(struct hci_conn *conn, struct sk_buff *skb, __u16 flags)
+static void hci_queue_acl(struct hci_conn *conn, struct sk_buff_head *queue,
+				struct sk_buff *skb, __u16 flags)
 {
 	struct hci_dev *hdev = conn->hdev;
 	struct sk_buff *list;
 
-	BT_DBG("%s conn %p flags 0x%x", hdev->name, conn, flags);
-
-	skb->dev = (void *) hdev;
-	bt_cb(skb)->pkt_type = HCI_ACLDATA_PKT;
-	hci_add_acl_hdr(skb, conn->handle, flags);
-
 	list = skb_shinfo(skb)->frag_list;
 	if (!list) {
 		/* Non fragmented */
 		BT_DBG("%s nonfrag skb %p len %d", hdev->name, skb, skb->len);
 
-		skb_queue_tail(&conn->data_q, skb);
+		skb_queue_tail(queue, skb);
 	} else {
 		/* Fragmented */
 		BT_DBG("%s frag %p len %d", hdev->name, skb, skb->len);
@@ -1961,9 +1956,9 @@ void hci_send_acl(struct hci_conn *conn, struct sk_buff *skb, __u16 flags)
 		skb_shinfo(skb)->frag_list = NULL;
 
 		/* Queue all fragments atomically */
-		spin_lock_bh(&conn->data_q.lock);
+		spin_lock_bh(&queue->lock);
 
-		__skb_queue_tail(&conn->data_q, skb);
+		__skb_queue_tail(queue, skb);
 
 		flags &= ~ACL_START;
 		flags |= ACL_CONT;
@@ -1976,11 +1971,25 @@ void hci_send_acl(struct hci_conn *conn, struct sk_buff *skb, __u16 flags)
 
 			BT_DBG("%s frag %p len %d", hdev->name, skb, skb->len);
 
-			__skb_queue_tail(&conn->data_q, skb);
+			__skb_queue_tail(queue, skb);
 		} while (list);
 
-		spin_unlock_bh(&conn->data_q.lock);
+		spin_unlock_bh(&queue->lock);
 	}
+}
+
+void hci_send_acl(struct hci_chan *chan, struct sk_buff *skb, __u16 flags)
+{
+	struct hci_conn *conn = chan->conn;
+	struct hci_dev *hdev = conn->hdev;
+
+	BT_DBG("%s chan %p flags 0x%x", hdev->name, chan, flags);
+
+	skb->dev = (void *) hdev;
+	bt_cb(skb)->pkt_type = HCI_ACLDATA_PKT;
+	hci_add_acl_hdr(skb, conn->handle, flags);
+
+	hci_queue_acl(conn, &chan->data_q, skb, flags);
 
 	tasklet_schedule(&hdev->tx_task);
 }
@@ -2083,11 +2092,90 @@ static inline void hci_link_tx_to(struct hci_dev *hdev, __u8 type)
 	}
 }
 
-static inline void hci_sched_acl(struct hci_dev *hdev)
+static inline struct hci_chan *hci_chan_sent(struct hci_dev *hdev, __u8 type,
+						int *quote)
 {
+	struct hci_conn_hash *h = &hdev->conn_hash;
+	struct hci_chan *chan = NULL;
+	int num = 0, min = ~0, cur_prio = 0;
 	struct hci_conn *conn;
+	int cnt, q, conn_num = 0;
+
+	BT_DBG("%s", hdev->name);
+
+	list_for_each_entry(conn, &h->list, list) {
+		struct hci_chan_hash *ch;
+		struct hci_chan *tmp;
+
+		if (conn->type != type)
+			continue;
+
+		if (conn->state != BT_CONNECTED && conn->state != BT_CONFIG)
+			continue;
+
+		conn_num++;
+
+		ch = &conn->chan_hash;
+
+		list_for_each_entry(tmp, &ch->list, list) {
+			struct sk_buff *skb;
+
+			if (skb_queue_empty(&tmp->data_q))
+				continue;
+
+			skb = skb_peek(&tmp->data_q);
+			if (skb->priority < cur_prio)
+				continue;
+
+			if (skb->priority > cur_prio) {
+				num = 0;
+				min = ~0;
+				cur_prio = skb->priority;
+			}
+
+			num++;
+
+			if (conn->sent < min) {
+				min  = conn->sent;
+				chan = tmp;
+			}
+		}
+
+		if (hci_conn_num(hdev, type) == conn_num)
+			break;
+	}
+
+	if (!chan)
+		return NULL;
+
+	switch (chan->conn->type) {
+	case ACL_LINK:
+		cnt = hdev->acl_cnt;
+		break;
+	case SCO_LINK:
+	case ESCO_LINK:
+		cnt = hdev->sco_cnt;
+		break;
+	case LE_LINK:
+		cnt = hdev->le_mtu ? hdev->le_cnt : hdev->acl_cnt;
+		break;
+	default:
+		cnt = 0;
+		BT_ERR("Unknown link type");
+	}
+
+	q = cnt / num;
+	*quote = q ? q : 1;
+	BT_DBG("chan %p quote %d", chan, *quote);
+	return chan;
+}
+
+static inline void hci_sched_acl(struct hci_dev *hdev)
+{
+	struct hci_chan *chan;
 	struct sk_buff *skb;
 	int quote;
+	unsigned int cnt;
 
 	BT_DBG("%s", hdev->name);
 
@@ -2101,17 +2189,23 @@ static inline void hci_sched_acl(struct hci_dev *hdev)
 			hci_link_tx_to(hdev, ACL_LINK);
 	}
 
-	while (hdev->acl_cnt && (conn = hci_low_sent(hdev, ACL_LINK, &quote))) {
-		while (quote-- && (skb = skb_dequeue(&conn->data_q))) {
-			BT_DBG("skb %p len %d", skb, skb->len);
+	cnt = hdev->acl_cnt;
 
-			hci_conn_enter_active_mode(conn, bt_cb(skb)->force_active);
+	while (hdev->acl_cnt &&
+			(chan = hci_chan_sent(hdev, ACL_LINK, &quote))) {
+		while (quote-- && (skb = skb_dequeue(&chan->data_q))) {
+			BT_DBG("chan %p skb %p len %d priority %u", chan, skb,
+					skb->len, skb->priority);
+
+			hci_conn_enter_active_mode(chan->conn,
+						bt_cb(skb)->force_active);
 
 			hci_send_frame(skb);
 			hdev->acl_last_tx = jiffies;
 
 			hdev->acl_cnt--;
-			conn->sent++;
+			chan->sent++;
+			chan->conn->sent++;
 		}
 	}
 }
@@ -2165,7 +2259,7 @@ static inline void hci_sched_esco(struct hci_dev *hdev)
 
 static inline void hci_sched_le(struct hci_dev *hdev)
 {
-	struct hci_conn *conn;
+	struct hci_chan *chan;
 	struct sk_buff *skb;
 	int quote, cnt;
 
@@ -2183,17 +2277,20 @@ static inline void hci_sched_le(struct hci_dev *hdev)
 	}
 
 	cnt = hdev->le_pkts ? hdev->le_cnt : hdev->acl_cnt;
-	while (cnt && (conn = hci_low_sent(hdev, LE_LINK, &quote))) {
-		while (quote-- && (skb = skb_dequeue(&conn->data_q))) {
-			BT_DBG("skb %p len %d", skb, skb->len);
+	while (cnt && (chan = hci_chan_sent(hdev, LE_LINK, &quote))) {
+		while (quote-- && (skb = skb_dequeue(&chan->data_q))) {
+			BT_DBG("chan %p skb %p len %d priority %u", chan, skb,
+					skb->len, skb->priority);
 
 			hci_send_frame(skb);
 			hdev->le_last_tx = jiffies;
 
 			cnt--;
-			conn->sent++;
+			chan->sent++;
+			chan->conn->sent++;
 		}
 	}
+
 	if (hdev->le_pkts)
 		hdev->le_cnt = cnt;
 	else
diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index af3e8c5..25d5b9c 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -566,7 +566,25 @@ static void l2cap_send_cmd(struct l2cap_conn *conn, u8 ident, u8 code, u16 len,
 	bt_cb(skb)->force_active = BT_POWER_FORCE_ACTIVE_ON;
 	skb->priority = HCI_PRIO_MAX;
 
-	hci_send_acl(conn->hcon, skb, flags);
+	hci_send_acl(conn->hchan, skb, flags);
+}
+
+static void l2cap_do_send(struct l2cap_chan *chan, struct sk_buff *skb)
+{
+	struct hci_conn *hcon = chan->conn->hcon;
+	u16 flags;
+
+	BT_DBG("chan %p, skb %p len %d priority %u", chan, skb, skb->len,
+							skb->priority);
+
+	if (!test_bit(FLAG_FLUSHABLE, &chan->flags) &&
+					lmp_no_flush_capable(hcon->hdev))
+		flags = ACL_START_NO_FLUSH;
+	else
+		flags = ACL_START;
+
+	bt_cb(skb)->force_active = test_bit(FLAG_FORCE_ACTIVE, &chan->flags);
+	hci_send_acl(chan->conn->hchan, skb, flags);
 }
 
 static inline void l2cap_send_sframe(struct l2cap_chan *chan, u32 control)
@@ -575,7 +593,6 @@ static inline void l2cap_send_sframe(struct l2cap_chan *chan, u32 control)
 	struct l2cap_hdr *lh;
 	struct l2cap_conn *conn = chan->conn;
 	int count, hlen;
-	u8 flags;
 
 	if (chan->state != BT_CONNECTED)
 		return;
@@ -615,14 +632,8 @@ static inline void l2cap_send_sframe(struct l2cap_chan *chan, u32 control)
 		put_unaligned_le16(fcs, skb_put(skb, L2CAP_FCS_SIZE));
 	}
 
-	if (lmp_no_flush_capable(conn->hcon->hdev))
-		flags = ACL_START_NO_FLUSH;
-	else
-		flags = ACL_START;
-
-	bt_cb(skb)->force_active = test_bit(FLAG_FORCE_ACTIVE, &chan->flags);
-
-	hci_send_acl(chan->conn->hcon, skb, flags);
+	skb->priority = HCI_PRIO_MAX;
+	l2cap_do_send(chan, skb);
 }
 
 static inline void l2cap_send_rr_or_rnr(struct l2cap_chan *chan, u32 control)
@@ -1002,6 +1013,8 @@ static void l2cap_conn_del(struct hci_conn *hcon, int err)
 		chan->ops->close(chan->data);
 	}
 
+	hci_chan_del(conn->hchan);
+
 	if (conn->info_state & L2CAP_INFO_FEAT_MASK_REQ_SENT)
 		del_timer_sync(&conn->info_timer);
 
@@ -1024,18 +1037,26 @@ static void security_timeout(unsigned long arg)
 static struct l2cap_conn *l2cap_conn_add(struct hci_conn *hcon, u8 status)
 {
 	struct l2cap_conn *conn = hcon->l2cap_data;
+	struct hci_chan *hchan;
 
 	if (conn || status)
 		return conn;
 
+	hchan = hci_chan_create(hcon);
+	if (!hchan)
+		return NULL;
+
 	conn = kzalloc(sizeof(struct l2cap_conn), GFP_ATOMIC);
-	if (!conn)
+	if (!conn) {
+		hci_chan_del(hchan);
 		return NULL;
+	}
 
 	hcon->l2cap_data = conn;
 	conn->hcon = hcon;
+	conn->hchan = hchan;
 
-	BT_DBG("hcon %p conn %p", hcon, conn);
+	BT_DBG("hcon %p conn %p hchan %p", hcon, conn, hchan);
 
 	if (hcon->hdev->le_mtu && hcon->type == LE_LINK)
 		conn->mtu = hcon->hdev->le_mtu;
@@ -1261,24 +1282,6 @@ static void l2cap_drop_acked_frames(struct l2cap_chan *chan)
 		__clear_retrans_timer(chan);
 }
 
-static void l2cap_do_send(struct l2cap_chan *chan, struct sk_buff *skb)
-{
-	struct hci_conn *hcon = chan->conn->hcon;
-	u16 flags;
-
-	BT_DBG("chan %p, skb %p len %d priority %u", chan, skb, skb->len,
-							skb->priority);
-
-	if (!test_bit(FLAG_FLUSHABLE, &chan->flags) &&
-					lmp_no_flush_capable(hcon->hdev))
-		flags = ACL_START_NO_FLUSH;
-	else
-		flags = ACL_START;
-
-	bt_cb(skb)->force_active = test_bit(FLAG_FORCE_ACTIVE, &chan->flags);
-	hci_send_acl(hcon, skb, flags);
-}
-
 static void l2cap_streaming_send(struct l2cap_chan *chan)
 {
 	struct sk_buff *skb;
diff --git a/net/bluetooth/smp.c b/net/bluetooth/smp.c
index 759b635..94e94ca 100644
--- a/net/bluetooth/smp.c
+++ b/net/bluetooth/smp.c
@@ -181,7 +181,8 @@ static void smp_send_cmd(struct l2cap_conn *conn, u8 code, u16 len, void *data)
 	if (!skb)
 		return;
 
-	hci_send_acl(conn->hcon, skb, 0);
+	skb->priority = HCI_PRIO_MAX;
+	hci_send_acl(conn->hchan, skb, 0);
 
 	mod_timer(&conn->security_timer, jiffies +
 					msecs_to_jiffies(SMP_TIMEOUT));
-- 
1.7.6.4

