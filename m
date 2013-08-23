Return-Path: <cyrus@holtmann.org>
From: Andre Guedes <andre.guedes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 5/5] Bluetooth: Export LE connection parameters to debugfs
Date: Fri, 23 Aug 2013 17:01:11 -0300
Message-Id: <1377288071-3664-5-git-send-email-andre.guedes@openbossa.org>
In-Reply-To: <1377288071-3664-1-git-send-email-andre.guedes@openbossa.org>
References: <1377288071-3664-1-git-send-email-andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch exports LE connection parameters under hciX directory if
controller is LE capable. All parameter files have read and write
permissions. This means, we are able to change LE connection parameters
by writing new values into the files. For instance, to change the
default value for supervision_timeout we can run:
$ echo 0x0040 > /sys/kernel/debug/bluetooth/hci0/le_conn_supervision_timeout

Signed-off-by: Andre Guedes <andre.guedes@openbossa.org>
---
 net/bluetooth/hci_sysfs.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/net/bluetooth/hci_sysfs.c b/net/bluetooth/hci_sysfs.c
index 78ef738..ba4f7c7 100644
--- a/net/bluetooth/hci_sysfs.c
+++ b/net/bluetooth/hci_sysfs.c
@@ -546,6 +546,7 @@ void hci_init_sysfs(struct hci_dev *hdev)
 void hci_sysfs_export_info(struct hci_dev *hdev)
 {
 	struct discovery_param *discov = &hdev->discovery_param;
+	struct le_conn_param *conn = &hdev->le_conn_param;
 
 	if (lmp_bredr_capable(hdev)) {
 		debugfs_create_file("inquiry_cache", 0444, hdev->debugfs,
@@ -558,6 +559,7 @@ void hci_sysfs_export_info(struct hci_dev *hdev)
 	}
 
 	if (lmp_le_capable(hdev)) {
+		/* Discovery parameters */
 		debugfs_create_x8("discov_scan_type", S_IRUSR|S_IWUSR,
 				  hdev->debugfs, &discov->scan_type);
 		debugfs_create_x16("discov_scan_interval", S_IRUSR|S_IWUSR,
@@ -566,6 +568,25 @@ void hci_sysfs_export_info(struct hci_dev *hdev)
 				   hdev->debugfs, &discov->scan_window);
 		debugfs_create_u16("discov_le_scan_timeout", S_IRUSR|S_IWUSR,
 				   hdev->debugfs, &discov->le_scan_timeout);
+
+		/* Connection parameters */
+		debugfs_create_x16("le_conn_scan_interval", S_IRUSR|S_IWUSR,
+				   hdev->debugfs, &conn->scan_interval);
+		debugfs_create_x16("le_conn_scan_window", S_IRUSR|S_IWUSR,
+				   hdev->debugfs, &conn->scan_window);
+		debugfs_create_x16("le_conn_interval_min", S_IRUSR|S_IWUSR,
+				   hdev->debugfs, &conn->conn_interval_min);
+		debugfs_create_x16("le_conn_interval_max", S_IRUSR|S_IWUSR,
+				   hdev->debugfs, &conn->conn_interval_max);
+		debugfs_create_x16("le_conn_supervision_timeout",
+				   S_IRUSR|S_IWUSR, hdev->debugfs,
+				   &conn->supervision_timeout);
+		debugfs_create_x16("le_conn_min_ce_lentgh", S_IRUSR|S_IWUSR,
+				   hdev->debugfs, &conn->min_ce_lentgh);
+		debugfs_create_x16("le_conn_max_ce_lentgh", S_IRUSR|S_IWUSR,
+				   hdev->debugfs, &conn->max_ce_lentgh);
+		debugfs_create_x16("le_conn_latency", S_IRUSR|S_IWUSR,
+				   hdev->debugfs, &conn->conn_latency);
 	}
 
 	if (lmp_le_capable(hdev) && lmp_bredr_capable(hdev)) {
-- 
1.8.3.4

