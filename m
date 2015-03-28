Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/2] Bluetooth: Fix error returns for Read Local OOB Extended Data commands
Date: Sat, 28 Mar 2015 15:14:21 -0700
Message-Id: <1427580861-8052-2-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The Read Local OOB Extended Data commands are required to return the
address type and the data length at least. However currently the error
returns only the address type.

To fix this and avoid any extra allocations or stack memory, rearrange
the code so that the same path can be used for error returns.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 net/bluetooth/mgmt.c | 64 ++++++++++++++++++++++++++--------------------------
 1 file changed, 32 insertions(+), 32 deletions(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index a9a0036ff0a7..97b39218faea 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -6414,36 +6414,30 @@ static int read_local_oob_ext_data(struct sock *sk, struct hci_dev *hdev,
 
 	BT_DBG("%s", hdev->name);
 
-	if (!hdev_is_powered(hdev))
-		return mgmt_cmd_complete(sk, hdev->id,
-					 MGMT_OP_READ_LOCAL_OOB_EXT_DATA,
-					 MGMT_STATUS_NOT_POWERED,
-					 &cp->type, sizeof(cp->type));
-
-	switch (cp->type) {
-	case BIT(BDADDR_BREDR):
-		status = mgmt_bredr_support(hdev);
-		if (status)
-			return mgmt_cmd_complete(sk, hdev->id,
-						 MGMT_OP_READ_LOCAL_OOB_EXT_DATA,
-						 status, &cp->type,
-						 sizeof(cp->type));
-		eir_len = 5;
-		break;
-	case (BIT(BDADDR_LE_PUBLIC) | BIT(BDADDR_LE_RANDOM)):
-		status = mgmt_le_support(hdev);
-		if (status)
-			return mgmt_cmd_complete(sk, hdev->id,
-						 MGMT_OP_READ_LOCAL_OOB_EXT_DATA,
-						 status, &cp->type,
-						 sizeof(cp->type));
-		eir_len = 9 + 3 + 18 + 18 + 3;
-		break;
-	default:
-		return mgmt_cmd_complete(sk, hdev->id,
-					 MGMT_OP_READ_LOCAL_OOB_EXT_DATA,
-					 MGMT_STATUS_INVALID_PARAMS,
-					 &cp->type, sizeof(cp->type));
+	if (hdev_is_powered(hdev)) {
+		switch (cp->type) {
+		case BIT(BDADDR_BREDR):
+			status = mgmt_bredr_support(hdev);
+			if (status)
+				eir_len = 0;
+			else
+				eir_len = 5;
+			break;
+		case (BIT(BDADDR_LE_PUBLIC) | BIT(BDADDR_LE_RANDOM)):
+			status = mgmt_le_support(hdev);
+			if (status)
+				eir_len = 0;
+			else
+				eir_len = 9 + 3 + 18 + 18 + 3;
+			break;
+		default:
+			status = MGMT_STATUS_INVALID_PARAMS;
+			eir_len = 0;
+			break;
+		}
+	} else {
+		status = MGMT_STATUS_NOT_POWERED;
+		eir_len = 0;
 	}
 
 	rp_len = sizeof(*rp) + eir_len;
@@ -6451,6 +6445,9 @@ static int read_local_oob_ext_data(struct sock *sk, struct hci_dev *hdev,
 	if (!rp)
 		return -ENOMEM;
 
+	if (status)
+		goto complete;
+
 	hci_dev_lock(hdev);
 
 	eir_len = 0;
@@ -6519,12 +6516,15 @@ static int read_local_oob_ext_data(struct sock *sk, struct hci_dev *hdev,
 
 	hci_sock_set_flag(sk, HCI_MGMT_OOB_DATA_EVENTS);
 
+	status = MGMT_STATUS_SUCCESS;
+
+complete:
 	rp->type = cp->type;
 	rp->eir_len = cpu_to_le16(eir_len);
 
 	err = mgmt_cmd_complete(sk, hdev->id, MGMT_OP_READ_LOCAL_OOB_EXT_DATA,
-				MGMT_STATUS_SUCCESS, rp, sizeof(*rp) + eir_len);
-	if (err < 0)
+				status, rp, sizeof(*rp) + eir_len);
+	if (err < 0 || status)
 		goto done;
 
 	err = mgmt_limited_event(MGMT_EV_LOCAL_OOB_DATA_UPDATED, hdev,
-- 
2.1.0

