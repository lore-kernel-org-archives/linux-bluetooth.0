Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 6/7] Bluetooth: Fix calling smp_distribute_keys() when still waiting for keys
Date: Fri,  5 Sep 2014 15:40:37 +0300
Message-Id: <1409920838-30242-7-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1409920838-30242-1-git-send-email-johan.hedberg@gmail.com>
References: <1409920838-30242-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

When we're in the process of receiving keys in phase 3 of SMP we keep
track of which keys are still expected in the smp->remote_key_dist
variable. If we still have some key bits set we need to continue waiting
for more PDUs and not needlessly call smp_distribute_keys(). This patch
fixes two such cases in the smp_cmd_master_ident() and
smp_cmd_ident_addr_info() handler functions.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/smp.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/net/bluetooth/smp.c b/net/bluetooth/smp.c
index fd326f35026e..3e59b2572f43 100644
--- a/net/bluetooth/smp.c
+++ b/net/bluetooth/smp.c
@@ -1292,7 +1292,7 @@ static int smp_cmd_master_ident(struct l2cap_conn *conn, struct sk_buff *skb)
 			  authenticated, smp->tk, smp->enc_key_size,
 			  rp->ediv, rp->rand);
 	smp->ltk = ltk;
-	if (!(smp->remote_key_dist & SMP_DIST_ID_KEY))
+	if (!(smp->remote_key_dist & 0x07))
 		smp_distribute_keys(smp);
 	hci_dev_unlock(hdev);
 
@@ -1370,7 +1370,8 @@ static int smp_cmd_ident_addr_info(struct l2cap_conn *conn,
 				      smp->id_addr_type, smp->irk, &rpa);
 
 distribute:
-	smp_distribute_keys(smp);
+	if (!(smp->remote_key_dist & 0x07))
+		smp_distribute_keys(smp);
 
 	hci_dev_unlock(hcon->hdev);
 
-- 
1.9.3

