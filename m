Return-Path: <cyrus@holtmann.org>
From: Gustavo Padovan <gustavo@padovan.org>
To: linux-bluetooth@vger.kernel.org
Cc: Gustavo Padovan <gustavo.padovan@collabora.co.uk>
Subject: [PATCH 2/7] Bluetooth: Add l2cap_state_change_and_error()
Date: Tue, 15 Oct 2013 19:24:46 -0300
Message-Id: <1381875891-27953-2-git-send-email-gustavo@padovan.org>
In-Reply-To: <1381875891-27953-1-git-send-email-gustavo@padovan.org>
References: <1381875891-27953-1-git-send-email-gustavo@padovan.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Gustavo Padovan <gustavo.padovan@collabora.co.uk>

l2cap_state_change_and_error() introduces the ability to update a
l2cap_user with changes in channel's state and error code with just one
call. The main reason for this is to avoid race conditions between and
setting the state and then the error. Otherwise we would need to release
the lock between both operations.

This is another step of an ongoing work to make l2cap_core.c totally
independent from l2cap's struct sock.

Signed-off-by: Gustavo Padovan <gustavo.padovan@collabora.co.uk>
---
 net/bluetooth/l2cap_core.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index df5670d..f4e02b4 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -241,9 +241,15 @@ static void l2cap_state_change(struct l2cap_chan *chan, int state)
 	release_sock(sk);
 }
 
-static inline void __l2cap_chan_set_err(struct l2cap_chan *chan, int err)
+static inline void l2cap_state_change_and_error(struct l2cap_chan *chan,
+						int state, int err)
 {
+	struct sock *sk = chan->sk;
+
+	lock_sock(sk);
+	chan->state = state;
 	chan->ops->state_change(chan, chan->state, err);
+	release_sock(sk);
 }
 
 static inline void l2cap_chan_set_err(struct l2cap_chan *chan, int err)
@@ -251,7 +257,7 @@ static inline void l2cap_chan_set_err(struct l2cap_chan *chan, int err)
 	struct sock *sk = chan->sk;
 
 	lock_sock(sk);
-	__l2cap_chan_set_err(chan, err);
+	chan->ops->state_change(chan, chan->state, err);
 	release_sock(sk);
 }
 
@@ -1228,7 +1234,6 @@ static inline int l2cap_mode_supported(__u8 mode, __u32 feat_mask)
 
 static void l2cap_send_disconn_req(struct l2cap_chan *chan, int err)
 {
-	struct sock *sk = chan->sk;
 	struct l2cap_conn *conn = chan->conn;
 	struct l2cap_disconn_req req;
 
@@ -1251,10 +1256,7 @@ static void l2cap_send_disconn_req(struct l2cap_chan *chan, int err)
 	l2cap_send_cmd(conn, l2cap_get_ident(conn), L2CAP_DISCONN_REQ,
 		       sizeof(req), &req);
 
-	lock_sock(sk);
-	__l2cap_state_change(chan, BT_DISCONN);
-	__l2cap_chan_set_err(chan, err);
-	release_sock(sk);
+	l2cap_state_change_and_error(chan, BT_DISCONN, err);
 }
 
 /* ---- L2CAP connections ---- */
-- 
1.8.3.1

