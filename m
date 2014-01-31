Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/3] Bluetooth: Add management command to allow use of debug keys
Date: Fri, 31 Jan 2014 11:55:22 -0800
Message-Id: <1391198123-55506-2-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Originally allowing the use of debug keys was done via the Load Link
Keys management command. However this is BR/EDR specific and to be
flexible and allow extending this to LE as well, make this an independent
command.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 include/net/bluetooth/mgmt.h |  2 ++
 net/bluetooth/mgmt.c         | 34 ++++++++++++++++++++++++++++++++++
 2 files changed, 36 insertions(+)

diff --git a/include/net/bluetooth/mgmt.h b/include/net/bluetooth/mgmt.h
index f87f5d784c3b..dfab094fab73 100644
--- a/include/net/bluetooth/mgmt.h
+++ b/include/net/bluetooth/mgmt.h
@@ -387,6 +387,8 @@ struct mgmt_cp_set_scan_params {
 
 #define MGMT_OP_SET_SECURE_CONN		0x002D
 
+#define MGMT_OP_SET_DEBUG_KEYS		0x002E
+
 #define MGMT_EV_CMD_COMPLETE		0x0001
 struct mgmt_ev_cmd_complete {
 	__le16	opcode;
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 91ffecd1727e..70a3a7e917b7 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -80,6 +80,7 @@ static const u16 mgmt_commands[] = {
 	MGMT_OP_SET_STATIC_ADDRESS,
 	MGMT_OP_SET_SCAN_PARAMS,
 	MGMT_OP_SET_SECURE_CONN,
+	MGMT_OP_SET_DEBUG_KEYS,
 };
 
 static const u16 mgmt_events[] = {
@@ -4111,6 +4112,38 @@ failed:
 	return err;
 }
 
+static int set_debug_keys(struct sock *sk, struct hci_dev *hdev,
+			  void *data, u16 len)
+{
+	struct mgmt_mode *cp = data;
+	bool changed;
+	int err;
+
+	BT_DBG("request for %s", hdev->name);
+
+	if (cp->val != 0x00 && cp->val != 0x01)
+		return cmd_status(sk, hdev->id, MGMT_OP_SET_DEBUG_KEYS,
+				  MGMT_STATUS_INVALID_PARAMS);
+
+	hci_dev_lock(hdev);
+
+	if (cp->val)
+		changed = !test_and_set_bit(HCI_DEBUG_KEYS, &hdev->dev_flags);
+	else
+		changed = test_and_clear_bit(HCI_DEBUG_KEYS, &hdev->dev_flags);
+
+	err = send_settings_rsp(sk, MGMT_OP_SET_DEBUG_KEYS, hdev);
+	if (err < 0)
+		goto unlock;
+
+	if (changed)
+		err = new_settings(hdev, sk);
+
+unlock:
+	hci_dev_unlock(hdev);
+	return err;
+}
+
 static bool ltk_is_valid(struct mgmt_ltk_info *key)
 {
 	if (key->authenticated != 0x00 && key->authenticated != 0x01)
@@ -4240,6 +4273,7 @@ static const struct mgmt_handler {
 	{ set_static_address,     false, MGMT_SET_STATIC_ADDRESS_SIZE },
 	{ set_scan_params,        false, MGMT_SET_SCAN_PARAMS_SIZE },
 	{ set_secure_conn,        false, MGMT_SETTING_SIZE },
+	{ set_debug_keys,         false, MGMT_SETTING_SIZE },
 };
 
 
-- 
1.8.5.3

