Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <4604B9F2.5040808@xmission.com>
Date: Fri, 23 Mar 2007 23:41:06 -0600
From: Brad Midgley <bmidgley@xmission.com>
MIME-Version: 1.0
To: BlueZ development <bluez-devel@lists.sourceforge.net>
References: <45FE8B0B.20500@xmission.com>
	<1174486267.15638.25.camel@aeonflux.holtmann.net>
In-Reply-To: <1174486267.15638.25.camel@aeonflux.holtmann.net>
Content-Type: multipart/mixed; boundary="------------050207020307040202050100"
Subject: Re: [Bluez-devel] new sco flowcontrol patch
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

This is a multi-part message in MIME format.
--------------050207020307040202050100
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Marcel

> The biggest thing however is hci_sched_sco(). This function is ugly as
> hell and basically unreadable. Please use break or continue instead of
> cascaded if clauses. I am not gonna review this piece of the patch until
> that is fixed.

I fixed a few whitespace problems and changed hci_sched_sco so it didn't 
get deep into nested if's. How does it look now?

Brad

--------------050207020307040202050100
Content-Type: text/plain;
 name="sco-flowcontrol-v4.1.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="sco-flowcontrol-v4.1.diff"

diff --git a/include/net/bluetooth/bluetooth.h b/include/net/bluetooth/bluetooth.h
diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index c0fc396..bd9be7a 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -25,6 +25,8 @@
 #ifndef __HCI_CORE_H
 #define __HCI_CORE_H
 
+#include <linux/hrtimer.h>
+
 #include <net/bluetooth/hci.h>
 
 /* HCI upper protocols */
