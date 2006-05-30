Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <447C4862.5050205@free.fr>
Date: Tue, 30 May 2006 15:28:02 +0200
From: Fabien Chevalier <fabchevalier@free.fr>
MIME-Version: 1.0
To: BlueZ development <bluez-devel@lists.sourceforge.net>
References: <447B4F98.8020501@free.fr> <1148934839.31689.116.camel@localhost>
In-Reply-To: <1148934839.31689.116.camel@localhost>
Content-Type: multipart/mixed; boundary="------------090909020508080707070500"
Subject: Re: [Bluez-devel] [PATCH] SCO flow control
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
--------------090909020508080707070500
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hello Marcel&All,

> please split the changes to Bluetooth core and SCO module. Your changes
> to the core will conflict with the automatic sniff mode support and I
> need to sort that out.

Ok, i've just done that, i've split the patch into three smaller bits.
   - Patch part 1 are changes to hci core required for SCO flow control 
itself.
   - Patch part 2 are the changes to the SCO socket layer.
   - Patch part 3 are additionnal comments on hci core code.

Please note however that part 1 and part 2 can not be applied seperately.

> 
> And for the core part, please be brief with any additional comments. My
> rule for comments is to put them where the code is not clear by itself.

I would tend to agree with the general philosophy of the thing, however
for my point of view bluez kernel code lacks proper fields structure 
explanation. Comparing for skbuff.h & usb.h to hci_core.h for instance 
is just night and day... skbuff.h & usb.h are just well commented files, 
while hci.h and hci_core.h have hardly any comment. :-(


> What you have done is actually over-commenting and that makes the code
> harder to read and understand.

Could you give me an example ? I don't see which part is not lined up 
with kernel coding style :-(

anyway,

All this is really *cosmetic* compared to the feature itself. :-)

On another level, does anyone here have anything to add on the feature 
itself, or the way i designed it ??

Cheers,

Fabien

--------------090909020508080707070500
Content-Type: text/plain;
 name="bluez-sco-flowcontrol-1of3.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="bluez-sco-flowcontrol-1of3.diff"

diff -rU 6 --exclude-from=kernelexcludes.txt --exclude='sco.*' /home/fchevalier/tmp/linux-2.6.16.16-orig/include/net/bluetooth/hci_core.h /home/fchevalier/tmp/linux-2.6.16.16/include/net/bluetooth/hci_core.h
--- /home/fchevalier/tmp/linux-2.6.16.16-orig/include/net/bluetooth/hci_core.h	2006-05-11 03:56:24.000000000 +0200
+++ /home/fchevalier/tmp/linux-2.6.16.16/include/net/bluetooth/hci_core.h	2006-05-25 17:47:11.000000000 +0200
@@ -142,26 +148,39 @@
 	atomic_t	 refcnt;
 	spinlock_t	 lock;
 
 	bdaddr_t	 dst;
 	__u16		 handle;
 	__u16		 state;
+	/* type : ACL or SCO */
 	__u8		 type;
 	__u8		 out;
 	__u8		 dev_class[3];
 	__u32		 link_mode;
 	unsigned long	 pend;
 	
+	/* sent represents the number of packets this connections
+           has "on the wire" : .... oh f.... there are no wire
+           with bluetooth. By on the wire, i mean packets that have been sent
+	   to the HCI device, and that are still in its buffers */
 	unsigned int	 sent;
 	
+	/* Queued packets for this connection 
+           Starting with bluez core version 2.9, SCO packets are not in this queue anymore,
+           but remain in the sockets send queue until they are forwared to the driver by
+	   the hci scheduler */
 	struct sk_buff_head data_q;
 
-	struct timer_list timer;
+	/* Data timer : used only for SCO */
+	struct timer_list data_timer;
+	/* Disconnect timer */
+	struct timer_list disc_timer;
 	
 	struct hci_dev	*hdev;
 	void		*l2cap_data;
+	/* private use for sco */
 	void		*sco_data;
 	void		*priv;
 
 	struct hci_conn	*link;
 };
 
@@ -283,37 +302,37 @@
 struct hci_conn *hci_connect(struct hci_dev *hdev, int type, bdaddr_t *src);
 int hci_conn_auth(struct hci_conn *conn);
 int hci_conn_encrypt(struct hci_conn *conn);
 int hci_conn_change_link_key(struct hci_conn *conn);
 int hci_conn_switch_role(struct hci_conn *conn, uint8_t role);
 
-static inline void hci_conn_set_timer(struct hci_conn *conn, unsigned long timeout)
+static inline void hci_conn_set_disc_timer(struct hci_conn *conn, unsigned long timeout)
 {
-	mod_timer(&conn->timer, jiffies + timeout);
+	mod_timer(&conn->disc_timer, jiffies + timeout);
 }
 
