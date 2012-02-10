Return-Path: <cyrus@holtmann.org>
From: Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFCv4 11/16] Bluetooth: Use chan lock in L2CAP conn start
Date: Fri, 10 Feb 2012 15:55:08 +0200
Message-Id: <1328882113-19810-12-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1328882113-19810-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1328882113-19810-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Change sk lock to chan lock in l2cap_conn_start. bh_locks were used
because of being RCU critical section.

Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
---
 net/bluetooth/l2cap_core.c |   16 ++++++++--------
 1 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 9ea7758..cb4a96d 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -782,10 +782,10 @@ static void l2cap_conn_start(struct l2cap_conn *conn)
 	list_for_each_entry_safe(chan, tmp, &conn->chan_l, list) {
 		struct sock *sk = chan->sk;
 
-		bh_lock_sock(sk);
+		l2cap_chan_lock(chan);
 
 		if (chan->chan_type != L2CAP_CHAN_CONN_ORIENTED) {
-			bh_unlock_sock(sk);
+			l2cap_chan_unlock(chan);
 			continue;
 		}
 
@@ -794,17 +794,15 @@ static void l2cap_conn_start(struct l2cap_conn *conn)
 
 			if (!l2cap_chan_check_security(chan) ||
 					!__l2cap_no_conn_pending(chan)) {
-				bh_unlock_sock(sk);
+				l2cap_chan_unlock(chan);
 				continue;
 			}
 
 			if (!l2cap_mode_supported(chan->mode, conn->feat_mask)
 					&& test_bit(CONF_STATE2_DEVICE,
 					&chan->conf_state)) {
-				/* l2cap_chan_close() calls list_del(chan)
-				 * so release the lock */
 				l2cap_chan_close(chan, ECONNRESET);
-				bh_unlock_sock(sk);
+				l2cap_chan_unlock(chan);
 				continue;
 			}
 
@@ -824,6 +822,7 @@ static void l2cap_conn_start(struct l2cap_conn *conn)
 			rsp.dcid = cpu_to_le16(chan->scid);
 
 			if (l2cap_chan_check_security(chan)) {
+				lock_sock(sk);
 				if (bt_sk(sk)->defer_setup) {
 					struct sock *parent = bt_sk(sk)->parent;
 					rsp.result = cpu_to_le16(L2CAP_CR_PEND);
@@ -836,6 +835,7 @@ static void l2cap_conn_start(struct l2cap_conn *conn)
 					rsp.result = cpu_to_le16(L2CAP_CR_SUCCESS);
 					rsp.status = cpu_to_le16(L2CAP_CS_NO_INFO);
 				}
+				release_sock(sk);
 			} else {
 				rsp.result = cpu_to_le16(L2CAP_CR_PEND);
 				rsp.status = cpu_to_le16(L2CAP_CS_AUTHEN_PEND);
@@ -846,7 +846,7 @@ static void l2cap_conn_start(struct l2cap_conn *conn)
 
 			if (test_bit(CONF_REQ_SENT, &chan->conf_state) ||
 					rsp.result != L2CAP_CR_SUCCESS) {
-				bh_unlock_sock(sk);
+				l2cap_chan_unlock(chan);
 				continue;
 			}
 
@@ -856,7 +856,7 @@ static void l2cap_conn_start(struct l2cap_conn *conn)
 			chan->num_conf_req++;
 		}
 
-		bh_unlock_sock(sk);
+		l2cap_chan_unlock(chan);
 	}
 
 	mutex_unlock(&conn->chan_lock);
-- 
1.7.8.3

