Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Introduce L2CAP channel flag for defer setup
Date: Mon, 14 Oct 2013 02:45:34 -0700
Message-Id: <1381743934-29348-1-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The L2CAP core should not look into the socket flags to figure out the
setting of defer setup. So introduce a L2CAP channel flag that mirrors
the socket flag.

Since the defer setup option is only set in one place this becomes a
really easy thing to do.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 include/net/bluetooth/l2cap.h |  1 +
 net/bluetooth/l2cap_core.c    | 15 +++++++--------
 net/bluetooth/l2cap_sock.c    |  7 +++++--
 3 files changed, 13 insertions(+), 10 deletions(-)

diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
index a27d51d..1a38ede 100644
--- a/include/net/bluetooth/l2cap.h
+++ b/include/net/bluetooth/l2cap.h
@@ -652,6 +652,7 @@ enum {
 	FLAG_FLUSHABLE,
 	FLAG_EXT_CTRL,
 	FLAG_EFS_ENABLE,
+	FLAG_DEFER_SETUP,
 };
 
 enum {
diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index f6b5f94..e5819cb 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -655,14 +655,14 @@ void l2cap_chan_close(struct l2cap_chan *chan, int reason)
 	case BT_CONNECT2:
 		if (chan->chan_type == L2CAP_CHAN_CONN_ORIENTED &&
 		    conn->hcon->type == ACL_LINK) {
-			struct sock *sk = chan->sk;
 			struct l2cap_conn_rsp rsp;
 			__u16 result;
 
-			if (test_bit(BT_SK_DEFER_SETUP, &bt_sk(sk)->flags))
+			if (test_bit(FLAG_DEFER_SETUP, &chan->flags))
 				result = L2CAP_CR_SEC_BLOCK;
 			else
 				result = L2CAP_CR_BAD_PSM;
+
 			l2cap_state_change(chan, BT_DISCONN);
 
 			rsp.scid   = cpu_to_le16(chan->dcid);
@@ -1294,16 +1294,16 @@ static void l2cap_conn_start(struct l2cap_conn *conn)
 			l2cap_start_connection(chan);
 
 		} else if (chan->state == BT_CONNECT2) {
-			struct sock *sk = chan->sk;
 			struct l2cap_conn_rsp rsp;
 			char buf[128];
 			rsp.scid = cpu_to_le16(chan->dcid);
 			rsp.dcid = cpu_to_le16(chan->scid);
 
 			if (l2cap_chan_check_security(chan)) {
+				struct sock *sk = chan->sk;
+
 				lock_sock(sk);
-				if (test_bit(BT_SK_DEFER_SETUP,
-					     &bt_sk(sk)->flags)) {
+				if (test_bit(FLAG_DEFER_SETUP, &chan->flags)) {
 					rsp.result = __constant_cpu_to_le16(L2CAP_CR_PEND);
 					rsp.status = __constant_cpu_to_le16(L2CAP_CS_AUTHOR_PEND);
 					chan->ops->defer(chan);
@@ -3823,7 +3823,7 @@ static struct l2cap_chan *l2cap_connect(struct l2cap_conn *conn,
 
 	if (conn->info_state & L2CAP_INFO_FEAT_MASK_REQ_DONE) {
 		if (l2cap_chan_check_security(chan)) {
-			if (test_bit(BT_SK_DEFER_SETUP, &bt_sk(sk)->flags)) {
+			if (test_bit(FLAG_DEFER_SETUP, &chan->flags)) {
 				__l2cap_state_change(chan, BT_CONNECT2);
 				result = L2CAP_CR_PEND;
 				status = L2CAP_CS_AUTHOR_PEND;
@@ -6693,8 +6693,7 @@ int l2cap_security_cfm(struct hci_conn *hcon, u8 status, u8 encrypt)
 			lock_sock(sk);
 
 			if (!status) {
-				if (test_bit(BT_SK_DEFER_SETUP,
-					     &bt_sk(sk)->flags)) {
+				if (test_bit(FLAG_DEFER_SETUP, &chan->flags)) {
 					res = L2CAP_CR_PEND;
 					stat = L2CAP_CS_AUTHOR_PEND;
 					chan->ops->defer(chan);
diff --git a/net/bluetooth/l2cap_sock.c b/net/bluetooth/l2cap_sock.c
index f1b462f..f5d9573 100644
--- a/net/bluetooth/l2cap_sock.c
+++ b/net/bluetooth/l2cap_sock.c
@@ -672,10 +672,13 @@ static int l2cap_sock_setsockopt(struct socket *sock, int level, int optname,
 			break;
 		}
 
-		if (opt)
+		if (opt) {
 			set_bit(BT_SK_DEFER_SETUP, &bt_sk(sk)->flags);
-		else
+			set_bit(FLAG_DEFER_SETUP, &chan->flags);
+		} else {
 			clear_bit(BT_SK_DEFER_SETUP, &bt_sk(sk)->flags);
+			clear_bit(FLAG_DEFER_SETUP, &chan->flags);
+		}
 		break;
 
 	case BT_FLUSHABLE:
-- 
1.8.3.1