-static inline void hci_conn_del_timer(struct hci_conn *conn)
+static inline void hci_conn_del_disc_timer(struct hci_conn *conn)
 {
-	del_timer(&conn->timer);
+	del_timer(&conn->disc_timer);
 }
 
 static inline void hci_conn_hold(struct hci_conn *conn)
 {
 	atomic_inc(&conn->refcnt);
-	hci_conn_del_timer(conn);
+	hci_conn_del_disc_timer(conn);
 }
 
 static inline void hci_conn_put(struct hci_conn *conn)
 {
 	if (atomic_dec_and_test(&conn->refcnt)) {
 		if (conn->type == ACL_LINK) {
 			unsigned long timeo = (conn->out) ?
 				HCI_DISCONN_TIMEOUT : HCI_DISCONN_TIMEOUT * 2;
-			hci_conn_set_timer(conn, timeo);
+			hci_conn_set_disc_timer(conn, timeo);
 		} else
-			hci_conn_set_timer(conn, HZ / 100);
+			hci_conn_set_disc_timer(conn, HZ / 100);
 	}
 }
 
 /* ----- HCI tasks ----- */
 static inline void hci_sched_cmd(struct hci_dev *hdev)
 {
@@ -419,19 +438,20 @@
 	char 		*name;
 	unsigned int	id;
 	unsigned long	flags;
 
 	void		*priv;
 
-	int (*connect_ind) 	(struct hci_dev *hdev, bdaddr_t *bdaddr, __u8 type);
-	int (*connect_cfm)	(struct hci_conn *conn, __u8 status);
-	int (*disconn_ind)	(struct hci_conn *conn, __u8 reason);
-	int (*recv_acldata)	(struct hci_conn *conn, struct sk_buff *skb, __u16 flags);
-	int (*recv_scodata)	(struct hci_conn *conn, struct sk_buff *skb);
-	int (*auth_cfm)		(struct hci_conn *conn, __u8 status);
-	int (*encrypt_cfm)	(struct hci_conn *conn, __u8 status);
+	int             (*connect_ind) 	(struct hci_dev *hdev, bdaddr_t *bdaddr, __u8 type);
+	int             (*connect_cfm)	(struct hci_conn *conn, __u8 status);
+	int             (*disconn_ind)	(struct hci_conn *conn, __u8 reason);
+	int             (*recv_acldata)	(struct hci_conn *conn, struct sk_buff *skb, __u16 flags);
+	int             (*recv_scodata)	(struct hci_conn *conn, struct sk_buff *skb);
+	struct sk_buff* (*get_scodata)	(struct hci_conn *conn);
+	int             (*auth_cfm)	(struct hci_conn *conn, __u8 status);
+	int             (*encrypt_cfm)	(struct hci_conn *conn, __u8 status);
 };
 
 static inline int hci_proto_connect_ind(struct hci_dev *hdev, bdaddr_t *bdaddr, __u8 type)
 {
 	register struct hci_proto *hp;
 	int mask = 0;
@@ -575,13 +595,13 @@
 
 int hci_register_notifier(struct notifier_block *nb);
 int hci_unregister_notifier(struct notifier_block *nb);
 
 int hci_send_cmd(struct hci_dev *hdev, __u16 ogf, __u16 ocf, __u32 plen, void *param);
 int hci_send_acl(struct hci_conn *conn, struct sk_buff *skb, __u16 flags);
-int hci_send_sco(struct hci_conn *conn, struct sk_buff *skb);
+void hci_stream_sco(struct hci_conn *conn);
 
 void *hci_sent_cmd_data(struct hci_dev *hdev, __u16 ogf, __u16 ocf);
 
 void hci_si_event(struct hci_dev *hdev, int type, int dlen, void *data);
 
 /* ----- HCI Sockets ----- */
diff -rU 6 --exclude-from=kernelexcludes.txt --exclude='sco.*' /home/fchevalier/tmp/linux-2.6.16.16-orig/net/bluetooth/af_bluetooth.c /home/fchevalier/tmp/linux-2.6.16.16/net/bluetooth/af_bluetooth.c
--- /home/fchevalier/tmp/linux-2.6.16.16-orig/net/bluetooth/af_bluetooth.c	2006-05-11 03:56:24.000000000 +0200
+++ /home/fchevalier/tmp/linux-2.6.16.16/net/bluetooth/af_bluetooth.c	2006-05-21 17:38:28.000000000 +0200
@@ -46,13 +46,13 @@
 
 #ifndef CONFIG_BT_SOCK_DEBUG
 #undef  BT_DBG
 #define BT_DBG(D...)
 #endif
 
-#define VERSION "2.8"
+#define VERSION "2.9"
 
 /* Bluetooth sockets */
 #define BT_MAX_PROTO	8
 static struct net_proto_family *bt_proto[BT_MAX_PROTO];
 
 int bt_sock_register(int proto, struct net_proto_family *ops)
diff -rU 6 --exclude-from=kernelexcludes.txt --exclude='sco.*' /home/fchevalier/tmp/linux-2.6.16.16-orig/net/bluetooth/hci_conn.c /home/fchevalier/tmp/linux-2.6.16.16/net/bluetooth/hci_conn.c
--- /home/fchevalier/tmp/linux-2.6.16.16-orig/net/bluetooth/hci_conn.c	2006-05-11 03:56:24.000000000 +0200
+++ /home/fchevalier/tmp/linux-2.6.16.16/net/bluetooth/hci_conn.c	2006-05-25 18:09:19.000000000 +0200
@@ -130,17 +130,17 @@
 	else
 		conn->state = BT_CLOSED;
 	hci_dev_unlock(hdev);
 	return;
 }
 
