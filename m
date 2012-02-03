Return-Path: <cyrus@holtmann.org>
From: Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFCv2 08/10] Bluetooth: Change socket lock to chan lock
Date: Fri,  3 Feb 2012 16:36:27 +0200
Message-Id: <1328279789-10870-9-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1328279789-10870-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1328279789-10870-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>


Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
---
 net/bluetooth/l2cap_core.c |  155 +++++++++++++++++++++++++++----------------
 net/bluetooth/l2cap_sock.c |   13 +++-
 2 files changed, 108 insertions(+), 60 deletions(-)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 79d6996..d70d0f5 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -261,13 +261,12 @@ static void l2cap_chan_timeout(struct work_struct *work)
 {
 	struct l2cap_chan *chan = container_of(work, struct l2cap_chan,
 							chan_timer.work);
-	struct sock *sk = chan->sk;
 	int reason;
 
 	BT_DBG("chan %p state %d", chan, chan->state);
 
 	mutex_lock(&chan->conn->chan_lock);
-	lock_sock(sk);
+	l2cap_chan_lock(chan);
 
 	if (chan->state == BT_CONNECTED || chan->state == BT_CONFIG)
 		reason = ECONNREFUSED;
@@ -279,7 +278,7 @@ static void l2cap_chan_timeout(struct work_struct *work)
 
 	l2cap_chan_close(chan, reason);
 
-	release_sock(sk);
+	l2cap_chan_unlock(chan);
 	mutex_unlock(&chan->conn->chan_lock);
 
 	chan->ops->close(chan->data);
@@ -395,6 +394,8 @@ static void l2cap_chan_del(struct l2cap_chan *chan, int err)
 		hci_conn_put(conn->hcon);
 	}
 
+	lock_sock(sk);
+
 	__l2cap_state_change(chan, BT_CLOSED);
 	sock_set_flag(sk, SOCK_ZAPPED);
 
@@ -407,6 +408,8 @@ static void l2cap_chan_del(struct l2cap_chan *chan, int err)
 	} else
 		sk->sk_state_change(sk);
 
+	release_sock(sk);
+
 	if (!(test_bit(CONF_OUTPUT_DONE, &chan->conf_state) &&
 			test_bit(CONF_INPUT_DONE, &chan->conf_state)))
 		return;
@@ -440,10 +443,10 @@ static void l2cap_chan_cleanup_listen(struct sock *parent)
 		struct l2cap_chan *chan = l2cap_pi(sk)->chan;
 
 		mutex_lock(&chan->conn->chan_lock);
+		l2cap_chan_lock(chan);
 		__clear_chan_timer(chan);
-		lock_sock(sk);
 		l2cap_chan_close(chan, ECONNRESET);
-		release_sock(sk);
+		l2cap_chan_unlock(chan);
 		mutex_unlock(&chan->conn->chan_lock);
 
 		chan->ops->close(chan->data);
@@ -459,10 +462,12 @@ void l2cap_chan_close(struct l2cap_chan *chan, int reason)
 
 	switch (chan->state) {
 	case BT_LISTEN:
+		lock_sock(sk);
 		l2cap_chan_cleanup_listen(sk);
 
 		__l2cap_state_change(chan, BT_CLOSED);
 		sock_set_flag(sk, SOCK_ZAPPED);
+		release_sock(sk);
 		break;
 
 	case BT_CONNECTED:
@@ -505,7 +510,9 @@ void l2cap_chan_close(struct l2cap_chan *chan, int reason)
 		break;
 
 	default:
+		lock_sock(sk);
 		sock_set_flag(sk, SOCK_ZAPPED);
+		release_sock(sk);
 		break;
 	}
 }
