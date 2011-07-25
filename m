Return-Path: <cyrus@holtmann.org>
From: Andre Guedes <andre.guedes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Andre Guedes <andre.guedes@openbossa.org>
Subject: [PATCH v2 16/16] Bluetooth: Support BR/EDR/LE discovery procedure
Date: Mon, 25 Jul 2011 16:50:05 -0300
Message-Id: <1311623405-31108-17-git-send-email-andre.guedes@openbossa.org>
In-Reply-To: <1311623405-31108-1-git-send-email-andre.guedes@openbossa.org>
References: <1311623405-31108-1-git-send-email-andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch adds support for BR/EDR/LE discovery procedure through
management interface.

Signed-off-by: Andre Guedes <andre.guedes@openbossa.org>
---
 include/net/bluetooth/hci_core.h |    2 ++
 net/bluetooth/hci_event.c        |    8 +++++++-
 net/bluetooth/mgmt.c             |   38 +++++++++++++++++++++++++++++++++++++-
 3 files changed, 46 insertions(+), 2 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index f23102a..1bc1c3a 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -866,6 +866,8 @@ int mgmt_stop_discovery_complete(u16 index);
 int mgmt_stop_discovery_failed(u16 index, u8 status);
 int mgmt_has_pending_stop_discov(u16 index);
 int mgmt_cancel_discovery(u16 index);
+int mgmt_is_interleaved_discovery(u16 index);
+int mgmt_do_interleaved_discovery(u16 index);
 
 /* HCI info for socket */
 #define hci_pi(sk) ((struct hci_pinfo *) sk)
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 08774c2..55872ff 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -913,7 +913,8 @@ static void hci_cc_le_set_scan_enable(struct hci_dev *hdev,
 			goto unlock;
 		}
 
-		mgmt_discovering(hdev->id, 1);
+		if (!mgmt_is_interleaved_discovery(hdev->id))
+			mgmt_discovering(hdev->id, 1);
 	} else if (cp->enable == 0x00) {
 		if (status) {
 			if (mgmt_has_pending_stop_discov(hdev->id))
@@ -1393,6 +1394,11 @@ static inline void hci_inquiry_complete_evt(struct hci_dev *hdev, struct sk_buff
 
 	hci_req_complete(hdev, HCI_OP_INQUIRY, status);
 
+	if (mgmt_is_interleaved_discovery(hdev->id)) {
+		mgmt_do_interleaved_discovery(hdev->id);
+		return;
+	}
+
 	mgmt_discovering(hdev->id, 0);
 
 	hci_dev_lock(hdev);
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index db3b177..7c0f4f6 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -40,6 +40,8 @@ enum bt_device_type {
 };
 
 #define BREDR_ONLY_INQ_LENGTH 0x08 /* TGAP(100) */
+#define BREDR_LE_INQ_LENGTH 0x04 /* TGAP(100)/2 */
+#define BREDR_LE_SCAN_TIMEOUT 5120 /* TGAP(100)/2 */
 #define LE_ONLY_SCAN_TIMEOUT 10240 /* TGAP(gen_disc_scan_min) */
 
 struct pending_cmd {
@@ -1731,7 +1733,7 @@ static int start_discovery(struct sock *sk, u16 index)
 		err = do_le_scan(hdev, LE_ONLY_SCAN_TIMEOUT);
 		break;
 	case BREDR_LE:
-		err = -ENOSYS;
+		err = do_inquiry(hdev, BREDR_LE_INQ_LENGTH);
 		break;
 	default:
 		err = -EINVAL;
@@ -2512,3 +2514,37 @@ int mgmt_has_pending_stop_discov(u16 index)
 
 	return 0;
 }
+
+int mgmt_is_interleaved_discovery(u16 index)
+{
+	struct hci_dev *hdev;
+	int res = 0;
+
+	hdev = hci_dev_get(index);
+
+	if (get_device_type(hdev) == BREDR_LE &&
+			mgmt_pending_find(MGMT_OP_START_DISCOVERY, hdev->id))
+		res = 1;
+
+	hci_dev_put(hdev);
+
+	return res;
+}
+
+int mgmt_do_interleaved_discovery(u16 index)
+{
+	struct hci_dev *hdev;
+	int err;
+
+	hdev = hci_dev_get(index);
+
+	err = do_le_scan(hdev, BREDR_LE_SCAN_TIMEOUT);
+	if (err < 0) {
+		mgmt_discovering(hdev->id, 0);
+		mgmt_start_discovery_failed(hdev->id, err);
+	}
+
+	hci_dev_put(hdev);
+
+	return err;
+}
-- 
1.7.4.1

