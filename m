Return-Path: <cyrus@holtmann.org>
From: "Gustavo F. Padovan" <padovan@profusion.mobi>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH -v2 4/7] Bluetooth: Add chan->chan_type struct member
Date: Fri, 13 May 2011 16:20:47 -0300
Message-Id: <1305314450-25493-5-git-send-email-padovan@profusion.mobi>
In-Reply-To: <1305314450-25493-4-git-send-email-padovan@profusion.mobi>
References: <1305314450-25493-1-git-send-email-padovan@profusion.mobi>
 <1305314450-25493-2-git-send-email-padovan@profusion.mobi>
 <1305314450-25493-3-git-send-email-padovan@profusion.mobi>
 <1305314450-25493-4-git-send-email-padovan@profusion.mobi>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

chan_type says if our chan is raw(direclty access to HCI),
connection less or connection oriented.

Signed-off-by: Gustavo F. Padovan <padovan@profusion.mobi>
---
 include/net/bluetooth/l2cap.h |    5 +++++
 net/bluetooth/l2cap_core.c    |   30 +++++++++++-------------------
 net/bluetooth/l2cap_sock.c    |   29 ++++++++++++++++++++++-------
 3 files changed, 38 insertions(+), 26 deletions(-)

diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
index dc721ca..094a7ac 100644
--- a/include/net/bluetooth/l2cap.h
+++ b/include/net/bluetooth/l2cap.h
@@ -295,6 +295,7 @@ struct l2cap_chan {
 	__u16		omtu;
 	__u16		flush_to;
 	__u8		mode;
+	__u8		chan_type;
 
 	__le16		sport;
 
@@ -384,6 +385,10 @@ struct l2cap_conn {
 #define L2CAP_INFO_FEAT_MASK_REQ_SENT	0x04
 #define L2CAP_INFO_FEAT_MASK_REQ_DONE	0x08
 
+#define L2CAP_CHAN_RAW			1
+#define L2CAP_CHAN_CONN_LESS		2
+#define L2CAP_CHAN_CONN_ORIENTED	3
+
 /* ----- L2CAP socket info ----- */
 #define l2cap_pi(sk) ((struct l2cap_pinfo *) sk)
 
diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 1e049a7..0964854 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -245,7 +245,7 @@ static void __l2cap_chan_add(struct l2cap_conn *conn, struct l2cap_chan *chan)
 
 	chan->conn = conn;
 
-	if (sk->sk_type == SOCK_SEQPACKET || sk->sk_type == SOCK_STREAM) {
+	if (chan->chan_type == L2CAP_CHAN_CONN_ORIENTED) {
 		if (conn->hcon->type == LE_LINK) {
 			/* LE connection */
 			chan->omtu = L2CAP_LE_DEFAULT_MTU;
@@ -256,7 +256,7 @@ static void __l2cap_chan_add(struct l2cap_conn *conn, struct l2cap_chan *chan)
 			chan->scid = l2cap_alloc_cid(conn);
 			chan->omtu = L2CAP_DEFAULT_MTU;
 		}
-	} else if (sk->sk_type == SOCK_DGRAM) {
+	} else if (chan->chan_type == L2CAP_CHAN_CONN_LESS) {
 		/* Connectionless socket */
 		chan->scid = L2CAP_CID_CONN_LESS;
 		chan->dcid = L2CAP_CID_CONN_LESS;
@@ -369,8 +369,7 @@ void __l2cap_chan_close(struct l2cap_chan *chan, int reason)
 
 	case BT_CONNECTED:
 	case BT_CONFIG:
-		if ((sk->sk_type == SOCK_SEQPACKET ||
-					sk->sk_type == SOCK_STREAM) &&
+		if (chan->chan_type == L2CAP_CHAN_CONN_ORIENTED &&
 					conn->hcon->type == ACL_LINK) {
 			l2cap_sock_set_timer(sk, sk->sk_sndtimeo);
 			l2cap_send_disconn_req(conn, chan, reason);
@@ -379,8 +378,7 @@ void __l2cap_chan_close(struct l2cap_chan *chan, int reason)
 		break;
 
 	case BT_CONNECT2:
-		if ((sk->sk_type == SOCK_SEQPACKET ||
-					sk->sk_type == SOCK_STREAM) &&
+		if (chan->chan_type == L2CAP_CHAN_CONN_ORIENTED &&
 					conn->hcon->type == ACL_LINK) {
 			struct l2cap_conn_rsp rsp;
 			__u16 result;
@@ -414,9 +412,7 @@ void __l2cap_chan_close(struct l2cap_chan *chan, int reason)
 
 static inline u8 l2cap_get_auth_type(struct l2cap_chan *chan)
 {
-	struct sock *sk = chan->sk;
-
-	if (sk->sk_type == SOCK_RAW) {
+	if (chan->chan_type == L2CAP_CHAN_RAW) {
 		switch (chan->sec_level) {
 		case BT_SECURITY_HIGH:
 			return HCI_AT_DEDICATED_BONDING_MITM;
@@ -657,8 +653,7 @@ static void l2cap_conn_start(struct l2cap_conn *conn)
 
 		bh_lock_sock(sk);
 
-		if (sk->sk_type != SOCK_SEQPACKET &&
-				sk->sk_type != SOCK_STREAM) {
+		if (chan->chan_type != L2CAP_CHAN_CONN_ORIENTED) {
 			bh_unlock_sock(sk);
 			continue;
 		}
@@ -852,8 +847,7 @@ static void l2cap_conn_ready(struct l2cap_conn *conn)
 			sk->sk_state_change(sk);
 		}
 
-		if (sk->sk_type != SOCK_SEQPACKET &&
-				sk->sk_type != SOCK_STREAM) {
+		if (chan->chan_type != L2CAP_CHAN_CONN_ORIENTED) {
 			l2cap_sock_clear_timer(sk);
 			sk->sk_state = BT_CONNECTED;
 			sk->sk_state_change(sk);
@@ -1056,8 +1050,7 @@ int l2cap_chan_connect(struct l2cap_chan *chan)
 	l2cap_sock_set_timer(sk, sk->sk_sndtimeo);
 
 	if (hcon->state == BT_CONNECTED) {
-		if (sk->sk_type != SOCK_SEQPACKET &&
-				sk->sk_type != SOCK_STREAM) {
+		if (chan->chan_type != L2CAP_CHAN_CONN_ORIENTED) {
 			l2cap_sock_clear_timer(sk);
 			if (l2cap_check_security(chan))
 				sk->sk_state = BT_CONNECTED;
@@ -1537,13 +1530,12 @@ int l2cap_sar_segment_sdu(struct l2cap_chan *chan, struct msghdr *msg, size_t le
 
 int l2cap_chan_send(struct l2cap_chan *chan, struct msghdr *msg, size_t len)
 {
-	struct sock *sk = chan->sk;
 	struct sk_buff *skb;
 	u16 control;
 	int err;
 
 	/* Connectionless channel */
-	if (sk->sk_type == SOCK_DGRAM) {
+	if (chan->chan_type == L2CAP_CHAN_CONN_LESS) {
 		skb = l2cap_create_connless_pdu(chan, msg, len);
 		if (IS_ERR(skb))
 			return PTR_ERR(skb);
@@ -1650,7 +1642,7 @@ static void l2cap_raw_recv(struct l2cap_conn *conn, struct sk_buff *skb)
 	read_lock(&conn->chan_lock);
 	list_for_each_entry(chan, &conn->chan_l, list) {
 		struct sock *sk = chan->sk;
-		if (sk->sk_type != SOCK_RAW)
+		if (chan->chan_type != L2CAP_CHAN_RAW)
 			continue;
 
 		/* Don't send frame to the socket it came from */
@@ -4106,7 +4098,7 @@ static inline void l2cap_check_encryption(struct l2cap_chan *chan, u8 encrypt)
 {
 	struct sock *sk = chan->sk;
 
-	if (sk->sk_type != SOCK_SEQPACKET && sk->sk_type != SOCK_STREAM)
+	if (chan->chan_type != L2CAP_CHAN_CONN_ORIENTED)
 		return;
 
 	if (encrypt == 0x00) {
diff --git a/net/bluetooth/l2cap_sock.c b/net/bluetooth/l2cap_sock.c
index f36776e..6a80a96 100644
--- a/net/bluetooth/l2cap_sock.c
+++ b/net/bluetooth/l2cap_sock.c
@@ -162,7 +162,7 @@ static int l2cap_sock_connect(struct socket *sock, struct sockaddr *addr, int al
 
 	lock_sock(sk);
 
-	if ((sk->sk_type == SOCK_SEQPACKET || sk->sk_type == SOCK_STREAM)
+	if (chan->chan_type == L2CAP_CHAN_CONN_ORIENTED
 			&& !(la.l2_psm || la.l2_cid)) {
 		err = -EINVAL;
 		goto done;
@@ -204,8 +204,8 @@ static int l2cap_sock_connect(struct socket *sock, struct sockaddr *addr, int al
 	}
 
 	/* PSM must be odd and lsb of upper byte must be 0 */
-	if ((__le16_to_cpu(la.l2_psm) & 0x0101) != 0x0001 &&
-				sk->sk_type != SOCK_RAW && !la.l2_cid) {
+	if ((__le16_to_cpu(la.l2_psm) & 0x0101) != 0x0001 && !la.l2_cid &&
+					chan->chan_type != L2CAP_CHAN_RAW) {
 		err = -EINVAL;
 		goto done;
 	}
@@ -453,8 +453,8 @@ static int l2cap_sock_getsockopt(struct socket *sock, int level, int optname, ch
 
 	switch (optname) {
 	case BT_SECURITY:
-		if (sk->sk_type != SOCK_SEQPACKET && sk->sk_type != SOCK_STREAM
-				&& sk->sk_type != SOCK_RAW) {
+		if (chan->chan_type != L2CAP_CHAN_CONN_ORIENTED &&
+					chan->chan_type != L2CAP_CHAN_RAW) {
 			err = -EINVAL;
 			break;
 		}
@@ -599,8 +599,8 @@ static int l2cap_sock_setsockopt(struct socket *sock, int level, int optname, ch
 
 	switch (optname) {
 	case BT_SECURITY:
-		if (sk->sk_type != SOCK_SEQPACKET && sk->sk_type != SOCK_STREAM
-				&& sk->sk_type != SOCK_RAW) {
+		if (chan->chan_type != L2CAP_CHAN_CONN_ORIENTED &&
+					chan->chan_type != L2CAP_CHAN_RAW) {
 			err = -EINVAL;
 			break;
 		}
@@ -806,6 +806,7 @@ void l2cap_sock_init(struct sock *sk, struct sock *parent)
 		sk->sk_type = parent->sk_type;
 		bt_sk(sk)->defer_setup = bt_sk(parent)->defer_setup;
 
+		chan->chan_type = pchan->chan_type;
 		chan->imtu = pchan->imtu;
 		chan->omtu = pchan->omtu;
 		chan->conf_state = pchan->conf_state;
@@ -818,6 +819,20 @@ void l2cap_sock_init(struct sock *sk, struct sock *parent)
 		chan->force_reliable = pchan->force_reliable;
 		chan->flushable = pchan->flushable;
 	} else {
+
+		switch (sk->sk_type) {
+		case SOCK_RAW:
+			chan->chan_type = L2CAP_CHAN_RAW;
+			break;
+		case SOCK_DGRAM:
+			chan->chan_type = L2CAP_CHAN_CONN_LESS;
+			break;
+		case SOCK_SEQPACKET:
+		case SOCK_STREAM:
+			chan->chan_type = L2CAP_CHAN_CONN_ORIENTED;
+			break;
+		}
+
 		chan->imtu = L2CAP_DEFAULT_MTU;
 		chan->omtu = 0;
 		if (!disable_ertm && sk->sk_type == SOCK_STREAM) {
-- 
1.7.5.rc3

