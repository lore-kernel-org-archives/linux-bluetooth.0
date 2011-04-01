Return-Path: <cyrus@holtmann.org>
From: "Gustavo F. Padovan" <padovan@profusion.mobi>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 03/15] Bluetooth: Remove struct del_list
Date: Fri,  1 Apr 2011 19:33:08 -0300
Message-Id: <1301697200-2446-4-git-send-email-padovan@profusion.mobi>
In-Reply-To: <1301697200-2446-3-git-send-email-padovan@profusion.mobi>
References: <1301697200-2446-1-git-send-email-padovan@profusion.mobi>
 <1301697200-2446-2-git-send-email-padovan@profusion.mobi>
 <1301697200-2446-3-git-send-email-padovan@profusion.mobi>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

As we use struct list_head to keep L2CAP channels list the workaround with
del_list is not needed anymore.

Signed-off-by: Gustavo F. Padovan <padovan@profusion.mobi>
---
 include/net/bluetooth/l2cap.h |    5 -----
 net/bluetooth/l2cap_core.c    |   24 +++++++-----------------
 2 files changed, 7 insertions(+), 22 deletions(-)

diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
index ddf4bc5..d24b51c 100644
--- a/include/net/bluetooth/l2cap.h
+++ b/include/net/bluetooth/l2cap.h
@@ -309,11 +309,6 @@ struct l2cap_conn {
 	rwlock_t	chan_lock;
 };
 
-struct sock_del_list {
-	struct sock *sk;
-	struct list_head list;
-};
-
 #define L2CAP_INFO_CL_MTU_REQ_SENT	0x01
 #define L2CAP_INFO_FEAT_MASK_REQ_SENT	0x04
 #define L2CAP_INFO_FEAT_MASK_REQ_DONE	0x08
diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index ce68896..3047c47 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -487,16 +487,13 @@ void l2cap_send_disconn_req(struct l2cap_conn *conn, struct sock *sk, int err)
 /* ---- L2CAP connections ---- */
 static void l2cap_conn_start(struct l2cap_conn *conn)
 {
-	struct sock_del_list del, *tmp1, *tmp2;
-	struct l2cap_chan *chan;
+	struct l2cap_chan *chan, *tmp;
 
 	BT_DBG("conn %p", conn);
 
-	INIT_LIST_HEAD(&del.list);
-
 	read_lock(&conn->chan_lock);
 
-	list_for_each_entry(chan, &conn->chan_l, list) {
+	list_for_each_entry_safe(chan, tmp, &conn->chan_l, list) {
 		struct sock *sk = chan->sk;
 
 		bh_lock_sock(sk);
@@ -520,10 +517,11 @@ static void l2cap_conn_start(struct l2cap_conn *conn)
 					conn->feat_mask)
 					&& l2cap_pi(sk)->conf_state &
 					L2CAP_CONF_STATE2_DEVICE) {
-				tmp1 = kzalloc(sizeof(struct sock_del_list),
-						GFP_ATOMIC);
-				tmp1->sk = sk;
-				list_add_tail(&tmp1->list, &del.list);
+				/* __l2cap_sock_close() calls list_del(chan)
+				 * so release the lock */
+				read_unlock_bh(&conn->chan_lock);
+				 __l2cap_sock_close(sk, ECONNRESET);
+				read_lock_bh(&conn->chan_lock);
 				bh_unlock_sock(sk);
 				continue;
 			}
@@ -579,14 +577,6 @@ static void l2cap_conn_start(struct l2cap_conn *conn)
 	}
 
 	read_unlock(&conn->chan_lock);
-
-	list_for_each_entry_safe(tmp1, tmp2, &del.list, list) {
-		bh_lock_sock(tmp1->sk);
-		__l2cap_sock_close(tmp1->sk, ECONNRESET);
-		bh_unlock_sock(tmp1->sk);
-		list_del(&tmp1->list);
-		kfree(tmp1);
-	}
 }
 
 /* Find socket with cid and source bdaddr.
-- 
1.7.4.1

