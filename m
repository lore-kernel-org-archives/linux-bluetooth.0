Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/2] Bluetooth: Use RPAs for SMP when used in LE connection establishment
Date: Wed, 26 Feb 2014 21:54:38 -0800
Message-Id: <1393480478-49167-2-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

When a LE connection has been established using RPAs either for the
local or peer address, the SMP requires to the RPA and not the identity
address. The HCI connection structure might already resolved the RPA
into the identity address and identity address type. So if the RPA
is stored, then use it for SMP.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 net/bluetooth/smp.c | 94 +++++++++++++++++++++++++++++++++++++++++++----------
 1 file changed, 77 insertions(+), 17 deletions(-)

diff --git a/net/bluetooth/smp.c b/net/bluetooth/smp.c
index 0de98fe23330..13dee699c25b 100644
--- a/net/bluetooth/smp.c
+++ b/net/bluetooth/smp.c
@@ -437,22 +437,52 @@ static void confirm_work(struct work_struct *work)
 	struct hci_dev *hdev = conn->hcon->hdev;
 	struct crypto_blkcipher *tfm = hdev->tfm_aes;
 	struct smp_cmd_pairing_confirm cp;
-	int ret;
+	bdaddr_t *init_addr, *resp_addr;
+	u8 init_addr_type, resp_addr_type;
 	u8 res[16], reason;
+	int ret;
 
 	BT_DBG("conn %p", conn);
 
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
+	if (conn->hcon->out) {
+		if (bacmp(&conn->hcon->src_rpa, BDADDR_ANY)) {
+			init_addr = &conn->hcon->src_rpa;
+			init_addr_type = ADDR_LE_DEV_RANDOM;
+		} else {
+			init_addr = &conn->hcon->src;
+			init_addr_type = conn->hcon->src_type;
+		}
+
+		if (bacmp(&conn->hcon->dst_rpa, BDADDR_ANY)) {
+			resp_addr = &conn->hcon->dst_rpa;
+			resp_addr_type = ADDR_LE_DEV_RANDOM;
+		} else {
+			resp_addr = &conn->hcon->dst;
+			resp_addr_type = conn->hcon->dst_type;
+		}
+	} else {
+		if (bacmp(&conn->hcon->dst_rpa, BDADDR_ANY)) {
+			init_addr = &conn->hcon->dst_rpa;
+			init_addr_type = ADDR_LE_DEV_RANDOM;
+		} else {
+			init_addr = &conn->hcon->dst;
+			init_addr_type = conn->hcon->dst_type;
+		}
+
+		if (bacmp(&conn->hcon->src_rpa, BDADDR_ANY)) {
+			resp_addr = &conn->hcon->src_rpa;
+			resp_addr_type = ADDR_LE_DEV_RANDOM;
+		} else {
+			resp_addr = &conn->hcon->src;
+			resp_addr_type = conn->hcon->src_type;
+		}
+	}
+
+	ret = smp_c1(tfm, smp->tk, smp->prnd, smp->preq, smp->prsp,
+		     init_addr_type, init_addr, resp_addr_type, resp_addr, res);
 
 	hci_dev_unlock(hdev);
 
@@ -479,6 +509,8 @@ static void random_work(struct work_struct *work)
 	struct hci_conn *hcon = conn->hcon;
 	struct hci_dev *hdev = hcon->hdev;
 	struct crypto_blkcipher *tfm = hdev->tfm_aes;
+	bdaddr_t *init_addr, *resp_addr;
+	u8 init_addr_type, resp_addr_type;
 	u8 reason, confirm[16], res[16], key[16];
 	int ret;
 
@@ -492,14 +524,42 @@ static void random_work(struct work_struct *work)
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
+	if (conn->hcon->out) {
+		if (bacmp(&conn->hcon->src_rpa, BDADDR_ANY)) {
+			init_addr = &conn->hcon->src_rpa;
+			init_addr_type = ADDR_LE_DEV_RANDOM;
+		} else {
+			init_addr = &conn->hcon->src;
+			init_addr_type = conn->hcon->src_type;
+		}
+
+		if (bacmp(&conn->hcon->dst_rpa, BDADDR_ANY)) {
+			resp_addr = &conn->hcon->dst_rpa;
+			resp_addr_type = ADDR_LE_DEV_RANDOM;
+		} else {
+			resp_addr = &conn->hcon->dst;
+			resp_addr_type = conn->hcon->dst_type;
+		}
+	} else {
+		if (bacmp(&conn->hcon->dst_rpa, BDADDR_ANY)) {
+			init_addr = &conn->hcon->dst_rpa;
+			init_addr_type = ADDR_LE_DEV_RANDOM;
+		} else {
+			init_addr = &conn->hcon->dst;
+			init_addr_type = conn->hcon->dst_type;
+		}
+
+		if (bacmp(&conn->hcon->src_rpa, BDADDR_ANY)) {
+			resp_addr = &conn->hcon->src_rpa;
+			resp_addr_type = ADDR_LE_DEV_RANDOM;
+		} else {
+			resp_addr = &conn->hcon->src;
+			resp_addr_type = conn->hcon->src_type;
+		}
+	}
+
+	ret = smp_c1(tfm, smp->tk, smp->rrnd, smp->preq, smp->prsp,
+		     init_addr_type, init_addr, resp_addr_type, resp_addr, res);
 
 	hci_dev_unlock(hdev);
 
-- 
1.8.5.3

