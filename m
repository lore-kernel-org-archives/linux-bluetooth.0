Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 2/2] Bluetooth: Fix disconnecting connections in non-connected states
Date: Thu, 27 Feb 2014 14:35:12 +0200
Message-Id: <1393504512-21877-2-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1393504512-21877-1-git-send-email-johan.hedberg@gmail.com>
References: <1393504512-21877-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

When powering off and disconnecting devices we should also consider
connections which have not yet reached the BT_CONNECTED state. They may
not have a valid handle yet and simply sending a HCI_Disconnect will not
work.

This patch updates the code to either disconnect, cancel connection
creation or reject incoming connection creation based on the current
conn->state value as well as the link type in question.

When the power off procedure results in canceling connection attempts
instead of disconnecting connections we get a connection failed event
instead of a disconnection event. Therefore, we also need to have extra
code in the mgmt_connect_failed function to check if we should proceed
with the power off or not.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/mgmt.c | 44 ++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 40 insertions(+), 4 deletions(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 4c4912e9a7c4..1e9747b60657 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -1057,10 +1057,34 @@ static int clean_up_hci_state(struct hci_dev *hdev)
 
 	list_for_each_entry(conn, &hdev->conn_hash.list, list) {
 		struct hci_cp_disconnect dc;
-
-		dc.handle = cpu_to_le16(conn->handle);
-		dc.reason = 0x15; /* Terminated due to Power Off */
-		hci_req_add(&req, HCI_OP_DISCONNECT, sizeof(dc), &dc);
+		struct hci_cp_reject_conn_req rej;
+
+		switch (conn->state) {
+		case BT_CONNECTED:
+		case BT_CONFIG:
+			dc.handle = cpu_to_le16(conn->handle);
+			dc.reason = 0x15; /* Terminated due to Power Off */
+			hci_req_add(&req, HCI_OP_DISCONNECT, sizeof(dc), &dc);
+			break;
+		case BT_CONNECT:
+			if (conn->type == LE_LINK)
+				hci_req_add(&req, HCI_OP_LE_CREATE_CONN_CANCEL,
+					    0, NULL);
+			else if (conn->type == ACL_LINK)
+				hci_req_add(&req, HCI_OP_CREATE_CONN_CANCEL,
+					    6, &conn->dst);
+			break;
+		case BT_CONNECT2:
+			bacpy(&rej.bdaddr, &conn->dst);
+			rej.reason = 0x15; /* Terminated due to Power Off */
+			if (conn->type == ACL_LINK)
+				hci_req_add(&req, HCI_OP_REJECT_CONN_REQ,
+					    sizeof(rej), &rej);
+			else if (conn->type == SCO_LINK)
+				hci_req_add(&req, HCI_OP_REJECT_SYNC_CONN_REQ,
+					    sizeof(rej), &rej);
+			break;
+		}
 	}
 
 	return hci_req_run(&req, clean_up_hci_complete);
@@ -5182,6 +5206,18 @@ void mgmt_connect_failed(struct hci_dev *hdev, bdaddr_t *bdaddr, u8 link_type,
 			 u8 addr_type, u8 status)
 {
 	struct mgmt_ev_connect_failed ev;
+	struct pending_cmd *power_off;
+
+	power_off = mgmt_pending_find(MGMT_OP_SET_POWERED, hdev);
+	if (power_off) {
+		struct mgmt_mode *cp = power_off->param;
+
+		/* The connection is still in hci_conn_hash so test for 1
+		 * instead of 0 to know if this is the last one.
+		 */
+		if (!cp->val && hci_conn_count(hdev) == 1)
+			queue_work(hdev->req_workqueue, &hdev->power_off.work);
+	}
 
 	bacpy(&ev.addr.bdaddr, bdaddr);
 	ev.addr.type = link_to_bdaddr(link_type, addr_type);
-- 
1.8.5.3

