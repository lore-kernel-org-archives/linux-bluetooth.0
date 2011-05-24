Return-Path: <cyrus@holtmann.org>
From: Jaikumar Ganesh <jaikumar@google.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jaikumar Ganesh <jaikumar@google.com>
Subject: [PATCH] Bluetooth: Add BT_POWER L2CAP socket option.
Date: Mon, 23 May 2011 18:06:04 -0700
Message-Id: <1306199164-28310-1-git-send-email-jaikumar@google.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Add BT_POWER socket option used to control the power
characteristics of the underlying ACL link. When the remote end
has put the link in sniff mode and the host stack wants to send
data we need need to explicitly exit sniff mode to work well with
certain devices (For example, A2DP on Plantronics Voyager 855).
However, this causes problems with HID devices.

Hence, moving into active mode when sending data, irrespective
of who set the sniff mode has been made as a socket option. By
default, we will move into active mode. HID devices can set the
L2CAP socket option to prevent this from happening.

Currently, this has been implemented for L2CAP sockets. This has been
tested with incoming and outgoing L2CAP sockets for HID and A2DP.

Based on discussions on linux-bluetooth and patches submitted by
Andrei Emeltchenko.

Signed-off-by: Jaikumar Ganesh <jaikumar@google.com>
---
 include/net/bluetooth/bluetooth.h |    8 ++++++++
 include/net/bluetooth/hci_core.h  |    2 +-
 include/net/bluetooth/l2cap.h     |    1 +
 net/bluetooth/hci_conn.c          |    9 ++++++---
 net/bluetooth/hci_core.c          |    4 ++--
 net/bluetooth/l2cap_core.c        |    5 +++++
 net/bluetooth/l2cap_sock.c        |   36 ++++++++++++++++++++++++++++++++++++
 7 files changed, 59 insertions(+), 6 deletions(-)

