Return-Path: <cyrus@holtmann.org>
From: Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFCv0 5/5] Bluetooth: Change sk lock to l2cap_chan lock
Date: Mon, 30 Jan 2012 17:09:06 +0200
Message-Id: <1327936146-13897-6-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1327936146-13897-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1327936146-13897-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Change socket lock to l2cap_chan lock. This is needed for use l2cap
channels without opening kernel socket for locking.

Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
---
 net/bluetooth/l2cap_core.c |  220 +++++++++++++++++++++++++++-----------------
 net/bluetooth/l2cap_sock.c |   13 ++-
 2 files changed, 146 insertions(+), 87 deletions(-)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 4a22602..85b4572 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -275,12 +275,12 @@ static void l2cap_chan_timeout(struct work_struct *work)
 {
 	struct l2cap_chan *chan = container_of(work, struct l2cap_chan,
 							chan_timer.work);
-	struct sock *sk = chan->sk;
 	int reason;
 
 	BT_DBG("chan %p state %d", chan, chan->state);
 
-	lock_sock(sk);
+	mutex_lock(&chan->conn->chan_lock);
+	l2cap_chan_lock(chan);
 
 	if (chan->state == BT_CONNECTED || chan->state == BT_CONFIG)
 		reason = ECONNREFUSED;
@@ -292,7 +292,8 @@ static void l2cap_chan_timeout(struct work_struct *work)
 
 	l2cap_chan_close(chan, reason);
 
-	release_sock(sk);
+	l2cap_chan_unlock(chan);
+	mutex_unlock(&chan->conn->chan_lock);
 
 	chan->ops->close(chan->data);
 	l2cap_chan_put(chan);
@@ -406,11 +407,13 @@ static void l2cap_chan_del(struct l2cap_chan *chan, int err)
 		hci_conn_put(conn->hcon);
 	}
 
-	l2cap_state_change(chan, BT_CLOSED);
+	lock_sock(sk);
+
+	__l2cap_state_change(chan, BT_CLOSED);
 	sock_set_flag(sk, SOCK_ZAPPED);
 
 	if (err)
-		sk->sk_err = err;
+		__l2cap_set_sock_err(sk, err);
 
 	if (parent) {
 		bt_accept_unlink(sk);
@@ -418,6 +421,8 @@ static void l2cap_chan_del(struct l2cap_chan *chan, int err)
 	} else
 		sk->sk_state_change(sk);
 
+	release_sock(sk);
+
 	if (!(test_bit(CONF_OUTPUT_DONE, &chan->conf_state) &&
 			test_bit(CONF_INPUT_DONE, &chan->conf_state)))
 		return;
@@ -449,10 +454,14 @@ static void l2cap_chan_cleanup_listen(struct sock *parent)
 	/* Close not yet accepted channels */
 	while ((sk = bt_accept_dequeue(parent, NULL))) {
 		struct l2cap_chan *chan = l2cap_pi(sk)->chan;
+
+		mutex_lock(&chan->conn->chan_lock);
+		l2cap_chan_lock(chan);
 		__clear_chan_timer(chan);
-		lock_sock(sk);
 		l2cap_chan_close(chan, ECONNRESET);
-		release_sock(sk);
+		l2cap_chan_unlock(chan);
+		mutex_unlock(&chan->conn->chan_lock);
+
 		chan->ops->close(chan->data);
 	}
 }
@@ -466,10 +475,12 @@ void l2cap_chan_close(struct l2cap_chan *chan, int reason)
 
 	switch (chan->state) {
 	case BT_LISTEN:
+		lock_sock(sk);
 		l2cap_chan_cleanup_listen(sk);
 
-		l2cap_state_change(chan, BT_CLOSED);
+		__l2cap_state_change(chan, BT_CLOSED);
 		sock_set_flag(sk, SOCK_ZAPPED);
+		release_sock(sk);
 		break;
 
 	case BT_CONNECTED:
@@ -512,7 +523,9 @@ void l2cap_chan_close(struct l2cap_chan *chan, int reason)
 		break;
 
 	default:
+		lock_sock(sk);
 		sock_set_flag(sk, SOCK_ZAPPED);
+		release_sock(sk);
 		break;
 	}
 }
