Return-Path: <cyrus@holtmann.org>
From: Andre Guedes <andre.guedes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 09/17] Bluetooth: Update le_scan_disable_work to use HCI request
Date: Thu,  4 Apr 2013 20:21:07 -0300
Message-Id: <1365117675-2202-10-git-send-email-andre.guedes@openbossa.org>
In-Reply-To: <1365117675-2202-1-git-send-email-andre.guedes@openbossa.org>
References: <1365117675-2202-1-git-send-email-andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch updates the le_scan_disable_work function so it uses the
HCI request framework. All discovery state handling are done in the
in le_scan_disable_work_complete callback.

This patch also changes the le_scan_disable_work behavior by adding
the HCI Inquiry command to the request in case we are running the
interleaved discovery. This way we don't need the extra logic in
hci_cc_le_set_scan_enable to trigger the inquiry procedure and the
mgmt_interleaved_discovery function becomes useless.

Signed-off-by: Andre Guedes <andre.guedes@openbossa.org>
---
 include/net/bluetooth/hci_core.h |  1 -
 net/bluetooth/hci_core.c         | 67 +++++++++++++++++++++++++++++++++++++++-
 net/bluetooth/hci_event.c        | 10 ------
 net/bluetooth/mgmt.c             | 17 ----------
 4 files changed, 66 insertions(+), 29 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index b2c0207..8a4c865 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -1145,7 +1145,6 @@ int mgmt_remote_name(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 link_type,
 int mgmt_start_discovery_failed(struct hci_dev *hdev, u8 status);
 int mgmt_stop_discovery_failed(struct hci_dev *hdev, u8 status);
 int mgmt_discovering(struct hci_dev *hdev, u8 discovering);
-int mgmt_interleaved_discovery(struct hci_dev *hdev);
 int mgmt_device_blocked(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 type);
 int mgmt_device_unblocked(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 type);
 bool mgmt_valid_hdev(struct hci_dev *hdev);
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index eecab8e..dcc602e 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -1932,17 +1932,82 @@ int hci_cancel_le_scan(struct hci_dev *hdev)
 	return 0;
 }
 
+static void le_scan_disable_work_complete(struct hci_dev *hdev, u8 status)
+{
+	struct hci_command_hdr *last_cmd;
+	u16 opcode;
+
+	BT_DBG("status %d", status);
+
+	/* Get opcode from the last command sent */
+	last_cmd = (void *) hdev->sent_cmd->data;
+	opcode = __le16_to_cpu(last_cmd->opcode);
+
+	switch (opcode) {
+	case HCI_OP_LE_SET_SCAN_ENABLE:
+		if (status) {
+			BT_ERR("Failed to disable LE scanning: status %d",
+			       status);
+			return;
+		}
+
+		hci_dev_lock(hdev);
+		hci_discovery_set_state(hdev, DISCOVERY_STOPPED);
+		hci_dev_unlock(hdev);
+		break;
+
+	case HCI_OP_INQUIRY:
+		if (status) {
+			hci_dev_lock(hdev);
+			hci_discovery_set_state(hdev, DISCOVERY_STOPPED);
+			hci_dev_unlock(hdev);
+			return;
+		}
+
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
 
+	if (hdev->discovery.state != DISCOVERY_FINDING)
+		return;
+
+	hci_req_init(&req, hdev);
+
 	memset(&cp, 0, sizeof(cp));
+	cp.enable = LE_SCAN_DISABLE;
+	hci_req_add(&req, HCI_OP_LE_SET_SCAN_ENABLE, sizeof(cp), &cp);
+
+	/* If we are running the interleaved discovery, also add the inquiry
+	 * HCI command to the HCI request.
+	 */
+	if (hdev->discovery.type == DISCOV_TYPE_INTERLEAVED) {
+		struct hci_cp_inquiry inq_cp;
+		/* General inquiry access code (GIAC) */
+		u8 lap[3] = { 0x33, 0x8b, 0x9e };
+
+		hci_dev_lock(hdev);
+		inquiry_cache_flush(hdev);
+		hci_dev_unlock(hdev);
+
+		memset(&inq_cp, 0, sizeof(inq_cp));
+		memcpy(&inq_cp.lap, lap, sizeof(inq_cp.lap));
+		inq_cp.length = DISCOV_INTERLEAVED_INQUIRY_LEN;
+		hci_req_add(&req, HCI_OP_INQUIRY, sizeof(inq_cp), &inq_cp);
+	}
 
-	hci_send_cmd(hdev, HCI_OP_LE_SET_SCAN_ENABLE, sizeof(cp), &cp);
+	err = hci_req_run(&req, le_scan_disable_work_complete);
+	if (err)
+		BT_ERR("Failed to disable LE scanning: err %d", err);
 }
 
 static void le_scan_work(struct work_struct *work)
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 6f78a8c..dc42acb 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -978,16 +978,6 @@ static void hci_cc_le_set_scan_enable(struct hci_dev *hdev,
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
index 06c96f1d..cfae494 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -2616,23 +2616,6 @@ static int remove_remote_oob_data(struct sock *sk, struct hci_dev *hdev,
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
 static void start_discovery_complete(struct hci_dev *hdev, u8 status)
 {
 	BT_DBG("status %d", status);
-- 
1.8.1.2

