Return-Path: <cyrus@holtmann.org>
From: Johan Hedberg <johan.hedberg@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/4] Bluetooth: Fix LE reconnection logic
Date: Fri, 16 Oct 2015 08:41:40 +0300
Message-Id: <1444974102-32379-3-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1444974102-32379-1-git-send-email-johan.hedberg@gmail.com>
References: <1444974102-32379-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

We can't use hci_explicit_connect_lookup() since that would only cover
explicit connections, leaving normal reconnections completely
untouched. Not using it in turn means leaving out entries in
pend_le_reports.

To fix this and simplify the logic move conn params from the reports
list to the pend_le_conns list for the duration of an explicit
connect. Once the connect is complete move the params back to the
pend_le_reports list. This also means that the explicit connect lookup
function only needs to look into the pend_le_conns list.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/hci_conn.c  | 4 ++--
 net/bluetooth/hci_core.c  | 7 -------
 net/bluetooth/hci_event.c | 4 ++--
 net/bluetooth/mgmt.c      | 5 ++++-
 4 files changed, 8 insertions(+), 12 deletions(-)

diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
index 4c240c1cb2cb..d5c06eeab4a3 100644
--- a/net/bluetooth/hci_conn.c
+++ b/net/bluetooth/hci_conn.c
@@ -1000,8 +1000,8 @@ static int hci_explicit_conn_params_set(struct hci_request *req,
 	/* If we created new params, or existing params were marked as disabled,
 	 * mark them to be used just once to connect.
 	 */
-	if (params->auto_connect == HCI_AUTO_CONN_DISABLED) {
-		params->auto_connect = HCI_AUTO_CONN_EXPLICIT;
+	if (params->auto_connect == HCI_AUTO_CONN_DISABLED ||
+	    params->auto_connect == HCI_AUTO_CONN_REPORT) {
 		list_del_init(&params->action);
 		list_add(&params->action, &hdev->pend_le_conns);
 	}
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index adcbc74c2432..e837539452fb 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -2861,13 +2861,6 @@ struct hci_conn_params *hci_explicit_connect_lookup(struct hci_dev *hdev,
 			return param;
 	}
 
-	list_for_each_entry(param, &hdev->pend_le_reports, action) {
-		if (bacmp(&param->addr, addr) == 0 &&
-		    param->addr_type == addr_type &&
-		    param->explicit_connect)
-			return param;
-	}
-
 	return NULL;
 }
 
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 186041866315..51ab8352a31d 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -4648,8 +4648,8 @@ static struct hci_conn *check_pending_le_conn(struct hci_dev *hdev,
 	/* If we're not connectable only connect devices that we have in
 	 * our pend_le_conns list.
 	 */
-	params = hci_explicit_connect_lookup(hdev, addr, addr_type);
-
+	params = hci_pend_le_action_lookup(&hdev->pend_le_conns, addr,
+					   addr_type);
 	if (!params)
 		return NULL;
 
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index af29a3d1267a..e798d6511a59 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -6117,7 +6117,10 @@ static int hci_conn_params_set(struct hci_request *req, bdaddr_t *addr,
 		__hci_update_background_scan(req);
 		break;
 	case HCI_AUTO_CONN_REPORT:
-		list_add(&params->action, &hdev->pend_le_reports);
+		if (params->explicit_connect)
+			list_add(&params->action, &hdev->pend_le_conns);
+		else
+			list_add(&params->action, &hdev->pend_le_reports);
 		__hci_update_background_scan(req);
 		break;
 	case HCI_AUTO_CONN_DIRECT:
-- 
2.4.3

