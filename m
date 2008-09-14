Return-Path: <cyrus@holtmann.org>
Message-ID: <48CD6F5A.1060900@free.fr>
Date: Sun, 14 Sep 2008 22:08:58 +0200
From: Fabien Chevalier <fabchevalier@free.fr>
MIME-Version: 1.0
To: linux-bluetooth@vger.kernel.org
Subject: Sniff mode patch V2
Content-Type: multipart/mixed;
 boundary="------------060301000401080209050909"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This is a multi-part message in MIME format.
--------------060301000401080209050909
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Marcel,

I spend most of the day reworking the sniff mode patch.
I implemented both L2CAP and RFCOMM, and tested those two. They both
seem to work.
The layering violation is gone.
The setting is propagated from a server socket to its children.

I think i've seen the end of your first round of comments ;-)

Could you please review this patch and tell me what needs fixing ?

Regards,

Fabien



--------------060301000401080209050909
Content-Type: text/x-patch;
 name="0001-Sniff-mode-fixes-V2.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="0001-Sniff-mode-fixes-V2.patch"

>>From 1252afa5d458cd4782ee767ff1e487a6ce56c964 Mon Sep 17 00:00:00 2001
From: Fabien Chevalier <fabchevalier@free.fr>
Date: Sun, 14 Sep 2008 20:52:08 +0200
Subject: [PATCH] Sniff mode fixes V2.

