Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Fix clearing SMP keys if pairing fails
Date: Fri, 28 Feb 2014 10:10:16 +0200
Message-Id: <1393575016-12166-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

If SMP fails we should not leave any keys (LTKs or IRKs) hanging around
the internal lists. This patch adds the necessary code to
smp_chan_destroy to remove any keys we may have in case of pairing
failure.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/smp.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/net/bluetooth/smp.c b/net/bluetooth/smp.c
index 6ace0b48dc6a..710f4e171bf1 100644
--- a/net/bluetooth/smp.c
+++ b/net/bluetooth/smp.c
@@ -589,6 +589,24 @@ void smp_chan_destroy(struct l2cap_conn *conn)
 	complete = test_bit(SMP_FLAG_COMPLETE, &smp->smp_flags);
 	mgmt_smp_complete(conn->hcon, complete);
 
+	/* If pairing failed clean up any keys we might have */
+	if (!complete) {
+		if (smp->ltk) {
+			list_del(&smp->ltk->list);
+			kfree(smp->ltk);
+		}
+
+		if (smp->slave_ltk) {
+			list_del(&smp->slave_ltk->list);
+			kfree(smp->slave_ltk);
+		}
+
+		if (smp->remote_irk) {
+			list_del(&smp->remote_irk->list);
+			kfree(smp->remote_irk);
+		}
+	}
+
 	kfree(smp);
 	conn->smp_chan = NULL;
 	conn->hcon->smp_conn = NULL;
-- 
1.8.5.3

