Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/4] Bluetooth: Use hci_conn->src address for SMP functions
Date: Sun, 13 Oct 2013 05:24:00 -0700
Message-Id: <1381667042-46368-2-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The source address is now stored in hci_conn->src and so use that
one for SMP functions.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 net/bluetooth/smp.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/net/bluetooth/smp.c b/net/bluetooth/smp.c
index 06a082ea..f57b209 100644
--- a/net/bluetooth/smp.c
+++ b/net/bluetooth/smp.c
@@ -388,12 +388,12 @@ static void confirm_work(struct work_struct *work)
 
 	if (conn->hcon->out)
 		ret = smp_c1(tfm, smp->tk, smp->prnd, smp->preq, smp->prsp, 0,
-			     &conn->hcon->hdev->bdaddr, conn->hcon->dst_type,
+			     &conn->hcon->src, conn->hcon->dst_type,
 			     &conn->hcon->dst, res);
 	else
 		ret = smp_c1(tfm, smp->tk, smp->prnd, smp->preq, smp->prsp,
 			     conn->hcon->dst_type, &conn->hcon->dst, 0,
-			     &conn->hcon->hdev->bdaddr, res);
+			     &conn->hcon->src, res);
 	if (ret) {
 		reason = SMP_UNSPECIFIED;
 		goto error;
@@ -428,12 +428,10 @@ static void random_work(struct work_struct *work)
 
 	if (hcon->out)
 		ret = smp_c1(tfm, smp->tk, smp->rrnd, smp->preq, smp->prsp, 0,
-			     &hcon->hdev->bdaddr, hcon->dst_type, &hcon->dst,
-			     res);
+			     &hcon->src, hcon->dst_type, &hcon->dst, res);
 	else
 		ret = smp_c1(tfm, smp->tk, smp->rrnd, smp->preq, smp->prsp,
-			     hcon->dst_type, &hcon->dst, 0, &hcon->hdev->bdaddr,
-			     res);
+			     hcon->dst_type, &hcon->dst, 0, &hcon->src, res);
 	if (ret) {
 		reason = SMP_UNSPECIFIED;
 		goto error;
@@ -1011,7 +1009,7 @@ int smp_distribute_keys(struct l2cap_conn *conn, __u8 force)
 
 		/* Just public address */
 		memset(&addrinfo, 0, sizeof(addrinfo));
-		bacpy(&addrinfo.bdaddr, &conn->hcon->hdev->bdaddr);
+		bacpy(&addrinfo.bdaddr, &conn->hcon->src);
 
 		smp_send_cmd(conn, SMP_CMD_IDENT_ADDR_INFO, sizeof(addrinfo),
 								&addrinfo);
-- 
1.8.3.1

