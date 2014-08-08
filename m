Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 3/5] Bluetooth: Refactor SMP (de)initialization into separate functions
Date: Fri,  8 Aug 2014 09:32:50 +0300
Message-Id: <1407479572-4868-4-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1407479572-4868-1-git-send-email-johan.hedberg@gmail.com>
References: <1407479572-4868-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

As preparation for converting SMP to use the l2cap_chan infrastructure
refactor the (de)initialization into separate functions.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/hci_core.c | 46 ++++++++++++++++++++++++++++++++++------------
 1 file changed, 34 insertions(+), 12 deletions(-)

diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 4a1ec259099e..1f691c50abbc 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -1764,6 +1764,34 @@ static void hci_init4_req(struct hci_request *req, unsigned long opt)
 	}
 }
 
+static int hci_register_smp(struct hci_dev *hdev)
+{
+	int err;
+
+	BT_DBG("%s", hdev->name);
+
+	hdev->tfm_aes = crypto_alloc_blkcipher("ecb(aes)", 0,
+					       CRYPTO_ALG_ASYNC);
+	if (IS_ERR(hdev->tfm_aes)) {
+		BT_ERR("Unable to create crypto context");
+		err = PTR_ERR(hdev->tfm_aes);
+		hdev->tfm_aes = NULL;
+		return err;
+	}
+
+	return 0;
+}
+
+static void hci_unregister_smp(struct hci_dev *hdev)
+{
+	BT_DBG("%s", hdev->name);
+
+	if (hdev->tfm_aes) {
+		crypto_free_blkcipher(hdev->tfm_aes);
+		hdev->tfm_aes = NULL;
+	}
+}
+
 static int __hci_init(struct hci_dev *hdev)
 {
 	int err;
@@ -4099,18 +4127,13 @@ int hci_register_dev(struct hci_dev *hdev)
 
 	dev_set_name(&hdev->dev, "%s", hdev->name);
 
-	hdev->tfm_aes = crypto_alloc_blkcipher("ecb(aes)", 0,
-					       CRYPTO_ALG_ASYNC);
-	if (IS_ERR(hdev->tfm_aes)) {
-		BT_ERR("Unable to create crypto context");
-		error = PTR_ERR(hdev->tfm_aes);
-		hdev->tfm_aes = NULL;
+	error = hci_register_smp(hdev);
+	if (error)
 		goto err_wqueue;
-	}
 
 	error = device_add(&hdev->dev);
 	if (error < 0)
-		goto err_tfm;
+		goto err_smp;
 
 	hdev->rfkill = rfkill_alloc(hdev->name, &hdev->dev,
 				    RFKILL_TYPE_BLUETOOTH, &hci_rfkill_ops,
@@ -4152,8 +4175,8 @@ int hci_register_dev(struct hci_dev *hdev)
 
 	return id;
 
-err_tfm:
-	crypto_free_blkcipher(hdev->tfm_aes);
+err_smp:
+	hci_unregister_smp(hdev);
 err_wqueue:
 	destroy_workqueue(hdev->workqueue);
 	destroy_workqueue(hdev->req_workqueue);
@@ -4205,8 +4228,7 @@ void hci_unregister_dev(struct hci_dev *hdev)
 		rfkill_destroy(hdev->rfkill);
 	}
 
-	if (hdev->tfm_aes)
-		crypto_free_blkcipher(hdev->tfm_aes);
+	hci_unregister_smp(hdev);
 
 	device_del(&hdev->dev);
 
-- 
1.9.3

