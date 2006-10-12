Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <452E84DA.9090307@free.fr>
Date: Thu, 12 Oct 2006 20:09:30 +0200
From: Fabien Chevalier <fabchevalier@free.fr>
MIME-Version: 1.0
To: BlueZ development <bluez-devel@lists.sourceforge.net>
Content-Type: multipart/mixed; boundary="------------050907010008020107080102"
Cc: Brad Midgley <bmidgley@xmission.com>
Subject: [Bluez-devel] [PATCH] Updated sco flow control feature
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
--------------050907010008020107080102
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit


Marcel, Brad, Jose,

After a few very busy months at work i finally had the opportunity to go 
back to my bluez flow control patch i left in the middle of nowhere back 
in May. :-)
You will find attached an updated version of the patch against 
2.6.18-mh4, as well as a sample test program that shows the flow control 
stuff is really working.

Major changes compared to previous versions:
 * Packets are queued in the core, and are dequeue from there.
 * Flow control is achieved using high resolution timers. This means the 
code is really HZ independant, and things will even go better when the 
dyntick patch which has been in the air recently will be included in the 
mainline kernel.
 * Fixed a stupid bug that would cause packets to be sent really too 
slowly when HZ was < 1000
 * Should work with HZ = 100, 250, 1000, ... or whatever else. I tested 
with 250 HZ only for now.
 * Wrote a test program, "headsettest". To run this program you will 
need an USB dongle that supports SCO, as well as a
headset. This program records your own voice for 30 seconds, then plays 
what it recorded in your ears for 30 seconds. Beware : Running it 
without the flow control patch is likely to crash your box !!
 * The patch is cleaner. This is mainly due to the fact i am getting to 
a better understanding of Linux socket layer.

Random notes :
I tryed to enable number of completed packets events for synchronous 
connections,
to get rid of all the timer stuff, however it didn't succeed.
 This is achieved using hcitool command while there are no active 
connections :

tannat:/home/fchevalier/tmp/linux-2.6.18-mh4-fch# hcitool cmd 0x003 
0X002F 0x01
< HCI Command: ogf 0x03, ocf 0x002f, plen 1
  01
 > HCI Event: 0x0e plen 4
  01 2F 0C 00
tannat:/home/fchevalier/tmp/linux-2.6.18-mh4-fch# hcitool cmd 0x003 0X002E
< HCI Command: ogf 0x03, ocf 0x002e, plen 0
 > HCI Event: 0x0e plen 5
  01 2E 0C 00 01

I tryed with 3 different USB dongles :
 * one of them did not support this feature (old CSR 1.1 dongle)
 * the two others supported the feature, however did never send any 
completed packets events for SCO packets (Broadcom BCM2035 and ISSC).

Due to this lack of working hardware i took the decision to stick with 
timers, even though it is not the best technical choice :-(

Limitations :
For now the flow control only works with CVSD air encoding
 (ie 16 bit frames). If 8 bit frames are used, data will be sent twice 
too fast.

I am looking forward to your comments,

Cheers,

Fabien

--------------050907010008020107080102
Content-Type: text/plain;
 name="bluez-sco-flowcontrol-1of2.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="bluez-sco-flowcontrol-1of2.diff"

diff -rU 6 --exclude-from=kernelexcludes.txt --exclude='sco.*' /home/fchevalier/tmp/linux-2.6.18-mh4/include/net/bluetooth/hci.h /home/fchevalier/tmp/linux-2.6.18-mh4-fch/include/net/bluetooth/hci.h
--- /home/fchevalier/tmp/linux-2.6.18-mh4/include/net/bluetooth/hci.h	2006-10-12 11:30:35.000000000 +0200
+++ /home/fchevalier/tmp/linux-2.6.18-mh4-fch/include/net/bluetooth/hci.h	2006-10-12 12:39:22.000000000 +0200
@@ -764,12 +764,15 @@
 	__u32 sco_tx;
 	__u32 sco_rx;
 	__u32 byte_rx;
 	__u32 byte_tx;
 };
 
