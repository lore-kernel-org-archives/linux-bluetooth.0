Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
From: "Ing.Gerhard Scheutz" <scheutz@grosspointner.at>
To: bluez-devel@lists.sourceforge.net
Content-Type: multipart/mixed; boundary="=-l8g1hfDP3dWAIixv9Txe"
Date: Fri, 09 Nov 2007 12:59:41 +0100
Message-Id: <1194609581.5314.9.camel@kermlx.grosspointner.intern>
Mime-Version: 1.0
Subject: [Bluez-devel] sco-flowcontrol patch for openSUSE 10.3
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net


--=-l8g1hfDP3dWAIixv9Txe
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi,

I have modified the the sco-flowcontrol-v4.4.diff for th openSUSE 10.3
Kernel linux-2.6.22.9-0.4.

The headsetd is working with my BLUETREK G3 :-)
Maybe someone can test it too.

Best regards from Austria 

  Kerm

-- 
------------------------------------------------------------------------ 
Ing. Gerhard Scheutz

GROSSPOINTNER GmbH & Co.KG
IT Lösungen
                                            t: +43 6135 20820
Sarstein 17                                 e: scheutz@grosspointner.at
4822 Bad Goisern                            i: www.grosspointner.at
------------------------------------------------------------------------


--=-l8g1hfDP3dWAIixv9Txe
Content-Disposition: attachment;
	filename=openSUSE-linux-2.6.22.9-0.4-sco-flowcontrol-v4.4.diff
Content-Type: text/x-patch;
	name=openSUSE-linux-2.6.22.9-0.4-sco-flowcontrol-v4.4.diff;
	charset=UTF-8
Content-Transfer-Encoding: 7bit

--- linux-2.6.22.9-0.4/include/net/bluetooth/hci_core.h	2007-07-09 01:32:17.000000000 +0200
+++ linux-2.6.22.9-0.4-mypatch/include/net/bluetooth/hci_core.h	2007-10-25 11:39:22.000000000 +0200
@@ -25,6 +25,8 @@
 #ifndef __HCI_CORE_H
 #define __HCI_CORE_H
 
+#include <linux/hrtimer.h>
+
 #include <net/bluetooth/hci.h>
 
 /* HCI upper protocols */
@@ -89,7 +91,7 @@
 
 	atomic_t	cmd_cnt;
 	unsigned int	acl_cnt;
-	unsigned int	sco_cnt;
+	atomic_t	sco_cnt;
 
 	unsigned int	acl_mtu;
 	unsigned int	sco_mtu;
@@ -145,7 +147,6 @@
 	struct list_head list;
 
 	atomic_t	 refcnt;
-	spinlock_t	 lock;
 
 	bdaddr_t	 dst;
 	__u16		 handle;
@@ -162,10 +163,11 @@
 	__u8             power_save;
 	unsigned long	 pend;
 
-	unsigned int	 sent;
+	atomic_t	 sent;
 
 	struct sk_buff_head data_q;
 
+	struct hrtimer tx_timer;
 	struct timer_list disc_timer;
 	struct timer_list idle_timer;
 
