Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/7] Bluetooth: Remove unnecessary checks after canceling SMP security timer
Date: Fri,  5 Sep 2014 13:51:00 +0300
Message-Id: <1409914266-21624-2-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1409914266-21624-1-git-send-email-johan.hedberg@gmail.com>
References: <1409914266-21624-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

The SMP security timer used to be able to modify the SMP context state
but now days it simply calls hci_disconnect(). It is therefore
unnecessary to have extra sanity checks for the SMP context after
canceling the timer.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/smp.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/net/bluetooth/smp.c b/net/bluetooth/smp.c
index 16c181181775..b8ecc7bd3e3b 100644
--- a/net/bluetooth/smp.c
+++ b/net/bluetooth/smp.c
@@ -282,8 +282,7 @@ static void smp_send_cmd(struct l2cap_conn *conn, u8 code, u16 len, void *data)
 	smp = chan->data;
 
 	cancel_delayed_work_sync(&smp->security_timer);
-	if (test_bit(HCI_CONN_LE_SMP_PEND, &conn->hcon->flags))
-		schedule_delayed_work(&smp->security_timer, SMP_TIMEOUT);
+	schedule_delayed_work(&smp->security_timer, SMP_TIMEOUT);
 }
 
 static __u8 authreq_to_seclevel(__u8 authreq)
@@ -375,9 +374,6 @@ static void smp_chan_destroy(struct l2cap_conn *conn)
 	BUG_ON(!smp);
 
 	cancel_delayed_work_sync(&smp->security_timer);
-	/* In case the timeout freed the SMP context */
-	if (!chan->data)
-		return;
 
 	if (work_pending(&smp->distribute_work)) {
 		cancel_work_sync(&smp->distribute_work);
-- 
1.9.3

