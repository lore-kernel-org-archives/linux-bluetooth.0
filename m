Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 3/3] Bluetooth: Add simple version of Read Local OOB Extended Data command
Date: Sat, 14 Mar 2015 22:43:19 -0700
Message-Id: <1426398199-11977-3-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This adds support for the simplest possible version of Read Local OOB
Extended Data management command. It includes all mandatory fields,
but none of the actual pairing related ones.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 include/net/bluetooth/mgmt.h |  11 +++++
 net/bluetooth/mgmt.c         | 111 ++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 121 insertions(+), 1 deletion(-)

diff --git a/include/net/bluetooth/mgmt.h b/include/net/bluetooth/mgmt.h
index 4d0ccd194c01..543c1ba3d892 100644
--- a/include/net/bluetooth/mgmt.h
+++ b/include/net/bluetooth/mgmt.h
@@ -506,6 +506,17 @@ struct mgmt_cp_start_service_discovery {
 } __packed;
 #define MGMT_START_SERVICE_DISCOVERY_SIZE 4
 
+#define MGMT_OP_READ_LOCAL_OOB_EXT_DATA	0x003B
+struct mgmt_cp_read_local_oob_ext_data {
+	__u8 type;
+} __packed;
+#define MGMT_READ_LOCAL_OOB_EXT_DATA_SIZE 1
+struct mgmt_rp_read_local_oob_ext_data {
+	__u8    type;
+	__le16	eir_len;
+	__u8	eir[0];
+} __packed;
+
 #define MGMT_OP_READ_EXT_INDEX_LIST	0x003C
 #define MGMT_READ_EXT_INDEX_LIST_SIZE	0
 struct mgmt_rp_read_ext_index_list {
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 3e430c8b8030..eda3288a3960 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -96,6 +96,7 @@ static const u16 mgmt_commands[] = {
 	MGMT_OP_SET_EXTERNAL_CONFIG,
 	MGMT_OP_SET_PUBLIC_ADDRESS,
 	MGMT_OP_START_SERVICE_DISCOVERY,
+	MGMT_OP_READ_LOCAL_OOB_EXT_DATA,
 	MGMT_OP_READ_EXT_INDEX_LIST,
 	MGMT_OP_READ_ADV_FEATURES,
 };
@@ -6266,6 +6267,114 @@ static inline u16 eir_append_data(u8 *eir, u16 eir_len, u8 type, u8 *data,
 	return eir_len;
 }
 
+static int read_local_oob_ext_data(struct sock *sk, struct hci_dev *hdev,
+				   void *data, u16 data_len)
+{
+	struct mgmt_cp_read_local_oob_ext_data *cp = data;
+	struct mgmt_rp_read_local_oob_ext_data *rp;
+	size_t rp_len;
+	u16 eir_len;
+	u8 status, flags, role, addr[7];
+	int err;
+
+	BT_DBG("%s", hdev->name);
+
+	if (!hdev_is_powered(hdev))
+		return mgmt_cmd_complete(sk, hdev->id,
+					 MGMT_OP_READ_LOCAL_OOB_EXT_DATA,
+					 MGMT_STATUS_NOT_POWERED,
+					 &cp->type, sizeof(cp->type));
+
+	switch (cp->type) {
+	case BIT(BDADDR_BREDR):
+		status = mgmt_bredr_support(hdev);
+		if (status)
+			return mgmt_cmd_complete(sk, hdev->id,
+						 MGMT_OP_READ_LOCAL_OOB_EXT_DATA,
+						 status, &cp->type,
+						 sizeof(cp->type));
+		eir_len = 5;
+		break;
+	case (BIT(BDADDR_LE_PUBLIC) | BIT(BDADDR_LE_RANDOM)):
+		status = mgmt_le_support(hdev);
+		if (status)
+			return mgmt_cmd_complete(sk, hdev->id,
+						 MGMT_OP_READ_LOCAL_OOB_EXT_DATA,
+						 status, &cp->type,
+						 sizeof(cp->type));
+		eir_len = 15;
+		break;
+	default:
+		return mgmt_cmd_complete(sk, hdev->id,
+					 MGMT_OP_READ_LOCAL_OOB_EXT_DATA,
+					 MGMT_STATUS_INVALID_PARAMS,
+					 &cp->type, sizeof(cp->type));
+	}
+
+	hci_dev_lock(hdev);
+
+	rp_len = sizeof(*rp) + eir_len;
+	rp = kmalloc(rp_len, GFP_ATOMIC);
+	if (!rp) {
+		hci_dev_unlock(hdev);
+		return -ENOMEM;
+	}
+
+	eir_len = 0;
+	switch (cp->type) {
+	case BIT(BDADDR_BREDR):
+		eir_len = eir_append_data(rp->eir, eir_len, EIR_CLASS_OF_DEV,
+					  hdev->dev_class, 3);
+		break;
+	case (BIT(BDADDR_LE_PUBLIC) | BIT(BDADDR_LE_RANDOM)):
+		if (hci_dev_test_flag(hdev, HCI_PRIVACY)) {
+			memcpy(addr, &hdev->rpa, 6);
+			addr[6] = 0x01;
+		} else if (hci_dev_test_flag(hdev, HCI_FORCE_STATIC_ADDR) ||
+			   !bacmp(&hdev->bdaddr, BDADDR_ANY) ||
+			   (!hci_dev_test_flag(hdev, HCI_BREDR_ENABLED) &&
+			    bacmp(&hdev->static_addr, BDADDR_ANY))) {
+			memcpy(addr, &hdev->static_addr, 6);
+			addr[6] = 0x01;
+		} else {
+			memcpy(addr, &hdev->bdaddr, 6);
+			addr[6] = 0x00;
+		}
+
+		eir_len = eir_append_data(rp->eir, eir_len, EIR_LE_BDADDR,
+					  addr, sizeof(addr));
+
+		if (hci_dev_test_flag(hdev, HCI_ADVERTISING))
+			role = 0x02;
+		else
+			role = 0x01;
+
+		eir_len = eir_append_data(rp->eir, eir_len, EIR_LE_ROLE,
+					  &role, sizeof(role));
+
+		flags = get_adv_discov_flags(hdev);
+
+		if (!hci_dev_test_flag(hdev, HCI_BREDR_ENABLED))
+			flags |= LE_AD_NO_BREDR;
+
+		eir_len = eir_append_data(rp->eir, eir_len, EIR_FLAGS,
+					  &flags, sizeof(flags));
+		break;
+	}
+
+	rp->type = cp->type;
+	rp->eir_len = cpu_to_le16(eir_len);
+
+	hci_dev_unlock(hdev);
+
+	err = mgmt_cmd_complete(sk, hdev->id, MGMT_OP_READ_LOCAL_OOB_EXT_DATA,
+				MGMT_STATUS_SUCCESS, rp, rp_len);
+
+	kfree(rp);
+
+	return err;
+}
+
 static int read_adv_features(struct sock *sk, struct hci_dev *hdev,
 			     void *data, u16 data_len)
 {
@@ -6379,7 +6488,7 @@ static const struct hci_mgmt_handler mgmt_handlers[] = {
 						HCI_MGMT_UNCONFIGURED },
 	{ start_service_discovery, MGMT_START_SERVICE_DISCOVERY_SIZE,
 						HCI_MGMT_VAR_LEN },
-	{ NULL },
+	{ read_local_oob_ext_data, MGMT_READ_LOCAL_OOB_EXT_DATA_SIZE },
 	{ read_ext_index_list,     MGMT_READ_EXT_INDEX_LIST_SIZE,
 						HCI_MGMT_NO_HDEV |
 						HCI_MGMT_UNTRUSTED },
-- 
2.1.0

