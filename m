Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 7/9] Bluetooth: Move canceling security_timer into smp_chan_destroy()
Date: Mon, 11 Aug 2014 22:06:42 +0300
Message-Id: <1407784004-12448-8-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1407784004-12448-1-git-send-email-johan.hedberg@gmail.com>
References: <1407784004-12448-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

All places needing to cancel the security timer also call
smp_chan_destroy() in the same go. To eliminate the need to do these two
calls in multiple places simply move the timer cancellation into
smp_chan_destroy().

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/smp.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/net/bluetooth/smp.c b/net/bluetooth/smp.c
index 7ab5f52955cb..cdae40869447 100644
--- a/net/bluetooth/smp.c
+++ b/net/bluetooth/smp.c
@@ -384,8 +384,6 @@ static void smp_failure(struct l2cap_conn *conn, u8 reason)
 
 	smp = chan->data;
 
-	cancel_delayed_work_sync(&smp->security_timer);
-
 	if (test_and_clear_bit(HCI_CONN_LE_SMP_PEND, &hcon->flags))
 		smp_chan_destroy(conn);
 }
@@ -765,7 +763,6 @@ static int smp_distribute_keys(struct l2cap_conn *conn)
 		return 0;
 
 	clear_bit(HCI_CONN_LE_SMP_PEND, &hcon->flags);
-	cancel_delayed_work_sync(&smp->security_timer);
 	set_bit(SMP_FLAG_COMPLETE, &smp->flags);
 	smp_notify_keys(conn);
 
@@ -822,6 +819,11 @@ void smp_chan_destroy(struct l2cap_conn *conn)
 
 	BUG_ON(!smp);
 
+	cancel_delayed_work_sync(&smp->security_timer);
+	/* In case the timeout freed the SMP context */
+	if (!chan->data)
+		return;
+
 	complete = test_bit(SMP_FLAG_COMPLETE, &smp->flags);
 	mgmt_smp_complete(conn->hcon, complete);
 
@@ -1512,10 +1514,8 @@ static void smp_teardown_cb(struct l2cap_chan *chan, int err)
 
 	BT_DBG("chan %p", chan);
 
-	if (test_and_clear_bit(HCI_CONN_LE_SMP_PEND, &conn->hcon->flags)) {
-		cancel_delayed_work_sync(&smp->security_timer);
+	if (test_and_clear_bit(HCI_CONN_LE_SMP_PEND, &conn->hcon->flags))
 		smp_chan_destroy(conn);
-	}
 
 	conn->smp = NULL;
 	l2cap_chan_put(chan);
-- 
1.9.3

