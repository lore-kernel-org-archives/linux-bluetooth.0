Return-Path: <cyrus@holtmann.org>
From: Johan Hedberg <johan.hedberg@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 07/10] Bluetooth: Fix checking for valid address type values in mgmt commands
Date: Fri, 18 Jan 2013 15:25:55 +0200
Message-Id: <1358515558-17861-8-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1358515558-17861-1-git-send-email-johan.hedberg@gmail.com>
References: <1358515558-17861-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

This patch adds checks for valid address type values passed to mgmt
commands. If an invalid address type is encountered the code will return
a proper invalid params response.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/mgmt.c |   43 ++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 38 insertions(+), 5 deletions(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 76301a3..3de4bc2 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -1506,7 +1506,7 @@ static int load_link_keys(struct sock *sk, struct hci_dev *hdev, void *data,
 {
 	struct mgmt_cp_load_link_keys *cp = data;
 	u16 key_count, expected_len;
-	int i;
+	int i, err;
 
 	key_count = __le16_to_cpu(cp->key_count);
 
@@ -1540,15 +1540,24 @@ static int load_link_keys(struct sock *sk, struct hci_dev *hdev, void *data,
 	for (i = 0; i < key_count; i++) {
 		struct mgmt_link_key_info *key = &cp->keys[i];
 
+		if (key->addr.type != BDADDR_BREDR) {
+			clear_bit(HCI_DEBUG_KEYS, &hdev->dev_flags);
+			hci_link_keys_clear(hdev);
+			err = cmd_status(sk, hdev->id, MGMT_OP_LOAD_LINK_KEYS,
+					 MGMT_STATUS_INVALID_PARAMS);
+			goto unlock;
+		}
+
 		hci_add_link_key(hdev, NULL, 0, &key->addr.bdaddr, key->val,
 				 key->type, key->pin_len);
 	}
 
-	cmd_complete(sk, hdev->id, MGMT_OP_LOAD_LINK_KEYS, 0, NULL, 0);
+	err = cmd_complete(sk, hdev->id, MGMT_OP_LOAD_LINK_KEYS, 0, NULL, 0);
 
+unlock:
 	hci_dev_unlock(hdev);
 
-	return 0;
+	return err;
 }
 
 static int device_unpaired(struct hci_dev *hdev, bdaddr_t *bdaddr,
@@ -1573,12 +1582,17 @@ static int unpair_device(struct sock *sk, struct hci_dev *hdev, void *data,
 	struct hci_conn *conn;
 	int err;
 
-	hci_dev_lock(hdev);
-
 	memset(&rp, 0, sizeof(rp));
 	bacpy(&rp.addr.bdaddr, &cp->addr.bdaddr);
 	rp.addr.type = cp->addr.type;
 
+	if (!bdaddr_type_is_valid(cp->addr.type))
+		return cmd_complete(sk, hdev->id, MGMT_OP_UNPAIR_DEVICE,
+				    MGMT_STATUS_INVALID_PARAMS,
+				    &rp, sizeof(rp));
+
+	hci_dev_lock(hdev);
+
 	if (!hdev_is_powered(hdev)) {
 		err = cmd_complete(sk, hdev->id, MGMT_OP_UNPAIR_DEVICE,
 				   MGMT_STATUS_NOT_POWERED, &rp, sizeof(rp));
@@ -1643,6 +1657,10 @@ static int disconnect(struct sock *sk, struct hci_dev *hdev, void *data,
 
 	BT_DBG("");
 
+	if (!bdaddr_type_is_valid(cp->addr.type))
+		return cmd_status(sk, hdev->id, MGMT_OP_DISCONNECT,
+				  MGMT_STATUS_INVALID_PARAMS);
+
 	hci_dev_lock(hdev);
 
 	if (!test_bit(HCI_UP, &hdev->flags)) {
@@ -1947,6 +1965,11 @@ static int pair_device(struct sock *sk, struct hci_dev *hdev, void *data,
 	bacpy(&rp.addr.bdaddr, &cp->addr.bdaddr);
 	rp.addr.type = cp->addr.type;
 
+	if (!bdaddr_type_is_valid(cp->addr.type))
+		return cmd_complete(sk, hdev->id, MGMT_OP_PAIR_DEVICE,
+				    MGMT_STATUS_INVALID_PARAMS,
+				    &rp, sizeof(rp));
+
 	hci_dev_lock(hdev);
 
 	if (!hdev_is_powered(hdev)) {
@@ -2564,6 +2587,10 @@ static int block_device(struct sock *sk, struct hci_dev *hdev, void *data,
 
 	BT_DBG("%s", hdev->name);
 
+	if (!bdaddr_type_is_valid(cp->addr.type))
+		return cmd_status(sk, hdev->id, MGMT_OP_BLOCK_DEVICE,
+				  MGMT_STATUS_INVALID_PARAMS);
+
 	hci_dev_lock(hdev);
 
 	err = hci_blacklist_add(hdev, &cp->addr.bdaddr, cp->addr.type);
@@ -2589,6 +2616,10 @@ static int unblock_device(struct sock *sk, struct hci_dev *hdev, void *data,
 
 	BT_DBG("%s", hdev->name);
 
+	if (!bdaddr_type_is_valid(cp->addr.type))
+		return cmd_status(sk, hdev->id, MGMT_OP_UNBLOCK_DEVICE,
+				  MGMT_STATUS_INVALID_PARAMS);
+
 	hci_dev_lock(hdev);
 
 	err = hci_blacklist_del(hdev, &cp->addr.bdaddr, cp->addr.type);
@@ -2707,6 +2738,8 @@ static bool ltk_is_valid(struct mgmt_ltk_info *key)
 		return false;
 	if (key->master != 0x00 && key->master != 0x01)
 		return false;
+	if (!bdaddr_type_is_le(key->addr.type))
+		return false;
 	return true;
 }
 
-- 
1.7.10.4

