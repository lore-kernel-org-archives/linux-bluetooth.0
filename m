Return-Path: <cyrus@holtmann.org>
From: Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFCv4 00/16] Bluetooth: Change socket lock to l2cap_chan lock
Date: Fri, 10 Feb 2012 15:54:57 +0200
Message-Id: <1328882113-19810-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

This set is still WIP, hope to send PATCH series next week.

Those small patches which dealing with locks need to be applied at once,
if needed they can be merged together. Please voice opinion about the split.

Changes:
	* RFCv4: Better split patches so they looks more clear and obvious,
	taking coments about naming change and delete unused vars. See diff change
	from the previous version below:
	* RFCv3: Split the big patch to several small (I believe logical) chunks,
	remove unneded locks from cleanup_listen, use the same arguments for
	locked/unlocked socket error functions.
	* RFCv2: Convert l2cap channel list back to mutex from RCU list.

This is DRAFT RFC introducing l2cap channel lock. Please make suggestion how to
make it better.

Andrei Emeltchenko (16):
  Bluetooth: trivial: Fix long line
  Bluetooth: Revert to mutexes from RCU list
  Bluetooth: Do not use sk lock in get_chan functions
  Bluetooth: Add l2cap_chan_lock
  Bluetooth: Add locked and unlocked state_change
  Bluetooth: Add socket error function
  Bluetooth: Add unlocked __l2cap_chan_add function
  Bluetooth: Use chan lock in timers
  Bluetooth: Use chan lock in L2CAP sig commands
  Bluetooth: Use chan lock in chan delete functions
  Bluetooth: Use chan lock in L2CAP conn start
  Bluetooth: Use chan lock in receiving data
  Bluetooth: Change locking logic for conn/chan ready
  Bluetooth: Change locking logic in security_cfm
  Bluetooth: Use l2cap chan lock in socket connect
  Bluetooth: Remove socket lock check

 include/net/bluetooth/l2cap.h |   11 ++
 net/bluetooth/l2cap_core.c    |  386 +++++++++++++++++++++++++----------------
 net/bluetooth/l2cap_sock.c    |   23 ++-
 3 files changed, 264 insertions(+), 156 deletions(-)

Cumulutive change from RFCv3->RFCv4

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 9d03c46..bb0d9f7 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -244,19 +244,19 @@ static void l2cap_state_change(struct l2cap_chan *chan, int state)
 	release_sock(sk);
 }
 
-static inline void __l2cap_set_sock_err(struct l2cap_chan *chan, int err)
+static inline void __l2cap_chan_set_err(struct l2cap_chan *chan, int err)
 {
 	struct sock *sk = chan->sk;
 
 	sk->sk_err = err;
 }
 
-static inline void l2cap_set_sock_err(struct l2cap_chan *chan, int err)
+static inline void l2cap_chan_set_err(struct l2cap_chan *chan, int err)
 {
 	struct sock *sk = chan->sk;
 
 	lock_sock(sk);
-	__l2cap_set_sock_err(chan, err);
+	__l2cap_chan_set_err(chan, err);
 	release_sock(sk);
 }
 
