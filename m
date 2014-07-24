Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [RFC v2] Bluetooth: Add support for using controller white list filtering
Date: Thu, 24 Jul 2014 03:50:14 +0200
Message-Id: <1406166614-1160-1-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The Bluetooth controller can use a white list filter when scanning
to avoid waking up the host for devices that are of no interest.

Devices marked as reporting, direct connection (incoming) or general
connection are now added to the controller white list. The update of
the white list happens just before enabling passive scanning.

In case the white list is full and can not hold all devices, the
white list is not used and the filter policy set to accept all
advertisements.

Using the white list for scanning allows for power saving with
controllers that do not handle the duplicate filtering correctly.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 net/bluetooth/hci_core.c | 105 ++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 103 insertions(+), 2 deletions(-)

diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index d8f91d5b0e56..797b3cdc55e0 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -3636,6 +3636,13 @@ int hci_conn_params_set(struct hci_dev *hdev, bdaddr_t *addr, u8 addr_type,
 	if (params->auto_connect == auto_connect)
 		return 0;
 
+	/* Update setting for auto_connect so that when updating
+	 * the white list, the correct values are available. Any
+	 * changes to the controller white list will happen just
+	 * before enabling passive scanning.
+	 */
+	params->auto_connect = auto_connect;
+
 	list_del_init(&params->action);
 
 	switch (auto_connect) {
@@ -3656,8 +3663,6 @@ int hci_conn_params_set(struct hci_dev *hdev, bdaddr_t *addr, u8 addr_type,
 		break;
 	}
 
-	params->auto_connect = auto_connect;
-
 	BT_DBG("addr %pMR (type %u) auto_connect %u", addr, addr_type,
 	       auto_connect);
 
@@ -5406,12 +5411,101 @@ void hci_req_add_le_scan_disable(struct hci_request *req)
 	hci_req_add(req, HCI_OP_LE_SET_SCAN_ENABLE, sizeof(cp), &cp);
 }
 
+static void add_to_white_list(struct hci_request *req,
+			      struct hci_conn_params *params)
+{
+	struct hci_cp_le_add_to_white_list cp;
+
+	cp.bdaddr_type = params->addr_type;
+	bacpy(&cp.bdaddr, &params->addr);
+
+	hci_req_add(req, HCI_OP_LE_ADD_TO_WHITE_LIST, sizeof(cp), &cp);
+}
+
+static u8 update_white_list(struct hci_request *req)
+{
+	struct hci_dev *hdev = req->hdev;
+	struct hci_conn_params *params;
+	struct bdaddr_list *b;
+	uint8_t white_list_entries = 0;
+
+	/* Go through the current white list programmed into the
+	 * controller one by one and check if that address is still
+	 * in the list of pending connections or list of devices to
+	 * report. If not present in either list, then queue the
+	 * command to remove it from the controller.
+	 */
+	list_for_each_entry(b, &hdev->le_white_list, list) {
+		struct hci_cp_le_del_from_white_list cp;
+
+		if (hci_pend_le_action_lookup(&hdev->pend_le_conns,
+					      &b->bdaddr, b->bdaddr_type) ||
+		    hci_pend_le_action_lookup(&hdev->pend_le_reports,
+					      &b->bdaddr, b->bdaddr_type)) {
+			white_list_entries++;
+			continue;
+		}
+
+		cp.bdaddr_type = b->bdaddr_type;
+		bacpy(&cp.bdaddr, &b->bdaddr);
+
+		hci_req_add(req, HCI_OP_LE_DEL_FROM_WHITE_LIST,
+			    sizeof(cp), &cp);
+	}
+
+	/* Since all no longer valid white list entries have been
+	 * removed, walk through the list of pending connections
+	 * and ensure that any new device gets programmed into
+	 * the controller.
+	 *
+	 * If the list of the devices is larger than the list of
+	 * available white list entries in the controller, then
+	 * just abort and return filer policy value to not use the
+	 * white list.
+	 */
+	list_for_each_entry(params, &hdev->pend_le_conns, action) {
+		if (hci_bdaddr_list_lookup(&hdev->le_white_list,
+					   &params->addr, params->addr_type))
+			continue;
+
+		if (white_list_entries >= hdev->le_white_list_size) {
+			/* Select filter policy to accept all advertising */
+			return 0x00;
+		}
+
+		white_list_entries++;
+		add_to_white_list(req, params);
+	}
+
+	/* After adding all new pending connections, walk through
+	 * the list of pending reports and also add these to the
+	 * white list if there is still space.
+	 */
+	list_for_each_entry(params, &hdev->pend_le_reports, action) {
+		if (hci_bdaddr_list_lookup(&hdev->le_white_list,
+					   &params->addr, params->addr_type))
+			continue;
+
+		if (white_list_entries >= hdev->le_white_list_size) {
+			/* Select filter policy to accept all advertising */
+			return 0x00;
+		}
+
+		white_list_entries++;
+		add_to_white_list(req, params);
+	}
+
+	/* Select filter policy to use white list */
+	return 0x01;
+}
+
 void hci_req_add_le_passive_scan(struct hci_request *req)
 {
 	struct hci_cp_le_set_scan_param param_cp;
 	struct hci_cp_le_set_scan_enable enable_cp;
 	struct hci_dev *hdev = req->hdev;
 	u8 own_addr_type;
+	u8 filter_policy;
 
 	/* Set require_privacy to false since no SCAN_REQ are send
 	 * during passive scanning. Not using an unresolvable address
@@ -5422,11 +5516,18 @@ void hci_req_add_le_passive_scan(struct hci_request *req)
 	if (hci_update_random_address(req, false, &own_addr_type))
 		return;
 
+	/* Adding or removing entries from the white list must
+	 * happen before enabling scanning. The controller does
+	 * not allow white list modification while scanning.
+	 */
+	filter_policy = update_white_list(req);
+
 	memset(&param_cp, 0, sizeof(param_cp));
 	param_cp.type = LE_SCAN_PASSIVE;
 	param_cp.interval = cpu_to_le16(hdev->le_scan_interval);
 	param_cp.window = cpu_to_le16(hdev->le_scan_window);
 	param_cp.own_address_type = own_addr_type;
+	param_cp.filter_policy = filter_policy;
 	hci_req_add(req, HCI_OP_LE_SET_SCAN_PARAM, sizeof(param_cp),
 		    &param_cp);
 
-- 
1.9.3

