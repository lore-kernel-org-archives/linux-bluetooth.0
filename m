Return-Path: <cyrus@holtmann.org>
From: Andre Guedes <andre.guedes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 3/5] Bluetooth: Export discovery parameters to debugfs
Date: Fri, 23 Aug 2013 17:01:09 -0300
Message-Id: <1377288071-3664-3-git-send-email-andre.guedes@openbossa.org>
In-Reply-To: <1377288071-3664-1-git-send-email-andre.guedes@openbossa.org>
References: <1377288071-3664-1-git-send-email-andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch exports discovery parameters under hciX directory. All
parameter files have read and write permissions. This means, we
are able to change discovery parameters by writing new values into
the files. For instance, to change the default value for the scanning
interval we can run:
$ echo 0x0016 > /sys/kernel/debug/bluetooth/hci0/discov_scan_interval

Signed-off-by: Andre Guedes <andre.guedes@openbossa.org>
---
 net/bluetooth/hci_sysfs.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/net/bluetooth/hci_sysfs.c b/net/bluetooth/hci_sysfs.c
index c89032c..78ef738 100644
--- a/net/bluetooth/hci_sysfs.c
+++ b/net/bluetooth/hci_sysfs.c
@@ -545,11 +545,36 @@ void hci_init_sysfs(struct hci_dev *hdev)
 /* This function expects hdev has been already intialized */
 void hci_sysfs_export_info(struct hci_dev *hdev)
 {
+	struct discovery_param *discov = &hdev->discovery_param;
+
 	if (lmp_bredr_capable(hdev)) {
 		debugfs_create_file("inquiry_cache", 0444, hdev->debugfs,
 				    hdev, &inquiry_cache_fops);
 		debugfs_create_file("auto_accept_delay", 0444, hdev->debugfs,
 				    hdev, &auto_accept_delay_fops);
+		debugfs_create_x8("discov_bredr_inq_len", S_IRUSR|S_IWUSR,
+				  hdev->debugfs,
+				  &discov->bredr_inquiry_length);
+	}
+
+	if (lmp_le_capable(hdev)) {
+		debugfs_create_x8("discov_scan_type", S_IRUSR|S_IWUSR,
+				  hdev->debugfs, &discov->scan_type);
+		debugfs_create_x16("discov_scan_interval", S_IRUSR|S_IWUSR,
+				   hdev->debugfs, &discov->scan_interval);
+		debugfs_create_x16("discov_scan_window", S_IRUSR|S_IWUSR,
+				   hdev->debugfs, &discov->scan_window);
+		debugfs_create_u16("discov_le_scan_timeout", S_IRUSR|S_IWUSR,
+				   hdev->debugfs, &discov->le_scan_timeout);
+	}
+
+	if (lmp_le_capable(hdev) && lmp_bredr_capable(hdev)) {
+		debugfs_create_x8("discov_interleaved_inq_len",
+				  S_IRUSR|S_IWUSR, hdev->debugfs,
+				   &discov->interleaved_inquiry_length);
+		debugfs_create_u16("discov_interleaved_scan_timeout",
+				   S_IRUSR|S_IWUSR, hdev->debugfs,
+				   &discov->interleaved_scan_timeout);
 	}
 }
 
-- 
1.8.3.4

