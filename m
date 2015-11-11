Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Date: Wed, 11 Nov 2015 08:30:30 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v3 1/2] Bluetooth: Move Start Discovery to req_workqueue
Message-ID: <20151111063030.GA11256@t440s.P-661HNU-F1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

Since discovery also deals with LE scanning it makes sense to move it
behind the same req_workqueue as other LE scanning changes. This also
simplifies the logic since we do many of the actions in a synchronous
manner.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 include/net/bluetooth/hci_core.h |   2 +
 net/bluetooth/hci_request.c      | 202 +++++++++++++++++++++++++++++++++
 net/bluetooth/mgmt.c             | 238 ++-------------------------------------
 3 files changed, 213 insertions(+), 229 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 1f75aebbd8c4..72ea8a6d7d70 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -327,6 +327,7 @@ struct hci_dev {
 	struct work_struct	cmd_work;
 	struct work_struct	tx_work;
 
+	struct work_struct	discov_update;
 	struct work_struct	bg_scan_update;
 	struct delayed_work	le_scan_disable;
 	struct delayed_work	le_scan_restart;
@@ -1473,6 +1474,7 @@ void mgmt_ssp_enable_complete(struct hci_dev *hdev, u8 enable, u8 status);
 void mgmt_set_class_of_dev_complete(struct hci_dev *hdev, u8 *dev_class,
 				    u8 status);
 void mgmt_set_local_name_complete(struct hci_dev *hdev, u8 *name, u8 status);
+void mgmt_start_discovery_complete(struct hci_dev *hdev, u8 status);
 void mgmt_device_found(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 link_type,
 		       u8 addr_type, u8 *dev_class, s8 rssi, u32 flags,
 		       u8 *eir, u16 eir_len, u8 *scan_rsp, u8 scan_rsp_len);
diff --git a/net/bluetooth/hci_request.c b/net/bluetooth/hci_request.c
index ecfa4105e00d..da1e30b85e77 100644
--- a/net/bluetooth/hci_request.c
+++ b/net/bluetooth/hci_request.c
@@ -1042,8 +1042,209 @@ static void le_scan_restart_work(struct work_struct *work)
 	le_scan_restart_work_complete(hdev, status);
 }
 