+/* Fields down there are mostly the same as hci_dev,
+   as this structure is meant to communicate info
+   to userspace */
 struct hci_dev_info {
 	__u16 dev_id;
 	char  name[8];
 
 	bdaddr_t bdaddr;
 
@@ -779,15 +782,19 @@
 	__u8  features[8];
 
 	__u32 pkt_type;
 	__u32 link_policy;
 	__u32 link_mode;
 
+	/* Maximum transmition unit for ACL packets */
 	__u16 acl_mtu;
+	/* Number of ACL packets the baseband is able to buffer */
 	__u16 acl_pkts;
+	/* Maximum transmition unit for SCO packets */
 	__u16 sco_mtu;
+	/* Number of SCO packets the baseband is able to buffer */
 	__u16 sco_pkts;
 
 	struct hci_dev_stats stat;
 };
 
 struct hci_conn_info {
diff -rU 6 --exclude-from=kernelexcludes.txt --exclude='sco.*' /home/fchevalier/tmp/linux-2.6.18-mh4/include/net/bluetooth/hci_core.h /home/fchevalier/tmp/linux-2.6.18-mh4-fch/include/net/bluetooth/hci_core.h
--- /home/fchevalier/tmp/linux-2.6.18-mh4/include/net/bluetooth/hci_core.h	2006-10-12 11:30:35.000000000 +0200
+++ /home/fchevalier/tmp/linux-2.6.18-mh4-fch/include/net/bluetooth/hci_core.h	2006-10-12 17:45:39.000000000 +0200
@@ -22,12 +22,14 @@
    SOFTWARE IS DISCLAIMED.
 */
 
 #ifndef __HCI_CORE_H
 #define __HCI_CORE_H
 
+#include <linux/hrtimer.h>
+
 #include <net/bluetooth/hci.h>
 
 /* HCI upper protocols */
 #define HCI_PROTO_L2CAP	0
 #define HCI_PROTO_SCO	1
 
@@ -85,18 +87,24 @@
 	__u16		sniff_min_interval;
 	__u16		sniff_max_interval;
 
 	unsigned long	quirks;
 
 	atomic_t	cmd_cnt;
+	/* Number of available controller buffers for ACL packets */
 	unsigned int	acl_cnt;
-	unsigned int	sco_cnt;
+	/* Number of available controller buffers for SCO packets */
+	atomic_t	sco_cnt;
 
+	/* Maximum transmition unit for ACL packets */
 	unsigned int	acl_mtu;
+	/* Maximum transmition unit for SCO packets */
 	unsigned int	sco_mtu;
+	/* Maximum number of ACL packets the controller is able to buffer */
 	unsigned int	acl_pkts;
+	/* Maximum number of SCO packets the controller is able to buffer */
 	unsigned int	sco_pkts;
 
 	unsigned long	cmd_last_tx;
 	unsigned long	acl_last_tx;
 	unsigned long	sco_last_tx;
 
@@ -142,41 +150,51 @@
 };
 
 struct hci_conn {
 	struct list_head list;
 
 	atomic_t	 refcnt;
-	spinlock_t	 lock;
 
 	bdaddr_t	 dst;
 	__u16		 handle;
 	__u16		 state;
 	__u8             mode;
+ 	/* type : ACL or SCO */
 	__u8		 type;
 	__u8		 out;
 	__u8		 dev_class[3];
 	__u8             features[8];
 	__u16            interval;
 	__u16            link_policy;
 	__u32		 link_mode;
 	__u8             power_save;
 	unsigned long	 pend;
 
-	unsigned int	 sent;
-
-	struct sk_buff_head data_q;
-
+ 	/* sent represents the number of packets this connections
+            has "on the wire" : .... oh f.... there are no wire
+            with bluetooth. By on the wire, i mean packets that have been sent
+ 	   to the HCI device, and that are still in its buffers */
+	atomic_t	 sent;
+
+	struct sk_buff_head out_q;
+	/* This is only used for SCO for now */
+	void (*pkt_sent_cb)(struct hci_conn *conn);
+
+	/* tx timer : used only for SCO */
+	struct hrtimer tx_timer;
+	/* Disconnect timer */
 	struct timer_list disc_timer;
 	struct timer_list idle_timer;
 
 	struct work_struct work;
 
 	struct device	dev;
 
 	struct hci_dev	*hdev;
 	void		*l2cap_data;
+	/* private use for sco */
 	void		*sco_data;
 	void		*priv;
 
 	struct hci_conn	*link;
 };
 
@@ -610,13 +628,16 @@
 
 int hci_register_notifier(struct notifier_block *nb);
 int hci_unregister_notifier(struct notifier_block *nb);
 
 int hci_send_cmd(struct hci_dev *hdev, __u16 ogf, __u16 ocf, __u32 plen, void *param);
 int hci_send_acl(struct hci_conn *conn, struct sk_buff *skb, __u16 flags);
-int hci_send_sco(struct hci_conn *conn, struct sk_buff *skb);
+int hci_send_sco(struct hci_conn *conn, 
+			struct sk_buff *skb, 
+			int sndbufsize, 
+			void (*send_complete_cb)(struct hci_conn *conn));
 
 void *hci_sent_cmd_data(struct hci_dev *hdev, __u16 ogf, __u16 ocf);
 
 void hci_si_event(struct hci_dev *hdev, int type, int dlen, void *data);
 
 /* ----- HCI Sockets ----- */
diff -rU 6 --exclude-from=kernelexcludes.txt --exclude='sco.*' /home/fchevalier/tmp/linux-2.6.18-mh4/net/bluetooth/hci_conn.c /home/fchevalier/tmp/linux-2.6.18-mh4-fch/net/bluetooth/hci_conn.c
--- /home/fchevalier/tmp/linux-2.6.18-mh4/net/bluetooth/hci_conn.c	2006-10-12 11:30:35.000000000 +0200
+++ /home/fchevalier/tmp/linux-2.6.18-mh4-fch/net/bluetooth/hci_conn.c	2006-10-12 17:31:39.000000000 +0200
@@ -179,23 +179,27 @@
 	conn->type   = type;
 	conn->mode   = HCI_CM_ACTIVE;
 	conn->state  = BT_OPEN;
 
 	conn->power_save = 1;
 
