Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/5] Bluetooth: mgmt: Refactor hci_dev lookup for commands
Date: Thu,  1 Mar 2012 12:33:28 -0800
Message-Id: <1330634012-4502-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

Almost all mgmt commands need to lookup a struct hci_dev based on the
index received within the mgmt headers. It makese therefore sense to
look this up in a single place and then just pass the hdev pointer to
each command handler function.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/mgmt.c |  764 ++++++++++++++++++--------------------------------
 1 files changed, 274 insertions(+), 490 deletions(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 3fcccad..cc9fb64 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -624,17 +624,11 @@ static void mgmt_init_hdev(struct hci_dev *hdev)
 	}
 }
 
-static int read_controller_info(struct sock *sk, u16 index)
+static int read_controller_info(struct sock *sk, struct hci_dev *hdev)
 {
 	struct mgmt_rp_read_info rp;
-	struct hci_dev *hdev;
-
-	BT_DBG("sock %p hci%u", sk, index);
 
-	hdev = hci_dev_get(index);
-	if (!hdev)
-		return cmd_status(sk, index, MGMT_OP_READ_INFO,
-						MGMT_STATUS_INVALID_PARAMS);
+	BT_DBG("sock %p %s", sk, hdev->name);
 
 	hci_dev_lock(hdev);
 
@@ -658,9 +652,9 @@ static int read_controller_info(struct sock *sk, u16 index)
 	memcpy(rp.short_name, hdev->short_name, sizeof(hdev->short_name));
 
 	hci_dev_unlock(hdev);
-	hci_dev_put(hdev);
 
-	return cmd_complete(sk, index, MGMT_OP_READ_INFO, 0, &rp, sizeof(rp));
+	return cmd_complete(sk, hdev->id, MGMT_OP_READ_INFO, 0, &rp,
+								sizeof(rp));
 }
 
 static void mgmt_pending_free(struct pending_cmd *cmd)
@@ -744,22 +738,17 @@ static int send_settings_rsp(struct sock *sk, u16 opcode, struct hci_dev *hdev)
 							sizeof(settings));
 }
 
-static int set_powered(struct sock *sk, u16 index, void *data, u16 len)
+static int set_powered(struct sock *sk, struct hci_dev *hdev, void *data,
+								u16 len)
 {
 	struct mgmt_mode *cp = data;
-	struct hci_dev *hdev;
 	struct pending_cmd *cmd;
 	int err;
 
-	BT_DBG("request for hci%u", index);
+	BT_DBG("request for %s", hdev->name);
 
 	if (len != sizeof(*cp))
-		return cmd_status(sk, index, MGMT_OP_SET_POWERED,
-						MGMT_STATUS_INVALID_PARAMS);
-
-	hdev = hci_dev_get(index);
-	if (!hdev)
-		return cmd_status(sk, index, MGMT_OP_SET_POWERED,
+		return cmd_status(sk, hdev->id, MGMT_OP_SET_POWERED,
 						MGMT_STATUS_INVALID_PARAMS);
 
 	hci_dev_lock(hdev);
@@ -780,7 +769,7 @@ static int set_powered(struct sock *sk, u16 index, void *data, u16 len)
 	}
 
 	if (mgmt_pending_find(MGMT_OP_SET_POWERED, hdev)) {
-		err = cmd_status(sk, index, MGMT_OP_SET_POWERED,
+		err = cmd_status(sk, hdev->id, MGMT_OP_SET_POWERED,
 							MGMT_STATUS_BUSY);
 		goto failed;
 	}
@@ -800,7 +789,6 @@ static int set_powered(struct sock *sk, u16 index, void *data, u16 len)
 
 failed:
 	hci_dev_unlock(hdev);
-	hci_dev_put(hdev);
 	return err;
 }
 
@@ -843,48 +831,43 @@ static int new_settings(struct hci_dev *hdev, struct sock *skip)
 	return mgmt_event(MGMT_EV_NEW_SETTINGS, hdev, &ev, sizeof(ev), skip);
 }
 
