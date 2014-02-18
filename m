Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 7/9] Bluetooth: Implement mgmt_load_irks command
Date: Tue, 18 Feb 2014 10:19:35 +0200
Message-Id: <1392711577-31431-7-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1392711577-31431-1-git-send-email-johan.hedberg@gmail.com>
References: <1392711577-31431-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

This patch implements the Load IRKs command for the management
interface. The command is used to load the kernel with the initial set
of IRKs. It also sets a HCI_RPA_RESOLVING flag to indicate that we can
start requesting devices to distribute their IRK to us.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 include/net/bluetooth/hci.h  |  1 +
 include/net/bluetooth/mgmt.h | 12 +++++++
 net/bluetooth/mgmt.c         | 79 ++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 92 insertions(+)

diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index 352d3d7d06bb..d3a8fff50f69 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -125,6 +125,7 @@ enum {
 	HCI_SSP_ENABLED,
 	HCI_SC_ENABLED,
 	HCI_SC_ONLY,
+	HCI_RPA_RESOLVING,
 	HCI_HS_ENABLED,
 	HCI_LE_ENABLED,
 	HCI_ADVERTISING,
diff --git a/include/net/bluetooth/mgmt.h b/include/net/bluetooth/mgmt.h
index 4303fa90b7c1..e4fa13e559e2 100644
--- a/include/net/bluetooth/mgmt.h
+++ b/include/net/bluetooth/mgmt.h
@@ -389,6 +389,18 @@ struct mgmt_cp_set_scan_params {
 
 #define MGMT_OP_SET_DEBUG_KEYS		0x002E
 
+struct mgmt_irk_info {
+	struct mgmt_addr_info addr;
+	__u8 val[16];
+} __packed;
+
+#define MGMT_OP_LOAD_IRKS		0x0030
+struct mgmt_cp_load_irks {
+	__le16 irk_count;
+	struct mgmt_irk_info irks[0];
+} __packed;
+#define MGMT_LOAD_IRKS_SIZE		2
+
 #define MGMT_EV_CMD_COMPLETE		0x0001
 struct mgmt_ev_cmd_complete {
 	__le16	opcode;
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 70bef3d5db57..782e2bb10881 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -81,6 +81,7 @@ static const u16 mgmt_commands[] = {
 	MGMT_OP_SET_SCAN_PARAMS,
 	MGMT_OP_SET_SECURE_CONN,
 	MGMT_OP_SET_DEBUG_KEYS,
+	MGMT_OP_LOAD_IRKS,
 };
 
 static const u16 mgmt_events[] = {
@@ -4158,6 +4159,82 @@ unlock:
 	return err;
 }
 
+static bool irk_is_valid(struct mgmt_irk_info *irk)
+{
+	switch (irk->addr.type) {
+	case BDADDR_LE_PUBLIC:
+		return true;
+
+	case BDADDR_LE_RANDOM:
+		/* Two most significant bits shall be set */
+		if ((irk->addr.bdaddr.b[5] & 0xc0) != 0xc0)
+			return false;
+		return true;
+	}
+
+	return false;
+}
+
+static int load_irks(struct sock *sk, struct hci_dev *hdev, void *cp_data,
+		     u16 len)
+{
+	struct mgmt_cp_load_irks *cp = cp_data;
+	u16 irk_count, expected_len;
+	int i, err;
+
+	BT_DBG("request for %s", hdev->name);
+
+	if (!lmp_le_capable(hdev))
+		return cmd_status(sk, hdev->id, MGMT_OP_LOAD_IRKS,
+				  MGMT_STATUS_NOT_SUPPORTED);
+
+	irk_count = __le16_to_cpu(cp->irk_count);
+
+	expected_len = sizeof(*cp) + irk_count * sizeof(struct mgmt_irk_info);
+	if (expected_len != len) {
+		BT_ERR("load_irks: expected %u bytes, got %u bytes",
+		       len, expected_len);
+		return cmd_status(sk, hdev->id, MGMT_OP_LOAD_IRKS,
+				  MGMT_STATUS_INVALID_PARAMS);
+	}
+
+	BT_DBG("%s irk_count %u", hdev->name, irk_count);
+
+	for (i = 0; i < irk_count; i++) {
+		struct mgmt_irk_info *key = &cp->irks[i];
+
+		if (!irk_is_valid(key))
+			return cmd_status(sk, hdev->id,
+					  MGMT_OP_LOAD_IRKS,
+					  MGMT_STATUS_INVALID_PARAMS);
+	}
+
+	hci_dev_lock(hdev);
+
+	hci_smp_irks_clear(hdev);
+
+	for (i = 0; i < irk_count; i++) {
+		struct mgmt_irk_info *irk = &cp->irks[i];
+		u8 addr_type;
+
+		if (irk->addr.type == BDADDR_LE_PUBLIC)
+			addr_type = ADDR_LE_DEV_PUBLIC;
+		else
+			addr_type = ADDR_LE_DEV_RANDOM;
+
+		hci_add_irk(hdev, &irk->addr.bdaddr, addr_type, irk->val,
+			    BDADDR_ANY);
+	}
+
+	set_bit(HCI_RPA_RESOLVING, &hdev->dev_flags);
+
+	err = cmd_complete(sk, hdev->id, MGMT_OP_LOAD_IRKS, 0, NULL, 0);
+
+	hci_dev_unlock(hdev);
+
+	return err;
+}
+
 static bool ltk_is_valid(struct mgmt_ltk_info *key)
 {
 	if (key->master != 0x00 && key->master != 0x01)
@@ -4296,6 +4373,8 @@ static const struct mgmt_handler {
 	{ set_scan_params,        false, MGMT_SET_SCAN_PARAMS_SIZE },
 	{ set_secure_conn,        false, MGMT_SETTING_SIZE },
 	{ set_debug_keys,         false, MGMT_SETTING_SIZE },
+	{ },
+	{ load_irks,              true,  MGMT_LOAD_IRKS_SIZE },
 };
 
 
-- 
1.8.5.3

