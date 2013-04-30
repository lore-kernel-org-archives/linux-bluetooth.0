Return-Path: <cyrus@holtmann.org>
From: Andre Guedes <andre.guedes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 05/13] Bluetooth: Move discovery macros to hci_core.h
Date: Tue, 30 Apr 2013 02:44:56 -0300
Message-Id: <1367300704-703-6-git-send-email-andre.guedes@openbossa.org>
In-Reply-To: <1367300704-703-1-git-send-email-andre.guedes@openbossa.org>
References: <1367300704-703-1-git-send-email-andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Some of discovery macros will be used in hci_core so we need to
define them in common place such as hci_core.h. Thus, this patch
moves discovery macros to hci_core.h and also adds the DISCOV_
prefix to them.

Signed-off-by: Andre Guedes <andre.guedes@openbossa.org>
---
 include/net/bluetooth/hci_core.h | 10 ++++++++++
 net/bluetooth/mgmt.c             | 24 ++++++------------------
 2 files changed, 16 insertions(+), 18 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 1ff7f67..fbfa5cd 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -1115,6 +1115,16 @@ void hci_sock_dev_event(struct hci_dev *hdev, int event);
 					 BIT(BDADDR_LE_PUBLIC) | \
 					 BIT(BDADDR_LE_RANDOM))
 
+/* These LE scan and inquiry parameters were chosen according to LE General
+ * Discovery Procedure specification.
+ */
+#define DISCOV_LE_SCAN_WIN		0x12
+#define DISCOV_LE_SCAN_INT		0x12
+#define DISCOV_LE_TIMEOUT		msecs_to_jiffies(10240)
+#define DISCOV_INTERLEAVED_TIMEOUT	msecs_to_jiffies(5120)
+#define DISCOV_INTERLEAVED_INQUIRY_LEN	0x04
+#define DISCOV_BREDR_INQUIRY_LEN	0x08
+
 int mgmt_control(struct sock *sk, struct msghdr *msg, size_t len);
 int mgmt_index_added(struct hci_dev *hdev);
 int mgmt_index_removed(struct hci_dev *hdev);
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index c701eac..7673398 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -102,18 +102,6 @@ static const u16 mgmt_events[] = {
 	MGMT_EV_PASSKEY_NOTIFY,
 };
 
-/*
- * These LE scan and inquiry parameters were chosen according to LE General
- * Discovery Procedure specification.
- */
-#define LE_SCAN_WIN			0x12
-#define LE_SCAN_INT			0x12
-#define LE_SCAN_TIMEOUT_LE_ONLY		msecs_to_jiffies(10240)
-#define LE_SCAN_TIMEOUT_BREDR_LE	msecs_to_jiffies(5120)
-
-#define INQUIRY_LEN_BREDR		0x08	/* TGAP(100) */
-#define INQUIRY_LEN_BREDR_LE		0x04	/* TGAP(100)/2 */
-
 #define CACHE_TIMEOUT	msecs_to_jiffies(2 * 1000)
 
 #define hdev_is_powered(hdev) (test_bit(HCI_UP, &hdev->flags) && \
@@ -2641,7 +2629,7 @@ int mgmt_interleaved_discovery(struct hci_dev *hdev)
 
 	hci_dev_lock(hdev);
 
-	err = hci_do_inquiry(hdev, INQUIRY_LEN_BREDR_LE);
+	err = hci_do_inquiry(hdev, DISCOV_INTERLEAVED_INQUIRY_LEN);
 	if (err < 0)
 		hci_discovery_set_state(hdev, DISCOVERY_STOPPED);
 
@@ -2668,12 +2656,12 @@ static void start_discovery_complete(struct hci_dev *hdev, u8 status)
 	switch (hdev->discovery.type) {
 	case DISCOV_TYPE_LE:
 		queue_delayed_work(hdev->workqueue, &hdev->le_scan_disable,
-				   LE_SCAN_TIMEOUT_LE_ONLY);
+				   DISCOV_LE_TIMEOUT);
 		break;
 
 	case DISCOV_TYPE_INTERLEAVED:
 		queue_delayed_work(hdev->workqueue, &hdev->le_scan_disable,
-				   LE_SCAN_TIMEOUT_BREDR_LE);
+				   DISCOV_INTERLEAVED_TIMEOUT);
 		break;
 
 	case DISCOV_TYPE_BREDR:
@@ -2749,7 +2737,7 @@ static int start_discovery(struct sock *sk, struct hci_dev *hdev,
 
 		memset(&inq_cp, 0, sizeof(inq_cp));
 		memcpy(&inq_cp.lap, lap, sizeof(inq_cp.lap));
-		inq_cp.length = INQUIRY_LEN_BREDR;
+		inq_cp.length = DISCOV_BREDR_INQUIRY_LEN;
 		hci_req_add(&req, HCI_OP_INQUIRY, sizeof(inq_cp), &inq_cp);
 		break;
 
@@ -2786,8 +2774,8 @@ static int start_discovery(struct sock *sk, struct hci_dev *hdev,
 
 		memset(&param_cp, 0, sizeof(param_cp));
 		param_cp.type = LE_SCAN_ACTIVE;
-		param_cp.interval = cpu_to_le16(LE_SCAN_INT);
-		param_cp.window = cpu_to_le16(LE_SCAN_WIN);
+		param_cp.interval = cpu_to_le16(DISCOV_LE_SCAN_INT);
+		param_cp.window = cpu_to_le16(DISCOV_LE_SCAN_WIN);
 		hci_req_add(&req, HCI_OP_LE_SET_SCAN_PARAM, sizeof(param_cp),
 			    &param_cp);
 
-- 
1.8.2.1

