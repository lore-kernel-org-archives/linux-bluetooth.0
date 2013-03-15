Return-Path: <cyrus@holtmann.org>
From: Johan Hedberg <johan.hedberg@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v5 26/26] Bluetooth: Fix PIN/Confirm/Passkey response parameters
Date: Fri, 15 Mar 2013 17:07:16 -0500
Message-Id: <1363385236-25704-27-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1363385236-25704-1-git-send-email-johan.hedberg@gmail.com>
References: <1363385236-25704-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

The only valid mgmt response to these pairing related commands is a
mgmt_cmd_complete and the returned parameters should contain the address
and address type of the remote device.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
Acked-by: Marcel Holtmann <marcel@holtmann.org>
---
 net/bluetooth/mgmt.c |   20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 8587229..03e7e73 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -2310,8 +2310,9 @@ static int user_pairing_resp(struct sock *sk, struct hci_dev *hdev,
 	hci_dev_lock(hdev);
 
 	if (!hdev_is_powered(hdev)) {
-		err = cmd_status(sk, hdev->id, mgmt_op,
-				 MGMT_STATUS_NOT_POWERED);
+		err = cmd_complete(sk, hdev->id, mgmt_op,
+				   MGMT_STATUS_NOT_POWERED, addr,
+				   sizeof(*addr));
 		goto done;
 	}
 
@@ -2321,8 +2322,9 @@ static int user_pairing_resp(struct sock *sk, struct hci_dev *hdev,
 		conn = hci_conn_hash_lookup_ba(hdev, LE_LINK, &addr->bdaddr);
 
 	if (!conn) {
-		err = cmd_status(sk, hdev->id, mgmt_op,
-				 MGMT_STATUS_NOT_CONNECTED);
+		err = cmd_complete(sk, hdev->id, mgmt_op,
+				   MGMT_STATUS_NOT_CONNECTED, addr,
+				   sizeof(*addr));
 		goto done;
 	}
 
@@ -2331,11 +2333,13 @@ static int user_pairing_resp(struct sock *sk, struct hci_dev *hdev,
 		err = smp_user_confirm_reply(conn, mgmt_op, passkey);
 
 		if (!err)
-			err = cmd_status(sk, hdev->id, mgmt_op,
-					 MGMT_STATUS_SUCCESS);
+			err = cmd_complete(sk, hdev->id, mgmt_op,
+					   MGMT_STATUS_SUCCESS, addr,
+					   sizeof(*addr));
 		else
-			err = cmd_status(sk, hdev->id, mgmt_op,
-					 MGMT_STATUS_FAILED);
+			err = cmd_complete(sk, hdev->id, mgmt_op,
+					   MGMT_STATUS_FAILED, addr,
+					   sizeof(*addr));
 
 		goto done;
 	}
-- 
1.7.10.4