* Introduces L2CAP_FORCE_ACTIVE_MODE and RFCOMM_FORCE_ACTIVE_MODE.
* Support for RFCOMM and L2CAP.
* Setting is now inherited on child sockets created through accept()
---
 include/net/bluetooth/hci_core.h |    3 ++-
 include/net/bluetooth/l2cap.h    |    5 +++++
 include/net/bluetooth/rfcomm.h   |    3 +++
 net/bluetooth/hci_conn.c         |    6 +++++-
 net/bluetooth/hci_core.c         |    4 +++-
 net/bluetooth/l2cap.c            |   38 ++++++++++++++++++++++++++++++++------
 net/bluetooth/rfcomm/core.c      |   13 +++++++++----
 net/bluetooth/rfcomm/sock.c      |   32 ++++++++++++++++++++++++++++++--
 8 files changed, 89 insertions(+), 15 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 46a43b7..95f113e 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -170,6 +170,7 @@ struct hci_conn {
 	__u32		 link_mode;
 	__u8             auth_type;
 	__u8             power_save;
+	__u8             force_active_mode;
 	unsigned long	 pend;
 
 	unsigned int	 sent;
@@ -631,7 +632,7 @@ int hci_register_notifier(struct notifier_block *nb);
 int hci_unregister_notifier(struct notifier_block *nb);
 
 int hci_send_cmd(struct hci_dev *hdev, __u16 opcode, __u32 plen, void *param);
-int hci_send_acl(struct hci_conn *conn, struct sk_buff *skb, __u16 flags);
+int hci_send_acl(struct hci_conn *conn, struct sk_buff *skb, int force_active_mode, __u16 flags);
 int hci_send_sco(struct hci_conn *conn, struct sk_buff *skb);
 
 void *hci_sent_cmd_data(struct hci_dev *hdev, __u16 opcode);
diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
index 73e115b..d13f586 100644
--- a/include/net/bluetooth/l2cap.h
+++ b/include/net/bluetooth/l2cap.h
@@ -62,6 +62,8 @@ struct l2cap_conninfo {
 #define L2CAP_LM_RELIABLE	0x0010
 #define L2CAP_LM_SECURE		0x0020
 
+#define L2CAP_FORCE_ACTIVE_MODE	0x04
+
 /* L2CAP command codes */
 #define L2CAP_COMMAND_REJ 0x01
 #define L2CAP_CONN_REQ    0x02
@@ -210,6 +212,8 @@ struct l2cap_conn {
 	__u8		info_state;
 	__u8		info_ident;
 
+	int		force_active_mode;
+
 	struct timer_list info_timer;
 
 	spinlock_t	lock;
@@ -239,6 +243,7 @@ struct l2cap_pinfo {
 	__u16		flush_to;
 
 	__u32		link_mode;
+	int		force_active_mode;
 
 	__u8		conf_req[64];
 	__u8		conf_len;
diff --git a/include/net/bluetooth/rfcomm.h b/include/net/bluetooth/rfcomm.h
index 4dc8d92..61bf1cf 100644
--- a/include/net/bluetooth/rfcomm.h
+++ b/include/net/bluetooth/rfcomm.h
@@ -185,6 +185,7 @@ struct rfcomm_dlc {
 	u8            out;
 
 	u32           link_mode;
+	int           force_active_mode;
 
 	uint          mtu;
 	uint          cfc;
@@ -298,6 +299,8 @@ struct rfcomm_conninfo {
 #define RFCOMM_LM_RELIABLE	0x0010
 #define RFCOMM_LM_SECURE	0x0020
 
+#define RFCOMM_FORCE_ACTIVE_MODE	0x04
+
 #define rfcomm_pi(sk) ((struct rfcomm_pinfo *) sk)
 
 struct rfcomm_pinfo {
diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index b700242..a7feebd 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -214,6 +214,7 @@ struct hci_conn *hci_conn_add(struct hci_dev *hdev, int type, bdaddr_t *dst)
 	conn->state = BT_OPEN;
 
 	conn->power_save = 1;
+	conn->force_active_mode = 0;
 
 	switch (type) {
 	case ACL_LINK:
@@ -479,9 +480,12 @@ void hci_conn_enter_active_mode(struct hci_conn *conn)
 	if (test_bit(HCI_RAW, &hdev->flags))
 		return;
 
-	if (conn->mode != HCI_CM_SNIFF || !conn->power_save)
+	if (conn->mode != HCI_CM_SNIFF)
 		goto timer;
 
+	if (!conn->power_save && !conn->force_active_mode)
+ 		goto timer;
+ 		
 	if (!test_and_set_bit(HCI_CONN_MODE_CHANGE_PEND, &conn->pend)) {
 		struct hci_cp_exit_sniff_mode cp;
 		cp.handle = cpu_to_le16(conn->handle);
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index f5b21cb..ec4b1ff 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -1193,7 +1193,7 @@ static void hci_add_acl_hdr(struct sk_buff *skb, __u16 handle, __u16 flags)
 	hdr->dlen   = cpu_to_le16(len);
 }
 
-int hci_send_acl(struct hci_conn *conn, struct sk_buff *skb, __u16 flags)
+int hci_send_acl(struct hci_conn *conn, struct sk_buff *skb, int force_active_mode, __u16 flags)
 {
 	struct hci_dev *hdev = conn->hdev;
 	struct sk_buff *list;
@@ -1234,6 +1234,8 @@ int hci_send_acl(struct hci_conn *conn, struct sk_buff *skb, __u16 flags)
 		spin_unlock_bh(&conn->data_q.lock);
 	}
 
+	conn->force_active_mode = force_active_mode;
+
 	hci_sched_tx(hdev);
 	return 0;
 }
diff --git a/net/bluetooth/l2cap.c b/net/bluetooth/l2cap.c
index 9610a9c..7d422e9 100644
--- a/net/bluetooth/l2cap.c
+++ b/net/bluetooth/l2cap.c
@@ -304,12 +304,12 @@ static inline int l2cap_send_cmd(struct l2cap_conn *conn, u8 ident, u8 code, u16
 {
 	struct sk_buff *skb = l2cap_build_cmd(conn, code, ident, len, data);
 
-	BT_DBG("code 0x%2.2x", code);
+	BT_DBG("code 0x%2.2x active_mode %d ", code, conn->force_active_mode);
 
 	if (!skb)
 		return -ENOMEM;
 
-	return hci_send_acl(conn->hcon, skb, 0);
+	return hci_send_acl(conn->hcon, skb, conn->force_active_mode, 0);
 }
 
 static void l2cap_do_start(struct sock *sk)
@@ -661,10 +661,13 @@ static void l2cap_sock_init(struct sock *sk, struct sock *parent)
 		pi->imtu = l2cap_pi(parent)->imtu;
 		pi->omtu = l2cap_pi(parent)->omtu;
 		pi->link_mode = l2cap_pi(parent)->link_mode;
+		pi->force_active_mode = 
+			l2cap_pi(parent)->force_active_mode;
 	} else {
 		pi->imtu = L2CAP_DEFAULT_MTU;
 		pi->omtu = 0;
 		pi->link_mode = 0;
+		pi->force_active_mode = 0;
 	}
 
 	/* Default config options */
@@ -818,6 +821,8 @@ static int l2cap_do_connect(struct sock *sk)
 
 	/* Update source addr of the socket */
 	bacpy(src, conn->src);
+	
+	conn->force_active_mode = l2cap_pi(sk)->force_active_mode;
 
 	l2cap_chan_add(conn, sk, NULL);
 
@@ -1021,7 +1026,7 @@ static inline int l2cap_do_send(struct sock *sk, struct msghdr *msg, int len)
 	int err, hlen, count, sent=0;
 	struct l2cap_hdr *lh;
 
-	BT_DBG("sk %p len %d", sk, len);
+	BT_DBG("sk %p len %d active_mode %d", sk, len, conn->force_active_mode);
 
 	/* First fragment (with L2CAP header) */
 	if (sk->sk_type == SOCK_DGRAM)
@@ -1072,7 +1077,7 @@ static inline int l2cap_do_send(struct sock *sk, struct msghdr *msg, int len)
 		frag = &(*frag)->next;
 	}
 
-	if ((err = hci_send_acl(conn->hcon, skb, 0)) < 0)
+	if ((err = hci_send_acl(conn->hcon, skb, l2cap_pi(sk)->force_active_mode, 0)) < 0)
 		goto fail;
 
 	return sent;
@@ -1148,6 +1153,20 @@ static int l2cap_sock_setsockopt(struct socket *sock, int level, int optname, ch
 		l2cap_pi(sk)->link_mode = opt;
 		break;
 
+	case L2CAP_FORCE_ACTIVE_MODE:
+		if (get_user(opt, (u32 __user *) optval)) {
+			err = -EFAULT;
+			break;
+		}
+
+		l2cap_pi(sk)->force_active_mode = opt;
+
+		if (sk->sk_state == BT_CONNECTED) {
+			l2cap_pi(sk)->conn->force_active_mode = opt;
+		}
+
+		break;
+
 	default:
 		err = -ENOPROTOOPT;
 		break;
@@ -1204,6 +1223,12 @@ static int l2cap_sock_getsockopt(struct socket *sock, int level, int optname, ch
 
 		break;
 
+	case L2CAP_FORCE_ACTIVE_MODE:
+		if (put_user(l2cap_pi(sk)->force_active_mode,
+				 (u32 __user *) optval))
+			err = -EFAULT;
+		break;
+
 	default:
 		err = -ENOPROTOOPT;
 		break;
@@ -2429,10 +2454,11 @@ static ssize_t l2cap_sysfs_show(struct class *dev, char *buf)
 	sk_for_each(sk, node, &l2cap_sk_list.head) {
 		struct l2cap_pinfo *pi = l2cap_pi(sk);
 
-		str += sprintf(str, "%s %s %d %d 0x%4.4x 0x%4.4x %d %d 0x%x\n",
+		str += sprintf(str, "%s %s %d %d 0x%4.4x 0x%4.4x %d %d 0x%x %d\n",
 				batostr(&bt_sk(sk)->src), batostr(&bt_sk(sk)->dst),
 				sk->sk_state, btohs(pi->psm), pi->scid, pi->dcid,
-				pi->imtu, pi->omtu, pi->link_mode);
+				pi->imtu, pi->omtu, pi->link_mode,
+				pi->force_active_mode);
 	}
 
 	read_unlock_bh(&l2cap_sk_list.lock);
diff --git a/net/bluetooth/rfcomm/core.c b/net/bluetooth/rfcomm/core.c
index ba537fa..888b431 100644
--- a/net/bluetooth/rfcomm/core.c
+++ b/net/bluetooth/rfcomm/core.c
@@ -80,7 +80,7 @@ static void rfcomm_make_uih(struct sk_buff *skb, u8 addr);
 
 static void rfcomm_process_connect(struct rfcomm_session *s);
 
-static struct rfcomm_session *rfcomm_session_create(bdaddr_t *src, bdaddr_t *dst, int *err);
+static struct rfcomm_session *rfcomm_session_create(bdaddr_t *src, bdaddr_t *dst, int force_active_mode, int *err);
 static struct rfcomm_session *rfcomm_session_get(bdaddr_t *src, bdaddr_t *dst);
 static void rfcomm_session_del(struct rfcomm_session *s);
 
@@ -367,7 +367,7 @@ static int __rfcomm_dlc_open(struct rfcomm_dlc *d, bdaddr_t *src, bdaddr_t *dst,
 
 	s = rfcomm_session_get(src, dst);
 	if (!s) {
-		s = rfcomm_session_create(src, dst, &err);
+		s = rfcomm_session_create(src, dst, d->force_active_mode, &err);
 		if (!s)
 			return err;
 	}
@@ -625,19 +625,24 @@ static void rfcomm_session_close(struct rfcomm_session *s, int err)
 	rfcomm_session_put(s);
 }
 
-static struct rfcomm_session *rfcomm_session_create(bdaddr_t *src, bdaddr_t *dst, int *err)
+static struct rfcomm_session *rfcomm_session_create(bdaddr_t *src, bdaddr_t *dst, int force_active_mode, int *err)
 {
 	struct rfcomm_session *s = NULL;
 	struct sockaddr_l2 addr;
 	struct socket *sock;
 	struct sock *sk;
 
-	BT_DBG("%s %s", batostr(src), batostr(dst));
+	BT_DBG("%s %s %d", batostr(src), batostr(dst), force_active_mode);
 
 	*err = rfcomm_l2sock_create(&sock);
 	if (*err < 0)
 		return NULL;
 
+	*err = kernel_setsockopt(sock, SOL_BLUETOOTH, L2CAP_FORCE_ACTIVE_MODE,
+		(void *) &force_active_mode, sizeof(force_active_mode));
+	if (*err < 0)
+		goto failed;
+
 	bacpy(&addr.l2_bdaddr, src);
 	addr.l2_family = AF_BLUETOOTH;
 	addr.l2_psm    = 0;
diff --git a/net/bluetooth/rfcomm/sock.c b/net/bluetooth/rfcomm/sock.c
index 8a972b6..f6a48e5 100644
--- a/net/bluetooth/rfcomm/sock.c
+++ b/net/bluetooth/rfcomm/sock.c
@@ -267,8 +267,11 @@ static void rfcomm_sock_init(struct sock *sk, struct sock *parent)
 	if (parent) {
 		sk->sk_type = parent->sk_type;
 		pi->link_mode = rfcomm_pi(parent)->link_mode;
+		pi->dlc->force_active_mode = 
+			rfcomm_pi(parent)->dlc->force_active_mode;
 	} else {
 		pi->link_mode = 0;
+		pi->dlc->force_active_mode = 0;
 	}
 
 	pi->dlc->link_mode = pi->link_mode;
@@ -735,6 +738,15 @@ static int rfcomm_sock_setsockopt(struct socket *sock, int level, int optname, c
 		rfcomm_pi(sk)->link_mode = opt;
 		break;
 
+	case RFCOMM_FORCE_ACTIVE_MODE:
+		if (get_user(opt, (u32 __user *) optval)) {
+			err = -EFAULT;
+			break;
+		}
+
+		rfcomm_pi(sk)->dlc->force_active_mode = opt;
+		break;
+
 	default:
 		err = -ENOPROTOOPT;
 		break;
@@ -781,6 +793,12 @@ static int rfcomm_sock_getsockopt(struct socket *sock, int level, int optname, c
 
 		break;
 
+	case RFCOMM_FORCE_ACTIVE_MODE:
+		if (put_user(rfcomm_pi(sk)->dlc->force_active_mode,
+				 (u32 __user *) optval))
+			err = -EFAULT;
+		break;
+
 	default:
 		err = -ENOPROTOOPT;
 		break;
@@ -859,6 +877,8 @@ int rfcomm_connect_ind(struct rfcomm_session *s, u8 channel, struct rfcomm_dlc *
 	struct sock *sk, *parent;
 	bdaddr_t src, dst;
 	int result = 0;
+	int err;
+	int force_active_mode;
 
 	BT_DBG("session %p channel %d", s, channel);
 
@@ -869,6 +889,13 @@ int rfcomm_connect_ind(struct rfcomm_session *s, u8 channel, struct rfcomm_dlc *
 	if (!parent)
 		return 0;
 
+	/* Propagate setting to children */
+	force_active_mode = rfcomm_pi(parent)->dlc->force_active_mode;
+	err = kernel_setsockopt(s->sock, SOL_BLUETOOTH, L2CAP_FORCE_ACTIVE_MODE,
+		(void *) &force_active_mode, sizeof(force_active_mode));
+	if (err < 0)
+		goto done;
+
 	/* Check for backlog size */
 	if (sk_acceptq_is_full(parent)) {
 		BT_DBG("backlog full %d", parent->sk_ack_backlog);
@@ -905,9 +932,10 @@ static ssize_t rfcomm_sock_sysfs_show(struct class *dev, char *buf)
 	read_lock_bh(&rfcomm_sk_list.lock);
 
 	sk_for_each(sk, node, &rfcomm_sk_list.head) {
-		str += sprintf(str, "%s %s %d %d\n",
+		str += sprintf(str, "%s %s %d %d %d\n",
 				batostr(&bt_sk(sk)->src), batostr(&bt_sk(sk)->dst),
-				sk->sk_state, rfcomm_pi(sk)->channel);
+				sk->sk_state, rfcomm_pi(sk)->channel, 
+				rfcomm_pi(sk)->dlc->force_active_mode);
 	}
 
 	read_unlock_bh(&rfcomm_sk_list.lock);
-- 
1.5.6.5




--------------060301000401080209050909--
