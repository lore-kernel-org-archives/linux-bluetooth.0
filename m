Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 4/4] Bluetooth: Fix input address type for SMP C1 function
Date: Sun, 13 Oct 2013 05:24:02 -0700
Message-Id: <1381667042-46368-4-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The smp_c1() so far always assumed public addresses as input for its
operation. However it should provide actually the source address type
of the actual connection.

Finally the source address type is tracked in hci_conn->src_type and
so use that one as input.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 net/bluetooth/smp.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/net/bluetooth/smp.c b/net/bluetooth/smp.c
index f57b209..112e581 100644
--- a/net/bluetooth/smp.c
+++ b/net/bluetooth/smp.c
@@ -387,13 +387,13 @@ static void confirm_work(struct work_struct *work)
 	smp->tfm = tfm;
 
 	if (conn->hcon->out)
-		ret = smp_c1(tfm, smp->tk, smp->prnd, smp->preq, smp->prsp, 0,
-			     &conn->hcon->src, conn->hcon->dst_type,
-			     &conn->hcon->dst, res);
+		ret = smp_c1(tfm, smp->tk, smp->prnd, smp->preq, smp->prsp,
+			     conn->hcon->src_type, &conn->hcon->src,
+			     conn->hcon->dst_type, &conn->hcon->dst, res);
 	else
 		ret = smp_c1(tfm, smp->tk, smp->prnd, smp->preq, smp->prsp,
-			     conn->hcon->dst_type, &conn->hcon->dst, 0,
-			     &conn->hcon->src, res);
+			     conn->hcon->dst_type, &conn->hcon->dst,
+			     conn->hcon->src_type, &conn->hcon->src, res);
 	if (ret) {
 		reason = SMP_UNSPECIFIED;
 		goto error;
@@ -427,11 +427,13 @@ static void random_work(struct work_struct *work)
 	BT_DBG("conn %p %s", conn, conn->hcon->out ? "master" : "slave");
 
 	if (hcon->out)
-		ret = smp_c1(tfm, smp->tk, smp->rrnd, smp->preq, smp->prsp, 0,
-			     &hcon->src, hcon->dst_type, &hcon->dst, res);
+		ret = smp_c1(tfm, smp->tk, smp->rrnd, smp->preq, smp->prsp,
+			     hcon->src_type, &hcon->src,
+			     hcon->dst_type, &hcon->dst, res);
 	else
 		ret = smp_c1(tfm, smp->tk, smp->rrnd, smp->preq, smp->prsp,
-			     hcon->dst_type, &hcon->dst, 0, &hcon->src, res);
+			     hcon->dst_type, &hcon->dst,
+			     hcon->src_type, &hcon->src, res);
 	if (ret) {
 		reason = SMP_UNSPECIFIED;
 		goto error;
-- 
1.8.3.1

