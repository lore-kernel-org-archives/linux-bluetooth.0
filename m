Return-Path: <cyrus@holtmann.org>
From: Andre Guedes <andre.guedes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 2/5] Bluetooth: Discovery parameters per hci_dev
Date: Fri, 23 Aug 2013 17:01:08 -0300
Message-Id: <1377288071-3664-2-git-send-email-andre.guedes@openbossa.org>
In-Reply-To: <1377288071-3664-1-git-send-email-andre.guedes@openbossa.org>
References: <1377288071-3664-1-git-send-email-andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch adds discovery parameters to struct hci_dev. This way, we
will be able to configure the discovery parameters per hci device.

Signed-off-by: Andre Guedes <andre.guedes@openbossa.org>
---
 include/net/bluetooth/hci_core.h | 13 +++++++++++++
 net/bluetooth/hci_core.c         | 13 ++++++++++++-
 net/bluetooth/mgmt.c             | 15 +++++++++------
 3 files changed, 34 insertions(+), 7 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 879bf45..20dae6d 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -127,6 +127,17 @@ struct amp_assoc {
 	__u8	data[HCI_MAX_AMP_ASSOC_SIZE];
 };
 
+struct discovery_param {
+	u8		scan_type;
+	u16		scan_interval;
+	u16		scan_window;
+	u16		le_scan_timeout;
+	u16		interleaved_scan_timeout;
+
+	u8		interleaved_inquiry_length;
+	u8		bredr_inquiry_length;
+};
+
 #define HCI_MAX_PAGES	3
 
 #define NUM_REASSEMBLY 4
@@ -280,6 +291,8 @@ struct hci_dev {
 	__u8			adv_data[HCI_MAX_AD_LENGTH];
 	__u8			adv_data_len;
 
+	struct discovery_param	discovery_param;
+
 	int (*open)(struct hci_dev *hdev);
 	int (*close)(struct hci_dev *hdev);
 	int (*flush)(struct hci_dev *hdev);
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index e8be6ec..e6d1350 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -2032,6 +2032,7 @@ static void le_scan_disable_work_complete(struct hci_dev *hdev, u8 status)
 {
 	/* General inquiry access code (GIAC) */
 	u8 lap[3] = { 0x33, 0x8b, 0x9e };
+	struct discovery_param *discov = &hdev->discovery_param;
 	struct hci_request req;
 	struct hci_cp_inquiry cp;
 	int err;
@@ -2053,7 +2054,7 @@ static void le_scan_disable_work_complete(struct hci_dev *hdev, u8 status)
 
 		memset(&cp, 0, sizeof(cp));
 		memcpy(&cp.lap, lap, sizeof(cp.lap));
-		cp.length = DISCOV_INTERLEAVED_INQUIRY_LEN;
+		cp.length = discov->interleaved_inquiry_length;
 		hci_req_add(&req, HCI_OP_INQUIRY, sizeof(cp), &cp);
 
 		hci_dev_lock(hdev);
@@ -2096,6 +2097,7 @@ static void le_scan_disable_work(struct work_struct *work)
 struct hci_dev *hci_alloc_dev(void)
 {
 	struct hci_dev *hdev;
+	struct discovery_param *discov;
 
 	hdev = kzalloc(sizeof(struct hci_dev), GFP_KERNEL);
 	if (!hdev)
@@ -2142,6 +2144,15 @@ struct hci_dev *hci_alloc_dev(void)
 	hci_init_sysfs(hdev);
 	discovery_init(hdev);
 
+	discov = &hdev->discovery_param;
+	discov->scan_type = LE_SCAN_ACTIVE;
+	discov->scan_interval = DISCOV_LE_SCAN_INT;
+	discov->scan_window = DISCOV_LE_SCAN_WIN;
+	discov->le_scan_timeout = DISCOV_LE_TIMEOUT;
+	discov->interleaved_scan_timeout = DISCOV_INTERLEAVED_TIMEOUT;
+	discov->interleaved_inquiry_length = DISCOV_INTERLEAVED_INQUIRY_LEN;
+	discov->bredr_inquiry_length = DISCOV_BREDR_INQUIRY_LEN;
+
 	return hdev;
 }
 EXPORT_SYMBOL(hci_alloc_dev);
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index fedc539..b9b14c6 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -2642,6 +2642,8 @@ static int mgmt_start_discovery_failed(struct hci_dev *hdev, u8 status)
 
 static void start_discovery_complete(struct hci_dev *hdev, u8 status)
 {
+	struct discovery_param *discov = &hdev->discovery_param;
+
 	BT_DBG("status %d", status);
 
 	if (status) {
@@ -2658,12 +2660,12 @@ static void start_discovery_complete(struct hci_dev *hdev, u8 status)
 	switch (hdev->discovery.type) {
 	case DISCOV_TYPE_LE:
 		queue_delayed_work(hdev->workqueue, &hdev->le_scan_disable,
-				   DISCOV_LE_TIMEOUT);
+				   discov->le_scan_timeout);
 		break;
 
 	case DISCOV_TYPE_INTERLEAVED:
 		queue_delayed_work(hdev->workqueue, &hdev->le_scan_disable,
-				   DISCOV_INTERLEAVED_TIMEOUT);
+				   discov->interleaved_scan_timeout);
 		break;
 
 	case DISCOV_TYPE_BREDR:
@@ -2678,6 +2680,7 @@ static int start_discovery(struct sock *sk, struct hci_dev *hdev,
 			   void *data, u16 len)
 {
 	struct mgmt_cp_start_discovery *cp = data;
+	struct discovery_param *discov = &hdev->discovery_param;
 	struct pending_cmd *cmd;
 	struct hci_cp_le_set_scan_param param_cp;
 	struct hci_cp_le_set_scan_enable enable_cp;
@@ -2739,7 +2742,7 @@ static int start_discovery(struct sock *sk, struct hci_dev *hdev,
 
 		memset(&inq_cp, 0, sizeof(inq_cp));
 		memcpy(&inq_cp.lap, lap, sizeof(inq_cp.lap));
-		inq_cp.length = DISCOV_BREDR_INQUIRY_LEN;
+		inq_cp.length = discov->bredr_inquiry_length;
 		hci_req_add(&req, HCI_OP_INQUIRY, sizeof(inq_cp), &inq_cp);
 		break;
 
@@ -2775,9 +2778,9 @@ static int start_discovery(struct sock *sk, struct hci_dev *hdev,
 		}
 
 		memset(&param_cp, 0, sizeof(param_cp));
-		param_cp.type = LE_SCAN_ACTIVE;
-		param_cp.interval = cpu_to_le16(DISCOV_LE_SCAN_INT);
-		param_cp.window = cpu_to_le16(DISCOV_LE_SCAN_WIN);
+		param_cp.type = discov->scan_type;
+		param_cp.interval = cpu_to_le16(discov->scan_interval);
+		param_cp.window = cpu_to_le16(discov->scan_window);
 		hci_req_add(&req, HCI_OP_LE_SET_SCAN_PARAM, sizeof(param_cp),
 			    &param_cp);
 
-- 
1.8.3.4