@@ -89,7 +91,7 @@ struct hci_dev {
 
 	atomic_t	cmd_cnt;
 	unsigned int	acl_cnt;
-	unsigned int	sco_cnt;
+	atomic_t	sco_cnt;
 
 	unsigned int	acl_mtu;
 	unsigned int	sco_mtu;
@@ -145,7 +147,6 @@ struct hci_conn {
 	struct list_head list;
 
 	atomic_t	 refcnt;
-	spinlock_t	 lock;
 
 	bdaddr_t	 dst;
 	__u16		 handle;
@@ -162,10 +163,11 @@ struct hci_conn {
 	__u8             power_save;
 	unsigned long	 pend;
 
-	unsigned int	 sent;
+	atomic_t	 sent;
 
 	struct sk_buff_head data_q;
 
+	struct hrtimer tx_timer;
 	struct timer_list disc_timer;
 	struct timer_list idle_timer;
 
diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
diff --git a/include/net/bluetooth/rfcomm.h b/include/net/bluetooth/rfcomm.h
diff --git a/include/net/bluetooth/sco.h b/include/net/bluetooth/sco.h
index e28a2a7..4ba976b 100644
--- a/include/net/bluetooth/sco.h
+++ b/include/net/bluetooth/sco.h
@@ -26,12 +26,7 @@ #ifndef __SCO_H
 #define __SCO_H
 
 /* SCO defaults */
-#define SCO_DEFAULT_MTU		500
-#define SCO_DEFAULT_FLUSH_TO	0xFFFF
-
 #define SCO_CONN_TIMEOUT	(HZ * 40)
-#define SCO_DISCONN_TIMEOUT	(HZ * 2)
-#define SCO_CONN_IDLE_TIMEOUT	(HZ * 60)
 
 /* SCO socket address */
 struct sockaddr_sco {
@@ -51,6 +46,9 @@ struct sco_conninfo {
 	__u8  dev_class[3];
 };
 
+#define SCO_TXBUFS	0x03
+#define SCO_RXBUFS	0x04
+
 /* ---- SCO connections ---- */
 struct sco_conn {
 	struct hci_conn	*hcon;
diff --git a/net/bluetooth/Kconfig b/net/bluetooth/Kconfig
diff --git a/net/bluetooth/Makefile b/net/bluetooth/Makefile
diff --git a/net/bluetooth/af_bluetooth.c b/net/bluetooth/af_bluetooth.c
diff --git a/net/bluetooth/bnep/Kconfig b/net/bluetooth/bnep/Kconfig
diff --git a/net/bluetooth/bnep/Makefile b/net/bluetooth/bnep/Makefile
diff --git a/net/bluetooth/bnep/bnep.h b/net/bluetooth/bnep/bnep.h
diff --git a/net/bluetooth/bnep/core.c b/net/bluetooth/bnep/core.c
diff --git a/net/bluetooth/bnep/netdev.c b/net/bluetooth/bnep/netdev.c
diff --git a/net/bluetooth/bnep/sock.c b/net/bluetooth/bnep/sock.c
diff --git a/net/bluetooth/cmtp/Kconfig b/net/bluetooth/cmtp/Kconfig
diff --git a/net/bluetooth/cmtp/Makefile b/net/bluetooth/cmtp/Makefile
diff --git a/net/bluetooth/cmtp/capi.c b/net/bluetooth/cmtp/capi.c
diff --git a/net/bluetooth/cmtp/cmtp.h b/net/bluetooth/cmtp/cmtp.h
diff --git a/net/bluetooth/cmtp/core.c b/net/bluetooth/cmtp/core.c
diff --git a/net/bluetooth/cmtp/sock.c b/net/bluetooth/cmtp/sock.c
diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index f3403fd..72c7a07 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -185,6 +185,8 @@ struct hci_conn *hci_conn_add(struct hci
 
 	skb_queue_head_init(&conn->data_q);
 
+	hrtimer_init(&conn->tx_timer, CLOCK_MONOTONIC, HRTIMER_NORESTART);
+
 	init_timer(&conn->disc_timer);
 	conn->disc_timer.function = hci_conn_timeout;
 	conn->disc_timer.data = (unsigned long) conn;
@@ -194,6 +196,7 @@ struct hci_conn *hci_conn_add(struct hci
 	conn->idle_timer.data = (unsigned long) conn;
 
 	atomic_set(&conn->refcnt, 0);
+	atomic_set(&conn->sent, 0);
 
 	hci_dev_hold(hdev);
 
@@ -220,6 +223,8 @@ int hci_conn_del(struct hci_conn *conn)
 
 	del_timer(&conn->disc_timer);
 
+	hrtimer_cancel(&conn->tx_timer);
+
 	if (conn->type == SCO_LINK) {
 		struct hci_conn *acl = conn->link;
 		if (acl) {
@@ -232,7 +237,7 @@ int hci_conn_del(struct hci_conn *conn)
 			sco->link = NULL;
 
 		/* Unacked frames */
-		hdev->acl_cnt += conn->sent;
+		hdev->acl_cnt += atomic_read(&conn->sent);
 	}
 
 	tasklet_disable(&hdev->tx_task);
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 4917919..30071c6 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -620,7 +620,8 @@ int hci_dev_reset(__u16 dev)
 		hdev->flush(hdev);
 
 	atomic_set(&hdev->cmd_cnt, 1);
-	hdev->acl_cnt = 0; hdev->sco_cnt = 0;
+	atomic_set(&hdev->sco_cnt, 0);
+	hdev->acl_cnt = 0;
 
 	if (!test_bit(HCI_RAW, &hdev->flags))
 		ret = __hci_request(hdev, hci_reset_req, 0,
@@ -1132,14 +1133,25 @@ int hci_send_sco(struct hci_conn *conn, 
 {
 	struct hci_dev *hdev = conn->hdev;
 	struct hci_sco_hdr hdr;
-
-	BT_DBG("%s len %d", hdev->name, skb->len);
+	ktime_t now = conn->tx_timer.base->get_time();
+#ifdef CONFIG_BT_HCI_CORE_DEBUG
+	ktime_t timer_exp = conn->tx_timer.expires;
+	BT_DBG("conn %p skb %p, timer %5lu.%06lu", conn, skb,
+		(unsigned long) timer_exp.tv64, 
+		do_div(timer_exp.tv64, NSEC_PER_SEC) / 1000);
+#endif
 
 	if (skb->len > hdev->sco_mtu) {
 		kfree_skb(skb);
 		return -EINVAL;
 	}
 
+	/* Criteria for underrun condition : more than 100 ms late */
+	if(conn->tx_timer.expires.tv64 + NSEC_PER_SEC / 10 <= now.tv64) {
+		/* We are under underrun condition, just we do a clean start */
+		conn->tx_timer.expires = now;
+	}
+
 	hdr.handle = __cpu_to_le16(conn->handle);
 	hdr.dlen   = skb->len;
 
@@ -1156,12 +1168,12 @@ EXPORT_SYMBOL(hci_send_sco);
 
 /* ---- HCI TX task (outgoing data) ---- */
 
-/* HCI Connection scheduler */
-static inline struct hci_conn *hci_low_sent(struct hci_dev *hdev, __u8 type, int *quote)
+/* HCI ACL Connection scheduler */
+static inline struct hci_conn *hci_low_sent_acl(struct hci_dev *hdev, int *quote)
 {
 	struct hci_conn_hash *h = &hdev->conn_hash;
 	struct hci_conn  *conn = NULL;
-	int num = 0, min = ~0;
+	unsigned int num = 0, min = ~0;
 	struct list_head *p;
 
 	/* We don't have to lock device here. Connections are always
@@ -1170,20 +1182,22 @@ static inline struct hci_conn *hci_low_s
 		struct hci_conn *c;
 		c = list_entry(p, struct hci_conn, list);
 
-		if (c->type != type || c->state != BT_CONNECTED
+		BT_DBG("c->type %d c->state %d len(c->data_q) %d min %d c->sent %d", 
+			c->type, c->state, skb_queue_len(&c->data_q), min, atomic_read(&c->sent));
+
+		if (c->type != ACL_LINK || c->state != BT_CONNECTED
 				|| skb_queue_empty(&c->data_q))
 			continue;
 		num++;
 
-		if (c->sent < min) {
-			min  = c->sent;
+		if (atomic_read(&c->sent) < min) {
+			min  = atomic_read(&c->sent);
 			conn = c;
 		}
 	}
 
 	if (conn) {
-		int cnt = (type == ACL_LINK ? hdev->acl_cnt : hdev->sco_cnt);
-		int q = cnt / num;
+		int q = hdev->acl_cnt / num;
 		*quote = q ? q : 1;
 	} else
 		*quote = 0;
@@ -1203,7 +1217,7 @@ static inline void hci_acl_tx_to(struct 
 	/* Kill stalled connections */
 	list_for_each(p, &h->list) {
 		c = list_entry(p, struct hci_conn, list);
-		if (c->type == ACL_LINK && c->sent) {
+		if (c->type == ACL_LINK && atomic_read(&c->sent)) {
 			BT_ERR("%s killing stalled ACL connection %s",
 				hdev->name, batostr(&c->dst));
 			hci_acl_disconn(c, 0x13);
@@ -1226,7 +1240,7 @@ static inline void hci_sched_acl(struct 
 			hci_acl_tx_to(hdev);
 	}
 
-	while (hdev->acl_cnt && (conn = hci_low_sent(hdev, ACL_LINK, &quote))) {
+	while (hdev->acl_cnt && (conn = hci_low_sent_acl(hdev, &quote))) {
 		while (quote-- && (skb = skb_dequeue(&conn->data_q))) {
 			BT_DBG("skb %p len %d", skb, skb->len);
 
@@ -1236,28 +1250,85 @@ static inline void hci_sched_acl(struct 
 			hdev->acl_last_tx = jiffies;
 
 			hdev->acl_cnt--;
-			conn->sent++;
+			atomic_inc(&conn->sent);
 		}
 	}
 }
 
-/* Schedule SCO */
+/* HCI SCO tx timer */
+
+static  enum hrtimer_restart hci_sco_tx_timer(struct hrtimer *timer)
+{
+	struct hci_conn *conn = container_of(timer, struct hci_conn, tx_timer);
+#ifdef CONFIG_BT_HCI_CORE_DEBUG
+	ktime_t now = timer->base->get_time();
+
+	BT_DBG("%s, conn %p, time %5lu.%06lu", conn->hdev->name, conn,
+		(unsigned long) now.tv64, 
+		do_div(now.tv64, NSEC_PER_SEC) / 1000);
+#endif
+
+	if(atomic_read(&conn->sent) > 0) {
+		atomic_dec(&conn->sent);
+		atomic_inc(&conn->hdev->sco_cnt);
+		hci_sched_tx(conn->hdev);
+	}
+	return HRTIMER_NORESTART;
+}
+ 
+/* HCI SCO Connection scheduler */
+
 static inline void hci_sched_sco(struct hci_dev *hdev)
 {
-	struct hci_conn *conn;
+	struct hci_conn_hash *h = &hdev->conn_hash;
 	struct sk_buff *skb;
-	int quote;
-
+	struct list_head *p;
+	struct hci_conn *c;
+	ktime_t now, pkt_time;
+	
 	BT_DBG("%s", hdev->name);
+  
+	/* We don't have to lock device here. Connections are always 
+	 * added and removed with TX task disabled. */
+	list_for_each(p, &h->list) {
+		c = list_entry(p, struct hci_conn, list);
+  
+		/* SCO scheduling algorithm makes sure there is never more than
+		   1 outstanding packet for each connection */
 
-	while (hdev->sco_cnt && (conn = hci_low_sent(hdev, SCO_LINK, &quote))) {
-		while (quote-- && (skb = skb_dequeue(&conn->data_q))) {
-			BT_DBG("skb %p len %d", skb, skb->len);
-			hci_send_frame(skb);
+		if (c->type != SCO_LINK)
+			continue;
 
-			conn->sent++;
-			if (conn->sent == ~0)
-				conn->sent = 0;
+		if (atomic_read(&c->sent) >= 1)
+			continue;
+
+		if (c->state != BT_CONNECTED)
+			continue;
+
+		if(atomic_read(&hdev->sco_cnt) <= 0)
+			continue;
+
+		if((skb = skb_dequeue(&c->data_q)) == NULL)
+			continue;
+
+		hci_send_frame(skb);
+ 
+		atomic_inc(&c->sent);			
+		atomic_dec(&hdev->sco_cnt);
+
+		c->tx_timer.function = hci_sco_tx_timer;
+					
+		pkt_time = ktime_set(0, NSEC_PER_SEC / 16000 * (skb->len - HCI_SCO_HDR_SIZE));
+		now = c->tx_timer.base->get_time();
+
+		c->tx_timer.expires.tv64 += pkt_time.tv64;
+		if(c->tx_timer.expires.tv64 > now.tv64) {
+			hrtimer_restart(&c->tx_timer);
+		} else {
+			/* Timer is to expire in the past - this can happen if timer base
+			 precision is less than pkt_time. In this case we force timer
+			 expiration by calling its expires function */
+			c->tx_timer.function(&c->tx_timer);
 		}
 	}
 }
@@ -1269,14 +1340,14 @@ static void hci_tx_task(unsigned long ar
 
 	read_lock(&hci_task_lock);
 
-	BT_DBG("%s acl %d sco %d", hdev->name, hdev->acl_cnt, hdev->sco_cnt);
+	BT_DBG("%s acl %d sco %d", hdev->name, hdev->acl_cnt, atomic_read(&hdev->sco_cnt));
 
 	/* Schedule queues and send stuff to HCI driver */
 
-	hci_sched_acl(hdev);
-
 	hci_sched_sco(hdev);
 
+	hci_sched_acl(hdev);
+
 	/* Send next queued raw (unknown type) packet */
 	while ((skb = skb_dequeue(&hdev->raw_q)))
 		hci_send_frame(skb);
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 936d3fc..e220e0a 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -319,7 +319,7 @@ static void hci_cc_info_param(struct hci
 		lv = (struct hci_rp_read_loc_version *) skb->data;
 
 		if (lv->status) {
-			BT_DBG("%s READ_LOCAL_VERSION failed %d", hdev->name, lf->status);
+			BT_DBG("%s READ_LOCAL_VERSION failed %d", hdev->name, lv->status);
 			break;
 		}
 
@@ -381,7 +381,7 @@ static void hci_cc_info_param(struct hci
 		}
 
 		hdev->acl_cnt = hdev->acl_pkts;
-		hdev->sco_cnt = hdev->sco_pkts;
+		atomic_set(&hdev->sco_cnt, hdev->sco_pkts);
 
 		BT_DBG("%s mtu: acl %d, sco %d max_pkt: acl %d, sco %d", hdev->name,
 			hdev->acl_mtu, hdev->sco_mtu, hdev->acl_pkts, hdev->sco_pkts);
@@ -879,12 +879,9 @@ static inline void hci_num_comp_pkts_evt
 
 		conn = hci_conn_hash_lookup_handle(hdev, handle);
 		if (conn) {
-			conn->sent -= count;
+			atomic_sub(count, &conn->sent);
 
-			if (conn->type == SCO_LINK) {
-				if ((hdev->sco_cnt += count) > hdev->sco_pkts)
-					hdev->sco_cnt = hdev->sco_pkts;
-			} else {
+			if (conn->type == ACL_LINK) {
 				if ((hdev->acl_cnt += count) > hdev->acl_pkts)
 					hdev->acl_cnt = hdev->acl_pkts;
 			}
diff --git a/net/bluetooth/hci_sock.c b/net/bluetooth/hci_sock.c
diff --git a/net/bluetooth/hci_sysfs.c b/net/bluetooth/hci_sysfs.c
diff --git a/net/bluetooth/hidp/Kconfig b/net/bluetooth/hidp/Kconfig
diff --git a/net/bluetooth/hidp/Makefile b/net/bluetooth/hidp/Makefile
diff --git a/net/bluetooth/hidp/core.c b/net/bluetooth/hidp/core.c
diff --git a/net/bluetooth/hidp/hidp.h b/net/bluetooth/hidp/hidp.h
diff --git a/net/bluetooth/hidp/sock.c b/net/bluetooth/hidp/sock.c
diff --git a/net/bluetooth/l2cap.c b/net/bluetooth/l2cap.c
diff --git a/net/bluetooth/lib.c b/net/bluetooth/lib.c
diff --git a/net/bluetooth/rfcomm/Kconfig b/net/bluetooth/rfcomm/Kconfig
diff --git a/net/bluetooth/rfcomm/Makefile b/net/bluetooth/rfcomm/Makefile
diff --git a/net/bluetooth/rfcomm/core.c b/net/bluetooth/rfcomm/core.c
diff --git a/net/bluetooth/rfcomm/sock.c b/net/bluetooth/rfcomm/sock.c
diff --git a/net/bluetooth/rfcomm/tty.c b/net/bluetooth/rfcomm/tty.c
diff --git a/net/bluetooth/sco.c b/net/bluetooth/sco.c
index ae43914..005e5e0 100644
--- a/net/bluetooth/sco.c
+++ b/net/bluetooth/sco.c
@@ -53,7 +53,13 @@ #undef  BT_DBG
 #define BT_DBG(D...)
 #endif
 
-#define VERSION "0.5"
+#define VERSION "0.6"
+
+#define MAX_SCO_TXBUFS 200
+#define MAX_SCO_RXBUFS 200
+
+#define DEFAULT_SCO_TXBUFS 5
+#define DEFAULT_SCO_RXBUFS 5
 
 static const struct proto_ops sco_sock_ops;
 
@@ -69,6 +75,35 @@ static int  sco_conn_del(struct hci_conn
 static void sco_sock_close(struct sock *sk);
 static void sco_sock_kill(struct sock *sk);
 
+static int sco_sock_queue_rcv_skb(struct sock *sk, struct sk_buff *skb);
+
+/* 
+ * Write buffer destructor automatically called from kfree_skb. 
+ */
+void sco_sock_wfree(struct sk_buff *skb)
+{
+	struct sock *sk = skb->sk;
+
+	atomic_dec(&sk->sk_wmem_alloc);
+	sk->sk_write_space(sk);
+	sock_put(sk);
+}
+
+static void sco_sock_write_space(struct sock *sk)
+{
+	read_lock(&sk->sk_callback_lock);
+
+	if(atomic_read(&sk->sk_wmem_alloc) < sk->sk_sndbuf) {
+		if (sk->sk_sleep && waitqueue_active(sk->sk_sleep))
+			wake_up_interruptible(sk->sk_sleep);
+
+		if (sock_writeable(sk))
+			sk_wake_async(sk, 2, POLL_OUT);
+	}
+
+	read_unlock(&sk->sk_callback_lock);
+}
+
 /* ---- SCO timers ---- */
 static void sco_sock_timeout(unsigned long arg)
 {
@@ -234,27 +269,30 @@ static inline int sco_send_frame(struct 
 {
 	struct sco_conn *conn = sco_pi(sk)->conn;
 	struct sk_buff *skb;
-	int err, count;
-
-	/* Check outgoing MTU */
-	if (len > conn->mtu)
-		return -EINVAL;
+	int err;
 
 	BT_DBG("sk %p len %d", sk, len);
 
-	count = min_t(unsigned int, conn->mtu, len);
-	if (!(skb = bt_skb_send_alloc(sk, count, msg->msg_flags & MSG_DONTWAIT, &err)))
+	if (!(skb = bt_skb_send_alloc(sk, len, msg->msg_flags & MSG_DONTWAIT, &err)))
 		return err;
 
-	if (memcpy_fromiovec(skb_put(skb, count), msg->msg_iov, count)) {
+	/* fix sk_wmem_alloc value : by default it is increased by  skb->truesize, but
+	we want it only increased by 1 */
+	atomic_sub(skb->truesize - 1, &sk->sk_wmem_alloc);
+	/* fix destructor */
+	skb->destructor = sco_sock_wfree;
+
+	if (memcpy_fromiovec(skb_put(skb, len), msg->msg_iov, len)) {
 		err = -EFAULT;
 		goto fail;
 	}
 
-	if ((err = hci_send_sco(conn->hcon, skb)) < 0)
-		return err;
+	err = hci_send_sco(conn->hcon, skb);
 
-	return count;
+	if (err < 0)
+		goto fail;
+
+	return len;
 
 fail:
 	kfree_skb(skb);
@@ -273,8 +311,9 @@ static inline void sco_recv_frame(struct
 	if (sk->sk_state != BT_CONNECTED)
 		goto drop;
 
-	if (!sock_queue_rcv_skb(sk, skb))
+	if (sco_sock_queue_rcv_skb(sk, skb) == 0) {
 		return;
+	}
 
 drop:
 	kfree_skb(skb);
@@ -328,7 +367,6 @@ static void sco_sock_destruct(struct soc
 	BT_DBG("sk %p", sk);
 
 	skb_queue_purge(&sk->sk_receive_queue);
-	skb_queue_purge(&sk->sk_write_queue);
 }
 
 static void sco_sock_cleanup_listen(struct sock *parent)
@@ -376,7 +414,7 @@ static void sco_sock_close(struct sock *
 
 	conn = sco_pi(sk)->conn;
 
-	BT_DBG("sk %p state %d conn %p socket %p", sk, sk->sk_state, conn, sk->sk_socket);
+	BT_DBG("sk %p state %d conn %p socket %p refcnt %d", sk, sk->sk_state, conn, sk->sk_socket, atomic_read(&sk->sk_refcnt));
 
 	switch (sk->sk_state) {
 	case BT_LISTEN:
@@ -426,6 +464,10 @@ static struct sock *sco_sock_alloc(struc
 	INIT_LIST_HEAD(&bt_sk(sk)->accept_q);
 
 	sk->sk_destruct = sco_sock_destruct;
+	sk->sk_write_space = sco_sock_write_space;
+
+	sk->sk_sndbuf = DEFAULT_SCO_TXBUFS;
+	sk->sk_rcvbuf = DEFAULT_SCO_RXBUFS;
 	sk->sk_sndtimeo = SCO_CONN_TIMEOUT;
 
 	sock_reset_flag(sk, SOCK_ZAPPED);
@@ -656,6 +698,7 @@ static int sco_sock_sendmsg(struct kiocb
 static int sco_sock_setsockopt(struct socket *sock, int level, int optname, char __user *optval, int optlen)
 {
 	struct sock *sk = sock->sk;
+	u32 opt;
 	int err = 0;
 
 	BT_DBG("sk %p", sk);
@@ -663,6 +706,35 @@ static int sco_sock_setsockopt(struct so
 	lock_sock(sk);
 
 	switch (optname) {
+	case SCO_TXBUFS:
+		if (get_user(opt, (u32 __user *) optval)) {
+			err = -EFAULT;
+			break;
+		}
+		if(opt > MAX_SCO_TXBUFS) {
+			err = -EINVAL;
+			break;
+		}
+
+		sk->sk_sndbuf = opt;
+		/*
+		 *	Wake up sending tasks if we
+		 *	upped the value.
+		 */
+		sk->sk_write_space(sk);
+		break;
+	case SCO_RXBUFS:
+		if (get_user(opt, (u32 __user *) optval)) {
+			err = -EFAULT;
+			break;
+		}
+		if(opt > MAX_SCO_RXBUFS) {
+			err = -EINVAL;
+			break;
+		}
+
+		sk->sk_rcvbuf = opt;
+		break;
 	default:
 		err = -ENOPROTOOPT;
 		break;
@@ -678,6 +750,7 @@ static int sco_sock_getsockopt(struct so
 	struct sco_options opts;
 	struct sco_conninfo cinfo;
 	int len, err = 0;
+	int val;
 
 	BT_DBG("sk %p", sk);
 
@@ -687,6 +760,24 @@ static int sco_sock_getsockopt(struct so
 	lock_sock(sk);
 
 	switch (optname) {
+	case SCO_RXBUFS:
+		val = sk->sk_rcvbuf;
+
+		len = min_t(unsigned int, len, sizeof(val));
+		if (copy_to_user(optval, (char *)&val, len))
+			err = -EFAULT;
+
+		break;
+
+	case SCO_TXBUFS:
+		val = sk->sk_sndbuf;
+
+		len = min_t(unsigned int, len, sizeof(val));
+		if (copy_to_user(optval, (char *)&val, len))
+			err = -EFAULT;
+
+		break;
+
 	case SCO_OPTIONS:
 		if (sk->sk_state != BT_CONNECTED) {
 			err = -ENOTCONN;
@@ -891,6 +982,32 @@ drop:
 	return 0;
 }
 
+static int sco_sock_queue_rcv_skb(struct sock *sk, struct sk_buff *skb)
+{
+       int err = 0;
+
+       BT_DBG("sock %p, sk_rcvbuf %d, qlen %d", sk, sk->sk_rcvbuf, skb_queue_len(&sk->sk_receive_queue));
+       /* Cast skb->rcvbuf to unsigned... It's pointless, but reduces
+          number of warnings when compiling with -W --ANK
+        */
+       if (skb_queue_len(&sk->sk_receive_queue) + 1 >
+           (unsigned)sk->sk_rcvbuf) {
+               err = -ENOMEM;
+               goto out;
+       }
+
+       skb->dev = NULL;
+       skb->sk = sk;
+       skb->destructor = NULL;
+
+       skb_queue_tail(&sk->sk_receive_queue, skb);
+
+       if (!sock_flag(sk, SOCK_DEAD))
+               sk->sk_data_ready(sk, 1);
+out:
+       return err;
+}
+
 static ssize_t sco_sysfs_show(struct class *dev, char *buf)
 {
 	struct sock *sk;

--------------050207020307040202050100
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
--------------050207020307040202050100
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--------------050207020307040202050100--
