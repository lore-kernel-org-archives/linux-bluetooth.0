Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 7/7] Bluetooth: Add new mgmt_set_advertising command
Date: Wed, 25 Sep 2013 13:26:10 +0300
Message-Id: <1380104770-8022-8-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1380104770-8022-1-git-send-email-johan.hedberg@gmail.com>
References: <1380104770-8022-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

This patch adds a new mgmt command for enabling and disabling
LE advertising. The command depends on the LE setting being enabled
first and will return a "rejected" response otherwise. The patch also
adds safeguards so that there will ever only be one set_le or
set_advertising command pending per adapter.

The response handling and new_settings event sending is done in an
asynchronous request callback, meaning raw HCI access from user space to
enable advertising (e.g. hciconfig leadv) will not trigger the
new_settings event. This is intentional since trying to support mixed
raw HCI and mgmt access would mean adding extra state tracking or new
helper functions, essentially negating the benefit of using the
asynchronous request framework. The HCI_LE_ENABLED and HCI_LE_PERIPHERAL
flags however are updated correctly even with raw HCI access so this
will not completely break subsequent access over mgmt.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 include/net/bluetooth/mgmt.h |  2 +
 net/bluetooth/mgmt.c         | 97 +++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 98 insertions(+), 1 deletion(-)

diff --git a/include/net/bluetooth/mgmt.h b/include/net/bluetooth/mgmt.h
index 6cc72b6..421d763 100644
--- a/include/net/bluetooth/mgmt.h
+++ b/include/net/bluetooth/mgmt.h
@@ -352,6 +352,8 @@ struct mgmt_cp_set_device_id {
 } __packed;
 #define MGMT_SET_DEVICE_ID_SIZE		8
 
+#define MGMT_OP_SET_ADVERTISING		0x0029
+
 #define MGMT_EV_CMD_COMPLETE		0x0001
 struct mgmt_ev_cmd_complete {
 	__le16	opcode;
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 9a2faa3..1b5b10f 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -76,6 +76,7 @@ static const u16 mgmt_commands[] = {
 	MGMT_OP_BLOCK_DEVICE,
 	MGMT_OP_UNBLOCK_DEVICE,
 	MGMT_OP_SET_DEVICE_ID,
+	MGMT_OP_SET_ADVERTISING,
 };
 
 static const u16 mgmt_events[] = {
@@ -1431,7 +1432,8 @@ static int set_le(struct sock *sk, struct hci_dev *hdev, void *data, u16 len)
 		goto unlock;
 	}
 
-	if (mgmt_pending_find(MGMT_OP_SET_LE, hdev)) {
+	if (mgmt_pending_find(MGMT_OP_SET_LE, hdev) ||
+	    mgmt_pending_find(MGMT_OP_SET_ADVERTISING, hdev)) {
 		err = cmd_status(sk, hdev->id, MGMT_OP_SET_LE,
 				 MGMT_STATUS_BUSY);
 		goto unlock;
@@ -3136,6 +3138,98 @@ static int set_device_id(struct sock *sk, struct hci_dev *hdev, void *data,
 	return err;
 }
 
+static void set_advertising_complete(struct hci_dev *hdev, u8 status)
+{
+	struct cmd_lookup match = { NULL, hdev };
+
+	if (status) {
+		u8 mgmt_err = mgmt_status(status);
+
+		mgmt_pending_foreach(MGMT_OP_SET_ADVERTISING, hdev,
+				     cmd_status_rsp, &mgmt_err);
+		return;
+	}
+
+	mgmt_pending_foreach(MGMT_OP_SET_ADVERTISING, hdev, settings_rsp,
+			     &match);
+
+	new_settings(hdev, match.sk);
+
+	if (match.sk)
+		sock_put(match.sk);
+}
+
+static int set_advertising(struct sock *sk, struct hci_dev *hdev, void *data, u16 len)
+{
+	struct mgmt_mode *cp = data;
+	struct pending_cmd *cmd;
+	struct hci_request req;
+	u8 val, enabled;
+	int err;
+
+	BT_DBG("request for %s", hdev->name);
+
+	if (!lmp_le_capable(hdev))
+		return cmd_status(sk, hdev->id, MGMT_OP_SET_ADVERTISING,
+				  MGMT_STATUS_NOT_SUPPORTED);
+
+	if (!test_bit(HCI_LE_ENABLED, &hdev->dev_flags))
+		return cmd_status(sk, hdev->id, MGMT_OP_SET_ADVERTISING,
+				  MGMT_STATUS_REJECTED);
+
+	if (cp->val != 0x00 && cp->val != 0x01)
+		return cmd_status(sk, hdev->id, MGMT_OP_SET_ADVERTISING,
+				  MGMT_STATUS_INVALID_PARAMS);
+
+	hci_dev_lock(hdev);
+
+	val = !!cp->val;
+	enabled = test_bit(HCI_LE_PERIPHERAL, &hdev->dev_flags);
+
+	if (!hdev_is_powered(hdev) || val == enabled) {
+		bool changed = false;
+
+		if (val != test_bit(HCI_LE_PERIPHERAL, &hdev->dev_flags)) {
+			change_bit(HCI_LE_PERIPHERAL, &hdev->dev_flags);
+			changed = true;
+		}
+
+		err = send_settings_rsp(sk, MGMT_OP_SET_ADVERTISING, hdev);
+		if (err < 0)
+			goto unlock;
+
+		if (changed)
+			err = new_settings(hdev, sk);
+
+		goto unlock;
+	}
+
+	if (mgmt_pending_find(MGMT_OP_SET_ADVERTISING, hdev) ||
+	    mgmt_pending_find(MGMT_OP_SET_LE, hdev)) {
+		err = cmd_status(sk, hdev->id, MGMT_OP_SET_ADVERTISING,
+				 MGMT_STATUS_BUSY);
+		goto unlock;
+	}
+
+	cmd = mgmt_pending_add(sk, MGMT_OP_SET_ADVERTISING, hdev, data, len);
+	if (!cmd) {
+		err = -ENOMEM;
+		goto unlock;
+	}
+
+	hci_req_init(&req, hdev);
+
+	hci_req_add(&req, HCI_OP_LE_SET_ADV_ENABLE, sizeof(val), &val);
+
+	err = hci_req_run(&req, set_advertising_complete);
+	if (err < 0)
+		mgmt_pending_remove(cmd);
+
+unlock:
+	hci_dev_unlock(hdev);
+	return err;
+}
+
 static void fast_connectable_complete(struct hci_dev *hdev, u8 status)
 {
 	struct pending_cmd *cmd;
@@ -3347,6 +3441,7 @@ static const struct mgmt_handler {
 	{ block_device,           false, MGMT_BLOCK_DEVICE_SIZE },
 	{ unblock_device,         false, MGMT_UNBLOCK_DEVICE_SIZE },
 	{ set_device_id,          false, MGMT_SET_DEVICE_ID_SIZE },
+	{ set_advertising,        false, MGMT_SETTING_SIZE },
 };
 
 
-- 
1.8.3.1

