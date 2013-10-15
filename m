Return-Path: <cyrus@holtmann.org>
From: Gustavo Padovan <gustavo@padovan.org>
To: linux-bluetooth@vger.kernel.org
Cc: Gustavo Padovan <gustavo.padovan@collabora.co.uk>
Subject: [PATCH 1/7] Bluetooth: Extend state_change() call to report errors too
Date: Tue, 15 Oct 2013 19:24:45 -0300
Message-Id: <1381875891-27953-1-git-send-email-gustavo@padovan.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Gustavo Padovan <gustavo.padovan@collabora.co.uk>

Instead of creating an new function pointer to report errors we are just
reusing state_change for that and there is a simple reason for this, one
place in the l2cap_core.c code needs, in a locked sk, set both the sk_state
and sk_err. If we create two different functions for this we would need to
release the lock between the two operation putting the socket in non
desired state.

The change is transparent to the l2cap_core.c code, user that only needs
to set the state won't need any modification.

This is another step of an ongoing work to make l2cap_core.c totally
independent from l2cap's struct sock.

Signed-off-by: Gustavo Padovan <gustavo.padovan@collabora.co.uk>
---
 include/net/bluetooth/l2cap.h | 2 +-
 net/bluetooth/a2mp.c          | 3 ++-
 net/bluetooth/l2cap_core.c    | 6 ++----
 net/bluetooth/l2cap_sock.c    | 6 +++++-
 4 files changed, 10 insertions(+), 7 deletions(-)

diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
index 07757a2..4ec86ce 100644
--- a/include/net/bluetooth/l2cap.h
+++ b/include/net/bluetooth/l2cap.h
@@ -551,7 +551,7 @@ struct l2cap_ops {
 	void			(*teardown) (struct l2cap_chan *chan, int err);
 	void			(*close) (struct l2cap_chan *chan);
 	void			(*state_change) (struct l2cap_chan *chan,
-						 int state);
+						 int state, int err);
 	void			(*ready) (struct l2cap_chan *chan);
 	void			(*defer) (struct l2cap_chan *chan);
 	void			(*resume) (struct l2cap_chan *chan);
diff --git a/net/bluetooth/a2mp.c b/net/bluetooth/a2mp.c
index 60ca528..6b8cc23 100644
--- a/net/bluetooth/a2mp.c
+++ b/net/bluetooth/a2mp.c
@@ -672,7 +672,8 @@ static void a2mp_chan_close_cb(struct l2cap_chan *chan)
 	l2cap_chan_put(chan);
 }
 
-static void a2mp_chan_state_change_cb(struct l2cap_chan *chan, int state)
+static void a2mp_chan_state_change_cb(struct l2cap_chan *chan, int state,
+				      int err)
 {
 	struct amp_mgr *mgr = chan->data;
 
diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 0c3446d..df5670d 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -229,7 +229,7 @@ static void __l2cap_state_change(struct l2cap_chan *chan, int state)
 	       state_to_string(state));
 
 	chan->state = state;
-	chan->ops->state_change(chan, state);
+	chan->ops->state_change(chan, state, 0);
 }
 
 static void l2cap_state_change(struct l2cap_chan *chan, int state)
@@ -243,9 +243,7 @@ static void l2cap_state_change(struct l2cap_chan *chan, int state)
 
 static inline void __l2cap_chan_set_err(struct l2cap_chan *chan, int err)
 {
-	struct sock *sk = chan->sk;
-
-	sk->sk_err = err;
+	chan->ops->state_change(chan, chan->state, err);
 }
 
 static inline void l2cap_chan_set_err(struct l2cap_chan *chan, int err)
diff --git a/net/bluetooth/l2cap_sock.c b/net/bluetooth/l2cap_sock.c
index 5ffd75e..0de8a30 100644
--- a/net/bluetooth/l2cap_sock.c
+++ b/net/bluetooth/l2cap_sock.c
@@ -1072,11 +1072,15 @@ static void l2cap_sock_teardown_cb(struct l2cap_chan *chan, int err)
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
1.8.3.1

