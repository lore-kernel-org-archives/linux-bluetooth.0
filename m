Return-Path: <cyrus@holtmann.org>
From: Jakub Pawlowski <jpawlowski@google.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jakub Pawlowski <jpawlowski@google.com>
Subject: [PATCH v1] Bluetooth: add macro for exposing quirks
Date: Wed, 18 Mar 2015 22:21:39 -0700
Message-Id: <1426742499-14185-1-git-send-email-jpawlowski@google.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch adds macro for exposing quirks through debugfs. Exposing
quirks would be useful for making quirk dependent BlueZ tests using
vhci. Currently there is no way to test that. It might be also
useful for manual testing.

This patch also uses this macro to expose first two quirks.

Signed-off-by: Jakub Pawlowski <jpawlowski@google.com>
---
 net/bluetooth/hci_debugfs.c | 44 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/net/bluetooth/hci_debugfs.c b/net/bluetooth/hci_debugfs.c
index 0818fab..fd39422 100644
--- a/net/bluetooth/hci_debugfs.c
+++ b/net/bluetooth/hci_debugfs.c
@@ -28,6 +28,43 @@
 
 #include "hci_debugfs.h"
 
+#define DEFINE_QUIRK_ATTRIBUTE(ATTRIBUTE_NAME, QUIRK_NAME)		      \
+static int QUIRK_NAME##_set(void *data, u64 val)			      \
+{									      \
+	struct hci_dev *hdev = data;					      \
+									      \
+	if (val != 0 && val != 1)					      \
+		return -EINVAL;						      \
+									      \
+	/* don't modify quirk if controller is powered */		      \
+	if (hdev_is_powered(hdev)) {					      \
+		BT_ERR("Cannot modify quirk when controller is powered");     \
+		return -EINVAL;						      \
+	}								      \
+									      \
+	hci_dev_lock(hdev);						      \
+	if (val == 0)							      \
+		clear_bit(QUIRK_NAME, &hdev->quirks);			      \
+	else								      \
+		set_bit(QUIRK_NAME, &hdev->quirks);			      \
+									      \
+	hci_dev_unlock(hdev);						      \
+	return 0;							      \
+}									      \
+									      \
+static int QUIRK_NAME##_get(void *data, u64 *val)			      \
+{									      \
+	struct hci_dev *hdev = data;					      \
+									      \
+	hci_dev_lock(hdev);						      \
+	*val = test_bit(QUIRK_NAME, &hdev->quirks);			      \
+	hci_dev_unlock(hdev);						      \
+	return 0;							      \
+}									      \
+									      \
+DEFINE_SIMPLE_ATTRIBUTE(ATTRIBUTE_NAME, QUIRK_NAME##_get,		      \
+			QUIRK_NAME##_set, "%llu\n")			      \
+
 static int features_show(struct seq_file *f, void *ptr)
 {
 	struct hci_dev *hdev = f->private;
@@ -277,6 +314,9 @@ static const struct file_operations sc_only_mode_fops = {
 	.llseek		= default_llseek,
 };
 
+DEFINE_QUIRK_ATTRIBUTE(hci_quirk_sdf_fops, HCI_QUIRK_STRICT_DUPLICATE_FILTER);
+DEFINE_QUIRK_ATTRIBUTE(hci_quirk_sd_fops, HCI_QUIRK_SIMULTANEOUS_DISCOVERY);
+
 void hci_debugfs_create_common(struct hci_dev *hdev)
 {
 	debugfs_create_file("features", 0444, hdev->debugfs, hdev,
@@ -308,6 +348,10 @@ void hci_debugfs_create_common(struct hci_dev *hdev)
 	if (lmp_sc_capable(hdev) || lmp_le_capable(hdev))
 		debugfs_create_file("sc_only_mode", 0444, hdev->debugfs,
 				    hdev, &sc_only_mode_fops);
+	debugfs_create_file("HCI_QUIRK_STRICT_DUPLICATE_FILTER", 0644,
+			    hdev->debugfs, hdev, &hci_quirk_sdf_fops);
+	debugfs_create_file("HCI_QUIRK_SIMULTANEOUS_DISCOVERY", 0644,
+			    hdev->debugfs, hdev, &hci_quirk_sd_fops);
 }
 
 static int inquiry_cache_show(struct seq_file *f, void *p)
-- 
2.2.0.rc0.207.ga3a616c

