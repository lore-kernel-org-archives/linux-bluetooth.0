Return-Path: <cyrus@holtmann.org>
From: Johan Hedberg <johan.hedberg@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/2] Bluetooth: Fix L2CAP nesting level initialization location
Date: Thu, 13 Nov 2014 09:46:04 +0200
Message-Id: <1415864765-7507-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

There's no reason why all users of L2CAP would need to worry about
initializing chan->nesting to L2CAP_NESTING_NORMAL (which is important
since 0 is the same as NESTING_SMP). This patch moves the initialization
to the common place that's used to create all new channels, i.e. the
l2cap_chan_create() function.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/l2cap_core.c | 3 +++
 net/bluetooth/l2cap_sock.c | 3 ---
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index fc15174c612c..52e1871d6334 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -424,6 +424,9 @@ struct l2cap_chan *l2cap_chan_create(void)
 
 	mutex_init(&chan->lock);
 
+	/* Set default lock nesting level */
+	atomic_set(&chan->nesting, L2CAP_NESTING_NORMAL);
+
 	write_lock(&chan_list_lock);
 	list_add(&chan->global_l, &chan_list);
 	write_unlock(&chan_list_lock);
diff --git a/net/bluetooth/l2cap_sock.c b/net/bluetooth/l2cap_sock.c
index 7913c28c643d..a5aa9f92b5e2 100644
--- a/net/bluetooth/l2cap_sock.c
+++ b/net/bluetooth/l2cap_sock.c
@@ -1510,9 +1510,6 @@ static void l2cap_sock_init(struct sock *sk, struct sock *parent)
 		l2cap_chan_set_defaults(chan);
 	}
 
-	/* Set default lock nesting level */
-	atomic_set(&chan->nesting, L2CAP_NESTING_NORMAL);
-
 	/* Default config options */
 	chan->flush_to = L2CAP_DEFAULT_FLUSH_TO;
 
-- 
2.1.0

