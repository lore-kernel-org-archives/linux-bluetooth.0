Return-Path: <cyrus@holtmann.org>
From: "Gustavo F. Padovan" <padovan@profusion.mobi>
To: linux-bluetooth@vger.kernel.org
Subject: [bluetooth-next 13/16] Bluetooth: move l2cap_sock_sendmsg() to l2cap_sock.c
Date: Fri,  4 Feb 2011 04:01:55 -0200
Message-Id: <1296799318-5517-14-git-send-email-padovan@profusion.mobi>
In-Reply-To: <1296799318-5517-13-git-send-email-padovan@profusion.mobi>
References: <1296799318-5517-1-git-send-email-padovan@profusion.mobi>
 <1296799318-5517-2-git-send-email-padovan@profusion.mobi>
 <1296799318-5517-3-git-send-email-padovan@profusion.mobi>
 <1296799318-5517-4-git-send-email-padovan@profusion.mobi>
 <1296799318-5517-5-git-send-email-padovan@profusion.mobi>
 <1296799318-5517-6-git-send-email-padovan@profusion.mobi>
 <1296799318-5517-7-git-send-email-padovan@profusion.mobi>
 <1296799318-5517-8-git-send-email-padovan@profusion.mobi>
 <1296799318-5517-9-git-send-email-padovan@profusion.mobi>
 <1296799318-5517-10-git-send-email-padovan@profusion.mobi>
 <1296799318-5517-11-git-send-email-padovan@profusion.mobi>
 <1296799318-5517-12-git-send-email-padovan@profusion.mobi>
 <1296799318-5517-13-git-send-email-padovan@profusion.mobi>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Also moves some L2CAP sending functions declaration to l2cap.h

Signed-off-by: Gustavo F. Padovan <padovan@profusion.mobi>
---
 include/net/bluetooth/l2cap.h |   11 +++-
 net/bluetooth/l2cap_core.c    |  116 +++--------------------------------------
 net/bluetooth/l2cap_sock.c    |  102 ++++++++++++++++++++++++++++++++++++
 3 files changed, 117 insertions(+), 112 deletions(-)

diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
index c9df0ef..d4c93ed 100644
--- a/include/net/bluetooth/l2cap.h
+++ b/include/net/bluetooth/l2cap.h
@@ -436,6 +436,14 @@ void l2cap_send_cmd(struct l2cap_conn *conn, u8 ident, u8 code, u16 len, void *d
 int l2cap_build_conf_req(struct sock *sk, void *data);
 int __l2cap_wait_ack(struct sock *sk);
 
+struct sk_buff *l2cap_create_connless_pdu(struct sock *sk, struct msghdr *msg, size_t len);
+struct sk_buff *l2cap_create_basic_pdu(struct sock *sk, struct msghdr *msg, size_t len);
+struct sk_buff *l2cap_create_iframe_pdu(struct sock *sk, struct msghdr *msg, size_t len, u16 control, u16 sdulen);
+int l2cap_sar_segment_sdu(struct sock *sk, struct msghdr *msg, size_t len);
+void l2cap_do_send(struct sock *sk, struct sk_buff *skb);
+void l2cap_streaming_send(struct sock *sk);
+int l2cap_ertm_send(struct sock *sk);
+
 void l2cap_sock_set_timer(struct sock *sk, long timeout);
 void l2cap_sock_clear_timer(struct sock *sk);
 void __l2cap_sock_close(struct sock *sk, int reason);
@@ -445,9 +453,6 @@ struct sock *l2cap_sock_alloc(struct net *net, struct socket *sock,
 							int proto, gfp_t prio);
 int l2cap_do_connect(struct sock *sk);
 
-int l2cap_sock_sendmsg(struct kiocb *iocb, struct socket *sock, struct msghdr *msg, size_t len);
-
-
 void l2cap_load(void);
 
 #endif /* __L2CAP_H */
diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 0368a2e..4e3a06e 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -992,7 +992,7 @@ static void l2cap_drop_acked_frames(struct sock *sk)
 		del_timer(&l2cap_pi(sk)->retrans_timer);
 }
 
-static inline void l2cap_do_send(struct sock *sk, struct sk_buff *skb)
+void l2cap_do_send(struct sock *sk, struct sk_buff *skb)
 {
 	struct l2cap_pinfo *pi = l2cap_pi(sk);
 	struct hci_conn *hcon = pi->conn->hcon;
@@ -1008,7 +1008,7 @@ static inline void l2cap_do_send(struct sock *sk, struct sk_buff *skb)
 	hci_send_acl(hcon, skb, flags);
 }
 
-static void l2cap_streaming_send(struct sock *sk)
+void l2cap_streaming_send(struct sock *sk)
 {
 	struct sk_buff *skb;
 	struct l2cap_pinfo *pi = l2cap_pi(sk);
@@ -1077,7 +1077,7 @@ static void l2cap_retransmit_one_frame(struct sock *sk, u8 tx_seq)
 	l2cap_do_send(sk, tx_skb);
 }
 
