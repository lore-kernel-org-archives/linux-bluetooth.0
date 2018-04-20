Return-Path: <hdegoede@redhat.com>
From: Hans de Goede <hdegoede@redhat.com>
To: Marcel Holtmann <marcel@holtmann.org>,
	Gustavo Padovan <gustavo@padovan.org>,
	Johan Hedberg <johan.hedberg@gmail.com>
Cc: Hans de Goede <hdegoede@redhat.com>,
	=?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?= <frederic.danis.oss@gmail.com>,
	Lukas Wunner <lukas@wunner.de>,
	linux-bluetooth@vger.kernel.org,
	linux-serial@vger.kernel.org,
	linux-acpi@vger.kernel.org
Subject: [PATCH 4/6] Bluetooth: btbcm: Allow using btbcm_initialize() for reinit
Date: Fri, 20 Apr 2018 14:44:05 +0200
Message-Id: <20180420124407.19712-4-hdegoede@redhat.com>
In-Reply-To: <20180420124407.19712-1-hdegoede@redhat.com>
References: <20180420124407.19712-1-hdegoede@redhat.com>
List-ID: <linux-bluetooth.vger.kernel.org>

btbcm_finalize() does a re-init of the controller, which is almost the
same as the initial init. Modify btbcm_initialize() so that it can be
used for this re-init and modify btbcm_finalize() to use it.

As an added bonus this also makes the dev_info from btbcm_finalize()
use the proper hw_name instead of always printing "BCM".

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 drivers/bluetooth/btbcm.c   | 33 ++++++++++-----------------------
 drivers/bluetooth/btbcm.h   |  5 +++--
 drivers/bluetooth/hci_bcm.c |  2 +-
 3 files changed, 14 insertions(+), 26 deletions(-)

diff --git a/drivers/bluetooth/btbcm.c b/drivers/bluetooth/btbcm.c
index dd243afe32de..fdcbeb489a2e 100644
--- a/drivers/bluetooth/btbcm.c
+++ b/drivers/bluetooth/btbcm.c
@@ -346,7 +346,8 @@ static const struct bcm_subver_table bcm_usb_subver_table[] = {
 	{ }
 };
 
-int btbcm_initialize(struct hci_dev *hdev, char *fw_name, size_t len)
+int btbcm_initialize(struct hci_dev *hdev, char *fw_name, size_t len,
+		     bool reinit)
 {
 	u16 subver, rev, pid, vid;
 	const char *hw_name = NULL;
@@ -371,9 +372,11 @@ int btbcm_initialize(struct hci_dev *hdev, char *fw_name, size_t len)
 	kfree_skb(skb);
 
 	/* Read controller information */
-	err = btbcm_read_info(hdev);
-	if (err)
-		return err;
+	if (!reinit) {
+		err = btbcm_read_info(hdev);
+		if (err)
+			return err;
+	}
 
 	/* Upper nibble of rev should be between 0 and 3? */
 	if (((rev & 0xf000) >> 12) > 3)
@@ -416,30 +419,14 @@ EXPORT_SYMBOL_GPL(btbcm_initialize);
 
 int btbcm_finalize(struct hci_dev *hdev)
 {
-	struct sk_buff *skb;
-	struct hci_rp_read_local_version *ver;
-	u16 subver, rev;
+	char fw_name[64];
 	int err;
 
-	/* Reset */
-	err = btbcm_reset(hdev);
+	/* Re-initialize */
+	err = btbcm_initialize(hdev, fw_name, sizeof(fw_name), true);
 	if (err)
 		return err;
 
-	/* Read Local Version Info */
-	skb = btbcm_read_local_version(hdev);
-	if (IS_ERR(skb))
-		return PTR_ERR(skb);
-
-	ver = (struct hci_rp_read_local_version *)skb->data;
-	rev = le16_to_cpu(ver->hci_rev);
-	subver = le16_to_cpu(ver->lmp_subver);
-	kfree_skb(skb);
-
-	bt_dev_info(hdev, "BCM (%3.3u.%3.3u.%3.3u) build %4.4u",
-		    (subver & 0xe000) >> 13, (subver & 0x1f00) >> 8,
-		    (subver & 0x00ff), rev & 0x0fff);
-
 	btbcm_check_bdaddr(hdev);
 
 	set_bit(HCI_QUIRK_STRICT_DUPLICATE_FILTER, &hdev->quirks);
diff --git a/drivers/bluetooth/btbcm.h b/drivers/bluetooth/btbcm.h
index cfe6ad4cc621..5346515c880c 100644
--- a/drivers/bluetooth/btbcm.h
+++ b/drivers/bluetooth/btbcm.h
@@ -73,7 +73,8 @@ int btbcm_patchram(struct hci_dev *hdev, const struct firmware *fw);
 int btbcm_setup_patchram(struct hci_dev *hdev);
 int btbcm_setup_apple(struct hci_dev *hdev);
 
-int btbcm_initialize(struct hci_dev *hdev, char *fw_name, size_t len);
+int btbcm_initialize(struct hci_dev *hdev, char *fw_name, size_t len,
+		     bool reinit);
 int btbcm_finalize(struct hci_dev *hdev);
 
 #else
@@ -104,7 +105,7 @@ static inline int btbcm_setup_apple(struct hci_dev *hdev)
 }
 
 static inline int btbcm_initialize(struct hci_dev *hdev, char *fw_name,
-				   size_t len)
+				   size_t len, bool reinit)
 {
 	return 0;
 }
diff --git a/drivers/bluetooth/hci_bcm.c b/drivers/bluetooth/hci_bcm.c
index 04c4b93b4c6f..f06f0f1132fb 100644
--- a/drivers/bluetooth/hci_bcm.c
+++ b/drivers/bluetooth/hci_bcm.c
@@ -501,7 +501,7 @@ static int bcm_setup(struct hci_uart *hu)
 	hu->hdev->set_diag = bcm_set_diag;
 	hu->hdev->set_bdaddr = btbcm_set_bdaddr;
 
-	err = btbcm_initialize(hu->hdev, fw_name, sizeof(fw_name));
+	err = btbcm_initialize(hu->hdev, fw_name, sizeof(fw_name), false);
 	if (err)
 		return err;
 
-- 
2.17.0
