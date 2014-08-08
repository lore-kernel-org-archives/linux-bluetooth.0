Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 5/5] Bluetooth: Move SMP (de)initialization to smp.c
Date: Fri,  8 Aug 2014 09:32:52 +0300
Message-Id: <1407479572-4868-6-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1407479572-4868-1-git-send-email-johan.hedberg@gmail.com>
References: <1407479572-4868-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

As preparation for moving SMP to use l2cap_chan infrastructure we need
to move the (de)initialization functions to smp.c (where they'll
eventually need access to the local L2CAP channel callbacks).

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/hci_core.c | 32 ++------------------------------
 net/bluetooth/smp.c      | 26 ++++++++++++++++++++++++++
 net/bluetooth/smp.h      |  3 +++
 3 files changed, 31 insertions(+), 30 deletions(-)

diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 9eb2869b183b..88575a633601 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -1764,34 +1764,6 @@ static void hci_init4_req(struct hci_request *req, unsigned long opt)
 	}
 }
 
-static int hci_register_smp(struct hci_dev *hdev)
-{
-	int err;
-
-	BT_DBG("%s", hdev->name);
-
-	hdev->tfm_aes = crypto_alloc_blkcipher("ecb(aes)", 0,
-					       CRYPTO_ALG_ASYNC);
-	if (IS_ERR(hdev->tfm_aes)) {
-		BT_ERR("Unable to create crypto context");
-		err = PTR_ERR(hdev->tfm_aes);
-		hdev->tfm_aes = NULL;
-		return err;
-	}
-
-	return 0;
-}
-
-static void hci_unregister_smp(struct hci_dev *hdev)
-{
-	BT_DBG("%s", hdev->name);
-
-	if (hdev->tfm_aes) {
-		crypto_free_blkcipher(hdev->tfm_aes);
-		hdev->tfm_aes = NULL;
-	}
-}
-
 static int __hci_init(struct hci_dev *hdev)
 {
 	int err;
@@ -1927,7 +1899,7 @@ static int __hci_init(struct hci_dev *hdev)
 				   hdev->debugfs,
 				   &hdev->discov_interleaved_timeout);
 
-		hci_register_smp(hdev);
+		smp_register(hdev);
 	}
 
 	return 0;
@@ -4224,7 +4196,7 @@ void hci_unregister_dev(struct hci_dev *hdev)
 		rfkill_destroy(hdev->rfkill);
 	}
 
-	hci_unregister_smp(hdev);
+	smp_unregister(hdev);
 
 	device_del(&hdev->dev);
 
diff --git a/net/bluetooth/smp.c b/net/bluetooth/smp.c
index 33016ec9b247..ab07649ecc77 100644
--- a/net/bluetooth/smp.c
+++ b/net/bluetooth/smp.c
@@ -1455,3 +1455,29 @@ int smp_distribute_keys(struct l2cap_conn *conn)
 
 	return 0;
 }
+
+int smp_register(struct hci_dev *hdev)
+{
+	BT_DBG("%s", hdev->name);
+
+	hdev->tfm_aes = crypto_alloc_blkcipher("ecb(aes)", 0,
+					       CRYPTO_ALG_ASYNC);
+	if (IS_ERR(hdev->tfm_aes)) {
+		int err = PTR_ERR(hdev->tfm_aes);
+		BT_ERR("Unable to create crypto context");
+		hdev->tfm_aes = NULL;
+		return err;
+	}
+
+	return 0;
+}
+
+void smp_unregister(struct hci_dev *hdev)
+{
+	BT_DBG("%s", hdev->name);
+
+	if (hdev->tfm_aes) {
+		crypto_free_blkcipher(hdev->tfm_aes);
+		hdev->tfm_aes = NULL;
+	}
+}
diff --git a/net/bluetooth/smp.h b/net/bluetooth/smp.h
index 796f4f45f92f..6e29359f60a3 100644
--- a/net/bluetooth/smp.h
+++ b/net/bluetooth/smp.h
@@ -136,4 +136,7 @@ bool smp_irk_matches(struct crypto_blkcipher *tfm, u8 irk[16],
 		     bdaddr_t *bdaddr);
 int smp_generate_rpa(struct crypto_blkcipher *tfm, u8 irk[16], bdaddr_t *rpa);
 
+int smp_register(struct hci_dev *hdev);
+void smp_unregister(struct hci_dev *hdev);
+
 #endif /* __SMP_H */
-- 
1.9.3

