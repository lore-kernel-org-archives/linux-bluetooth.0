Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 2/2] Bluetooth: Add management command for setting LE scan parameters
Date: Fri, 11 Oct 2013 08:23:20 -0700
Message-Id: <1381505000-50787-2-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The scan interval and window parameters are used for LE passive
background scanning and connection establishment. This allows
userspace to change the values.

These two values should be kept in sync with whatever is used for
the scan parameters service on remote devices. And it puts the
controlling daemon (for example bluetoothd) in charge of setting
the values.

Main use case would be to switch between two sets of values. One
for foreground applications and one for background applications.

At this moment, the values are only used for manual connection
establishment, but soon that should be extended to background
scanning and automatic connection establishment.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 include/net/bluetooth/mgmt.h |  7 +++++++
 net/bluetooth/mgmt.c         | 38 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 45 insertions(+)

diff --git a/include/net/bluetooth/mgmt.h b/include/net/bluetooth/mgmt.h
index 2ad433bb..518c5c8 100644
--- a/include/net/bluetooth/mgmt.h
+++ b/include/net/bluetooth/mgmt.h
@@ -362,6 +362,13 @@ struct mgmt_cp_set_static_address {
 } __packed;
 #define MGMT_SET_STATIC_ADDRESS_SIZE	6
 
+#define MGMT_OP_SET_SCAN_PARAMS		0x002C
+struct mgmt_cp_set_scan_params {
+	__le16	interval;
+	__le16	window;
+} __packed;
+#define MGMT_SET_SCAN_PARAMS_SIZE	4
+
 #define MGMT_EV_CMD_COMPLETE		0x0001
 struct mgmt_ev_cmd_complete {
 	__le16	opcode;
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 143dd73..f57ec19 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -3374,6 +3374,43 @@ static int set_static_address(struct sock *sk, struct hci_dev *hdev,
 	return err;
 }
 
+static int set_scan_params(struct sock *sk, struct hci_dev *hdev,
+			   void *data, u16 len)
+{
+	struct mgmt_cp_set_scan_params *cp = data;
+	__u16 interval, window;
+	int err;
+
+	BT_DBG("%s", hdev->name);
+
+	if (!lmp_le_capable(hdev))
+		return cmd_status(sk, hdev->id, MGMT_OP_SET_SCAN_PARAMS,
+				  MGMT_STATUS_NOT_SUPPORTED);
+
+	interval = __le16_to_cpu(cp->interval);
+
+	if (interval < 0x0004 || interval > 0x4000)
+		return cmd_status(sk, hdev->id, MGMT_OP_SET_SCAN_PARAMS,
+				  MGMT_STATUS_INVALID_PARAMS);
+
+	window = __le16_to_cpu(cp->window);
+
+	if (window < 0x0004 || window > 0x4000)
+		return cmd_status(sk, hdev->id, MGMT_OP_SET_SCAN_PARAMS,
+				  MGMT_STATUS_INVALID_PARAMS);
+
+	hci_dev_lock(hdev);
+
+	hdev->le_scan_interval = interval;
+	hdev->le_scan_window = window;
+
+	err = cmd_complete(sk, hdev->id, MGMT_OP_SET_SCAN_PARAMS, 0, NULL, 0);
+
+	hci_dev_unlock(hdev);
+
+	return err;
+}
+
 static void fast_connectable_complete(struct hci_dev *hdev, u8 status)
 {
 	struct pending_cmd *cmd;
@@ -3710,6 +3747,7 @@ static const struct mgmt_handler {
 	{ set_advertising,        false, MGMT_SETTING_SIZE },
 	{ set_bredr,              false, MGMT_SETTING_SIZE },
 	{ set_static_address,     false, MGMT_SET_STATIC_ADDRESS_SIZE },
+	{ set_scan_params,        false, MGMT_SET_SCAN_PARAMS_SIZE },
 };
 
 
-- 
1.8.3.1

