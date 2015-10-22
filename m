Return-Path: <cyrus@holtmann.org>
From: Johan Hedberg <johan.hedberg@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/5] Bluetooth: Introduce hci_req helper to abort a connection
Date: Thu, 22 Oct 2015 09:38:32 +0300
Message-Id: <1445495915-21059-3-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1445495915-21059-1-git-send-email-johan.hedberg@gmail.com>
References: <1445495915-21059-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

There are several different places needing to make sure that a
connection gets disconnected or canceled. The exact action needed
depends on the connection state, so centralizing this logic can save
quite a lot of code duplication.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/hci_request.c | 93 +++++++++++++++++++++++++++++++++++++++++++++
 net/bluetooth/hci_request.h |  4 ++
 2 files changed, 97 insertions(+)

diff --git a/net/bluetooth/hci_request.c b/net/bluetooth/hci_request.c
index b7369220c9ef..5821280a14f5 100644
--- a/net/bluetooth/hci_request.c
+++ b/net/bluetooth/hci_request.c
@@ -564,3 +564,96 @@ void hci_update_background_scan(struct hci_dev *hdev)
 	if (err && err != -ENODATA)
 		BT_ERR("Failed to run HCI request: err %d", err);
 }
+
+void __hci_abort_conn(struct hci_request *req, struct hci_conn *conn,
+		      u8 reason)
+{
+	switch (conn->state) {
+	case BT_CONNECTED:
+	case BT_CONFIG:
+		if (conn->type == AMP_LINK) {
+			struct hci_cp_disconn_phy_link cp;
+
+			cp.phy_handle = HCI_PHY_HANDLE(conn->handle);
+			cp.reason = hci_proto_disconn_ind(conn);
+			hci_req_add(req, HCI_OP_DISCONN_PHY_LINK, sizeof(cp),
+				    &cp);
+		} else {
+			struct hci_cp_disconnect dc;
+
+			dc.handle = cpu_to_le16(conn->handle);
+			dc.reason = reason;
+			hci_req_add(req, HCI_OP_DISCONNECT, sizeof(dc), &dc);
+		}
+
+		conn->state = BT_DISCONN;
+
+		break;
+	case BT_CONNECT:
+		if (test_bit(HCI_CONN_SCANNING, &conn->flags))
+			break;
+		if (conn->type == LE_LINK)
+			hci_req_add(req, HCI_OP_LE_CREATE_CONN_CANCEL,
+				    0, NULL);
+		else if (conn->type == ACL_LINK)
+			hci_req_add(req, HCI_OP_CREATE_CONN_CANCEL,
+				    6, &conn->dst);
+		break;
+	case BT_CONNECT2:
+		if (conn->type == ACL_LINK) {
+			struct hci_cp_reject_conn_req rej;
+
+			if (req->hdev->hci_ver < BLUETOOTH_VER_1_2)
+				return;
+
+			bacpy(&rej.bdaddr, &conn->dst);
+			rej.reason = reason;
+
+			hci_req_add(req, HCI_OP_REJECT_CONN_REQ,
+				    sizeof(rej), &rej);
+		} else if (conn->type == SCO_LINK || conn->type == ESCO_LINK) {
+			struct hci_cp_reject_sync_conn_req rej;
+
+			bacpy(&rej.bdaddr, &conn->dst);
+
+			/* SCO rejection has its own limited set of
+			 * allowed error values (0x0D-0x0F) which isn't
+			 * compatible with most values passed to this
+			 * function. To be safe hard-code one of the
+			 * values that's suitable for SCO.
+			 */
+			rej.reason = HCI_ERROR_REMOTE_LOW_RESOURCES;
+
+			hci_req_add(req, HCI_OP_REJECT_SYNC_CONN_REQ,
+				    sizeof(rej), &rej);
+		}
+		break;
+	default:
+		conn->state = BT_CLOSED;
+		break;
+	}
+}
+
+static void abort_conn_complete(struct hci_dev *hdev, u8 status, u16 opcode)
+{
+	if (status)
+		BT_DBG("Failed to abort connection: status 0x%2.2x", status);
+}
+
+int hci_abort_conn(struct hci_conn *conn, u8 reason)
+{
+	struct hci_request req;
+	int err;
+
+	hci_req_init(&req, conn->hdev);
+
+	__hci_abort_conn(&req, conn, reason);
+
+	err = hci_req_run(&req, abort_conn_complete);
+	if (err && err != -ENODATA) {
+		BT_ERR("Failed to run HCI request: err %d", err);
+		return err;
+	}
+
+	return 0;
+}
diff --git a/net/bluetooth/hci_request.h b/net/bluetooth/hci_request.h
index bf6df92f42db..25c7f1305dcb 100644
--- a/net/bluetooth/hci_request.h
+++ b/net/bluetooth/hci_request.h
@@ -55,3 +55,7 @@ int hci_update_random_address(struct hci_request *req, bool require_privacy,
 
 void hci_update_background_scan(struct hci_dev *hdev);
 void __hci_update_background_scan(struct hci_request *req);
+
+int hci_abort_conn(struct hci_conn *conn, u8 reason);
+void __hci_abort_conn(struct hci_request *req, struct hci_conn *conn,
+		      u8 reason);
-- 
2.5.0