@@ -740,14 +753,12 @@ static inline int l2cap_mode_supported(__u8 mode, __u32 feat_mask)
 
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
@@ -759,8 +770,10 @@ static void l2cap_send_disconn_req(struct l2cap_conn *conn, struct l2cap_chan *c
 	l2cap_send_cmd(conn, l2cap_get_ident(conn),
 			L2CAP_DISCONN_REQ, sizeof(req), &req);
 
-	l2cap_state_change(chan, BT_DISCONN);
-	sk->sk_err = err;
+	lock_sock(sk);
+	__l2cap_state_change(chan, BT_DISCONN);
+	__l2cap_set_sock_err(sk, err);
+	release_sock(sk);
 }
 
 /* ---- L2CAP connections ---- */
@@ -775,10 +788,10 @@ static void l2cap_conn_start(struct l2cap_conn *conn)
 	list_for_each_entry_safe(chan, tmp, &conn->chan_l, list) {
 		struct sock *sk = chan->sk;
 
-		bh_lock_sock(sk);
+		l2cap_chan_lock(chan);
 
 		if (chan->chan_type != L2CAP_CHAN_CONN_ORIENTED) {
-			bh_unlock_sock(sk);
+			l2cap_chan_unlock(chan);
 			continue;
 		}
 
@@ -787,7 +800,7 @@ static void l2cap_conn_start(struct l2cap_conn *conn)
 
 			if (!l2cap_chan_check_security(chan) ||
 					!__l2cap_no_conn_pending(chan)) {
-				bh_unlock_sock(sk);
+				l2cap_chan_unlock(chan);
 				continue;
 			}
 
@@ -797,7 +810,7 @@ static void l2cap_conn_start(struct l2cap_conn *conn)
 				/* l2cap_chan_close() calls list_del(chan)
 				 * so release the lock */
 				l2cap_chan_close(chan, ECONNRESET);
-				bh_unlock_sock(sk);
+				l2cap_chan_unlock(chan);
 				continue;
 			}
 
@@ -817,6 +830,7 @@ static void l2cap_conn_start(struct l2cap_conn *conn)
 			rsp.dcid = cpu_to_le16(chan->scid);
 
 			if (l2cap_chan_check_security(chan)) {
+				lock_sock(sk);
 				if (bt_sk(sk)->defer_setup) {
 					struct sock *parent = bt_sk(sk)->parent;
 					rsp.result = cpu_to_le16(L2CAP_CR_PEND);
@@ -825,10 +839,11 @@ static void l2cap_conn_start(struct l2cap_conn *conn)
 						parent->sk_data_ready(parent, 0);
 
 				} else {
-					l2cap_state_change(chan, BT_CONFIG);
+					__l2cap_state_change(chan, BT_CONFIG);
 					rsp.result = cpu_to_le16(L2CAP_CR_SUCCESS);
 					rsp.status = cpu_to_le16(L2CAP_CS_NO_INFO);
 				}
+				release_sock(sk);
 			} else {
 				rsp.result = cpu_to_le16(L2CAP_CR_PEND);
 				rsp.status = cpu_to_le16(L2CAP_CS_AUTHEN_PEND);
@@ -839,7 +854,7 @@ static void l2cap_conn_start(struct l2cap_conn *conn)
 
 			if (test_bit(CONF_REQ_SENT, &chan->conf_state) ||
 					rsp.result != L2CAP_CR_SUCCESS) {
-				bh_unlock_sock(sk);
+				l2cap_chan_unlock(chan);
 				continue;
 			}
 
@@ -849,7 +864,7 @@ static void l2cap_conn_start(struct l2cap_conn *conn)
 			chan->num_conf_req++;
 		}
 
-		bh_unlock_sock(sk);
+		l2cap_chan_unlock(chan);
 	}
 
 	mutex_unlock(&conn->chan_lock);
@@ -928,7 +943,7 @@ static void l2cap_le_conn_ready(struct l2cap_conn *conn)
 
 	__set_chan_timer(chan, sk->sk_sndtimeo);
 