-static int set_discoverable(struct sock *sk, u16 index, void *data, u16 len)
+static int set_discoverable(struct sock *sk, struct hci_dev *hdev, void *data,
+								u16 len)
 {
 	struct mgmt_cp_set_discoverable *cp = data;
-	struct hci_dev *hdev;
 	struct pending_cmd *cmd;
 	u16 timeout;
 	u8 scan;
 	int err;
 
-	BT_DBG("request for hci%u", index);
+	BT_DBG("request for %s", hdev->name);
 
 	if (len != sizeof(*cp))
-		return cmd_status(sk, index, MGMT_OP_SET_DISCOVERABLE,
+		return cmd_status(sk, hdev->id, MGMT_OP_SET_DISCOVERABLE,
 						MGMT_STATUS_INVALID_PARAMS);
 
 	timeout = get_unaligned_le16(&cp->timeout);
 	if (!cp->val && timeout > 0)
-		return cmd_status(sk, index, MGMT_OP_SET_DISCOVERABLE,
-						MGMT_STATUS_INVALID_PARAMS);
-
-	hdev = hci_dev_get(index);
-	if (!hdev)
-		return cmd_status(sk, index, MGMT_OP_SET_DISCOVERABLE,
+		return cmd_status(sk, hdev->id, MGMT_OP_SET_DISCOVERABLE,
 						MGMT_STATUS_INVALID_PARAMS);
 
 	hci_dev_lock(hdev);
 
 	if (!hdev_is_powered(hdev) && timeout > 0) {
-		err = cmd_status(sk, index, MGMT_OP_SET_DISCOVERABLE,
+		err = cmd_status(sk, hdev->id, MGMT_OP_SET_DISCOVERABLE,
 						MGMT_STATUS_NOT_POWERED);
 		goto failed;
 	}
 
 	if (mgmt_pending_find(MGMT_OP_SET_DISCOVERABLE, hdev) ||
 			mgmt_pending_find(MGMT_OP_SET_CONNECTABLE, hdev)) {
-		err = cmd_status(sk, index, MGMT_OP_SET_DISCOVERABLE,
+		err = cmd_status(sk, hdev->id, MGMT_OP_SET_DISCOVERABLE,
 							MGMT_STATUS_BUSY);
 		goto failed;
 	}
 
 	if (!test_bit(HCI_CONNECTABLE, &hdev->dev_flags)) {
-		err = cmd_status(sk, index, MGMT_OP_SET_DISCOVERABLE,
+		err = cmd_status(sk, hdev->id, MGMT_OP_SET_DISCOVERABLE,
 							MGMT_STATUS_REJECTED);
 		goto failed;
 	}
@@ -945,28 +928,21 @@ static int set_discoverable(struct sock *sk, u16 index, void *data, u16 len)
 
 failed:
 	hci_dev_unlock(hdev);
-	hci_dev_put(hdev);
-
 	return err;
 }
 
-static int set_connectable(struct sock *sk, u16 index, void *data, u16 len)
+static int set_connectable(struct sock *sk, struct hci_dev *hdev, void *data,
+								u16 len)
 {
 	struct mgmt_mode *cp = data;
-	struct hci_dev *hdev;
 	struct pending_cmd *cmd;
 	u8 scan;
 	int err;
 
-	BT_DBG("request for hci%u", index);
+	BT_DBG("request for %s", hdev->name);
 
 	if (len != sizeof(*cp))
-		return cmd_status(sk, index, MGMT_OP_SET_CONNECTABLE,
-						MGMT_STATUS_INVALID_PARAMS);
-
-	hdev = hci_dev_get(index);
-	if (!hdev)
-		return cmd_status(sk, index, MGMT_OP_SET_CONNECTABLE,
+		return cmd_status(sk, hdev->id, MGMT_OP_SET_CONNECTABLE,
 						MGMT_STATUS_INVALID_PARAMS);
 
 	hci_dev_lock(hdev);
@@ -996,7 +972,7 @@ static int set_connectable(struct sock *sk, u16 index, void *data, u16 len)
 
 	if (mgmt_pending_find(MGMT_OP_SET_DISCOVERABLE, hdev) ||
 			mgmt_pending_find(MGMT_OP_SET_CONNECTABLE, hdev)) {
-		err = cmd_status(sk, index, MGMT_OP_SET_CONNECTABLE,
+		err = cmd_status(sk, hdev->id, MGMT_OP_SET_CONNECTABLE,
 							MGMT_STATUS_BUSY);
 		goto failed;
 	}
@@ -1028,26 +1004,19 @@ static int set_connectable(struct sock *sk, u16 index, void *data, u16 len)
 
 failed:
 	hci_dev_unlock(hdev);
-	hci_dev_put(hdev);
-
 	return err;
 }
 
-static int set_pairable(struct sock *sk, u16 index, void *data, u16 len)
+static int set_pairable(struct sock *sk, struct hci_dev *hdev, void *data,
+								u16 len)
 {
 	struct mgmt_mode *cp = data;
-	struct hci_dev *hdev;
 	int err;
 
-	BT_DBG("request for hci%u", index);
+	BT_DBG("request for %s", hdev->name);
 
 	if (len != sizeof(*cp))
-		return cmd_status(sk, index, MGMT_OP_SET_PAIRABLE,
-						MGMT_STATUS_INVALID_PARAMS);
-
-	hdev = hci_dev_get(index);
-	if (!hdev)
-		return cmd_status(sk, index, MGMT_OP_SET_PAIRABLE,
+		return cmd_status(sk, hdev->id, MGMT_OP_SET_PAIRABLE,
 						MGMT_STATUS_INVALID_PARAMS);
 
 	hci_dev_lock(hdev);
@@ -1065,28 +1034,21 @@ static int set_pairable(struct sock *sk, u16 index, void *data, u16 len)
 
 failed:
 	hci_dev_unlock(hdev);
-	hci_dev_put(hdev);
-
 	return err;
 }
 
-static int set_link_security(struct sock *sk, u16 index, void *data, u16 len)
+static int set_link_security(struct sock *sk, struct hci_dev *hdev,
+							void *data, u16 len)
 {
 	struct mgmt_mode *cp = data;
 	struct pending_cmd *cmd;
-	struct hci_dev *hdev;
 	u8 val;
 	int err;
 
-	BT_DBG("request for hci%u", index);
+	BT_DBG("request for %s", hdev->name);
 
 	if (len != sizeof(*cp))
-		return cmd_status(sk, index, MGMT_OP_SET_LINK_SECURITY,
-						MGMT_STATUS_INVALID_PARAMS);
-
-	hdev = hci_dev_get(index);
-	if (!hdev)
-		return cmd_status(sk, index, MGMT_OP_SET_LINK_SECURITY,
+		return cmd_status(sk, hdev->id, MGMT_OP_SET_LINK_SECURITY,
 						MGMT_STATUS_INVALID_PARAMS);
 
 	hci_dev_lock(hdev);
@@ -1111,7 +1073,7 @@ static int set_link_security(struct sock *sk, u16 index, void *data, u16 len)
 	}
 
 	if (mgmt_pending_find(MGMT_OP_SET_LINK_SECURITY, hdev)) {
-		err = cmd_status(sk, index, MGMT_OP_SET_LINK_SECURITY,
+		err = cmd_status(sk, hdev->id, MGMT_OP_SET_LINK_SECURITY,
 							MGMT_STATUS_BUSY);
 		goto failed;
 	}
@@ -1137,34 +1099,26 @@ static int set_link_security(struct sock *sk, u16 index, void *data, u16 len)
 
 failed:
 	hci_dev_unlock(hdev);
-	hci_dev_put(hdev);
-
 	return err;
 }
 
-static int set_ssp(struct sock *sk, u16 index, void *data, u16 len)
+static int set_ssp(struct sock *sk, struct hci_dev *hdev, void *data, u16 len)
 {
 	struct mgmt_mode *cp = data;
 	struct pending_cmd *cmd;
-	struct hci_dev *hdev;
 	u8 val;
 	int err;
 
-	BT_DBG("request for hci%u", index);
+	BT_DBG("request for %s", hdev->name);
 
 	if (len != sizeof(*cp))
-		return cmd_status(sk, index, MGMT_OP_SET_SSP,
-						MGMT_STATUS_INVALID_PARAMS);
-
-	hdev = hci_dev_get(index);
-	if (!hdev)
-		return cmd_status(sk, index, MGMT_OP_SET_SSP,
+		return cmd_status(sk, hdev->id, MGMT_OP_SET_SSP,
 						MGMT_STATUS_INVALID_PARAMS);
 
 	hci_dev_lock(hdev);
 
 	if (!(hdev->features[6] & LMP_SIMPLE_PAIR)) {
-		err = cmd_status(sk, index, MGMT_OP_SET_SSP,
+		err = cmd_status(sk, hdev->id, MGMT_OP_SET_SSP,
 						MGMT_STATUS_NOT_SUPPORTED);
 		goto failed;
 	}
@@ -1190,7 +1144,8 @@ static int set_ssp(struct sock *sk, u16 index, void *data, u16 len)
 	}
 
 	if (mgmt_pending_find(MGMT_OP_SET_SSP, hdev)) {
-		err = cmd_status(sk, index, MGMT_OP_SET_SSP, MGMT_STATUS_BUSY);
+		err = cmd_status(sk, hdev->id, MGMT_OP_SET_SSP,
+							MGMT_STATUS_BUSY);
 		goto failed;
 	}
 
@@ -1213,70 +1168,49 @@ static int set_ssp(struct sock *sk, u16 index, void *data, u16 len)
 
 failed:
 	hci_dev_unlock(hdev);
-	hci_dev_put(hdev);
-
 	return err;
 }
 
-static int set_hs(struct sock *sk, u16 index, void *data, u16 len)
+static int set_hs(struct sock *sk, struct hci_dev *hdev, void *data, u16 len)
 {
 	struct mgmt_mode *cp = data;
-	struct hci_dev *hdev;
-	int err;
 
-	BT_DBG("request for hci%u", index);
+	BT_DBG("request for %s", hdev->name);
 
 	if (len != sizeof(*cp))
-		return cmd_status(sk, index, MGMT_OP_SET_HS,
+		return cmd_status(sk, hdev->id, MGMT_OP_SET_HS,
 						MGMT_STATUS_INVALID_PARAMS);
 
-	hdev = hci_dev_get(index);
-	if (!hdev)
-		return cmd_status(sk, index, MGMT_OP_SET_HS,
-						MGMT_STATUS_INVALID_PARAMS);
-
-	if (!enable_hs) {
-		err = cmd_status(sk, index, MGMT_OP_SET_HS,
-					MGMT_STATUS_NOT_SUPPORTED);
-		goto failed;
-	}
+	if (!enable_hs)
+		return cmd_status(sk, hdev->id, MGMT_OP_SET_HS,
+						MGMT_STATUS_NOT_SUPPORTED);
 
 	if (cp->val)
 		set_bit(HCI_HS_ENABLED, &hdev->dev_flags);
 	else
 		clear_bit(HCI_HS_ENABLED, &hdev->dev_flags);
 
-	err = send_settings_rsp(sk, MGMT_OP_SET_HS, hdev);
-
-failed:
-	hci_dev_put(hdev);
-	return err;
+	return send_settings_rsp(sk, MGMT_OP_SET_HS, hdev);
 }
 
-static int set_le(struct sock *sk, u16 index, void *data, u16 len)
+static int set_le(struct sock *sk, struct hci_dev *hdev, void *data, u16 len)
 {
 	struct mgmt_mode *cp = data;
 	struct hci_cp_write_le_host_supported hci_cp;
 	struct pending_cmd *cmd;
-	struct hci_dev *hdev;
 	int err;
 	u8 val, enabled;
 
-	BT_DBG("request for hci%u", index);
+	BT_DBG("request for %s", hdev->name);
 
 	if (len != sizeof(*cp))
-		return cmd_status(sk, index, MGMT_OP_SET_LE,
-						MGMT_STATUS_INVALID_PARAMS);
-
-	hdev = hci_dev_get(index);
-	if (!hdev)
-		return cmd_status(sk, index, MGMT_OP_SET_LE,
+		return cmd_status(sk, hdev->id, MGMT_OP_SET_LE,
 						MGMT_STATUS_INVALID_PARAMS);
 
 	hci_dev_lock(hdev);
 
 	if (!enable_le || !(hdev->features[4] & LMP_LE)) {
-		err = cmd_status(sk, index, MGMT_OP_SET_LE,
+		err = cmd_status(sk, hdev->id, MGMT_OP_SET_LE,
 						MGMT_STATUS_NOT_SUPPORTED);
 		goto unlock;
 	}
@@ -1303,7 +1237,8 @@ static int set_le(struct sock *sk, u16 index, void *data, u16 len)
 	}
 
 	if (mgmt_pending_find(MGMT_OP_SET_LE, hdev)) {
-		err = cmd_status(sk, index, MGMT_OP_SET_LE, MGMT_STATUS_BUSY);
+		err = cmd_status(sk, hdev->id, MGMT_OP_SET_LE,
+							MGMT_STATUS_BUSY);
 		goto unlock;
 	}
 
@@ -1329,33 +1264,26 @@ static int set_le(struct sock *sk, u16 index, void *data, u16 len)
 
 unlock:
 	hci_dev_unlock(hdev);
-	hci_dev_put(hdev);
 	return err;
 }
 
-static int add_uuid(struct sock *sk, u16 index, void *data, u16 len)
+static int add_uuid(struct sock *sk, struct hci_dev *hdev, void *data, u16 len)
 {
 	struct mgmt_cp_add_uuid *cp = data;
 	struct pending_cmd *cmd;
-	struct hci_dev *hdev;
 	struct bt_uuid *uuid;
 	int err;
 
-	BT_DBG("request for hci%u", index);
+	BT_DBG("request for %s", hdev->name);
 
 	if (len != sizeof(*cp))
-		return cmd_status(sk, index, MGMT_OP_ADD_UUID,
-						MGMT_STATUS_INVALID_PARAMS);
-
-	hdev = hci_dev_get(index);
-	if (!hdev)
-		return cmd_status(sk, index, MGMT_OP_ADD_UUID,
+		return cmd_status(sk, hdev->id, MGMT_OP_ADD_UUID,
 						MGMT_STATUS_INVALID_PARAMS);
 
 	hci_dev_lock(hdev);
 
 	if (test_bit(HCI_PENDING_CLASS, &hdev->dev_flags)) {
-		err = cmd_status(sk, index, MGMT_OP_ADD_UUID,
+		err = cmd_status(sk, hdev->id, MGMT_OP_ADD_UUID,
 							MGMT_STATUS_BUSY);
 		goto failed;
 	}
@@ -1380,7 +1308,7 @@ static int add_uuid(struct sock *sk, u16 index, void *data, u16 len)
 		goto failed;
 
 	if (!test_bit(HCI_PENDING_CLASS, &hdev->dev_flags)) {
-		err = cmd_complete(sk, index, MGMT_OP_ADD_UUID, 0,
+		err = cmd_complete(sk, hdev->id, MGMT_OP_ADD_UUID, 0,
 							hdev->dev_class, 3);
 		goto failed;
 	}
@@ -1393,8 +1321,6 @@ static int add_uuid(struct sock *sk, u16 index, void *data, u16 len)
 
 failed:
 	hci_dev_unlock(hdev);
-	hci_dev_put(hdev);
-
 	return err;
 }
 
@@ -1412,30 +1338,25 @@ static bool enable_service_cache(struct hci_dev *hdev)
 	return false;
 }
 
-static int remove_uuid(struct sock *sk, u16 index, void *data, u16 len)
+static int remove_uuid(struct sock *sk, struct hci_dev *hdev, void *data,
+								u16 len)
 {
 	struct mgmt_cp_remove_uuid *cp = data;
 	struct pending_cmd *cmd;
 	struct list_head *p, *n;
-	struct hci_dev *hdev;
 	u8 bt_uuid_any[] = { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 };
 	int err, found;
 
-	BT_DBG("request for hci%u", index);
+	BT_DBG("request for %s", hdev->name);
 
 	if (len != sizeof(*cp))
-		return cmd_status(sk, index, MGMT_OP_REMOVE_UUID,
-						MGMT_STATUS_INVALID_PARAMS);
-
-	hdev = hci_dev_get(index);
-	if (!hdev)
-		return cmd_status(sk, index, MGMT_OP_REMOVE_UUID,
+		return cmd_status(sk, hdev->id, MGMT_OP_REMOVE_UUID,
 						MGMT_STATUS_INVALID_PARAMS);
 
 	hci_dev_lock(hdev);
 
 	if (test_bit(HCI_PENDING_CLASS, &hdev->dev_flags)) {
-		err = cmd_status(sk, index, MGMT_OP_REMOVE_UUID,
+		err = cmd_status(sk, hdev->id, MGMT_OP_REMOVE_UUID,
 							MGMT_STATUS_BUSY);
 		goto unlock;
 	}
@@ -1444,8 +1365,8 @@ static int remove_uuid(struct sock *sk, u16 index, void *data, u16 len)
 		err = hci_uuids_clear(hdev);
 
 		if (enable_service_cache(hdev)) {
-			err = cmd_complete(sk, index, MGMT_OP_REMOVE_UUID, 0,
-							hdev->dev_class, 3);
+			err = cmd_complete(sk, hdev->id, MGMT_OP_REMOVE_UUID,
+							0, hdev->dev_class, 3);
 			goto unlock;
 		}
 
@@ -1465,7 +1386,7 @@ static int remove_uuid(struct sock *sk, u16 index, void *data, u16 len)
 	}
 
 	if (found == 0) {
-		err = cmd_status(sk, index, MGMT_OP_REMOVE_UUID,
+		err = cmd_status(sk, hdev->id, MGMT_OP_REMOVE_UUID,
 						MGMT_STATUS_INVALID_PARAMS);
 		goto unlock;
 	}
@@ -1480,7 +1401,7 @@ update_class:
 		goto unlock;
 
 	if (!test_bit(HCI_PENDING_CLASS, &hdev->dev_flags)) {
-		err = cmd_complete(sk, index, MGMT_OP_REMOVE_UUID, 0,
+		err = cmd_complete(sk, hdev->id, MGMT_OP_REMOVE_UUID, 0,
 							hdev->dev_class, 3);
 		goto unlock;
 	}
@@ -1493,33 +1414,26 @@ update_class:
 
 unlock:
 	hci_dev_unlock(hdev);
-	hci_dev_put(hdev);
-
 	return err;
 }
 
-static int set_dev_class(struct sock *sk, u16 index, void *data, u16 len)
+static int set_dev_class(struct sock *sk, struct hci_dev *hdev, void *data,
+								u16 len)
 {
-	struct hci_dev *hdev;
 	struct mgmt_cp_set_dev_class *cp = data;
 	struct pending_cmd *cmd;
 	int err;
 
-	BT_DBG("request for hci%u", index);
+	BT_DBG("request for %s", hdev->name);
 
 	if (len != sizeof(*cp))
-		return cmd_status(sk, index, MGMT_OP_SET_DEV_CLASS,
-						MGMT_STATUS_INVALID_PARAMS);
-
-	hdev = hci_dev_get(index);
-	if (!hdev)
-		return cmd_status(sk, index, MGMT_OP_SET_DEV_CLASS,
+		return cmd_status(sk, hdev->id, MGMT_OP_SET_DEV_CLASS,
 						MGMT_STATUS_INVALID_PARAMS);
 
 	hci_dev_lock(hdev);
 
 	if (test_bit(HCI_PENDING_CLASS, &hdev->dev_flags)) {
-		err = cmd_status(sk, index, MGMT_OP_SET_DEV_CLASS,
+		err = cmd_status(sk, hdev->id, MGMT_OP_SET_DEV_CLASS,
 							MGMT_STATUS_BUSY);
 		goto unlock;
 	}
@@ -1528,7 +1442,7 @@ static int set_dev_class(struct sock *sk, u16 index, void *data, u16 len)
 	hdev->minor_class = cp->minor;
 
 	if (!hdev_is_powered(hdev)) {
-		err = cmd_complete(sk, index, MGMT_OP_SET_DEV_CLASS, 0,
+		err = cmd_complete(sk, hdev->id, MGMT_OP_SET_DEV_CLASS, 0,
 							hdev->dev_class, 3);
 		goto unlock;
 	}
@@ -1545,7 +1459,7 @@ static int set_dev_class(struct sock *sk, u16 index, void *data, u16 len)
 		goto unlock;
 
 	if (!test_bit(HCI_PENDING_CLASS, &hdev->dev_flags)) {
-		err = cmd_complete(sk, index, MGMT_OP_SET_DEV_CLASS, 0,
+		err = cmd_complete(sk, hdev->id, MGMT_OP_SET_DEV_CLASS, 0,
 							hdev->dev_class, 3);
 		goto unlock;
 	}
@@ -1558,20 +1472,18 @@ static int set_dev_class(struct sock *sk, u16 index, void *data, u16 len)
 
 unlock:
 	hci_dev_unlock(hdev);
-	hci_dev_put(hdev);
-
 	return err;
 }
 
-static int load_link_keys(struct sock *sk, u16 index, void *data, u16 len)
+static int load_link_keys(struct sock *sk, struct hci_dev *hdev, void *data,
+								u16 len)
 {
-	struct hci_dev *hdev;
 	struct mgmt_cp_load_link_keys *cp = data;
 	u16 key_count, expected_len;
 	int i;
 
 	if (len < sizeof(*cp))
-		return cmd_status(sk, index, MGMT_OP_LOAD_LINK_KEYS,
+		return cmd_status(sk, hdev->id, MGMT_OP_LOAD_LINK_KEYS,
 						MGMT_STATUS_INVALID_PARAMS);
 
 	key_count = get_unaligned_le16(&cp->key_count);
@@ -1581,16 +1493,11 @@ static int load_link_keys(struct sock *sk, u16 index, void *data, u16 len)
 	if (expected_len != len) {
 		BT_ERR("load_link_keys: expected %u bytes, got %u bytes",
 							len, expected_len);
-		return cmd_status(sk, index, MGMT_OP_LOAD_LINK_KEYS,
+		return cmd_status(sk, hdev->id, MGMT_OP_LOAD_LINK_KEYS,
 						MGMT_STATUS_INVALID_PARAMS);
 	}
 
-	hdev = hci_dev_get(index);
-	if (!hdev)
-		return cmd_status(sk, index, MGMT_OP_LOAD_LINK_KEYS,
-						MGMT_STATUS_INVALID_PARAMS);
-
-	BT_DBG("hci%u debug_keys %u key_count %u", index, cp->debug_keys,
+	BT_DBG("%s debug_keys %u key_count %u", hdev->name, cp->debug_keys,
 								key_count);
 
 	hci_dev_lock(hdev);
@@ -1611,10 +1518,9 @@ static int load_link_keys(struct sock *sk, u16 index, void *data, u16 len)
 						key->type, key->pin_len);
 	}
 
-	cmd_complete(sk, index, MGMT_OP_LOAD_LINK_KEYS, 0, NULL, 0);
+	cmd_complete(sk, hdev->id, MGMT_OP_LOAD_LINK_KEYS, 0, NULL, 0);
 
 	hci_dev_unlock(hdev);
-	hci_dev_put(hdev);
 
 	return 0;
 }
@@ -1631,9 +1537,9 @@ static int device_unpaired(struct hci_dev *hdev, bdaddr_t *bdaddr,
 								skip_sk);
 }
 
-static int unpair_device(struct sock *sk, u16 index, void *data, u16 len)
+static int unpair_device(struct sock *sk, struct hci_dev *hdev, void *data,
+								u16 len)
 {
-	struct hci_dev *hdev;
 	struct mgmt_cp_unpair_device *cp = data;
 	struct mgmt_rp_unpair_device rp;
 	struct hci_cp_disconnect dc;
@@ -1642,12 +1548,7 @@ static int unpair_device(struct sock *sk, u16 index, void *data, u16 len)
 	int err;
 
 	if (len != sizeof(*cp))
-		return cmd_status(sk, index, MGMT_OP_UNPAIR_DEVICE,
-						MGMT_STATUS_INVALID_PARAMS);
-
-	hdev = hci_dev_get(index);
-	if (!hdev)
-		return cmd_status(sk, index, MGMT_OP_UNPAIR_DEVICE,
+		return cmd_status(sk, hdev->id, MGMT_OP_UNPAIR_DEVICE,
 						MGMT_STATUS_INVALID_PARAMS);
 
 	hci_dev_lock(hdev);
@@ -1657,7 +1558,7 @@ static int unpair_device(struct sock *sk, u16 index, void *data, u16 len)
 	rp.addr.type = cp->addr.type;
 
 	if (!hdev_is_powered(hdev)) {
-		err = cmd_complete(sk, index, MGMT_OP_UNPAIR_DEVICE,
+		err = cmd_complete(sk, hdev->id, MGMT_OP_UNPAIR_DEVICE,
 						MGMT_STATUS_NOT_POWERED,
 						&rp, sizeof(rp));
 		goto unlock;
@@ -1669,7 +1570,7 @@ static int unpair_device(struct sock *sk, u16 index, void *data, u16 len)
 		err = hci_remove_ltk(hdev, &cp->addr.bdaddr);
 
 	if (err < 0) {
-		err = cmd_complete(sk, index, MGMT_OP_UNPAIR_DEVICE,
+		err = cmd_complete(sk, hdev->id, MGMT_OP_UNPAIR_DEVICE,
 						MGMT_STATUS_NOT_PAIRED,
 						&rp, sizeof(rp));
 		goto unlock;
@@ -1687,7 +1588,7 @@ static int unpair_device(struct sock *sk, u16 index, void *data, u16 len)
 	}
 
 	if (!conn) {
-		err = cmd_complete(sk, index, MGMT_OP_UNPAIR_DEVICE, 0,
+		err = cmd_complete(sk, hdev->id, MGMT_OP_UNPAIR_DEVICE, 0,
 							&rp, sizeof(rp));
 		device_unpaired(hdev, &cp->addr.bdaddr, cp->addr.type, sk);
 		goto unlock;
@@ -1708,14 +1609,12 @@ static int unpair_device(struct sock *sk, u16 index, void *data, u16 len)
 
 unlock:
 	hci_dev_unlock(hdev);
-	hci_dev_put(hdev);
-
 	return err;
 }
 
-static int disconnect(struct sock *sk, u16 index, void *data, u16 len)
+static int disconnect(struct sock *sk, struct hci_dev *hdev, void *data,
+								u16 len)
 {
-	struct hci_dev *hdev;
 	struct mgmt_cp_disconnect *cp = data;
 	struct hci_cp_disconnect dc;
 	struct pending_cmd *cmd;
@@ -1725,24 +1624,19 @@ static int disconnect(struct sock *sk, u16 index, void *data, u16 len)
 	BT_DBG("");
 
 	if (len != sizeof(*cp))
-		return cmd_status(sk, index, MGMT_OP_DISCONNECT,
-						MGMT_STATUS_INVALID_PARAMS);
-
-	hdev = hci_dev_get(index);
-	if (!hdev)
-		return cmd_status(sk, index, MGMT_OP_DISCONNECT,
+		return cmd_status(sk, hdev->id, MGMT_OP_DISCONNECT,
 						MGMT_STATUS_INVALID_PARAMS);
 
 	hci_dev_lock(hdev);
 
 	if (!test_bit(HCI_UP, &hdev->flags)) {
-		err = cmd_status(sk, index, MGMT_OP_DISCONNECT,
+		err = cmd_status(sk, hdev->id, MGMT_OP_DISCONNECT,
 						MGMT_STATUS_NOT_POWERED);
 		goto failed;
 	}
 
 	if (mgmt_pending_find(MGMT_OP_DISCONNECT, hdev)) {
-		err = cmd_status(sk, index, MGMT_OP_DISCONNECT,
+		err = cmd_status(sk, hdev->id, MGMT_OP_DISCONNECT,
 							MGMT_STATUS_BUSY);
 		goto failed;
 	}
@@ -1753,7 +1647,7 @@ static int disconnect(struct sock *sk, u16 index, void *data, u16 len)
 		conn = hci_conn_hash_lookup_ba(hdev, LE_LINK, &cp->addr.bdaddr);
 
 	if (!conn) {
-		err = cmd_status(sk, index, MGMT_OP_DISCONNECT,
+		err = cmd_status(sk, hdev->id, MGMT_OP_DISCONNECT,
 						MGMT_STATUS_NOT_CONNECTED);
 		goto failed;
 	}
@@ -1773,8 +1667,6 @@ static int disconnect(struct sock *sk, u16 index, void *data, u16 len)
 
 failed:
 	hci_dev_unlock(hdev);
-	hci_dev_put(hdev);
-
 	return err;
 }
 
@@ -1797,10 +1689,9 @@ static u8 link_to_mgmt(u8 link_type, u8 addr_type)
 	}
 }
 
-static int get_connections(struct sock *sk, u16 index)
+static int get_connections(struct sock *sk, struct hci_dev *hdev)
 {
 	struct mgmt_rp_get_connections *rp;
-	struct hci_dev *hdev;
 	struct hci_conn *c;
 	size_t rp_len;
 	int err;
@@ -1808,15 +1699,10 @@ static int get_connections(struct sock *sk, u16 index)
 
 	BT_DBG("");
 
-	hdev = hci_dev_get(index);
-	if (!hdev)
-		return cmd_status(sk, index, MGMT_OP_GET_CONNECTIONS,
-						MGMT_STATUS_INVALID_PARAMS);
-
 	hci_dev_lock(hdev);
 
 	if (!hdev_is_powered(hdev)) {
-		err = cmd_status(sk, index, MGMT_OP_GET_CONNECTIONS,
+		err = cmd_status(sk, hdev->id, MGMT_OP_GET_CONNECTIONS,
 						MGMT_STATUS_NOT_POWERED);
 		goto unlock;
 	}
@@ -1850,18 +1736,18 @@ static int get_connections(struct sock *sk, u16 index)
 	/* Recalculate length in case of filtered SCO connections, etc */
 	rp_len = sizeof(*rp) + (i * sizeof(struct mgmt_addr_info));
 
-	err = cmd_complete(sk, index, MGMT_OP_GET_CONNECTIONS, 0, rp, rp_len);
+	err = cmd_complete(sk, hdev->id, MGMT_OP_GET_CONNECTIONS, 0, rp,
+								rp_len);
 
 	kfree(rp);
 
 unlock:
 	hci_dev_unlock(hdev);
-	hci_dev_put(hdev);
 	return err;
 }
 
-static int send_pin_code_neg_reply(struct sock *sk, u16 index,
-		struct hci_dev *hdev, struct mgmt_cp_pin_code_neg_reply *cp)
+static int send_pin_code_neg_reply(struct sock *sk, struct hci_dev *hdev,
+					struct mgmt_cp_pin_code_neg_reply *cp)
 {
 	struct pending_cmd *cmd;
 	int err;
@@ -1879,9 +1765,9 @@ static int send_pin_code_neg_reply(struct sock *sk, u16 index,
 	return err;
 }
 
-static int pin_code_reply(struct sock *sk, u16 index, void *data, u16 len)
+static int pin_code_reply(struct sock *sk, struct hci_dev *hdev, void *data,
+								u16 len)
 {
-	struct hci_dev *hdev;
 	struct hci_conn *conn;
 	struct mgmt_cp_pin_code_reply *cp = data;
 	struct hci_cp_pin_code_reply reply;
@@ -1891,25 +1777,20 @@ static int pin_code_reply(struct sock *sk, u16 index, void *data, u16 len)
 	BT_DBG("");
 
 	if (len != sizeof(*cp))
-		return cmd_status(sk, index, MGMT_OP_PIN_CODE_REPLY,
-						MGMT_STATUS_INVALID_PARAMS);
-
-	hdev = hci_dev_get(index);
-	if (!hdev)
-		return cmd_status(sk, index, MGMT_OP_PIN_CODE_REPLY,
+		return cmd_status(sk, hdev->id, MGMT_OP_PIN_CODE_REPLY,
 						MGMT_STATUS_INVALID_PARAMS);
 
 	hci_dev_lock(hdev);
 
 	if (!hdev_is_powered(hdev)) {
-		err = cmd_status(sk, index, MGMT_OP_PIN_CODE_REPLY,
+		err = cmd_status(sk, hdev->id, MGMT_OP_PIN_CODE_REPLY,
 						MGMT_STATUS_NOT_POWERED);
 		goto failed;
 	}
 
 	conn = hci_conn_hash_lookup_ba(hdev, ACL_LINK, &cp->addr.bdaddr);
 	if (!conn) {
-		err = cmd_status(sk, index, MGMT_OP_PIN_CODE_REPLY,
+		err = cmd_status(sk, hdev->id, MGMT_OP_PIN_CODE_REPLY,
 						MGMT_STATUS_NOT_CONNECTED);
 		goto failed;
 	}
@@ -1921,9 +1802,9 @@ static int pin_code_reply(struct sock *sk, u16 index, void *data, u16 len)
 
 		BT_ERR("PIN code is not 16 bytes long");
 
-		err = send_pin_code_neg_reply(sk, index, hdev, &ncp);
+		err = send_pin_code_neg_reply(sk, hdev, &ncp);
 		if (err >= 0)
-			err = cmd_status(sk, index, MGMT_OP_PIN_CODE_REPLY,
+			err = cmd_status(sk, hdev->id, MGMT_OP_PIN_CODE_REPLY,
 						MGMT_STATUS_INVALID_PARAMS);
 
 		goto failed;
@@ -1945,59 +1826,45 @@ static int pin_code_reply(struct sock *sk, u16 index, void *data, u16 len)
 
 failed:
 	hci_dev_unlock(hdev);
-	hci_dev_put(hdev);
-
 	return err;
 }
 
-static int pin_code_neg_reply(struct sock *sk, u16 index, void *data, u16 len)
+static int pin_code_neg_reply(struct sock *sk, struct hci_dev *hdev,
+							void *data, u16 len)
 {
-	struct hci_dev *hdev;
 	struct mgmt_cp_pin_code_neg_reply *cp = data;
 	int err;
 
 	BT_DBG("");
 
 	if (len != sizeof(*cp))
-		return cmd_status(sk, index, MGMT_OP_PIN_CODE_NEG_REPLY,
-						MGMT_STATUS_INVALID_PARAMS);
-
-	hdev = hci_dev_get(index);
-	if (!hdev)
-		return cmd_status(sk, index, MGMT_OP_PIN_CODE_NEG_REPLY,
+		return cmd_status(sk, hdev->id, MGMT_OP_PIN_CODE_NEG_REPLY,
 						MGMT_STATUS_INVALID_PARAMS);
 
 	hci_dev_lock(hdev);
 
 	if (!hdev_is_powered(hdev)) {
-		err = cmd_status(sk, index, MGMT_OP_PIN_CODE_NEG_REPLY,
+		err = cmd_status(sk, hdev->id, MGMT_OP_PIN_CODE_NEG_REPLY,
 						MGMT_STATUS_NOT_POWERED);
 		goto failed;
 	}
 
-	err = send_pin_code_neg_reply(sk, index, hdev, cp);
+	err = send_pin_code_neg_reply(sk, hdev, cp);
 
 failed:
 	hci_dev_unlock(hdev);
-	hci_dev_put(hdev);
-
 	return err;
 }
 
-static int set_io_capability(struct sock *sk, u16 index, void *data, u16 len)
+static int set_io_capability(struct sock *sk, struct hci_dev *hdev,
+							void *data, u16 len)
 {
-	struct hci_dev *hdev;
 	struct mgmt_cp_set_io_capability *cp = data;
 
 	BT_DBG("");
 
 	if (len != sizeof(*cp))
-		return cmd_status(sk, index, MGMT_OP_SET_IO_CAPABILITY,
-						MGMT_STATUS_INVALID_PARAMS);
-
-	hdev = hci_dev_get(index);
-	if (!hdev)
-		return cmd_status(sk, index, MGMT_OP_SET_IO_CAPABILITY,
+		return cmd_status(sk, hdev->id, MGMT_OP_SET_IO_CAPABILITY,
 						MGMT_STATUS_INVALID_PARAMS);
 
 	hci_dev_lock(hdev);
@@ -2008,9 +1875,9 @@ static int set_io_capability(struct sock *sk, u16 index, void *data, u16 len)
 							hdev->io_capability);
 
 	hci_dev_unlock(hdev);
-	hci_dev_put(hdev);
 
-	return cmd_complete(sk, index, MGMT_OP_SET_IO_CAPABILITY, 0, NULL, 0);
+	return cmd_complete(sk, hdev->id, MGMT_OP_SET_IO_CAPABILITY, 0,
+								NULL, 0);
 }
 
 static inline struct pending_cmd *find_pairing(struct hci_conn *conn)
@@ -2065,9 +1932,9 @@ static void pairing_complete_cb(struct hci_conn *conn, u8 status)
 		pairing_complete(cmd, mgmt_status(status));
 }
 
-static int pair_device(struct sock *sk, u16 index, void *data, u16 len)
+static int pair_device(struct sock *sk, struct hci_dev *hdev, void *data,
+								u16 len)
 {
-	struct hci_dev *hdev;
 	struct mgmt_cp_pair_device *cp = data;
 	struct mgmt_rp_pair_device rp;
 	struct pending_cmd *cmd;
@@ -2078,18 +1945,13 @@ static int pair_device(struct sock *sk, u16 index, void *data, u16 len)
 	BT_DBG("");
 
 	if (len != sizeof(*cp))
-		return cmd_status(sk, index, MGMT_OP_PAIR_DEVICE,
-						MGMT_STATUS_INVALID_PARAMS);
-
-	hdev = hci_dev_get(index);
-	if (!hdev)
-		return cmd_status(sk, index, MGMT_OP_PAIR_DEVICE,
+		return cmd_status(sk, hdev->id, MGMT_OP_PAIR_DEVICE,
 						MGMT_STATUS_INVALID_PARAMS);
 
 	hci_dev_lock(hdev);
 
 	if (!hdev_is_powered(hdev)) {
-		err = cmd_status(sk, index, MGMT_OP_PAIR_DEVICE,
+		err = cmd_status(sk, hdev->id, MGMT_OP_PAIR_DEVICE,
 						MGMT_STATUS_NOT_POWERED);
 		goto unlock;
 	}
@@ -2112,7 +1974,7 @@ static int pair_device(struct sock *sk, u16 index, void *data, u16 len)
 	rp.addr.type = cp->addr.type;
 
 	if (IS_ERR(conn)) {
-		err = cmd_complete(sk, index, MGMT_OP_PAIR_DEVICE,
+		err = cmd_complete(sk, hdev->id, MGMT_OP_PAIR_DEVICE,
 						MGMT_STATUS_CONNECT_FAILED,
 						&rp, sizeof(rp));
 		goto unlock;
@@ -2120,7 +1982,7 @@ static int pair_device(struct sock *sk, u16 index, void *data, u16 len)
 
 	if (conn->connect_cfm_cb) {
 		hci_conn_put(conn);
-		err = cmd_complete(sk, index, MGMT_OP_PAIR_DEVICE,
+		err = cmd_complete(sk, hdev->id, MGMT_OP_PAIR_DEVICE,
 					MGMT_STATUS_BUSY, &rp, sizeof(rp));
 		goto unlock;
 	}
@@ -2149,16 +2011,13 @@ static int pair_device(struct sock *sk, u16 index, void *data, u16 len)
 
 unlock:
 	hci_dev_unlock(hdev);
-	hci_dev_put(hdev);
-
 	return err;
 }
 
-static int cancel_pair_device(struct sock *sk, u16 index,
+static int cancel_pair_device(struct sock *sk, struct hci_dev *hdev,
 						unsigned char *data, u16 len)
 {
 	struct mgmt_addr_info *addr = (void *) data;
-	struct hci_dev *hdev;
 	struct pending_cmd *cmd;
 	struct hci_conn *conn;
 	int err;
@@ -2166,25 +2025,20 @@ static int cancel_pair_device(struct sock *sk, u16 index,
 	BT_DBG("");
 
 	if (len != sizeof(*addr))
-		return cmd_status(sk, index, MGMT_OP_CANCEL_PAIR_DEVICE,
-						MGMT_STATUS_INVALID_PARAMS);
-
-	hdev = hci_dev_get(index);
-	if (!hdev)
-		return cmd_status(sk, index, MGMT_OP_CANCEL_PAIR_DEVICE,
+		return cmd_status(sk, hdev->id, MGMT_OP_CANCEL_PAIR_DEVICE,
 						MGMT_STATUS_INVALID_PARAMS);
 
 	hci_dev_lock(hdev);
 
 	if (!hdev_is_powered(hdev)) {
-		err = cmd_status(sk, index, MGMT_OP_CANCEL_PAIR_DEVICE,
+		err = cmd_status(sk, hdev->id, MGMT_OP_CANCEL_PAIR_DEVICE,
 						MGMT_STATUS_NOT_POWERED);
 		goto unlock;
 	}
 
 	cmd = mgmt_pending_find(MGMT_OP_PAIR_DEVICE, hdev);
 	if (!cmd) {
-		err = cmd_status(sk, index, MGMT_OP_CANCEL_PAIR_DEVICE,
+		err = cmd_status(sk, hdev->id, MGMT_OP_CANCEL_PAIR_DEVICE,
 						MGMT_STATUS_INVALID_PARAMS);
 		goto unlock;
 	}
@@ -2192,40 +2046,33 @@ static int cancel_pair_device(struct sock *sk, u16 index,
 	conn = cmd->user_data;
 
 	if (bacmp(&addr->bdaddr, &conn->dst) != 0) {
-		err = cmd_status(sk, index, MGMT_OP_CANCEL_PAIR_DEVICE,
+		err = cmd_status(sk, hdev->id, MGMT_OP_CANCEL_PAIR_DEVICE,
 						MGMT_STATUS_INVALID_PARAMS);
 		goto unlock;
 	}
 
 	pairing_complete(cmd, MGMT_STATUS_CANCELLED);
 
-	err = cmd_complete(sk, index, MGMT_OP_CANCEL_PAIR_DEVICE, 0, addr,
-								sizeof(*addr));
+	err = cmd_complete(sk, hdev->id, MGMT_OP_CANCEL_PAIR_DEVICE, 0,
+							addr, sizeof(*addr));
 unlock:
 	hci_dev_unlock(hdev);
-	hci_dev_put(hdev);
-
 	return err;
 }
 
-static int user_pairing_resp(struct sock *sk, u16 index, bdaddr_t *bdaddr,
-					u8 type, u16 mgmt_op, u16 hci_op,
-					__le32 passkey)
+static int user_pairing_resp(struct sock *sk, struct hci_dev *hdev,
+				bdaddr_t *bdaddr, u8 type, u16 mgmt_op,
+				u16 hci_op, __le32 passkey)
 {
 	struct pending_cmd *cmd;
-	struct hci_dev *hdev;
 	struct hci_conn *conn;
 	int err;
 
-	hdev = hci_dev_get(index);
-	if (!hdev)
-		return cmd_status(sk, index, mgmt_op,
-						MGMT_STATUS_INVALID_PARAMS);
-
 	hci_dev_lock(hdev);
 
 	if (!hdev_is_powered(hdev)) {
-		err = cmd_status(sk, index, mgmt_op, MGMT_STATUS_NOT_POWERED);
+		err = cmd_status(sk, hdev->id, mgmt_op,
+						MGMT_STATUS_NOT_POWERED);
 		goto done;
 	}
 
@@ -2235,7 +2082,7 @@ static int user_pairing_resp(struct sock *sk, u16 index, bdaddr_t *bdaddr,
 		conn = hci_conn_hash_lookup_ba(hdev, LE_LINK, bdaddr);
 
 	if (!conn) {
-		err = cmd_status(sk, index, mgmt_op,
+		err = cmd_status(sk, hdev->id, mgmt_op,
 						MGMT_STATUS_NOT_CONNECTED);
 		goto done;
 	}
@@ -2245,10 +2092,10 @@ static int user_pairing_resp(struct sock *sk, u16 index, bdaddr_t *bdaddr,
 		err = smp_user_confirm_reply(conn, mgmt_op, passkey);
 
 		if (!err)
-			err = cmd_status(sk, index, mgmt_op,
+			err = cmd_status(sk, hdev->id, mgmt_op,
 							MGMT_STATUS_SUCCESS);
 		else
-			err = cmd_status(sk, index, mgmt_op,
+			err = cmd_status(sk, hdev->id, mgmt_op,
 							MGMT_STATUS_FAILED);
 
 		goto done;
@@ -2275,92 +2122,86 @@ static int user_pairing_resp(struct sock *sk, u16 index, bdaddr_t *bdaddr,
 
 done:
 	hci_dev_unlock(hdev);
-	hci_dev_put(hdev);
-
 	return err;
 }
 
-static int user_confirm_reply(struct sock *sk, u16 index, void *data, u16 len)
+static int user_confirm_reply(struct sock *sk, struct hci_dev *hdev,
+							void *data, u16 len)
 {
 	struct mgmt_cp_user_confirm_reply *cp = data;
 
 	BT_DBG("");
 
 	if (len != sizeof(*cp))
-		return cmd_status(sk, index, MGMT_OP_USER_CONFIRM_REPLY,
+		return cmd_status(sk, hdev->id, MGMT_OP_USER_CONFIRM_REPLY,
 						MGMT_STATUS_INVALID_PARAMS);
 
-	return user_pairing_resp(sk, index, &cp->addr.bdaddr, cp->addr.type,
+	return user_pairing_resp(sk, hdev, &cp->addr.bdaddr, cp->addr.type,
 						MGMT_OP_USER_CONFIRM_REPLY,
 						HCI_OP_USER_CONFIRM_REPLY, 0);
 }
 
-static int user_confirm_neg_reply(struct sock *sk, u16 index, void *data,
-									u16 len)
+static int user_confirm_neg_reply(struct sock *sk, struct hci_dev *hdev,
+							void *data, u16 len)
 {
 	struct mgmt_cp_user_confirm_neg_reply *cp = data;
 
 	BT_DBG("");
 
 	if (len != sizeof(*cp))
-		return cmd_status(sk, index, MGMT_OP_USER_CONFIRM_NEG_REPLY,
+		return cmd_status(sk, hdev->id, MGMT_OP_USER_CONFIRM_NEG_REPLY,
 						MGMT_STATUS_INVALID_PARAMS);
 
-	return user_pairing_resp(sk, index, &cp->addr.bdaddr, cp->addr.type,
+	return user_pairing_resp(sk, hdev, &cp->addr.bdaddr, cp->addr.type,
 					MGMT_OP_USER_CONFIRM_NEG_REPLY,
 					HCI_OP_USER_CONFIRM_NEG_REPLY, 0);
 }
 
-static int user_passkey_reply(struct sock *sk, u16 index, void *data, u16 len)
+static int user_passkey_reply(struct sock *sk, struct hci_dev *hdev,
+							void *data, u16 len)
 {
 	struct mgmt_cp_user_passkey_reply *cp = data;
 
 	BT_DBG("");
 
 	if (len != sizeof(*cp))
-		return cmd_status(sk, index, MGMT_OP_USER_PASSKEY_REPLY,
+		return cmd_status(sk, hdev->id, MGMT_OP_USER_PASSKEY_REPLY,
 									EINVAL);
 
-	return user_pairing_resp(sk, index, &cp->addr.bdaddr, cp->addr.type,
+	return user_pairing_resp(sk, hdev, &cp->addr.bdaddr, cp->addr.type,
 						MGMT_OP_USER_PASSKEY_REPLY,
 						HCI_OP_USER_PASSKEY_REPLY,
 						cp->passkey);
 }
 
-static int user_passkey_neg_reply(struct sock *sk, u16 index, void *data,
-									u16 len)
+static int user_passkey_neg_reply(struct sock *sk, struct hci_dev *hdev,
+							void *data, u16 len)
 {
 	struct mgmt_cp_user_passkey_neg_reply *cp = data;
 
 	BT_DBG("");
 
 	if (len != sizeof(*cp))
-		return cmd_status(sk, index, MGMT_OP_USER_PASSKEY_NEG_REPLY,
-									EINVAL);
+		return cmd_status(sk, hdev->id, MGMT_OP_USER_PASSKEY_NEG_REPLY,
+								EINVAL);
 
-	return user_pairing_resp(sk, index, &cp->addr.bdaddr, cp->addr.type,
+	return user_pairing_resp(sk, hdev, &cp->addr.bdaddr, cp->addr.type,
 					MGMT_OP_USER_PASSKEY_NEG_REPLY,
 					HCI_OP_USER_PASSKEY_NEG_REPLY, 0);
 }
 
-static int set_local_name(struct sock *sk, u16 index, void *data,
+static int set_local_name(struct sock *sk, struct hci_dev *hdev, void *data,
 								u16 len)
 {
 	struct mgmt_cp_set_local_name *mgmt_cp = data;
 	struct hci_cp_write_local_name hci_cp;
-	struct hci_dev *hdev;
 	struct pending_cmd *cmd;
 	int err;
 
 	BT_DBG("");
 
 	if (len != sizeof(*mgmt_cp))
-		return cmd_status(sk, index, MGMT_OP_SET_LOCAL_NAME,
-						MGMT_STATUS_INVALID_PARAMS);
-
-	hdev = hci_dev_get(index);
-	if (!hdev)
-		return cmd_status(sk, index, MGMT_OP_SET_LOCAL_NAME,
+		return cmd_status(sk, hdev->id, MGMT_OP_SET_LOCAL_NAME,
 						MGMT_STATUS_INVALID_PARAMS);
 
 	hci_dev_lock(hdev);
@@ -2396,40 +2237,32 @@ static int set_local_name(struct sock *sk, u16 index, void *data,
 
 failed:
 	hci_dev_unlock(hdev);
-	hci_dev_put(hdev);
-
 	return err;
 }
 
-static int read_local_oob_data(struct sock *sk, u16 index)
+static int read_local_oob_data(struct sock *sk, struct hci_dev *hdev)
 {
-	struct hci_dev *hdev;
 	struct pending_cmd *cmd;
 	int err;
 
-	BT_DBG("hci%u", index);
-
-	hdev = hci_dev_get(index);
-	if (!hdev)
-		return cmd_status(sk, index, MGMT_OP_READ_LOCAL_OOB_DATA,
-						MGMT_STATUS_INVALID_PARAMS);
+	BT_DBG("%s", hdev->name);
 
 	hci_dev_lock(hdev);
 
 	if (!hdev_is_powered(hdev)) {
-		err = cmd_status(sk, index, MGMT_OP_READ_LOCAL_OOB_DATA,
+		err = cmd_status(sk, hdev->id, MGMT_OP_READ_LOCAL_OOB_DATA,
 						MGMT_STATUS_NOT_POWERED);
 		goto unlock;
 	}
 
 	if (!(hdev->features[6] & LMP_SIMPLE_PAIR)) {
-		err = cmd_status(sk, index, MGMT_OP_READ_LOCAL_OOB_DATA,
+		err = cmd_status(sk, hdev->id, MGMT_OP_READ_LOCAL_OOB_DATA,
 						MGMT_STATUS_NOT_SUPPORTED);
 		goto unlock;
 	}
 
 	if (mgmt_pending_find(MGMT_OP_READ_LOCAL_OOB_DATA, hdev)) {
-		err = cmd_status(sk, index, MGMT_OP_READ_LOCAL_OOB_DATA,
+		err = cmd_status(sk, hdev->id, MGMT_OP_READ_LOCAL_OOB_DATA,
 							MGMT_STATUS_BUSY);
 		goto unlock;
 	}
@@ -2446,35 +2279,26 @@ static int read_local_oob_data(struct sock *sk, u16 index)
 
 unlock:
 	hci_dev_unlock(hdev);
-	hci_dev_put(hdev);
-
 	return err;
 }
 
-static int add_remote_oob_data(struct sock *sk, u16 index, void *data,
-								u16 len)
+static int add_remote_oob_data(struct sock *sk, struct hci_dev *hdev,
+							void *data, u16 len)
 {
-	struct hci_dev *hdev;
 	struct mgmt_cp_add_remote_oob_data *cp = data;
 	u8 status;
 	int err;
 
-	BT_DBG("hci%u ", index);
+	BT_DBG("%s ", hdev->name);
 
 	if (len != sizeof(*cp))
-		return cmd_status(sk, index, MGMT_OP_ADD_REMOTE_OOB_DATA,
+		return cmd_status(sk, hdev->id, MGMT_OP_ADD_REMOTE_OOB_DATA,
 						MGMT_STATUS_INVALID_PARAMS);
 
-	hdev = hci_dev_get(index);
-	if (!hdev)
-		return cmd_complete(sk, index, MGMT_OP_ADD_REMOTE_OOB_DATA,
-						MGMT_STATUS_INVALID_PARAMS,
-						&cp->addr, sizeof(cp->addr));
-
 	hci_dev_lock(hdev);
 
 	if (!hdev_is_powered(hdev)) {
-		err = cmd_complete(sk, index, MGMT_OP_ADD_REMOTE_OOB_DATA,
+		err = cmd_complete(sk, hdev->id, MGMT_OP_ADD_REMOTE_OOB_DATA,
 						MGMT_STATUS_NOT_POWERED,
 						&cp->addr, sizeof(cp->addr));
 		goto unlock;
@@ -2487,42 +2311,34 @@ static int add_remote_oob_data(struct sock *sk, u16 index, void *data,
 	else
 		status = 0;
 
-	err = cmd_complete(sk, index, MGMT_OP_ADD_REMOTE_OOB_DATA, status,
+	err = cmd_complete(sk, hdev->id, MGMT_OP_ADD_REMOTE_OOB_DATA, status,
 						&cp->addr, sizeof(cp->addr));
 
 unlock:
 	hci_dev_unlock(hdev);
-	hci_dev_put(hdev);
-
 	return err;
 }
 
-static int remove_remote_oob_data(struct sock *sk, u16 index,
+static int remove_remote_oob_data(struct sock *sk, struct hci_dev *hdev,
 						void *data, u16 len)
 {
-	struct hci_dev *hdev;
 	struct mgmt_cp_remove_remote_oob_data *cp = data;
 	u8 status;
 	int err;
 
-	BT_DBG("hci%u ", index);
+	BT_DBG("%s", hdev->name);
 
 	if (len != sizeof(*cp))
-		return cmd_status(sk, index, MGMT_OP_REMOVE_REMOTE_OOB_DATA,
+		return cmd_status(sk, hdev->id, MGMT_OP_REMOVE_REMOTE_OOB_DATA,
 						MGMT_STATUS_INVALID_PARAMS);
 
-	hdev = hci_dev_get(index);
-	if (!hdev)
-		return cmd_complete(sk, index, MGMT_OP_REMOVE_REMOTE_OOB_DATA,
-						MGMT_STATUS_INVALID_PARAMS,
-						&cp->addr, sizeof(cp->addr));
-
 	hci_dev_lock(hdev);
 
 	if (!hdev_is_powered(hdev)) {
-		err = cmd_complete(sk, index, MGMT_OP_REMOVE_REMOTE_OOB_DATA,
-						MGMT_STATUS_NOT_POWERED,
-						&cp->addr, sizeof(cp->addr));
+		err = cmd_complete(sk, hdev->id,
+					MGMT_OP_REMOVE_REMOTE_OOB_DATA,
+					MGMT_STATUS_NOT_POWERED,
+					&cp->addr, sizeof(cp->addr));
 		goto unlock;
 	}
 
@@ -2532,13 +2348,11 @@ static int remove_remote_oob_data(struct sock *sk, u16 index,
 	else
 		status = 0;
 
-	err = cmd_complete(sk, index, MGMT_OP_REMOVE_REMOTE_OOB_DATA, status,
-						&cp->addr, sizeof(cp->addr));
+	err = cmd_complete(sk, hdev->id, MGMT_OP_REMOVE_REMOTE_OOB_DATA,
+					status, &cp->addr, sizeof(cp->addr));
 
 unlock:
 	hci_dev_unlock(hdev);
-	hci_dev_put(hdev);
-
 	return err;
 }
 
@@ -2559,36 +2373,30 @@ int mgmt_interleaved_discovery(struct hci_dev *hdev)
 	return err;
 }
 
-static int start_discovery(struct sock *sk, u16 index,
+static int start_discovery(struct sock *sk, struct hci_dev *hdev,
 						void *data, u16 len)
 {
 	struct mgmt_cp_start_discovery *cp = data;
 	struct pending_cmd *cmd;
-	struct hci_dev *hdev;
 	int err;
 
-	BT_DBG("hci%u", index);
+	BT_DBG("%s", hdev->name);
 
 	if (len != sizeof(*cp))
-		return cmd_status(sk, index, MGMT_OP_START_DISCOVERY,
-						MGMT_STATUS_INVALID_PARAMS);
-
-	hdev = hci_dev_get(index);
-	if (!hdev)
-		return cmd_status(sk, index, MGMT_OP_START_DISCOVERY,
+		return cmd_status(sk, hdev->id, MGMT_OP_START_DISCOVERY,
 						MGMT_STATUS_INVALID_PARAMS);
 
 	hci_dev_lock(hdev);
 
 	if (!hdev_is_powered(hdev)) {
-		err = cmd_status(sk, index, MGMT_OP_START_DISCOVERY,
+		err = cmd_status(sk, hdev->id, MGMT_OP_START_DISCOVERY,
 						MGMT_STATUS_NOT_POWERED);
 		goto failed;
 	}
 
 	if (hdev->discovery.state != DISCOVERY_STOPPED) {
-		err = cmd_status(sk, index, MGMT_OP_START_DISCOVERY,
-						MGMT_STATUS_BUSY);
+		err = cmd_status(sk, hdev->id, MGMT_OP_START_DISCOVERY,
+							MGMT_STATUS_BUSY);
 		goto failed;
 	}
 
@@ -2635,42 +2443,35 @@ static int start_discovery(struct sock *sk, u16 index,
 
 failed:
 	hci_dev_unlock(hdev);
-	hci_dev_put(hdev);
-
 	return err;
 }
 
-static int stop_discovery(struct sock *sk, u16 index, void *data, u16 len)
+static int stop_discovery(struct sock *sk, struct hci_dev *hdev, void *data,
+								u16 len)
 {
 	struct mgmt_cp_stop_discovery *mgmt_cp = data;
-	struct hci_dev *hdev;
 	struct pending_cmd *cmd;
 	struct hci_cp_remote_name_req_cancel cp;
 	struct inquiry_entry *e;
 	int err;
 
-	BT_DBG("hci%u", index);
+	BT_DBG("%s", hdev->name);
 
 	if (len != sizeof(*mgmt_cp))
-		return cmd_status(sk, index, MGMT_OP_STOP_DISCOVERY,
-						MGMT_STATUS_INVALID_PARAMS);
-
-	hdev = hci_dev_get(index);
-	if (!hdev)
-		return cmd_status(sk, index, MGMT_OP_STOP_DISCOVERY,
+		return cmd_status(sk, hdev->id, MGMT_OP_STOP_DISCOVERY,
 						MGMT_STATUS_INVALID_PARAMS);
 
 	hci_dev_lock(hdev);
 
 	if (!hci_discovery_active(hdev)) {
-		err = cmd_complete(sk, index, MGMT_OP_STOP_DISCOVERY,
+		err = cmd_complete(sk, hdev->id, MGMT_OP_STOP_DISCOVERY,
 					MGMT_STATUS_REJECTED,
 					&mgmt_cp->type, sizeof(mgmt_cp->type));
 		goto unlock;
 	}
 
 	if (hdev->discovery.type != mgmt_cp->type) {
-		err = cmd_complete(sk, index, MGMT_OP_STOP_DISCOVERY,
+		err = cmd_complete(sk, hdev->id, MGMT_OP_STOP_DISCOVERY,
 					MGMT_STATUS_INVALID_PARAMS,
 					&mgmt_cp->type, sizeof(mgmt_cp->type));
 		goto unlock;
@@ -2694,7 +2495,7 @@ static int stop_discovery(struct sock *sk, u16 index, void *data, u16 len)
 	e = hci_inquiry_cache_lookup_resolve(hdev, BDADDR_ANY, NAME_PENDING);
 	if (!e) {
 		mgmt_pending_remove(cmd);
-		err = cmd_complete(sk, index, MGMT_OP_STOP_DISCOVERY, 0,
+		err = cmd_complete(sk, hdev->id, MGMT_OP_STOP_DISCOVERY, 0,
 					&mgmt_cp->type, sizeof(mgmt_cp->type));
 		hci_discovery_set_state(hdev, DISCOVERY_STOPPED);
 		goto unlock;
@@ -2710,41 +2511,34 @@ static int stop_discovery(struct sock *sk, u16 index, void *data, u16 len)
 
 unlock:
 	hci_dev_unlock(hdev);
-	hci_dev_put(hdev);
-
 	return err;
 }
 
-static int confirm_name(struct sock *sk, u16 index, void *data, u16 len)
+static int confirm_name(struct sock *sk, struct hci_dev *hdev, void *data,
+								u16 len)
 {
 	struct mgmt_cp_confirm_name *cp = data;
 	struct inquiry_entry *e;
-	struct hci_dev *hdev;
 	int err;
 
-	BT_DBG("hci%u", index);
+	BT_DBG("%s", hdev->name);
 
 	if (len != sizeof(*cp))
-		return cmd_status(sk, index, MGMT_OP_CONFIRM_NAME,
-				MGMT_STATUS_INVALID_PARAMS);
-
-	hdev = hci_dev_get(index);
-	if (!hdev)
-		return cmd_status(sk, index, MGMT_OP_CONFIRM_NAME,
-				MGMT_STATUS_INVALID_PARAMS);
+		return cmd_status(sk, hdev->id, MGMT_OP_CONFIRM_NAME,
+						MGMT_STATUS_INVALID_PARAMS);
 
 	hci_dev_lock(hdev);
 
 	if (!hci_discovery_active(hdev)) {
-		err = cmd_status(sk, index, MGMT_OP_CONFIRM_NAME,
+		err = cmd_status(sk, hdev->id, MGMT_OP_CONFIRM_NAME,
 							MGMT_STATUS_FAILED);
 		goto failed;
 	}
 
 	e = hci_inquiry_cache_lookup_unknown(hdev, &cp->addr.bdaddr);
 	if (!e) {
-		err = cmd_status(sk, index, MGMT_OP_CONFIRM_NAME,
-				MGMT_STATUS_INVALID_PARAMS);
+		err = cmd_status(sk, hdev->id, MGMT_OP_CONFIRM_NAME,
+						MGMT_STATUS_INVALID_PARAMS);
 		goto failed;
 	}
 
@@ -2760,29 +2554,22 @@ static int confirm_name(struct sock *sk, u16 index, void *data, u16 len)
 
 failed:
 	hci_dev_unlock(hdev);
-
 	return err;
 }
 
-static int block_device(struct sock *sk, u16 index, void *data, u16 len)
+static int block_device(struct sock *sk, struct hci_dev *hdev, void *data,
+								u16 len)
 {
-	struct hci_dev *hdev;
 	struct mgmt_cp_block_device *cp = data;
 	u8 status;
 	int err;
 
-	BT_DBG("hci%u", index);
+	BT_DBG("%s", hdev->name);
 
 	if (len != sizeof(*cp))
-		return cmd_status(sk, index, MGMT_OP_BLOCK_DEVICE,
+		return cmd_status(sk, hdev->id, MGMT_OP_BLOCK_DEVICE,
 						MGMT_STATUS_INVALID_PARAMS);
 
-	hdev = hci_dev_get(index);
-	if (!hdev)
-		return cmd_complete(sk, index, MGMT_OP_BLOCK_DEVICE,
-						MGMT_STATUS_INVALID_PARAMS,
-						&cp->addr, sizeof(cp->addr));
-
 	hci_dev_lock(hdev);
 
 	err = hci_blacklist_add(hdev, &cp->addr.bdaddr, cp->addr.type);
@@ -2791,34 +2578,27 @@ static int block_device(struct sock *sk, u16 index, void *data, u16 len)
 	else
 		status = 0;
 
-	err = cmd_complete(sk, index, MGMT_OP_BLOCK_DEVICE, status,
+	err = cmd_complete(sk, hdev->id, MGMT_OP_BLOCK_DEVICE, status,
 						&cp->addr, sizeof(cp->addr));
 
 	hci_dev_unlock(hdev);
-	hci_dev_put(hdev);
 
 	return err;
 }
 
-static int unblock_device(struct sock *sk, u16 index, void *data, u16 len)
+static int unblock_device(struct sock *sk, struct hci_dev *hdev, void *data,
+								u16 len)
 {
-	struct hci_dev *hdev;
 	struct mgmt_cp_unblock_device *cp = data;
 	u8 status;
 	int err;
 
-	BT_DBG("hci%u", index);
+	BT_DBG("%s", hdev->name);
 
 	if (len != sizeof(*cp))
-		return cmd_status(sk, index, MGMT_OP_UNBLOCK_DEVICE,
+		return cmd_status(sk, hdev->id, MGMT_OP_UNBLOCK_DEVICE,
 						MGMT_STATUS_INVALID_PARAMS);
 
-	hdev = hci_dev_get(index);
-	if (!hdev)
-		return cmd_complete(sk, index, MGMT_OP_UNBLOCK_DEVICE,
-						MGMT_STATUS_INVALID_PARAMS,
-						&cp->addr, sizeof(cp->addr));
-
 	hci_dev_lock(hdev);
 
 	err = hci_blacklist_del(hdev, &cp->addr.bdaddr, cp->addr.type);
@@ -2827,41 +2607,35 @@ static int unblock_device(struct sock *sk, u16 index, void *data, u16 len)
 	else
 		status = 0;
 
-	err = cmd_complete(sk, index, MGMT_OP_UNBLOCK_DEVICE, status,
+	err = cmd_complete(sk, hdev->id, MGMT_OP_UNBLOCK_DEVICE, status,
 						&cp->addr, sizeof(cp->addr));
 
 	hci_dev_unlock(hdev);
-	hci_dev_put(hdev);
 
 	return err;
 }
 
-static int set_fast_connectable(struct sock *sk, u16 index,
-					void *data, u16 len)
+static int set_fast_connectable(struct sock *sk, struct hci_dev *hdev,
+							void *data, u16 len)
 {
-	struct hci_dev *hdev;
 	struct mgmt_mode *cp = data;
 	struct hci_cp_write_page_scan_activity acp;
 	u8 type;
 	int err;
 
-	BT_DBG("hci%u", index);
+	BT_DBG("%s", hdev->name);
 
 	if (len != sizeof(*cp))
-		return cmd_status(sk, index, MGMT_OP_SET_FAST_CONNECTABLE,
+		return cmd_status(sk, hdev->id, MGMT_OP_SET_FAST_CONNECTABLE,
 						MGMT_STATUS_INVALID_PARAMS);
 
-	hdev = hci_dev_get(index);
-	if (!hdev)
-		return cmd_status(sk, index, MGMT_OP_SET_FAST_CONNECTABLE,
-						MGMT_STATUS_INVALID_PARAMS);
 	if (!hdev_is_powered(hdev))
-		return cmd_status(sk, index, MGMT_OP_SET_FAST_CONNECTABLE,
+		return cmd_status(sk, hdev->id, MGMT_OP_SET_FAST_CONNECTABLE,
 						MGMT_STATUS_NOT_POWERED);
 
 	if (!test_bit(HCI_CONNECTABLE, &hdev->dev_flags))
-		return cmd_status(sk, index, MGMT_OP_SET_FAST_CONNECTABLE,
-							MGMT_STATUS_REJECTED);
+		return cmd_status(sk, hdev->id, MGMT_OP_SET_FAST_CONNECTABLE,
+						MGMT_STATUS_REJECTED);
 
 	hci_dev_lock(hdev);
 
@@ -2878,37 +2652,34 @@ static int set_fast_connectable(struct sock *sk, u16 index,
 	err = hci_send_cmd(hdev, HCI_OP_WRITE_PAGE_SCAN_ACTIVITY,
 						sizeof(acp), &acp);
 	if (err < 0) {
-		err = cmd_status(sk, index, MGMT_OP_SET_FAST_CONNECTABLE,
-							MGMT_STATUS_FAILED);
+		err = cmd_status(sk, hdev->id, MGMT_OP_SET_FAST_CONNECTABLE,
+						MGMT_STATUS_FAILED);
 		goto done;
 	}
 
 	err = hci_send_cmd(hdev, HCI_OP_WRITE_PAGE_SCAN_TYPE, 1, &type);
 	if (err < 0) {
-		err = cmd_status(sk, index, MGMT_OP_SET_FAST_CONNECTABLE,
-							MGMT_STATUS_FAILED);
+		err = cmd_status(sk, hdev->id, MGMT_OP_SET_FAST_CONNECTABLE,
+						MGMT_STATUS_FAILED);
 		goto done;
 	}
 
-	err = cmd_complete(sk, index, MGMT_OP_SET_FAST_CONNECTABLE, 0,
+	err = cmd_complete(sk, hdev->id, MGMT_OP_SET_FAST_CONNECTABLE, 0,
 								NULL, 0);
 done:
 	hci_dev_unlock(hdev);
-	hci_dev_put(hdev);
-
 	return err;
 }
 
-static int load_long_term_keys(struct sock *sk, u16 index,
+static int load_long_term_keys(struct sock *sk, struct hci_dev *hdev,
 					void *cp_data, u16 len)
 {
-	struct hci_dev *hdev;
 	struct mgmt_cp_load_long_term_keys *cp = cp_data;
 	u16 key_count, expected_len;
 	int i;
 
 	if (len < sizeof(*cp))
-		return cmd_status(sk, index, MGMT_OP_LOAD_LONG_TERM_KEYS,
+		return cmd_status(sk, hdev->id, MGMT_OP_LOAD_LONG_TERM_KEYS,
 								EINVAL);
 
 	key_count = get_unaligned_le16(&cp->key_count);
@@ -2918,16 +2689,11 @@ static int load_long_term_keys(struct sock *sk, u16 index,
 	if (expected_len != len) {
 		BT_ERR("load_keys: expected %u bytes, got %u bytes",
 							len, expected_len);
-		return cmd_status(sk, index, MGMT_OP_LOAD_LONG_TERM_KEYS,
+		return cmd_status(sk, hdev->id, MGMT_OP_LOAD_LONG_TERM_KEYS,
 								EINVAL);
 	}
 
-	hdev = hci_dev_get(index);
-	if (!hdev)
-		return cmd_status(sk, index, MGMT_OP_LOAD_LONG_TERM_KEYS,
-								ENODEV);
-
-	BT_DBG("hci%u key_count %u", index, key_count);
+	BT_DBG("%s key_count %u", hdev->name, key_count);
 
 	hci_dev_lock(hdev);
 
@@ -2948,7 +2714,6 @@ static int load_long_term_keys(struct sock *sk, u16 index,
 	}
 
 	hci_dev_unlock(hdev);
-	hci_dev_put(hdev);
 
 	return 0;
 }
@@ -2959,6 +2724,7 @@ int mgmt_control(struct sock *sk, struct msghdr *msg, size_t msglen)
 	u8 *cp;
 	struct mgmt_hdr *hdr;
 	u16 opcode, index, len;
+	struct hci_dev *hdev = NULL;
 	int err;
 
 	BT_DBG("got %zu bytes", msglen);
@@ -2985,6 +2751,21 @@ int mgmt_control(struct sock *sk, struct msghdr *msg, size_t msglen)
 		goto done;
 	}
 
+	if (opcode < MGMT_OP_READ_INFO) {
+		if (index != MGMT_INDEX_NONE) {
+			err = cmd_status(sk, index, opcode,
+						MGMT_STATUS_INVALID_PARAMS);
+			goto done;
+		}
+	} else {
+		hdev = hci_dev_get(index);
+		if (!hdev) {
+			err = cmd_status(sk, index, opcode,
+						MGMT_STATUS_INVALID_PARAMS);
+			goto done;
+		}
+	}
+
 	cp = buf + sizeof(*hdr);
 
 	switch (opcode) {
@@ -2998,112 +2779,112 @@ int mgmt_control(struct sock *sk, struct msghdr *msg, size_t msglen)
 		err = read_index_list(sk);
 		break;
 	case MGMT_OP_READ_INFO:
-		err = read_controller_info(sk, index);
+		err = read_controller_info(sk, hdev);
 		break;
 	case MGMT_OP_SET_POWERED:
-		err = set_powered(sk, index, cp, len);
+		err = set_powered(sk, hdev, cp, len);
 		break;
 	case MGMT_OP_SET_DISCOVERABLE:
-		err = set_discoverable(sk, index, cp, len);
+		err = set_discoverable(sk, hdev, cp, len);
 		break;
 	case MGMT_OP_SET_CONNECTABLE:
-		err = set_connectable(sk, index, cp, len);
+		err = set_connectable(sk, hdev, cp, len);
 		break;
 	case MGMT_OP_SET_FAST_CONNECTABLE:
-		err = set_fast_connectable(sk, index, cp, len);
+		err = set_fast_connectable(sk, hdev, cp, len);
 		break;
 	case MGMT_OP_SET_PAIRABLE:
-		err = set_pairable(sk, index, cp, len);
+		err = set_pairable(sk, hdev, cp, len);
 		break;
 	case MGMT_OP_SET_LINK_SECURITY:
-		err = set_link_security(sk, index, cp, len);
+		err = set_link_security(sk, hdev, cp, len);
 		break;
 	case MGMT_OP_SET_SSP:
-		err = set_ssp(sk, index, cp, len);
+		err = set_ssp(sk, hdev, cp, len);
 		break;
 	case MGMT_OP_SET_HS:
-		err = set_hs(sk, index, cp, len);
+		err = set_hs(sk, hdev, cp, len);
 		break;
 	case MGMT_OP_SET_LE:
-		err = set_le(sk, index, cp, len);
+		err = set_le(sk, hdev, cp, len);
 		break;
 	case MGMT_OP_ADD_UUID:
-		err = add_uuid(sk, index, cp, len);
+		err = add_uuid(sk, hdev, cp, len);
 		break;
 	case MGMT_OP_REMOVE_UUID:
-		err = remove_uuid(sk, index, cp, len);
+		err = remove_uuid(sk, hdev, cp, len);
 		break;
 	case MGMT_OP_SET_DEV_CLASS:
-		err = set_dev_class(sk, index, cp, len);
+		err = set_dev_class(sk, hdev, cp, len);
 		break;
 	case MGMT_OP_LOAD_LINK_KEYS:
-		err = load_link_keys(sk, index, cp, len);
+		err = load_link_keys(sk, hdev, cp, len);
 		break;
 	case MGMT_OP_DISCONNECT:
-		err = disconnect(sk, index, cp, len);
+		err = disconnect(sk, hdev, cp, len);
 		break;
 	case MGMT_OP_GET_CONNECTIONS:
-		err = get_connections(sk, index);
+		err = get_connections(sk, hdev);
 		break;
 	case MGMT_OP_PIN_CODE_REPLY:
-		err = pin_code_reply(sk, index, cp, len);
+		err = pin_code_reply(sk, hdev, cp, len);
 		break;
 	case MGMT_OP_PIN_CODE_NEG_REPLY:
-		err = pin_code_neg_reply(sk, index, cp, len);
+		err = pin_code_neg_reply(sk, hdev, cp, len);
 		break;
 	case MGMT_OP_SET_IO_CAPABILITY:
-		err = set_io_capability(sk, index, cp, len);
+		err = set_io_capability(sk, hdev, cp, len);
 		break;
 	case MGMT_OP_PAIR_DEVICE:
-		err = pair_device(sk, index, cp, len);
+		err = pair_device(sk, hdev, cp, len);
 		break;
 	case MGMT_OP_CANCEL_PAIR_DEVICE:
-		err = cancel_pair_device(sk, index, buf + sizeof(*hdr), len);
+		err = cancel_pair_device(sk, hdev, buf + sizeof(*hdr), len);
 		break;
 	case MGMT_OP_UNPAIR_DEVICE:
-		err = unpair_device(sk, index, cp, len);
+		err = unpair_device(sk, hdev, cp, len);
 		break;
 	case MGMT_OP_USER_CONFIRM_REPLY:
-		err = user_confirm_reply(sk, index, cp, len);
+		err = user_confirm_reply(sk, hdev, cp, len);
 		break;
 	case MGMT_OP_USER_CONFIRM_NEG_REPLY:
-		err = user_confirm_neg_reply(sk, index, cp, len);
+		err = user_confirm_neg_reply(sk, hdev, cp, len);
 		break;
 	case MGMT_OP_USER_PASSKEY_REPLY:
-		err = user_passkey_reply(sk, index, cp, len);
+		err = user_passkey_reply(sk, hdev, cp, len);
 		break;
 	case MGMT_OP_USER_PASSKEY_NEG_REPLY:
-		err = user_passkey_neg_reply(sk, index, cp, len);
+		err = user_passkey_neg_reply(sk, hdev, cp, len);
 		break;
 	case MGMT_OP_SET_LOCAL_NAME:
-		err = set_local_name(sk, index, cp, len);
+		err = set_local_name(sk, hdev, cp, len);
 		break;
 	case MGMT_OP_READ_LOCAL_OOB_DATA:
-		err = read_local_oob_data(sk, index);
+		err = read_local_oob_data(sk, hdev);
 		break;
 	case MGMT_OP_ADD_REMOTE_OOB_DATA:
-		err = add_remote_oob_data(sk, index, cp, len);
+		err = add_remote_oob_data(sk, hdev, cp, len);
 		break;
 	case MGMT_OP_REMOVE_REMOTE_OOB_DATA:
-		err = remove_remote_oob_data(sk, index, cp, len);
+		err = remove_remote_oob_data(sk, hdev, cp, len);
 		break;
 	case MGMT_OP_START_DISCOVERY:
-		err = start_discovery(sk, index, cp, len);
+		err = start_discovery(sk, hdev, cp, len);
 		break;
 	case MGMT_OP_STOP_DISCOVERY:
-		err = stop_discovery(sk, index, cp, len);
+		err = stop_discovery(sk, hdev, cp, len);
 		break;
 	case MGMT_OP_CONFIRM_NAME:
-		err = confirm_name(sk, index, cp, len);
+		err = confirm_name(sk, hdev, cp, len);
 		break;
 	case MGMT_OP_BLOCK_DEVICE:
-		err = block_device(sk, index, cp, len);
+		err = block_device(sk, hdev, cp, len);
 		break;
 	case MGMT_OP_UNBLOCK_DEVICE:
-		err = unblock_device(sk, index, cp, len);
+		err = unblock_device(sk, hdev, cp, len);
 		break;
 	case MGMT_OP_LOAD_LONG_TERM_KEYS:
-		err = load_long_term_keys(sk, index, cp, len);
+		err = load_long_term_keys(sk, hdev, cp, len);
 		break;
 	default:
 		BT_DBG("Unknown op %u", opcode);
@@ -3118,6 +2899,9 @@ int mgmt_control(struct sock *sk, struct msghdr *msg, size_t msglen)
 	err = msglen;
 
 done:
+	if (hdev)
+		hci_dev_put(hdev);
+
 	kfree(buf);
 	return err;
 }
-- 
1.7.9.1

