Return-Path: <cyrus@holtmann.org>
From: Gustavo Padovan <gustavo@padovan.org>
To: linux-bluetooth@vger.kernel.org
Cc: Gustavo Padovan <gustavo.padovan@collabora.co.uk>
Subject: [RFC 04/16] Bluetooth: add l2cap_state_change_and_error()
Date: Wed, 12 Dec 2012 02:13:32 -0200
Message-Id: <1355285624-25811-5-git-send-email-gustavo@padovan.org>
In-Reply-To: <1355285624-25811-1-git-send-email-gustavo@padovan.org>
References: <1355285624-25811-1-git-send-email-gustavo@padovan.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Gustavo Padovan <gustavo.padovan@collabora.co.uk>

Add helper to set both state and error at the same time.

Signed-off-by: Gustavo Padovan <gustavo.padovan@collabora.co.uk>
---
 net/bluetooth/l2cap_core.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index e0aabe8..91e12b6 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -228,9 +228,15 @@ static void l2cap_state_change(struct l2cap_chan *chan, int state)
 	release_sock(sk);
 }
 
-static inline void __l2cap_chan_set_err(struct l2cap_chan *chan, int err)
+static void l2cap_state_change_and_error(struct l2cap_chan *chan, int state,
+					 int err)
 {
-	chan->ops->state_change(chan, chan->state, 0);
+	struct sock *sk = chan->sk;
+
+	lock_sock(sk);
+	chan->state = state;
+	chan->ops->state_change(chan, state, err);
+	release_sock(sk);
 }
 
 static inline void l2cap_chan_set_err(struct l2cap_chan *chan, int err)
@@ -238,7 +244,7 @@ static inline void l2cap_chan_set_err(struct l2cap_chan *chan, int err)
 	struct sock *sk = chan->sk;
 
 	lock_sock(sk);
-	__l2cap_chan_set_err(chan, err);
+	chan->ops->state_change(chan, chan->state, 0);
 	release_sock(sk);
 }
 
@@ -1180,7 +1186,6 @@ static inline int l2cap_mode_supported(__u8 mode, __u32 feat_mask)
 
 static void l2cap_send_disconn_req(struct l2cap_chan *chan, int err)
 {
-	struct sock *sk = chan->sk;
 	struct l2cap_conn *conn = chan->conn;
 	struct l2cap_disconn_req req;
 
@@ -1203,10 +1208,7 @@ static void l2cap_send_disconn_req(struct l2cap_chan *chan, int err)
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
1.7.11.7

