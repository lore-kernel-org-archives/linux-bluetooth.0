Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Johan Hedberg <johan.hedberg@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 2/2] Bluetooth: Add support for Start Limited Discovery command
Date: Tue,  5 Jan 2016 13:19:32 +0200
Message-Id: <1451992772-4971-3-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1451992772-4971-1-git-send-email-johan.hedberg@gmail.com>
References: <1451992772-4971-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

This patch implements the mgmt Start Limited Discovery command. Most
of existing Start Discovery code is reused since the only difference
is the presence of a 'limited' flag as part of the discovery state.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 include/net/bluetooth/hci_core.h |  1 +
 include/net/bluetooth/mgmt.h     |  2 ++
 net/bluetooth/hci_request.c      | 11 ++++++---
 net/bluetooth/mgmt.c             | 53 +++++++++++++++++++++++++++++++++-------
 4 files changed, 55 insertions(+), 12 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 372e2a7c4ada..d4f82edb5cff 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -77,6 +77,7 @@ struct discovery_state {
 	u8			last_adv_data_len;
 	bool			report_invalid_rssi;
 	bool			result_filtering;
+	bool			limited;
 	s8			rssi;
 	u16			uuid_count;
 	u8			(*uuids)[16];
diff --git a/include/net/bluetooth/mgmt.h b/include/net/bluetooth/mgmt.h
index af17774c9416..ea73e0826aa7 100644
--- a/include/net/bluetooth/mgmt.h
+++ b/include/net/bluetooth/mgmt.h
@@ -584,6 +584,8 @@ struct mgmt_rp_get_adv_size_info {
 	__u8	max_scan_rsp_len;
 } __packed;
 
+#define MGMT_OP_START_LIMITED_DISCOVERY	0x0041
+
 #define MGMT_EV_CMD_COMPLETE		0x0001
 struct mgmt_ev_cmd_complete {
 	__le16	opcode;
diff --git a/net/bluetooth/hci_request.c b/net/bluetooth/hci_request.c
index 9997c31ef987..794299c4673a 100644
--- a/net/bluetooth/hci_request.c
+++ b/net/bluetooth/hci_request.c
@@ -1737,8 +1737,8 @@ static int le_scan_disable(struct hci_request *req, unsigned long opt)
 static int bredr_inquiry(struct hci_request *req, unsigned long opt)
 {
 	u8 length = opt;
-	/* General inquiry access code (GIAC) */
-	u8 lap[3] = { 0x33, 0x8b, 0x9e };
+	u8 giac[3] = { 0x33, 0x8b, 0x9e };
+	u8 liac[3] = { 0x00, 0x8b, 0x9e };
 	struct hci_cp_inquiry cp;
 
 	BT_DBG("%s", req->hdev->name);
@@ -1748,7 +1748,12 @@ static int bredr_inquiry(struct hci_request *req, unsigned long opt)
 	hci_dev_unlock(req->hdev);
 
 	memset(&cp, 0, sizeof(cp));
-	memcpy(&cp.lap, lap, sizeof(cp.lap));
+
+	if (req->hdev->discovery.limited)
+		memcpy(&cp.lap, liac, sizeof(cp.lap));
+	else
+		memcpy(&cp.lap, giac, sizeof(cp.lap));
+
 	cp.length = length;
 
 	hci_req_add(req, HCI_OP_INQUIRY, sizeof(cp), &cp);
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 3297a4ecc05e..5a5089cb6570 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -103,6 +103,7 @@ static const u16 mgmt_commands[] = {
 	MGMT_OP_ADD_ADVERTISING,
 	MGMT_OP_REMOVE_ADVERTISING,
 	MGMT_OP_GET_ADV_SIZE_INFO,
+	MGMT_OP_START_LIMITED_DISCOVERY,
 };
 
 static const u16 mgmt_events[] = {
@@ -3283,6 +3284,9 @@ void mgmt_start_discovery_complete(struct hci_dev *hdev, u8 status)
 	if (!cmd)
 		cmd = pending_find(MGMT_OP_START_SERVICE_DISCOVERY, hdev);
 
+	if (!cmd)
+		cmd = pending_find(MGMT_OP_START_LIMITED_DISCOVERY, hdev);
+
 	if (cmd) {
 		cmd->cmd_complete(cmd, mgmt_status(status));
 		mgmt_pending_remove(cmd);
@@ -3318,8 +3322,8 @@ static bool discovery_type_is_valid(struct hci_dev *hdev, uint8_t type,
 	return true;
 }
 
-static int start_discovery(struct sock *sk, struct hci_dev *hdev,
-			   void *data, u16 len)
+static int start_discovery_internal(struct sock *sk, struct hci_dev *hdev,
+				    u16 op, void *data, u16 len)
 {
 	struct mgmt_cp_start_discovery *cp = data;
 	struct mgmt_pending_cmd *cmd;
@@ -3331,7 +3335,7 @@ static int start_discovery(struct sock *sk, struct hci_dev *hdev,
 	hci_dev_lock(hdev);
 
 	if (!hdev_is_powered(hdev)) {
-		err = mgmt_cmd_complete(sk, hdev->id, MGMT_OP_START_DISCOVERY,
+		err = mgmt_cmd_complete(sk, hdev->id, op,
 					MGMT_STATUS_NOT_POWERED,
 					&cp->type, sizeof(cp->type));
 		goto failed;
@@ -3339,15 +3343,14 @@ static int start_discovery(struct sock *sk, struct hci_dev *hdev,
 
 	if (hdev->discovery.state != DISCOVERY_STOPPED ||
 	    hci_dev_test_flag(hdev, HCI_PERIODIC_INQ)) {
-		err = mgmt_cmd_complete(sk, hdev->id, MGMT_OP_START_DISCOVERY,
-					MGMT_STATUS_BUSY, &cp->type,
-					sizeof(cp->type));
+		err = mgmt_cmd_complete(sk, hdev->id, op, MGMT_STATUS_BUSY,
+					&cp->type, sizeof(cp->type));
 		goto failed;
 	}
 
 	if (!discovery_type_is_valid(hdev, cp->type, &status)) {
-		err = mgmt_cmd_complete(sk, hdev->id, MGMT_OP_START_DISCOVERY,
-					status, &cp->type, sizeof(cp->type));
+		err = mgmt_cmd_complete(sk, hdev->id, op, status,
+					&cp->type, sizeof(cp->type));
 		goto failed;
 	}
 
@@ -3358,8 +3361,12 @@ static int start_discovery(struct sock *sk, struct hci_dev *hdev,
 
 	hdev->discovery.type = cp->type;
 	hdev->discovery.report_invalid_rssi = false;
+	if (op == MGMT_OP_START_LIMITED_DISCOVERY)
+		hdev->discovery.limited = true;
+	else
+		hdev->discovery.limited = false;
 
-	cmd = mgmt_pending_add(sk, MGMT_OP_START_DISCOVERY, hdev, data, len);
+	cmd = mgmt_pending_add(sk, op, hdev, data, len);
 	if (!cmd) {
 		err = -ENOMEM;
 		goto failed;
@@ -3376,6 +3383,21 @@ failed:
 	return err;
 }
 
+static int start_discovery(struct sock *sk, struct hci_dev *hdev,
+			   void *data, u16 len)
+{
+	return start_discovery_internal(sk, hdev, MGMT_OP_START_DISCOVERY,
+					data, len);
+}
+
+static int start_limited_discovery(struct sock *sk, struct hci_dev *hdev,
+				   void *data, u16 len)
+{
+	return start_discovery_internal(sk, hdev,
+					MGMT_OP_START_LIMITED_DISCOVERY,
+					data, len);
+}
+
 static int service_discovery_cmd_complete(struct mgmt_pending_cmd *cmd,
 					  u8 status)
 {
@@ -6313,6 +6335,7 @@ static const struct hci_mgmt_handler mgmt_handlers[] = {
 						HCI_MGMT_VAR_LEN },
 	{ remove_advertising,	   MGMT_REMOVE_ADVERTISING_SIZE },
 	{ get_adv_size_info,       MGMT_GET_ADV_SIZE_INFO_SIZE },
+	{ start_limited_discovery, MGMT_START_DISCOVERY_SIZE },
 };
 
 void mgmt_index_added(struct hci_dev *hdev)
@@ -7237,6 +7260,18 @@ void mgmt_device_found(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 link_type,
 			return;
 	}
 
+	if (hdev->discovery.limited) {
+		/* Check for limited discoverable bit */
+		if (dev_class) {
+			if (!(dev_class[1] & 0x20))
+				return;
+		} else {
+			u8 *flags = eir_get_data(eir, eir_len, EIR_FLAGS, NULL);
+			if (!flags || !(flags[0] & LE_AD_LIMITED))
+				return;
+		}
+	}
+
 	/* Make sure that the buffer is big enough. The 5 extra bytes
 	 * are for the potential CoD field.
 	 */
-- 
2.5.0

