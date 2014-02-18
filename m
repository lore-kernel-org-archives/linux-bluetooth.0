Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 05/10] Bluetooth: Fix completing SMP as peripheral when no keys are expected
Date: Tue, 18 Feb 2014 17:14:34 +0200
Message-Id: <1392736479-8808-6-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1392736479-8808-1-git-send-email-johan.hedberg@gmail.com>
References: <1392736479-8808-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

When we're the acceptors (peripheral/slave) of an SMP procedure and
we've completed distributing our keys we should only stick around
waiting for keys from the remote side if any of the initiator
distribution bits were actually set. This patch fixes the
smp_distribute_keys function to clear the SMP context when this
situation occurs.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/smp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/bluetooth/smp.c b/net/bluetooth/smp.c
index 6dcb35640b6f..54672c9ab6a5 100644
--- a/net/bluetooth/smp.c
+++ b/net/bluetooth/smp.c
@@ -1164,7 +1164,7 @@ int smp_distribute_keys(struct l2cap_conn *conn, __u8 force)
 		*keydist &= ~SMP_DIST_SIGN;
 	}
 
-	if (conn->hcon->out || force) {
+	if (conn->hcon->out || force || !(rsp->init_key_dist & 0x07)) {
 		clear_bit(HCI_CONN_LE_SMP_PEND, &conn->hcon->flags);
 		cancel_delayed_work_sync(&conn->security_timer);
 		smp_chan_destroy(conn);
-- 
1.8.5.3

