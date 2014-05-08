Return-Path: <cyrus@holtmann.org>
From: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
Subject: [PATCH 6/8] Bluetooth: Make min interval for connection information configurable
Date: Thu, 8 May 2014 15:32:13 +0200
Message-ID: <1399555935-702-7-git-send-email-andrzej.kaczmarek@tieto.com>
In-Reply-To: <1399555935-702-1-git-send-email-andrzej.kaczmarek@tieto.com>
References: <1399555935-702-1-git-send-email-andrzej.kaczmarek@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch adds debugfs entry to configure minimum interval between
refreshing data using Get Connection Information request. Default value
is 2000ms.

Signed-off-by: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
---
 include/net/bluetooth/hci_core.h | 3 +++
 net/bluetooth/hci_core.c         | 4 ++++
 net/bluetooth/mgmt.c             | 5 ++---
 3 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 8d7d48b..a1eb022 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -145,6 +145,8 @@ struct oob_data {
 /* Default LE RPA expiry time, 15 minutes */
 #define HCI_DEFAULT_RPA_TIMEOUT		(15 * 60)
 
+#define DEFAULT_CONN_INFO_INTERVAL	2000
+
 struct amp_assoc {
 	__u16	len;
 	__u16	offset;
@@ -200,6 +202,7 @@ struct hci_dev {
 	__u16		le_conn_min_interval;
 	__u16		le_conn_max_interval;
 	__u16		discov_interleaved_timeout;
+	__u16		conn_info_interval;
 	__u8		ssp_debug_mode;
 
 	__u16		devid_source;
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index f5dcbb1..611f707 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -1754,6 +1754,9 @@ static int __hci_init(struct hci_dev *hdev)
 			    &blacklist_fops);
 	debugfs_create_file("uuids", 0444, hdev->debugfs, hdev, &uuids_fops);
 
+	debugfs_create_u16("conn_info_interval", 0644, hdev->debugfs,
+			   &hdev->conn_info_interval);
+
 	if (lmp_bredr_capable(hdev)) {
 		debugfs_create_file("inquiry_cache", 0444, hdev->debugfs,
 				    hdev, &inquiry_cache_fops);
@@ -3790,6 +3793,7 @@ struct hci_dev *hci_alloc_dev(void)
 
 	hdev->rpa_timeout = HCI_DEFAULT_RPA_TIMEOUT;
 	hdev->discov_interleaved_timeout = DISCOV_INTERLEAVED_TIMEOUT;
+	hdev->conn_info_interval = DEFAULT_CONN_INFO_INTERVAL;
 
 	mutex_init(&hdev->lock);
 	mutex_init(&hdev->req_lock);
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 58074c8..e84adf9 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -114,8 +114,6 @@ static const u16 mgmt_events[] = {
 
 #define CACHE_TIMEOUT	msecs_to_jiffies(2 * 1000)
 
-#define CONN_INFO_INTERVAL	msecs_to_jiffies(2 * 1000)
-
 #define hdev_is_powered(hdev) (test_bit(HCI_UP, &hdev->flags) && \
 				!test_bit(HCI_AUTO_OFF, &hdev->dev_flags))
 
@@ -4718,7 +4716,8 @@ static int get_conn_info(struct sock *sk, struct hci_dev *hdev, void *data,
 
 	hci_req_init(&req, hdev, conn);
 
-	if (time_after(jiffies, conn->last_info_read + CONN_INFO_INTERVAL) ||
+	if (time_after(jiffies, conn->last_info_read +
+		       msecs_to_jiffies(hdev->conn_info_interval)) ||
 	    conn->tx_power == HCI_TX_POWER_INVALID) {
 		struct hci_cp_read_rssi req_rssi_cp;
 		struct hci_cp_read_tx_power_level req_txp_cp;
-- 
1.9.2

