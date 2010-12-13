Return-Path: <cyrus@holtmann.org>
From: Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFC] Bluetooth: Use non-flushable pb flag by default for ACL data on capable chipsets.
Date: Mon, 13 Dec 2010 16:38:25 +0200
Message-Id: <1292251105-31130-2-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1292251105-31130-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1292251105-31130-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@nokia.com>

Modification of Nick Pelly <npelly@google.com> patch.

With Bluetooth 2.1 ACL packets can be flushable or non-flushable. This commit
makes ACL data packets non-flushable by default on compatible chipsets, and
adds the BT_FLUSHABLE socket option to explicitly request flushable ACL
data packets for a given L2CAP socket. This is useful for A2DP data which can
be safely discarded if it can not be delivered within a short time (while
other ACL data should not be discarded).

Note that making ACL data flushable has no effect unless the automatic flush
timeout for that ACL link is changed from its default of 0 (infinite).

Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@nokia.com>
---
 include/net/bluetooth/bluetooth.h |    5 +++++
 include/net/bluetooth/hci.h       |    2 ++
 include/net/bluetooth/hci_core.h  |    1 +
 include/net/bluetooth/l2cap.h     |    2 ++
 net/bluetooth/hci_core.c          |    6 ++++--
 net/bluetooth/l2cap.c             |   33 +++++++++++++++++++++++++++++++--
 6 files changed, 45 insertions(+), 4 deletions(-)

