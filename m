Return-Path: <cyrus@holtmann.org>
From: Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFCv2 09/10] Bluetooth: Use l2cap chan lock in socket connect
Date: Fri,  3 Feb 2012 16:36:28 +0200
Message-Id: <1328279789-10870-10-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1328279789-10870-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1328279789-10870-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>


Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
---
 net/bluetooth/l2cap_core.c |   26 ++++++++++++++++++++------
 net/bluetooth/l2cap_sock.c |    2 ++
 2 files changed, 22 insertions(+), 6 deletions(-)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index d70d0f5..4e9de8c 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -1185,7 +1185,7 @@ int l2cap_chan_connect(struct l2cap_chan *chan, __le16 psm, u16 cid, bdaddr_t *d
 
 	hci_dev_lock(hdev);
 
-	lock_sock(sk);
+	l2cap_chan_lock(chan);
 
 	/* PSM must be odd and lsb of upper byte must be 0 */
 	if ((__le16_to_cpu(psm) & 0x0101) != 0x0001 && !cid &&
@@ -1212,18 +1212,20 @@ int l2cap_chan_connect(struct l2cap_chan *chan, __le16 psm, u16 cid, bdaddr_t *d
 		goto done;
 	}
 
+	lock_sock(sk);
+
 	switch (sk->sk_state) {
 	case BT_CONNECT:
 	case BT_CONNECT2:
 	case BT_CONFIG:
 		/* Already connecting */
 		err = 0;
-		goto done;
+		goto sock_release;
 
 	case BT_CONNECTED:
 		/* Already connected */
 		err = -EISCONN;
-		goto done;
+		goto sock_release;
 
 	case BT_OPEN:
 	case BT_BOUND:
@@ -1232,11 +1234,14 @@ int l2cap_chan_connect(struct l2cap_chan *chan, __le16 psm, u16 cid, bdaddr_t *d
 
 	default:
 		err = -EBADFD;
-		goto done;
+		goto sock_release;
 	}
 
 	/* Set destination address and psm */
 	bacpy(&bt_sk(sk)->dst, dst);
+
+	release_sock(sk);
+
 	chan->psm = psm;
 	chan->dcid = cid;
 
@@ -1264,23 +1269,30 @@ int l2cap_chan_connect(struct l2cap_chan *chan, __le16 psm, u16 cid, bdaddr_t *d
 	/* Update source addr of the socket */
 	bacpy(src, conn->src);
 
+	l2cap_chan_unlock(chan);
 	l2cap_chan_add(conn, chan);
+	l2cap_chan_lock(chan);
 
-	__l2cap_state_change(chan, BT_CONNECT);
+	l2cap_state_change(chan, BT_CONNECT);
 	__set_chan_timer(chan, sk->sk_sndtimeo);
 
 	if (hcon->state == BT_CONNECTED) {
 		if (chan->chan_type != L2CAP_CHAN_CONN_ORIENTED) {
 			__clear_chan_timer(chan);
 			if (l2cap_chan_check_security(chan))
-				__l2cap_state_change(chan, BT_CONNECTED);
+				l2cap_state_change(chan, BT_CONNECTED);
 		} else
 			l2cap_do_start(chan);
 	}
 
 	err = 0;
+	goto done;
+
+sock_release:
+	release_sock(sk);
 
 done:
+	l2cap_chan_unlock(chan);
 	hci_dev_unlock(hdev);
 	hci_dev_put(hdev);
 	return err;
@@ -2707,7 +2719,9 @@ static inline int l2cap_connect_req(struct l2cap_conn *conn, struct l2cap_cmd_hd
 
 	bt_accept_enqueue(parent, sk);
 
+	release_sock(parent);
 	l2cap_chan_add(conn, chan);
+	lock_sock(parent);
 
 	dcid = chan->scid;
 
diff --git a/net/bluetooth/l2cap_sock.c b/net/bluetooth/l2cap_sock.c
index dea5418..ddac4cb 100644
--- a/net/bluetooth/l2cap_sock.c
+++ b/net/bluetooth/l2cap_sock.c
@@ -127,6 +127,8 @@ static int l2cap_sock_connect(struct socket *sock, struct sockaddr *addr, int al
 	if (err)
 		goto done;
 
+	lock_sock(sk);
+
 	err = bt_sock_wait_state(sk, BT_CONNECTED,
 			sock_sndtimeo(sk, flags & O_NONBLOCK));
 done:
-- 
1.7.8.3

