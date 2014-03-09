Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/2] Bluetooth: Add management command for setting signature resolving key
Date: Sat,  8 Mar 2014 23:06:03 -0800
Message-Id: <1394348764-6722-1-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The connection signature resolving key (CSRK) can be used to allow
signed write requests over the attribute protocol. This command
provides userspace with the ability to configure such a key that
can be distributed over SMP if requested.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 include/net/bluetooth/hci_core.h |  1 +
 include/net/bluetooth/mgmt.h     |  6 ++++++
 net/bluetooth/mgmt.c             | 28 ++++++++++++++++++++++++++++
 3 files changed, 35 insertions(+)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index dbb788e4f265..dd6e58062e34 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -187,6 +187,7 @@ struct hci_dev {
 	__u16		le_conn_min_interval;
 	__u16		le_conn_max_interval;
 	__u8		ssp_debug_mode;
+	__u8		csrk[16];
 
 	__u16		devid_source;
 	__u16		devid_vendor;
diff --git a/include/net/bluetooth/mgmt.h b/include/net/bluetooth/mgmt.h
index 0326648fd799..d79f81c04cb3 100644
--- a/include/net/bluetooth/mgmt.h
+++ b/include/net/bluetooth/mgmt.h
@@ -409,6 +409,12 @@ struct mgmt_cp_load_irks {
 } __packed;
 #define MGMT_LOAD_IRKS_SIZE		2
 
+#define MGMT_OP_SET_CSRK		0x0031
+struct mgmt_cp_set_csrk {
+	__u8 val[16];
+} __packed;
+#define MGMT_SET_CSRK_SIZE		16
+
 #define MGMT_EV_CMD_COMPLETE		0x0001
 struct mgmt_ev_cmd_complete {
 	__le16	opcode;
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index f2397e7ad385..4ccb3baaa4a2 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -83,6 +83,7 @@ static const u16 mgmt_commands[] = {
 	MGMT_OP_SET_DEBUG_KEYS,
 	MGMT_OP_SET_PRIVACY,
 	MGMT_OP_LOAD_IRKS,
+	MGMT_OP_SET_CSRK,
 };
 
 static const u16 mgmt_events[] = {
@@ -4554,6 +4555,32 @@ static int load_long_term_keys(struct sock *sk, struct hci_dev *hdev,
 	return err;
 }
 
+static int set_csrk(struct sock *sk, struct hci_dev *hdev, void *data, u16 len)
+{
+	struct mgmt_cp_set_csrk *cp = data;
+	int err;
+
+	BT_DBG("%s", hdev->name);
+
+	if (!lmp_le_capable(hdev))
+		return cmd_status(sk, hdev->id, MGMT_OP_SET_CSRK,
+				  MGMT_STATUS_NOT_SUPPORTED);
+
+	if (hdev_is_powered(hdev))
+		return cmd_status(sk, hdev->id, MGMT_OP_SET_CSRK,
+				  MGMT_STATUS_REJECTED);
+
+	hci_dev_lock(hdev);
+
+	memcpy(hdev->csrk, cp->val, 16);
+
+	err = cmd_complete(sk, hdev->id, MGMT_OP_SET_CSRK, 0, NULL, 0);
+
+	hci_dev_unlock(hdev);
+
+	return err;
+}
+
 static const struct mgmt_handler {
 	int (*func) (struct sock *sk, struct hci_dev *hdev, void *data,
 		     u16 data_len);
@@ -4609,6 +4636,7 @@ static const struct mgmt_handler {
 	{ set_debug_keys,         false, MGMT_SETTING_SIZE },
 	{ set_privacy,            false, MGMT_SET_PRIVACY_SIZE },
 	{ load_irks,              true,  MGMT_LOAD_IRKS_SIZE },
+	{ set_csrk,               false, MGMT_SET_CSRK_SIZE },
 };
 
 
-- 
1.8.5.3