diff --git a/include/net/bluetooth/bluetooth.h b/include/net/bluetooth/bluetooth.h
index 0c5e725..ed7d775 100644
--- a/include/net/bluetooth/bluetooth.h
+++ b/include/net/bluetooth/bluetooth.h
@@ -64,6 +64,11 @@ struct bt_security {
 
 #define BT_DEFER_SETUP	7
 
+#define BT_FLUSHABLE	8
+
+#define BT_FLUSHABLE_OFF	0
+#define BT_FLUSHABLE_ON		1
+
 #define BT_INFO(fmt, arg...) printk(KERN_INFO "Bluetooth: " fmt "\n" , ## arg)
 #define BT_ERR(fmt, arg...)  printk(KERN_ERR "%s: " fmt "\n" , __func__ , ## arg)
 #define BT_DBG(fmt, arg...)  pr_debug("%s: " fmt "\n" , __func__ , ## arg)
diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index 29a7a8c..333d5cb 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -150,6 +150,7 @@ enum {
 #define EDR_ESCO_MASK  (ESCO_2EV3 | ESCO_3EV3 | ESCO_2EV5 | ESCO_3EV5)
 
 /* ACL flags */
+#define ACL_START_NO_FLUSH	0x00
 #define ACL_CONT		0x01
 #define ACL_START		0x02
 #define ACL_ACTIVE_BCAST	0x04
@@ -193,6 +194,7 @@ enum {
 #define LMP_EDR_ESCO_3M	0x40
 #define LMP_EDR_3S_ESCO	0x80
 
+#define LMP_NO_FLUSH	0x01
 #define LMP_SIMPLE_PAIR	0x08
 
 /* Connection modes */
diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 1992fac..9778bc8 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -456,6 +456,7 @@ void hci_conn_del_sysfs(struct hci_conn *conn);
 #define lmp_sniffsubr_capable(dev) ((dev)->features[5] & LMP_SNIFF_SUBR)
 #define lmp_esco_capable(dev)      ((dev)->features[3] & LMP_ESCO)
 #define lmp_ssp_capable(dev)       ((dev)->features[6] & LMP_SIMPLE_PAIR)
+#define lmp_no_flush_capable(dev)  ((dev)->features[6] & LMP_NO_FLUSH)
 
 /* ----- HCI protocols ----- */
 struct hci_proto {
diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
index 7ad25ca..af35711 100644
--- a/include/net/bluetooth/l2cap.h
+++ b/include/net/bluetooth/l2cap.h
@@ -75,6 +75,7 @@ struct l2cap_conninfo {
 #define L2CAP_LM_TRUSTED	0x0008
 #define L2CAP_LM_RELIABLE	0x0010
 #define L2CAP_LM_SECURE		0x0020
+#define L2CAP_LM_FLUSHABLE	0x0040
 
 /* L2CAP command codes */
 #define L2CAP_COMMAND_REJ	0x01
@@ -327,6 +328,7 @@ struct l2cap_pinfo {
 	__u8		sec_level;
 	__u8		role_switch;
 	__u8		force_reliable;
+	__u8		flushable;
 
 	__u8		conf_req[64];
 	__u8		conf_len;
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 51c61f7..c0d776b 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -1380,7 +1380,7 @@ void hci_send_acl(struct hci_conn *conn, struct sk_buff *skb, __u16 flags)
 
 	skb->dev = (void *) hdev;
 	bt_cb(skb)->pkt_type = HCI_ACLDATA_PKT;
-	hci_add_acl_hdr(skb, conn->handle, flags | ACL_START);
+	hci_add_acl_hdr(skb, conn->handle, flags);
 
 	list = skb_shinfo(skb)->frag_list;
 	if (!list) {
@@ -1398,12 +1398,14 @@ void hci_send_acl(struct hci_conn *conn, struct sk_buff *skb, __u16 flags)
 		spin_lock_bh(&conn->data_q.lock);
 
 		__skb_queue_tail(&conn->data_q, skb);
+		flags &= ~ACL_START;
+		flags |= ACL_CONT;
 		do {
 			skb = list; list = list->next;
 
 			skb->dev = (void *) hdev;
 			bt_cb(skb)->pkt_type = HCI_ACLDATA_PKT;
-			hci_add_acl_hdr(skb, conn->handle, flags | ACL_CONT);
+			hci_add_acl_hdr(skb, conn->handle, flags);
 
 			BT_DBG("%s frag %p len %d", hdev->name, skb, skb->len);
 
diff --git a/net/bluetooth/l2cap.c b/net/bluetooth/l2cap.c
index c791fcd..c7f25c2 100644
--- a/net/bluetooth/l2cap.c
+++ b/net/bluetooth/l2cap.c
@@ -362,13 +362,19 @@ static inline u8 l2cap_get_ident(struct l2cap_conn *conn)
 static inline void l2cap_send_cmd(struct l2cap_conn *conn, u8 ident, u8 code, u16 len, void *data)
 {
 	struct sk_buff *skb = l2cap_build_cmd(conn, code, ident, len, data);
+	u8 flags;
 
 	BT_DBG("code 0x%2.2x", code);
 
 	if (!skb)
 		return;
 
-	hci_send_acl(conn->hcon, skb, 0);
+	if (lmp_no_flush_capable(conn->hcon->hdev))
+		flags = ACL_START_NO_FLUSH;
+	else
+		flags = ACL_START;
+
+	hci_send_acl(conn->hcon, skb, flags);
 }
 
 static inline void l2cap_send_sframe(struct l2cap_pinfo *pi, u16 control)
@@ -900,6 +906,7 @@ static void l2cap_sock_init(struct sock *sk, struct sock *parent)
 		pi->sec_level = l2cap_pi(parent)->sec_level;
 		pi->role_switch = l2cap_pi(parent)->role_switch;
 		pi->force_reliable = l2cap_pi(parent)->force_reliable;
+		pi->flushable = l2cap_pi(parent)->flushable;
 	} else {
 		pi->imtu = L2CAP_DEFAULT_MTU;
 		pi->omtu = 0;
@@ -915,6 +922,7 @@ static void l2cap_sock_init(struct sock *sk, struct sock *parent)
 		pi->sec_level = BT_SECURITY_LOW;
 		pi->role_switch = 0;
 		pi->force_reliable = 0;
+		pi->flushable = BT_FLUSHABLE_OFF;
 	}
 
 	/* Default config options */
@@ -2098,6 +2106,20 @@ static int l2cap_sock_setsockopt(struct socket *sock, int level, int optname, ch
 		bt_sk(sk)->defer_setup = opt;
 		break;
 
+	case BT_FLUSHABLE:
+		if (get_user(opt, (u32 __user *) optval)) {
+			err = -EFAULT;
+			break;
+		}
+
+		if (opt > BT_FLUSHABLE_ON) {
+			err = -EINVAL;
+			break;
+		}
+
+		l2cap_pi(sk)->flushable = opt;
+		break;
+
 	default:
 		err = -ENOPROTOOPT;
 		break;
@@ -2237,6 +2259,13 @@ static int l2cap_sock_getsockopt(struct socket *sock, int level, int optname, ch
 
 		break;
 
+	case BT_FLUSHABLE:
+
+		if (put_user(l2cap_pi(sk)->flushable, (u32 __user *) optval))
+ 			err = -EFAULT;
+
+ 		break;
+
 	default:
 		err = -ENOPROTOOPT;
 		break;
@@ -4697,7 +4726,7 @@ static int l2cap_recv_acldata(struct hci_conn *hcon, struct sk_buff *skb, u16 fl
 
 	BT_DBG("conn %p len %d flags 0x%x", conn, skb->len, flags);
 
-	if (flags & ACL_START) {
+	if (!(flags & ACL_CONT)) {
 		struct l2cap_hdr *hdr;
 		struct sock *sk;
 		u16 cid;
-- 
1.7.1

