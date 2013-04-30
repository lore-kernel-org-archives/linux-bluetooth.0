Return-Path: <cyrus@holtmann.org>
From: Andre Guedes <andre.guedes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v3 02/14] Bluetooth: Update start_discovery to use HCI request
Date: Tue, 30 Apr 2013 15:29:28 -0300
Message-Id: <1367346580-6647-3-git-send-email-andre.guedes@openbossa.org>
In-Reply-To: <1367346580-6647-1-git-send-email-andre.guedes@openbossa.org>
References: <1367346580-6647-1-git-send-email-andre.guedes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch modifies the start_discovery function so it uses the HCI
request framework.

We build the HCI request according to the discovery type (add inquiry
or LE scan HCI commands) and run the HCI request. We also register
the start_discovery_complete callback which handles mgmt command
complete events for this command. This way, we move all start_
discovery mgmt handling code spread in hci_event.c to a single place
in mgmt.c.

This patch also merges the LE-only and interleaved discovery type
cases since these cases are pretty much the same now.

Signed-off-by: Andre Guedes <andre.guedes@openbossa.org>
Acked-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/mgmt.c | 94 +++++++++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 85 insertions(+), 9 deletions(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 5e93b24..c701eac 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -2650,11 +2650,51 @@ int mgmt_interleaved_discovery(struct hci_dev *hdev)
 	return err;
 }
 
