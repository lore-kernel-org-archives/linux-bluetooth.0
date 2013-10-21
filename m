Return-Path: <cyrus@holtmann.org>
From: Gustavo Padovan <gustavo@padovan.org>
To: linux-bluetooth@vger.kernel.org
Cc: Gustavo Padovan <gustavo.padovan@collabora.co.uk>
Subject: [PATCH -v2 3/5] Bluetooth: Hold socket in defer callback in L2CAP socket
Date: Mon, 21 Oct 2013 14:21:39 -0200
Message-Id: <1382372501-28562-3-git-send-email-gustavo@padovan.org>
In-Reply-To: <1382372501-28562-1-git-send-email-gustavo@padovan.org>
References: <1382372501-28562-1-git-send-email-gustavo@padovan.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Gustavo Padovan <gustavo.padovan@collabora.co.uk>

In both places that we use the defer callback the socket lock is held for
a indirect sk access inside __l2cap_change_state() and chan->ops->defer(),
all the rest of the code between lock_sock() and release_sock() is
already protected by the channel lock and won't be affected by this
change.

We now use l2cap_change_state(), the locked version of the change state
function, and the defer callback does the locking itself now. This does
not affect other uses of the defer callback.

Signed-off-by: Gustavo Padovan <gustavo.padovan@collabora.co.uk>
---
 net/bluetooth/l2cap_core.c | 15 +++------------
 net/bluetooth/l2cap_sock.c |  8 ++++++--
 2 files changed, 9 insertions(+), 14 deletions(-)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 4141545..049e1c8 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -1299,20 +1299,16 @@ static void l2cap_conn_start(struct l2cap_conn *conn)
 			rsp.dcid = cpu_to_le16(chan->scid);
 
 			if (l2cap_chan_check_security(chan)) {
-				struct sock *sk = chan->sk;
-
-				lock_sock(sk);
 				if (test_bit(FLAG_DEFER_SETUP, &chan->flags)) {
 					rsp.result = __constant_cpu_to_le16(L2CAP_CR_PEND);
 					rsp.status = __constant_cpu_to_le16(L2CAP_CS_AUTHOR_PEND);
 					chan->ops->defer(chan);
 
 				} else {
-					__l2cap_state_change(chan, BT_CONFIG);
+					l2cap_state_change(chan, BT_CONFIG);
 					rsp.result = __constant_cpu_to_le16(L2CAP_CR_SUCCESS);
 					rsp.status = __constant_cpu_to_le16(L2CAP_CS_NO_INFO);
 				}
-				release_sock(sk);
 			} else {
 				rsp.result = __constant_cpu_to_le16(L2CAP_CR_PEND);
 				rsp.status = __constant_cpu_to_le16(L2CAP_CS_AUTHEN_PEND);
@@ -6643,31 +6639,26 @@ int l2cap_security_cfm(struct hci_conn *hcon, u8 status, u8 encrypt)
 				__set_chan_timer(chan, L2CAP_DISC_TIMEOUT);
 			}
 		} else if (chan->state == BT_CONNECT2) {
-			struct sock *sk = chan->sk;
 			struct l2cap_conn_rsp rsp;
 			__u16 res, stat;
 
-			lock_sock(sk);
-
 			if (!status) {
 				if (test_bit(FLAG_DEFER_SETUP, &chan->flags)) {
 					res = L2CAP_CR_PEND;
 					stat = L2CAP_CS_AUTHOR_PEND;
 					chan->ops->defer(chan);
 				} else {
-					__l2cap_state_change(chan, BT_CONFIG);
+					l2cap_state_change(chan, BT_CONFIG);
 					res = L2CAP_CR_SUCCESS;
 					stat = L2CAP_CS_NO_INFO;
 				}
 			} else {
-				__l2cap_state_change(chan, BT_DISCONN);
+				l2cap_state_change(chan, BT_DISCONN);
 				__set_chan_timer(chan, L2CAP_DISC_TIMEOUT);
 				res = L2CAP_CR_SEC_BLOCK;
 				stat = L2CAP_CS_NO_INFO;
 			}
 
-			release_sock(sk);
-
 			rsp.scid   = cpu_to_le16(chan->dcid);
 			rsp.dcid   = cpu_to_le16(chan->scid);
 			rsp.result = cpu_to_le16(res);
diff --git a/net/bluetooth/l2cap_sock.c b/net/bluetooth/l2cap_sock.c
index a0b31db..e559992 100644
--- a/net/bluetooth/l2cap_sock.c
+++ b/net/bluetooth/l2cap_sock.c
@@ -1195,11 +1195,15 @@ static void l2cap_sock_ready_cb(struct l2cap_chan *chan)
 
 static void l2cap_sock_defer_cb(struct l2cap_chan *chan)
 {
-	struct sock *sk = chan->data;
-	struct sock *parent = bt_sk(sk)->parent;
+	struct sock *parent, *sk = chan->data;
+
+	lock_sock(sk);
 
+	parent = bt_sk(sk)->parent;
 	if (parent)
 		parent->sk_data_ready(parent, 0);
+
+	release_sock(sk);
 }
 
 static void l2cap_sock_resume_cb(struct l2cap_chan *chan)
-- 
1.8.3.1

