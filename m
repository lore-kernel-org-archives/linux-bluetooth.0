Return-Path: <cyrus@holtmann.org>
From: Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFCv0 19/20] Bluetooth: A2MP: handling fixed channel
Date: Wed,  2 Nov 2011 16:02:47 +0200
Message-Id: <1320242568-372-20-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1320242568-372-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1320242568-372-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

A2MP fixed channel is handled differently from normal L2CAP channel.
There is no connect and config req/rsp sequence.

Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
---
 include/net/bluetooth/l2cap.h |    1 +
 net/bluetooth/a2mp.c          |    2 +
 net/bluetooth/l2cap_core.c    |   61 +++++++++++++++++++++++++++++-----------
 3 files changed, 47 insertions(+), 17 deletions(-)

diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
index cc3b81f..473976e 100644
--- a/include/net/bluetooth/l2cap.h
+++ b/include/net/bluetooth/l2cap.h
@@ -559,6 +559,7 @@ enum {
 	FLAG_FLUSHABLE,
 	FLAG_EXT_CTRL,
 	FLAG_EFS_ENABLE,
+	FLAG_FIXED_CHANNEL,
 };
 
 #define __set_chan_timer(c, t) l2cap_set_timer(c, &c->chan_timer, (t))
diff --git a/net/bluetooth/a2mp.c b/net/bluetooth/a2mp.c
index 4414d74..b4d3a13 100644
--- a/net/bluetooth/a2mp.c
+++ b/net/bluetooth/a2mp.c
@@ -451,6 +451,8 @@ static void l2cap_fixed_channel_config(struct sock *sk)
 
 	lock_sock(sk);
 
+	set_bit(FLAG_FIXED_CHANNEL, &chan->flags);
+
 	chan->omtu = L2CAP_A2MP_DEFAULT_MTU;
 	chan->imtu = L2CAP_A2MP_DEFAULT_MTU;
 	chan->flush_to = L2CAP_DEFAULT_FLUSH_TO;
diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 8b930ca..3dd80a5 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -316,6 +316,10 @@ static void __l2cap_chan_add(struct l2cap_conn *conn, struct l2cap_chan *chan)
 
 	chan->conn = conn;
 
+	/* Fixed channel setup is already done */
+	if (test_bit(FLAG_FIXED_CHANNEL, &chan->flags))
+		goto fixed_chan;
+
 	if (chan->chan_type == L2CAP_CHAN_CONN_ORIENTED) {
 		if (conn->hcon->type == LE_LINK) {
 			/* LE connection */
@@ -339,6 +343,8 @@ static void __l2cap_chan_add(struct l2cap_conn *conn, struct l2cap_chan *chan)
 		chan->omtu = L2CAP_DEFAULT_MTU;
 	}
 
+fixed_chan:
+
 	chan->local_id		= L2CAP_BESTEFFORT_ID;
 	chan->local_stype	= L2CAP_SERV_BESTEFFORT;
 	chan->local_msdu	= L2CAP_DEFAULT_MAX_SDU_SIZE;
@@ -371,7 +377,8 @@ static void l2cap_chan_del(struct l2cap_chan *chan, int err)
 		chan_put(chan);
 
 		chan->conn = NULL;
-		hci_conn_put(conn->hcon);
+		if (!test_bit(FLAG_FIXED_CHANNEL, &chan->flags))
+			hci_conn_put(conn->hcon);
 	}
 
 	l2cap_state_change(chan, BT_CLOSED);
@@ -387,7 +394,8 @@ static void l2cap_chan_del(struct l2cap_chan *chan, int err)
 		sk->sk_state_change(sk);
 
 	if (!(test_bit(CONF_OUTPUT_DONE, &chan->conf_state) &&
-			test_bit(CONF_INPUT_DONE, &chan->conf_state)))
+			test_bit(CONF_INPUT_DONE, &chan->conf_state)) &&
+			!test_bit(FLAG_FIXED_CHANNEL, &chan->flags))
 		return;
 
 	skb_queue_purge(&chan->tx_q);
@@ -1128,23 +1136,34 @@ int l2cap_chan_connect(struct l2cap_chan *chan)
 
 	auth_type = l2cap_get_auth_type(chan);
 
-	if (chan->dcid == L2CAP_CID_LE_DATA)
-		hcon = hci_connect(hdev, LE_LINK, dst,
-					chan->sec_level, auth_type);
-	else
-		hcon = hci_connect(hdev, ACL_LINK, dst,
-					chan->sec_level, auth_type);
+	if (test_bit(FLAG_FIXED_CHANNEL, &chan->flags)) {
+		/* Fixed channels piggyback on existing ACL connections */
+		hcon = hci_conn_hash_lookup_ba(hdev, ACL_LINK, dst);
+		if (!hcon || !hcon->l2cap_data) {
+			err = -ENOTCONN;
+			goto done;
+		}
 
-	if (IS_ERR(hcon)) {
-		err = PTR_ERR(hcon);
-		goto done;
-	}
+		conn = hcon->l2cap_data;
+	} else {
+		if (chan->dcid == L2CAP_CID_LE_DATA)
+			hcon = hci_connect(hdev, LE_LINK, dst,
+						chan->sec_level, auth_type);
+		else
+			hcon = hci_connect(hdev, ACL_LINK, dst,
+						chan->sec_level, auth_type);
 
-	conn = l2cap_conn_add(hcon, 0);
-	if (!conn) {
-		hci_conn_put(hcon);
-		err = -ENOMEM;
-		goto done;
+		if (IS_ERR(hcon)) {
+			err = PTR_ERR(hcon);
+			goto done;
+		}
+
+		conn = l2cap_conn_add(hcon, 0);
+		if (!conn) {
+			hci_conn_put(hcon);
+			err = -ENOMEM;
+			goto done;
+		}
 	}
 
 	/* Update source addr of the socket */
@@ -1152,6 +1171,14 @@ int l2cap_chan_connect(struct l2cap_chan *chan)
 
 	l2cap_chan_add(conn, chan);
 
+	if (test_bit(FLAG_FIXED_CHANNEL, &chan->flags)) {
+		l2cap_state_change(chan, BT_CONNECTED);
+		sk->sk_state = BT_CONNECTED;
+		sk->sk_state_change(sk);
+		err = 0;
+		goto done;
+	}
+
 	l2cap_state_change(chan, BT_CONNECT);
 	__set_chan_timer(chan, sk->sk_sndtimeo);
 
-- 
1.7.4.1

