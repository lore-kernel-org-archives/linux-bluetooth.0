Return-Path: <cyrus@holtmann.org>
From: Alfonso Acosta <fons@spotify.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2] Bluetooth: Add HCI_AUTO_CONN_DIRECT_REPORT_IND
Date: Fri, 26 Sep 2014 15:29:07 +0000
Message-Id: <1411745347-9430-1-git-send-email-fons@spotify.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

HCI_AUTO_CONN_DIRECT_REPORT_IND (associated to a new autoconnect
action, 0x03) treats advertising reports like a combination of
HCI_AUTO_CONN_DIRECT and HCI_AUTO_CONN_REPORT:

* Autoconnects on ADV_DIRECT_IND reports.
* Notifies userland (MGMT_EV_DEVICE_FOUND) about ADV_IND reports.

This is useful to communicate with autoconnectable devices which
advertise meaningful ADV_IND reports.

HCI_AUTO_CONN_DIRECT_REPORT_IND requires being able to simultaneously
have a pending report and connection action. I merged pend_le_reports
and pend_le_conns into the new pend_le_actions in order to make that
possible while maintaining a unique list_head in hci_conn_parameters
(action). This results in simpler handling of pending actions.

Signed-off-by: Alfonso Acosta <fons@spotify.com>
---
 include/net/bluetooth/hci_core.h |  6 ++---
 net/bluetooth/hci_conn.c         |  2 +-
 net/bluetooth/hci_core.c         | 54 ++++++++++------------------------------
 net/bluetooth/hci_event.c        | 24 ++++++++++++------
 net/bluetooth/mgmt.c             | 30 ++++++++++++++++------
 5 files changed, 56 insertions(+), 60 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 37ff1ae..59393ea 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -317,8 +317,7 @@ struct hci_dev {
 	struct list_head	remote_oob_data;
 	struct list_head	le_white_list;
 	struct list_head	le_conn_params;
-	struct list_head	pend_le_conns;
-	struct list_head	pend_le_reports;
+	struct list_head	pend_le_actions;
 
 	struct hci_dev_stats	stat;
 
@@ -461,6 +460,7 @@ struct hci_conn_params {
 		HCI_AUTO_CONN_DISABLED,
 		HCI_AUTO_CONN_REPORT,
 		HCI_AUTO_CONN_DIRECT,
+		HCI_AUTO_CONN_DIRECT_REPORT_IND,
 		HCI_AUTO_CONN_ALWAYS,
 		HCI_AUTO_CONN_LINK_LOSS,
 	} auto_connect;
@@ -881,7 +881,7 @@ void hci_conn_params_del(struct hci_dev *hdev, bdaddr_t *addr, u8 addr_type);
 void hci_conn_params_clear_all(struct hci_dev *hdev);
 void hci_conn_params_clear_disabled(struct hci_dev *hdev);
 
-struct hci_conn_params *hci_pend_le_action_lookup(struct list_head *list,
+struct hci_conn_params *hci_pend_le_action_lookup(struct hci_dev *hdev,
 						  bdaddr_t *addr,
 						  u8 addr_type);
 
diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index b9517bd..f65b705 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -596,7 +596,7 @@ void hci_le_conn_failed(struct hci_conn *conn, u8 status)
 	struct hci_dev *hdev = conn->hdev;
 	struct hci_conn_params *params;
 
-	params = hci_pend_le_action_lookup(&hdev->pend_le_conns, &conn->dst,
+	params = hci_pend_le_action_lookup(&hdev->pend_le_actions, &conn->dst,
 					   conn->dst_type);
 	if (params && params->conn) {
 		hci_conn_drop(params->conn);
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index cb05d7f..980ec2e 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -3631,7 +3631,7 @@ static bool is_connected(struct hci_dev *hdev, bdaddr_t *addr, u8 type)
 }
 
 /* This function requires the caller holds hdev->lock */
-struct hci_conn_params *hci_pend_le_action_lookup(struct list_head *list,
+struct hci_conn_params *hci_pend_le_action_lookup(struct hci_dev *hdev,
 						  bdaddr_t *addr, u8 addr_type)
 {
 	struct hci_conn_params *param;
@@ -3640,7 +3640,7 @@ struct hci_conn_params *hci_pend_le_action_lookup(struct list_head *list,
 	if (!hci_is_identity_address(addr, addr_type))
 		return NULL;
 
-	list_for_each_entry(param, list, action) {
+	list_for_each_entry(param, &hdev->pend_le_actions, action) {
 		if (bacmp(&param->addr, addr) == 0 &&
 		    param->addr_type == addr_type)
 			return param;
@@ -3706,13 +3706,14 @@ int hci_conn_params_set(struct hci_dev *hdev, bdaddr_t *addr, u8 addr_type,
 		hci_update_background_scan(hdev);
 		break;
 	case HCI_AUTO_CONN_REPORT:
-		list_add(&params->action, &hdev->pend_le_reports);
+	case HCI_AUTO_CONN_DIRECT_REPORT_IND:
+		list_add(&params->action, &hdev->pend_le_actions);
 		hci_update_background_scan(hdev);
 		break;
 	case HCI_AUTO_CONN_DIRECT:
 	case HCI_AUTO_CONN_ALWAYS:
 		if (!is_connected(hdev, addr, addr_type)) {
-			list_add(&params->action, &hdev->pend_le_conns);
+			list_add(&params->action, &hdev->pend_le_actions);
 			hci_update_background_scan(hdev);
 		}
 		break;
@@ -4020,8 +4021,7 @@ struct hci_dev *hci_alloc_dev(void)
 	INIT_LIST_HEAD(&hdev->remote_oob_data);
 	INIT_LIST_HEAD(&hdev->le_white_list);
 	INIT_LIST_HEAD(&hdev->le_conn_params);
-	INIT_LIST_HEAD(&hdev->pend_le_conns);
-	INIT_LIST_HEAD(&hdev->pend_le_reports);
+	INIT_LIST_HEAD(&hdev->pend_le_actions);
 	INIT_LIST_HEAD(&hdev->conn_hash.list);
 
 	INIT_WORK(&hdev->rx_work, hci_rx_work);
@@ -5467,16 +5467,13 @@ static u8 update_white_list(struct hci_request *req)
 
 	/* Go through the current white list programmed into the
 	 * controller one by one and check if that address is still
-	 * in the list of pending connections or list of devices to
-	 * report. If not present in either list, then queue the
-	 * command to remove it from the controller.
+	 * in the list of pending actions list. If not present,
+	 * then queue the command to remove it from the controller.
 	 */
 	list_for_each_entry(b, &hdev->le_white_list, list) {
 		struct hci_cp_le_del_from_white_list cp;
 
-		if (hci_pend_le_action_lookup(&hdev->pend_le_conns,
-					      &b->bdaddr, b->bdaddr_type) ||
-		    hci_pend_le_action_lookup(&hdev->pend_le_reports,
+		if (hci_pend_le_action_lookup(hdev,
 					      &b->bdaddr, b->bdaddr_type)) {
 			white_list_entries++;
 			continue;
@@ -5490,7 +5487,7 @@ static u8 update_white_list(struct hci_request *req)
 	}
 
 	/* Since all no longer valid white list entries have been
-	 * removed, walk through the list of pending connections
+	 * removed, walk through the list of pending actions
 	 * and ensure that any new device gets programmed into
 	 * the controller.
 	 *
@@ -5499,31 +5496,7 @@ static u8 update_white_list(struct hci_request *req)
 	 * just abort and return filer policy value to not use the
 	 * white list.
 	 */
-	list_for_each_entry(params, &hdev->pend_le_conns, action) {
-		if (hci_bdaddr_list_lookup(&hdev->le_white_list,
-					   &params->addr, params->addr_type))
-			continue;
-
-		if (white_list_entries >= hdev->le_white_list_size) {
-			/* Select filter policy to accept all advertising */
-			return 0x00;
-		}
-
-		if (hci_find_irk_by_addr(hdev, &params->addr,
-					 params->addr_type)) {
-			/* White list can not be used with RPAs */
-			return 0x00;
-		}
-
-		white_list_entries++;
-		add_to_white_list(req, params);
-	}
-
-	/* After adding all new pending connections, walk through
-	 * the list of pending reports and also add these to the
-	 * white list if there is still space.
-	 */
-	list_for_each_entry(params, &hdev->pend_le_reports, action) {
+	list_for_each_entry(params, &hdev->pend_le_actions, action) {
 		if (hci_bdaddr_list_lookup(&hdev->le_white_list,
 					   &params->addr, params->addr_type))
 			continue;
@@ -5593,7 +5566,7 @@ static void update_background_scan_complete(struct hci_dev *hdev, u8 status)
 		       "status 0x%2.2x", status);
 }
 
-/* This function controls the background scanning based on hdev->pend_le_conns
+/* This function controls the background scanning based on hdev->pend_le_actions
  * list. If there are pending LE connection we start the background scanning,
  * otherwise we stop it.
  *
@@ -5623,8 +5596,7 @@ void hci_update_background_scan(struct hci_dev *hdev)
 
 	hci_req_init(&req, hdev);
 
-	if (list_empty(&hdev->pend_le_conns) &&
-	    list_empty(&hdev->pend_le_reports)) {
+	if (list_empty(&hdev->pend_le_actions)) {
 		/* If there is no pending LE connections or devices
 		 * to be scanned for, we should stop the background
 		 * scanning.
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 8b0a2a6..3d669da 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -2265,9 +2265,10 @@ static void hci_disconn_complete_evt(struct hci_dev *hdev, struct sk_buff *skb)
 			/* Fall through */
 
 		case HCI_AUTO_CONN_DIRECT:
+		case HCI_AUTO_CONN_DIRECT_REPORT_IND:
 		case HCI_AUTO_CONN_ALWAYS:
 			list_del_init(&params->action);
-			list_add(&params->action, &hdev->pend_le_conns);
+			list_add(&params->action, &hdev->pend_le_actions);
 			hci_update_background_scan(hdev);
 			break;
 
@@ -4292,13 +4293,13 @@ static void check_pending_le_conn(struct hci_dev *hdev, bdaddr_t *addr,
 	/* If we're not connectable only connect devices that we have in
 	 * our pend_le_conns list.
 	 */
-	params = hci_pend_le_action_lookup(&hdev->pend_le_conns,
-					   addr, addr_type);
+	params = hci_pend_le_action_lookup(hdev, addr, addr_type);
 	if (!params)
 		return;
 
 	switch (params->auto_connect) {
 	case HCI_AUTO_CONN_DIRECT:
+	case HCI_AUTO_CONN_DIRECT_REPORT_IND:
 		/* Only devices advertising with ADV_DIRECT_IND are
 		 * triggering a connection attempt. This is allowing
 		 * incoming connections from slave devices.
@@ -4351,6 +4352,7 @@ static void process_adv_report(struct hci_dev *hdev, u8 type, bdaddr_t *bdaddr,
 	struct smp_irk *irk;
 	bool match;
 	u32 flags;
+	struct hci_conn_params *params;
 
 	/* Check if we need to convert to identity address */
 	irk = hci_get_irk(hdev, bdaddr, bdaddr_type);
@@ -4363,17 +4365,25 @@ static void process_adv_report(struct hci_dev *hdev, u8 type, bdaddr_t *bdaddr,
 	check_pending_le_conn(hdev, bdaddr, bdaddr_type, type);
 
 	/* Passive scanning shouldn't trigger any device found events,
-	 * except for devices marked as CONN_REPORT for which we do send
-	 * device found events.
+	 * except for devices marked as CONN_REPORT or CONN_DIRECT_REPORT_IND
+	 * for which we do send device found events.
 	 */
 	if (hdev->le_scan_type == LE_SCAN_PASSIVE) {
 		if (type == LE_ADV_DIRECT_IND)
 			return;
 
-		if (!hci_pend_le_action_lookup(&hdev->pend_le_reports,
-					       bdaddr, bdaddr_type))
+		params = hci_pend_le_action_lookup(hdev, bdaddr, bdaddr_type);
+		if (!params)
 			return;
 
+		switch (params->auto_connect) {
+		case HCI_AUTO_CONN_REPORT:
+		case HCI_AUTO_CONN_DIRECT_REPORT_IND:
+		  break;
+		default:
+		  return;
+		}
+
 		if (type == LE_ADV_NONCONN_IND || type == LE_ADV_SCAN_IND)
 			flags = MGMT_DEV_FOUND_NOT_CONNECTABLE;
 		else
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index efb71b0..adb5248 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -5241,7 +5241,7 @@ static int add_device(struct sock *sk, struct hci_dev *hdev,
 				    MGMT_STATUS_INVALID_PARAMS,
 				    &cp->addr, sizeof(cp->addr));
 
-	if (cp->action != 0x00 && cp->action != 0x01 && cp->action != 0x02)
+	if (cp->action > 0x03)
 		return cmd_complete(sk, hdev->id, MGMT_OP_ADD_DEVICE,
 				    MGMT_STATUS_INVALID_PARAMS,
 				    &cp->addr, sizeof(cp->addr));
@@ -5272,7 +5272,9 @@ static int add_device(struct sock *sk, struct hci_dev *hdev,
 	else
 		addr_type = ADDR_LE_DEV_RANDOM;
 
-	if (cp->action == 0x02)
+	if (cp->action == 0x03)
+		auto_conn = HCI_AUTO_CONN_DIRECT_REPORT_IND;
+	else if (cp->action == 0x02)
 		auto_conn = HCI_AUTO_CONN_ALWAYS;
 	else if (cp->action == 0x01)
 		auto_conn = HCI_AUTO_CONN_DIRECT;
@@ -5838,10 +5840,9 @@ static void restart_le_actions(struct hci_dev *hdev)
 		switch (p->auto_connect) {
 		case HCI_AUTO_CONN_DIRECT:
 		case HCI_AUTO_CONN_ALWAYS:
-			list_add(&p->action, &hdev->pend_le_conns);
-			break;
+		case HCI_AUTO_CONN_DIRECT_REPORT_IND:
 		case HCI_AUTO_CONN_REPORT:
-			list_add(&p->action, &hdev->pend_le_reports);
+			list_add(&p->action, &hdev->pend_le_actions);
 			break;
 		default:
 			break;
@@ -6746,16 +6747,29 @@ void mgmt_device_found(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 link_type,
 	char buf[512];
 	struct mgmt_ev_device_found *ev = (void *) buf;
 	size_t ev_size;
+	struct hci_conn_params *params;
 
 	/* Don't send events for a non-kernel initiated discovery. With
-	 * LE one exception is if we have pend_le_reports > 0 in which
+	 * LE one exception is if we have CONN_REPORT in pend_le_actions in which
 	 * case we're doing passive scanning and want these events.
 	 */
 	if (!hci_discovery_active(hdev)) {
 		if (link_type == ACL_LINK)
 			return;
-		if (link_type == LE_LINK && list_empty(&hdev->pend_le_reports))
-			return;
+		if (link_type == LE_LINK)
+		{
+			params = hci_conn_params_lookup(hdev, bdaddr, addr_type);
+			if(!params)
+			  return;
+			switch(params->auto_connect)
+			{
+			case HCI_AUTO_CONN_REPORT:
+			case HCI_AUTO_CONN_DIRECT_REPORT_IND:
+			  break;
+			default:
+			  return;
+			}
+		}
 	}
 
 	/* Make sure that the buffer is big enough. The 5 extra bytes
-- 
1.9.1