diff --git a/include/net/bluetooth/bluetooth.h b/include/net/bluetooth/bluetooth.h
index 4375043..af930a3 100644
--- a/include/net/bluetooth/bluetooth.h
+++ b/include/net/bluetooth/bluetooth.h
@@ -69,6 +69,13 @@ struct bt_security {
 #define BT_FLUSHABLE_OFF	0
 #define BT_FLUSHABLE_ON		1
 
+#define BT_POWER	9
+struct bt_power {
+	__u8 force_active;
+};
+#define BT_POWER_FORCE_ACTIVE_OFF 0
+#define BT_POWER_FORCE_ACTIVE_ON  1
+
 #define BT_INFO(fmt, arg...) printk(KERN_INFO "Bluetooth: " fmt "\n" , ## arg)
 #define BT_ERR(fmt, arg...)  printk(KERN_ERR "%s: " fmt "\n" , __func__ , ## arg)
 #define BT_DBG(fmt, arg...)  pr_debug("%s: " fmt "\n" , __func__ , ## arg)
@@ -150,6 +157,7 @@ struct bt_skb_cb {
 	__u8 retries;
 	__u8 sar;
 	unsigned short channel;
+	__u8 force_active;
 };
 #define bt_cb(skb) ((struct bt_skb_cb *)((skb)->cb))
 
diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 6c994c0..0747841 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -427,7 +427,7 @@ int hci_conn_security(struct hci_conn *conn, __u8 sec_level, __u8 auth_type);
 int hci_conn_change_link_key(struct hci_conn *conn);
 int hci_conn_switch_role(struct hci_conn *conn, __u8 role);
 
-void hci_conn_enter_active_mode(struct hci_conn *conn);
+void hci_conn_enter_active_mode(struct hci_conn *conn, __u8 force_active);
 void hci_conn_enter_sniff_mode(struct hci_conn *conn);
 
 void hci_conn_hold_device(struct hci_conn *conn);
diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
index d09c9b1..942970d 100644
--- a/include/net/bluetooth/l2cap.h
+++ b/include/net/bluetooth/l2cap.h
@@ -302,6 +302,7 @@ struct l2cap_chan {
 	__u8		role_switch;
 	__u8		force_reliable;
 	__u8		flushable;
+	__u8		force_active;
 
 	__u8		ident;
 
diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index 3163330..5195715 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -497,7 +497,7 @@ struct hci_conn *hci_connect(struct hci_dev *hdev, int type, bdaddr_t *dst, __u8
 	if (acl->state == BT_CONNECTED &&
 			(sco->state == BT_OPEN || sco->state == BT_CLOSED)) {
 		acl->power_save = 1;
-		hci_conn_enter_active_mode(acl);
+		hci_conn_enter_active_mode(acl, BT_POWER_FORCE_ACTIVE_ON);
 
 		if (test_bit(HCI_CONN_MODE_CHANGE_PEND, &acl->pend)) {
 			/* defer SCO setup until mode change completed */
@@ -676,7 +676,7 @@ int hci_conn_switch_role(struct hci_conn *conn, __u8 role)
 EXPORT_SYMBOL(hci_conn_switch_role);
 
 /* Enter active mode */
-void hci_conn_enter_active_mode(struct hci_conn *conn)
+void hci_conn_enter_active_mode(struct hci_conn *conn, __u8 force_active)
 {
 	struct hci_dev *hdev = conn->hdev;
 
@@ -685,7 +685,10 @@ void hci_conn_enter_active_mode(struct hci_conn *conn)
 	if (test_bit(HCI_RAW, &hdev->flags))
 		return;
 
-	if (conn->mode != HCI_CM_SNIFF || !conn->power_save)
+	if (conn->mode != HCI_CM_SNIFF)
+		goto timer;
+
+	if (!conn->power_save && !force_active)
 		goto timer;
 
 	if (!test_and_set_bit(HCI_CONN_MODE_CHANGE_PEND, &conn->pend)) {
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index b6bda3f..be68e7d 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -1893,7 +1893,7 @@ static inline void hci_sched_acl(struct hci_dev *hdev)
 		while (quote-- && (skb = skb_dequeue(&conn->data_q))) {
 			BT_DBG("skb %p len %d", skb, skb->len);
 
-			hci_conn_enter_active_mode(conn);
+			hci_conn_enter_active_mode(conn, bt_cb(skb)->force_active);
 
 			hci_send_frame(skb);
 			hdev->acl_last_tx = jiffies;
@@ -2032,7 +2032,7 @@ static inline void hci_acldata_packet(struct hci_dev *hdev, struct sk_buff *skb)
 	if (conn) {
 		register struct hci_proto *hp;
 
-		hci_conn_enter_active_mode(conn);
+		hci_conn_enter_active_mode(conn, bt_cb(skb)->force_active);
 
 		/* Send to upper protocol */
 		hp = hci_proto[HCI_PROTO_L2CAP];
diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 7c0e571..2a80a91 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -408,6 +408,8 @@ void l2cap_send_cmd(struct l2cap_conn *conn, u8 ident, u8 code, u16 len, void *d
 	else
 		flags = ACL_START;
 
+	bt_cb(skb)->force_active = BT_POWER_FORCE_ACTIVE_ON;
+
 	hci_send_acl(conn->hcon, skb, flags);
 }
 
@@ -461,6 +463,8 @@ static inline void l2cap_send_sframe(struct l2cap_chan *chan, u16 control)
 	else
 		flags = ACL_START;
 
+	bt_cb(skb)->force_active = chan->force_active;
+
 	hci_send_acl(chan->conn->hcon, skb, flags);
 }
 
@@ -1089,6 +1093,7 @@ void l2cap_do_send(struct l2cap_chan *chan, struct sk_buff *skb)
 	else
 		flags = ACL_START;
 
+	bt_cb(skb)->force_active = chan->force_active;
 	hci_send_acl(hcon, skb, flags);
 }
 
diff --git a/net/bluetooth/l2cap_sock.c b/net/bluetooth/l2cap_sock.c
index c98360d..9f99e1d 100644
--- a/net/bluetooth/l2cap_sock.c
+++ b/net/bluetooth/l2cap_sock.c
@@ -436,6 +436,7 @@ static int l2cap_sock_getsockopt(struct socket *sock, int level, int optname, ch
 	struct sock *sk = sock->sk;
 	struct l2cap_chan *chan = l2cap_pi(sk)->chan;
 	struct bt_security sec;
+	struct bt_power pwr;
 	int len, err = 0;
 
 	BT_DBG("sk %p", sk);
@@ -484,6 +485,21 @@ static int l2cap_sock_getsockopt(struct socket *sock, int level, int optname, ch
 
 		break;
 
+	case BT_POWER:
+		if (sk->sk_type != SOCK_SEQPACKET && sk->sk_type != SOCK_STREAM
+				&& sk->sk_type != SOCK_RAW) {
+			err = -EINVAL;
+			break;
+		}
+
+		pwr.force_active = chan->force_active;
+
+		len = min_t(unsigned int, len, sizeof(pwr));
+		if (copy_to_user(optval, (char *) &pwr, len))
+			err = -EFAULT;
+
+		break;
+
 	default:
 		err = -ENOPROTOOPT;
 		break;
@@ -584,6 +600,7 @@ static int l2cap_sock_setsockopt(struct socket *sock, int level, int optname, ch
 	struct sock *sk = sock->sk;
 	struct l2cap_chan *chan = l2cap_pi(sk)->chan;
 	struct bt_security sec;
+	struct bt_power pwr;
 	int len, err = 0;
 	u32 opt;
 
@@ -660,6 +677,23 @@ static int l2cap_sock_setsockopt(struct socket *sock, int level, int optname, ch
 		chan->flushable = opt;
 		break;
 
+	case BT_POWER:
+		if (sk->sk_type != SOCK_SEQPACKET && sk->sk_type != SOCK_STREAM
+				&& sk->sk_type != SOCK_RAW) {
+			err = -EINVAL;
+			break;
+		}
+
+		pwr.force_active = BT_POWER_FORCE_ACTIVE_ON;
+
+		len = min_t(unsigned int, sizeof(pwr), optlen);
+		if (copy_from_user((char *) &pwr, optval, len)) {
+			err = -EFAULT;
+			break;
+		}
+		chan->force_active = pwr.force_active;
+		break;
+
 	default:
 		err = -ENOPROTOOPT;
 		break;
@@ -975,6 +1009,7 @@ void l2cap_sock_init(struct sock *sk, struct sock *parent)
 		chan->role_switch = pchan->role_switch;
 		chan->force_reliable = pchan->force_reliable;
 		chan->flushable = pchan->flushable;
+		chan->force_active = pchan->force_active;
 	} else {
 		chan->imtu = L2CAP_DEFAULT_MTU;
 		chan->omtu = 0;
@@ -991,6 +1026,7 @@ void l2cap_sock_init(struct sock *sk, struct sock *parent)
 		chan->role_switch = 0;
 		chan->force_reliable = 0;
 		chan->flushable = BT_FLUSHABLE_OFF;
+		chan->force_active = BT_POWER_FORCE_ACTIVE_ON;
 	}
 
 	/* Default config options */
-- 
1.7.3.1