--- linux-2.6.22.9-0.4/include/net/bluetooth/sco.h	2007-07-09 01:32:17.000000000 +0200
+++ linux-2.6.22.9-0.4-mypatch/include/net/bluetooth/sco.h	2007-10-25 11:45:09.000000000 +0200
@@ -26,12 +26,7 @@
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
--- linux-2.6.22.9-0.4/net/bluetooth/hci_conn.c	2007-07-09 01:32:17.000000000 +0200
+++ linux-2.6.22.9-0.4-mypatch/net/bluetooth/hci_conn.c	2007-10-25 11:58:47.000000000 +0200
@@ -165,6 +165,26 @@
 	hci_conn_enter_sniff_mode(conn);
 }
 
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
+	if (atomic_read(&conn->sent) > 0) {
+		atomic_dec(&conn->sent);
+		atomic_inc(&conn->hdev->sco_cnt);
+		hci_sched_tx(conn->hdev);
+	}
+	return HRTIMER_NORESTART;
+}
+ 
+
 struct hci_conn *hci_conn_add(struct hci_dev *hdev, int type, bdaddr_t *dst)
 {
 	struct hci_conn *conn;
@@ -185,6 +205,11 @@
 
 	skb_queue_head_init(&conn->data_q);
 
+	hrtimer_init(&conn->tx_timer, CLOCK_MONOTONIC, HRTIMER_NORESTART);
+
+	if(type == SCO_LINK)
+		conn->tx_timer.function = hci_sco_tx_timer;
+
 	init_timer(&conn->disc_timer);
 	conn->disc_timer.function = hci_conn_timeout;
 	conn->disc_timer.data = (unsigned long) conn;
@@ -194,6 +219,7 @@
 	conn->idle_timer.data = (unsigned long) conn;
 
 	atomic_set(&conn->refcnt, 0);
+	atomic_set(&conn->sent, 0);
 
 	hci_dev_hold(hdev);
 
@@ -220,6 +246,8 @@
 
 	del_timer(&conn->disc_timer);
 
+	hrtimer_cancel(&conn->tx_timer);
+
 	if (conn->type == SCO_LINK) {
 		struct hci_conn *acl = conn->link;
 		if (acl) {
@@ -232,7 +260,7 @@
 			sco->link = NULL;
 
 		/* Unacked frames */
-		hdev->acl_cnt += conn->sent;
+		hdev->acl_cnt += atomic_read(&conn->sent);
 	}
 
 	tasklet_disable(&hdev->tx_task);
--- linux-2.6.22.9-0.4/net/bluetooth/hci_core.c	2007-10-08 13:48:24.000000000 +0200
+++ linux-2.6.22.9-0.4-mypatch/net/bluetooth/hci_core.c	2007-11-07 18:01:20.000000000 +0100
@@ -639,7 +639,8 @@
 		hdev->flush(hdev);
 
 	atomic_set(&hdev->cmd_cnt, 1);
-	hdev->acl_cnt = 0; hdev->sco_cnt = 0;
+	atomic_set(&hdev->sco_cnt, 0);
+	hdev->acl_cnt = 0;
 
 	if (!test_bit(HCI_RAW, &hdev->flags))
 		ret = __hci_request(hdev, hci_reset_req, 0,
@@ -1151,6 +1152,7 @@
 {
 	struct hci_dev *hdev = conn->hdev;
 	struct hci_sco_hdr hdr;
+	ktime_t now;
 
 	BT_DBG("%s len %d", hdev->name, skb->len);
 
@@ -1159,6 +1161,13 @@
 		return -EINVAL;
 	}
 
+        now = conn->tx_timer.base->get_time();
+
+        /* force a clean start for 100 ms or later underrun */
+        if (conn->tx_timer.expires.tv64 + NSEC_PER_SEC / 10 <= now.tv64) {
+               conn->tx_timer.expires = now;
+        }
+
 	hdr.handle = cpu_to_le16(conn->handle);
 	hdr.dlen   = skb->len;
 
@@ -1176,12 +1185,13 @@
 
 /* ---- HCI TX task (outgoing data) ---- */
 
-/* HCI Connection scheduler */
-static inline struct hci_conn *hci_low_sent(struct hci_dev *hdev, __u8 type, int *quote)
+/* HCI ACL Connection scheduler */
+static inline struct hci_conn *hci_low_sent_acl(struct hci_dev *hdev, int *quote)
 {
 	struct hci_conn_hash *h = &hdev->conn_hash;
 	struct hci_conn  *conn = NULL;
-	int num = 0, min = ~0;
+        unsigned int num = 0, min = ~0;
+
 	struct list_head *p;
 
 	/* We don't have to lock device here. Connections are always
@@ -1190,20 +1200,22 @@
 		struct hci_conn *c;
 		c = list_entry(p, struct hci_conn, list);
 
-		if (c->type != type || c->state != BT_CONNECTED
+                BT_DBG("c->type %d c->state %d len(c->data_q) %d min %d c->sent %d",
+                        c->type, c->state, skb_queue_len(&c->data_q), min, atomic_read(&c->sent));
+
+                if (c->type != ACL_LINK || c->state != BT_CONNECTED
 				|| skb_queue_empty(&c->data_q))
 			continue;
 		num++;
 
-		if (c->sent < min) {
-			min  = c->sent;
+                if (atomic_read(&c->sent) < min) {
+                        min  = atomic_read(&c->sent);
 			conn = c;
 		}
 	}
 
 	if (conn) {
-		int cnt = (type == ACL_LINK ? hdev->acl_cnt : hdev->sco_cnt);
-		int q = cnt / num;
+                int q = hdev->acl_cnt / num;
 		*quote = q ? q : 1;
 	} else
 		*quote = 0;
@@ -1223,7 +1235,7 @@
 	/* Kill stalled connections */
 	list_for_each(p, &h->list) {
 		c = list_entry(p, struct hci_conn, list);
-		if (c->type == ACL_LINK && c->sent) {
+                if (c->type == ACL_LINK && atomic_read(&c->sent)) {
 			BT_ERR("%s killing stalled ACL connection %s",
 				hdev->name, batostr(&c->dst));
 			hci_acl_disconn(c, 0x13);
@@ -1246,7 +1258,7 @@
 			hci_acl_tx_to(hdev);
 	}
 
-	while (hdev->acl_cnt && (conn = hci_low_sent(hdev, ACL_LINK, &quote))) {
+	while (hdev->acl_cnt && (conn = hci_low_sent_acl(hdev, &quote))) {
 		while (quote-- && (skb = skb_dequeue(&conn->data_q))) {
 			BT_DBG("skb %p len %d", skb, skb->len);
 
@@ -1256,30 +1268,63 @@
 			hdev->acl_last_tx = jiffies;
 
 			hdev->acl_cnt--;
-			conn->sent++;
+			atomic_inc(&conn->sent);
 		}
 	}
 }
 
-/* Schedule SCO */
+/* HCI SCO Connection scheduler */
+
 static inline void hci_sched_sco(struct hci_dev *hdev)
 {
-	struct hci_conn *conn;
+	struct hci_conn_hash *h = &hdev->conn_hash;
 	struct sk_buff *skb;
-	int quote;
+        struct list_head *p;
+        struct hci_conn *c;
+        ktime_t now, pkt_time;
 
 	BT_DBG("%s", hdev->name);
 
-	while (hdev->sco_cnt && (conn = hci_low_sent(hdev, SCO_LINK, &quote))) {
-		while (quote-- && (skb = skb_dequeue(&conn->data_q))) {
-			BT_DBG("skb %p len %d", skb, skb->len);
-			hci_send_frame(skb);
-
-			conn->sent++;
-			if (conn->sent == ~0)
-				conn->sent = 0;
-		}
-	}
+        /* We don't have to lock device here. Connections are always
+           added and removed with TX task disabled. */
+        list_for_each(p, &h->list) {
+                c = list_entry(p, struct hci_conn, list);
+ 
+                /* SCO scheduling algorithm makes sure there is never more than
+                   1 outstanding packet for each connection */
+
+                if (c->type == ACL_LINK)
+                        continue;
+
+                if (atomic_read(&c->sent) >= 1)
+                        continue;
+
+                if (c->state != BT_CONNECTED)
+                        continue;
+
+                if (atomic_read(&hdev->sco_cnt) <= 0)
+                        continue;
+
+                if ((skb = skb_dequeue(&c->data_q)) == NULL)
+                        continue;
+
+                hci_send_frame(skb);
+ 
+                atomic_inc(&c->sent);
+                atomic_dec(&hdev->sco_cnt);
+ 
+                pkt_time = ktime_set(0, NSEC_PER_SEC / 16000 * (skb->len - HCI_SCO_HDR_SIZE));
+                now = c->tx_timer.base->get_time();
+ 
+                c->tx_timer.expires.tv64 += pkt_time.tv64;
+                if (c->tx_timer.expires.tv64 > now.tv64) {
+                        hrtimer_restart(&c->tx_timer);
+                } else {
+                        /* Timer is to expire in the past - force timer expiration.
+                           this can happen if timer base precision is less than pkt_time */
+                        c->tx_timer.function(&c->tx_timer);
+                }
+        }
 }
 
 static void hci_tx_task(unsigned long arg)
@@ -1289,14 +1334,14 @@
 
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
--- linux-2.6.22.9-0.4/net/bluetooth/hci_event.c	2007-07-09 01:32:17.000000000 +0200
+++ linux-2.6.22.9-0.4-mypatch/net/bluetooth/hci_event.c	2007-11-08 15:54:56.000000000 +0100
@@ -381,7 +381,7 @@
 		}
 
 		hdev->acl_cnt = hdev->acl_pkts;
-		hdev->sco_cnt = hdev->sco_pkts;
+		atomic_set(&hdev->sco_cnt, hdev->sco_pkts);
 
 		BT_DBG("%s mtu: acl %d, sco %d max_pkt: acl %d, sco %d", hdev->name,
 			hdev->acl_mtu, hdev->sco_mtu, hdev->acl_pkts, hdev->sco_pkts);
@@ -879,12 +879,9 @@
 
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
--- linux-2.6.22.9-0.4/net/bluetooth/sco.c	2007-07-09 01:32:17.000000000 +0200
+++ linux-2.6.22.9-0.4-mypatch/net/bluetooth/sco.c	2007-11-08 15:57:15.000000000 +0100
@@ -53,7 +53,13 @@
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
 
@@ -69,6 +75,33 @@
 static void sco_sock_close(struct sock *sk);
 static void sco_sock_kill(struct sock *sk);
 
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
+	if (atomic_read(&sk->sk_wmem_alloc) < sk->sk_sndbuf) {
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
@@ -234,33 +267,55 @@
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
+	   we want it only increased by 1 */
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
+
+	if (err < 0)
+		goto fail;
 
-	return count;
+	return len;
 
 fail:
 	kfree_skb(skb);
 	return err;
 }
 
+static int sco_sock_queue_rcv_skb(struct sock *sk, struct sk_buff *skb)
+{
+	BT_DBG("sock %p, sk_rcvbuf %d, qlen %d", sk, sk->sk_rcvbuf, skb_queue_len(&sk->sk_receive_queue));
+
+	if (skb_queue_len(&sk->sk_receive_queue) + 1 > (unsigned)sk->sk_rcvbuf)
+		return -ENOMEM;
+
+	skb->dev = NULL;
+	skb->sk = sk;
+	skb->destructor = NULL;
+
+	skb_queue_tail(&sk->sk_receive_queue, skb);
+
+	if (!sock_flag(sk, SOCK_DEAD))
+		sk->sk_data_ready(sk, 1);
+
+	return 0;
+}
+
 static inline void sco_recv_frame(struct sco_conn *conn, struct sk_buff *skb)
 {
 	struct sock *sk = sco_chan_get(conn);
@@ -273,7 +328,7 @@
 	if (sk->sk_state != BT_CONNECTED)
 		goto drop;
 
-	if (!sock_queue_rcv_skb(sk, skb))
+	if (!sco_sock_queue_rcv_skb(sk, skb))
 		return;
 
 drop:
@@ -328,7 +383,6 @@
 	BT_DBG("sk %p", sk);
 
 	skb_queue_purge(&sk->sk_receive_queue);
-	skb_queue_purge(&sk->sk_write_queue);
 }
 
 static void sco_sock_cleanup_listen(struct sock *parent)
@@ -426,6 +480,10 @@
 	INIT_LIST_HEAD(&bt_sk(sk)->accept_q);
 
 	sk->sk_destruct = sco_sock_destruct;
+	sk->sk_write_space = sco_sock_write_space;
+
+	sk->sk_sndbuf = DEFAULT_SCO_TXBUFS;
+	sk->sk_rcvbuf = DEFAULT_SCO_RXBUFS;
 	sk->sk_sndtimeo = SCO_CONN_TIMEOUT;
 
 	sock_reset_flag(sk, SOCK_ZAPPED);
@@ -656,6 +714,7 @@
 static int sco_sock_setsockopt(struct socket *sock, int level, int optname, char __user *optval, int optlen)
 {
 	struct sock *sk = sock->sk;
+	u32 opt;
 	int err = 0;
 
 	BT_DBG("sk %p", sk);
@@ -663,6 +722,32 @@
 	lock_sock(sk);
 
 	switch (optname) {
+	case SO_SNDBUF:
+		if (get_user(opt, (u32 __user *) optval)) {
+			err = -EFAULT;
+			break;
+		}
+		if (opt > MAX_SCO_TXBUFS) {
+			err = -EINVAL;
+			break;
+		}
+
+		sk->sk_sndbuf = opt;
+		/* Wake up sending tasks if we upped the value */
+		sk->sk_write_space(sk);
+		break;
+	case SO_RCVBUF:
+		if (get_user(opt, (u32 __user *) optval)) {
+			err = -EFAULT;
+			break;
+		}
+		if (opt > MAX_SCO_RXBUFS) {
+			err = -EINVAL;
+			break;
+		}
+
+		sk->sk_rcvbuf = opt;
+		break;
 	default:
 		err = -ENOPROTOOPT;
 		break;
@@ -678,6 +763,7 @@
 	struct sco_options opts;
 	struct sco_conninfo cinfo;
 	int len, err = 0;
+	int val;
 
 	BT_DBG("sk %p", sk);
 
@@ -687,6 +773,24 @@
 	lock_sock(sk);
 
 	switch (optname) {
+	case SO_RCVBUF:
+		val = sk->sk_rcvbuf;
+
+		len = min_t(unsigned int, len, sizeof(val));
+		if (copy_to_user(optval, (char *) &val, len))
+			err = -EFAULT;
+
+		break;
+
+	case SO_SNDBUF:
+		val = sk->sk_sndbuf;
+
+		len = min_t(unsigned int, len, sizeof(val));
+		if (copy_to_user(optval, (char *) &val, len))
+			err = -EFAULT;
+
+		break;
+
 	case SCO_OPTIONS:
 		if (sk->sk_state != BT_CONNECTED) {
 			err = -ENOTCONN;
@@ -698,7 +802,7 @@
 		BT_DBG("mtu %d", opts.mtu);
 
 		len = min_t(unsigned int, len, sizeof(opts));
-		if (copy_to_user(optval, (char *)&opts, len))
+		if (copy_to_user(optval, (char *) &opts, len))
 			err = -EFAULT;
 
 		break;
@@ -713,7 +817,7 @@
 		memcpy(cinfo.dev_class, sco_pi(sk)->conn->hcon->dev_class, 3);
 
 		len = min_t(unsigned int, len, sizeof(cinfo));
-		if (copy_to_user(optval, (char *)&cinfo, len))
+		if (copy_to_user(optval, (char *) &cinfo, len))
 			err = -EFAULT;
 
 		break;

--=-l8g1hfDP3dWAIixv9Txe
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >> http://get.splunk.com/
--=-l8g1hfDP3dWAIixv9Txe
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--=-l8g1hfDP3dWAIixv9Txe--
