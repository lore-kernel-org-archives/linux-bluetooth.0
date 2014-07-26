Return-Path: <cyrus@holtmann.org>
From: Georg Lukas <georg@op-co.de>
To: linux-bluetooth@vger.kernel.org
Cc: Georg Lukas <georg@op-co.de>
Subject: [PATCH 2/2] Bluetooth: Expose default LE advertising interval via debugfs
Date: Sat, 26 Jul 2014 13:59:58 +0200
Message-Id: <1406375998-15288-3-git-send-email-georg@op-co.de>
In-Reply-To: <1406375998-15288-1-git-send-email-georg@op-co.de>
References: <1406375998-15288-1-git-send-email-georg@op-co.de>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Expose the default values for minimum and maximum LE advertising
interval via debugfs for testing purposes.

Signed-off-by: Georg Lukas <georg@op-co.de>
---
 net/bluetooth/hci_core.c | 60 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 60 insertions(+)

diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 8292bba..3911fef 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -970,6 +970,62 @@ static int adv_channel_map_get(void *data, u64 *val)
 DEFINE_SIMPLE_ATTRIBUTE(adv_channel_map_fops, adv_channel_map_get,
 			adv_channel_map_set, "%llu\n");
 
+static int adv_min_interval_set(void *data, u64 val)
+{
+	struct hci_dev *hdev = data;
+
+	if (val < 0x0020 || val > 0x4000 || val > hdev->le_adv_max_interval)
+		return -EINVAL;
+
+	hci_dev_lock(hdev);
+	hdev->le_adv_min_interval = val;
+	hci_dev_unlock(hdev);
+
+	return 0;
+}
+
+static int adv_min_interval_get(void *data, u64 *val)
+{
+	struct hci_dev *hdev = data;
+
+	hci_dev_lock(hdev);
+	*val = hdev->le_adv_min_interval;
+	hci_dev_unlock(hdev);
+
+	return 0;
+}
+
+DEFINE_SIMPLE_ATTRIBUTE(adv_min_interval_fops, adv_min_interval_get,
+			adv_min_interval_set, "%llu\n");
+
+static int adv_max_interval_set(void *data, u64 val)
+{
+	struct hci_dev *hdev = data;
+
+	if (val < 0x0020 || val > 0x4000 || val < hdev->le_adv_min_interval)
+		return -EINVAL;
+
+	hci_dev_lock(hdev);
+	hdev->le_adv_max_interval = val;
+	hci_dev_unlock(hdev);
+
+	return 0;
+}
+
+static int adv_max_interval_get(void *data, u64 *val)
+{
+	struct hci_dev *hdev = data;
+
+	hci_dev_lock(hdev);
+	*val = hdev->le_adv_max_interval;
+	hci_dev_unlock(hdev);
+
+	return 0;
+}
+
+DEFINE_SIMPLE_ATTRIBUTE(adv_max_interval_fops, adv_max_interval_get,
+			adv_max_interval_set, "%llu\n");
+
 static int device_list_show(struct seq_file *f, void *ptr)
 {
 	struct hci_dev *hdev = f->private;
@@ -1833,6 +1889,10 @@ static int __hci_init(struct hci_dev *hdev)
 				    hdev, &supervision_timeout_fops);
 		debugfs_create_file("adv_channel_map", 0644, hdev->debugfs,
 				    hdev, &adv_channel_map_fops);
+		debugfs_create_file("adv_min_interval", 0644, hdev->debugfs,
+				    hdev, &adv_min_interval_fops);
+		debugfs_create_file("adv_max_interval", 0644, hdev->debugfs,
+				    hdev, &adv_max_interval_fops);
 		debugfs_create_file("device_list", 0444, hdev->debugfs, hdev,
 				    &device_list_fops);
 		debugfs_create_u16("discov_interleaved_timeout", 0644,
-- 
2.0.1

