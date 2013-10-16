Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Expose inquiry_cache debugfs only on BR/EDR controllers
Date: Wed, 16 Oct 2013 03:28:55 -0700
Message-Id: <1381919335-59602-1-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The inquiry_cache debugfs entry is only valid for BR/EDR capable
controllers. In case of single mode LE-only controllers that
entry is not valid.

Move the creating of the debugfs entries to the end of controller
init and only create the inquiry_cache entry if BR/EDR is actually
supported.

At the same time this avoids creating any debugfs entries for
AMP controllers since none of the entries are valid there.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 net/bluetooth/hci_core.c  | 57 +++++++++++++++++++++++++++++++++++++++++++++--
 net/bluetooth/hci_sysfs.c | 39 --------------------------------
 2 files changed, 55 insertions(+), 41 deletions(-)

diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 2af0bac..73c8def 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -27,8 +27,8 @@
 
 #include <linux/export.h>
 #include <linux/idr.h>
-
 #include <linux/rfkill.h>
+#include <linux/debugfs.h>
 
 #include <net/bluetooth/bluetooth.h>
 #include <net/bluetooth/hci_core.h>
@@ -55,6 +55,44 @@ static void hci_notify(struct hci_dev *hdev, int event)
 	hci_sock_dev_event(hdev, event);
 }
 
+/* ---- HCI debugfs entries ---- */
+
+static int inquiry_cache_show(struct seq_file *f, void *p)
+{
+	struct hci_dev *hdev = f->private;
+	struct discovery_state *cache = &hdev->discovery;
+	struct inquiry_entry *e;
+
+	hci_dev_lock(hdev);
+
+	list_for_each_entry(e, &cache->all, all) {
+		struct inquiry_data *data = &e->data;
+		seq_printf(f, "%pMR %d %d %d 0x%.2x%.2x%.2x 0x%.4x %d %d %u\n",
+			   &data->bdaddr,
+			   data->pscan_rep_mode, data->pscan_period_mode,
+			   data->pscan_mode, data->dev_class[2],
+			   data->dev_class[1], data->dev_class[0],
+			   __le16_to_cpu(data->clock_offset),
+			   data->rssi, data->ssp_mode, e->timestamp);
+	}
+
+	hci_dev_unlock(hdev);
+
+	return 0;
+}
+
+static int inquiry_cache_open(struct inode *inode, struct file *file)
+{
+	return single_open(file, inquiry_cache_show, inode->i_private);
+}
+
+static const struct file_operations inquiry_cache_fops = {
+	.open		= inquiry_cache_open,
+	.read		= seq_read,
+	.llseek		= seq_lseek,
+	.release	= single_release,
+};
+
 /* ---- HCI requests ---- */
 
 static void hci_req_sync_complete(struct hci_dev *hdev, u8 result)
@@ -734,7 +772,22 @@ static int __hci_init(struct hci_dev *hdev)
 	if (err < 0)
 		return err;
 
-	return __hci_req_sync(hdev, hci_init4_req, 0, HCI_INIT_TIMEOUT);
+	err = __hci_req_sync(hdev, hci_init4_req, 0, HCI_INIT_TIMEOUT);
+	if (err < 0)
+		return err;
+
+	/* Only create debugfs entries during the initial setup
+	 * phase and not every time the controller gets powered on.
+	 */
+	if (!test_bit(HCI_SETUP, &hdev->dev_flags))
+		return 0;
+
+	if (lmp_bredr_capable(hdev)) {
+		debugfs_create_file("inquiry_cache", 0444, hdev->debugfs,
+				    hdev, &inquiry_cache_fops);
+	}
+
+	return 0;
 }
 
 static void hci_scan_req(struct hci_request *req, unsigned long opt)
diff --git a/net/bluetooth/hci_sysfs.c b/net/bluetooth/hci_sysfs.c
index edf623a..65ecb9e 100644
--- a/net/bluetooth/hci_sysfs.c
+++ b/net/bluetooth/hci_sysfs.c
@@ -396,42 +396,6 @@ static struct device_type bt_host = {
 	.release = bt_host_release,
 };
 
-static int inquiry_cache_show(struct seq_file *f, void *p)
-{
-	struct hci_dev *hdev = f->private;
-	struct discovery_state *cache = &hdev->discovery;
-	struct inquiry_entry *e;
-
-	hci_dev_lock(hdev);
-
-	list_for_each_entry(e, &cache->all, all) {
-		struct inquiry_data *data = &e->data;
-		seq_printf(f, "%pMR %d %d %d 0x%.2x%.2x%.2x 0x%.4x %d %d %u\n",
-			   &data->bdaddr,
-			   data->pscan_rep_mode, data->pscan_period_mode,
-			   data->pscan_mode, data->dev_class[2],
-			   data->dev_class[1], data->dev_class[0],
-			   __le16_to_cpu(data->clock_offset),
-			   data->rssi, data->ssp_mode, e->timestamp);
-	}
-
-	hci_dev_unlock(hdev);
-
-	return 0;
-}
-
-static int inquiry_cache_open(struct inode *inode, struct file *file)
-{
-	return single_open(file, inquiry_cache_show, inode->i_private);
-}
-
-static const struct file_operations inquiry_cache_fops = {
-	.open		= inquiry_cache_open,
-	.read		= seq_read,
-	.llseek		= seq_lseek,
-	.release	= single_release,
-};
-
 static int blacklist_show(struct seq_file *f, void *p)
 {
 	struct hci_dev *hdev = f->private;
@@ -562,9 +526,6 @@ int hci_add_sysfs(struct hci_dev *hdev)
 	if (!hdev->debugfs)
 		return 0;
 
-	debugfs_create_file("inquiry_cache", 0444, hdev->debugfs,
-			    hdev, &inquiry_cache_fops);
-
 	debugfs_create_file("blacklist", 0444, hdev->debugfs,
 			    hdev, &blacklist_fops);
 
-- 
1.8.3.1

