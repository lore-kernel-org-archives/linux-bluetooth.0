Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Fix allowing SMP Signing info PDU
Date: Tue,  9 Sep 2014 16:21:46 -0700
Message-Id: <1410304906-20898-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

If the remote side is not distributing its IRK but is distributing the
CSRK the next PDU after master identification is the Signing
Information. This patch fixes a missing SMP_ALLOW_CND() for this in the
smp_cmd_master_ident() function.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/smp.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/bluetooth/smp.c b/net/bluetooth/smp.c
index 25c9040e0b12..dc575aba2e65 100644
--- a/net/bluetooth/smp.c
+++ b/net/bluetooth/smp.c
@@ -1324,6 +1324,8 @@ static int smp_cmd_master_ident(struct l2cap_conn *conn, struct sk_buff *skb)
 	SMP_DISALLOW_CMD(smp, SMP_CMD_MASTER_IDENT);
 	if (smp->remote_key_dist & SMP_DIST_ID_KEY)
 		SMP_ALLOW_CMD(smp, SMP_CMD_IDENT_INFO);
+	else if (smp->remote_key_dist & SMP_DIST_SIGN)
+		SMP_ALLOW_CMD(smp, SMP_CMD_SIGN_INFO);
 
 	skb_pull(skb, sizeof(*rp));
 
-- 
1.9.3

