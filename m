Return-Path: <cyrus@holtmann.org>
From: Gustavo Padovan <gustavo@padovan.org>
To: linux-bluetooth@vger.kernel.org
Cc: Gustavo Padovan <gustavo.padovan@collabora.co.uk>
Subject: [RFC -v2 03/16] Bluetooth: extend state_change() call to report errors too
Date: Fri, 21 Dec 2012 16:10:46 -0200
Message-Id: <1356113459-7932-4-git-send-email-gustavo@padovan.org>
In-Reply-To: <1356113459-7932-1-git-send-email-gustavo@padovan.org>
References: <1356113459-7932-1-git-send-email-gustavo@padovan.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Gustavo Padovan <gustavo.padovan@collabora.co.uk>

Now l2cap_core doesn't need to touch sk_err element anymore, it just tell
l2cap_sock via this call which error it wants to set.

Signed-off-by: Gustavo Padovan <gustavo.padovan@collabora.co.uk>
---
 include/net/bluetooth/l2cap.h | 2 +-
 net/bluetooth/a2mp.c          | 2 +-
 net/bluetooth/l2cap_core.c    | 6 ++----
 net/bluetooth/l2cap_sock.c    | 6 +++++-
 4 files changed, 9 insertions(+), 7 deletions(-)

diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
index cf94e68..4f28a8c 100644
--- a/include/net/bluetooth/l2cap.h
+++ b/include/net/bluetooth/l2cap.h
@@ -550,7 +550,7 @@ struct l2cap_ops {
 	void			(*teardown) (struct l2cap_chan *chan, int err);
 	void			(*close) (struct l2cap_chan *chan);
 	void			(*state_change) (struct l2cap_chan *chan,
-						 int state);
+						 int state, int err);
 	void			(*ready) (struct l2cap_chan *chan);
 	void			(*defer) (struct l2cap_chan *chan);
 	struct sk_buff		*(*alloc_skb) (struct l2cap_chan *chan,
diff --git a/net/bluetooth/a2mp.c b/net/bluetooth/a2mp.c
index eb0f4b1..ad6e42f 100644
--- a/net/bluetooth/a2mp.c
+++ b/net/bluetooth/a2mp.c
@@ -671,7 +671,7 @@ static void a2mp_chan_close_cb(struct l2cap_chan *chan)
 	l2cap_chan_put(chan);
 }
 
-static void a2mp_chan_state_change_cb(struct l2cap_chan *chan, int state)
+static void a2mp_chan_state_change_cb(struct l2cap_chan *chan, int state, int err)
 {
 	struct amp_mgr *mgr = chan->data;
 
diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index c854789..7a56596 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -216,7 +216,7 @@ static void __l2cap_state_change(struct l2cap_chan *chan, int state)
 	       state_to_string(state));
 
 	chan->state = state;
-	chan->ops->state_change(chan, state);
+	chan->ops->state_change(chan, state, 0);
 }
 
 static void l2cap_state_change(struct l2cap_chan *chan, int state)
@@ -230,9 +230,7 @@ static void l2cap_state_change(struct l2cap_chan *chan, int state)
 
 static inline void __l2cap_chan_set_err(struct l2cap_chan *chan, int err)
 {
-	struct sock *sk = chan->sk;
-
-	sk->sk_err = err;
+	chan->ops->state_change(chan, chan->state, err);
 }
 
 static inline void l2cap_chan_set_err(struct l2cap_chan *chan, int err)
diff --git a/net/bluetooth/l2cap_sock.c b/net/bluetooth/l2cap_sock.c
index 221aef9..8adea0f 100644
--- a/net/bluetooth/l2cap_sock.c
+++ b/net/bluetooth/l2cap_sock.c
@@ -1044,11 +1044,15 @@ static void l2cap_sock_teardown_cb(struct l2cap_chan *chan, int err)
 	release_sock(sk);
 }
 
-static void l2cap_sock_state_change_cb(struct l2cap_chan *chan, int state)
+static void l2cap_sock_state_change_cb(struct l2cap_chan *chan, int state,
+				       int err)
 {
 	struct sock *sk = chan->data;
 
 	sk->sk_state = state;
+
+	if (err)
+		sk->sk_err = err;
 }
 
 static struct sk_buff *l2cap_sock_alloc_skb_cb(struct l2cap_chan *chan,
-- 
1.8.0.2

