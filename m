Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Expose hardware error code as debugfs entry
Date: Sat, 31 Jan 2015 19:54:39 -0800
Message-Id: <1422762879-5998-1-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

When the Hardware Error event is send by the controller, the Bluetooth
core stores the error code. Expose it via debugfs so it can be retrieved
later on.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 net/bluetooth/hci_debugfs.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/bluetooth/hci_debugfs.c b/net/bluetooth/hci_debugfs.c
index 2272384755d5..5353f6ec8d68 100644
--- a/net/bluetooth/hci_debugfs.c
+++ b/net/bluetooth/hci_debugfs.c
@@ -256,6 +256,9 @@ void hci_debugfs_create_common(struct hci_dev *hdev)
 			   &hdev->manufacturer);
 	debugfs_create_u8("hci_version", 0444, hdev->debugfs, &hdev->hci_ver);
 	debugfs_create_u16("hci_revision", 0444, hdev->debugfs, &hdev->hci_rev);
+	debugfs_create_u8("hardware_error", 0444, hdev->debugfs,
+			  &hdev->hw_error_code);
+
 	debugfs_create_file("device_list", 0444, hdev->debugfs, hdev,
 			    &device_list_fops);
 	debugfs_create_file("blacklist", 0444, hdev->debugfs, hdev,
-- 
2.1.0