-static int l2cap_ertm_send(struct sock *sk)
+int l2cap_ertm_send(struct sock *sk)
 {
 	struct sk_buff *skb, *tx_skb;
 	struct l2cap_pinfo *pi = l2cap_pi(sk);
@@ -1217,7 +1217,7 @@ static inline int l2cap_skbuff_fromiovec(struct sock *sk, struct msghdr *msg, in
 	return sent;
 }
 
-static struct sk_buff *l2cap_create_connless_pdu(struct sock *sk, struct msghdr *msg, size_t len)
+struct sk_buff *l2cap_create_connless_pdu(struct sock *sk, struct msghdr *msg, size_t len)
 {
 	struct l2cap_conn *conn = l2cap_pi(sk)->conn;
 	struct sk_buff *skb;
@@ -1246,7 +1246,7 @@ static struct sk_buff *l2cap_create_connless_pdu(struct sock *sk, struct msghdr
 	return skb;
 }
 
-static struct sk_buff *l2cap_create_basic_pdu(struct sock *sk, struct msghdr *msg, size_t len)
+struct sk_buff *l2cap_create_basic_pdu(struct sock *sk, struct msghdr *msg, size_t len)
 {
 	struct l2cap_conn *conn = l2cap_pi(sk)->conn;
 	struct sk_buff *skb;
@@ -1274,7 +1274,7 @@ static struct sk_buff *l2cap_create_basic_pdu(struct sock *sk, struct msghdr *ms
 	return skb;
 }
 
-static struct sk_buff *l2cap_create_iframe_pdu(struct sock *sk, struct msghdr *msg, size_t len, u16 control, u16 sdulen)
+struct sk_buff *l2cap_create_iframe_pdu(struct sock *sk, struct msghdr *msg, size_t len, u16 control, u16 sdulen)
 {
 	struct l2cap_conn *conn = l2cap_pi(sk)->conn;
 	struct sk_buff *skb;
@@ -1319,7 +1319,7 @@ static struct sk_buff *l2cap_create_iframe_pdu(struct sock *sk, struct msghdr *m
 	return skb;
 }
 
-static inline int l2cap_sar_segment_sdu(struct sock *sk, struct msghdr *msg, size_t len)
+int l2cap_sar_segment_sdu(struct sock *sk, struct msghdr *msg, size_t len)
 {
 	struct l2cap_pinfo *pi = l2cap_pi(sk);
 	struct sk_buff *skb;
@@ -1365,108 +1365,6 @@ static inline int l2cap_sar_segment_sdu(struct sock *sk, struct msghdr *msg, siz
 	return size;
 }
 
-int l2cap_sock_sendmsg(struct kiocb *iocb, struct socket *sock, struct msghdr *msg, size_t len)
-{
-	struct sock *sk = sock->sk;
-	struct l2cap_pinfo *pi = l2cap_pi(sk);
-	struct sk_buff *skb;
-	u16 control;
-	int err;
-
-	BT_DBG("sock %p, sk %p", sock, sk);
-
-	err = sock_error(sk);
-	if (err)
-		return err;
-
-	if (msg->msg_flags & MSG_OOB)
-		return -EOPNOTSUPP;
-
-	lock_sock(sk);
-
-	if (sk->sk_state != BT_CONNECTED) {
-		err = -ENOTCONN;
-		goto done;
-	}
-
-	/* Connectionless channel */
-	if (sk->sk_type == SOCK_DGRAM) {
-		skb = l2cap_create_connless_pdu(sk, msg, len);
-		if (IS_ERR(skb)) {
-			err = PTR_ERR(skb);
-		} else {
-			l2cap_do_send(sk, skb);
-			err = len;
-		}
-		goto done;
-	}
-
-	switch (pi->mode) {
-	case L2CAP_MODE_BASIC:
-		/* Check outgoing MTU */
-		if (len > pi->omtu) {
-			err = -EMSGSIZE;
-			goto done;
-		}
-
-		/* Create a basic PDU */
-		skb = l2cap_create_basic_pdu(sk, msg, len);
-		if (IS_ERR(skb)) {
-			err = PTR_ERR(skb);
-			goto done;
-		}
-
-		l2cap_do_send(sk, skb);
-		err = len;
-		break;
-
-	case L2CAP_MODE_ERTM:
-	case L2CAP_MODE_STREAMING:
-		/* Entire SDU fits into one PDU */
-		if (len <= pi->remote_mps) {
-			control = L2CAP_SDU_UNSEGMENTED;
-			skb = l2cap_create_iframe_pdu(sk, msg, len, control, 0);
-			if (IS_ERR(skb)) {
-				err = PTR_ERR(skb);
-				goto done;
-			}
-			__skb_queue_tail(TX_QUEUE(sk), skb);
-
-			if (sk->sk_send_head == NULL)
-				sk->sk_send_head = skb;
-
-		} else {
-		/* Segment SDU into multiples PDUs */
-			err = l2cap_sar_segment_sdu(sk, msg, len);
-			if (err < 0)
-				goto done;
-		}
-
-		if (pi->mode == L2CAP_MODE_STREAMING) {
-			l2cap_streaming_send(sk);
-		} else {
-			if ((pi->conn_state & L2CAP_CONN_REMOTE_BUSY) &&
-					(pi->conn_state & L2CAP_CONN_WAIT_F)) {
-				err = len;
-				break;
-			}
-			err = l2cap_ertm_send(sk);
-		}
-
-		if (err >= 0)
-			err = len;
-		break;
-
-	default:
-		BT_DBG("bad state %1.1x", pi->mode);
-		err = -EBADFD;
-	}
-
-done:
-	release_sock(sk);
-	return err;
-}
-
 static void l2cap_chan_ready(struct sock *sk)
 {
 	struct sock *parent = bt_sk(sk)->parent;
diff --git a/net/bluetooth/l2cap_sock.c b/net/bluetooth/l2cap_sock.c
index 93af233..fe4f834 100644
--- a/net/bluetooth/l2cap_sock.c
+++ b/net/bluetooth/l2cap_sock.c
@@ -681,6 +681,108 @@ static int l2cap_sock_setsockopt(struct socket *sock, int level, int optname, ch
 	return err;
 }
 
+static int l2cap_sock_sendmsg(struct kiocb *iocb, struct socket *sock, struct msghdr *msg, size_t len)
+{
+	struct sock *sk = sock->sk;
+	struct l2cap_pinfo *pi = l2cap_pi(sk);
+	struct sk_buff *skb;
+	u16 control;
+	int err;
+
+	BT_DBG("sock %p, sk %p", sock, sk);
+
+	err = sock_error(sk);
+	if (err)
+		return err;
+
+	if (msg->msg_flags & MSG_OOB)
+		return -EOPNOTSUPP;
+
+	lock_sock(sk);
+
+	if (sk->sk_state != BT_CONNECTED) {
+		err = -ENOTCONN;
+		goto done;
+	}
+
+	/* Connectionless channel */
+	if (sk->sk_type == SOCK_DGRAM) {
+		skb = l2cap_create_connless_pdu(sk, msg, len);
+		if (IS_ERR(skb)) {
+			err = PTR_ERR(skb);
+		} else {
+			l2cap_do_send(sk, skb);
+			err = len;
+		}
+		goto done;
+	}
+
+	switch (pi->mode) {
+	case L2CAP_MODE_BASIC:
+		/* Check outgoing MTU */
+		if (len > pi->omtu) {
+			err = -EMSGSIZE;
+			goto done;
+		}
+
+		/* Create a basic PDU */
+		skb = l2cap_create_basic_pdu(sk, msg, len);
+		if (IS_ERR(skb)) {
+			err = PTR_ERR(skb);
+			goto done;
+		}
+
+		l2cap_do_send(sk, skb);
+		err = len;
+		break;
+
+	case L2CAP_MODE_ERTM:
+	case L2CAP_MODE_STREAMING:
+		/* Entire SDU fits into one PDU */
+		if (len <= pi->remote_mps) {
+			control = L2CAP_SDU_UNSEGMENTED;
+			skb = l2cap_create_iframe_pdu(sk, msg, len, control, 0);
+			if (IS_ERR(skb)) {
+				err = PTR_ERR(skb);
+				goto done;
+			}
+			__skb_queue_tail(TX_QUEUE(sk), skb);
+
+			if (sk->sk_send_head == NULL)
+				sk->sk_send_head = skb;
+
+		} else {
+		/* Segment SDU into multiples PDUs */
+			err = l2cap_sar_segment_sdu(sk, msg, len);
+			if (err < 0)
+				goto done;
+		}
+
+		if (pi->mode == L2CAP_MODE_STREAMING) {
+			l2cap_streaming_send(sk);
+		} else {
+			if ((pi->conn_state & L2CAP_CONN_REMOTE_BUSY) &&
+					(pi->conn_state & L2CAP_CONN_WAIT_F)) {
+				err = len;
+				break;
+			}
+			err = l2cap_ertm_send(sk);
+		}
+
+		if (err >= 0)
+			err = len;
+		break;
+
+	default:
+		BT_DBG("bad state %1.1x", pi->mode);
+		err = -EBADFD;
+	}
+
+done:
+	release_sock(sk);
+	return err;
+}
+
 static int l2cap_sock_recvmsg(struct kiocb *iocb, struct socket *sock, struct msghdr *msg, size_t len, int flags)
 {
 	struct sock *sk = sock->sk;
-- 
1.7.4.rc3