-	skb_queue_head_init(&conn->data_q);
+	conn->pkt_sent_cb = NULL;
+	skb_queue_head_init(&conn->out_q);
+
+	hrtimer_init(&conn->tx_timer, CLOCK_MONOTONIC, HRTIMER_NORESTART);
 
 	init_timer(&conn->disc_timer);
 	conn->disc_timer.function = hci_conn_timeout;
 	conn->disc_timer.data = (unsigned long) conn;
 
 	init_timer(&conn->idle_timer);
 	conn->idle_timer.function = hci_conn_idle;
 	conn->idle_timer.data = (unsigned long) conn;
 
 	atomic_set(&conn->refcnt, 0);
+	atomic_set(&conn->sent, 0);
 
 	hci_dev_hold(hdev);
 
 	tasklet_disable(&hdev->tx_task);
 
 	hci_conn_hash_add(hdev, conn);
@@ -216,38 +220,40 @@
 	BT_DBG("%s conn %p handle %d", hdev->name, conn, conn->handle);
 
 	del_timer(&conn->idle_timer);
 
 	del_timer(&conn->disc_timer);
 
+	hrtimer_cancel(&conn->tx_timer);
+
 	if (conn->type == SCO_LINK) {
 		struct hci_conn *acl = conn->link;
 		if (acl) {
 			acl->link = NULL;
 			hci_conn_put(acl);
 		}
 	} else {
 		struct hci_conn *sco = conn->link;
 		if (sco)
 			sco->link = NULL;
 
 		/* Unacked frames */
-		hdev->acl_cnt += conn->sent;
+		hdev->acl_cnt += atomic_read(&conn->sent);
 	}
 
 	tasklet_disable(&hdev->tx_task);
 
 	hci_conn_del_sysfs(conn);
 
 	hci_conn_hash_del(hdev, conn);
 	if (hdev->notify)
 		hdev->notify(hdev, HCI_NOTIFY_CONN_DEL);
 
 	tasklet_enable(&hdev->tx_task);
 
-	skb_queue_purge(&conn->data_q);
+	skb_queue_purge(&conn->out_q);
 
 	hci_dev_put(hdev);
 
 	/* will free via device release */
 	put_device(&conn->dev);
 
diff -rU 6 --exclude-from=kernelexcludes.txt --exclude='sco.*' /home/fchevalier/tmp/linux-2.6.18-mh4/net/bluetooth/hci_core.c /home/fchevalier/tmp/linux-2.6.18-mh4-fch/net/bluetooth/hci_core.c
--- /home/fchevalier/tmp/linux-2.6.18-mh4/net/bluetooth/hci_core.c	2006-10-12 11:30:35.000000000 +0200
+++ /home/fchevalier/tmp/linux-2.6.18-mh4-fch/net/bluetooth/hci_core.c	2006-10-12 19:01:26.000000000 +0200
@@ -616,14 +616,15 @@
 	hci_conn_hash_flush(hdev);
 	hci_dev_unlock_bh(hdev);
 
 	if (hdev->flush)
 		hdev->flush(hdev);
 
-	atomic_set(&hdev->cmd_cnt, 1); 
-	hdev->acl_cnt = 0; hdev->sco_cnt = 0;
+	atomic_set(&hdev->cmd_cnt, 1);
+	atomic_set(&hdev->sco_cnt, 0); 
+	hdev->acl_cnt = 0; 
 
 	if (!test_bit(HCI_RAW, &hdev->flags))
 		ret = __hci_request(hdev, hci_reset_req, 0,
 					msecs_to_jiffies(HCI_INIT_TIMEOUT));
 
 done:
@@ -1093,100 +1094,110 @@
 	hci_add_acl_hdr(skb, conn->handle, flags | ACL_START);
 
 	if (!(list = skb_shinfo(skb)->frag_list)) {
 		/* Non fragmented */
 		BT_DBG("%s nonfrag skb %p len %d", hdev->name, skb, skb->len);
 
-		skb_queue_tail(&conn->data_q, skb);
+		skb_queue_tail(&conn->out_q, skb);
 	} else {
 		/* Fragmented */
 		BT_DBG("%s frag %p len %d", hdev->name, skb, skb->len);
 
 		skb_shinfo(skb)->frag_list = NULL;
 
 		/* Queue all fragments atomically */
-		spin_lock_bh(&conn->data_q.lock);
+		spin_lock_bh(&conn->out_q.lock);
 
-		__skb_queue_tail(&conn->data_q, skb);
+		__skb_queue_tail(&conn->out_q, skb);
 		do {
 			skb = list; list = list->next;
 			
 			skb->dev = (void *) hdev;
 			bt_cb(skb)->pkt_type = HCI_ACLDATA_PKT;
 			hci_add_acl_hdr(skb, conn->handle, flags | ACL_CONT);
 
 			BT_DBG("%s frag %p len %d", hdev->name, skb, skb->len);
 
-			__skb_queue_tail(&conn->data_q, skb);
+			__skb_queue_tail(&conn->out_q, skb);
 		} while (list);
 
-		spin_unlock_bh(&conn->data_q.lock);
+		spin_unlock_bh(&conn->out_q.lock);
 	}
 
 	hci_sched_tx(hdev);
 	return 0;
 }
 EXPORT_SYMBOL(hci_send_acl);
 
