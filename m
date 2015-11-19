Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 3/3] Bluetooth: Add support for Get Advertising Size Information command
Date: Thu, 19 Nov 2015 16:16:43 +0100
Message-Id: <1447946203-17620-3-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The Get Advertising Size Information command allows to retrieve size
information for advertising data and scan response data fields depending
on the selected flags. This is useful if applications want to know the
available size ahead of time.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 include/net/bluetooth/mgmt.h | 13 ++++++++++
 net/bluetooth/mgmt.c         | 58 ++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 71 insertions(+)

diff --git a/include/net/bluetooth/mgmt.h b/include/net/bluetooth/mgmt.h
index b831242d48a4..af17774c9416 100644
--- a/include/net/bluetooth/mgmt.h
+++ b/include/net/bluetooth/mgmt.h
@@ -571,6 +571,19 @@ struct mgmt_rp_remove_advertising {
 	__u8	instance;
 } __packed;
 
+#define MGMT_OP_GET_ADV_SIZE_INFO	0x0040
+struct mgmt_cp_get_adv_size_info {
+	__u8	instance;
+	__le32	flags;
+} __packed;
+#define MGMT_GET_ADV_SIZE_INFO_SIZE	5
+struct mgmt_rp_get_adv_size_info {
+	__u8	instance;
+	__le32	flags;
+	__u8	max_adv_data_len;
+	__u8	max_scan_rsp_len;
+} __packed;
+
 #define MGMT_EV_CMD_COMPLETE		0x0001
 struct mgmt_ev_cmd_complete {
 	__le16	opcode;
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 05370e76feb0..dc8e428050d9 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -102,6 +102,7 @@ static const u16 mgmt_commands[] = {
 	MGMT_OP_READ_ADV_FEATURES,
 	MGMT_OP_ADD_ADVERTISING,
 	MGMT_OP_REMOVE_ADVERTISING,
+	MGMT_OP_GET_ADV_SIZE_INFO,
 };
 
 static const u16 mgmt_events[] = {
@@ -7059,6 +7060,62 @@ unlock:
 	return err;
 }
 
+static u8 tlv_data_max_len(u32 adv_flags, bool is_adv_data)
+{
+	u8 max_len = HCI_MAX_AD_LENGTH;
+
+	if (is_adv_data) {
+		if (adv_flags & (MGMT_ADV_FLAG_DISCOV |
+				 MGMT_ADV_FLAG_LIMITED_DISCOV |
+				 MGMT_ADV_FLAG_MANAGED_FLAGS))
+			max_len -= 3;
+
+		if (adv_flags & MGMT_ADV_FLAG_TX_POWER)
+			max_len -= 3;
+	}
+
+	return max_len;
+}
+
+static int get_adv_size_info(struct sock *sk, struct hci_dev *hdev,
+			     void *data, u16 data_len)
+{
+	struct mgmt_cp_get_adv_size_info *cp = data;
+	struct mgmt_rp_get_adv_size_info rp;
+	u32 flags, supported_flags;
+	int err;
+
+	BT_DBG("%s", hdev->name);
+
+	if (!lmp_le_capable(hdev))
+		return mgmt_cmd_status(sk, hdev->id, MGMT_OP_GET_ADV_SIZE_INFO,
+				       MGMT_STATUS_REJECTED);
+
+	if (cp->instance < 1 || cp->instance > HCI_MAX_ADV_INSTANCES)
+		return mgmt_cmd_status(sk, hdev->id, MGMT_OP_GET_ADV_SIZE_INFO,
+				       MGMT_STATUS_INVALID_PARAMS);
+
+	flags = __le32_to_cpu(cp->flags);
+
+	/* The current implementation only supports a subset of the specified
+	 * flags.
+	 */
+	supported_flags = get_supported_adv_flags(hdev);
+	if (flags & ~supported_flags)
+		return mgmt_cmd_status(sk, hdev->id, MGMT_OP_GET_ADV_SIZE_INFO,
+				       MGMT_STATUS_INVALID_PARAMS);
+
+	rp.instance = cp->instance;
+	rp.flags = cp->flags;
+	rp.max_adv_data_len = tlv_data_max_len(flags, true);
+	rp.max_scan_rsp_len = tlv_data_max_len(flags, false);
+
+	err = mgmt_cmd_complete(sk, hdev->id, MGMT_OP_GET_ADV_SIZE_INFO,
+				MGMT_STATUS_SUCCESS, &rp, sizeof(rp));
+
+	return err;
+}
+
 static const struct hci_mgmt_handler mgmt_handlers[] = {
 	{ NULL }, /* 0x0000 (no command) */
 	{ read_version,            MGMT_READ_VERSION_SIZE,
@@ -7146,6 +7203,7 @@ static const struct hci_mgmt_handler mgmt_handlers[] = {
 	{ add_advertising,	   MGMT_ADD_ADVERTISING_SIZE,
 						HCI_MGMT_VAR_LEN },
 	{ remove_advertising,	   MGMT_REMOVE_ADVERTISING_SIZE },
+	{ get_adv_size_info,       MGMT_GET_ADV_SIZE_INFO_SIZE },
 };
 
 void mgmt_index_added(struct hci_dev *hdev)
-- 
2.5.0

