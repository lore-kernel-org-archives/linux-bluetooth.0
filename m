Return-Path: <cyrus@holtmann.org>
From: Emeltchenko Andrei <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFCv0 3/5] Bluetooth: Helper functions for locking change
Date: Mon, 30 Jan 2012 17:09:04 +0200
Message-Id: <1327936146-13897-4-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1327936146-13897-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1327936146-13897-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>


Signed-off-by: Andrei Emeltchenko <andrei.emeltchenko@intel.com>
---
 net/bluetooth/l2cap_core.c |   23 ++++++++++++++++++++++-
 1 files changed, 22 insertions(+), 1 deletions(-)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 9a23b19..a7e5a55 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -241,7 +241,7 @@ static char *state_to_string(int state)
 	return "invalid state";
 }
 
-static void l2cap_state_change(struct l2cap_chan *chan, int state)
+static void __l2cap_state_change(struct l2cap_chan *chan, int state)
 {
 	BT_DBG("%p %s -> %s", chan, state_to_string(chan->state),
 						state_to_string(state));
@@ -250,6 +250,27 @@ static void l2cap_state_change(struct l2cap_chan *chan, int state)
 	chan->ops->state_change(chan->data, state);
 }
 
+static void l2cap_state_change(struct l2cap_chan *chan, int state)
+{
+	lock_sock(chan->sk);
+	__l2cap_state_change(chan, state);
+	release_sock(chan->sk);
+}
+
+static inline void __l2cap_set_sock_err(struct sock *sk, int err)
+{
+	sk->sk_err = err;
+}
+
+static inline void l2cap_set_sock_err(struct l2cap_chan *chan, int err)
+{
+	struct sock *sk = chan->sk;
+
+	lock_sock(sk);
+	__l2cap_set_sock_err(sk, err);
+	release_sock(sk);
+}
+
 static void l2cap_chan_timeout(struct work_struct *work)
 {
 	struct l2cap_chan *chan = container_of(work, struct l2cap_chan,
-- 
1.7.4.1