-static void hci_conn_init_timer(struct hci_conn *conn)
+static void hci_conn_init_disc_timer(struct hci_conn *conn)
 {
-	init_timer(&conn->timer);
-	conn->timer.function = hci_conn_timeout;
-	conn->timer.data = (unsigned long)conn;
+	init_timer(&conn->disc_timer);
+	conn->disc_timer.function = hci_conn_timeout;
+	conn->disc_timer.data = (unsigned long)conn;
 }
 
 struct hci_conn *hci_conn_add(struct hci_dev *hdev, int type, bdaddr_t *dst)
 {
 	struct hci_conn *conn;
 
@@ -153,13 +153,14 @@
 	bacpy(&conn->dst, dst);
 	conn->type   = type;
 	conn->hdev   = hdev;
 	conn->state  = BT_OPEN;
 
 	skb_queue_head_init(&conn->data_q);
-	hci_conn_init_timer(conn);
+	hci_conn_init_disc_timer(conn);
+	init_timer(&conn->data_timer);
 
 	atomic_set(&conn->refcnt, 0);
 
 	hci_dev_hold(hdev);
 
 	tasklet_disable(&hdev->tx_task);
@@ -176,13 +177,14 @@
 int hci_conn_del(struct hci_conn *conn)
 {
 	struct hci_dev *hdev = conn->hdev;
 
 	BT_DBG("%s conn %p handle %d", hdev->name, conn, conn->handle);
 
-	hci_conn_del_timer(conn);
+	hci_conn_del_disc_timer(conn);
+	del_timer_sync(&conn->data_timer);
 
 	if (conn->type == SCO_LINK) {
 		struct hci_conn *acl = conn->link;
 		if (acl) {
 			acl->link = NULL;
 			hci_conn_put(acl);
diff -rU 6 --exclude-from=kernelexcludes.txt --exclude='sco.*' /home/fchevalier/tmp/linux-2.6.16.16-orig/net/bluetooth/hci_core.c /home/fchevalier/tmp/linux-2.6.16.16/net/bluetooth/hci_core.c
--- /home/fchevalier/tmp/linux-2.6.16.16-orig/net/bluetooth/hci_core.c	2006-05-11 03:56:24.000000000 +0200
+++ /home/fchevalier/tmp/linux-2.6.16.16/net/bluetooth/hci_core.c	2006-05-30 12:56:00.000000000 +0200
@@ -1116,69 +1116,49 @@
 
 	hci_sched_tx(hdev);
 	return 0;
 }
 EXPORT_SYMBOL(hci_send_acl);
 
-/* Send SCO data */
-int hci_send_sco(struct hci_conn *conn, struct sk_buff *skb)
+/* Push sco data if not already in progress */
+void hci_stream_sco(struct hci_conn *conn)
 {
 	struct hci_dev *hdev = conn->hdev;
-	struct hci_sco_hdr hdr;
-
-	BT_DBG("%s len %d", hdev->name, skb->len);
-
-	if (skb->len > hdev->sco_mtu) {
-		kfree_skb(skb);
-		return -EINVAL;
-	}
-
-	hdr.handle = __cpu_to_le16(conn->handle);
-	hdr.dlen   = skb->len;
-
-	skb->h.raw = skb_push(skb, HCI_SCO_HDR_SIZE);
-	memcpy(skb->h.raw, &hdr, HCI_SCO_HDR_SIZE);
-
-	skb->dev = (void *) hdev;
-	bt_cb(skb)->pkt_type = HCI_SCODATA_PKT;
-	skb_queue_tail(&conn->data_q, skb);
 	hci_sched_tx(hdev);
-	return 0;
 }
-EXPORT_SYMBOL(hci_send_sco);
+EXPORT_SYMBOL(hci_stream_sco);
 
 /* ---- HCI TX task (outgoing data) ---- */
 
-/* HCI Connection scheduler */
-static inline struct hci_conn *hci_low_sent(struct hci_dev *hdev, __u8 type, int *quote)
+/* HCI ACL Connection scheduler */
+static inline struct hci_conn *hci_low_sent_acl(struct hci_dev *hdev, int *quote)
 {
 	struct hci_conn_hash *h = &hdev->conn_hash;
 	struct hci_conn  *conn = NULL;
 	int num = 0, min = ~0;
 	struct list_head *p;
 
 	/* We don't have to lock device here. Connections are always 
 	 * added and removed with TX task disabled. */
 	list_for_each(p, &h->list) {
 		struct hci_conn *c;
 		c = list_entry(p, struct hci_conn, list);
 
-		if (c->type != type || c->state != BT_CONNECTED
+		if (c->type != ACL_LINK || c->state != BT_CONNECTED
 				|| skb_queue_empty(&c->data_q))
 			continue;
 		num++;
 
 		if (c->sent < min) {
 			min  = c->sent;
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
@@ -1215,41 +1195,95 @@
 		/* ACL tx timeout must be longer than maximum
 		 * link supervision timeout (40.9 seconds) */
 		if (!hdev->acl_cnt && (jiffies - hdev->acl_last_tx) > (HZ * 45))
 			hci_acl_tx_to(hdev);
 	}
 
-	while (hdev->acl_cnt && (conn = hci_low_sent(hdev, ACL_LINK, &quote))) {
+	while (hdev->acl_cnt && (conn = hci_low_sent_acl(hdev, &quote))) {
 		while (quote-- && (skb = skb_dequeue(&conn->data_q))) {
 			BT_DBG("skb %p len %d", skb, skb->len);
 			hci_send_frame(skb);
 			hdev->acl_last_tx = jiffies;
 
 			hdev->acl_cnt--;
 			conn->sent++;
 		}
 	}
 }
 
-/* Schedule SCO */
+/* HCI SCO Connection scheduler */
+
+static void hci_send_sco(struct hci_dev *hdev, struct hci_conn *conn, struct sk_buff *skb)
+{
+	struct hci_sco_hdr hdr;
+
+	BT_DBG("skb %p len %d", skb, skb->len);
+	/* preparing frame */
+
+	hdr.handle = __cpu_to_le16(conn->handle);
+	hdr.dlen   = skb->len;
+
+	skb->h.raw = skb_push(skb, HCI_SCO_HDR_SIZE);
+	memcpy(skb->h.raw, &hdr, HCI_SCO_HDR_SIZE);
+
+	skb->dev = (void *) hdev;
+	bt_cb(skb)->pkt_type = HCI_SCODATA_PKT;
+
+	hci_send_frame(skb);
+}
+
+static void hci_sco_tx_timer(unsigned long data)
+{
+	struct hci_conn *conn = (struct hci_conn *) data;
+	BT_DBG("%s, conn %p", conn->hdev->name, conn);
+	if(conn->sent > 0) {
+		conn->sent--;
+		conn->hdev->sco_cnt++;
+		hci_sched_tx(conn->hdev);
+	}
+}
+
 static inline void hci_sched_sco(struct hci_dev *hdev)
 {
-	struct hci_conn *conn;
+	struct hci_conn_hash *h = &hdev->conn_hash;
 	struct sk_buff *skb;
-	int quote;
-
+	struct hci_proto *hp = hci_proto[HCI_PROTO_SCO];
+	struct list_head *p;
+	struct hci_conn *c;
+	
 	BT_DBG("%s", hdev->name);
 
-	while (hdev->sco_cnt && (conn = hci_low_sent(hdev, SCO_LINK, &quote))) {
-		while (quote-- && (skb = skb_dequeue(&conn->data_q))) {
-			BT_DBG("skb %p len %d", skb, skb->len);
-			hci_send_frame(skb);
+	/* We don't have to lock device here. Connections are always 
+	 * added and removed with TX task disabled. */
+	list_for_each(p, &h->list) {
+		c = list_entry(p, struct hci_conn, list);
 
-			conn->sent++;
-			if (conn->sent == ~0)
-				conn->sent = 0;
+		/* SCO scheduling algorithm makes sure there is never more than
+		   1 outstanding packet for each connection -- I tried with
+                   2 and more, however there voice quality was not significantly
+		   increased. So let it be 1.*/
+		if (c->sent < 1 && c->type == SCO_LINK && c->state == BT_CONNECTED)
+		{
+			if(hdev->sco_cnt > 0) {
+				if((skb = hp->get_scodata(c)) != NULL) {
+					hci_send_sco(hdev, c, skb);
+
+					c->sent++;			
+					hdev->sco_cnt--;
+
+					c->data_timer.data = (unsigned long)c;
+					c->data_timer.function = hci_sco_tx_timer;
+					/* At this point we are already supposed to have skb->len a multiple of 16 --
+					   this is supposed to be enforced by SCO socket layer */
+					mod_timer(&c->data_timer, jiffies + 1000 * (skb->len % 16) / HZ );	
+				}
+			}
+			else {
+				/* exit from loop, as there is no free HCI SCO buffer */
+				break;
+			}
 		}
 	}
 }
 
 static void hci_tx_task(unsigned long arg)
 {
@@ -1259,16 +1293,16 @@
 	read_lock(&hci_task_lock);
 
 	BT_DBG("%s acl %d sco %d", hdev->name, hdev->acl_cnt, hdev->sco_cnt);
 
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

--------------090909020508080707070500
Content-Type: text/plain;
 name="bluez-sco-flowcontrol-2of3.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="bluez-sco-flowcontrol-2of3.diff"

diff -rU 6 --exclude-from=kernelexcludes.txt --exclude='*hci*' --exclude='af_bluetooth.*' /home/fchevalier/tmp/linux-2.6.16.16-orig/include/net/bluetooth/sco.h /home/fchevalier/tmp/linux-2.6.16.16/include/net/bluetooth/sco.h
--- /home/fchevalier/tmp/linux-2.6.16.16-orig/include/net/bluetooth/sco.h	2006-05-11 03:56:24.000000000 +0200
+++ /home/fchevalier/tmp/linux-2.6.16.16/include/net/bluetooth/sco.h	2006-05-28 17:36:49.000000000 +0200
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
diff -rU 6 --exclude-from=kernelexcludes.txt --exclude='*hci*' --exclude='af_bluetooth.*' /home/fchevalier/tmp/linux-2.6.16.16-orig/net/bluetooth/sco.c /home/fchevalier/tmp/linux-2.6.16.16/net/bluetooth/sco.c
--- /home/fchevalier/tmp/linux-2.6.16.16-orig/net/bluetooth/sco.c	2006-05-11 03:56:24.000000000 +0200
+++ /home/fchevalier/tmp/linux-2.6.16.16/net/bluetooth/sco.c	2006-05-30 13:58:51.000000000 +0200
@@ -51,28 +51,48 @@
 
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
+
+static unsigned int tx_quality_tune;
+static unsigned int rx_quality_tune;
 
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
 
+static void sco_sock_wfree(struct sk_buff *skb);
+static void sco_sock_rfree(struct sk_buff *skb);
+static long sock_wait_for_wmem(struct sock * sk, long timeo);
+
+static struct sk_buff *sco_skb_send_alloc(struct sock *sk, unsigned long len, 
+							int nb, int *errcode);
+
+static int sco_sock_queue_rcv_skb(struct sock *sk, struct sk_buff *skb);
+
 /* ---- SCO timers ---- */
 static void sco_sock_timeout(unsigned long arg)
 {
 	struct sock *sk = (struct sock *) arg;
 
 	BT_DBG("sock %p state %d", sk, sk->sk_state);
@@ -230,58 +250,30 @@
 done:
 	hci_dev_unlock_bh(hdev);
 	hci_dev_put(hdev);
 	return err;
 }
 
-static inline int sco_send_frame(struct sock *sk, struct msghdr *msg, int len)
-{
-	struct sco_conn *conn = sco_pi(sk)->conn;
-	struct sk_buff *skb;
-	int err, count;
-
-	/* Check outgoing MTU */
-	if (len > conn->mtu)
-		return -EINVAL;
-
-	BT_DBG("sk %p len %d", sk, len);
-
-	count = min_t(unsigned int, conn->mtu, len);
-	if (!(skb = bt_skb_send_alloc(sk, count, msg->msg_flags & MSG_DONTWAIT, &err)))
-		return err;
-
-	if (memcpy_fromiovec(skb_put(skb, count), msg->msg_iov, count)) {
-		err = -EFAULT;
-		goto fail;
-	}
-
-	if ((err = hci_send_sco(conn->hcon, skb)) < 0)
-		goto fail;
-
-	return count;
-
-fail:
-	kfree_skb(skb);
-	return err;
-}
-
 static inline void sco_recv_frame(struct sco_conn *conn, struct sk_buff *skb)
 {
 	struct sock *sk = sco_chan_get(conn);
 
 	if (!sk)
 		goto drop;
 
 	BT_DBG("sk %p len %d", sk, skb->len);
 
 	if (sk->sk_state != BT_CONNECTED)
 		goto drop;
 
-	if (!sock_queue_rcv_skb(sk, skb))
+	if (sco_sock_queue_rcv_skb(sk, skb) == 0) {
 		return;
-
+	}
+	else if(rx_quality_tune) {
+		printk(KERN_INFO "rx_quality_tune: audio cut !\n");
+	}
 drop:
 	kfree_skb(skb);
 	return;
 }
 
 /* -------- Socket interface ---------- */
@@ -328,13 +320,30 @@
 
 static void sco_sock_destruct(struct sock *sk)
 {
 	BT_DBG("sk %p", sk);
 
 	skb_queue_purge(&sk->sk_receive_queue);
-	skb_queue_purge(&sk->sk_write_queue);
+}
+
+static void sco_sock_write_space(struct sock *sk)
+{
+	read_lock(&sk->sk_callback_lock);
+
+	/* Unlock writers ASAP
+	 */
+	if((atomic_read(&sk->sk_wmem_alloc)) < sk->sk_sndbuf) {
+		if (sk->sk_sleep && waitqueue_active(sk->sk_sleep))
+			wake_up_interruptible(sk->sk_sleep);
+
+		/* Should agree with poll, otherwise some programs break */
+		if (sock_writeable(sk))
+			sk_wake_async(sk, 2, POLL_OUT);
+	}
+
+	read_unlock(&sk->sk_callback_lock);
 }
 
 static void sco_sock_cleanup_listen(struct sock *parent)
 {
 	struct sock *sk;
 
@@ -360,12 +369,19 @@
 
 	BT_DBG("sk %p state %d", sk, sk->sk_state);
 
 	/* Kill poor orphan */
 	bt_sock_unlink(&sco_sk_list, sk);
 	sock_set_flag(sk, SOCK_DEAD);
+	
+	/* We cannot purge write queue in socket destructor as
+        it was done before, as skb in this queue hold a reference
+        to the socket itself */
+	skb_queue_purge(&sk->sk_write_queue);
+
+	/* release socket */
 	sock_put(sk);
 }
 
 /* Close socket.
  * Must be called on unlocked socket.
  */
@@ -376,13 +392,13 @@
 	sco_sock_clear_timer(sk);
 
 	lock_sock(sk);
 
 	conn = sco_pi(sk)->conn;
 
-	BT_DBG("sk %p state %d conn %p socket %p", sk, sk->sk_state, conn, sk->sk_socket);
+	BT_DBG("sk %p state %d conn %p socket %p refcnt %d", sk, sk->sk_state, conn, sk->sk_socket, atomic_read(&sk->sk_refcnt));
 
 	switch (sk->sk_state) {
 	case BT_LISTEN:
 		sco_sock_cleanup_listen(sk);
 		break;
 
@@ -426,12 +442,21 @@
 		return NULL;
 
 	sock_init_data(sock, sk);
 	INIT_LIST_HEAD(&bt_sk(sk)->accept_q);
 
 	sk->sk_destruct = sco_sock_destruct;
+	sk->sk_write_space = sco_sock_write_space;
+
+	/* Put sensible values for a voice link (i.e. not too big),
+	   as sysctl_rmem_default & sysctl_wmem_default are
+           really not designed for that -- In our case we use sk_**buf to
+           store a count of SCO packets, not a number of bytes as most of other type of
+           sockets do */
+	sk->sk_sndbuf = DEFAULT_SCO_TXBUFS;
+	sk->sk_rcvbuf = DEFAULT_SCO_RXBUFS;
 	sk->sk_sndtimeo = SCO_CONN_TIMEOUT;
 
 	sock_reset_flag(sk, SOCK_ZAPPED);
 
 	sk->sk_protocol = proto;
 	sk->sk_state    = BT_OPEN;
@@ -631,43 +656,100 @@
 
 static int sco_sock_sendmsg(struct kiocb *iocb, struct socket *sock, 
 			    struct msghdr *msg, size_t len)
 {
 	struct sock *sk = sock->sk;
 	int err = 0;
+	struct sk_buff * skb;
+	struct sco_conn *conn = 0;
 
-	BT_DBG("sock %p, sk %p", sock, sk);
+	BT_DBG("sock %p, sk %p, len %d", sock, sk, len);
 
 	err = sock_error(sk);
 	if (err)
 		return err;
 
 	if (msg->msg_flags & MSG_OOB)
 		return -EOPNOTSUPP;
 
+
 	lock_sock(sk);
 
-	if (sk->sk_state == BT_CONNECTED)
-		err = sco_send_frame(sk, msg, len);
-	else
-		err = -ENOTCONN;
+	conn = sco_pi(sk)->conn;
+
+	/* Check outgoing MTU and that this is a 16 bytes multiple .
+           16 bytes multiple is required by the new SCO scheduler algorithm */
+	if (len <= conn->mtu && (len % 16) == 0) {
+		if (sk->sk_state == BT_CONNECTED) {
+			/* This is the call that will put us to sleep if socket send queue is full */
+			skb = sco_skb_send_alloc(sk, len,
+					msg->msg_flags & MSG_DONTWAIT, &err);
+	
+			if (skb) {		
+				err = memcpy_fromiovec(skb_put(skb, len), msg->msg_iov, len);
+				if (err == 0) {
+	
+					BT_DBG("skb %p, size %d", skb, len);
+			
+					skb_queue_tail(&sk->sk_write_queue, skb);
+					hci_stream_sco(conn->hcon);
+					err = len;
+				}
+				else {
+					kfree_skb(skb);
+				}
+			}
+		}
+		else {
+			err = -ENOTCONN;
+		}
+	}
+	else {
+		err = -EINVAL;
+	}
 
 	release_sock(sk);
+
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
@@ -676,22 +758,41 @@
 
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
 
@@ -890,12 +991,169 @@
 
 drop:
 	kfree_skb(skb);	
 	return 0;
 }
 
+struct sk_buff* sco_get_scodata(struct hci_conn *hcon)
+{
+	struct sco_conn *conn = hcon->sco_data;
+	struct sk_buff* skb = NULL;
+
+	BT_DBG("conn %p", conn);
+
+	if (conn) {
+		struct sock *sk = sco_chan_get(conn);
+		if(sk) {
+			skb = skb_dequeue(&sk->sk_write_queue);
+		}
+	}
+
+	if(skb == NULL && tx_quality_tune) {
+		printk(KERN_INFO "tx_quality_tune: audio cut !\n");
+	}
+
+	return skb;
+}
+
+/* Generic socket manipulations functions, adapted for SCO */
+
+static void sco_sock_wfree(struct sk_buff *skb)
+{
+	struct sock *sk = skb->sk;
+
+	atomic_sub(1, &sk->sk_wmem_alloc);
+	if (!sock_flag(sk, SOCK_USE_WRITE_QUEUE))
+		sk->sk_write_space(sk);
+	sock_put(sk);
+}
+
+static void sco_sock_rfree(struct sk_buff *skb)
+{
+	struct sock *sk = skb->sk;
+
+	atomic_sub(1, &sk->sk_rmem_alloc);
+}
+
+
+static long sock_wait_for_wmem(struct sock * sk, long timeo)
+{
+	DEFINE_WAIT(wait);
+
+	clear_bit(SOCK_ASYNC_NOSPACE, &sk->sk_socket->flags);
+	for (;;) {
+		if (!timeo)
+			break;
+		if (signal_pending(current))
+			break;
+		set_bit(SOCK_NOSPACE, &sk->sk_socket->flags);
+		prepare_to_wait(sk->sk_sleep, &wait, TASK_INTERRUPTIBLE);
+		if (atomic_read(&sk->sk_wmem_alloc) < sk->sk_sndbuf)
+			break;
+		if (sk->sk_shutdown & SEND_SHUTDOWN)
+			break;
+		if (sk->sk_err)
+			break;
+		timeo = schedule_timeout(timeo);
+	}
+	finish_wait(sk->sk_sleep, &wait);
+	return timeo;
+}
+
+static struct sk_buff *sco_skb_send_alloc(struct sock *sk, unsigned long len, 
+							int nb, int *errcode)
+{
+	struct sk_buff *skb;
+	gfp_t gfp_mask;
+	int err;
+	long timeo = nb ? 0 : MAX_SCHEDULE_TIMEOUT;
+
+	gfp_mask = sk->sk_allocation;
+	if (gfp_mask & __GFP_WAIT)
+		gfp_mask |= __GFP_REPEAT;
+
+	while (1) {
+		err = sock_error(sk);
+		if (err != 0)
+			goto failure;
+
+		err = -EPIPE;
+		if (sk->sk_shutdown & SEND_SHUTDOWN)
+			goto failure;
+
+		if (atomic_read(&sk->sk_wmem_alloc) < sk->sk_sndbuf) {
+			skb = alloc_skb(len + BT_SKB_RESERVE, sk->sk_allocation);
+			if (skb) {
+				/* Full success... */
+				break;
+			}
+			err = -ENOBUFS;
+			goto failure;
+		}
+		set_bit(SOCK_ASYNC_NOSPACE, &sk->sk_socket->flags);
+		set_bit(SOCK_NOSPACE, &sk->sk_socket->flags);
+		err = -EAGAIN;
+		if (!timeo)
+			goto failure;
+		if (signal_pending(current))
+			goto interrupted;
+		timeo = sock_wait_for_wmem(sk, timeo);
+	}
+
+	sock_hold(sk);
+	skb->sk = sk;
+	skb->destructor = sco_sock_wfree;
+	atomic_add(1, &sk->sk_wmem_alloc);
+	skb_reserve(skb, BT_SKB_RESERVE);
+	bt_cb(skb)->incoming  = 0;
+
+	return skb;
+
+interrupted:
+	err = sock_intr_errno(timeo);
+failure:
+	*errcode = err;
+	return NULL;
+}
+
+static int sco_sock_queue_rcv_skb(struct sock *sk, struct sk_buff *skb)
+{
+	int err = 0;
+	int skb_len;
+
+	/* Cast skb->rcvbuf to unsigned... It's pointless, but reduces
+	   number of warnings when compiling with -W --ANK
+	 */
+	if (atomic_read(&sk->sk_rmem_alloc) >=
+	    (unsigned)sk->sk_rcvbuf) {
+		err = -ENOMEM;
+		goto out;
+	}
+
+	skb->dev = NULL;
+	skb->sk = sk;
+	skb->destructor = sco_sock_rfree;
+	atomic_add(1, &sk->sk_rmem_alloc);
+
+	/* Cache the SKB length before we tack it onto the receive
+	 * queue.  Once it is added it no longer belongs to us and
+	 * may be freed by other threads of control pulling packets
+	 * from the queue.
+	 */
+	skb_len = skb->len;
+
+	skb_queue_tail(&sk->sk_receive_queue, skb);
+
+	if (!sock_flag(sk, SOCK_DEAD))
+		sk->sk_data_ready(sk, skb_len);
+out:
+	return err;
+}
+
+/* ------- Others ------- */
+
 static ssize_t sco_sysfs_show(struct class *dev, char *buf)
 {
 	struct sock *sk;
 	struct hlist_node *node;
 	char *str = buf;
 
@@ -943,13 +1201,14 @@
 static struct hci_proto sco_hci_proto = {
 	.name		= "SCO",
 	.id		= HCI_PROTO_SCO,
 	.connect_ind	= sco_connect_ind,
 	.connect_cfm	= sco_connect_cfm,
 	.disconn_ind	= sco_disconn_ind,
-	.recv_scodata	= sco_recv_scodata
+	.recv_scodata	= sco_recv_scodata,
+	.get_scodata    = sco_get_scodata
 };
 
 static int __init sco_init(void)
 {
 	int err;
 
@@ -995,11 +1254,17 @@
 	proto_unregister(&sco_proto);
 }
 
 module_init(sco_init);
 module_exit(sco_exit);
 
+module_param(tx_quality_tune, bool, 0644);
+MODULE_PARM_DESC(tx_quality_tune, "Print warning message when an audio cut will happen in tx");
+
+module_param(rx_quality_tune, bool, 0644);
+MODULE_PARM_DESC(rx_quality_tune, "Print warning message when an audio cut will happen in rx");
+
 MODULE_AUTHOR("Maxim Krasnyansky <maxk@qualcomm.com>, Marcel Holtmann <marcel@holtmann.org>");
 MODULE_DESCRIPTION("Bluetooth SCO ver " VERSION);
 MODULE_VERSION(VERSION);
 MODULE_LICENSE("GPL");
 MODULE_ALIAS("bt-proto-2");

--------------090909020508080707070500
Content-Type: text/plain;
 name="bluez-sco-flowcontrol-3of3.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="bluez-sco-flowcontrol-3of3.diff"

diff -rU 6 --exclude-from=kernelexcludes.txt --exclude='sco.*' /home/fchevalier/tmp/linux-2.6.16.16-orig/include/net/bluetooth/hci.h /home/fchevalier/tmp/linux-2.6.16.16/include/net/bluetooth/hci.h
--- /home/fchevalier/tmp/linux-2.6.16.16-orig/include/net/bluetooth/hci.h	2006-05-11 03:56:24.000000000 +0200
+++ /home/fchevalier/tmp/linux-2.6.16.16/include/net/bluetooth/hci.h	2006-05-21 15:55:23.000000000 +0200
@@ -712,12 +712,15 @@
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
 
@@ -727,15 +730,19 @@
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
diff -rU 6 --exclude-from=kernelexcludes.txt --exclude='sco.*' /home/fchevalier/tmp/linux-2.6.16.16-orig/include/net/bluetooth/hci_core.h /home/fchevalier/tmp/linux-2.6.16.16/include/net/bluetooth/hci_core.h
--- /home/fchevalier/tmp/linux-2.6.16.16-orig/include/net/bluetooth/hci_core.h	2006-05-11 03:56:24.000000000 +0200
+++ /home/fchevalier/tmp/linux-2.6.16.16/include/net/bluetooth/hci_core.h	2006-05-25 17:47:11.000000000 +0200
@@ -81,18 +81,24 @@
 	__u16		link_policy;
 	__u16		link_mode;
 
 	unsigned long	quirks;
 
 	atomic_t	cmd_cnt;
+	/* Number of available controller buffers for ACL packets */
 	unsigned int	acl_cnt;
+	/* Number of available controller buffers for SCO packets */
 	unsigned int	sco_cnt;
 
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
 

--------------090909020508080707070500
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--------------090909020508080707070500
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--------------090909020508080707070500--
