Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 1/3] Bluetooth: Simplify logic when checking SMP_FLAG_TK_VALID
Date: Wed, 19 Mar 2014 14:14:51 +0200
Message-Id: <1395231293-26581-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

This is a trivial coding style simplification by instead of having an
extra early return to instead revert the if condition and do the single
needed queue_work() call there.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/smp.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/net/bluetooth/smp.c b/net/bluetooth/smp.c
index a0150033e797..ed1c9547ba6e 100644
--- a/net/bluetooth/smp.c
+++ b/net/bluetooth/smp.c
@@ -761,10 +761,8 @@ static u8 smp_cmd_pairing_rsp(struct l2cap_conn *conn, struct sk_buff *skb)
 	set_bit(SMP_FLAG_CFM_PENDING, &smp->smp_flags);
 
 	/* Can't compose response until we have been confirmed */
-	if (!test_bit(SMP_FLAG_TK_VALID, &smp->smp_flags))
-		return 0;
-
-	queue_work(hdev->workqueue, &smp->confirm);
+	if (test_bit(SMP_FLAG_TK_VALID, &smp->smp_flags))
+		queue_work(hdev->workqueue, &smp->confirm);
 
 	return 0;
 }
-- 
1.8.5.3

