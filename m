Return-Path: <cyrus@holtmann.org>
From: Andre Guedes <andre.guedes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Andre Guedes <andre.guedes@openbossa.org>
Subject: [PATCH 5/5] Bluetooth: Remove enable_smp parameter
Date: Thu, 30 Jun 2011 19:20:56 -0300
Message-Id: <1309472456-24674-5-git-send-email-andre.guedes@openbossa.org>
In-Reply-To: <1309472456-24674-1-git-send-email-andre.guedes@openbossa.org>
References: <1309472456-24674-1-git-send-email-andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The enable_smp parameter is no longer needed. It can be replaced by
checking lmp_host_le_capable.

Signed-off-by: Andre Guedes <andre.guedes@openbossa.org>
---
 net/bluetooth/hci_core.c |   15 +--------------
 net/bluetooth/smp.c      |    9 +++++++++
 2 files changed, 10 insertions(+), 14 deletions(-)

diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index ecc584d..5742aee 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -60,8 +60,6 @@ static void hci_tx_task(unsigned long arg);
 
 static DEFINE_RWLOCK(hci_task_lock);
 
-static int enable_smp;
-
 /* HCI device list */
 LIST_HEAD(hci_dev_list);
 DEFINE_RWLOCK(hci_dev_list_lock);
@@ -1368,14 +1366,6 @@ int hci_add_adv_entry(struct hci_dev *hdev,
 	return 0;
 }
 
-static struct crypto_blkcipher *alloc_cypher(void)
-{
-	if (enable_smp)
-		return crypto_alloc_blkcipher("ecb(aes)", 0, CRYPTO_ALG_ASYNC);
-
-	return ERR_PTR(-ENOTSUPP);
-}
-
 /* Register HCI device */
 int hci_register_dev(struct hci_dev *hdev)
 {
@@ -1460,7 +1450,7 @@ int hci_register_dev(struct hci_dev *hdev)
 	if (!hdev->workqueue)
 		goto nomem;
 
-	hdev->tfm = alloc_cypher();
+	hdev->tfm = crypto_alloc_blkcipher("ecb(aes)", 0, CRYPTO_ALG_ASYNC);
 	if (IS_ERR(hdev->tfm))
 		BT_INFO("Failed to load transform for ecb(aes): %ld",
 							PTR_ERR(hdev->tfm));
@@ -2352,6 +2342,3 @@ static void hci_cmd_task(unsigned long arg)
 		}
 	}
 }
-
-module_param(enable_smp, bool, 0644);
-MODULE_PARM_DESC(enable_smp, "Enable SMP support (LE only)");
diff --git a/net/bluetooth/smp.c b/net/bluetooth/smp.c
index a36f870..ba55bd4 100644
--- a/net/bluetooth/smp.c
+++ b/net/bluetooth/smp.c
@@ -434,6 +434,9 @@ int smp_conn_security(struct l2cap_conn *conn, __u8 sec_level)
 
 	BT_DBG("conn %p hcon %p level 0x%2.2x", conn, hcon, sec_level);
 
+	if (!lmp_host_le_capable(hcon->hdev))
+		return 1;
+
 	if (IS_ERR(hcon->hdev->tfm))
 		return 1;
 
@@ -477,6 +480,12 @@ int smp_sig_channel(struct l2cap_conn *conn, struct sk_buff *skb)
 	__u8 reason;
 	int err = 0;
 
+	if (!lmp_host_le_capable(conn->hcon->hdev)) {
+		err = -ENOTSUPP;
+		reason = SMP_PAIRING_NOTSUPP;
+		goto done;
+	}
+
 	if (IS_ERR(conn->hcon->hdev->tfm)) {
 		err = PTR_ERR(conn->hcon->hdev->tfm);
 		reason = SMP_PAIRING_NOTSUPP;
-- 
1.7.4.1

