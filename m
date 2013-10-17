Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Expose auto_accept_delay debugfs only when SSP is supported
Date: Thu, 17 Oct 2013 10:54:46 -0700
Message-Id: <1382032486-31010-1-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The auto_accept_delay debugfs entry is only valid for BR/EDR capable
controllers that also support SSP. If SSP is not available or it is
a LE-only single mode controller this value has no affect and so do
not expose it.

Since the value can be actually changed, switch the permissions
to 0644 to clearly indicate that the value is indeed writeable.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 net/bluetooth/hci_core.c  | 29 +++++++++++++++++++++++++++++
 net/bluetooth/hci_sysfs.c | 31 -------------------------------
 2 files changed, 29 insertions(+), 31 deletions(-)

diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 73c8def..bb95ddd 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -93,6 +93,31 @@ static const struct file_operations inquiry_cache_fops = {
 	.release	= single_release,
 };
 
+static int auto_accept_delay_set(void *data, u64 val)
+{
+	struct hci_dev *hdev = data;
+
+	hci_dev_lock(hdev);
+	hdev->auto_accept_delay = val;
+	hci_dev_unlock(hdev);
+
+	return 0;
+}
+
+static int auto_accept_delay_get(void *data, u64 *val)
+{
+	struct hci_dev *hdev = data;
+
+	hci_dev_lock(hdev);
+	*val = hdev->auto_accept_delay;
+	hci_dev_unlock(hdev);
+
+	return 0;
+}
+
+DEFINE_SIMPLE_ATTRIBUTE(auto_accept_delay_fops, auto_accept_delay_get,
+			auto_accept_delay_set, "%llu\n");
+
 /* ---- HCI requests ---- */
 
 static void hci_req_sync_complete(struct hci_dev *hdev, u8 result)
@@ -787,6 +812,10 @@ static int __hci_init(struct hci_dev *hdev)
 				    hdev, &inquiry_cache_fops);
 	}
 
+	if (lmp_ssp_capable(hdev))
+		debugfs_create_file("auto_accept_delay", 0644, hdev->debugfs,
+				    hdev, &auto_accept_delay_fops);
+
 	return 0;
 }
 
diff --git a/net/bluetooth/hci_sysfs.c b/net/bluetooth/hci_sysfs.c
index 65ecb9e..a141960 100644
--- a/net/bluetooth/hci_sysfs.c
+++ b/net/bluetooth/hci_sysfs.c
@@ -466,35 +466,6 @@ static const struct file_operations uuids_fops = {
 	.release	= single_release,
 };
 
-static int auto_accept_delay_set(void *data, u64 val)
-{
-	struct hci_dev *hdev = data;
-
-	hci_dev_lock(hdev);
-
-	hdev->auto_accept_delay = val;
-
-	hci_dev_unlock(hdev);
-
-	return 0;
-}
-
-static int auto_accept_delay_get(void *data, u64 *val)
-{
-	struct hci_dev *hdev = data;
-
-	hci_dev_lock(hdev);
-
-	*val = hdev->auto_accept_delay;
-
-	hci_dev_unlock(hdev);
-
-	return 0;
-}
-
-DEFINE_SIMPLE_ATTRIBUTE(auto_accept_delay_fops, auto_accept_delay_get,
-			auto_accept_delay_set, "%llu\n");
-
 void hci_init_sysfs(struct hci_dev *hdev)
 {
 	struct device *dev = &hdev->dev;
@@ -531,8 +502,6 @@ int hci_add_sysfs(struct hci_dev *hdev)
 
 	debugfs_create_file("uuids", 0444, hdev->debugfs, hdev, &uuids_fops);
 
-	debugfs_create_file("auto_accept_delay", 0444, hdev->debugfs, hdev,
-			    &auto_accept_delay_fops);
 	return 0;
 }
 
-- 
1.8.3.1

