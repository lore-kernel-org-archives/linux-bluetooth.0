Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/5] Bluetooth: Simplify logic for checking for SMP completion
Date: Wed, 26 Feb 2014 23:33:44 +0200
Message-Id: <1393450427-12438-2-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1393450427-12438-1-git-send-email-johan.hedberg@gmail.com>
References: <1393450427-12438-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

Now that smp->remote_key_dist is tracking the keys we're still waiting
for we can use it to simplify the logic for checking whether we're done
with key distribution or not. At the same time the reliance on the
"force" parameter of smp_distribute_keys goes away and it can completely
be removed in a subsequent patch.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/smp.c | 19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

diff --git a/net/bluetooth/smp.c b/net/bluetooth/smp.c
index fe41df5c320c..1b17adfffef8 100644
--- a/net/bluetooth/smp.c
+++ b/net/bluetooth/smp.c
@@ -1184,7 +1184,7 @@ int smp_distribute_keys(struct l2cap_conn *conn, __u8 force)
 	rsp = (void *) &smp->prsp[1];
 
 	/* The responder sends its keys first */
-	if (!force && hcon->out && (rsp->resp_key_dist & 0x07))
+	if (hcon->out && (smp->remote_key_dist & 0x07))
 		return 0;
 
 	req = (void *) &smp->preq[1];
@@ -1259,13 +1259,16 @@ int smp_distribute_keys(struct l2cap_conn *conn, __u8 force)
 		*keydist &= ~SMP_DIST_SIGN;
 	}
 
-	if (hcon->out || force || !(rsp->init_key_dist & 0x07)) {
-		clear_bit(HCI_CONN_LE_SMP_PEND, &hcon->flags);
-		cancel_delayed_work_sync(&conn->security_timer);
-		set_bit(SMP_FLAG_COMPLETE, &smp->smp_flags);
-		smp_notify_keys(conn);
-		smp_chan_destroy(conn);
-	}
+	/* If there are still keys to be received wait for them */
+	if ((smp->remote_key_dist & 0x07))
+		return 0;
+
+	clear_bit(HCI_CONN_LE_SMP_PEND, &hcon->flags);
+	cancel_delayed_work_sync(&conn->security_timer);
+	set_bit(SMP_FLAG_COMPLETE, &smp->smp_flags);
+	smp_notify_keys(conn);
+
+	smp_chan_destroy(conn);
 
 	return 0;
 }
-- 
1.8.5.3

