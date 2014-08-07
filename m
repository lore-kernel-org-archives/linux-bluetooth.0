Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/2] Bluetooth: Remove redundant check for remote_key_dist
Date: Thu,  7 Aug 2014 10:03:31 +0300
Message-Id: <1407395012-30446-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

In the smp_cmd_sign_info() function the SMP_DIST_SIGN bit is explicitly
cleared early on in the function. This means that there's no need to
check for it again before calling smp_distribute_keys().

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/smp.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/net/bluetooth/smp.c b/net/bluetooth/smp.c
index fd3294300803..40db728f044b 100644
--- a/net/bluetooth/smp.c
+++ b/net/bluetooth/smp.c
@@ -1168,8 +1168,7 @@ static int smp_cmd_sign_info(struct l2cap_conn *conn, struct sk_buff *skb)
 		memcpy(csrk->val, rp->csrk, sizeof(csrk->val));
 	}
 	smp->csrk = csrk;
-	if (!(smp->remote_key_dist & SMP_DIST_SIGN))
-		smp_distribute_keys(conn);
+	smp_distribute_keys(conn);
 	hci_dev_unlock(hdev);
 
 	return 0;
-- 
1.9.3