-	l2cap_state_change(chan, BT_CONNECTED);
+	__l2cap_state_change(chan, BT_CONNECTED);
 	parent->sk_data_ready(parent, 0);
 
 clean:
@@ -938,18 +953,24 @@ clean:
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
 
 	chan->conf_state = 0;
 	__clear_chan_timer(chan);
 
-	l2cap_state_change(chan, BT_CONNECTED);
+	__l2cap_state_change(chan, BT_CONNECTED);
 	sk->sk_state_change(sk);
 
 	if (parent)
 		parent->sk_data_ready(parent, 0);
+
+	release_sock(sk);
 }
 
 static void l2cap_conn_ready(struct l2cap_conn *conn)
@@ -964,29 +985,31 @@ static void l2cap_conn_ready(struct l2cap_conn *conn)
 	if (conn->hcon->out && conn->hcon->type == LE_LINK)
 		smp_conn_security(conn, conn->hcon->pending_sec_level);
 
-	rcu_read_lock();
+	mutex_lock(&conn->chan_lock);
 
-	list_for_each_entry_rcu(chan, &conn->chan_l, list) {
-		struct sock *sk = chan->sk;
+	list_for_each_entry(chan, &conn->chan_l, list) {
 
-		bh_lock_sock(sk);
+		l2cap_chan_lock(chan);
 
 		if (conn->hcon->type == LE_LINK) {
 			if (smp_conn_security(conn, chan->sec_level))
 				l2cap_chan_ready(chan);
 
 		} else if (chan->chan_type != L2CAP_CHAN_CONN_ORIENTED) {
+			struct sock *sk = chan->sk;
 			__clear_chan_timer(chan);
-			l2cap_state_change(chan, BT_CONNECTED);
+			lock_sock(sk);
+			__l2cap_state_change(chan, BT_CONNECTED);
 			sk->sk_state_change(sk);
+			release_sock(sk);
 
 		} else if (chan->state == BT_CONNECT)
 			l2cap_do_start(chan);
 
-		bh_unlock_sock(sk);
+		l2cap_chan_unlock(chan);
 	}
 
-	rcu_read_unlock();
+	mutex_unlock(&conn->chan_lock);
 }
 
 /* Notify sockets that we cannot guaranty reliability anymore */
@@ -1001,8 +1024,12 @@ static void l2cap_conn_unreliable(struct l2cap_conn *conn, int err)
 	list_for_each_entry_rcu(chan, &conn->chan_l, list) {
 		struct sock *sk = chan->sk;
 
+		lock_sock(sk);
+
 		if (test_bit(FLAG_FORCE_RELIABLE, &chan->flags))
-			sk->sk_err = err;
+			__l2cap_set_sock_err(sk, err);
+
+		release_sock(sk);
 	}
 
 	rcu_read_unlock();