@@ -264,11 +264,13 @@ static void l2cap_chan_timeout(struct work_struct *work)
 {
 	struct l2cap_chan *chan = container_of(work, struct l2cap_chan,
 							chan_timer.work);
+	struct l2cap_conn *conn = chan->conn;
+
 	int reason;
 
 	BT_DBG("chan %p state %d", chan, chan->state);
 
-	mutex_lock(&chan->conn->chan_lock);
+	mutex_lock(&conn->chan_lock);
 	l2cap_chan_lock(chan);
 
 	if (chan->state == BT_CONNECTED || chan->state == BT_CONFIG)
@@ -282,7 +284,7 @@ static void l2cap_chan_timeout(struct work_struct *work)
 	l2cap_chan_close(chan, reason);
 
 	l2cap_chan_unlock(chan);
-	mutex_unlock(&chan->conn->chan_lock);
+	mutex_unlock(&conn->chan_lock);
 
 	chan->ops->close(chan->data);
 	l2cap_chan_put(chan);
@@ -420,7 +422,7 @@ static void l2cap_chan_del(struct l2cap_chan *chan, int err)
 	sock_set_flag(sk, SOCK_ZAPPED);
 
 	if (err)
-		__l2cap_set_sock_err(chan, err);
+		__l2cap_chan_set_err(chan, err);
 
 	if (parent) {
 		bt_accept_unlink(sk);
@@ -778,7 +780,7 @@ static void l2cap_send_disconn_req(struct l2cap_conn *conn, struct l2cap_chan *c
 
 	lock_sock(sk);
 	__l2cap_state_change(chan, BT_DISCONN);
-	__l2cap_set_sock_err(chan, err);
+	__l2cap_chan_set_err(chan, err);
 	release_sock(sk);
 }
 
@@ -1027,7 +1029,7 @@ static void l2cap_conn_unreliable(struct l2cap_conn *conn, int err)
 
 	list_for_each_entry(chan, &conn->chan_l, list) {
 		if (test_bit(FLAG_FORCE_RELIABLE, &chan->flags))
-			l2cap_set_sock_err(chan, err);
+			l2cap_chan_set_err(chan, err);
 	}
 
 	mutex_unlock(&conn->chan_lock);
@@ -1231,12 +1233,14 @@ int l2cap_chan_connect(struct l2cap_chan *chan, __le16 psm, u16 cid, bdaddr_t *d
 	case BT_CONFIG:
 		/* Already connecting */
 		err = 0;
-		goto sock_release;
+		release_sock(sk);
+		goto done;
 
 	case BT_CONNECTED:
 		/* Already connected */
 		err = -EISCONN;
-		goto sock_release;
+		release_sock(sk);
+		goto done;
 
 	case BT_OPEN:
 	case BT_BOUND:
@@ -1245,7 +1249,8 @@ int l2cap_chan_connect(struct l2cap_chan *chan, __le16 psm, u16 cid, bdaddr_t *d
 
 	default:
 		err = -EBADFD;
-		goto sock_release;
+		release_sock(sk);
+		goto done;
 	}
 
 	/* Set destination address and psm */
@@ -1297,11 +1302,6 @@ int l2cap_chan_connect(struct l2cap_chan *chan, __le16 psm, u16 cid, bdaddr_t *d
 	}
 
 	err = 0;
-	goto done;
-
-sock_release:
-	release_sock(sk);
-
 done:
 	l2cap_chan_unlock(chan);
 	hci_dev_unlock(hdev);
@@ -2886,7 +2886,6 @@ static inline int l2cap_config_req(struct l2cap_conn *conn, struct l2cap_cmd_hdr
 	u16 dcid, flags;
 	u8 rsp[64];
 	struct l2cap_chan *chan;
-	struct sock *sk;
 	int len;
 
 	dcid  = __le16_to_cpu(req->dcid);
@@ -2900,8 +2899,6 @@ static inline int l2cap_config_req(struct l2cap_conn *conn, struct l2cap_cmd_hdr
 
 	l2cap_chan_lock(chan);
 
-	sk = chan->sk;
-
 	if (chan->state != BT_CONFIG && chan->state != BT_CONNECT2) {
 		struct l2cap_cmd_rej_cid rej;
 
@@ -2998,7 +2995,6 @@ static inline int l2cap_config_rsp(struct l2cap_conn *conn, struct l2cap_cmd_hdr
 	struct l2cap_conf_rsp *rsp = (struct l2cap_conf_rsp *)data;
 	u16 scid, flags, result;
 	struct l2cap_chan *chan;
-	struct sock *sk;
 	int len = cmd->len - sizeof(*rsp);
 
 	scid   = __le16_to_cpu(rsp->scid);
@@ -3014,8 +3010,6 @@ static inline int l2cap_config_rsp(struct l2cap_conn *conn, struct l2cap_cmd_hdr
 
 	l2cap_chan_lock(chan);
 
-	sk = chan->sk;
-
 	switch (result) {
 	case L2CAP_CONF_SUCCESS:
 		l2cap_conf_rfc_get(chan, rsp->data, len);
@@ -3073,7 +3067,7 @@ static inline int l2cap_config_rsp(struct l2cap_conn *conn, struct l2cap_cmd_hdr
 		}
 
 	default:
-		l2cap_set_sock_err(chan, ECONNRESET);
+		l2cap_chan_set_err(chan, ECONNRESET);
 
 		__set_chan_timer(chan,
 				msecs_to_jiffies(L2CAP_DISC_REJ_TIMEOUT));

-- 
1.7.8.3

