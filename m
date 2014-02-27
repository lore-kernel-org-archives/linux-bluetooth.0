Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 4/4] Bluetooth: Use hdev->init/resp_addr values for smp_c1 function
Date: Thu, 27 Feb 2014 14:05:43 +0200
Message-Id: <1393502743-9995-5-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1393502743-9995-1-git-send-email-johan.hedberg@gmail.com>
References: <1393502743-9995-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

Now that we have nicely tracked values of the initiator and responder
address information we can pass that directly to the smp_c1 function
without worrying e.g. about who initiated the connection. This patch
updates the two places in smp.c to use the new variables.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/smp.c | 22 ++++++----------------
 1 file changed, 6 insertions(+), 16 deletions(-)

diff --git a/net/bluetooth/smp.c b/net/bluetooth/smp.c
index 52708f79545f..c7ba30dcb907 100644
--- a/net/bluetooth/smp.c
+++ b/net/bluetooth/smp.c
@@ -445,14 +445,9 @@ static void confirm_work(struct work_struct *work)
 	/* Prevent mutual access to hdev->tfm_aes */
 	hci_dev_lock(hdev);
 
-	if (conn->hcon->out)
-		ret = smp_c1(tfm, smp->tk, smp->prnd, smp->preq, smp->prsp,
-			     conn->hcon->src_type, &conn->hcon->src,
-			     conn->hcon->dst_type, &conn->hcon->dst, res);
-	else
-		ret = smp_c1(tfm, smp->tk, smp->prnd, smp->preq, smp->prsp,
-			     conn->hcon->dst_type, &conn->hcon->dst,
-			     conn->hcon->src_type, &conn->hcon->src, res);
+	ret = smp_c1(tfm, smp->tk, smp->prnd, smp->preq, smp->prsp,
+		     conn->hcon->init_addr_type, &conn->hcon->init_addr,
+		     conn->hcon->resp_addr_type, &conn->hcon->resp_addr, res);
 
 	hci_dev_unlock(hdev);
 
@@ -492,14 +487,9 @@ static void random_work(struct work_struct *work)
 	/* Prevent mutual access to hdev->tfm_aes */
 	hci_dev_lock(hdev);
 
-	if (hcon->out)
-		ret = smp_c1(tfm, smp->tk, smp->rrnd, smp->preq, smp->prsp,
-			     hcon->src_type, &hcon->src,
-			     hcon->dst_type, &hcon->dst, res);
-	else
-		ret = smp_c1(tfm, smp->tk, smp->rrnd, smp->preq, smp->prsp,
-			     hcon->dst_type, &hcon->dst,
-			     hcon->src_type, &hcon->src, res);
+	ret = smp_c1(tfm, smp->tk, smp->rrnd, smp->preq, smp->prsp,
+		     hcon->init_addr_type, &hcon->init_addr,
+		     hcon->resp_addr_type, &hcon->resp_addr, res);
 
 	hci_dev_unlock(hdev);
 
-- 
1.8.5.3

