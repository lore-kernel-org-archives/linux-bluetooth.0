Return-Path: <cyrus@holtmann.org>
From: Johan Hedberg <johan.hedberg@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v5 25/26] Bluetooth: Simplify address parameters of user_pairing_resp()
Date: Fri, 15 Mar 2013 17:07:15 -0500
Message-Id: <1363385236-25704-26-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1363385236-25704-1-git-send-email-johan.hedberg@gmail.com>
References: <1363385236-25704-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

Instead of passing the bdaddr and bdaddr_type as separate parameters to
user_pairing_resp it's simpler to just pass the original mgmt_addr_info
struct which contains both values.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
Acked-by: Marcel Holtmann <marcel@holtmann.org>
---
 net/bluetooth/mgmt.c |   27 ++++++++++++++-------------
 1 file changed, 14 insertions(+), 13 deletions(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 75c9d92..8587229 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -2300,7 +2300,7 @@ unlock:
 }
 
 static int user_pairing_resp(struct sock *sk, struct hci_dev *hdev,
-			     bdaddr_t *bdaddr, u8 type, u16 mgmt_op,
+			     struct mgmt_addr_info *addr, u16 mgmt_op,
 			     u16 hci_op, __le32 passkey)
 {
 	struct pending_cmd *cmd;
@@ -2315,10 +2315,10 @@ static int user_pairing_resp(struct sock *sk, struct hci_dev *hdev,
 		goto done;
 	}
 
-	if (type == BDADDR_BREDR)
-		conn = hci_conn_hash_lookup_ba(hdev, ACL_LINK, bdaddr);
+	if (addr->type == BDADDR_BREDR)
+		conn = hci_conn_hash_lookup_ba(hdev, ACL_LINK, &addr->bdaddr);
 	else
-		conn = hci_conn_hash_lookup_ba(hdev, LE_LINK, bdaddr);
+		conn = hci_conn_hash_lookup_ba(hdev, LE_LINK, &addr->bdaddr);
 
 	if (!conn) {
 		err = cmd_status(sk, hdev->id, mgmt_op,
@@ -2326,7 +2326,7 @@ static int user_pairing_resp(struct sock *sk, struct hci_dev *hdev,
 		goto done;
 	}
 
-	if (type == BDADDR_LE_PUBLIC || type == BDADDR_LE_RANDOM) {
+	if (addr->type == BDADDR_LE_PUBLIC || addr->type == BDADDR_LE_RANDOM) {
 		/* Continue with pairing via SMP */
 		err = smp_user_confirm_reply(conn, mgmt_op, passkey);
 
@@ -2340,7 +2340,7 @@ static int user_pairing_resp(struct sock *sk, struct hci_dev *hdev,
 		goto done;
 	}
 
-	cmd = mgmt_pending_add(sk, mgmt_op, hdev, bdaddr, sizeof(*bdaddr));
+	cmd = mgmt_pending_add(sk, mgmt_op, hdev, addr, sizeof(*addr));
 	if (!cmd) {
 		err = -ENOMEM;
 		goto done;
@@ -2350,11 +2350,12 @@ static int user_pairing_resp(struct sock *sk, struct hci_dev *hdev,
 	if (hci_op == HCI_OP_USER_PASSKEY_REPLY) {
 		struct hci_cp_user_passkey_reply cp;
 
-		bacpy(&cp.bdaddr, bdaddr);
+		bacpy(&cp.bdaddr, &addr->bdaddr);
 		cp.passkey = passkey;
 		err = hci_send_cmd(hdev, hci_op, sizeof(cp), &cp);
 	} else
-		err = hci_send_cmd(hdev, hci_op, sizeof(*bdaddr), bdaddr);
+		err = hci_send_cmd(hdev, hci_op, sizeof(addr->bdaddr),
+				   &addr->bdaddr);
 
 	if (err < 0)
 		mgmt_pending_remove(cmd);
@@ -2371,7 +2372,7 @@ static int pin_code_neg_reply(struct sock *sk, struct hci_dev *hdev,
 
 	BT_DBG("");
 
-	return user_pairing_resp(sk, hdev, &cp->addr.bdaddr, cp->addr.type,
+	return user_pairing_resp(sk, hdev, &cp->addr,
 				MGMT_OP_PIN_CODE_NEG_REPLY,
 				HCI_OP_PIN_CODE_NEG_REPLY, 0);
 }
@@ -2387,7 +2388,7 @@ static int user_confirm_reply(struct sock *sk, struct hci_dev *hdev, void *data,
 		return cmd_status(sk, hdev->id, MGMT_OP_USER_CONFIRM_REPLY,
 				  MGMT_STATUS_INVALID_PARAMS);
 
-	return user_pairing_resp(sk, hdev, &cp->addr.bdaddr, cp->addr.type,
+	return user_pairing_resp(sk, hdev, &cp->addr,
 				 MGMT_OP_USER_CONFIRM_REPLY,
 				 HCI_OP_USER_CONFIRM_REPLY, 0);
 }
@@ -2399,7 +2400,7 @@ static int user_confirm_neg_reply(struct sock *sk, struct hci_dev *hdev,
 
 	BT_DBG("");
 
-	return user_pairing_resp(sk, hdev, &cp->addr.bdaddr, cp->addr.type,
+	return user_pairing_resp(sk, hdev, &cp->addr,
 				 MGMT_OP_USER_CONFIRM_NEG_REPLY,
 				 HCI_OP_USER_CONFIRM_NEG_REPLY, 0);
 }
@@ -2411,7 +2412,7 @@ static int user_passkey_reply(struct sock *sk, struct hci_dev *hdev, void *data,
 
 	BT_DBG("");
 
-	return user_pairing_resp(sk, hdev, &cp->addr.bdaddr, cp->addr.type,
+	return user_pairing_resp(sk, hdev, &cp->addr,
 				 MGMT_OP_USER_PASSKEY_REPLY,
 				 HCI_OP_USER_PASSKEY_REPLY, cp->passkey);
 }
@@ -2423,7 +2424,7 @@ static int user_passkey_neg_reply(struct sock *sk, struct hci_dev *hdev,
 
 	BT_DBG("");
 
-	return user_pairing_resp(sk, hdev, &cp->addr.bdaddr, cp->addr.type,
+	return user_pairing_resp(sk, hdev, &cp->addr,
 				 MGMT_OP_USER_PASSKEY_NEG_REPLY,
 				 HCI_OP_USER_PASSKEY_NEG_REPLY, 0);
 }
-- 
1.7.10.4