-/* Send SCO data */
-int hci_send_sco(struct hci_conn *conn, struct sk_buff *skb)
+static inline void __hci_send_sco(struct hci_conn *conn, struct sk_buff *skb)
 {
-	struct hci_dev *hdev = conn->hdev;
 	struct hci_sco_hdr hdr;
 
-	BT_DBG("%s len %d", hdev->name, skb->len);
-
-	if (skb->len > hdev->sco_mtu) {
-		kfree_skb(skb);
-		return -EINVAL;
-	}
-
+	BT_DBG("skb %p len %d", skb, skb->len);
+	/* preparing frame */
 	hdr.handle = __cpu_to_le16(conn->handle);
 	hdr.dlen   = skb->len;
 
 	skb->h.raw = skb_push(skb, HCI_SCO_HDR_SIZE);
 	memcpy(skb->h.raw, &hdr, HCI_SCO_HDR_SIZE);
 
-	skb->dev = (void *) hdev;
+	skb->dev = (void *) conn->hdev;
 	bt_cb(skb)->pkt_type = HCI_SCODATA_PKT;
-	skb_queue_tail(&conn->data_q, skb);
-	hci_sched_tx(hdev);
-	return 0;
+
+	skb_queue_tail(&conn->out_q, skb);
+
+	hci_sched_tx(conn->hdev);
+}
+
+int hci_send_sco(struct hci_conn *conn, struct sk_buff *skb, 
+		int sndbufsize, void (*send_complete_cb)(struct hci_conn *conn))
+{
+	BT_DBG("conn %p skb %p sndbufsize %d", conn, skb, sndbufsize);
+	if(skb_queue_len(&conn->out_q) < sndbufsize) {
+		__hci_send_sco(conn, skb);
+		conn->pkt_sent_cb = send_complete_cb;
+		return 0;
+	}
+	else {
+		return -EAGAIN;
+	}
 }
 EXPORT_SYMBOL(hci_send_sco);
 
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
 	 * added and removed with TX task disabled. */
 	list_for_each(p, &h->list) {
 		struct hci_conn *c;
 		c = list_entry(p, struct hci_conn, list);
 
-		if (c->type != type || c->state != BT_CONNECTED
-				|| skb_queue_empty(&c->data_q))
+		BT_DBG("c->type %d c->state %d len(c->out_q) %d min %d c->sent %d", 
+			c->type, c->state, skb_queue_len(&c->out_q), min, atomic_read(&c->sent));
+
+		if (c->type != ACL_LINK || c->state != BT_CONNECTED
+				|| skb_queue_empty(&c->out_q))
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
 
 	BT_DBG("conn %p quote %d", conn, *quote);
 	return conn;
@@ -1200,13 +1211,13 @@
 
 	BT_ERR("%s ACL tx timeout", hdev->name);
 
 	/* Kill stalled connections */
 	list_for_each(p, &h->list) {
 		c = list_entry(p, struct hci_conn, list);
-		if (c->type == ACL_LINK && c->sent) {
+		if (c->type == ACL_LINK && atomic_read(&c->sent)) {
 			BT_ERR("%s killing stalled ACL connection %s",
 				hdev->name, batostr(&c->dst));
 			hci_acl_disconn(c, 0x13);
 		}
 	}
 }
@@ -1223,63 +1234,122 @@
 		/* ACL tx timeout must be longer than maximum
 		 * link supervision timeout (40.9 seconds) */
 		if (!hdev->acl_cnt && (jiffies - hdev->acl_last_tx) > (HZ * 45))
 			hci_acl_tx_to(hdev);
 	}
 
