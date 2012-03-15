Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFCv4 04/30] Bluetooth: Add set_err to state_change callback
Date: Thu, 15 Mar 2012 14:29:55 +0200
Message-Id: <1331814621-13905-5-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1331814621-13905-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1331814621-13905-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

There are several places in the code where l2cap_state_change and
l2cap_chan_set_err used together. With combining them we remove
socket lock in l2cap_send_disconn_req and simplify code in couple
of other places with a price of adding extra parameter err to
state_change.

Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
---
 include/net/bluetooth/l2cap.h |    4 ++-
 net/bluetooth/l2cap_core.c    |   56 ++++++++++++++++++----------------------
 net/bluetooth/l2cap_sock.c    |    8 +++++-
 3 files changed, 35 insertions(+), 33 deletions(-)

diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
index f089162..d9c668c 100644
--- a/include/net/bluetooth/l2cap.h
+++ b/include/net/bluetooth/l2cap.h
@@ -508,7 +508,8 @@ struct l2cap_ops {
 	int			(*send) (struct l2cap_chan *chan,
 				struct msghdr *msg, size_t len, u32 priority);
 	void			(*close) (void *data);
-	void			(*state_change) (void *data, int state);
+	void			(*state_change) (void *data, int state,
+								int err);
 	struct sk_buff		*(*alloc_skb) (struct l2cap_chan *chan,
 					unsigned long len, int nb, int *err);
 
@@ -866,5 +867,6 @@ int l2cap_chan_check_security(struct l2cap_chan *chan);
 void l2cap_ertm_init(struct l2cap_chan *chan);
 
 void l2cap_chan_add(struct l2cap_conn *conn, struct l2cap_chan *chan);
+void __l2cap_chan_set_err(struct l2cap_chan *chan, int err);
 
 #endif /* __L2CAP_H */
diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index b0d1cee..779f819 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -199,25 +199,25 @@ static u16 l2cap_alloc_cid(struct l2cap_conn *conn)
 	return 0;
 }
 
-static void __l2cap_state_change(struct l2cap_chan *chan, int state)
+static void __l2cap_state_change(struct l2cap_chan *chan, int state, int err)
 {
 	BT_DBG("chan %p %s -> %s", chan, state_to_string(chan->state),
 						state_to_string(state));
 
 	chan->state = state;
-	chan->ops->state_change(chan->data, state);
+	chan->ops->state_change(chan->data, state, err);
 }
 
-static void l2cap_state_change(struct l2cap_chan *chan, int state)
+static inline void l2cap_state_change(struct l2cap_chan *chan, int state, int err)
 {
 	struct sock *sk = chan->sk;
 
 	lock_sock(sk);
-	__l2cap_state_change(chan, state);
+	__l2cap_state_change(chan, state, err);
 	release_sock(sk);
 }
 
