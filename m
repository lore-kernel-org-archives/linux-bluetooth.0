Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/2] Bluetooth: Expose debugfs entry read/write own address type
Date: Fri, 18 Oct 2013 16:38:10 -0700
Message-Id: <1382139490-306-2-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

For some testing it is important to know the current own addres type,
but also be able to change it. The change is lost over powery cycles
and only intended for debugging.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 net/bluetooth/hci_core.c | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index c130a23..d47c8ec 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -385,6 +385,34 @@ static const struct file_operations static_address_fops = {
 	.release	= single_release,
 };
 
+static int own_address_type_set(void *data, u64 val)
+{
+	struct hci_dev *hdev = data;
+
+	if (val != 0 && val != 1)
+		return -EINVAL;
+
+	hci_dev_lock(hdev);
+	hdev->own_addr_type = val;
+	hci_dev_unlock(hdev);
+
+	return 0;
+}
+
+static int own_address_type_get(void *data, u64 *val)
+{
+	struct hci_dev *hdev = data;
+
+	hci_dev_lock(hdev);
+	*val = hdev->own_addr_type;
+	hci_dev_unlock(hdev);
+
+	return 0;
+}
+
+DEFINE_SIMPLE_ATTRIBUTE(own_address_type_fops, own_address_type_get,
+			own_address_type_set, "%llu\n");
+
 static int long_term_keys_show(struct seq_file *f, void *ptr)
 {
 	struct hci_dev *hdev = f->private;
@@ -1162,6 +1190,8 @@ static int __hci_init(struct hci_dev *hdev)
 				  &hdev->le_white_list_size);
 		debugfs_create_file("static_address", 0444, hdev->debugfs,
 				   hdev, &static_address_fops);
+		debugfs_create_file("own_address_type", 0644, hdev->debugfs,
+				    hdev, &own_address_type_fops);
 		debugfs_create_file("long_term_keys", 0400, hdev->debugfs,
 				    hdev, &long_term_keys_fops);
 	}
-- 
1.8.3.1

