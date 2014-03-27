Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH v4 1/3] Bluetooth: Keep msec in DISCOV_INTERLEAVED_TIMEOUT
Date: Thu, 27 Mar 2014 20:55:19 +0100
Message-ID: <1395950121-12263-1-git-send-email-lukasz.rymanowski@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Keep msec instead of jiffies in this define. This is needed by following
patch where we want this timeout to be exposed in debugfs.

Note: Value of this timeout comes from recommendation in BT Core Spec.4.0,
Vol 3, Part C, chapter 13.2.1.

Signed-off-by: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
---
 include/net/bluetooth/hci_core.h |  2 +-
 net/bluetooth/mgmt.c             | 13 +++++++++----
 2 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index e2bfcda..96681b0 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -1210,7 +1210,7 @@ void hci_sock_dev_event(struct hci_dev *hdev, int event);
 #define DISCOV_LE_SCAN_WIN		0x12
 #define DISCOV_LE_SCAN_INT		0x12
 #define DISCOV_LE_TIMEOUT		msecs_to_jiffies(10240)
-#define DISCOV_INTERLEAVED_TIMEOUT	msecs_to_jiffies(5120)
+#define DISCOV_INTERLEAVED_TIMEOUT	5120	/* msec */
 #define DISCOV_INTERLEAVED_INQUIRY_LEN	0x04
 #define DISCOV_BREDR_INQUIRY_LEN	0x08
 
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 6487c73..e6d906f 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -3352,6 +3352,8 @@ static int mgmt_start_discovery_failed(struct hci_dev *hdev, u8 status)
 
 static void start_discovery_complete(struct hci_dev *hdev, u8 status)
 {
+	unsigned long timeout = 0;
+
 	BT_DBG("status %d", status);
 
 	if (status) {
@@ -3367,13 +3369,11 @@ static void start_discovery_complete(struct hci_dev *hdev, u8 status)
 
 	switch (hdev->discovery.type) {
 	case DISCOV_TYPE_LE:
-		queue_delayed_work(hdev->workqueue, &hdev->le_scan_disable,
-				   DISCOV_LE_TIMEOUT);
+		timeout = DISCOV_LE_TIMEOUT;
 		break;
 
 	case DISCOV_TYPE_INTERLEAVED:
-		queue_delayed_work(hdev->workqueue, &hdev->le_scan_disable,
-				   DISCOV_INTERLEAVED_TIMEOUT);
+		timeout = msecs_to_jiffies(DISCOV_INTERLEAVED_TIMEOUT);
 		break;
 
 	case DISCOV_TYPE_BREDR:
@@ -3382,6 +3382,11 @@ static void start_discovery_complete(struct hci_dev *hdev, u8 status)
 	default:
 		BT_ERR("Invalid discovery type %d", hdev->discovery.type);
 	}
+
+	if (!timeout)
+		return;
+
+	queue_delayed_work(hdev->workqueue, &hdev->le_scan_disable, timeout);
 }
 
 static int start_discovery(struct sock *sk, struct hci_dev *hdev,
-- 
1.8.4

