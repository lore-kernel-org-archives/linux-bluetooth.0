Return-Path: <cyrus@holtmann.org>
From: Frederic Danis <frederic.danis@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 4/7] Bluetooth: btbcm: Split setup() function
Date: Fri, 10 Apr 2015 15:37:43 +0200
Message-Id: <1428673066-1349-4-git-send-email-frederic.danis@linux.intel.com>
In-Reply-To: <1428673066-1349-1-git-send-email-frederic.danis@linux.intel.com>
References: <1428673066-1349-1-git-send-email-frederic.danis@linux.intel.com>
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

BCM firmware loading will reset controller speed to default one.
So we need to split it in 2 functions done before and after this speed
change.

Signed-off-by: Frederic Danis <frederic.danis@linux.intel.com>
---
 drivers/bluetooth/btbcm.c | 33 ++++++++++++++++++++++-----------
 drivers/bluetooth/btbcm.h |  6 ++++++
 2 files changed, 28 insertions(+), 11 deletions(-)

diff --git a/drivers/bluetooth/btbcm.c b/drivers/bluetooth/btbcm.c
index 47e0563..f7802c4 100644
--- a/drivers/bluetooth/btbcm.c
+++ b/drivers/bluetooth/btbcm.c
@@ -283,7 +283,7 @@ int btbcm_setup_patchram(struct hci_dev *hdev)
 	err = request_firmware(&fw, fw_name, &hdev->dev);
 	if (err < 0) {
 		BT_INFO("%s: BCM: patch %s not found", hdev->name, fw_name);
-		return 0;
+		return -ENOENT;
 	}
 
 	/* Start Download */
@@ -292,7 +292,7 @@ int btbcm_setup_patchram(struct hci_dev *hdev)
 		err = PTR_ERR(skb);
 		BT_ERR("%s: BCM: Download Minidrv command failed (%d)",
 		       hdev->name, err);
-		goto reset;
+		goto done;
 	}
 	kfree_skb(skb);
 
@@ -313,7 +313,7 @@ int btbcm_setup_patchram(struct hci_dev *hdev)
 			BT_ERR("%s: BCM: patch %s is corrupted", hdev->name,
 			       fw_name);
 			err = -EINVAL;
-			goto reset;
+			goto done;
 		}
 
 		cmd_param = fw_ptr;
@@ -328,7 +328,7 @@ int btbcm_setup_patchram(struct hci_dev *hdev)
 			err = PTR_ERR(skb);
 			BT_ERR("%s: BCM: patch command %04x failed (%d)",
 			       hdev->name, opcode, err);
-			goto reset;
+			goto done;
 		}
 		kfree_skb(skb);
 	}
@@ -336,7 +336,20 @@ int btbcm_setup_patchram(struct hci_dev *hdev)
 	/* 250 msec delay after Launch Ram completes */
 	msleep(250);
 
-reset:
+done:
+	release_firmware(fw);
+
+	return err;
+}
+EXPORT_SYMBOL_GPL(btbcm_setup_patchram);
+
+int btbcm_setup_post(struct hci_dev *hdev)
+{
+	struct sk_buff *skb;
+	struct hci_rp_read_local_version *ver;
+	u16 subver, rev;
+	int err;
+
 	/* Reset */
 	err = btbcm_reset(hdev);
 	if (err)
@@ -354,20 +367,18 @@ reset:
 	subver = le16_to_cpu(ver->lmp_subver);
 	kfree_skb(skb);
 
-	BT_INFO("%s: %s (%3.3u.%3.3u.%3.3u) build %4.4u", hdev->name,
-		hw_name ? : "BCM", (subver & 0x7000) >> 13,
-		(subver & 0x1f00) >> 8, (subver & 0x00ff), rev & 0x0fff);
+	BT_INFO("%s: BCM (%3.3u.%3.3u.%3.3u) build %4.4u", hdev->name,
+		(subver & 0x7000) >> 13, (subver & 0x1f00) >> 8,
+		(subver & 0x00ff), rev & 0x0fff);
 
 	btbcm_check_bdaddr(hdev);
 
 	set_bit(HCI_QUIRK_STRICT_DUPLICATE_FILTER, &hdev->quirks);
 
 done:
-	release_firmware(fw);
-
 	return err;
 }
-EXPORT_SYMBOL_GPL(btbcm_setup_patchram);
+EXPORT_SYMBOL_GPL(btbcm_setup_post);
 
 int btbcm_setup_apple(struct hci_dev *hdev)
 {
diff --git a/drivers/bluetooth/btbcm.h b/drivers/bluetooth/btbcm.h
index 34268ae..245fa30 100644
--- a/drivers/bluetooth/btbcm.h
+++ b/drivers/bluetooth/btbcm.h
@@ -27,6 +27,7 @@ int btbcm_check_bdaddr(struct hci_dev *hdev);
 int btbcm_set_bdaddr(struct hci_dev *hdev, const bdaddr_t *bdaddr);
 
 int btbcm_setup_patchram(struct hci_dev *hdev);
+int btbcm_setup_post(struct hci_dev *hdev);
 int btbcm_setup_apple(struct hci_dev *hdev);
 
 #else
@@ -46,6 +47,11 @@ static inline int btbcm_setup_patchram(struct hci_dev *hdev)
 	return 0;
 }
 
+static inline int btbcm_setup_post(struct hci_dev *hdev)
+{
+	return 0;
+}
+
 static inline int btbcm_setup_apple(struct hci_dev *hdev)
 {
 	return 0;
-- 
1.9.1

