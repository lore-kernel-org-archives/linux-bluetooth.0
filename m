Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 5/5] Bluetooth: Fix disconnecting connections in non-connected states
Date: Wed, 26 Feb 2014 23:33:47 +0200
Message-Id: <1393450427-12438-5-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1393450427-12438-1-git-send-email-johan.hedberg@gmail.com>
References: <1393450427-12438-1-git-send-email-johan.hedberg@gmail.com>
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

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/mgmt.c | 32 ++++++++++++++++++++++++++++----
 1 file changed, 28 insertions(+), 4 deletions(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index d6e269287cfc..d09e84fb7c3f 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -1061,10 +1061,34 @@ static int clean_up_hci_state(struct hci_dev *hdev)
 
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
-- 
1.8.5.3