+static void start_discovery_complete(struct hci_dev *hdev, u8 status)
+{
+	BT_DBG("status %d", status);
+
+	if (status) {
+		hci_dev_lock(hdev);
+		mgmt_start_discovery_failed(hdev, status);
+		hci_dev_unlock(hdev);
+		return;
+	}
+
+	hci_dev_lock(hdev);
+	hci_discovery_set_state(hdev, DISCOVERY_FINDING);
+	hci_dev_unlock(hdev);
+
+	switch (hdev->discovery.type) {
+	case DISCOV_TYPE_LE:
+		queue_delayed_work(hdev->workqueue, &hdev->le_scan_disable,
+				   LE_SCAN_TIMEOUT_LE_ONLY);
+		break;
+
+	case DISCOV_TYPE_INTERLEAVED:
+		queue_delayed_work(hdev->workqueue, &hdev->le_scan_disable,
+				   LE_SCAN_TIMEOUT_BREDR_LE);
+		break;
+
+	case DISCOV_TYPE_BREDR:
+		break;
+
+	default:
+		BT_ERR("Invalid discovery type %d", hdev->discovery.type);
+	}
+}
+
 static int start_discovery(struct sock *sk, struct hci_dev *hdev,
 			   void *data, u16 len)
 {
 	struct mgmt_cp_start_discovery *cp = data;
 	struct pending_cmd *cmd;
+	struct hci_cp_le_set_scan_param param_cp;
+	struct hci_cp_le_set_scan_enable enable_cp;
+	struct hci_cp_inquiry inq_cp;
+	struct hci_request req;
+	/* General inquiry access code (GIAC) */
+	u8 lap[3] = { 0x33, 0x8b, 0x9e };
 	int err;
 
 	BT_DBG("%s", hdev->name);
@@ -2687,6 +2727,8 @@ static int start_discovery(struct sock *sk, struct hci_dev *hdev,
 
 	hdev->discovery.type = cp->type;
 
+	hci_req_init(&req, hdev);
+
 	switch (hdev->discovery.type) {
 	case DISCOV_TYPE_BREDR:
 		if (!lmp_bredr_capable(hdev)) {
@@ -2696,10 +2738,23 @@ static int start_discovery(struct sock *sk, struct hci_dev *hdev,
 			goto failed;
 		}
 
-		err = hci_do_inquiry(hdev, INQUIRY_LEN_BREDR);
+		if (test_bit(HCI_INQUIRY, &hdev->flags)) {
+			err = cmd_status(sk, hdev->id, MGMT_OP_START_DISCOVERY,
+					 MGMT_STATUS_BUSY);
+			mgmt_pending_remove(cmd);
+			goto failed;
+		}
+
+		hci_inquiry_cache_flush(hdev);
+
+		memset(&inq_cp, 0, sizeof(inq_cp));
+		memcpy(&inq_cp.lap, lap, sizeof(inq_cp.lap));
+		inq_cp.length = INQUIRY_LEN_BREDR;
+		hci_req_add(&req, HCI_OP_INQUIRY, sizeof(inq_cp), &inq_cp);
 		break;
 
 	case DISCOV_TYPE_LE:
+	case DISCOV_TYPE_INTERLEAVED:
 		if (!test_bit(HCI_LE_ENABLED, &hdev->dev_flags)) {
 			err = cmd_status(sk, hdev->id, MGMT_OP_START_DISCOVERY,
 					 MGMT_STATUS_NOT_SUPPORTED);
@@ -2707,20 +2762,40 @@ static int start_discovery(struct sock *sk, struct hci_dev *hdev,
 			goto failed;
 		}
 
-		err = hci_le_scan(hdev, LE_SCAN_ACTIVE, LE_SCAN_INT,
-				  LE_SCAN_WIN, LE_SCAN_TIMEOUT_LE_ONLY);
-		break;
-
-	case DISCOV_TYPE_INTERLEAVED:
-		if (!lmp_host_le_capable(hdev) || !lmp_bredr_capable(hdev)) {
+		if (hdev->discovery.type == DISCOV_TYPE_INTERLEAVED &&
+		    !lmp_bredr_capable(hdev)) {
 			err = cmd_status(sk, hdev->id, MGMT_OP_START_DISCOVERY,
 					 MGMT_STATUS_NOT_SUPPORTED);
 			mgmt_pending_remove(cmd);
 			goto failed;
 		}
 
-		err = hci_le_scan(hdev, LE_SCAN_ACTIVE, LE_SCAN_INT,
-				  LE_SCAN_WIN, LE_SCAN_TIMEOUT_BREDR_LE);
+		if (test_bit(HCI_LE_PERIPHERAL, &hdev->dev_flags)) {
+			err = cmd_status(sk, hdev->id, MGMT_OP_START_DISCOVERY,
+					 MGMT_STATUS_REJECTED);
+			mgmt_pending_remove(cmd);
+			goto failed;
+		}
+
+		if (test_bit(HCI_LE_SCAN, &hdev->dev_flags)) {
+			err = cmd_status(sk, hdev->id, MGMT_OP_START_DISCOVERY,
+					 MGMT_STATUS_BUSY);
+			mgmt_pending_remove(cmd);
+			goto failed;
+		}
+
+		memset(&param_cp, 0, sizeof(param_cp));
+		param_cp.type = LE_SCAN_ACTIVE;
+		param_cp.interval = cpu_to_le16(LE_SCAN_INT);
+		param_cp.window = cpu_to_le16(LE_SCAN_WIN);
+		hci_req_add(&req, HCI_OP_LE_SET_SCAN_PARAM, sizeof(param_cp),
+			    &param_cp);
+
+		memset(&enable_cp, 0, sizeof(enable_cp));
+		enable_cp.enable = LE_SCAN_ENABLE;
+		enable_cp.filter_dup = LE_SCAN_FILTER_DUP_ENABLE;
+		hci_req_add(&req, HCI_OP_LE_SET_SCAN_ENABLE, sizeof(enable_cp),
+			    &enable_cp);
 		break;
 
 	default:
@@ -2730,6 +2805,7 @@ static int start_discovery(struct sock *sk, struct hci_dev *hdev,
 		goto failed;
 	}
 
+	err = hci_req_run(&req, start_discovery_complete);
 	if (err < 0)
 		mgmt_pending_remove(cmd);
 	else
-- 
1.8.2.1

