Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/3] Bluetooth: Call L2CAP teardown callback before clearing chan->conn
Date: Fri,  8 Aug 2014 09:28:03 +0300
Message-Id: <1407479285-4261-2-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1407479285-4261-1-git-send-email-johan.hedberg@gmail.com>
References: <1407479285-4261-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

L2CAP channel implementations may want to still access the chan->conn
pointer. This will particularly be the case for SMP that will want to
clear a reference to the SMP channel in the l2cap_conn structure. The
only user of the teardown callback so far is l2cap_sock.c and for the
code there it makes no difference whether the callback is called before
or after clearing the chan->conn pointer.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/l2cap_core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/bluetooth/l2cap_core.c b/net/bluetooth/l2cap_core.c
index 344a29c53227..c6419f40cfba 100644
--- a/net/bluetooth/l2cap_core.c
+++ b/net/bluetooth/l2cap_core.c
@@ -566,6 +566,8 @@ void l2cap_chan_del(struct l2cap_chan *chan, int err)
 
 	BT_DBG("chan %p, conn %p, err %d", chan, conn, err);
 
+	chan->ops->teardown(chan, err);
+
 	if (conn) {
 		struct amp_mgr *mgr = conn->hcon->amp_mgr;
 		/* Delete from channel list */
@@ -589,8 +591,6 @@ void l2cap_chan_del(struct l2cap_chan *chan, int err)
 		amp_disconnect_logical_link(hs_hchan);
 	}
 
-	chan->ops->teardown(chan, err);
-
 	if (test_bit(CONF_NOT_COMPLETE, &chan->conf_state))
 		return;
 
-- 
1.9.3