-	while (hdev->acl_cnt && (conn = hci_low_sent(hdev, ACL_LINK, &quote))) {
-		while (quote-- && (skb = skb_dequeue(&conn->data_q))) {
+	while (hdev->acl_cnt && (conn = hci_low_sent_acl(hdev, &quote))) {
+		while (quote-- && (skb = skb_dequeue(&conn->out_q))) {
 			BT_DBG("skb %p len %d", skb, skb->len);
 
 			hci_conn_enter_active_mode(conn);
 
 			hci_send_frame(skb);
 			hdev->acl_last_tx = jiffies;
 
 			hdev->acl_cnt--;
-			conn->sent++;
+			atomic_inc(&conn->sent);
 		}
 	}
 }
 
-/* Schedule SCO */
-static inline void hci_sched_sco(struct hci_dev *hdev)
+/* HCI SCO tx timer */
+
+static int hci_sco_tx_timer(struct hrtimer *timer)
 {
-	struct hci_conn *conn;
-	struct sk_buff *skb;
-	int quote;
+	struct hci_conn *conn = container_of(timer, struct hci_conn, tx_timer);
+#ifdef CONFIG_BT_HCI_CORE_DEBUG
+	ktime_t now = timer->base->get_time();
+#endif
 
-	BT_DBG("%s", hdev->name);
+	BT_DBG("%s, conn %p, time %5lu.%06lu", conn->hdev->name, conn,
+		(unsigned long) now.tv64, 
+		do_div(now.tv64, NSEC_PER_SEC) / 1000);
 
-	while (hdev->sco_cnt && (conn = hci_low_sent(hdev, SCO_LINK, &quote))) {
-		while (quote-- && (skb = skb_dequeue(&conn->data_q))) {
-			BT_DBG("skb %p len %d", skb, skb->len);
-			hci_send_frame(skb);
+	if(atomic_read(&conn->sent) > 0) {
+		atomic_dec(&conn->sent);
+		atomic_inc(&conn->hdev->sco_cnt);
+		hci_sched_tx(conn->hdev);
+	}
+	/* Wake up writers */
+	if(conn->pkt_sent_cb) {
+		conn->pkt_sent_cb(conn);
+	}
+	return HRTIMER_NORESTART;
+}
+ 
+/* HCI SCO Connection scheduler */
 
-			conn->sent++;
-			if (conn->sent == ~0)
-				conn->sent = 0;
+static inline void hci_sched_sco(struct hci_dev *hdev)
+{
+	struct hci_conn_hash *h = &hdev->conn_hash;
+	struct sk_buff *skb;
+	struct list_head *p;
+	struct hci_conn *c;
+	
+	BT_DBG("%s", hdev->name);
+  
+	/* We don't have to lock device here. Connections are always 
+	 * added and removed with TX task disabled. */
+	list_for_each(p, &h->list) {
+		c = list_entry(p, struct hci_conn, list);
+  
+		/* SCO scheduling algorithm makes sure there is never more than
+		   1 outstanding packet for each connection */
+		if (c->type == SCO_LINK && atomic_read(&c->sent) < 1  && c->state == BT_CONNECTED)
+		{
+			if(atomic_read(&hdev->sco_cnt) > 0) {
+				if((skb = skb_dequeue(&c->out_q)) != NULL) {
+					ktime_t now, pkt_time;
+
+					hci_send_frame(skb);
+ 
+					atomic_inc(&c->sent);			
+					atomic_dec(&hdev->sco_cnt);
+
+					c->tx_timer.function = hci_sco_tx_timer;
+					
+					pkt_time =
+						ktime_set(0, NSEC_PER_SEC / 16000 * (skb->len - HCI_SCO_HDR_SIZE));
+					now = c->tx_timer.base->get_time();
+
+					if(c->tx_timer.expires.tv64 == 0) {
+						c->tx_timer.expires = now;
+					}
+
+					c->tx_timer.expires.tv64 += pkt_time.tv64;
+					if(c->tx_timer.expires.tv64 > now.tv64) {
+						hrtimer_restart(&c->tx_timer);
+					}
+					else {
+						/* Timer is to expire in the past - this can happen if timer base
+						 precision is less than pkt_time. In this case we force timer
+						 expiration by calling its expires function */
+						c->tx_timer.function(&c->tx_timer);
+					}
+				}
+			}
 		}
 	}
 }
 
 static void hci_tx_task(unsigned long arg)
 {
 	struct hci_dev *hdev = (struct hci_dev *) arg;
 	struct sk_buff *skb;
 
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
 
 	read_unlock(&hci_task_lock);
 }
diff -rU 6 --exclude-from=kernelexcludes.txt --exclude='sco.*' /home/fchevalier/tmp/linux-2.6.18-mh4/net/bluetooth/hci_event.c /home/fchevalier/tmp/linux-2.6.18-mh4-fch/net/bluetooth/hci_event.c
--- /home/fchevalier/tmp/linux-2.6.18-mh4/net/bluetooth/hci_event.c	2006-10-12 11:30:35.000000000 +0200
+++ /home/fchevalier/tmp/linux-2.6.18-mh4-fch/net/bluetooth/hci_event.c	2006-10-12 17:37:07.000000000 +0200
@@ -307,13 +307,13 @@
 
 	switch (ocf) {
 	case OCF_READ_LOCAL_VERSION:
 		lv = (struct hci_rp_read_loc_version *) skb->data;
 
 		if (lv->status) {
-			BT_DBG("%s READ_LOCAL_VERSION failed %d", hdev->name, lf->status);
+			BT_DBG("%s READ_LOCAL_VERSION failed %d", hdev->name, lv->status);
 			break;
 		}
 
 		hdev->hci_ver = lv->hci_ver;
 		hdev->hci_rev = btohs(lv->hci_rev);
 		hdev->manufacturer = btohs(lv->manufacturer);
@@ -369,13 +369,13 @@
 		if (test_bit(HCI_QUIRK_FIXUP_BUFFER_SIZE, &hdev->quirks)) {
 			hdev->sco_mtu  = 64;
 			hdev->sco_pkts = 8;
 		}
 
 		hdev->acl_cnt = hdev->acl_pkts;
-		hdev->sco_cnt = hdev->sco_pkts;
+		atomic_set(&hdev->sco_cnt, hdev->sco_pkts);
 
 		BT_DBG("%s mtu: acl %d, sco %d max_pkt: acl %d, sco %d", hdev->name,
 			hdev->acl_mtu, hdev->sco_mtu, hdev->acl_pkts, hdev->sco_pkts);
 		break;
 
 	case OCF_READ_BD_ADDR:
@@ -858,21 +858,21 @@
 
 		handle = __le16_to_cpu(get_unaligned(ptr++));
 		count  = __le16_to_cpu(get_unaligned(ptr++));
 
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
+			/* Note : we do not use the "number of completed packets" event
+			to increment hdev->sco_cnt, as this feature is only optionnally support
+			by bluetooth controllers. So there is no if branch for SCO_LINK packets */
 		}
 	}
 	hci_sched_tx(hdev);
 
 	tasklet_enable(&hdev->tx_task);
 }

--------------050907010008020107080102
Content-Type: text/plain;
 name="bluez-sco-flowcontrol-2of2.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="bluez-sco-flowcontrol-2of2.diff"

diff -rU 6 --exclude-from=kernelexcludes.txt --exclude='*hci*' --exclude='af_bluetooth.*' /home/fchevalier/tmp/linux-2.6.18-mh4/include/net/bluetooth/sco.h /home/fchevalier/tmp/linux-2.6.18-mh4-fch/include/net/bluetooth/sco.h
--- /home/fchevalier/tmp/linux-2.6.18-mh4/include/net/bluetooth/sco.h	2006-09-20 05:42:06.000000000 +0200
+++ /home/fchevalier/tmp/linux-2.6.18-mh4-fch/include/net/bluetooth/sco.h	2006-10-12 12:39:05.000000000 +0200
@@ -23,18 +23,13 @@
 */
 
 #ifndef __SCO_H
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
 	sa_family_t	sco_family;
 	bdaddr_t	sco_bdaddr;
 };
