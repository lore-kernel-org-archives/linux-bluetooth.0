Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH] Bluetooth: Add new debugfs parameter
Date: Sun, 23 Mar 2014 23:09:31 +0100
Message-ID: <1395612571-5365-1-git-send-email-lukasz.rymanowski@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

With this patch it is possible to control discovery interleaved
timeout value from debugfs. Default value is 5120 ms.

It is useful to control it in case of automated testaces where bredrle
controler is doing discovery and it is waiting for inquiry results. With
this patch we can decrease le scan time and get inquiry results faster.

It might be also useful in other test cases.

Signed-off-by: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
---
 include/net/bluetooth/hci_core.h | 2 +-
 net/bluetooth/hci_core.c         | 6 ++++++
 net/bluetooth/mgmt.c             | 2 +-
 3 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 5f8bc05..2d63ade 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -194,6 +194,7 @@ struct hci_dev {
 	__u16		le_scan_window;
 	__u16		le_conn_min_interval;
 	__u16		le_conn_max_interval;
+	__u32		discov_interl_timeout;
 	__u8		ssp_debug_mode;
 
 	__u16		devid_source;
@@ -1205,7 +1206,6 @@ void hci_sock_dev_event(struct hci_dev *hdev, int event);
 #define DISCOV_LE_SCAN_WIN		0x12
 #define DISCOV_LE_SCAN_INT		0x12
 #define DISCOV_LE_TIMEOUT		msecs_to_jiffies(10240)
-#define DISCOV_INTERLEAVED_TIMEOUT	msecs_to_jiffies(5120)
 #define DISCOV_INTERLEAVED_INQUIRY_LEN	0x04
 #define DISCOV_BREDR_INQUIRY_LEN	0x08
 
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 1c6ffaa..b2139f1 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -61,6 +61,9 @@ static void hci_notify(struct hci_dev *hdev, int event)
 
 /* ---- HCI debugfs entries ---- */
 
+/* Discovery interleaved timeout */
+static u16 discov_timeout_ms = 5120;
+
 static ssize_t dut_mode_read(struct file *file, char __user *user_buf,
 			     size_t count, loff_t *ppos)
 {
@@ -1828,6 +1831,8 @@ static int __hci_init(struct hci_dev *hdev)
 				    &lowpan_debugfs_fops);
 		debugfs_create_file("le_auto_conn", 0644, hdev->debugfs, hdev,
 				    &le_auto_conn_fops);
+		debugfs_create_u16("discov_interleaved_timeout", 0644,
+				   bt_debugfs, &discov_timeout_ms);
 	}
 
 	return 0;
@@ -3792,6 +3797,7 @@ struct hci_dev *hci_alloc_dev(void)
 
 	hdev->rpa_timeout = HCI_DEFAULT_RPA_TIMEOUT;
 
+	hdev->discov_interl_timeout = msecs_to_jiffies(discov_timeout_ms);
 	mutex_init(&hdev->lock);
 	mutex_init(&hdev->req_lock);
 
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index d2d4e0d..3eedb87 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -3372,7 +3372,7 @@ static void start_discovery_complete(struct hci_dev *hdev, u8 status)
 
 	case DISCOV_TYPE_INTERLEAVED:
 		queue_delayed_work(hdev->workqueue, &hdev->le_scan_disable,
-				   DISCOV_INTERLEAVED_TIMEOUT);
+				   hdev->discov_interl_timeout);
 		break;
 
 	case DISCOV_TYPE_BREDR:
-- 
1.8.4

