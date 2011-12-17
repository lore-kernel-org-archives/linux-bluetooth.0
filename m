Return-Path: <cyrus@holtmann.org>
From: "Gustavo F. Padovan" <padovan@profusion.mobi>
To: linux-bluetooth@vger.kernel.org
Cc: "Gustavo F. Padovan" <padovan@profusion.mobi>
Subject: [RFC 18/22] Bluetooth: invert locking order in connect path
Date: Sat, 17 Dec 2011 19:29:38 -0200
Message-Id: <1324157382-1815-19-git-send-email-padovan@profusion.mobi>
In-Reply-To: <1324157382-1815-18-git-send-email-padovan@profusion.mobi>
References: <1324157382-1815-1-git-send-email-padovan@profusion.mobi>
 <1324157382-1815-2-git-send-email-padovan@profusion.mobi>
 <1324157382-1815-3-git-send-email-padovan@profusion.mobi>
 <1324157382-1815-4-git-send-email-padovan@profusion.mobi>
 <1324157382-1815-5-git-send-email-padovan@profusion.mobi>
 <1324157382-1815-6-git-send-email-padovan@profusion.mobi>
 <1324157382-1815-7-git-send-email-padovan@profusion.mobi>
 <1324157382-1815-8-git-send-email-padovan@profusion.mobi>
 <1324157382-1815-9-git-send-email-padovan@profusion.mobi>
 <1324157382-1815-10-git-send-email-padovan@profusion.mobi>
 <1324157382-1815-11-git-send-email-padovan@profusion.mobi>
 <1324157382-1815-12-git-send-email-padovan@profusion.mobi>
 <1324157382-1815-13-git-send-email-padovan@profusion.mobi>
 <1324157382-1815-14-git-send-email-padovan@profusion.mobi>
 <1324157382-1815-15-git-send-email-padovan@profusion.mobi>
 <1324157382-1815-16-git-send-email-padovan@profusion.mobi>
 <1324157382-1815-17-git-send-email-padovan@profusion.mobi>
 <1324157382-1815-18-git-send-email-padovan@profusion.mobi>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: "Gustavo F. Padovan" <padovan@profusion.mobi>

This move some checking code that was in l2cap_sock_connect() to
l2cap_chan_connect(). Thus we can invert the lock calls, i.e., call
lock_sock() before hci_dev_lock() to avoid a deadlock scenario.

Signed-off-by: Gustavo F. Padovan <padovan@profusion.mobi>
---
 include/net/bluetooth/l2cap.h |    3 +-
 net/bluetooth/l2cap_core.c    |   58 +++++++++++++++++++++++++++++++++++++-
 net/bluetooth/l2cap_sock.c    |   61 ++---------------------------------------
 3 files changed, 61 insertions(+), 61 deletions(-)

diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
index f791374..c0d168a 100644
--- a/include/net/bluetooth/l2cap.h
+++ b/include/net/bluetooth/l2cap.h
@@ -806,7 +806,8 @@ int l2cap_add_scid(struct l2cap_chan *chan,  __u16 scid);
 struct l2cap_chan *l2cap_chan_create(struct sock *sk);
 void l2cap_chan_close(struct l2cap_chan *chan, int reason);
 void l2cap_chan_destroy(struct l2cap_chan *chan);
-int l2cap_chan_connect(struct l2cap_chan *chan);
+inline int l2cap_chan_connect(struct l2cap_chan *chan, __le16 psm, u16 cid,
+								bdaddr_t *dst);
 int l2cap_chan_send(struct l2cap_chan *chan, struct msghdr *msg, size_t len,
 								u32 priority);
 void l2cap_chan_busy(struct l2cap_chan *chan, int busy);
diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index a78cdf7..d616519 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -1144,11 +1144,10 @@ static struct l2cap_chan *l2cap_global_chan_by_psm(int state, __le16 psm, bdaddr
 	return c1;
 }
 
