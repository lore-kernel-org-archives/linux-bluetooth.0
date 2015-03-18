Return-Path: <cyrus@holtmann.org>
From: Jakub Pawlowski <jpawlowski@google.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jakub Pawlowski <jpawlowski@google.com>
Subject: [PATCH] Bluetooth: expose quirks through debugfs
Date: Tue, 17 Mar 2015 22:49:02 -0700
Message-Id: <1426657742-13963-1-git-send-email-jpawlowski@google.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch expose controller quirks through debugfs. It would be
useful for BlueZ tests using vhci. Currently there is no way to
test quirk dependent behaviour. It might be also useful for manual
testing.

Signed-off-by: Jakub Pawlowski <jpawlowski@google.com>
---
 include/net/bluetooth/hci.h |  2 ++
 net/bluetooth/hci_debugfs.c | 29 +++++++++++++++++++++++++++++
 2 files changed, 31 insertions(+)

diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index 06e7eee..e9cec98 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -168,6 +168,8 @@ enum {
 	 * during the hdev->setup vendor callback.
 	 */
 	HCI_QUIRK_SIMULTANEOUS_DISCOVERY,
+
+	__HCI_NUM_QUIRKS
 };
 
 /* HCI device flags */
diff --git a/net/bluetooth/hci_debugfs.c b/net/bluetooth/hci_debugfs.c
index 0818fab..0011d1e 100644
--- a/net/bluetooth/hci_debugfs.c
+++ b/net/bluetooth/hci_debugfs.c
@@ -277,6 +277,33 @@ static const struct file_operations sc_only_mode_fops = {
 	.llseek		= default_llseek,
 };
 
+static int quirks_set(void *data, u64 val)
+{
+	struct hci_dev *hdev = data;
+
+	if (val >= (1 << __HCI_NUM_QUIRKS))
+		return -EINVAL;
+
+	hci_dev_lock(hdev);
+	hdev->quirks = val;
+	hci_dev_unlock(hdev);
+
+	return 0;
+}
+
+static int quirks_get(void *data, u64 *val)
+{
+	struct hci_dev *hdev = data;
+
+	hci_dev_lock(hdev);
+	*val = hdev->quirks;
+	hci_dev_unlock(hdev);
+
+	return 0;
+}
+
+DEFINE_SIMPLE_ATTRIBUTE(quirks_fops, quirks_get, quirks_set, "%llu\n");
+
 void hci_debugfs_create_common(struct hci_dev *hdev)
 {
 	debugfs_create_file("features", 0444, hdev->debugfs, hdev,
@@ -308,6 +335,8 @@ void hci_debugfs_create_common(struct hci_dev *hdev)
 	if (lmp_sc_capable(hdev) || lmp_le_capable(hdev))
 		debugfs_create_file("sc_only_mode", 0444, hdev->debugfs,
 				    hdev, &sc_only_mode_fops);
+
+	debugfs_create_file("quirks", 0644, hdev->debugfs, hdev, &quirks_fops);
 }
 
 static int inquiry_cache_show(struct seq_file *f, void *p)
-- 
2.2.0.rc0.207.ga3a616c

