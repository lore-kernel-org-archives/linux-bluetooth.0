Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [RFC 4/6] Bluetooth: Split triggering of discovery commands into separate function
Date: Thu,  4 Dec 2014 10:13:59 +0100
Message-Id: <1417684441-103825-4-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The actual process of compiling the correct HCI commands for triggering
discovery is something that should be generic. So instead of mixing it
into the Start Discover operation handling, split it out into its own
function utilizing HCI request handling and just providing status in
case of errors or invalid parameters.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 net/bluetooth/mgmt.c | 214 ++++++++++++++++++++++++---------------------------
 1 file changed, 100 insertions(+), 114 deletions(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index f3296371a310..46c9d528490d 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -3686,6 +3686,103 @@ done:
 	return err;
 }
 
+static bool trigger_discovery(struct hci_request *req, u8 *status)
+{
+	struct hci_dev *hdev = req->hdev;
+	struct hci_cp_le_set_scan_param param_cp;
+	struct hci_cp_le_set_scan_enable enable_cp;
+	struct hci_cp_inquiry inq_cp;
+	/* General inquiry access code (GIAC) */
+	u8 lap[3] = { 0x33, 0x8b, 0x9e };
+	u8 own_addr_type;
+	int err;
+
+	switch (hdev->discovery.type) {
+	case DISCOV_TYPE_BREDR:
+		*status = mgmt_bredr_support(hdev);
+		if (*status)
+			return false;
+
+		if (test_bit(HCI_INQUIRY, &hdev->flags)) {
+			*status = MGMT_STATUS_BUSY;
+			return false;
+		}
+
+		hci_inquiry_cache_flush(hdev);
+
+		memset(&inq_cp, 0, sizeof(inq_cp));
+		memcpy(&inq_cp.lap, lap, sizeof(inq_cp.lap));
+		inq_cp.length = DISCOV_BREDR_INQUIRY_LEN;
+		hci_req_add(req, HCI_OP_INQUIRY, sizeof(inq_cp), &inq_cp);
+		break;
+
+	case DISCOV_TYPE_LE:
+	case DISCOV_TYPE_INTERLEAVED:
+		*status = mgmt_le_support(hdev);
+		if (*status)
+			return false;
+
+		if (hdev->discovery.type == DISCOV_TYPE_INTERLEAVED &&
+		    !test_bit(HCI_BREDR_ENABLED, &hdev->dev_flags)) {
+			*status = MGMT_STATUS_NOT_SUPPORTED;
+			return false;
+		}
+
+		if (test_bit(HCI_LE_ADV, &hdev->dev_flags)) {
+			/* Don't let discovery abort an outgoing
+			 * connection attempt that's using directed
+			 * advertising.
+			 */
+			if (hci_conn_hash_lookup_state(hdev, LE_LINK,
+						       BT_CONNECT)) {
+				*status = MGMT_STATUS_REJECTED;
+				return false;
+			}
+
+			disable_advertising(req);
+		}
+
+		/* If controller is scanning, it means the background scanning
+		 * is running. Thus, we should temporarily stop it in order to
+		 * set the discovery scanning parameters.
+		 */
+		if (test_bit(HCI_LE_SCAN, &hdev->dev_flags))
+			hci_req_add_le_scan_disable(req);
+
+		memset(&param_cp, 0, sizeof(param_cp));
+
+		/* All active scans will be done with either a resolvable
+		 * private address (when privacy feature has been enabled)
+		 * or unresolvable private address.
+		 */
+		err = hci_update_random_address(req, true, &own_addr_type);
+		if (err < 0) {
+			*status = MGMT_STATUS_FAILED;
+			return false;
+		}
+
+		param_cp.type = LE_SCAN_ACTIVE;
+		param_cp.interval = cpu_to_le16(DISCOV_LE_SCAN_INT);
+		param_cp.window = cpu_to_le16(DISCOV_LE_SCAN_WIN);
+		param_cp.own_address_type = own_addr_type;
+		hci_req_add(req, HCI_OP_LE_SET_SCAN_PARAM, sizeof(param_cp),
+			    &param_cp);
+
+		memset(&enable_cp, 0, sizeof(enable_cp));
+		enable_cp.enable = LE_SCAN_ENABLE;
+		enable_cp.filter_dup = LE_SCAN_FILTER_DUP_ENABLE;
+		hci_req_add(req, HCI_OP_LE_SET_SCAN_ENABLE, sizeof(enable_cp),
+			    &enable_cp);
+		break;
+
+	default:
+		*status = MGMT_STATUS_INVALID_PARAMS;
+		return false;
+	}
+
+	return true;
+}
+
 static int mgmt_start_discovery_failed(struct hci_dev *hdev, u8 status)
 {
 	struct pending_cmd *cmd;
@@ -3751,13 +3848,8 @@ static int start_discovery(struct sock *sk, struct hci_dev *hdev,
 {
 	struct mgmt_cp_start_discovery *cp = data;
 	struct pending_cmd *cmd;
-	struct hci_cp_le_set_scan_param param_cp;
-	struct hci_cp_le_set_scan_enable enable_cp;
-	struct hci_cp_inquiry inq_cp;
 	struct hci_request req;
-	/* General inquiry access code (GIAC) */
-	u8 lap[3] = { 0x33, 0x8b, 0x9e };
-	u8 status, own_addr_type;
+	u8 status;
 	int err;
 
 	BT_DBG("%s", hdev->name);
@@ -3789,115 +3881,9 @@ static int start_discovery(struct sock *sk, struct hci_dev *hdev,
 
 	hci_req_init(&req, hdev);
 
-	switch (hdev->discovery.type) {
-	case DISCOV_TYPE_BREDR:
-		status = mgmt_bredr_support(hdev);
-		if (status) {
-			err = cmd_complete(sk, hdev->id,
-					   MGMT_OP_START_DISCOVERY, status,
-					   &cp->type, sizeof(cp->type));
-			mgmt_pending_remove(cmd);
-			goto failed;
-		}
-
-		if (test_bit(HCI_INQUIRY, &hdev->flags)) {
-			err = cmd_complete(sk, hdev->id,
-					   MGMT_OP_START_DISCOVERY,
-					   MGMT_STATUS_BUSY, &cp->type,
-					   sizeof(cp->type));
-			mgmt_pending_remove(cmd);
-			goto failed;
-		}
-
-		hci_inquiry_cache_flush(hdev);
-
-		memset(&inq_cp, 0, sizeof(inq_cp));
-		memcpy(&inq_cp.lap, lap, sizeof(inq_cp.lap));
-		inq_cp.length = DISCOV_BREDR_INQUIRY_LEN;
-		hci_req_add(&req, HCI_OP_INQUIRY, sizeof(inq_cp), &inq_cp);
-		break;
-
-	case DISCOV_TYPE_LE:
-	case DISCOV_TYPE_INTERLEAVED:
-		status = mgmt_le_support(hdev);
-		if (status) {
-			err = cmd_complete(sk, hdev->id,
-					   MGMT_OP_START_DISCOVERY, status,
-					   &cp->type, sizeof(cp->type));
-			mgmt_pending_remove(cmd);
-			goto failed;
-		}
-
-		if (hdev->discovery.type == DISCOV_TYPE_INTERLEAVED &&
-		    !test_bit(HCI_BREDR_ENABLED, &hdev->dev_flags)) {
-			err = cmd_complete(sk, hdev->id,
-					   MGMT_OP_START_DISCOVERY,
-					   MGMT_STATUS_NOT_SUPPORTED,
-					   &cp->type, sizeof(cp->type));
-			mgmt_pending_remove(cmd);
-			goto failed;
-		}
-
-		if (test_bit(HCI_LE_ADV, &hdev->dev_flags)) {
-			/* Don't let discovery abort an outgoing
-			 * connection attempt that's using directed
-			 * advertising.
-			 */
-			if (hci_conn_hash_lookup_state(hdev, LE_LINK,
-						       BT_CONNECT)) {
-				err = cmd_complete(sk, hdev->id,
-						   MGMT_OP_START_DISCOVERY,
-						   MGMT_STATUS_REJECTED,
-						   &cp->type,
-						   sizeof(cp->type));
-				mgmt_pending_remove(cmd);
-				goto failed;
-			}
-
-			disable_advertising(&req);
-		}
-
-		/* If controller is scanning, it means the background scanning
-		 * is running. Thus, we should temporarily stop it in order to
-		 * set the discovery scanning parameters.
-		 */
-		if (test_bit(HCI_LE_SCAN, &hdev->dev_flags))
-			hci_req_add_le_scan_disable(&req);
-
-		memset(&param_cp, 0, sizeof(param_cp));
-
-		/* All active scans will be done with either a resolvable
-		 * private address (when privacy feature has been enabled)
-		 * or unresolvable private address.
-		 */
-		err = hci_update_random_address(&req, true, &own_addr_type);
-		if (err < 0) {
-			err = cmd_complete(sk, hdev->id,
-					   MGMT_OP_START_DISCOVERY,
-					   MGMT_STATUS_FAILED,
-					   &cp->type, sizeof(cp->type));
-			mgmt_pending_remove(cmd);
-			goto failed;
-		}
-
-		param_cp.type = LE_SCAN_ACTIVE;
-		param_cp.interval = cpu_to_le16(DISCOV_LE_SCAN_INT);
-		param_cp.window = cpu_to_le16(DISCOV_LE_SCAN_WIN);
-		param_cp.own_address_type = own_addr_type;
-		hci_req_add(&req, HCI_OP_LE_SET_SCAN_PARAM, sizeof(param_cp),
-			    &param_cp);
-
-		memset(&enable_cp, 0, sizeof(enable_cp));
-		enable_cp.enable = LE_SCAN_ENABLE;
-		enable_cp.filter_dup = LE_SCAN_FILTER_DUP_ENABLE;
-		hci_req_add(&req, HCI_OP_LE_SET_SCAN_ENABLE, sizeof(enable_cp),
-			    &enable_cp);
-		break;
-
-	default:
+	if (!trigger_discovery(&req, &status)) {
 		err = cmd_complete(sk, hdev->id, MGMT_OP_START_DISCOVERY,
-				   MGMT_STATUS_INVALID_PARAMS,
-				   &cp->type, sizeof(cp->type));
+				   status, &cp->type, sizeof(cp->type));
 		mgmt_pending_remove(cmd);
 		goto failed;
 	}
-- 
1.9.3