-int l2cap_chan_connect(struct l2cap_chan *chan)
+inline int l2cap_chan_connect(struct l2cap_chan *chan, __le16 psm, u16 cid, bdaddr_t *dst)
 {
 	struct sock *sk = chan->sk;
 	bdaddr_t *src = &bt_sk(sk)->src;
-	bdaddr_t *dst = &bt_sk(sk)->dst;
 	struct l2cap_conn *conn;
 	struct hci_conn *hcon;
 	struct hci_dev *hdev;
@@ -1164,6 +1163,61 @@ int l2cap_chan_connect(struct l2cap_chan *chan)
 
 	hci_dev_lock(hdev);
 
+	lock_sock(sk);
+
+	/* PSM must be odd and lsb of upper byte must be 0 */
+	if ((__le16_to_cpu(psm) & 0x0101) != 0x0001 && !cid &&
+					chan->chan_type != L2CAP_CHAN_RAW) {
+		err = -EINVAL;
+		goto done;
+	}
+
+	if (chan->chan_type == L2CAP_CHAN_CONN_ORIENTED && !(psm || cid)) {
+		err = -EINVAL;
+		goto done;
+	}
+
+	switch (chan->mode) {
+	case L2CAP_MODE_BASIC:
+		break;
+	case L2CAP_MODE_ERTM:
+	case L2CAP_MODE_STREAMING:
+		if (!disable_ertm)
+			break;
+		/* fall through */
+	default:
+		err = -ENOTSUPP;
+		goto done;
+	}
+
+	switch (sk->sk_state) {
+	case BT_CONNECT:
+	case BT_CONNECT2:
+	case BT_CONFIG:
+		/* Already connecting */
+		err = 0;
+		goto done;
+
+	case BT_CONNECTED:
+		/* Already connected */
+		err = -EISCONN;
+		goto done;
+
+	case BT_OPEN:
+	case BT_BOUND:
+		/* Can connect */
+		break;
+
+	default:
+		err = -EBADFD;
+		goto done;
+	}
+
+	/* Set destination address and psm */
+	bacpy(&bt_sk(sk)->dst, src);
+	chan->psm = psm;
+	chan->dcid = cid;
+
 	auth_type = l2cap_get_auth_type(chan);
 
 	if (chan->dcid == L2CAP_CID_LE_DATA)
diff --git a/net/bluetooth/l2cap_sock.c b/net/bluetooth/l2cap_sock.c
index fbdc8b3..6c7d432 100644
--- a/net/bluetooth/l2cap_sock.c
+++ b/net/bluetooth/l2cap_sock.c
@@ -121,70 +121,15 @@ static int l2cap_sock_connect(struct socket *sock, struct sockaddr *addr, int al
 	if (la.l2_cid && la.l2_psm)
 		return -EINVAL;
 
-	lock_sock(sk);
-
-	if (chan->chan_type == L2CAP_CHAN_CONN_ORIENTED
-			&& !(la.l2_psm || la.l2_cid)) {
-		err = -EINVAL;
-		goto done;
-	}
-
-	switch (chan->mode) {
-	case L2CAP_MODE_BASIC:
-		break;
-	case L2CAP_MODE_ERTM:
-	case L2CAP_MODE_STREAMING:
-		if (!disable_ertm)
-			break;
-		/* fall through */
-	default:
-		err = -ENOTSUPP;
-		goto done;
-	}
-
-	switch (sk->sk_state) {
-	case BT_CONNECT:
-	case BT_CONNECT2:
-	case BT_CONFIG:
-		/* Already connecting */
-		goto wait;
-
-	case BT_CONNECTED:
-		/* Already connected */
-		err = -EISCONN;
-		goto done;
-
-	case BT_OPEN:
-	case BT_BOUND:
-		/* Can connect */
-		break;
-
-	default:
-		err = -EBADFD;
-		goto done;
-	}
-
-	/* PSM must be odd and lsb of upper byte must be 0 */
-	if ((__le16_to_cpu(la.l2_psm) & 0x0101) != 0x0001 && !la.l2_cid &&
-					chan->chan_type != L2CAP_CHAN_RAW) {
-		err = -EINVAL;
-		goto done;
-	}
-
-	/* Set destination address and psm */
-	bacpy(&bt_sk(sk)->dst, &la.l2_bdaddr);
-	chan->psm = la.l2_psm;
-	chan->dcid = la.l2_cid;
-
-	err = l2cap_chan_connect(chan);
+	err = l2cap_chan_connect(chan, la.l2_psm, la.l2_cid, &la.l2_bdaddr);
 	if (err)
 		goto done;
 
-wait:
 	err = bt_sock_wait_state(sk, BT_CONNECTED,
 			sock_sndtimeo(sk, flags & O_NONBLOCK));
 done:
-	release_sock(sk);
+	if (sock_owned_by_user(sk))
+		release_sock(sk);
 	return err;
 }
 
-- 
1.7.6.4