-static inline void __l2cap_chan_set_err(struct l2cap_chan *chan, int err)
+void __l2cap_chan_set_err(struct l2cap_chan *chan, int err)
 {
 	struct sock *sk = chan->sk;
 
@@ -377,11 +377,9 @@ static void l2cap_chan_del(struct l2cap_chan *chan, int err)
 
 	lock_sock(sk);
 
-	__l2cap_state_change(chan, BT_CLOSED);
-	sock_set_flag(sk, SOCK_ZAPPED);
+	__l2cap_state_change(chan, BT_CLOSED, err);
 
-	if (err)
-		__l2cap_chan_set_err(chan, err);
+	sock_set_flag(sk, SOCK_ZAPPED);
 
 	if (parent) {
 		bt_accept_unlink(sk);
@@ -445,7 +443,7 @@ void l2cap_chan_close(struct l2cap_chan *chan, int reason)
 		lock_sock(sk);
 		l2cap_chan_cleanup_listen(sk);
 
-		__l2cap_state_change(chan, BT_CLOSED);
+		__l2cap_state_change(chan, BT_CLOSED, 0);
 		sock_set_flag(sk, SOCK_ZAPPED);
 		release_sock(sk);
 		break;
@@ -471,7 +469,7 @@ void l2cap_chan_close(struct l2cap_chan *chan, int reason)
 				result = L2CAP_CR_SEC_BLOCK;
 			else
 				result = L2CAP_CR_BAD_PSM;
-			l2cap_state_change(chan, BT_DISCONN);
+			l2cap_state_change(chan, BT_DISCONN, 0);
 
 			rsp.scid   = cpu_to_le16(chan->dcid);
 			rsp.dcid   = cpu_to_le16(chan->scid);
@@ -725,7 +723,6 @@ static inline int l2cap_mode_supported(__u8 mode, __u32 feat_mask)
 
 static void l2cap_send_disconn_req(struct l2cap_conn *conn, struct l2cap_chan *chan, int err)
 {
-	struct sock *sk = chan->sk;
 	struct l2cap_disconn_req req;
 
 	if (!conn)
@@ -742,10 +739,7 @@ static void l2cap_send_disconn_req(struct l2cap_conn *conn, struct l2cap_chan *c
 	l2cap_send_cmd(conn, l2cap_get_ident(conn),
 			L2CAP_DISCONN_REQ, sizeof(req), &req);
 
-	lock_sock(sk);
-	__l2cap_state_change(chan, BT_DISCONN);
-	__l2cap_chan_set_err(chan, err);
-	release_sock(sk);
+	l2cap_state_change(chan, BT_DISCONN, err);
 }
 
 /* ---- L2CAP connections ---- */
@@ -800,7 +794,7 @@ static void l2cap_conn_start(struct l2cap_conn *conn)
 						parent->sk_data_ready(parent, 0);
 
 				} else {
-					__l2cap_state_change(chan, BT_CONFIG);
+					__l2cap_state_change(chan, BT_CONFIG, 0);
 					rsp.result = cpu_to_le16(L2CAP_CR_SUCCESS);
 					rsp.status = cpu_to_le16(L2CAP_CS_NO_INFO);
 				}
@@ -904,7 +898,7 @@ static void l2cap_le_conn_ready(struct l2cap_conn *conn)
 
 	__set_chan_timer(chan, sk->sk_sndtimeo);
 
-	__l2cap_state_change(chan, BT_CONNECTED);
+	__l2cap_state_change(chan, BT_CONNECTED, 0);
 	parent->sk_data_ready(parent, 0);
 
 clean:
@@ -925,7 +919,7 @@ static void l2cap_chan_ready(struct l2cap_chan *chan)
 	chan->conf_state = 0;
 	__clear_chan_timer(chan);
 
-	__l2cap_state_change(chan, BT_CONNECTED);
+	__l2cap_state_change(chan, BT_CONNECTED, 0);
 	sk->sk_state_change(sk);
 
 	if (parent)
@@ -960,7 +954,7 @@ static void l2cap_conn_ready(struct l2cap_conn *conn)
 			struct sock *sk = chan->sk;
 			__clear_chan_timer(chan);
 			lock_sock(sk);
-			__l2cap_state_change(chan, BT_CONNECTED);
+			__l2cap_state_change(chan, BT_CONNECTED, 0);
 			sk->sk_state_change(sk);
 			release_sock(sk);
 
@@ -1244,14 +1238,14 @@ int l2cap_chan_connect(struct l2cap_chan *chan, __le16 psm, u16 cid, bdaddr_t *d
 	l2cap_chan_add(conn, chan);
 	l2cap_chan_lock(chan);
 
-	l2cap_state_change(chan, BT_CONNECT);
+	l2cap_state_change(chan, BT_CONNECT, 0);
 	__set_chan_timer(chan, sk->sk_sndtimeo);
 
 	if (hcon->state == BT_CONNECTED) {
 		if (chan->chan_type != L2CAP_CHAN_CONN_ORIENTED) {
 			__clear_chan_timer(chan);
 			if (l2cap_chan_check_security(chan))
-				l2cap_state_change(chan, BT_CONNECTED);
+				l2cap_state_change(chan, BT_CONNECTED, 0);
 		} else
 			l2cap_do_start(chan);
 	}
@@ -2705,22 +2699,22 @@ static inline int l2cap_connect_req(struct l2cap_conn *conn, struct l2cap_cmd_hd
 	if (conn->info_state & L2CAP_INFO_FEAT_MASK_REQ_DONE) {
 		if (l2cap_chan_check_security(chan)) {
 			if (bt_sk(sk)->defer_setup) {
-				__l2cap_state_change(chan, BT_CONNECT2);
+				__l2cap_state_change(chan, BT_CONNECT2, 0);
 				result = L2CAP_CR_PEND;
 				status = L2CAP_CS_AUTHOR_PEND;
 				parent->sk_data_ready(parent, 0);
 			} else {
-				__l2cap_state_change(chan, BT_CONFIG);
+				__l2cap_state_change(chan, BT_CONFIG, 0);
 				result = L2CAP_CR_SUCCESS;
 				status = L2CAP_CS_NO_INFO;
 			}
 		} else {
-			__l2cap_state_change(chan, BT_CONNECT2);
+			__l2cap_state_change(chan, BT_CONNECT2, 0);
 			result = L2CAP_CR_PEND;
 			status = L2CAP_CS_AUTHEN_PEND;
 		}
 	} else {
-		__l2cap_state_change(chan, BT_CONNECT2);
+		__l2cap_state_change(chan, BT_CONNECT2, 0);
 		result = L2CAP_CR_PEND;
 		status = L2CAP_CS_NO_INFO;
 	}
@@ -2799,7 +2793,7 @@ static inline int l2cap_connect_rsp(struct l2cap_conn *conn, struct l2cap_cmd_hd
 
 	switch (result) {
 	case L2CAP_CR_SUCCESS:
-		l2cap_state_change(chan, BT_CONFIG);
+		l2cap_state_change(chan, BT_CONFIG, 0);
 		chan->ident = 0;
 		chan->dcid = dcid;
 		clear_bit(CONF_CONNECT_PEND, &chan->conf_state);
@@ -2911,7 +2905,7 @@ static inline int l2cap_config_req(struct l2cap_conn *conn, struct l2cap_cmd_hdr
 	if (test_bit(CONF_INPUT_DONE, &chan->conf_state)) {
 		set_default_fcs(chan);
 
-		l2cap_state_change(chan, BT_CONNECTED);
+		l2cap_state_change(chan, BT_CONNECTED, 0);
 
 		chan->next_tx_seq = 0;
 		chan->expected_tx_seq = 0;
@@ -3042,7 +3036,7 @@ static inline int l2cap_config_rsp(struct l2cap_conn *conn, struct l2cap_cmd_hdr
 	if (test_bit(CONF_OUTPUT_DONE, &chan->conf_state)) {
 		set_default_fcs(chan);
 
-		l2cap_state_change(chan, BT_CONNECTED);
+		l2cap_state_change(chan, BT_CONNECTED, 0);
 		chan->next_tx_seq = 0;
 		chan->expected_tx_seq = 0;
 		skb_queue_head_init(&chan->tx_q);
@@ -4614,12 +4608,12 @@ int l2cap_security_cfm(struct hci_conn *hcon, u8 status, u8 encrypt)
 					if (parent)
 						parent->sk_data_ready(parent, 0);
 				} else {
-					__l2cap_state_change(chan, BT_CONFIG);
+					__l2cap_state_change(chan, BT_CONFIG, 0);
 					res = L2CAP_CR_SUCCESS;
 					stat = L2CAP_CS_NO_INFO;
 				}
 			} else {
-				__l2cap_state_change(chan, BT_DISCONN);
+				__l2cap_state_change(chan, BT_DISCONN, 0);
 				__set_chan_timer(chan, L2CAP_DISC_TIMEOUT);
 				res = L2CAP_CR_SEC_BLOCK;
 				stat = L2CAP_CS_NO_INFO;
diff --git a/net/bluetooth/l2cap_sock.c b/net/bluetooth/l2cap_sock.c
index 29122ed..7e26d63 100644
--- a/net/bluetooth/l2cap_sock.c
+++ b/net/bluetooth/l2cap_sock.c
@@ -919,11 +919,17 @@ static void l2cap_sock_close_cb(void *data)
 	l2cap_sock_kill(sk);
 }
 
-static void l2cap_sock_state_change_cb(void *data, int state)
+static void l2cap_sock_state_change_cb(void *data, int state, int err)
 {
 	struct sock *sk = data;
 
 	sk->sk_state = state;
+
+	if (err) {
+		struct l2cap_chan *chan = l2cap_pi(sk)->chan;
+
+		__l2cap_chan_set_err(chan, err);
+	}
 }
 
 static struct sk_buff *l2cap_sock_alloc_skb_cb(struct l2cap_chan *chan,
-- 
1.7.9.1

