Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Bharat Bhusan Panda <bharat.b.panda@intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: bharat.b.panda@intel.com
Subject: [PATCH] support fast advertising interval
Date: Mon, 27 Aug 2018 14:16:31 +0530
Message-Id: <1535359591-27842-1-git-send-email-bharat.b.panda@intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Changes made to add support for fast advertising interval as per
core 4.1 specification, section 9.3.11.2.

A peripheral device enetering any of the following GAP modes and
sending either non-connectable advertising events or scannable undirected
advertising events should use adv_fast_interval2(100ms - 150ms)
for adv_fast_period(30s).
         - Non-Discoverable Mode
         - Non-Connectable Mode
         - Limited Discoverable Mode
         - General Discoverable Mode

Signed-off-by: Bharat Bhusan Panda <bharat.b.panda@intel.com>
---
 include/net/bluetooth/hci_core.h |  2 ++
 net/bluetooth/hci_request.c      | 22 ++++++++++++++++++++++
 2 files changed, 24 insertions(+)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index b619a19..2fe908c 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -1456,6 +1456,8 @@ struct hci_mgmt_chan {
 #define DISCOV_INTERLEAVED_INQUIRY_LEN	0x04
 #define DISCOV_BREDR_INQUIRY_LEN	0x08
 #define DISCOV_LE_RESTART_DELAY		msecs_to_jiffies(200)	/* msec */
+#define DISCOV_LE_FAST_ADV_INT_MIN	100	/* msec */
+#define DISCOV_LE_FAST_ADV_INT_MAX	150	/* msec */
 
 void mgmt_fill_version_info(void *ver);
 int mgmt_new_settings(struct hci_dev *hdev);
diff --git a/net/bluetooth/hci_request.c b/net/bluetooth/hci_request.c
index 66c0781..5cf3ef9 100644
--- a/net/bluetooth/hci_request.c
+++ b/net/bluetooth/hci_request.c
@@ -1005,6 +1005,28 @@ void __hci_req_enable_advertising(struct hci_request *req)
 	else
 		cp.type = LE_ADV_NONCONN_IND;
 
+	/* As per core 4.1 spec, section 9.3.11.2: A peripheral device
+	 * enetering any of the following GAP modes and sending either
+	 * non-connectable advertising events or scannable undirected
+	 * advertising events should use adv_fast_interval2(100ms - 150ms)
+	 * for adv_fast_period(30s).
+	 *
+	 * 	- Non-Discoverable Mode
+	 *	- Non-Connectable Mode
+	 * 	- Limited Discoverable Mode
+	 * 	- General Discoverable Mode
+	 */
+	if ((cp.type == LE_ADV_NONCONN_IND) || (cp.type = LE_ADV_SCAN_IND)) {
+		if ((hci_dev_test_flag(hdev, HCI_DISCOVERABLE)) ||
+		(hci_dev_test_flag(hdev, HCI_LIMITED_DISCOVERABLE)) ||
+		(hdev->discovery.limited == true)) {
+			cp.min_interval =
+				cpu_to_le16(DISCOV_LE_FAST_ADV_INT_MIN);
+			cp.max_interval =
+				cpu_to_le16(DISCOV_LE_FAST_ADV_INT_MAX);
+		}
+	}
+
 	cp.own_address_type = own_addr_type;
 	cp.channel_map = hdev->le_adv_channel_map;
 
-- 
1.9.1
