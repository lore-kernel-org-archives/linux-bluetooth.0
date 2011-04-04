Return-Path: <cyrus@holtmann.org>
From: "Gustavo F. Padovan" <padovan@profusion.mobi>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/2] Bluetooth: Don't use spin_lock_bh in user context
Date: Mon,  4 Apr 2011 19:08:03 -0300
Message-Id: <1301954883-13326-2-git-send-email-padovan@profusion.mobi>
In-Reply-To: <1301954883-13326-1-git-send-email-padovan@profusion.mobi>
References: <1301954883-13326-1-git-send-email-padovan@profusion.mobi>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

spin_lock() and spin_unlock() are more apropiated for user context.

Signed-off-by: Gustavo F. Padovan <padovan@profusion.mobi>
---
 net/bluetooth/mgmt.c |   88 +++++++++++++++++++++++++-------------------------
 1 files changed, 44 insertions(+), 44 deletions(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index bab8b58..d39abe9 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -179,7 +179,7 @@ static int read_controller_info(struct sock *sk, u16 index)
 
 	hci_del_off_timer(hdev);
 
-	hci_dev_lock_bh(hdev);
+	hci_dev_lock(hdev);
 
 	set_bit(HCI_MGMT, &hdev->flags);
 
@@ -208,7 +208,7 @@ static int read_controller_info(struct sock *sk, u16 index)
 
 	memcpy(rp.name, hdev->dev_name, sizeof(hdev->dev_name));
 
-	hci_dev_unlock_bh(hdev);
+	hci_dev_unlock(hdev);
 	hci_dev_put(hdev);
 
 	return cmd_complete(sk, index, MGMT_OP_READ_INFO, &rp, sizeof(rp));
@@ -316,7 +316,7 @@ static int set_powered(struct sock *sk, u16 index, unsigned char *data, u16 len)
 	if (!hdev)
 		return cmd_status(sk, index, MGMT_OP_SET_POWERED, ENODEV);
 
-	hci_dev_lock_bh(hdev);
+	hci_dev_lock(hdev);
 
 	up = test_bit(HCI_UP, &hdev->flags);
 	if ((cp->val && up) || (!cp->val && !up)) {
@@ -343,7 +343,7 @@ static int set_powered(struct sock *sk, u16 index, unsigned char *data, u16 len)
 	err = 0;
 
 failed:
-	hci_dev_unlock_bh(hdev);
+	hci_dev_unlock(hdev);
 	hci_dev_put(hdev);
 	return err;
 }
@@ -368,7 +368,7 @@ static int set_discoverable(struct sock *sk, u16 index, unsigned char *data,
 	if (!hdev)
 		return cmd_status(sk, index, MGMT_OP_SET_DISCOVERABLE, ENODEV);
 
-	hci_dev_lock_bh(hdev);
+	hci_dev_lock(hdev);
 
 	if (!test_bit(HCI_UP, &hdev->flags)) {
 		err = cmd_status(sk, index, MGMT_OP_SET_DISCOVERABLE, ENETDOWN);
@@ -403,7 +403,7 @@ static int set_discoverable(struct sock *sk, u16 index, unsigned char *data,
 		mgmt_pending_remove(cmd);
 
 failed:
-	hci_dev_unlock_bh(hdev);
+	hci_dev_unlock(hdev);
 	hci_dev_put(hdev);
 
 	return err;
@@ -429,7 +429,7 @@ static int set_connectable(struct sock *sk, u16 index, unsigned char *data,
 	if (!hdev)
 		return cmd_status(sk, index, MGMT_OP_SET_CONNECTABLE, ENODEV);
 
-	hci_dev_lock_bh(hdev);
+	hci_dev_lock(hdev);
 
 	if (!test_bit(HCI_UP, &hdev->flags)) {
 		err = cmd_status(sk, index, MGMT_OP_SET_CONNECTABLE, ENETDOWN);
@@ -463,7 +463,7 @@ static int set_connectable(struct sock *sk, u16 index, unsigned char *data,
 		mgmt_pending_remove(cmd);
 
 failed:
-	hci_dev_unlock_bh(hdev);
+	hci_dev_unlock(hdev);
 	hci_dev_put(hdev);
 
 	return err;
@@ -522,7 +522,7 @@ static int set_pairable(struct sock *sk, u16 index, unsigned char *data,
 	if (!hdev)
 		return cmd_status(sk, index, MGMT_OP_SET_PAIRABLE, ENODEV);
 
-	hci_dev_lock_bh(hdev);
+	hci_dev_lock(hdev);
 
 	if (cp->val)
 		set_bit(HCI_PAIRABLE, &hdev->flags);
@@ -538,7 +538,7 @@ static int set_pairable(struct sock *sk, u16 index, unsigned char *data,
 	err = mgmt_event(MGMT_EV_PAIRABLE, index, &ev, sizeof(ev), sk);
 
 failed:
-	hci_dev_unlock_bh(hdev);
+	hci_dev_unlock(hdev);
 	hci_dev_put(hdev);
 
 	return err;
@@ -739,7 +739,7 @@ static int add_uuid(struct sock *sk, u16 index, unsigned char *data, u16 len)
 	if (!hdev)
 		return cmd_status(sk, index, MGMT_OP_ADD_UUID, ENODEV);
 
-	hci_dev_lock_bh(hdev);
+	hci_dev_lock(hdev);
 
 	uuid = kmalloc(sizeof(*uuid), GFP_KERNEL);
 	if (!uuid) {
@@ -763,7 +763,7 @@ static int add_uuid(struct sock *sk, u16 index, unsigned char *data, u16 len)
 	err = cmd_complete(sk, index, MGMT_OP_ADD_UUID, NULL, 0);
 
 failed:
-	hci_dev_unlock_bh(hdev);
+	hci_dev_unlock(hdev);
 	hci_dev_put(hdev);
 
 	return err;
@@ -788,7 +788,7 @@ static int remove_uuid(struct sock *sk, u16 index, unsigned char *data, u16 len)
 	if (!hdev)
 		return cmd_status(sk, index, MGMT_OP_REMOVE_UUID, ENODEV);
 
-	hci_dev_lock_bh(hdev);
+	hci_dev_lock(hdev);
 
 	if (memcmp(cp->uuid, bt_uuid_any, 16) == 0) {
 		err = hci_uuids_clear(hdev);
@@ -823,7 +823,7 @@ static int remove_uuid(struct sock *sk, u16 index, unsigned char *data, u16 len)
 	err = cmd_complete(sk, index, MGMT_OP_REMOVE_UUID, NULL, 0);
 
 unlock:
-	hci_dev_unlock_bh(hdev);
+	hci_dev_unlock(hdev);
 	hci_dev_put(hdev);
 
 	return err;
@@ -847,7 +847,7 @@ static int set_dev_class(struct sock *sk, u16 index, unsigned char *data,
 	if (!hdev)
 		return cmd_status(sk, index, MGMT_OP_SET_DEV_CLASS, ENODEV);
 
-	hci_dev_lock_bh(hdev);
+	hci_dev_lock(hdev);
 
 	hdev->major_class = cp->major;
 	hdev->minor_class = cp->minor;
@@ -857,7 +857,7 @@ static int set_dev_class(struct sock *sk, u16 index, unsigned char *data,
 	if (err == 0)
 		err = cmd_complete(sk, index, MGMT_OP_SET_DEV_CLASS, NULL, 0);
 
-	hci_dev_unlock_bh(hdev);
+	hci_dev_unlock(hdev);
 	hci_dev_put(hdev);
 
 	return err;
@@ -879,7 +879,7 @@ static int set_service_cache(struct sock *sk, u16 index,  unsigned char *data,
 	if (!hdev)
 		return cmd_status(sk, index, MGMT_OP_SET_SERVICE_CACHE, ENODEV);
 
-	hci_dev_lock_bh(hdev);
+	hci_dev_lock(hdev);
 
 	BT_DBG("hci%u enable %d", index, cp->enable);
 
@@ -897,7 +897,7 @@ static int set_service_cache(struct sock *sk, u16 index,  unsigned char *data,
 		err = cmd_complete(sk, index, MGMT_OP_SET_SERVICE_CACHE, NULL,
 									0);
 
-	hci_dev_unlock_bh(hdev);
+	hci_dev_unlock(hdev);
 	hci_dev_put(hdev);
 
 	return err;
@@ -931,7 +931,7 @@ static int load_keys(struct sock *sk, u16 index, unsigned char *data, u16 len)
 	BT_DBG("hci%u debug_keys %u key_count %u", index, cp->debug_keys,
 								key_count);
 
-	hci_dev_lock_bh(hdev);
+	hci_dev_lock(hdev);
 
 	hci_link_keys_clear(hdev);
 
@@ -949,7 +949,7 @@ static int load_keys(struct sock *sk, u16 index, unsigned char *data, u16 len)
 								key->pin_len);
 	}
 
-	hci_dev_unlock_bh(hdev);
+	hci_dev_unlock(hdev);
 	hci_dev_put(hdev);
 
 	return 0;
@@ -971,7 +971,7 @@ static int remove_key(struct sock *sk, u16 index, unsigned char *data, u16 len)
 	if (!hdev)
 		return cmd_status(sk, index, MGMT_OP_REMOVE_KEY, ENODEV);
 
-	hci_dev_lock_bh(hdev);
+	hci_dev_lock(hdev);
 
 	err = hci_remove_link_key(hdev, &cp->bdaddr);
 	if (err < 0) {
@@ -994,7 +994,7 @@ static int remove_key(struct sock *sk, u16 index, unsigned char *data, u16 len)
 	}
 
 unlock:
-	hci_dev_unlock_bh(hdev);
+	hci_dev_unlock(hdev);
 	hci_dev_put(hdev);
 
 	return err;
@@ -1020,7 +1020,7 @@ static int disconnect(struct sock *sk, u16 index, unsigned char *data, u16 len)
 	if (!hdev)
 		return cmd_status(sk, index, MGMT_OP_DISCONNECT, ENODEV);
 
-	hci_dev_lock_bh(hdev);
+	hci_dev_lock(hdev);
 
 	if (!test_bit(HCI_UP, &hdev->flags)) {
 		err = cmd_status(sk, index, MGMT_OP_DISCONNECT, ENETDOWN);
@@ -1052,7 +1052,7 @@ static int disconnect(struct sock *sk, u16 index, unsigned char *data, u16 len)
 		mgmt_pending_remove(cmd);
 
 failed:
-	hci_dev_unlock_bh(hdev);
+	hci_dev_unlock(hdev);
 	hci_dev_put(hdev);
 
 	return err;
@@ -1073,7 +1073,7 @@ static int get_connections(struct sock *sk, u16 index)
 	if (!hdev)
 		return cmd_status(sk, index, MGMT_OP_GET_CONNECTIONS, ENODEV);
 
-	hci_dev_lock_bh(hdev);
+	hci_dev_lock(hdev);
 
 	count = 0;
 	list_for_each(p, &hdev->conn_hash.list) {
@@ -1104,7 +1104,7 @@ static int get_connections(struct sock *sk, u16 index)
 
 unlock:
 	kfree(rp);
-	hci_dev_unlock_bh(hdev);
+	hci_dev_unlock(hdev);
 	hci_dev_put(hdev);
 	return err;
 }
@@ -1129,7 +1129,7 @@ static int pin_code_reply(struct sock *sk, u16 index, unsigned char *data,
 	if (!hdev)
 		return cmd_status(sk, index, MGMT_OP_PIN_CODE_REPLY, ENODEV);
 
-	hci_dev_lock_bh(hdev);
+	hci_dev_lock(hdev);
 
 	if (!test_bit(HCI_UP, &hdev->flags)) {
 		err = cmd_status(sk, index, MGMT_OP_PIN_CODE_REPLY, ENETDOWN);
@@ -1151,7 +1151,7 @@ static int pin_code_reply(struct sock *sk, u16 index, unsigned char *data,
 		mgmt_pending_remove(cmd);
 
 failed:
-	hci_dev_unlock_bh(hdev);
+	hci_dev_unlock(hdev);
 	hci_dev_put(hdev);
 
 	return err;
@@ -1178,7 +1178,7 @@ static int pin_code_neg_reply(struct sock *sk, u16 index, unsigned char *data,
 		return cmd_status(sk, index, MGMT_OP_PIN_CODE_NEG_REPLY,
 									ENODEV);
 
-	hci_dev_lock_bh(hdev);
+	hci_dev_lock(hdev);
 
 	if (!test_bit(HCI_UP, &hdev->flags)) {
 		err = cmd_status(sk, index, MGMT_OP_PIN_CODE_NEG_REPLY,
@@ -1199,7 +1199,7 @@ static int pin_code_neg_reply(struct sock *sk, u16 index, unsigned char *data,
 		mgmt_pending_remove(cmd);
 
 failed:
-	hci_dev_unlock_bh(hdev);
+	hci_dev_unlock(hdev);
 	hci_dev_put(hdev);
 
 	return err;
@@ -1222,14 +1222,14 @@ static int set_io_capability(struct sock *sk, u16 index, unsigned char *data,
 	if (!hdev)
 		return cmd_status(sk, index, MGMT_OP_SET_IO_CAPABILITY, ENODEV);
 
-	hci_dev_lock_bh(hdev);
+	hci_dev_lock(hdev);
 
 	hdev->io_capability = cp->io_capability;
 
 	BT_DBG("%s IO capability set to 0x%02x", hdev->name,
 							hdev->io_capability);
 
-	hci_dev_unlock_bh(hdev);
+	hci_dev_unlock(hdev);
 	hci_dev_put(hdev);
 
 	return cmd_complete(sk, index, MGMT_OP_SET_IO_CAPABILITY, NULL, 0);
@@ -1315,7 +1315,7 @@ static int pair_device(struct sock *sk, u16 index, unsigned char *data, u16 len)
 	if (!hdev)
 		return cmd_status(sk, index, MGMT_OP_PAIR_DEVICE, ENODEV);
 
-	hci_dev_lock_bh(hdev);
+	hci_dev_lock(hdev);
 
 	if (cp->io_cap == 0x03) {
 		sec_level = BT_SECURITY_MEDIUM;
@@ -1357,7 +1357,7 @@ static int pair_device(struct sock *sk, u16 index, unsigned char *data, u16 len)
 	err = 0;
 
 unlock:
-	hci_dev_unlock_bh(hdev);
+	hci_dev_unlock(hdev);
 	hci_dev_put(hdev);
 
 	return err;
@@ -1389,7 +1389,7 @@ static int user_confirm_reply(struct sock *sk, u16 index, unsigned char *data,
 	if (!hdev)
 		return cmd_status(sk, index, mgmt_op, ENODEV);
 
-	hci_dev_lock_bh(hdev);
+	hci_dev_lock(hdev);
 
 	if (!test_bit(HCI_UP, &hdev->flags)) {
 		err = cmd_status(sk, index, mgmt_op, ENETDOWN);
@@ -1407,7 +1407,7 @@ static int user_confirm_reply(struct sock *sk, u16 index, unsigned char *data,
 		mgmt_pending_remove(cmd);
 
 failed:
-	hci_dev_unlock_bh(hdev);
+	hci_dev_unlock(hdev);
 	hci_dev_put(hdev);
 
 	return err;
@@ -1431,7 +1431,7 @@ static int set_local_name(struct sock *sk, u16 index, unsigned char *data,
 	if (!hdev)
 		return cmd_status(sk, index, MGMT_OP_SET_LOCAL_NAME, ENODEV);
 
-	hci_dev_lock_bh(hdev);
+	hci_dev_lock(hdev);
 
 	cmd = mgmt_pending_add(sk, MGMT_OP_SET_LOCAL_NAME, index, data, len);
 	if (!cmd) {
@@ -1446,7 +1446,7 @@ static int set_local_name(struct sock *sk, u16 index, unsigned char *data,
 		mgmt_pending_remove(cmd);
 
 failed:
-	hci_dev_unlock_bh(hdev);
+	hci_dev_unlock(hdev);
 	hci_dev_put(hdev);
 
 	return err;
@@ -1465,7 +1465,7 @@ static int read_local_oob_data(struct sock *sk, u16 index)
 		return cmd_status(sk, index, MGMT_OP_READ_LOCAL_OOB_DATA,
 									ENODEV);
 
-	hci_dev_lock_bh(hdev);
+	hci_dev_lock(hdev);
 
 	if (!test_bit(HCI_UP, &hdev->flags)) {
 		err = cmd_status(sk, index, MGMT_OP_READ_LOCAL_OOB_DATA,
@@ -1495,7 +1495,7 @@ static int read_local_oob_data(struct sock *sk, u16 index)
 		mgmt_pending_remove(cmd);
 
 unlock:
-	hci_dev_unlock_bh(hdev);
+	hci_dev_unlock(hdev);
 	hci_dev_put(hdev);
 
 	return err;
@@ -1519,7 +1519,7 @@ static int add_remote_oob_data(struct sock *sk, u16 index, unsigned char *data,
 		return cmd_status(sk, index, MGMT_OP_ADD_REMOTE_OOB_DATA,
 									ENODEV);
 
-	hci_dev_lock_bh(hdev);
+	hci_dev_lock(hdev);
 
 	err = hci_add_remote_oob_data(hdev, &cp->bdaddr, cp->hash,
 								cp->randomizer);
@@ -1529,7 +1529,7 @@ static int add_remote_oob_data(struct sock *sk, u16 index, unsigned char *data,
 		err = cmd_complete(sk, index, MGMT_OP_ADD_REMOTE_OOB_DATA, NULL,
 									0);
 
-	hci_dev_unlock_bh(hdev);
+	hci_dev_unlock(hdev);
 	hci_dev_put(hdev);
 
 	return err;
@@ -1553,7 +1553,7 @@ static int remove_remote_oob_data(struct sock *sk, u16 index,
 		return cmd_status(sk, index, MGMT_OP_REMOVE_REMOTE_OOB_DATA,
 									ENODEV);
 
-	hci_dev_lock_bh(hdev);
+	hci_dev_lock(hdev);
 
 	err = hci_remove_remote_oob_data(hdev, &cp->bdaddr);
 	if (err < 0)
@@ -1563,7 +1563,7 @@ static int remove_remote_oob_data(struct sock *sk, u16 index,
 		err = cmd_complete(sk, index, MGMT_OP_REMOVE_REMOTE_OOB_DATA,
 								NULL, 0);
 
-	hci_dev_unlock_bh(hdev);
+	hci_dev_unlock(hdev);
 	hci_dev_put(hdev);
 
 	return err;
-- 
1.7.4.1

