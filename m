Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/2] Bluetooth: Fix issue with ADV_IND reports and auto-connection handling
Date: Wed, 23 Jul 2014 21:55:23 +0200
Message-Id: <1406145323-42940-2-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

When adding remote devices to the kernel using the Add Device management
command, these devices are explicitly allowed to connect. This kind of
incoming connections are possible even when the controller itself is
not connectable.

For BR/EDR this distinction is pretty simple since there is only one
type of incoming connections. With LE this is not that simple anymore
since there are ADV_IND and ADV_DIRECT_IND advertising events.

The ADV_DIRECT_IND advertising events are send for incoming (slave
initiated) connections only. And this is the only thing the kernel
should allow when adding devices using action 0x01. This meaning
of incoming connections is coming from BR/EDR and needs to be
mapped to LE the same way.

Supporting the auto-connection of devices using ADV_IND advertising
events is an important feature as well. However it does not map to
incoming connections. So introduce a new action 0x02 that allows
the kernel to connect to devices using ADV_DIRECT_IND and in addition
ADV_IND advertising reports.

This difference is represented by the new HCI_AUTO_CONN_DIRECT value
for only connecting to ADV_DIRECT_IND. For connection to ADV_IND and
ADV_DIRECT_IND the old value HCI_AUTO_CONN_ALWAYS is used.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 include/net/bluetooth/hci_core.h |  1 +
 net/bluetooth/hci_core.c         |  1 +
 net/bluetooth/hci_event.c        | 27 ++++++++++++++++++++++++++-
 net/bluetooth/mgmt.c             |  9 ++++++---
 4 files changed, 34 insertions(+), 4 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 996ed065b6c2..747a0c3d9947 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -458,6 +458,7 @@ struct hci_conn_params {
 	enum {
 		HCI_AUTO_CONN_DISABLED,
 		HCI_AUTO_CONN_REPORT,
+		HCI_AUTO_CONN_DIRECT,
 		HCI_AUTO_CONN_ALWAYS,
 		HCI_AUTO_CONN_LINK_LOSS,
 	} auto_connect;
diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 078f1ecbc058..d8f91d5b0e56 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -3647,6 +3647,7 @@ int hci_conn_params_set(struct hci_dev *hdev, bdaddr_t *addr, u8 addr_type,
 		list_add(&params->action, &hdev->pend_le_reports);
 		hci_update_background_scan(hdev);
 		break;
+	case HCI_AUTO_CONN_DIRECT:
 	case HCI_AUTO_CONN_ALWAYS:
 		if (!is_connected(hdev, addr, addr_type)) {
 			list_add(&params->action, &hdev->pend_le_conns);
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 293dd98ae98f..ba26fbfe481a 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -2259,6 +2259,7 @@ static void hci_disconn_complete_evt(struct hci_dev *hdev, struct sk_buff *skb)
 				break;
 			/* Fall through */
 
+		case HCI_AUTO_CONN_DIRECT:
 		case HCI_AUTO_CONN_ALWAYS:
 			list_del_init(&params->action);
 			list_add(&params->action, &hdev->pend_le_conns);
@@ -4251,6 +4252,7 @@ static void check_pending_le_conn(struct hci_dev *hdev, bdaddr_t *addr,
 				  u8 addr_type, u8 adv_type)
 {
 	struct hci_conn *conn;
+	struct hci_conn_params *params;
 
 	/* If the event is not connectable don't proceed further */
 	if (adv_type != LE_ADV_IND && adv_type != LE_ADV_DIRECT_IND)
@@ -4269,8 +4271,31 @@ static void check_pending_le_conn(struct hci_dev *hdev, bdaddr_t *addr,
 	/* If we're not connectable only connect devices that we have in
 	 * our pend_le_conns list.
 	 */
-	if (!hci_pend_le_action_lookup(&hdev->pend_le_conns, addr, addr_type))
+	params = hci_pend_le_action_lookup(&hdev->pend_le_conns,
+					   addr, addr_type);
+	if (!params)
+		return;
+
+	switch (params->auto_connect) {
+	case HCI_AUTO_CONN_DIRECT:
+		/* Only devices advertising with ADV_DIRECT_IND are
+		 * triggering a connection attempt. This is allowing
+		 * incoming connections from slave devices.
+		 */
+		if (adv_type != LE_ADV_DIRECT_IND)
+			return;
+		break;
+	case HCI_AUTO_CONN_ALWAYS:
+		/* Devices advertising with ADV_IND or ADV_DIRECT_IND
+		 * are triggering a connection attempt. This means
+		 * that incoming connectioms from slave device are
+		 * accepted and also outgoing connections to slave
+		 * devices are established when found.
+		 */
+		break;
+	default:
 		return;
+	}
 
 	conn = hci_connect_le(hdev, addr, addr_type, BT_SECURITY_LOW,
 			      HCI_LE_AUTOCONN_TIMEOUT, HCI_ROLE_MASTER);
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 190668367e42..ccc4653ce658 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -5271,7 +5271,7 @@ static int add_device(struct sock *sk, struct hci_dev *hdev,
 				    MGMT_STATUS_INVALID_PARAMS,
 				    &cp->addr, sizeof(cp->addr));
 
-	if (cp->action != 0x00 && cp->action != 0x01)
+	if (cp->action != 0x00 && cp->action != 0x01 && cp->action != 0x02)
 		return cmd_complete(sk, hdev->id, MGMT_OP_ADD_DEVICE,
 				    MGMT_STATUS_INVALID_PARAMS,
 				    &cp->addr, sizeof(cp->addr));
@@ -5281,7 +5281,7 @@ static int add_device(struct sock *sk, struct hci_dev *hdev,
 	if (cp->addr.type == BDADDR_BREDR) {
 		bool update_scan;
 
-		/* Only "connect" action supported for now */
+		/* Only incoming connections action is supported for now */
 		if (cp->action != 0x01) {
 			err = cmd_complete(sk, hdev->id, MGMT_OP_ADD_DEVICE,
 					   MGMT_STATUS_INVALID_PARAMS,
@@ -5307,8 +5307,10 @@ static int add_device(struct sock *sk, struct hci_dev *hdev,
 	else
 		addr_type = ADDR_LE_DEV_RANDOM;
 
-	if (cp->action)
+	if (cp->action == 0x02)
 		auto_conn = HCI_AUTO_CONN_ALWAYS;
+	else if (cp->action == 0x01)
+		auto_conn = HCI_AUTO_CONN_DIRECT;
 	else
 		auto_conn = HCI_AUTO_CONN_REPORT;
 
@@ -5870,6 +5872,7 @@ static void restart_le_actions(struct hci_dev *hdev)
 		list_del_init(&p->action);
 
 		switch (p->auto_connect) {
+		case HCI_AUTO_CONN_DIRECT:
 		case HCI_AUTO_CONN_ALWAYS:
 			list_add(&p->action, &hdev->pend_le_conns);
 			break;
-- 
1.9.3

