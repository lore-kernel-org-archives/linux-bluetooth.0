Return-Path: <cyrus@holtmann.org>
From: "Gustavo F. Padovan" <padovan@profusion.mobi>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 4/8] Bluetooth: Move some more elements to struct l2cap_chan
Date: Fri, 15 Apr 2011 15:17:30 -0300
Message-Id: <1302891454-10165-5-git-send-email-padovan@profusion.mobi>
In-Reply-To: <1302891454-10165-4-git-send-email-padovan@profusion.mobi>
References: <1302891454-10165-1-git-send-email-padovan@profusion.mobi>
 <1302891454-10165-2-git-send-email-padovan@profusion.mobi>
 <1302891454-10165-3-git-send-email-padovan@profusion.mobi>
 <1302891454-10165-4-git-send-email-padovan@profusion.mobi>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

In this commit sec_level, force_reliable, role_switch and flushable.

Signed-off-by: Gustavo F. Padovan <padovan@profusion.mobi>
---
 include/net/bluetooth/l2cap.h |   12 ++++---
 net/bluetooth/l2cap_core.c    |   78 ++++++++++++++++++++++-------------------
 net/bluetooth/l2cap_sock.c    |   52 +++++++++++++++------------
 3 files changed, 77 insertions(+), 65 deletions(-)

diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
index f709350..684deee 100644
--- a/include/net/bluetooth/l2cap.h
+++ b/include/net/bluetooth/l2cap.h
@@ -284,6 +284,12 @@ struct srej_list {
 
 struct l2cap_chan {
 	struct sock *sk;
+
+	__u8		sec_level;
+	__u8		role_switch;
+	__u8		force_reliable;
+	__u8		flushable;
+
 	__u8		ident;
 
 	__u8		conf_req[64];
@@ -371,10 +377,6 @@ struct l2cap_pinfo {
 	__u8		mode;
 
 	__u8		fcs;
-	__u8		sec_level;
-	__u8		role_switch;
-	__u8		force_reliable;
-	__u8		flushable;
 
 	__u8		tx_win;
 	__u8		max_tx;
@@ -452,7 +454,7 @@ struct sk_buff *l2cap_create_connless_pdu(struct sock *sk, struct msghdr *msg, s
 struct sk_buff *l2cap_create_basic_pdu(struct sock *sk, struct msghdr *msg, size_t len);
 struct sk_buff *l2cap_create_iframe_pdu(struct sock *sk, struct msghdr *msg, size_t len, u16 control, u16 sdulen);
 int l2cap_sar_segment_sdu(struct l2cap_chan *chan, struct msghdr *msg, size_t len);
-void l2cap_do_send(struct sock *sk, struct sk_buff *skb);
+void l2cap_do_send(struct l2cap_chan *chan, struct sk_buff *skb);
 void l2cap_streaming_send(struct l2cap_chan *chan);
 int l2cap_ertm_send(struct l2cap_chan *chan);
 
diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 05848ee..eca9c9a 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -262,10 +262,12 @@ free:
 	kfree(chan);
 }
 
-static inline u8 l2cap_get_auth_type(struct sock *sk)
+static inline u8 l2cap_get_auth_type(struct l2cap_chan *chan)
 {
+	struct sock *sk = chan->sk;
+
 	if (sk->sk_type == SOCK_RAW) {
-		switch (l2cap_pi(sk)->sec_level) {
+		switch (chan->sec_level) {
 		case BT_SECURITY_HIGH:
 			return HCI_AT_DEDICATED_BONDING_MITM;
 		case BT_SECURITY_MEDIUM:
@@ -274,15 +276,15 @@ static inline u8 l2cap_get_auth_type(struct sock *sk)
 			return HCI_AT_NO_BONDING;
 		}
 	} else if (l2cap_pi(sk)->psm == cpu_to_le16(0x0001)) {
-		if (l2cap_pi(sk)->sec_level == BT_SECURITY_LOW)
-			l2cap_pi(sk)->sec_level = BT_SECURITY_SDP;
+		if (chan->sec_level == BT_SECURITY_LOW)
+			chan->sec_level = BT_SECURITY_SDP;
 
-		if (l2cap_pi(sk)->sec_level == BT_SECURITY_HIGH)
+		if (chan->sec_level == BT_SECURITY_HIGH)
 			return HCI_AT_NO_BONDING_MITM;
 		else
 			return HCI_AT_NO_BONDING;
 	} else {
-		switch (l2cap_pi(sk)->sec_level) {
+		switch (chan->sec_level) {
 		case BT_SECURITY_HIGH:
 			return HCI_AT_GENERAL_BONDING_MITM;
 		case BT_SECURITY_MEDIUM:
@@ -294,15 +296,14 @@ static inline u8 l2cap_get_auth_type(struct sock *sk)
 }
 
 /* Service level security */
-static inline int l2cap_check_security(struct sock *sk)
+static inline int l2cap_check_security(struct l2cap_chan *chan)
 {
-	struct l2cap_conn *conn = l2cap_pi(sk)->conn;
+	struct l2cap_conn *conn = l2cap_pi(chan->sk)->conn;
 	__u8 auth_type;
 
-	auth_type = l2cap_get_auth_type(sk);
+	auth_type = l2cap_get_auth_type(chan);
 
-	return hci_conn_security(conn->hcon, l2cap_pi(sk)->sec_level,
-								auth_type);
+	return hci_conn_security(conn->hcon, chan->sec_level, auth_type);
 }
 
 u8 l2cap_get_ident(struct l2cap_conn *conn)
@@ -425,7 +426,8 @@ static void l2cap_do_start(struct l2cap_chan *chan)
 		if (!(conn->info_state & L2CAP_INFO_FEAT_MASK_REQ_DONE))
 			return;
 
-		if (l2cap_check_security(sk) && __l2cap_no_conn_pending(chan)) {
+		if (l2cap_check_security(chan) &&
+				__l2cap_no_conn_pending(chan)) {
 			struct l2cap_conn_req req;
 			req.scid = cpu_to_le16(l2cap_pi(sk)->scid);
 			req.psm  = l2cap_pi(sk)->psm;
@@ -515,7 +517,7 @@ static void l2cap_conn_start(struct l2cap_conn *conn)
 		if (sk->sk_state == BT_CONNECT) {
 			struct l2cap_conn_req req;
 
-			if (!l2cap_check_security(sk) ||
+			if (!l2cap_check_security(chan) ||
 					!__l2cap_no_conn_pending(chan)) {
 				bh_unlock_sock(sk);
 				continue;
@@ -549,7 +551,7 @@ static void l2cap_conn_start(struct l2cap_conn *conn)
 			rsp.scid = cpu_to_le16(l2cap_pi(sk)->dcid);
 			rsp.dcid = cpu_to_le16(l2cap_pi(sk)->scid);
 
-			if (l2cap_check_security(sk)) {
+			if (l2cap_check_security(chan)) {
 				if (bt_sk(sk)->defer_setup) {
 					struct sock *parent = bt_sk(sk)->parent;
 					rsp.result = cpu_to_le16(L2CAP_CR_PEND);
@@ -722,7 +724,7 @@ static void l2cap_conn_unreliable(struct l2cap_conn *conn, int err)
 	list_for_each_entry(chan, &conn->chan_l, list) {
 		struct sock *sk = chan->sk;
 
-		if (l2cap_pi(sk)->force_reliable)
+		if (chan->force_reliable)
 			sk->sk_err = err;
 	}
 
@@ -867,14 +869,14 @@ int l2cap_chan_connect(struct l2cap_chan *chan)
 
 	hci_dev_lock_bh(hdev);
 
-	auth_type = l2cap_get_auth_type(sk);
+	auth_type = l2cap_get_auth_type(chan);
 
 	if (l2cap_pi(sk)->dcid == L2CAP_CID_LE_DATA)
 		hcon = hci_connect(hdev, LE_LINK, dst,
-					l2cap_pi(sk)->sec_level, auth_type);
+					chan->sec_level, auth_type);
 	else
 		hcon = hci_connect(hdev, ACL_LINK, dst,
-					l2cap_pi(sk)->sec_level, auth_type);
+					chan->sec_level, auth_type);
 
 	if (IS_ERR(hcon)) {
 		err = PTR_ERR(hcon);
@@ -900,7 +902,7 @@ int l2cap_chan_connect(struct l2cap_chan *chan)
 		if (sk->sk_type != SOCK_SEQPACKET &&
 				sk->sk_type != SOCK_STREAM) {
 			l2cap_sock_clear_timer(sk);
-			if (l2cap_check_security(sk))
+			if (l2cap_check_security(chan))
 				sk->sk_state = BT_CONNECTED;
 		} else
 			l2cap_do_start(chan);
@@ -1002,15 +1004,15 @@ static void l2cap_drop_acked_frames(struct l2cap_chan *chan)
 		del_timer(&chan->retrans_timer);
 }
 
-void l2cap_do_send(struct sock *sk, struct sk_buff *skb)
+void l2cap_do_send(struct l2cap_chan *chan, struct sk_buff *skb)
 {
-	struct l2cap_pinfo *pi = l2cap_pi(sk);
-	struct hci_conn *hcon = pi->conn->hcon;
+	struct sock *sk = chan->sk;
+	struct hci_conn *hcon = l2cap_pi(sk)->conn->hcon;
 	u16 flags;
 
-	BT_DBG("sk %p, skb %p len %d", sk, skb, skb->len);
+	BT_DBG("chan %p, skb %p len %d", chan, skb, skb->len);
 
-	if (!pi->flushable && lmp_no_flush_capable(hcon->hdev))
+	if (!chan->flushable && lmp_no_flush_capable(hcon->hdev))
 		flags = ACL_START_NO_FLUSH;
 	else
 		flags = ACL_START;
@@ -1035,7 +1037,7 @@ void l2cap_streaming_send(struct l2cap_chan *chan)
 			put_unaligned_le16(fcs, skb->data + skb->len - 2);
 		}
 
-		l2cap_do_send(sk, skb);
+		l2cap_do_send(chan, skb);
 
 		chan->next_tx_seq = (chan->next_tx_seq + 1) % 64;
 	}
@@ -1086,7 +1088,7 @@ static void l2cap_retransmit_one_frame(struct l2cap_chan *chan, u8 tx_seq)
 		put_unaligned_le16(fcs, tx_skb->data + tx_skb->len - 2);
 	}
 
-	l2cap_do_send(sk, tx_skb);
+	l2cap_do_send(chan, tx_skb);
 }
 
 int l2cap_ertm_send(struct l2cap_chan *chan)
@@ -1129,7 +1131,7 @@ int l2cap_ertm_send(struct l2cap_chan *chan)
 			put_unaligned_le16(fcs, skb->data + tx_skb->len - 2);
 		}
 
-		l2cap_do_send(sk, tx_skb);
+		l2cap_do_send(chan, tx_skb);
 
 		__mod_retrans_timer();
 
@@ -2099,7 +2101,7 @@ static inline int l2cap_connect_req(struct l2cap_conn *conn, struct l2cap_cmd_hd
 	chan->ident = cmd->ident;
 
 	if (conn->info_state & L2CAP_INFO_FEAT_MASK_REQ_DONE) {
-		if (l2cap_check_security(sk)) {
+		if (l2cap_check_security(chan)) {
 			if (bt_sk(sk)->defer_setup) {
 				sk->sk_state = BT_CONNECT2;
 				result = L2CAP_CR_PEND;
@@ -3804,17 +3806,19 @@ static int l2cap_connect_ind(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 type)
 	/* Find listening sockets and check their link_mode */
 	read_lock(&l2cap_sk_list.lock);
 	sk_for_each(sk, node, &l2cap_sk_list.head) {
+		struct l2cap_chan *chan = l2cap_pi(sk)->chan;
+
 		if (sk->sk_state != BT_LISTEN)
 			continue;
 
 		if (!bacmp(&bt_sk(sk)->src, &hdev->bdaddr)) {
 			lm1 |= HCI_LM_ACCEPT;
-			if (l2cap_pi(sk)->role_switch)
+			if (chan->role_switch)
 				lm1 |= HCI_LM_MASTER;
 			exact++;
 		} else if (!bacmp(&bt_sk(sk)->src, BDADDR_ANY)) {
 			lm2 |= HCI_LM_ACCEPT;
-			if (l2cap_pi(sk)->role_switch)
+			if (chan->role_switch)
 				lm2 |= HCI_LM_MASTER;
 		}
 	}
@@ -3866,19 +3870,21 @@ static int l2cap_disconn_cfm(struct hci_conn *hcon, u8 reason)
 	return 0;
 }
 
-static inline void l2cap_check_encryption(struct sock *sk, u8 encrypt)
+static inline void l2cap_check_encryption(struct l2cap_chan *chan, u8 encrypt)
 {
+	struct sock *sk = chan->sk;
+
 	if (sk->sk_type != SOCK_SEQPACKET && sk->sk_type != SOCK_STREAM)
 		return;
 
 	if (encrypt == 0x00) {
-		if (l2cap_pi(sk)->sec_level == BT_SECURITY_MEDIUM) {
+		if (chan->sec_level == BT_SECURITY_MEDIUM) {
 			l2cap_sock_clear_timer(sk);
 			l2cap_sock_set_timer(sk, HZ * 5);
-		} else if (l2cap_pi(sk)->sec_level == BT_SECURITY_HIGH)
+		} else if (chan->sec_level == BT_SECURITY_HIGH)
 			__l2cap_sock_close(sk, ECONNREFUSED);
 	} else {
-		if (l2cap_pi(sk)->sec_level == BT_SECURITY_MEDIUM)
+		if (chan->sec_level == BT_SECURITY_MEDIUM)
 			l2cap_sock_clear_timer(sk);
 	}
 }
@@ -3907,7 +3913,7 @@ static int l2cap_security_cfm(struct hci_conn *hcon, u8 status, u8 encrypt)
 
 		if (!status && (sk->sk_state == BT_CONNECTED ||
 						sk->sk_state == BT_CONFIG)) {
-			l2cap_check_encryption(sk, encrypt);
+			l2cap_check_encryption(chan, encrypt);
 			bh_unlock_sock(sk);
 			continue;
 		}
@@ -4082,7 +4088,7 @@ static int l2cap_debugfs_show(struct seq_file *f, void *p)
 					batostr(&bt_sk(sk)->dst),
 					sk->sk_state, __le16_to_cpu(pi->psm),
 					pi->scid, pi->dcid,
-					pi->imtu, pi->omtu, pi->sec_level,
+					pi->imtu, pi->omtu, pi->chan->sec_level,
 					pi->mode);
 	}
 
diff --git a/net/bluetooth/l2cap_sock.c b/net/bluetooth/l2cap_sock.c
index 50437c6..6129556 100644
--- a/net/bluetooth/l2cap_sock.c
+++ b/net/bluetooth/l2cap_sock.c
@@ -51,7 +51,7 @@ static void l2cap_sock_timeout(unsigned long arg)
 	if (sk->sk_state == BT_CONNECTED || sk->sk_state == BT_CONFIG)
 		reason = ECONNREFUSED;
 	else if (sk->sk_state == BT_CONNECT &&
-				l2cap_pi(sk)->sec_level != BT_SECURITY_SDP)
+			l2cap_pi(sk)->chan->sec_level != BT_SECURITY_SDP)
 		reason = ECONNREFUSED;
 	else
 		reason = ETIMEDOUT;
@@ -91,6 +91,7 @@ found:
 static int l2cap_sock_bind(struct socket *sock, struct sockaddr *addr, int alen)
 {
 	struct sock *sk = sock->sk;
+	struct l2cap_chan *chan = l2cap_pi(sk)->chan;
 	struct sockaddr_l2 la;
 	int len, err = 0;
 
@@ -142,7 +143,7 @@ static int l2cap_sock_bind(struct socket *sock, struct sockaddr *addr, int alen)
 
 		if (__le16_to_cpu(la.l2_psm) == 0x0001 ||
 					__le16_to_cpu(la.l2_psm) == 0x0003)
-			l2cap_pi(sk)->sec_level = BT_SECURITY_SDP;
+			chan->sec_level = BT_SECURITY_SDP;
 	}
 
 	if (la.l2_cid)
@@ -382,6 +383,7 @@ static int l2cap_sock_getname(struct socket *sock, struct sockaddr *addr, int *l
 static int l2cap_sock_getsockopt_old(struct socket *sock, int optname, char __user *optval, int __user *optlen)
 {
 	struct sock *sk = sock->sk;
+	struct l2cap_chan *chan = l2cap_pi(sk)->chan;
 	struct l2cap_options opts;
 	struct l2cap_conninfo cinfo;
 	int len, err = 0;
@@ -412,7 +414,7 @@ static int l2cap_sock_getsockopt_old(struct socket *sock, int optname, char __us
 		break;
 
 	case L2CAP_LM:
-		switch (l2cap_pi(sk)->sec_level) {
+		switch (chan->sec_level) {
 		case BT_SECURITY_LOW:
 			opt = L2CAP_LM_AUTH;
 			break;
@@ -428,10 +430,10 @@ static int l2cap_sock_getsockopt_old(struct socket *sock, int optname, char __us
 			break;
 		}
 
-		if (l2cap_pi(sk)->role_switch)
+		if (chan->role_switch)
 			opt |= L2CAP_LM_MASTER;
 
-		if (l2cap_pi(sk)->force_reliable)
+		if (chan->force_reliable)
 			opt |= L2CAP_LM_RELIABLE;
 
 		if (put_user(opt, (u32 __user *) optval))
@@ -467,6 +469,7 @@ static int l2cap_sock_getsockopt_old(struct socket *sock, int optname, char __us
 static int l2cap_sock_getsockopt(struct socket *sock, int level, int optname, char __user *optval, int __user *optlen)
 {
 	struct sock *sk = sock->sk;
+	struct l2cap_chan *chan = l2cap_pi(sk)->chan;
 	struct bt_security sec;
 	int len, err = 0;
 
@@ -491,7 +494,7 @@ static int l2cap_sock_getsockopt(struct socket *sock, int level, int optname, ch
 			break;
 		}
 
-		sec.level = l2cap_pi(sk)->sec_level;
+		sec.level = chan->sec_level;
 
 		len = min_t(unsigned int, len, sizeof(sec));
 		if (copy_to_user(optval, (char *) &sec, len))
@@ -511,7 +514,7 @@ static int l2cap_sock_getsockopt(struct socket *sock, int level, int optname, ch
 		break;
 
 	case BT_FLUSHABLE:
-		if (put_user(l2cap_pi(sk)->flushable, (u32 __user *) optval))
+		if (put_user(chan->flushable, (u32 __user *) optval))
 			err = -EFAULT;
 
 		break;
@@ -592,14 +595,14 @@ static int l2cap_sock_setsockopt_old(struct socket *sock, int optname, char __us
 		}
 
 		if (opt & L2CAP_LM_AUTH)
-			l2cap_pi(sk)->sec_level = BT_SECURITY_LOW;
+			chan->sec_level = BT_SECURITY_LOW;
 		if (opt & L2CAP_LM_ENCRYPT)
-			l2cap_pi(sk)->sec_level = BT_SECURITY_MEDIUM;
+			chan->sec_level = BT_SECURITY_MEDIUM;
 		if (opt & L2CAP_LM_SECURE)
-			l2cap_pi(sk)->sec_level = BT_SECURITY_HIGH;
+			chan->sec_level = BT_SECURITY_HIGH;
 
-		l2cap_pi(sk)->role_switch    = (opt & L2CAP_LM_MASTER);
-		l2cap_pi(sk)->force_reliable = (opt & L2CAP_LM_RELIABLE);
+		chan->role_switch    = (opt & L2CAP_LM_MASTER);
+		chan->force_reliable = (opt & L2CAP_LM_RELIABLE);
 		break;
 
 	default:
@@ -614,6 +617,7 @@ static int l2cap_sock_setsockopt_old(struct socket *sock, int optname, char __us
 static int l2cap_sock_setsockopt(struct socket *sock, int level, int optname, char __user *optval, unsigned int optlen)
 {
 	struct sock *sk = sock->sk;
+	struct l2cap_chan *chan = l2cap_pi(sk)->chan;
 	struct bt_security sec;
 	int len, err = 0;
 	u32 opt;
@@ -650,7 +654,7 @@ static int l2cap_sock_setsockopt(struct socket *sock, int level, int optname, ch
 			break;
 		}
 
-		l2cap_pi(sk)->sec_level = sec.level;
+		chan->sec_level = sec.level;
 		break;
 
 	case BT_DEFER_SETUP:
@@ -688,7 +692,7 @@ static int l2cap_sock_setsockopt(struct socket *sock, int level, int optname, ch
 			}
 		}
 
-		l2cap_pi(sk)->flushable = opt;
+		chan->flushable = opt;
 		break;
 
 	default:
@@ -730,7 +734,7 @@ static int l2cap_sock_sendmsg(struct kiocb *iocb, struct socket *sock, struct ms
 		if (IS_ERR(skb)) {
 			err = PTR_ERR(skb);
 		} else {
-			l2cap_do_send(sk, skb);
+			l2cap_do_send(pi->chan, skb);
 			err = len;
 		}
 		goto done;
@@ -751,7 +755,7 @@ static int l2cap_sock_sendmsg(struct kiocb *iocb, struct socket *sock, struct ms
 			goto done;
 		}
 
-		l2cap_do_send(sk, skb);
+		l2cap_do_send(pi->chan, skb);
 		err = len;
 		break;
 
@@ -997,10 +1001,10 @@ void l2cap_sock_init(struct sock *sk, struct sock *parent)
 		pi->fcs  = l2cap_pi(parent)->fcs;
 		pi->max_tx = l2cap_pi(parent)->max_tx;
 		pi->tx_win = l2cap_pi(parent)->tx_win;
-		pi->sec_level = l2cap_pi(parent)->sec_level;
-		pi->role_switch = l2cap_pi(parent)->role_switch;
-		pi->force_reliable = l2cap_pi(parent)->force_reliable;
-		pi->flushable = l2cap_pi(parent)->flushable;
+		chan->sec_level = pchan->sec_level;
+		chan->role_switch = pchan->role_switch;
+		chan->force_reliable = pchan->force_reliable;
+		chan->flushable = pchan->flushable;
 	} else {
 		pi->imtu = L2CAP_DEFAULT_MTU;
 		pi->omtu = 0;
@@ -1013,10 +1017,10 @@ void l2cap_sock_init(struct sock *sk, struct sock *parent)
 		pi->max_tx = L2CAP_DEFAULT_MAX_TX;
 		pi->fcs  = L2CAP_FCS_CRC16;
 		pi->tx_win = L2CAP_DEFAULT_TX_WINDOW;
-		pi->sec_level = BT_SECURITY_LOW;
-		pi->role_switch = 0;
-		pi->force_reliable = 0;
-		pi->flushable = BT_FLUSHABLE_OFF;
+		chan->sec_level = BT_SECURITY_LOW;
+		chan->role_switch = 0;
+		chan->force_reliable = 0;
+		chan->flushable = BT_FLUSHABLE_OFF;
 	}
 
 	/* Default config options */
-- 
1.7.5.rc1