@@ -733,14 +740,12 @@ static inline int l2cap_mode_supported(__u8 mode, __u32 feat_mask)
 
 static void l2cap_send_disconn_req(struct l2cap_conn *conn, struct l2cap_chan *chan, int err)
 {
-	struct sock *sk;
+	struct sock *sk = chan->sk;
 	struct l2cap_disconn_req req;
 
 	if (!conn)
 		return;
 
-	sk = chan->sk;
-
 	if (chan->mode == L2CAP_MODE_ERTM) {
 		__clear_retrans_timer(chan);
 		__clear_monitor_timer(chan);
@@ -752,8 +757,10 @@ static void l2cap_send_disconn_req(struct l2cap_conn *conn, struct l2cap_chan *c
 	l2cap_send_cmd(conn, l2cap_get_ident(conn),
 			L2CAP_DISCONN_REQ, sizeof(req), &req);
 
+	lock_sock(sk);
 	__l2cap_state_change(chan, BT_DISCONN);
 	__l2cap_set_sock_err(sk, err);
+	release_sock(sk);
 }
 
 /* ---- L2CAP connections ---- */
@@ -768,10 +775,10 @@ static void l2cap_conn_start(struct l2cap_conn *conn)
 	list_for_each_entry_safe(chan, tmp, &conn->chan_l, list) {
 		struct sock *sk = chan->sk;
 
-		bh_lock_sock(sk);
+		l2cap_chan_lock(chan);
 
 		if (chan->chan_type != L2CAP_CHAN_CONN_ORIENTED) {
-			bh_unlock_sock(sk);
+			l2cap_chan_unlock(chan);
 			continue;
 		}
 
@@ -780,7 +787,7 @@ static void l2cap_conn_start(struct l2cap_conn *conn)
 
 			if (!l2cap_chan_check_security(chan) ||
 					!__l2cap_no_conn_pending(chan)) {
-				bh_unlock_sock(sk);
+				l2cap_chan_unlock(chan);
 				continue;
 			}
 
@@ -790,7 +797,7 @@ static void l2cap_conn_start(struct l2cap_conn *conn)
 				/* l2cap_chan_close() calls list_del(chan)
 				 * so release the lock */
 				l2cap_chan_close(chan, ECONNRESET);
-				bh_unlock_sock(sk);
+				l2cap_chan_unlock(chan);
 				continue;
 			}
 
@@ -810,6 +817,7 @@ static void l2cap_conn_start(struct l2cap_conn *conn)
 			rsp.dcid = cpu_to_le16(chan->scid);
 
 			if (l2cap_chan_check_security(chan)) {
+				lock_sock(sk);
 				if (bt_sk(sk)->defer_setup) {
 					struct sock *parent = bt_sk(sk)->parent;
 					rsp.result = cpu_to_le16(L2CAP_CR_PEND);
@@ -822,6 +830,7 @@ static void l2cap_conn_start(struct l2cap_conn *conn)
 					rsp.result = cpu_to_le16(L2CAP_CR_SUCCESS);
 					rsp.status = cpu_to_le16(L2CAP_CS_NO_INFO);
 				}
+				release_sock(sk);
 			} else {
 				rsp.result = cpu_to_le16(L2CAP_CR_PEND);
 				rsp.status = cpu_to_le16(L2CAP_CS_AUTHEN_PEND);
@@ -832,7 +841,7 @@ static void l2cap_conn_start(struct l2cap_conn *conn)
 
 			if (test_bit(CONF_REQ_SENT, &chan->conf_state) ||
 					rsp.result != L2CAP_CR_SUCCESS) {
-				bh_unlock_sock(sk);
+				l2cap_chan_unlock(chan);
 				continue;
 			}
 
@@ -842,7 +851,7 @@ static void l2cap_conn_start(struct l2cap_conn *conn)
 			chan->num_conf_req++;
 		}
 
-		bh_unlock_sock(sk);
+		l2cap_chan_unlock(chan);
 	}
 
 	mutex_unlock(&conn->chan_lock);
@@ -931,7 +940,11 @@ clean:
 static void l2cap_chan_ready(struct l2cap_chan *chan)
 {
 	struct sock *sk = chan->sk;
-	struct sock *parent = bt_sk(sk)->parent;
+	struct sock *parent;
+
+	lock_sock(sk);
+
+	parent = bt_sk(sk)->parent;
 
 	BT_DBG("sk %p, parent %p", sk, parent);
 
@@ -943,6 +956,8 @@ static void l2cap_chan_ready(struct l2cap_chan *chan)
 
 	if (parent)
 		parent->sk_data_ready(parent, 0);
+
+	release_sock(sk);
 }
 
 static void l2cap_conn_ready(struct l2cap_conn *conn)
@@ -960,23 +975,25 @@ static void l2cap_conn_ready(struct l2cap_conn *conn)
 	mutex_lock(&conn->chan_lock);
 
 	list_for_each_entry(chan, &conn->chan_l, list) {
-		struct sock *sk = chan->sk;
 
-		bh_lock_sock(sk);
+		l2cap_chan_lock(chan);
 
 		if (conn->hcon->type == LE_LINK) {
 			if (smp_conn_security(conn, chan->sec_level))
 				l2cap_chan_ready(chan);
 
 		} else if (chan->chan_type != L2CAP_CHAN_CONN_ORIENTED) {
+			struct sock *sk = chan->sk;
 			__clear_chan_timer(chan);
+			lock_sock(sk);
 			__l2cap_state_change(chan, BT_CONNECTED);
 			sk->sk_state_change(sk);
+			release_sock(sk);
 
 		} else if (chan->state == BT_CONNECT)
 			l2cap_do_start(chan);
 
-		bh_unlock_sock(sk);
+		l2cap_chan_unlock(chan);
 	}
 
 	mutex_unlock(&conn->chan_lock);
@@ -994,8 +1011,12 @@ static void l2cap_conn_unreliable(struct l2cap_conn *conn, int err)
 	list_for_each_entry(chan, &conn->chan_l, list) {
 		struct sock *sk = chan->sk;
 
+		lock_sock(sk);
+
 		if (test_bit(FLAG_FORCE_RELIABLE, &chan->flags))
 			__l2cap_set_sock_err(sk, err);
+
+		release_sock(sk);
 	}
 
 	mutex_unlock(&conn->chan_lock);
@@ -1016,7 +1037,6 @@ static void l2cap_conn_del(struct hci_conn *hcon, int err)
 {
 	struct l2cap_conn *conn = hcon->l2cap_data;
 	struct l2cap_chan *chan, *l;
-	struct sock *sk;
 
 	if (!conn)
 		return;
@@ -1029,10 +1049,12 @@ static void l2cap_conn_del(struct hci_conn *hcon, int err)
 
 	/* Kill channels */
 	list_for_each_entry_safe(chan, l, &conn->chan_l, list) {
-		sk = chan->sk;
-		lock_sock(sk);
+		l2cap_chan_lock(chan);
+
 		l2cap_chan_del(chan, err);
-		release_sock(sk);
+
+		l2cap_chan_unlock(chan);
+
 		chan->ops->close(chan->data);
 	}
 
@@ -1300,40 +1322,39 @@ static void l2cap_monitor_timeout(struct work_struct *work)
 {
 	struct l2cap_chan *chan = container_of(work, struct l2cap_chan,
 							monitor_timer.work);
-	struct sock *sk = chan->sk;
-
 	BT_DBG("chan %p", chan);
 
-	lock_sock(sk);
+	l2cap_chan_lock(chan);
+
 	if (chan->retry_count >= chan->remote_max_tx) {
 		l2cap_send_disconn_req(chan->conn, chan, ECONNABORTED);
-		release_sock(sk);
-		return;
+		goto done;
 	}
 
 	chan->retry_count++;
 	__set_monitor_timer(chan);
 
 	l2cap_send_rr_or_rnr(chan, L2CAP_CTRL_POLL);
-	release_sock(sk);
+done:
+	l2cap_chan_unlock(chan);
 }
 
 static void l2cap_retrans_timeout(struct work_struct *work)
 {
 	struct l2cap_chan *chan = container_of(work, struct l2cap_chan,
 							retrans_timer.work);
-	struct sock *sk = chan->sk;
-
 	BT_DBG("chan %p", chan);
 
-	lock_sock(sk);
+	l2cap_chan_lock(chan);
+
 	chan->retry_count = 1;
 	__set_monitor_timer(chan);
 
 	set_bit(CONN_WAIT_F, &chan->conn_state);
 
 	l2cap_send_rr_or_rnr(chan, L2CAP_CTRL_POLL);
-	release_sock(sk);
+
+	l2cap_chan_unlock(chan);
 }
 
 static void l2cap_drop_acked_frames(struct l2cap_chan *chan)
@@ -2022,9 +2043,11 @@ static void l2cap_ack_timeout(struct work_struct *work)
 
 	BT_DBG("chan %p", chan);
 
-	lock_sock(chan->sk);
+	l2cap_chan_lock(chan);
+
 	__l2cap_send_ack(chan);
-	release_sock(chan->sk);
+
+	l2cap_chan_unlock(chan);
 
 	l2cap_chan_put(chan);
 }
@@ -2767,16 +2790,18 @@ static inline int l2cap_connect_rsp(struct l2cap_conn *conn, struct l2cap_cmd_hd
 	BT_DBG("dcid 0x%4.4x scid 0x%4.4x result 0x%2.2x status 0x%2.2x", dcid, scid, result, status);
 
 	if (scid) {
-		chan = l2cap_get_chan_by_scid(conn, scid);
+		chan = __l2cap_get_chan_by_scid(conn, scid);
 		if (!chan)
 			return -EFAULT;
 	} else {
-		chan = l2cap_get_chan_by_ident(conn, cmd->ident);
+		chan = __l2cap_get_chan_by_ident(conn, cmd->ident);
 		if (!chan)
 			return -EFAULT;
 	}
 
 	mutex_lock(&conn->chan_lock);
+	l2cap_chan_lock(chan);
+
 	sk = chan->sk;
 
 	switch (result) {
@@ -2803,7 +2828,7 @@ static inline int l2cap_connect_rsp(struct l2cap_conn *conn, struct l2cap_cmd_hd
 		break;
 	}
 
-	release_sock(sk);
+	l2cap_chan_unlock(chan);
 	mutex_unlock(&conn->chan_lock);
 
 	return 0;
@@ -2834,10 +2859,12 @@ static inline int l2cap_config_req(struct l2cap_conn *conn, struct l2cap_cmd_hdr
 
 	BT_DBG("dcid 0x%4.4x flags 0x%2.2x", dcid, flags);
 
-	chan = l2cap_get_chan_by_scid(conn, dcid);
+	chan = __l2cap_get_chan_by_scid(conn, dcid);
 	if (!chan)
 		return -ENOENT;
 
+	l2cap_chan_lock(chan);
+
 	sk = chan->sk;
 
 	if (chan->state != BT_CONFIG && chan->state != BT_CONNECT2) {
@@ -2927,7 +2954,7 @@ static inline int l2cap_config_req(struct l2cap_conn *conn, struct l2cap_cmd_hdr
 	}
 
 unlock:
-	release_sock(sk);
+	l2cap_chan_unlock(chan);
 	return 0;
 }
 
@@ -2946,10 +2973,12 @@ static inline int l2cap_config_rsp(struct l2cap_conn *conn, struct l2cap_cmd_hdr
 	BT_DBG("scid 0x%4.4x flags 0x%2.2x result 0x%2.2x",
 			scid, flags, result);
 
-	chan = l2cap_get_chan_by_scid(conn, scid);
+	chan = __l2cap_get_chan_by_scid(conn, scid);
 	if (!chan)
 		return 0;
 
+	l2cap_chan_lock(chan);
+
 	sk = chan->sk;
 
 	switch (result) {
@@ -3036,7 +3065,7 @@ static inline int l2cap_config_rsp(struct l2cap_conn *conn, struct l2cap_cmd_hdr
 	}
 
 done:
-	release_sock(sk);
+	l2cap_chan_unlock(chan);
 	return 0;
 }
 
@@ -3053,21 +3082,26 @@ static inline int l2cap_disconnect_req(struct l2cap_conn *conn, struct l2cap_cmd
 
 	BT_DBG("scid 0x%4.4x dcid 0x%4.4x", scid, dcid);
 
-	chan = l2cap_get_chan_by_scid(conn, dcid);
+	chan = __l2cap_get_chan_by_scid(conn, dcid);
 	if (!chan)
 		return 0;
 
 	mutex_lock(&conn->chan_lock);
+	l2cap_chan_lock(chan);
+
 	sk = chan->sk;
 
 	rsp.dcid = cpu_to_le16(chan->scid);
 	rsp.scid = cpu_to_le16(chan->dcid);
 	l2cap_send_cmd(conn, cmd->ident, L2CAP_DISCONN_RSP, sizeof(rsp), &rsp);
 
+	lock_sock(sk);
 	sk->sk_shutdown = SHUTDOWN_MASK;
+	release_sock(sk);
 
 	l2cap_chan_del(chan, ECONNRESET);
-	release_sock(sk);
+
+	l2cap_chan_unlock(chan);
 	mutex_unlock(&conn->chan_lock);
 
 	chan->ops->close(chan->data);
@@ -3079,22 +3113,23 @@ static inline int l2cap_disconnect_rsp(struct l2cap_conn *conn, struct l2cap_cmd
 	struct l2cap_disconn_rsp *rsp = (struct l2cap_disconn_rsp *) data;
 	u16 dcid, scid;
 	struct l2cap_chan *chan;
-	struct sock *sk;
 
 	scid = __le16_to_cpu(rsp->scid);
 	dcid = __le16_to_cpu(rsp->dcid);
 
 	BT_DBG("dcid 0x%4.4x scid 0x%4.4x", dcid, scid);
 
-	chan = l2cap_get_chan_by_scid(conn, scid);
+	chan = __l2cap_get_chan_by_scid(conn, scid);
 	if (!chan)
 		return 0;
 
 	mutex_lock(&conn->chan_lock);
-	sk = chan->sk;
+	l2cap_chan_lock(chan);
 
 	l2cap_chan_del(chan, 0);
-	release_sock(sk);
+
+	l2cap_chan_unlock(chan);
+	mutex_unlock(&conn->chan_lock);
 
 	chan->ops->close(chan->data);
 	return 0;
@@ -4243,18 +4278,17 @@ drop:
 static inline int l2cap_data_channel(struct l2cap_conn *conn, u16 cid, struct sk_buff *skb)
 {
 	struct l2cap_chan *chan;
-	struct sock *sk = NULL;
 	u32 control;
 	u16 tx_seq;
 	int len;
 
-	chan = l2cap_get_chan_by_scid(conn, cid);
+	chan = __l2cap_get_chan_by_scid(conn, cid);
 	if (!chan) {
 		BT_DBG("unknown cid 0x%4.4x", cid);
 		goto drop;
 	}
 
-	sk = chan->sk;
+	l2cap_chan_lock(chan);
 
 	BT_DBG("chan %p, len %d", chan, skb->len);
 
@@ -4325,8 +4359,7 @@ drop:
 	kfree_skb(skb);
 
 done:
-	if (sk)
-		release_sock(sk);
+	l2cap_chan_unlock(chan);
 
 	return 0;
 }
@@ -4545,7 +4578,7 @@ int l2cap_security_cfm(struct hci_conn *hcon, u8 status, u8 encrypt)
 	mutex_lock(&conn->chan_lock);
 
 	list_for_each_entry(chan, &conn->chan_l, list) {
-		bh_lock_sock(sk);
+		l2cap_chan_lock(chan);
 
 		BT_DBG("chan->scid %d", chan->scid);
 
@@ -4555,19 +4588,19 @@ int l2cap_security_cfm(struct hci_conn *hcon, u8 status, u8 encrypt)
 				l2cap_chan_ready(chan);
 			}
 
-			bh_unlock_sock(sk);
+			l2cap_chan_unlock(chan);
 			continue;
 		}
 
 		if (test_bit(CONF_CONNECT_PEND, &chan->conf_state)) {
-			bh_unlock_sock(sk);
+			l2cap_chan_unlock(chan);
 			continue;
 		}
 
 		if (!status && (chan->state == BT_CONNECTED ||
 						chan->state == BT_CONFIG)) {
 			l2cap_check_encryption(chan, encrypt);
-			bh_unlock_sock(sk);
+			l2cap_chan_unlock(chan);
 			continue;
 		}
 
@@ -4588,9 +4621,12 @@ int l2cap_security_cfm(struct hci_conn *hcon, u8 status, u8 encrypt)
 					msecs_to_jiffies(L2CAP_DISC_TIMEOUT));
 			}
 		} else if (chan->state == BT_CONNECT2) {
+			struct sock *sk = chan->sk;
 			struct l2cap_conn_rsp rsp;
 			__u16 res, stat;
 
+			lock_sock(sk);
+
 			if (!status) {
 				if (bt_sk(sk)->defer_setup) {
 					struct sock *parent = bt_sk(sk)->parent;
@@ -4611,6 +4647,8 @@ int l2cap_security_cfm(struct hci_conn *hcon, u8 status, u8 encrypt)
 				stat = L2CAP_CS_NO_INFO;
 			}
 
+			release_sock(sk);
+
 			rsp.scid   = cpu_to_le16(chan->dcid);
 			rsp.dcid   = cpu_to_le16(chan->scid);
 			rsp.result = cpu_to_le16(res);
@@ -4619,7 +4657,7 @@ int l2cap_security_cfm(struct hci_conn *hcon, u8 status, u8 encrypt)
 							sizeof(rsp), &rsp);
 		}
 
-		bh_unlock_sock(sk);
+		l2cap_chan_unlock(chan);
 	}
 
 	mutex_unlock(&conn->chan_lock);
@@ -4679,10 +4717,11 @@ int l2cap_recv_acldata(struct hci_conn *hcon, struct sk_buff *skb, u16 flags)
 			goto drop;
 		}
 
-		chan = l2cap_get_chan_by_scid(conn, cid);
+		chan = __l2cap_get_chan_by_scid(conn, cid);
 
 		if (chan && chan->sk) {
 			struct sock *sk = chan->sk;
+			lock_sock(sk);
 
 			if (chan->imtu < len - L2CAP_HDR_SIZE) {
 				BT_ERR("Frame exceeding recv MTU (len %d, "
diff --git a/net/bluetooth/l2cap_sock.c b/net/bluetooth/l2cap_sock.c
index 1636029..dea5418 100644
--- a/net/bluetooth/l2cap_sock.c
+++ b/net/bluetooth/l2cap_sock.c
@@ -809,7 +809,9 @@ static int l2cap_sock_shutdown(struct socket *sock, int how)
 			err = __l2cap_wait_ack(sk);
 
 		sk->sk_shutdown = SHUTDOWN_MASK;
+		release_sock(sk);
 		l2cap_chan_close(chan, 0);
+		lock_sock(sk);
 
 		if (sock_flag(sk, SOCK_LINGER) && sk->sk_lingertime)
 			err = bt_sock_wait_state(sk, BT_CLOSED,
@@ -862,8 +864,12 @@ static int l2cap_sock_recv_cb(void *data, struct sk_buff *skb)
 	struct sock *sk = data;
 	struct l2cap_pinfo *pi = l2cap_pi(sk);
 
-	if (pi->rx_busy_skb)
-		return -ENOMEM;
+	lock_sock(sk);
+
+	if (pi->rx_busy_skb) {
+		err = -ENOMEM;
+		goto done;
+	}
 
 	err = sock_queue_rcv_skb(sk, skb);
 
@@ -882,6 +888,9 @@ static int l2cap_sock_recv_cb(void *data, struct sk_buff *skb)
 		err = 0;
 	}
 
+done:
+	release_sock(sk);
+
 	return err;
 }
 
-- 
1.7.8.3

