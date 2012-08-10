Return-Path: <cyrus@holtmann.org>
From: Jefferson Delfes <jefferson.delfes@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Jefferson Delfes <jefferson.delfes@openbossa.org>
Subject: [RFC 5/5] Bluetooth: Add set observer MGMT command
Date: Fri, 10 Aug 2012 17:01:47 -0400
Message-Id: <1344632507-21381-6-git-send-email-jefferson.delfes@openbossa.org>
In-Reply-To: <1344632507-21381-1-git-send-email-jefferson.delfes@openbossa.org>
References: <1344632507-21381-1-git-send-email-jefferson.delfes@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This command will enable or disable observer mode. In that mode,
discovery will be started, so any broadcast will be received in device
found event.

Signed-off-by: Jefferson Delfes <jefferson.delfes@openbossa.org>
---
 include/net/bluetooth/hci.h  |  1 +
 include/net/bluetooth/mgmt.h |  3 +++
 net/bluetooth/mgmt.c         | 43 +++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 47 insertions(+)

diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index 80f585a..17ea1ad 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -119,6 +119,7 @@ enum {
 	HCI_PENDING_CLASS,
 	HCI_PERIODIC_INQ,
 	HCI_BROADCASTER,
+	HCI_OBSERVER,
 };
 
 /* HCI ioctl defines */
diff --git a/include/net/bluetooth/mgmt.h b/include/net/bluetooth/mgmt.h
index 2e85012..69525f9 100644
--- a/include/net/bluetooth/mgmt.h
+++ b/include/net/bluetooth/mgmt.h
@@ -93,6 +93,7 @@ struct mgmt_rp_read_index_list {
 #define MGMT_SETTING_HS			0x00000100
 #define MGMT_SETTING_LE			0x00000200
 #define MGMT_SETTING_BROADCASTER	0x00000400
+#define MGMT_SETTING_OBSERVER		0x00000800
 
 #define MGMT_OP_READ_INFO		0x0004
 #define MGMT_READ_INFO_SIZE		0
@@ -370,6 +371,8 @@ struct mgmt_cp_unset_controller_data {
 
 #define MGMT_OP_SET_BROADCASTER		0x002B
 
+#define MGMT_OP_SET_OBSERVER		0x002C
+
 #define MGMT_EV_CMD_COMPLETE		0x0001
 struct mgmt_ev_cmd_complete {
 	__le16	opcode;
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index ae4910a..845ce2d 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -380,6 +380,7 @@ static u32 get_supported_settings(struct hci_dev *hdev)
 	settings |= MGMT_SETTING_DISCOVERABLE;
 	settings |= MGMT_SETTING_PAIRABLE;
 	settings |= MGMT_SETTING_BROADCASTER;
+	settings |= MGMT_SETTING_OBSERVER;
 
 	if (lmp_ssp_capable(hdev))
 		settings |= MGMT_SETTING_SSP;
@@ -423,6 +424,9 @@ static u32 get_current_settings(struct hci_dev *hdev)
 	if (test_bit(HCI_BROADCASTER, &hdev->dev_flags))
 		settings |= MGMT_SETTING_BROADCASTER;
 
+	if (test_bit(HCI_OBSERVER, &hdev->dev_flags))
+		settings |= MGMT_SETTING_OBSERVER;
+
 	if (test_bit(HCI_LINK_SECURITY, &hdev->dev_flags))
 		settings |= MGMT_SETTING_LINK_SECURITY;
 
@@ -2805,6 +2809,44 @@ failed:
 	return err;
 }
 
+static int set_observer_le(struct hci_dev *hdev, u8 enable)
+{
+	struct hci_cp_le_set_scan_enable cmd;
+
+	cmd.enable = enable;
+	cmd.filter_dup = 0;
+	return hci_send_cmd(hdev, HCI_OP_LE_SET_SCAN_ENABLE, sizeof(cmd), &cmd);
+}
+
+static int set_observer(struct sock *sk, struct hci_dev *hdev, void *data,
+			u16 len)
+{
+	struct mgmt_mode *cp = data;
+	int err;
+
+	BT_DBG("%s val:%i", hdev->name, cp->val);
+
+	if (cp->val)
+		set_bit(HCI_OBSERVER, &hdev->dev_flags);
+	else
+		clear_bit(HCI_OBSERVER, &hdev->dev_flags);
+
+	hci_dev_lock(hdev);
+
+	if (test_bit(HCI_LE_ENABLED, &hdev->dev_flags))
+		set_observer_le(hdev, cp->val);
+
+	err = send_settings_rsp(sk, MGMT_OP_SET_OBSERVER, hdev);
+	if (err < 0)
+		goto failed;
+
+	err = new_settings(hdev, sk);
+
+failed:
+	hci_dev_unlock(hdev);
+	return err;
+}
+
 static const struct mgmt_handler {
 	int (*func) (struct sock *sk, struct hci_dev *hdev, void *data,
 		     u16 data_len);
@@ -2855,6 +2897,7 @@ static const struct mgmt_handler {
 	{ set_controller_data,    true,  MGMT_SET_CONTROLLER_DATA_SIZE },
 	{ unset_controller_data,  false, MGMT_UNSET_CONTROLLER_DATA_SIZE },
 	{ set_broadcaster,        false, MGMT_SETTING_SIZE },
+	{ set_observer,           false, MGMT_SETTING_SIZE },
 };
 
 
-- 
1.7.11.4

