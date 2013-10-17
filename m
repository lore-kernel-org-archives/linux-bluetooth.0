Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Expose current voice setting in debugfs
Date: Thu, 17 Oct 2013 12:02:31 -0700
Message-Id: <1382036551-54592-1-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

For easier debugging of the current voice setting, expose the value
in debugfs if the controller is BR/EDR capable.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 net/bluetooth/hci_core.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 3c1014c..b7c4ada 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -93,6 +93,20 @@ static const struct file_operations inquiry_cache_fops = {
 	.release	= single_release,
 };
 
+static int voice_setting_get(void *data, u64 *val)
+{
+	struct hci_dev *hdev = data;
+
+	hci_dev_lock(hdev);
+	*val = hdev->voice_setting;
+	hci_dev_unlock(hdev);
+
+	return 0;
+}
+
+DEFINE_SIMPLE_ATTRIBUTE(voice_setting_fops, voice_setting_get,
+			NULL, "0x%4.4llx\n");
+
 static int auto_accept_delay_set(void *data, u64 val)
 {
 	struct hci_dev *hdev = data;
@@ -833,6 +847,8 @@ static int __hci_init(struct hci_dev *hdev)
 	if (lmp_bredr_capable(hdev)) {
 		debugfs_create_file("inquiry_cache", 0444, hdev->debugfs,
 				    hdev, &inquiry_cache_fops);
+		debugfs_create_file("voice_setting", 0444, hdev->debugfs,
+				    hdev, &voice_setting_fops);
 	}
 
 	if (lmp_ssp_capable(hdev))
-- 
1.8.3.1

