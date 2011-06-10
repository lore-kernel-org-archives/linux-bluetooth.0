Return-Path: <cyrus@holtmann.org>
From: Andre Guedes <andre.guedes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Andre Guedes <andre.guedes@openbossa.org>
Subject: [RFC 16/16] Bluetooth: Support BR/EDR/LE discovery procedure
Date: Fri, 10 Jun 2011 16:36:13 -0300
Message-Id: <1307734573-1630-17-git-send-email-andre.guedes@openbossa.org>
In-Reply-To: <1307734573-1630-1-git-send-email-andre.guedes@openbossa.org>
References: <1307734573-1630-1-git-send-email-andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Signed-off-by: Andre Guedes <andre.guedes@openbossa.org>
---
 include/net/bluetooth/hci_core.h |    2 ++
 net/bluetooth/hci_event.c        |   20 +++++++++++++++-----
 net/bluetooth/mgmt.c             |   34 +++++++++++++++++++++++++++++++++-
 3 files changed, 50 insertions(+), 6 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 4eb365d..128a678 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -834,6 +834,8 @@ int mgmt_start_discovery_failed(u16 index);
 int mgmt_stop_discovery_complete(u16 index);
 int mgmt_stop_discovery_failed(u16 index);
 int mgmt_has_pending_stop_discov(u16 index);
+int mgmt_is_interleaved_discovery(u16 index);
+int mgmt_do_interleaved_discovery(u16 index);
 
 /* HCI info for socket */
 #define hci_pi(sk) ((struct hci_pinfo *) sk)
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 709c3e1..3ca749b 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -881,7 +881,8 @@ static void hci_cc_le_set_scan_enable(struct hci_dev *hdev,
 			goto unlock;
 		}
 
-		mgmt_discovering(hdev->id, 1);
+		if (!mgmt_is_interleaved_discovery(hdev->id))
+			mgmt_discovering(hdev->id, 1);
 	} else if (cp->enable == 0x00) {
 		if (status) {
 			if (mgmt_has_pending_stop_discov(hdev->id))
@@ -1315,13 +1316,22 @@ static inline void hci_inquiry_complete_evt(struct hci_dev *hdev, struct sk_buff
 
 	hci_dev_lock(hdev);
 
-	mgmt_discovering(hdev->id, 0);
-
-	if (mgmt_has_pending_stop_discov(hdev->id))
+	if (mgmt_has_pending_stop_discov(hdev->id)) {
+		mgmt_discovering(hdev->id, 0);
 		mgmt_stop_discovery_complete(hdev->id);
-	else
+		goto unlock;
+	}
+
+	if (mgmt_is_interleaved_discovery(hdev->id)) {
+		int err = mgmt_do_interleaved_discovery(hdev->id);
+		if (err)
+			mgmt_start_discovery_failed(hdev->id);
+	} else {
+		mgmt_discovering(hdev->id, 0);
 		mgmt_start_discovery_complete(hdev->id);
+	}
 
+unlock:
 	hci_dev_unlock(hdev);
 }
 
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index c780367..f3483b5 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -40,6 +40,8 @@ enum bt_device_type {
 };
 
 #define BREDR_ONLY_INQ_LENGTH 0x08 /* TGAP(100) */
+#define BREDR_LE_INQ_LENGTH 0x04 /* TGAP(100)/2 */
+#define BREDR_LE_SCAN_TIMEOUT 5120 /* TGAP(100)/2 */
 #define LE_ONLY_SCAN_TIMEOUT 10240 /* TGAP(gen_disc_scan_min) */
 
 struct pending_cmd {
@@ -1717,7 +1719,7 @@ static int start_discovery(struct sock *sk, u16 index)
 		err = do_le_scan(hdev, LE_ONLY_SCAN_TIMEOUT);
 		break;
 	case BREDR_LE:
-		err = -ENOSYS;
+		err = do_inquiry(hdev, BREDR_LE_INQ_LENGTH);
 		break;
 	default:
 		err = -EINVAL;
@@ -2394,3 +2396,33 @@ int mgmt_has_pending_stop_discov(u16 index)
 
 	return 0;
 }
+
+int mgmt_is_interleaved_discovery(u16 index)
+{
+	struct hci_dev *hdev;
+
+	hdev = hci_dev_get(index);
+
+	if (get_device_type(hdev) == BREDR_LE &&
+			mgmt_pending_find(MGMT_OP_START_DISCOVERY, hdev->id))
+		return 1;
+
+	hci_dev_put(hdev);
+
+	return 0;
+}
+
+/* hdev must be locked */
+int mgmt_do_interleaved_discovery(u16 index)
+{
+	int err;
+	struct hci_dev *hdev;
+
+	hdev = hci_dev_get(index);
+
+	err = do_le_scan(hdev, BREDR_LE_SCAN_TIMEOUT);
+
+	hci_dev_put(hdev);
+
+	return err;
+}
-- 
1.7.4.1

