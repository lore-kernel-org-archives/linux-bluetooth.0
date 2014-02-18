Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 4/9] Bluetooth: Add AES crypto context for each HCI device
Date: Tue, 18 Feb 2014 10:19:32 +0200
Message-Id: <1392711577-31431-4-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1392711577-31431-1-git-send-email-johan.hedberg@gmail.com>
References: <1392711577-31431-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

Previously the crypto context has only been available for LE SMP
sessions, but now that we'll need to perform operations also during
discovery it makes sense to have this context part of the hci_dev
struct. Later, the context can be removed from the SMP context.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 include/net/bluetooth/hci_core.h |  1 +
 net/bluetooth/hci_core.c         | 15 ++++++++++++++-
 2 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 92fa75fce29d..b344890b18f5 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -259,6 +259,7 @@ struct hci_dev {
 	__u32			req_status;
 	__u32			req_result;
 
+	struct crypto_blkcipher	*tfm_aes;
 
 	struct discovery_state	discovery;
 	struct hci_conn_hash	conn_hash;
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index b40d52446f8f..cd1cd7da3235 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -29,6 +29,7 @@
 #include <linux/idr.h>
 #include <linux/rfkill.h>
 #include <linux/debugfs.h>
+#include <linux/crypto.h>
 #include <asm/unaligned.h>
 
 #include <net/bluetooth/bluetooth.h>
@@ -3205,9 +3206,16 @@ int hci_register_dev(struct hci_dev *hdev)
 
 	dev_set_name(&hdev->dev, "%s", hdev->name);
 
+	hdev->tfm_aes = crypto_alloc_blkcipher("ecb(aes)", 0,
+					       CRYPTO_ALG_ASYNC);
+	if (IS_ERR(hdev->tfm_aes)) {
+		BT_ERR("Unable to create crypto context");
+		goto err_wqueue;
+	}
+
 	error = device_add(&hdev->dev);
 	if (error < 0)
-		goto err_wqueue;
+		goto err_tfm;
 
 	hdev->rfkill = rfkill_alloc(hdev->name, &hdev->dev,
 				    RFKILL_TYPE_BLUETOOTH, &hci_rfkill_ops,
@@ -3243,6 +3251,8 @@ int hci_register_dev(struct hci_dev *hdev)
 
 	return id;
 
+err_tfm:
+	crypto_free_blkcipher(hdev->tfm_aes);
 err_wqueue:
 	destroy_workqueue(hdev->workqueue);
 	destroy_workqueue(hdev->req_workqueue);
@@ -3293,6 +3303,9 @@ void hci_unregister_dev(struct hci_dev *hdev)
 		rfkill_destroy(hdev->rfkill);
 	}
 
+	if (hdev->tfm_aes)
+		crypto_free_blkcipher(hdev->tfm_aes);
+
 	device_del(&hdev->dev);
 
 	debugfs_remove_recursive(hdev->debugfs);
-- 
1.8.5.3

