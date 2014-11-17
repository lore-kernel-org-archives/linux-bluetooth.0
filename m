Return-Path: <cyrus@holtmann.org>
From: Johan Hedberg <johan.hedberg@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Fix BR/EDR-only address checks for remote OOB data
Date: Mon, 17 Nov 2014 18:49:25 +0200
Message-Id: <1416242965-29207-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

For now the mgmt commands dealing with remote OOB data are strictly
BR/EDR-only. This patch fixes missing checks for the passed address type
so that any non-BR/EDR value triggers the appropriate error response.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/mgmt.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index b84c0923ec62..aaaa605f48b0 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -3589,6 +3589,13 @@ static int add_remote_oob_data(struct sock *sk, struct hci_dev *hdev,
 		struct mgmt_cp_add_remote_oob_data *cp = data;
 		u8 status;
 
+		if (cp->addr.type != BDADDR_BREDR) {
+			err = cmd_status(sk, hdev->id,
+					 MGMT_OP_ADD_REMOTE_OOB_DATA,
+					 MGMT_STATUS_INVALID_PARAMS);
+			goto unlock;
+		}
+
 		err = hci_add_remote_oob_data(hdev, &cp->addr.bdaddr,
 					      cp->hash, cp->randomizer);
 		if (err < 0)
@@ -3602,6 +3609,13 @@ static int add_remote_oob_data(struct sock *sk, struct hci_dev *hdev,
 		struct mgmt_cp_add_remote_oob_ext_data *cp = data;
 		u8 status;
 
+		if (cp->addr.type != BDADDR_BREDR) {
+			err = cmd_status(sk, hdev->id,
+					 MGMT_OP_ADD_REMOTE_OOB_DATA,
+					 MGMT_STATUS_INVALID_PARAMS);
+			goto unlock;
+		}
+
 		err = hci_add_remote_oob_ext_data(hdev, &cp->addr.bdaddr,
 						  cp->hash192,
 						  cp->randomizer192,
@@ -3620,6 +3634,7 @@ static int add_remote_oob_data(struct sock *sk, struct hci_dev *hdev,
 				 MGMT_STATUS_INVALID_PARAMS);
 	}
 
+unlock:
 	hci_dev_unlock(hdev);
 	return err;
 }
@@ -3633,6 +3648,10 @@ static int remove_remote_oob_data(struct sock *sk, struct hci_dev *hdev,
 
 	BT_DBG("%s", hdev->name);
 
+	if (cp->addr.type != BDADDR_BREDR)
+		return cmd_status(sk, hdev->id, MGMT_OP_REMOVE_REMOTE_OOB_DATA,
+				  MGMT_STATUS_INVALID_PARAMS);
+
 	hci_dev_lock(hdev);
 
 	if (!bacmp(&cp->addr.bdaddr, BDADDR_ANY)) {
-- 
2.1.0