+static int bredr_inquiry(struct hci_request *req, unsigned long opt)
+{
+	struct hci_cp_inquiry cp;
+	/* General inquiry access code (GIAC) */
+	u8 lap[3] = { 0x33, 0x8b, 0x9e };
+
+	BT_DBG("%s", req->hdev->name);
+
+	hci_dev_lock(req->hdev);
+	hci_inquiry_cache_flush(req->hdev);
+	hci_dev_unlock(req->hdev);
+
+	memset(&cp, 0, sizeof(cp));
+	memcpy(&cp.lap, lap, sizeof(cp.lap));
+	cp.length = DISCOV_BREDR_INQUIRY_LEN;
+
+	hci_req_add(req, HCI_OP_INQUIRY, sizeof(cp), &cp);
+
+	return 0;
+}
+
+static void cancel_adv_timeout(struct hci_dev *hdev)
+{
+	if (hdev->adv_instance_timeout) {
+		hdev->adv_instance_timeout = 0;
+		cancel_delayed_work(&hdev->adv_instance_expire);
+	}
+}
+
+static void disable_advertising(struct hci_request *req)
+{
+	u8 enable = 0x00;
+
+	hci_req_add(req, HCI_OP_LE_SET_ADV_ENABLE, sizeof(enable), &enable);
+}
+
+static int active_scan(struct hci_request *req, unsigned long opt)
+{
+	uint16_t interval = opt;
+	struct hci_dev *hdev = req->hdev;
+	struct hci_cp_le_set_scan_param param_cp;
+	struct hci_cp_le_set_scan_enable enable_cp;
+	u8 own_addr_type;
+	int err;
+
+	BT_DBG("%s", hdev->name);
+
+	if (hci_dev_test_flag(hdev, HCI_LE_ADV)) {
+		hci_dev_lock(hdev);
+
+		/* Don't let discovery abort an outgoing connection attempt
+		 * that's using directed advertising.
+		 */
+		if (hci_lookup_le_connect(hdev)) {
+			hci_dev_unlock(hdev);
+			return -EBUSY;
+		}
+
+		cancel_adv_timeout(hdev);
+		hci_dev_unlock(hdev);
+
+		disable_advertising(req);
+	}
+
+	/* If controller is scanning, it means the background scanning is
+	 * running. Thus, we should temporarily stop it in order to set the
+	 * discovery scanning parameters.
+	 */
+	if (hci_dev_test_flag(hdev, HCI_LE_SCAN))
+		hci_req_add_le_scan_disable(req);
+
+	/* All active scans will be done with either a resolvable private
+	 * address (when privacy feature has been enabled) or non-resolvable
+	 * private address.
+	 */
+	err = hci_update_random_address(req, true, &own_addr_type);
+	if (err < 0)
+		own_addr_type = ADDR_LE_DEV_PUBLIC;
+
+	memset(&param_cp, 0, sizeof(param_cp));
+	param_cp.type = LE_SCAN_ACTIVE;
+	param_cp.interval = cpu_to_le16(interval);
+	param_cp.window = cpu_to_le16(DISCOV_LE_SCAN_WIN);
+	param_cp.own_address_type = own_addr_type;
+
+	hci_req_add(req, HCI_OP_LE_SET_SCAN_PARAM, sizeof(param_cp),
+		    &param_cp);
+
+	memset(&enable_cp, 0, sizeof(enable_cp));
+	enable_cp.enable = LE_SCAN_ENABLE;
+	enable_cp.filter_dup = LE_SCAN_FILTER_DUP_ENABLE;
+
+	hci_req_add(req, HCI_OP_LE_SET_SCAN_ENABLE, sizeof(enable_cp),
+		    &enable_cp);
+
+	return 0;
+}
+
+static int interleaved_discov(struct hci_request *req, unsigned long opt)
+{
+	int err;
+
+	BT_DBG("%s", req->hdev->name);
+
+	err = active_scan(req, opt);
+	if (err)
+		return err;
+
+	return bredr_inquiry(req, opt);
+}
+
+static void start_discovery(struct hci_dev *hdev, u8 *status)
+{
+	unsigned long timeout;
+
+	BT_DBG("%s type %u", hdev->name, hdev->discovery.type);
+
+	switch (hdev->discovery.type) {
+	case DISCOV_TYPE_BREDR:
+		if (!hci_dev_test_flag(hdev, HCI_INQUIRY))
+			hci_req_sync(hdev, bredr_inquiry, 0, HCI_CMD_TIMEOUT,
+				     status);
+		return;
+	case DISCOV_TYPE_INTERLEAVED:
+		/* When running simultaneous discovery, the LE scanning time
+		 * should occupy the whole discovery time sine BR/EDR inquiry
+		 * and LE scanning are scheduled by the controller.
+		 *
+		 * For interleaving discovery in comparison, BR/EDR inquiry
+		 * and LE scanning are done sequentially with separate
+		 * timeouts.
+		 */
+		if (test_bit(HCI_QUIRK_SIMULTANEOUS_DISCOVERY,
+			     &hdev->quirks)) {
+			timeout = msecs_to_jiffies(DISCOV_LE_TIMEOUT);
+			/* During simultaneous discovery, we double LE scan
+			 * interval. We must leave some time for the controller
+			 * to do BR/EDR inquiry.
+			 */
+			hci_req_sync(hdev, interleaved_discov,
+				     DISCOV_LE_SCAN_INT * 2, HCI_CMD_TIMEOUT,
+				     status);
+			break;
+		}
+
+		timeout = msecs_to_jiffies(hdev->discov_interleaved_timeout);
+		hci_req_sync(hdev, active_scan, DISCOV_LE_SCAN_INT,
+			     HCI_CMD_TIMEOUT, status);
+		break;
+	case DISCOV_TYPE_LE:
+		timeout = msecs_to_jiffies(DISCOV_LE_TIMEOUT);
+		hci_req_sync(hdev, active_scan, DISCOV_LE_SCAN_INT,
+			     HCI_CMD_TIMEOUT, status);
+		break;
+	default:
+		*status = HCI_ERROR_UNSPECIFIED;
+		return;
+	}
+
+	if (*status)
+		return;
+
+	BT_DBG("%s timeout %u ms", hdev->name, jiffies_to_msecs(timeout));
+
+	/* When service discovery is used and the controller has a
+	 * strict duplicate filter, it is important to remember the
+	 * start and duration of the scan. This is required for
+	 * restarting scanning during the discovery phase.
+	 */
+	if (test_bit(HCI_QUIRK_STRICT_DUPLICATE_FILTER, &hdev->quirks) &&
+		     hdev->discovery.result_filtering) {
+		hdev->discovery.scan_start = jiffies;
+		hdev->discovery.scan_duration = timeout;
+	}
+
+	queue_delayed_work(hdev->req_workqueue, &hdev->le_scan_disable,
+			   timeout);
+}
+
+static void discov_update(struct work_struct *work)
+{
+	struct hci_dev *hdev = container_of(work, struct hci_dev,
+					    discov_update);
+	u8 status = 0;
+
+	switch (hdev->discovery.state) {
+	case DISCOVERY_STARTING:
+		start_discovery(hdev, &status);
+		mgmt_start_discovery_complete(hdev, status);
+		if (status)
+			hci_discovery_set_state(hdev, DISCOVERY_STOPPED);
+		else
+			hci_discovery_set_state(hdev, DISCOVERY_FINDING);
+		break;
+	case DISCOVERY_STOPPED:
+	default:
+		return;
+	}
+}
+
 void hci_request_setup(struct hci_dev *hdev)
 {
+	INIT_WORK(&hdev->discov_update, discov_update);
 	INIT_WORK(&hdev->bg_scan_update, bg_scan_update);
 	INIT_DELAYED_WORK(&hdev->le_scan_disable, le_scan_disable_work);
 	INIT_DELAYED_WORK(&hdev->le_scan_restart, le_scan_restart_work);
@@ -1051,6 +1252,7 @@ void hci_request_setup(struct hci_dev *hdev)
 
 void hci_request_cancel_all(struct hci_dev *hdev)
 {
+	cancel_work_sync(&hdev->discov_update);
 	cancel_work_sync(&hdev->bg_scan_update);
 	cancel_delayed_work_sync(&hdev->le_scan_disable);
 	cancel_delayed_work_sync(&hdev->le_scan_restart);
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index e634b4d85249..63b099471c92 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -4164,145 +4164,9 @@ done:
 	return err;
 }
 
-static bool trigger_bredr_inquiry(struct hci_request *req, u8 *status)
-{
-	struct hci_dev *hdev = req->hdev;
-	struct hci_cp_inquiry cp;
-	/* General inquiry access code (GIAC) */
-	u8 lap[3] = { 0x33, 0x8b, 0x9e };
-
-	*status = mgmt_bredr_support(hdev);
-	if (*status)
-		return false;
-
-	if (hci_dev_test_flag(hdev, HCI_INQUIRY)) {
-		*status = MGMT_STATUS_BUSY;
-		return false;
-	}
-
-	hci_inquiry_cache_flush(hdev);
-
-	memset(&cp, 0, sizeof(cp));
-	memcpy(&cp.lap, lap, sizeof(cp.lap));
-	cp.length = DISCOV_BREDR_INQUIRY_LEN;
-
-	hci_req_add(req, HCI_OP_INQUIRY, sizeof(cp), &cp);
-
-	return true;
-}
-
-static bool trigger_le_scan(struct hci_request *req, u16 interval, u8 *status)
-{
-	struct hci_dev *hdev = req->hdev;
-	struct hci_cp_le_set_scan_param param_cp;
-	struct hci_cp_le_set_scan_enable enable_cp;
-	u8 own_addr_type;
-	int err;
-
-	*status = mgmt_le_support(hdev);
-	if (*status)
-		return false;
-
-	if (hci_dev_test_flag(hdev, HCI_LE_ADV)) {
-		/* Don't let discovery abort an outgoing connection attempt
-		 * that's using directed advertising.
-		 */
-		if (hci_lookup_le_connect(hdev)) {
-			*status = MGMT_STATUS_REJECTED;
-			return false;
-		}
-
-		cancel_adv_timeout(hdev);
-		disable_advertising(req);
-	}
-
-	/* If controller is scanning, it means the background scanning is
-	 * running. Thus, we should temporarily stop it in order to set the
-	 * discovery scanning parameters.
-	 */
-	if (hci_dev_test_flag(hdev, HCI_LE_SCAN))
-		hci_req_add_le_scan_disable(req);
-
-	/* All active scans will be done with either a resolvable private
-	 * address (when privacy feature has been enabled) or non-resolvable
-	 * private address.
-	 */
-	err = hci_update_random_address(req, true, &own_addr_type);
-	if (err < 0) {
-		*status = MGMT_STATUS_FAILED;
-		return false;
-	}
-
-	memset(&param_cp, 0, sizeof(param_cp));
-	param_cp.type = LE_SCAN_ACTIVE;
-	param_cp.interval = cpu_to_le16(interval);
-	param_cp.window = cpu_to_le16(DISCOV_LE_SCAN_WIN);
-	param_cp.own_address_type = own_addr_type;
-
-	hci_req_add(req, HCI_OP_LE_SET_SCAN_PARAM, sizeof(param_cp),
-		    &param_cp);
-
-	memset(&enable_cp, 0, sizeof(enable_cp));
-	enable_cp.enable = LE_SCAN_ENABLE;
-	enable_cp.filter_dup = LE_SCAN_FILTER_DUP_ENABLE;
-
-	hci_req_add(req, HCI_OP_LE_SET_SCAN_ENABLE, sizeof(enable_cp),
-		    &enable_cp);
-
-	return true;
-}
-
-static bool trigger_discovery(struct hci_request *req, u8 *status)
-{
-	struct hci_dev *hdev = req->hdev;
-
-	switch (hdev->discovery.type) {
-	case DISCOV_TYPE_BREDR:
-		if (!trigger_bredr_inquiry(req, status))
-			return false;
-		break;
-
-	case DISCOV_TYPE_INTERLEAVED:
-		if (test_bit(HCI_QUIRK_SIMULTANEOUS_DISCOVERY,
-			     &hdev->quirks)) {
-			/* During simultaneous discovery, we double LE scan
-			 * interval. We must leave some time for the controller
-			 * to do BR/EDR inquiry.
-			 */
-			if (!trigger_le_scan(req, DISCOV_LE_SCAN_INT * 2,
-					     status))
-				return false;
-
-			if (!trigger_bredr_inquiry(req, status))
-				return false;
-
-			return true;
-		}
-
-		if (!hci_dev_test_flag(hdev, HCI_BREDR_ENABLED)) {
-			*status = MGMT_STATUS_NOT_SUPPORTED;
-			return false;
-		}
-		/* fall through */
-
-	case DISCOV_TYPE_LE:
-		if (!trigger_le_scan(req, DISCOV_LE_SCAN_INT, status))
-			return false;
-		break;
-
-	default:
-		*status = MGMT_STATUS_INVALID_PARAMS;
-		return false;
-	}
-
-	return true;
-}
-
-static void start_discovery_complete(struct hci_dev *hdev, u8 status,
-				     u16 opcode)
+void mgmt_start_discovery_complete(struct hci_dev *hdev, u8 status)
 {
 	struct mgmt_pending_cmd *cmd;
-	unsigned long timeout;
 
 	BT_DBG("status %d", status);
 
@@ -4317,61 +4181,6 @@ static void start_discovery_complete(struct hci_dev *hdev, u8 status,
 		mgmt_pending_remove(cmd);
 	}
 
-	if (status) {
-		hci_discovery_set_state(hdev, DISCOVERY_STOPPED);
-		goto unlock;
-	}
-
-	hci_discovery_set_state(hdev, DISCOVERY_FINDING);
-
-	/* If the scan involves LE scan, pick proper timeout to schedule
-	 * hdev->le_scan_disable that will stop it.
-	 */
-	switch (hdev->discovery.type) {
-	case DISCOV_TYPE_LE:
-		timeout = msecs_to_jiffies(DISCOV_LE_TIMEOUT);
-		break;
-	case DISCOV_TYPE_INTERLEAVED:
-		 /* When running simultaneous discovery, the LE scanning time
-		 * should occupy the whole discovery time sine BR/EDR inquiry
-		 * and LE scanning are scheduled by the controller.
-		 *
-		 * For interleaving discovery in comparison, BR/EDR inquiry
-		 * and LE scanning are done sequentially with separate
-		 * timeouts.
-		 */
-		if (test_bit(HCI_QUIRK_SIMULTANEOUS_DISCOVERY, &hdev->quirks))
-			timeout = msecs_to_jiffies(DISCOV_LE_TIMEOUT);
-		else
-			timeout = msecs_to_jiffies(hdev->discov_interleaved_timeout);
-		break;
-	case DISCOV_TYPE_BREDR:
-		timeout = 0;
-		break;
-	default:
-		BT_ERR("Invalid discovery type %d", hdev->discovery.type);
-		timeout = 0;
-		break;
-	}
-
-	if (timeout) {
-		/* When service discovery is used and the controller has
-		 * a strict duplicate filter, it is important to remember
-		 * the start and duration of the scan. This is required
-		 * for restarting scanning during the discovery phase.
-		 */
-		if (test_bit(HCI_QUIRK_STRICT_DUPLICATE_FILTER,
-			     &hdev->quirks) &&
-		    hdev->discovery.result_filtering) {
-			hdev->discovery.scan_start = jiffies;
-			hdev->discovery.scan_duration = timeout;
-		}
-
-		queue_delayed_work(hdev->req_workqueue,
-				   &hdev->le_scan_disable, timeout);
-	}
-
-unlock:
 	hci_dev_unlock(hdev);
 }
 
@@ -4407,7 +4216,6 @@ static int start_discovery(struct sock *sk, struct hci_dev *hdev,
 {
 	struct mgmt_cp_start_discovery *cp = data;
 	struct mgmt_pending_cmd *cmd;
-	struct hci_request req;
 	u8 status;
 	int err;
 
@@ -4436,14 +4244,6 @@ static int start_discovery(struct sock *sk, struct hci_dev *hdev,
 		goto failed;
 	}
 
-	cmd = mgmt_pending_add(sk, MGMT_OP_START_DISCOVERY, hdev, data, len);
-	if (!cmd) {
-		err = -ENOMEM;
-		goto failed;
-	}
-
-	cmd->cmd_complete = generic_cmd_complete;
-
 	/* Clear the discovery filter first to free any previously
 	 * allocated memory for the UUID list.
 	 */
@@ -4452,22 +4252,17 @@ static int start_discovery(struct sock *sk, struct hci_dev *hdev,
 	hdev->discovery.type = cp->type;
 	hdev->discovery.report_invalid_rssi = false;
 
-	hci_req_init(&req, hdev);
-
-	if (!trigger_discovery(&req, &status)) {
-		err = mgmt_cmd_complete(sk, hdev->id, MGMT_OP_START_DISCOVERY,
-					status, &cp->type, sizeof(cp->type));
-		mgmt_pending_remove(cmd);
+	cmd = mgmt_pending_add(sk, MGMT_OP_START_DISCOVERY, hdev, data, len);
+	if (!cmd) {
+		err = -ENOMEM;
 		goto failed;
 	}
 
-	err = hci_req_run(&req, start_discovery_complete);
-	if (err < 0) {
-		mgmt_pending_remove(cmd);
-		goto failed;
-	}
+	cmd->cmd_complete = generic_cmd_complete;
 
 	hci_discovery_set_state(hdev, DISCOVERY_STARTING);
+	queue_work(hdev->req_workqueue, &hdev->discov_update);
+	err = 0;
 
 failed:
 	hci_dev_unlock(hdev);
@@ -4486,7 +4281,6 @@ static int start_service_discovery(struct sock *sk, struct hci_dev *hdev,
 {
 	struct mgmt_cp_start_service_discovery *cp = data;
 	struct mgmt_pending_cmd *cmd;
-	struct hci_request req;
 	const u16 max_uuid_count = ((U16_MAX - sizeof(*cp)) / 16);
 	u16 uuid_count, expected_len;
 	u8 status;
@@ -4574,23 +4368,9 @@ static int start_service_discovery(struct sock *sk, struct hci_dev *hdev,
 		}
 	}
 
-	hci_req_init(&req, hdev);
-
-	if (!trigger_discovery(&req, &status)) {
-		err = mgmt_cmd_complete(sk, hdev->id,
-					MGMT_OP_START_SERVICE_DISCOVERY,
-					status, &cp->type, sizeof(cp->type));
-		mgmt_pending_remove(cmd);
-		goto failed;
-	}
-
-	err = hci_req_run(&req, start_discovery_complete);
-	if (err < 0) {
-		mgmt_pending_remove(cmd);
-		goto failed;
-	}
-
 	hci_discovery_set_state(hdev, DISCOVERY_STARTING);
+	queue_work(hdev->req_workqueue, &hdev->discov_update);
+	err = 0;
 
 failed:
 	hci_dev_unlock(hdev);
-- 
2.5.0

