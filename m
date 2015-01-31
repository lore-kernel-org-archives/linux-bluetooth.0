Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 1/2] Bluetooth: Expose Secure Simple Pairing debug mode setting in debugfs
Date: Sat, 31 Jan 2015 15:07:51 -0800
Message-Id: <1422745672-27516-1-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The value of the ssp_debug_mode should be accessible via debugfs to be
able to determine if a BR/EDR controller generates debugs keys or not.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 net/bluetooth/hci_debugfs.c | 23 ++++++++++++++++++++++-
 1 file changed, 22 insertions(+), 1 deletion(-)

diff --git a/net/bluetooth/hci_debugfs.c b/net/bluetooth/hci_debugfs.c
index ead89a5ad9ce..51a424cfa94a 100644
--- a/net/bluetooth/hci_debugfs.c
+++ b/net/bluetooth/hci_debugfs.c
@@ -354,6 +354,24 @@ static int voice_setting_get(void *data, u64 *val)
 DEFINE_SIMPLE_ATTRIBUTE(voice_setting_fops, voice_setting_get,
 			NULL, "0x%4.4llx\n");
 
+static ssize_t ssp_debug_mode_read(struct file *file, char __user *user_buf,
+				   size_t count, loff_t *ppos)
+{
+	struct hci_dev *hdev = file->private_data;
+	char buf[3];
+
+	buf[0] = hdev->ssp_debug_mode ? 'Y': 'N';
+	buf[1] = '\n';
+	buf[2] = '\0';
+	return simple_read_from_buffer(user_buf, count, ppos, buf, 2);
+}
+
+static const struct file_operations ssp_debug_mode_fops = {
+	.open		= simple_open,
+	.read		= ssp_debug_mode_read,
+	.llseek		= default_llseek,
+};
+
 static int auto_accept_delay_set(void *data, u64 val)
 {
 	struct hci_dev *hdev = data;
@@ -474,9 +492,12 @@ void hci_debugfs_create_bredr(struct hci_dev *hdev)
 	debugfs_create_file("voice_setting", 0444, hdev->debugfs, hdev,
 			    &voice_setting_fops);
 
-	if (lmp_ssp_capable(hdev))
+	if (lmp_ssp_capable(hdev)) {
+		debugfs_create_file("ssp_debug_mode", 0444, hdev->debugfs,
+				    hdev, &ssp_debug_mode_fops);
 		debugfs_create_file("auto_accept_delay", 0644, hdev->debugfs,
 				    hdev, &auto_accept_delay_fops);
+	}
 
 	if (lmp_sniff_capable(hdev)) {
 		debugfs_create_file("idle_timeout", 0644, hdev->debugfs,
-- 
2.1.0