@@ -48,12 +43,15 @@
 #define SCO_CONNINFO	0x02
 struct sco_conninfo {
 	__u16 hci_handle;
 	__u8  dev_class[3];
 };
 
+#define SCO_TXBUFS	0x03
+#define SCO_RXBUFS	0x04
+
 /* ---- SCO connections ---- */
 struct sco_conn {
 	struct hci_conn	*hcon;
 
 	bdaddr_t 	*dst;
 	bdaddr_t 	*src;
diff -rU 6 --exclude-from=kernelexcludes.txt --exclude='*hci*' --exclude='af_bluetooth.*' /home/fchevalier/tmp/linux-2.6.18-mh4/net/bluetooth/sco.c /home/fchevalier/tmp/linux-2.6.18-mh4-fch/net/bluetooth/sco.c
--- /home/fchevalier/tmp/linux-2.6.18-mh4/net/bluetooth/sco.c	2006-09-20 05:42:06.000000000 +0200
+++ /home/fchevalier/tmp/linux-2.6.18-mh4-fch/net/bluetooth/sco.c	2006-10-12 12:39:05.000000000 +0200
@@ -50,28 +50,40 @@
 
 #ifndef CONFIG_BT_SCO_DEBUG
 #undef  BT_DBG
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
 
 static struct bt_sock_list sco_sk_list = {
 	.lock = RW_LOCK_UNLOCKED
 };
 
+/* Local functions declaration */
+
 static void __sco_chan_add(struct sco_conn *conn, struct sock *sk, struct sock *parent);
 static void sco_chan_del(struct sock *sk, int err);
 
 static int  sco_conn_del(struct hci_conn *conn, int err);
 
 static void sco_sock_close(struct sock *sk);
 static void sco_sock_kill(struct sock *sk);
 
+static void sco_sock_rfree(struct sk_buff *skb);
+
+static int sco_sock_queue_rcv_skb(struct sock *sk, struct sk_buff *skb);
+
 /* ---- SCO timers ---- */
 static void sco_sock_timeout(unsigned long arg)
 {
 	struct sock *sk = (struct sock *) arg;
 
 	BT_DBG("sock %p state %d", sk, sk->sk_state);
@@ -227,37 +239,64 @@
 done:
 	hci_dev_unlock_bh(hdev);
 	hci_dev_put(hdev);
 	return err;
 }
 
+static void sco_send_complete_cb(struct hci_conn *hcon)
+{
+	struct sco_conn *conn = hcon->sco_data;
+	struct sock *sk = conn->sk;
+	BT_DBG("conn %p, sock %p", conn, sk);
+
+	if(sk) {
+		bh_lock_sock(sk);
+		read_lock(&sk->sk_callback_lock);
+
+		if (sk->sk_sleep && waitqueue_active(sk->sk_sleep))
+			wake_up_interruptible(sk->sk_sleep);
+
+		sk_wake_async(sk, 2, POLL_OUT);
+
+		read_unlock(&sk->sk_callback_lock);
+		bh_unlock_sock(sk);
+	}
+}
+
 static inline int sco_send_frame(struct sock *sk, struct msghdr *msg, int len)
 {
 	struct sco_conn *conn = sco_pi(sk)->conn;
 	struct sk_buff *skb;
-	int err, count;
+	int err;
 
 	/* Check outgoing MTU */
 	if (len > conn->mtu)
-		return -EINVAL;
+		return -EMSGSIZE;
 
 	BT_DBG("sk %p len %d", sk, len);
 
-	count = min_t(unsigned int, conn->mtu, len);
-	if (!(skb = bt_skb_send_alloc(sk, count, msg->msg_flags & MSG_DONTWAIT, &err)))
-		return err;
+	if (!(skb = bt_skb_alloc(len, GFP_KERNEL)))
+		return -ENOBUFS;
 
-	if (memcpy_fromiovec(skb_put(skb, count), msg->msg_iov, count)) {
+	if (memcpy_fromiovec(skb_put(skb, len), msg->msg_iov, len)) {
 		err = -EFAULT;
 		goto fail;
 	}
 
-	if ((err = hci_send_sco(conn->hcon, skb)) < 0)
-		return err;
+	if(msg->msg_flags & MSG_DONTWAIT) {
+		err = hci_send_sco(conn->hcon, skb, sk->sk_sndbuf, sco_send_complete_cb);
+	}
+	else {
+		err = wait_event_interruptible(*sk->sk_sleep, 
+			hci_send_sco(conn->hcon, skb, sk->sk_sndbuf, sco_send_complete_cb) == 0);
+	}
+
+	if (err < 0)
+		goto fail;
 
-	return count;
+	return len;
 
 fail:
 	kfree_skb(skb);
 	return err;
 }
 
@@ -270,14 +309,15 @@
 
 	BT_DBG("sk %p len %d", sk, skb->len);
 
 	if (sk->sk_state != BT_CONNECTED)
 		goto drop;
 
-	if (!sock_queue_rcv_skb(sk, skb))
+	if (sco_sock_queue_rcv_skb(sk, skb) == 0) {
 		return;
+	}
 
 drop:
 	kfree_skb(skb);
 	return;
 }
 
@@ -325,13 +365,12 @@
 
 static void sco_sock_destruct(struct sock *sk)
 {
 	BT_DBG("sk %p", sk);
 
 	skb_queue_purge(&sk->sk_receive_queue);
-	skb_queue_purge(&sk->sk_write_queue);
 }
 
 static void sco_sock_cleanup_listen(struct sock *parent)
 {
 	struct sock *sk;
 
@@ -357,12 +396,14 @@
 
 	BT_DBG("sk %p state %d", sk, sk->sk_state);
 
 	/* Kill poor orphan */
 	bt_sock_unlink(&sco_sk_list, sk);
 	sock_set_flag(sk, SOCK_DEAD);
+	
+	/* release socket */
 	sock_put(sk);
 }
 
 /* Close socket.
  * Must be called on unlocked socket.
  */
@@ -373,13 +414,13 @@
 	sco_sock_clear_timer(sk);
 
 	lock_sock(sk);
 
 	conn = sco_pi(sk)->conn;
 
-	BT_DBG("sk %p state %d conn %p socket %p", sk, sk->sk_state, conn, sk->sk_socket);
+	BT_DBG("sk %p state %d conn %p socket %p refcnt %d", sk, sk->sk_state, conn, sk->sk_socket, atomic_read(&sk->sk_refcnt));
 
 	switch (sk->sk_state) {
 	case BT_LISTEN:
 		sco_sock_cleanup_listen(sk);
 		break;
 
@@ -423,12 +464,20 @@
 		return NULL;
 
 	sock_init_data(sock, sk);
 	INIT_LIST_HEAD(&bt_sk(sk)->accept_q);
 
 	sk->sk_destruct = sco_sock_destruct;
+
+       /* Put sensible values for a voice link (i.e. not too big),
+          as sysctl_rmem_default & sysctl_wmem_default are
+           really not designed for that -- In our case we use sk_**buf to
+           store a count of SCO packets, not a number of bytes as most of other type of
+           sockets do */
+	sk->sk_sndbuf = DEFAULT_SCO_TXBUFS;
+	sk->sk_rcvbuf = DEFAULT_SCO_RXBUFS;
 	sk->sk_sndtimeo = SCO_CONN_TIMEOUT;
 
 	sock_reset_flag(sk, SOCK_ZAPPED);
 
 	sk->sk_protocol = proto;
 	sk->sk_state    = BT_OPEN;
@@ -652,19 +701,44 @@
 	return err;
 }
 
 static int sco_sock_setsockopt(struct socket *sock, int level, int optname, char __user *optval, int optlen)
 {
 	struct sock *sk = sock->sk;
+	u32 opt;
 	int err = 0;
 
 	BT_DBG("sk %p", sk);
 
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
 	}
 
 	release_sock(sk);
@@ -673,22 +747,41 @@
 
 static int sco_sock_getsockopt(struct socket *sock, int level, int optname, char __user *optval, int __user *optlen)
 {
 	struct sock *sk = sock->sk;
 	struct sco_options opts;
 	struct sco_conninfo cinfo;
-	int len, err = 0; 
+	int len, err = 0;
+	int val;
 
 	BT_DBG("sk %p", sk);
 
 	if (get_user(len, optlen))
 		return -EFAULT;
 
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
 			break;
 		}
 
@@ -887,12 +980,48 @@
 
 drop:
 	kfree_skb(skb);	
 	return 0;
 }
 
