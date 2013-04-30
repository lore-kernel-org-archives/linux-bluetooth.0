Return-Path: <cyrus@holtmann.org>
From: Andre Guedes <andre.guedes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v3 06/14] Bluetooth: Use HCI request in interleaved discovery
Date: Tue, 30 Apr 2013 15:29:32 -0300
Message-Id: <1367346580-6647-7-git-send-email-andre.guedes@openbossa.org>
In-Reply-To: <1367346580-6647-1-git-send-email-andre.guedes@openbossa.org>
References: <1367346580-6647-1-git-send-email-andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

In order to have a better HCI error handling in interleaved discovery
functionality, we should use the HCI request framework.

This patch updates le_scan_disable_work function so it uses the
HCI request framework instead of the hci_send_cmd helper. A complete
callback is registered (le_scan_disable_work_complete function) so we
are able to trigger the inquiry procedure (if we are running the
interleaved discovery) or to stop the discovery procedure (if we are
running LE-only discovery).

This patch also removes the extra logic in hci_cc_le_set_scan_enable
to trigger the inquiry procedure and the mgmt_interleaved_discovery
function since they become useless.

Signed-off-by: Andre Guedes <andre.guedes@openbossa.org>
---
 include/net/bluetooth/hci_core.h |  1 -
 net/bluetooth/hci_core.c         | 65 +++++++++++++++++++++++++++++++++++++++-
 net/bluetooth/hci_event.c        | 10 -------
 net/bluetooth/mgmt.c             | 17 -----------
 4 files changed, 64 insertions(+), 29 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index ab280f5..9b226c5 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -1181,7 +1181,6 @@ int mgmt_remote_name(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 link_type,
 		     u8 addr_type, s8 rssi, u8 *name, u8 name_len);
 int mgmt_stop_discovery_failed(struct hci_dev *hdev, u8 status);
 int mgmt_discovering(struct hci_dev *hdev, u8 discovering);
-int mgmt_interleaved_discovery(struct hci_dev *hdev);
 int mgmt_device_blocked(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 type);
 int mgmt_device_unblocked(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 type);
 bool mgmt_valid_hdev(struct hci_dev *hdev);
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 8aefd17..c3d91ab 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -2058,17 +2058,80 @@ int hci_cancel_le_scan(struct hci_dev *hdev)
 	return 0;
 }
 
+static void inquiry_complete(struct hci_dev *hdev, u8 status)
+{
+	if (status) {
+		BT_ERR("Failed to start inquiry: status %d", status);
+
+		hci_dev_lock(hdev);
+		hci_discovery_set_state(hdev, DISCOVERY_STOPPED);
+		hci_dev_unlock(hdev);
+		return;
+	}
+}
+
+static void le_scan_disable_work_complete(struct hci_dev *hdev, u8 status)
+{
+	/* General inquiry access code (GIAC) */
+	u8 lap[3] = { 0x33, 0x8b, 0x9e };
+	struct hci_request req;
+	struct hci_cp_inquiry cp;
+	int err;
+
+	if (status) {
+		BT_ERR("Failed to disable LE scanning: status %d", status);
+		return;
+	}
+
+	switch (hdev->discovery.type) {
+	case DISCOV_TYPE_LE:
+		hci_dev_lock(hdev);
+		hci_discovery_set_state(hdev, DISCOVERY_STOPPED);
+		hci_dev_unlock(hdev);
+		break;
+
+	case DISCOV_TYPE_INTERLEAVED:
+		hci_req_init(&req, hdev);
+
+		memset(&cp, 0, sizeof(cp));
+		memcpy(&cp.lap, lap, sizeof(cp.lap));
+		cp.length = DISCOV_INTERLEAVED_INQUIRY_LEN;
+		hci_req_add(&req, HCI_OP_INQUIRY, sizeof(cp), &cp);
+
+		hci_dev_lock(hdev);
+
+		hci_inquiry_cache_flush(hdev);
+
+		err = hci_req_run(&req, inquiry_complete);
+		if (err) {
+			BT_ERR("Inquiry request failed: err %d", err);
+			hci_discovery_set_state(hdev, DISCOVERY_STOPPED);
+		}
+
+		hci_dev_unlock(hdev);
+		break;
+	}
+}
+
 static void le_scan_disable_work(struct work_struct *work)
 {
 	struct hci_dev *hdev = container_of(work, struct hci_dev,
 					    le_scan_disable.work);
 	struct hci_cp_le_set_scan_enable cp;
+	struct hci_request req;
+	int err;
 
 	BT_DBG("%s", hdev->name);
 
+	hci_req_init(&req, hdev);
+
 	memset(&cp, 0, sizeof(cp));
+	cp.enable = LE_SCAN_DISABLE;
+	hci_req_add(&req, HCI_OP_LE_SET_SCAN_ENABLE, sizeof(cp), &cp);
 
-	hci_send_cmd(hdev, HCI_OP_LE_SET_SCAN_ENABLE, sizeof(cp), &cp);
+	err = hci_req_run(&req, le_scan_disable_work_complete);
+	if (err)
+		BT_ERR("Disable LE scanning request failed: err %d", err);
 }
 
 static void le_scan_work(struct work_struct *work)
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 0e71e6c..faaf1f3 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -974,16 +974,6 @@ static void hci_cc_le_set_scan_enable(struct hci_dev *hdev,
 		}
 
 		clear_bit(HCI_LE_SCAN, &hdev->dev_flags);
-
-		if (hdev->discovery.type == DISCOV_TYPE_INTERLEAVED &&
-		    hdev->discovery.state == DISCOVERY_FINDING) {
-			mgmt_interleaved_discovery(hdev);
-		} else {
-			hci_dev_lock(hdev);
-			hci_discovery_set_state(hdev, DISCOVERY_STOPPED);
-			hci_dev_unlock(hdev);
-		}
-
 		break;
 
 	default:
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 8ec0944..15d40ab 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -2621,23 +2621,6 @@ static int remove_remote_oob_data(struct sock *sk, struct hci_dev *hdev,
 	return err;
 }
 
-int mgmt_interleaved_discovery(struct hci_dev *hdev)
-{
-	int err;
-
-	BT_DBG("%s", hdev->name);
-
-	hci_dev_lock(hdev);
-
-	err = hci_do_inquiry(hdev, DISCOV_INTERLEAVED_INQUIRY_LEN);
-	if (err < 0)
-		hci_discovery_set_state(hdev, DISCOVERY_STOPPED);
-
-	hci_dev_unlock(hdev);
-
-	return err;
-}
-
 static int mgmt_start_discovery_failed(struct hci_dev *hdev, u8 status)
 {
 	struct pending_cmd *cmd;
-- 
1.8.2.1

