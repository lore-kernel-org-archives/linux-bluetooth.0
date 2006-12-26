Return-Path: <fchevalier@silicom.fr>
Message-ID: <45910C43.2030601@silicom.fr>
Date: Tue, 26 Dec 2006 12:49:23 +0100
From: Fabien Chevalier <fchevalier@silicom.fr>
MIME-Version: 1.0
To: BlueZ development <bluez-devel@lists.sourceforge.net>,
        Marcel Holtmann <marcel@holtmann.org>,
        Brad Midgley <bmidgley@xmission.com>
Subject: [PATCH] New Christmas SCO flow control patch
Content-Type: multipart/mixed;
 boundary="------------050901020604010103090203"
List-ID: <bluez-devel.lists.sourceforge.net>

This is a multi-part message in MIME format.
--------------050901020604010103090203
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit


Marcel, Brad, Jose

Please find attached another rework of the SCO flow control patch. This 
patch is against 2.6.19.1.
I hope i'm getting closer to something that's good enough for inclusion 
in mh patches (Marcel, i'm waiting for your comments here ;-) ).

The only change compared to the previous release, is that the callback 
is gone.
The send complete aknowledge is now done using the skb destructor. As a 
consequence the sco feature is still strongly linked to sk_buffs & 
generic socket behaviour. However it looks like sound-of-bluez will be 
built on top of the socket layer, and won't replace it... so it looks OK 
for me to still have that strong dependancy on sockets.

Some design points are explained below (just a copy of one of my 
previous e-mails):

Point 1 : Why rely on hrtimers ?
As discussed previously on the list, there is no transport agnostic way 
to throttle ourselves to send data at the right rate.
SCO flow control support at HCI level is optionnal, thus we cannot rely 
on it.
Relying on isochronous USB transfer is not good as well, as it poses 
some architectural issues underlined by Marcel's previous e-mails. 
Moreover i suspect this to rely on USB host controller clock, which is 
unrelated to the bluetooth chip clock, and thus will  suffer the same 
clock offset drawback that a timer based approach.
So at some point we have to throttle ourselves, and timers can be used 
for that.

Point 2 : What about buffer settings ?
Audio API expects the application to specify a 'buffer size' and 'period 
size'.
Period size is the size of data that sound card hardware processes at a 
time.
Buffer size is a multiple of the period size, and is shared by both ALSA 
and the hardware
to move data from one to another.
One important thing to understand is that the biggest the buffer, the 
longer the added latency added.
That's why xmms's playing buffer default to 500 ms, while Ekiga's one is 
as small as two period sizes.
As it's up to the application to choose its buffer size, there is a need 
for SCO sockets to expose and API
to change the size of the buffer. There already exist such an API, which 
is SO_SNDBUF and SO_RCVBUF
setsockopt options, however the measurment does include the size of 
in-kernel data structures, which means the application has no way to 
tell the exact size of the buffer without knowing how big are the kernel 
data structures.
For ALSA this is not acceptable.
So i introduces SCO_TXBUFS and SCO_RXBUFS socket options to be able to 
specify a number of sco packets.
There is a nice tutorial on this subject by ALSA project that can be 
found on:
http://www.alsa-project.org/alsa-doc/alsa-lib/pcm.html

Cheers,

Fabien


--------------050901020604010103090203
Content-Type: text/plain;
 name="sco-flowcontrol-v3.0-1of2.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="sco-flowcontrol-v3.0-1of2.diff"

diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index 10a3eec..414313a 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -767,6 +767,9 @@ struct hci_dev_stats {
 	__u32 byte_tx;
 };
 
+/* Fields down there are mostly the same as hci_dev,
+   as this structure is meant to communicate info
+   to userspace */
 struct hci_dev_info {
 	__u16 dev_id;
 	char  name[8];
@@ -782,9 +785,13 @@ struct hci_dev_info {
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
diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index c0fc396..5bad7c0 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -25,6 +25,8 @@
 #ifndef __HCI_CORE_H
 #define __HCI_CORE_H
 
+#include <linux/hrtimer.h>
+
 #include <net/bluetooth/hci.h>
 
 /* HCI upper protocols */
@@ -88,12 +90,18 @@ struct hci_dev {
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
@@ -145,12 +153,12 @@ struct hci_conn {
 	struct list_head list;
 
 	atomic_t	 refcnt;
-	spinlock_t	 lock;
 
 	bdaddr_t	 dst;
 	__u16		 handle;
 	__u16		 state;
 	__u8             mode;
+  	/* type : ACL or SCO */
 	__u8		 type;
 	__u8		 out;
 	__u8		 attempt;
@@ -162,10 +170,17 @@ struct hci_conn {
 	__u8             power_save;
 	unsigned long	 pend;
 
-	unsigned int	 sent;
-
-	struct sk_buff_head data_q;
-
+	/* sent represents the number of packets this connections
+             has "on the wire" : .... oh f.... there are no wire
+             with bluetooth. By on the wire, i mean packets that have been sent
+	   to the HCI device, and that are still in its buffers */
+	atomic_t	 sent;
+ 
+	struct sk_buff_head out_q;
+ 
+	/* tx timer : used only for SCO */
+	struct hrtimer tx_timer;
+	/* Disconnect timer */
 	struct timer_list disc_timer;
 	struct timer_list idle_timer;
 
@@ -175,6 +190,7 @@ struct hci_conn {
 
 	struct hci_dev	*hdev;
 	void		*l2cap_data;
+ 	/* private use for sco */
 	void		*sco_data;
 	void		*priv;
 
diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index 6cd5711..979464d 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -184,7 +184,9 @@ struct hci_conn *hci_conn_add(struct hci_dev *hdev, int type, bdaddr_t *dst)
 
 	conn->power_save = 1;
 
-	skb_queue_head_init(&conn->data_q);
+	skb_queue_head_init(&conn->out_q);
+
+	hrtimer_init(&conn->tx_timer, CLOCK_MONOTONIC, HRTIMER_NORESTART);
 
 	init_timer(&conn->disc_timer);
 	conn->disc_timer.function = hci_conn_timeout;
@@ -195,6 +197,7 @@ struct hci_conn *hci_conn_add(struct hci_dev *hdev, int type, bdaddr_t *dst)
 	conn->idle_timer.data = (unsigned long) conn;
 
 	atomic_set(&conn->refcnt, 0);
+	atomic_set(&conn->sent, 0);
 
 	hci_dev_hold(hdev);
 
@@ -221,6 +224,8 @@ int hci_conn_del(struct hci_conn *conn)
 
 	del_timer(&conn->disc_timer);
 
+	hrtimer_cancel(&conn->tx_timer);
+
 	if (conn->type == SCO_LINK) {
 		struct hci_conn *acl = conn->link;
 		if (acl) {
@@ -233,7 +238,7 @@ int hci_conn_del(struct hci_conn *conn)
 			sco->link = NULL;
 
 		/* Unacked frames */
-		hdev->acl_cnt += conn->sent;
+		hdev->acl_cnt += atomic_read(&conn->sent);
 	}
 
 	tasklet_disable(&hdev->tx_task);
@@ -246,7 +251,7 @@ int hci_conn_del(struct hci_conn *conn)
 
 	tasklet_enable(&hdev->tx_task);
 
-	skb_queue_purge(&conn->data_q);
+	skb_queue_purge(&conn->out_q);
 
 	hci_dev_put(hdev);
 
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 338ae97..a2627af 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -619,8 +619,9 @@ int hci_dev_reset(__u16 dev)
 	if (hdev->flush)
 		hdev->flush(hdev);
 
-	atomic_set(&hdev->cmd_cnt, 1); 
-	hdev->acl_cnt = 0; hdev->sco_cnt = 0;
+	atomic_set(&hdev->cmd_cnt, 1);
+	atomic_set(&hdev->sco_cnt, 0); 
+	hdev->acl_cnt = 0; 
 
 	if (!test_bit(HCI_RAW, &hdev->flags))
 		ret = __hci_request(hdev, hci_reset_req, 0,
@@ -1012,7 +1013,7 @@ static int hci_send_frame(struct sk_buff *skb)
 		hci_send_to_sock(hdev, skb);
 	}
 
-	/* Get rid of skb owner, prior to sending to the driver. */
+       /* Get rid of skb owner, prior to sending to the driver. */
 	skb_orphan(skb);
 
 	return hdev->send(skb);
@@ -1096,7 +1097,7 @@ int hci_send_acl(struct hci_conn *conn, struct sk_buff *skb, __u16 flags)
 		/* Non fragmented */
 		BT_DBG("%s nonfrag skb %p len %d", hdev->name, skb, skb->len);
 
-		skb_queue_tail(&conn->data_q, skb);
+		skb_queue_tail(&conn->out_q, skb);
 	} else {
 		/* Fragmented */
 		BT_DBG("%s frag %p len %d", hdev->name, skb, skb->len);
@@ -1104,9 +1105,9 @@ int hci_send_acl(struct hci_conn *conn, struct sk_buff *skb, __u16 flags)
 		skb_shinfo(skb)->frag_list = NULL;
 
 		/* Queue all fragments atomically */
-		spin_lock_bh(&conn->data_q.lock);
+		spin_lock_bh(&conn->out_q.lock);
 
-		__skb_queue_tail(&conn->data_q, skb);
+		__skb_queue_tail(&conn->out_q, skb);
 		do {
 			skb = list; list = list->next;
 			
@@ -1116,10 +1117,10 @@ int hci_send_acl(struct hci_conn *conn, struct sk_buff *skb, __u16 flags)
 
 			BT_DBG("%s frag %p len %d", hdev->name, skb, skb->len);
 
-			__skb_queue_tail(&conn->data_q, skb);
+			__skb_queue_tail(&conn->out_q, skb);
 		} while (list);
 
-		spin_unlock_bh(&conn->data_q.lock);
+		spin_unlock_bh(&conn->out_q.lock);
 	}
 
 	hci_sched_tx(hdev);
@@ -1132,14 +1133,25 @@ int hci_send_sco(struct hci_conn *conn, struct sk_buff *skb)
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
 
@@ -1148,7 +1160,7 @@ int hci_send_sco(struct hci_conn *conn, struct sk_buff *skb)
 
 	skb->dev = (void *) hdev;
 	bt_cb(skb)->pkt_type = HCI_SCODATA_PKT;
-	skb_queue_tail(&conn->data_q, skb);
+	skb_queue_tail(&conn->out_q, skb);
 	hci_sched_tx(hdev);
 	return 0;
 }
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
@@ -1170,20 +1182,22 @@ static inline struct hci_conn *hci_low_sent(struct hci_dev *hdev, __u8 type, int
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
@@ -1203,7 +1217,7 @@ static inline void hci_acl_tx_to(struct hci_dev *hdev)
 	/* Kill stalled connections */
 	list_for_each(p, &h->list) {
 		c = list_entry(p, struct hci_conn, list);
-		if (c->type == ACL_LINK && c->sent) {
+		if (c->type == ACL_LINK && atomic_read(&c->sent)) {
 			BT_ERR("%s killing stalled ACL connection %s",
 				hdev->name, batostr(&c->dst));
 			hci_acl_disconn(c, 0x13);
@@ -1226,8 +1240,8 @@ static inline void hci_sched_acl(struct hci_dev *hdev)
 			hci_acl_tx_to(hdev);
 	}
 
-	while (hdev->acl_cnt && (conn = hci_low_sent(hdev, ACL_LINK, &quote))) {
-		while (quote-- && (skb = skb_dequeue(&conn->data_q))) {
+	while (hdev->acl_cnt && (conn = hci_low_sent_acl(hdev, &quote))) {
+		while (quote-- && (skb = skb_dequeue(&conn->out_q))) {
 			BT_DBG("skb %p len %d", skb, skb->len);
 
 			hci_conn_enter_active_mode(conn);
@@ -1236,28 +1250,79 @@ static inline void hci_sched_acl(struct hci_dev *hdev)
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
 
-	BT_DBG("%s", hdev->name);
+	BT_DBG("%s, conn %p, time %5lu.%06lu", conn->hdev->name, conn,
+		(unsigned long) now.tv64, 
+		do_div(now.tv64, NSEC_PER_SEC) / 1000);
+#endif
 
-	while (hdev->sco_cnt && (conn = hci_low_sent(hdev, SCO_LINK, &quote))) {
-		while (quote-- && (skb = skb_dequeue(&conn->data_q))) {
-			BT_DBG("skb %p len %d", skb, skb->len);
-			hci_send_frame(skb);
+	if(atomic_read(&conn->sent) > 0) {
+		atomic_dec(&conn->sent);
+		atomic_inc(&conn->hdev->sco_cnt);
+		hci_sched_tx(conn->hdev);
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
@@ -1269,14 +1334,14 @@ static void hci_tx_task(unsigned long arg)
 
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
index bb94e6d..815c79d 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -320,7 +320,7 @@ static void hci_cc_info_param(struct hci_dev *hdev, __u16 ocf, struct sk_buff *s
 		lv = (struct hci_rp_read_loc_version *) skb->data;
 
 		if (lv->status) {
-			BT_DBG("%s READ_LOCAL_VERSION failed %d", hdev->name, lf->status);
+			BT_DBG("%s READ_LOCAL_VERSION failed %d", hdev->name, lv->status);
 			break;
 		}
 
@@ -382,7 +382,7 @@ static void hci_cc_info_param(struct hci_dev *hdev, __u16 ocf, struct sk_buff *s
 		}
 
 		hdev->acl_cnt = hdev->acl_pkts;
-		hdev->sco_cnt = hdev->sco_pkts;
+		atomic_set(&hdev->sco_cnt, hdev->sco_pkts);
 
 		BT_DBG("%s mtu: acl %d, sco %d max_pkt: acl %d, sco %d", hdev->name,
 			hdev->acl_mtu, hdev->sco_mtu, hdev->acl_pkts, hdev->sco_pkts);
@@ -880,15 +880,15 @@ static inline void hci_num_comp_pkts_evt(struct hci_dev *hdev, struct sk_buff *s
 
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

--------------050901020604010103090203
Content-Type: text/plain;
 name="sco-flowcontrol-v3.0-2of2.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="sco-flowcontrol-v3.0-2of2.diff"

diff --git a/include/net/bluetooth/sco.h b/include/net/bluetooth/sco.h
index e28a2a7..4ba976b 100644
--- a/include/net/bluetooth/sco.h
+++ b/include/net/bluetooth/sco.h
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
@@ -51,6 +46,9 @@ struct sco_conninfo {
 	__u8  dev_class[3];
 };
 
+#define SCO_TXBUFS	0x03
+#define SCO_RXBUFS	0x04
+
 /* ---- SCO connections ---- */
 struct sco_conn {
 	struct hci_conn	*hcon;

diff --git a/net/bluetooth/sco.c b/net/bluetooth/sco.c
index 5d13d4f..50f7590 100644
--- a/net/bluetooth/sco.c
+++ b/net/bluetooth/sco.c
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
 
@@ -61,6 +67,8 @@ static struct bt_sock_list sco_sk_list = {
 	.lock = RW_LOCK_UNLOCKED
 };
 
+/* Local functions declaration */
+
 static void __sco_chan_add(struct sco_conn *conn, struct sock *sk, struct sock *parent);
 static void sco_chan_del(struct sock *sk, int err);
 
@@ -69,6 +77,35 @@ static int  sco_conn_del(struct hci_conn *conn, int err);
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
@@ -234,27 +271,30 @@ static inline int sco_send_frame(struct sock *sk, struct msghdr *msg, int len)
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
@@ -273,8 +313,9 @@ static inline void sco_recv_frame(struct sco_conn *conn, struct sk_buff *skb)
 	if (sk->sk_state != BT_CONNECTED)
 		goto drop;
 
-	if (!sock_queue_rcv_skb(sk, skb))
+	if (sco_sock_queue_rcv_skb(sk, skb) == 0) {
 		return;
+	}
 
 drop:
 	kfree_skb(skb);
@@ -328,7 +369,6 @@ static void sco_sock_destruct(struct sock *sk)
 	BT_DBG("sk %p", sk);
 
 	skb_queue_purge(&sk->sk_receive_queue);
-	skb_queue_purge(&sk->sk_write_queue);
 }
 
 static void sco_sock_cleanup_listen(struct sock *parent)
@@ -360,6 +400,8 @@ static void sco_sock_kill(struct sock *sk)
 	/* Kill poor orphan */
 	bt_sock_unlink(&sco_sk_list, sk);
 	sock_set_flag(sk, SOCK_DEAD);
+	
+	/* release socket */
 	sock_put(sk);
 }
 
@@ -376,7 +418,7 @@ static void sco_sock_close(struct sock *sk)
 
 	conn = sco_pi(sk)->conn;
 
-	BT_DBG("sk %p state %d conn %p socket %p", sk, sk->sk_state, conn, sk->sk_socket);
+	BT_DBG("sk %p state %d conn %p socket %p refcnt %d", sk, sk->sk_state, conn, sk->sk_socket, atomic_read(&sk->sk_refcnt));
 
 	switch (sk->sk_state) {
 	case BT_LISTEN:
@@ -426,6 +468,15 @@ static struct sock *sco_sock_alloc(struct socket *sock, int proto, gfp_t prio)
 	INIT_LIST_HEAD(&bt_sk(sk)->accept_q);
 
 	sk->sk_destruct = sco_sock_destruct;
+	sk->sk_write_space = sco_sock_write_space;
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
@@ -656,6 +707,7 @@ static int sco_sock_sendmsg(struct kiocb *iocb, struct socket *sock,
 static int sco_sock_setsockopt(struct socket *sock, int level, int optname, char __user *optval, int optlen)
 {
 	struct sock *sk = sock->sk;
+	u32 opt;
 	int err = 0;
 
 	BT_DBG("sk %p", sk);
@@ -663,6 +715,35 @@ static int sco_sock_setsockopt(struct socket *sock, int level, int optname, char
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
@@ -677,7 +758,8 @@ static int sco_sock_getsockopt(struct socket *sock, int level, int optname, char
 	struct sock *sk = sock->sk;
 	struct sco_options opts;
 	struct sco_conninfo cinfo;
-	int len, err = 0; 
+	int len, err = 0;
+	int val;
 
 	BT_DBG("sk %p", sk);
 
@@ -687,6 +769,24 @@ static int sco_sock_getsockopt(struct socket *sock, int level, int optname, char
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
@@ -891,6 +991,34 @@ drop:
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
+/* ------- Others ------- */
+
 static ssize_t sco_sysfs_show(struct class *dev, char *buf)
 {
 	struct sock *sk;

--------------050901020604010103090203
Content-Type: text/x-vcard; charset=utf-8;
 name="fchevalier.vcf"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="fchevalier.vcf"

begin:vcard
fn:Fabien CHEVALIER
n:CHEVALIER;Fabien
org:SILICOM
adr:;;4 rue de Jouanet;RENNES ATALANTE;;35700;FRANCE
email;internet:fchevalier@silicom.fr
title:Software & Studies Engineer
tel;work:+33 (0) 2 99 84 17 17
version:2.1
end:vcard


--------------050901020604010103090203--