+static int sco_sock_queue_rcv_skb(struct sock *sk, struct sk_buff *skb)
+{
+       int err = 0;
+
+       /* Cast skb->rcvbuf to unsigned... It's pointless, but reduces
+          number of warnings when compiling with -W --ANK
+        */
+       if (atomic_read(&sk->sk_rmem_alloc) + 1 >
+           (unsigned)sk->sk_rcvbuf) {
+               err = -ENOMEM;
+               goto out;
+       }
+
+       skb->dev = NULL;
+       skb->sk = sk;
+       skb->destructor = sco_sock_rfree;
+       atomic_add(1, &sk->sk_rmem_alloc);
+
+       skb_queue_tail(&sk->sk_receive_queue, skb);
+
+       if (!sock_flag(sk, SOCK_DEAD))
+               sk->sk_data_ready(sk, 1);
+out:
+       return err;
+}
+
+static void sco_sock_rfree(struct sk_buff *skb)
+{
+       struct sock *sk = skb->sk;
+
+       atomic_sub(1, &sk->sk_rmem_alloc);
+}
+
+
+/* ------- Others ------- */
+
 static ssize_t sco_sysfs_show(struct class *dev, char *buf)
 {
 	struct sock *sk;
 	struct hlist_node *node;
 	char *str = buf;
 

--------------050907010008020107080102
Content-Type: text/x-csrc;
 name="headsettest.c"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="headsettest.c"

#include <stdarg.h>
#include <stdio.h>
#include <stdlib.h>
#include <fcntl.h>
#include <assert.h>
#include <string.h>
#include <errno.h>
#include <poll.h>
#include <unistd.h>

#include <sys/types.h>
#include <sys/stat.h>
#include <sys/socket.h>
#include <sys/poll.h>

#include <bluetooth/bluetooth.h>
#include <bluetooth/hci.h>
#include <bluetooth/hci_lib.h>
#include <bluetooth/sco.h>
#include <bluetooth/rfcomm.h>

static int rfcomm_connect(bdaddr_t * dst, uint8_t channel)
{
	struct sockaddr_rc addr;
	int s;

	if ((s = socket(PF_BLUETOOTH, SOCK_STREAM, BTPROTO_RFCOMM)) < 0) {
		return -1;
	}

	memset(&addr, 0, sizeof(addr));
	addr.rc_family = AF_BLUETOOTH;
	bacpy(&addr.rc_bdaddr, dst);
	addr.rc_channel = channel;
	if (connect(s, (struct sockaddr *)&addr, sizeof(addr)) < 0) {
		close(s);
		return -1;
	}

	return s;
}

static int sco_connect(bdaddr_t * dst, uint16_t * handle,
		       uint16_t * mtu)
{
	struct sockaddr_sco addr;
	struct sco_conninfo conn;
	struct sco_options opts;
	int s;
	unsigned int size;

	if ((s = socket(PF_BLUETOOTH, SOCK_SEQPACKET, BTPROTO_SCO)) < 0) {
		return -1;
	}

	memset(&addr, 0, sizeof(addr));
	addr.sco_family = AF_BLUETOOTH;
	bacpy(&addr.sco_bdaddr, dst);
	if (connect(s, (struct sockaddr *)&addr, sizeof(addr)) < 0) {
		close(s);
		return -1;
	}

	size = sizeof(conn);
	if (getsockopt(s, SOL_SCO, SCO_CONNINFO, &conn, &size) < 0) {
		close(s);
		return -1;
	}

	size = sizeof(opts);
	if (getsockopt(s, SOL_SCO, SCO_OPTIONS, &opts, &size) < 0) {
		close(s);
		return -1;
	}

	if (handle)
		*handle = conn.hci_handle;

	if (mtu)
		*mtu = opts.mtu;

	return s;
}

#define PKT_SIZE 48

int main(int argc, char **argv)
{
	bdaddr_t remote;
	int rfcomm_socket;
	int sco_socket;
	int res;
	int channel;
	char buff[1024*1024];
	int i;
	struct pollfd pfd;

	if(argc != 3) {
		printf("usage: headsettest bdaddr rfcomm_channel\n");		
		printf("bdaddr = headet bd address\n");
		printf("rfcomm_channel = rfcomm channel used for headset control\n");		
		exit(1);
	}
	
	str2ba(argv[1], &remote);
	channel = atoi(argv[2]);
	
	rfcomm_socket = rfcomm_connect(&remote, channel);
	assert(rfcomm_socket != -1);
	res = write(rfcomm_socket, "RING\r\n", 6); 	
	assert(res == 6);
	memset(buff, 0, sizeof(buff));
	printf("RFCOMM control channel opened.\n");
	sco_socket = sco_connect(&remote, 0, 0);
	assert(res > 0);
	printf("SCO connected.\n");

	printf("Recording your own voice for 30 seconds, please speak loudly and clearly :-)\n");

	/* Reading 10000 packets*/
	
	pfd.fd = sco_socket;
	pfd.events = POLLIN;	
	
	for(i = 0; i < 10000; i++) {
		assert(poll(&pfd, 1 , -1) == 1);
		assert(pfd.revents & POLLIN);
		res = read(sco_socket, buff + i * PKT_SIZE, PKT_SIZE);
		assert(res > 0);
		printf(".");
		fflush(stdout);
	}

	printf("\nNow playing what has been recorded\n");

	/* Reading 3333 packets*/
	pfd.fd = sco_socket;
	pfd.events = POLLOUT;	
	for(i = 0; i < 10000; i++) {
		assert(poll(&pfd, 1, -1) == 1);
		assert(pfd.revents & POLLOUT);
		res = write(sco_socket, buff + i * PKT_SIZE, PKT_SIZE);
		assert(res > 0);
		printf(".");
		fflush(stdout);
	}
	
	return 0;
}

--------------050907010008020107080102
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
--------------050907010008020107080102
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--------------050907010008020107080102--