@@ -1023,7 +1050,6 @@ static void l2cap_conn_del(struct hci_conn *hcon, int err)
 {
 	struct l2cap_conn *conn = hcon->l2cap_data;
 	struct l2cap_chan *chan, *l;
-	struct sock *sk;
 
 	if (!conn)
 		return;
@@ -1036,10 +1062,12 @@ static void l2cap_conn_del(struct hci_conn *hcon, int err)
 
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
 
@@ -1251,14 +1279,14 @@ int l2cap_chan_connect(struct l2cap_chan *chan, __le16 psm, u16 cid, bdaddr_t *d
 
 	l2cap_chan_add(conn, chan);
 
-	l2cap_state_change(chan, BT_CONNECT);
+	__l2cap_state_change(chan, BT_CONNECT);
 	__set_chan_timer(chan, sk->sk_sndtimeo);
 
 	if (hcon->state == BT_CONNECTED) {
 		if (chan->chan_type != L2CAP_CHAN_CONN_ORIENTED) {
 			__clear_chan_timer(chan);
 			if (l2cap_chan_check_security(chan))
-				l2cap_state_change(chan, BT_CONNECTED);
+				__l2cap_state_change(chan, BT_CONNECTED);
 		} else
 			l2cap_do_start(chan);
 	}
@@ -1307,40 +1335,39 @@ static void l2cap_monitor_timeout(struct work_struct *work)
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
@@ -2029,9 +2056,11 @@ static void l2cap_ack_timeout(struct work_struct *work)
 
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
@@ -2702,22 +2731,22 @@ static inline int l2cap_connect_req(struct l2cap_conn *conn, struct l2cap_cmd_hd
 	if (conn->info_state & L2CAP_INFO_FEAT_MASK_REQ_DONE) {
 		if (l2cap_chan_check_security(chan)) {
 			if (bt_sk(sk)->defer_setup) {
-				l2cap_state_change(chan, BT_CONNECT2);
+				__l2cap_state_change(chan, BT_CONNECT2);
 				result = L2CAP_CR_PEND;
 				status = L2CAP_CS_AUTHOR_PEND;
 				parent->sk_data_ready(parent, 0);
 			} else {
-				l2cap_state_change(chan, BT_CONFIG);
+				__l2cap_state_change(chan, BT_CONFIG);
 				result = L2CAP_CR_SUCCESS;
 				status = L2CAP_CS_NO_INFO;
 			}
 		} else {
-			l2cap_state_change(chan, BT_CONNECT2);
+			__l2cap_state_change(chan, BT_CONNECT2);
 			result = L2CAP_CR_PEND;
 			status = L2CAP_CS_AUTHEN_PEND;
 		}
 	} else {
-		l2cap_state_change(chan, BT_CONNECT2);
+		__l2cap_state_change(chan, BT_CONNECT2);
 		result = L2CAP_CR_PEND;
 		status = L2CAP_CS_NO_INFO;
 	}
@@ -2774,15 +2803,18 @@ static inline int l2cap_connect_rsp(struct l2cap_conn *conn, struct l2cap_cmd_hd
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
 
+	mutex_lock(&conn->chan_lock);
+	l2cap_chan_lock(chan);
+
 	sk = chan->sk;
 
 	switch (result) {
@@ -2809,7 +2841,9 @@ static inline int l2cap_connect_rsp(struct l2cap_conn *conn, struct l2cap_cmd_hd
 		break;
 	}
 
-	release_sock(sk);
+	l2cap_chan_unlock(chan);
+	mutex_unlock(&conn->chan_lock);
+
 	return 0;
 }
 
@@ -2838,10 +2872,12 @@ static inline int l2cap_config_req(struct l2cap_conn *conn, struct l2cap_cmd_hdr
 
 	BT_DBG("dcid 0x%4.4x flags 0x%2.2x", dcid, flags);
 
-	chan = l2cap_get_chan_by_scid(conn, dcid);
+	chan = __l2cap_get_chan_by_scid(conn, dcid);
 	if (!chan)
 		return -ENOENT;
 
+	l2cap_chan_lock(chan);
+
 	sk = chan->sk;
 
 	if (chan->state != BT_CONFIG && chan->state != BT_CONNECT2) {
@@ -2931,7 +2967,7 @@ static inline int l2cap_config_req(struct l2cap_conn *conn, struct l2cap_cmd_hdr
 	}
 
 unlock:
-	release_sock(sk);
+	l2cap_chan_unlock(chan);
 	return 0;
 }
 
@@ -2950,10 +2986,12 @@ static inline int l2cap_config_rsp(struct l2cap_conn *conn, struct l2cap_cmd_hdr
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
@@ -3013,7 +3051,8 @@ static inline int l2cap_config_rsp(struct l2cap_conn *conn, struct l2cap_cmd_hdr
 		}
 
 	default:
-		sk->sk_err = ECONNRESET;
+		l2cap_set_sock_err(chan, ECONNRESET);
+
 		__set_chan_timer(chan,
 				msecs_to_jiffies(L2CAP_DISC_REJ_TIMEOUT));
 		l2cap_send_disconn_req(conn, chan, ECONNRESET);
@@ -3039,7 +3078,7 @@ static inline int l2cap_config_rsp(struct l2cap_conn *conn, struct l2cap_cmd_hdr
 	}
 
 done:
-	release_sock(sk);
+	l2cap_chan_unlock(chan);
 	return 0;
 }
 
@@ -3056,20 +3095,27 @@ static inline int l2cap_disconnect_req(struct l2cap_conn *conn, struct l2cap_cmd
 
 	BT_DBG("scid 0x%4.4x dcid 0x%4.4x", scid, dcid);
 
-	chan = l2cap_get_chan_by_scid(conn, dcid);
+	chan = __l2cap_get_chan_by_scid(conn, dcid);
 	if (!chan)
 		return 0;
 
+	mutex_lock(&conn->chan_lock);
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
+	mutex_unlock(&conn->chan_lock);
 
 	chan->ops->close(chan->data);
 	return 0;
@@ -3080,21 +3126,23 @@ static inline int l2cap_disconnect_rsp(struct l2cap_conn *conn, struct l2cap_cmd
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
 
-	sk = chan->sk;
+	mutex_lock(&conn->chan_lock);
+	l2cap_chan_lock(chan);
 
 	l2cap_chan_del(chan, 0);
-	release_sock(sk);
+
+	l2cap_chan_unlock(chan);
+	mutex_unlock(&conn->chan_lock);
 
 	chan->ops->close(chan->data);
 	return 0;
@@ -4243,18 +4291,17 @@ drop:
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
 
@@ -4325,8 +4372,7 @@ drop:
 	kfree_skb(skb);
 
 done:
-	if (sk)
-		release_sock(sk);
+	l2cap_chan_unlock(chan);
 
 	return 0;
 }
@@ -4542,12 +4588,10 @@ int l2cap_security_cfm(struct hci_conn *hcon, u8 status, u8 encrypt)
 		__cancel_delayed_work(&conn->security_timer);
 	}
 
-	rcu_read_lock();
-
-	list_for_each_entry_rcu(chan, &conn->chan_l, list) {
-		struct sock *sk = chan->sk;
+	mutex_lock(&conn->chan_lock);
 
-		bh_lock_sock(sk);
+	list_for_each_entry(chan, &conn->chan_l, list) {
+		l2cap_chan_lock(chan);
 
 		BT_DBG("chan->scid %d", chan->scid);
 
@@ -4557,19 +4601,19 @@ int l2cap_security_cfm(struct hci_conn *hcon, u8 status, u8 encrypt)
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
 
@@ -4590,9 +4634,12 @@ int l2cap_security_cfm(struct hci_conn *hcon, u8 status, u8 encrypt)
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
@@ -4601,18 +4648,20 @@ int l2cap_security_cfm(struct hci_conn *hcon, u8 status, u8 encrypt)
 					if (parent)
 						parent->sk_data_ready(parent, 0);
 				} else {
-					l2cap_state_change(chan, BT_CONFIG);
+					__l2cap_state_change(chan, BT_CONFIG);
 					res = L2CAP_CR_SUCCESS;
 					stat = L2CAP_CS_NO_INFO;
 				}
 			} else {
-				l2cap_state_change(chan, BT_DISCONN);
+				__l2cap_state_change(chan, BT_DISCONN);
 				__set_chan_timer(chan,
 					msecs_to_jiffies(L2CAP_DISC_TIMEOUT));
 				res = L2CAP_CR_SEC_BLOCK;
 				stat = L2CAP_CS_NO_INFO;
 			}
 
+			release_sock(sk);
+
 			rsp.scid   = cpu_to_le16(chan->dcid);
 			rsp.dcid   = cpu_to_le16(chan->scid);
 			rsp.result = cpu_to_le16(res);
@@ -4621,10 +4670,10 @@ int l2cap_security_cfm(struct hci_conn *hcon, u8 status, u8 encrypt)
 							sizeof(rsp), &rsp);
 		}
 
-		bh_unlock_sock(sk);
+		l2cap_chan_unlock(chan);
 	}
 
-	rcu_read_unlock();
+	mutex_unlock(&conn->chan_lock);
 
 	return 0;
 }
@@ -4681,10 +4730,11 @@ int l2cap_recv_acldata(struct hci_conn *hcon, struct sk_buff *skb, u16 flags)
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
1.7.4.1

