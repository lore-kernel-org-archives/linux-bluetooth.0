Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 1/2] Bluetooth: Use proper nesting annotation for l2cap_chan lock
Date: Wed, 12 Nov 2014 22:22:21 +0200
Message-Id: <1415823742-26909-2-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1415823742-26909-1-git-send-email-johan.hedberg@gmail.com>
References: <1415823742-26909-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

By default lockdep considers all L2CAP channels equal. This would mean
that we get warnings if a channel is locked when another one's lock is
tried to be acquired in the same thread. This kind of inter-channel
locking dependencies exist in the form of parent-child channels as well
as any channel wishing to elevate the security by requesting procedures
on the SMP channel.

To eliminate the chance for these lockdep warnings we introduce a
nesting level for each channel and use that when acquiring the channel
lock. For now there exists the earlier mentioned three identified
categories: SMP, "normal" channels and parent channels (i.e. those in
BT_LISTEN state). The nesting level is defined as atomic_t since we need
access to it before the lock is actually acquired.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 include/net/bluetooth/l2cap.h | 15 ++++++++++++++-
 net/bluetooth/l2cap_sock.c    |  9 +++++++++
 net/bluetooth/smp.c           | 10 ++++++++++
 3 files changed, 33 insertions(+), 1 deletion(-)

diff --git a/include/net/bluetooth/l2cap.h b/include/net/bluetooth/l2cap.h
index ead99f032f7a..061e648052c8 100644
--- a/include/net/bluetooth/l2cap.h
+++ b/include/net/bluetooth/l2cap.h
@@ -28,6 +28,7 @@
 #define __L2CAP_H
 
 #include <asm/unaligned.h>
+#include <linux/atomic.h>
 
 /* L2CAP defaults */
 #define L2CAP_DEFAULT_MTU		672
@@ -481,6 +482,7 @@ struct l2cap_chan {
 	struct hci_conn		*hs_hcon;
 	struct hci_chan		*hs_hchan;
 	struct kref	kref;
+	atomic_t	nesting;
 
 	__u8		state;
 
@@ -713,6 +715,17 @@ enum {
 	FLAG_HOLD_HCI_CONN,
 };
 
+/* Lock nesting levels for L2CAP channels. We need these because lockdep
+ * otherwise considers all channels equal and will e.g. complain about a
+ * connection oriented channel triggering SMP procedures or a listening
+ * channel creating and locking a child channel.
+ */
+enum {
+	L2CAP_NESTING_SMP,
+	L2CAP_NESTING_NORMAL,
+	L2CAP_NESTING_PARENT,
+};
+
 enum {
 	L2CAP_TX_STATE_XMIT,
 	L2CAP_TX_STATE_WAIT_F,
@@ -778,7 +791,7 @@ void l2cap_chan_put(struct l2cap_chan *c);
 
 static inline void l2cap_chan_lock(struct l2cap_chan *chan)
 {
-	mutex_lock(&chan->lock);
+	mutex_lock_nested(&chan->lock, atomic_read(&chan->nesting));
 }
 
 static inline void l2cap_chan_unlock(struct l2cap_chan *chan)
diff --git a/net/bluetooth/l2cap_sock.c b/net/bluetooth/l2cap_sock.c
index ad1cf82fee02..f1a51564b8fd 100644
--- a/net/bluetooth/l2cap_sock.c
+++ b/net/bluetooth/l2cap_sock.c
@@ -285,6 +285,12 @@ static int l2cap_sock_listen(struct socket *sock, int backlog)
 	sk->sk_max_ack_backlog = backlog;
 	sk->sk_ack_backlog = 0;
 
+	/* Listening channels need to use nested locking in order not to
+	 * cause lockdep warnings when the created child channels end up
+	 * being locked in the same thread as the parent channel.
+	 */
+	atomic_set(&chan->nesting, L2CAP_NESTING_PARENT);
+
 	chan->state = BT_LISTEN;
 	sk->sk_state = BT_LISTEN;
 
@@ -1497,6 +1503,9 @@ static void l2cap_sock_init(struct sock *sk, struct sock *parent)
 		l2cap_chan_set_defaults(chan);
 	}
 
+	/* Set default lock nesting level */
+	atomic_set(&chan->nesting, L2CAP_NESTING_NORMAL);
+
 	/* Default config options */
 	chan->flush_to = L2CAP_DEFAULT_FLUSH_TO;
 
diff --git a/net/bluetooth/smp.c b/net/bluetooth/smp.c
index 3d38553eb526..3b63c7f09dd5 100644
--- a/net/bluetooth/smp.c
+++ b/net/bluetooth/smp.c
@@ -1658,6 +1658,13 @@ static inline struct l2cap_chan *smp_new_conn_cb(struct l2cap_chan *pchan)
 	chan->omtu	= pchan->omtu;
 	chan->mode	= pchan->mode;
 
+	/* Other L2CAP channels may request SMP routines in order to
+	 * change the security level. This means that the SMP channel
+	 * lock must be considered in its own category to avoid lockdep
+	 * warnings.
+	 */
+	atomic_set(&chan->nesting, L2CAP_NESTING_SMP);
+
 	BT_DBG("created chan %p", chan);
 
 	return chan;
@@ -1715,6 +1722,9 @@ int smp_register(struct hci_dev *hdev)
 	chan->imtu = L2CAP_DEFAULT_MTU;
 	chan->ops = &smp_root_chan_ops;
 
+	/* Set correct nesting level for a parent/listening channel */
+	atomic_set(&chan->nesting, L2CAP_NESTING_PARENT);
+
 	hdev->smp_data = chan;
 
 	return 0;
-- 
2.1.0

