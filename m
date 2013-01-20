Return-Path: <cyrus@holtmann.org>
From: Johan Hedberg <johan.hedberg@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 09/10 v2] Bluetooth: Fix returning proper cmd_complete for mgmt_disconnect
Date: Sun, 20 Jan 2013 14:27:21 +0200
Message-Id: <1358684842-4441-10-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1358684842-4441-1-git-send-email-johan.hedberg@gmail.com>
References: <1358684842-4441-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

The Disconnect Management command should return Command Complete instead
of Command Status whenever possible so that user space can distinguish
exactly which command failed in the case of multiple commands. This
patch does the necessary changes in the disconnect command handler to
return the right event to user space.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/mgmt.c |   22 ++++++++++++++--------
 1 file changed, 14 insertions(+), 8 deletions(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index e5e865d..7b8bc7c 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -1654,6 +1654,7 @@ static int disconnect(struct sock *sk, struct hci_dev *hdev, void *data,
 		      u16 len)
 {
 	struct mgmt_cp_disconnect *cp = data;
+	struct mgmt_rp_disconnect rp;
 	struct hci_cp_disconnect dc;
 	struct pending_cmd *cmd;
 	struct hci_conn *conn;
@@ -1661,21 +1662,26 @@ static int disconnect(struct sock *sk, struct hci_dev *hdev, void *data,
 
 	BT_DBG("");
 
+	memset(&rp, 0, sizeof(rp));
+	bacpy(&rp.addr.bdaddr, &cp->addr.bdaddr);
+	rp.addr.type = cp->addr.type;
+
 	if (!bdaddr_type_is_valid(cp->addr.type))
-		return cmd_status(sk, hdev->id, MGMT_OP_DISCONNECT,
-				  MGMT_STATUS_INVALID_PARAMS);
+		return cmd_complete(sk, hdev->id, MGMT_OP_DISCONNECT,
+				    MGMT_STATUS_INVALID_PARAMS,
+				    &rp, sizeof(rp));
 
 	hci_dev_lock(hdev);
 
 	if (!test_bit(HCI_UP, &hdev->flags)) {
-		err = cmd_status(sk, hdev->id, MGMT_OP_DISCONNECT,
-				 MGMT_STATUS_NOT_POWERED);
+		err = cmd_complete(sk, hdev->id, MGMT_OP_DISCONNECT,
+				   MGMT_STATUS_NOT_POWERED, &rp, sizeof(rp));
 		goto failed;
 	}
 
 	if (mgmt_pending_find(MGMT_OP_DISCONNECT, hdev)) {
-		err = cmd_status(sk, hdev->id, MGMT_OP_DISCONNECT,
-				 MGMT_STATUS_BUSY);
+		err = cmd_complete(sk, hdev->id, MGMT_OP_DISCONNECT,
+				   MGMT_STATUS_BUSY, &rp, sizeof(rp));
 		goto failed;
 	}
 
@@ -1686,8 +1692,8 @@ static int disconnect(struct sock *sk, struct hci_dev *hdev, void *data,
 		conn = hci_conn_hash_lookup_ba(hdev, LE_LINK, &cp->addr.bdaddr);
 
 	if (!conn || conn->state == BT_OPEN || conn->state == BT_CLOSED) {
-		err = cmd_status(sk, hdev->id, MGMT_OP_DISCONNECT,
-				 MGMT_STATUS_NOT_CONNECTED);
+		err = cmd_complete(sk, hdev->id, MGMT_OP_DISCONNECT,
+				   MGMT_STATUS_NOT_CONNECTED, &rp, sizeof(rp));
 		goto failed;
 	}
 
-- 
1.7.10.4

