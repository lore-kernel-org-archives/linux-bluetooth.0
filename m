Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [RFC] Bluetooth: Add command for setting 3D information data
Date: Fri, 11 Oct 2013 15:14:24 -0700
Message-Id: <1381529664-23391-1-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This commands allows to program the 3D information data so it
can later be used when setting the Extended Inquiry Information.

The 3D profile is flexible on the parameter length of this field
and allows for future extensions. So make the input parameter to
this command also flexible.

Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 include/net/bluetooth/hci.h      |  1 +
 include/net/bluetooth/hci_core.h |  2 ++
 include/net/bluetooth/mgmt.h     |  7 +++++++
 net/bluetooth/mgmt.c             | 45 ++++++++++++++++++++++++++++++++++++++++
 4 files changed, 55 insertions(+)

diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index c8a91cb..944ff04 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -358,6 +358,7 @@ enum {
 #define EIR_SSP_HASH_C		0x0E /* Simple Pairing Hash C */
 #define EIR_SSP_RAND_R		0x0F /* Simple Pairing Randomizer R */
 #define EIR_DEVICE_ID		0x10 /* device ID */
+#define EIR_3D_INFO_DATA	0x3D /* 3D information */
 
 /* Low Energy Advertising Flags */
 #define LE_AD_LIMITED		0x01 /* Limited Discoverable */
diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 6900454..d55f353 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -171,6 +171,8 @@ struct hci_dev {
 	__u16		devid_vendor;
 	__u16		devid_product;
 	__u16		devid_version;
+	__u8		data_3d_len;
+	__u8		data_3d[2];
 
 	__u16		pkt_type;
 	__u16		esco_type;
diff --git a/include/net/bluetooth/mgmt.h b/include/net/bluetooth/mgmt.h
index 518c5c8..95efb75 100644
--- a/include/net/bluetooth/mgmt.h
+++ b/include/net/bluetooth/mgmt.h
@@ -369,6 +369,13 @@ struct mgmt_cp_set_scan_params {
 } __packed;
 #define MGMT_SET_SCAN_PARAMS_SIZE	4
 
+#define MGMT_OP_SET_3D_INFO		0x002D
+struct mgmt_cp_set_3d_info {
+	__u8	len;
+	__u8	data[0];
+} __packed;
+#define MGMT_SET_3D_INFO_SIZE		1
+
 #define MGMT_EV_CMD_COMPLETE		0x0001
 struct mgmt_ev_cmd_complete {
 	__le16	opcode;
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 338878c..c558571 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -79,6 +79,7 @@ static const u16 mgmt_commands[] = {
 	MGMT_OP_SET_BREDR,
 	MGMT_OP_SET_STATIC_ADDRESS,
 	MGMT_OP_SET_SCAN_PARAMS,
+	MGMT_OP_SET_3D_INFO,
 };
 
 static const u16 mgmt_events[] = {
@@ -579,6 +580,15 @@ static void create_eir(struct hci_dev *hdev, u8 *data)
 		ptr += 10;
 	}
 
+	if (hdev->data_3d_len > 0) {
+		ptr[0] = hdev->data_3d_len + 1;
+		ptr[1] = EIR_3D_INFO_DATA;
+
+		memcpy(ptr + 2, hdev->data_3d, hdev->data_3d_len);
+
+		ptr += (hdev->data_3d_len + 2);
+	}
+
 	ptr = create_uuid16_list(hdev, ptr, HCI_MAX_EIR_LENGTH - (ptr - data));
 	ptr = create_uuid32_list(hdev, ptr, HCI_MAX_EIR_LENGTH - (ptr - data));
 	ptr = create_uuid128_list(hdev, ptr, HCI_MAX_EIR_LENGTH - (ptr - data));
@@ -3413,6 +3423,40 @@ static int set_scan_params(struct sock *sk, struct hci_dev *hdev,
 	return err;
 }
 
+static int set_3d_info(struct sock *sk, struct hci_dev *hdev, void *data,
+		       u16 len)
+{
+	struct mgmt_cp_set_3d_info *cp = data;
+	struct hci_request req;
+	int err;
+
+	BT_DBG("request for %s", hdev->name);
+
+	if (!lmp_bredr_capable(hdev))
+		return cmd_status(sk, hdev->id, MGMT_OP_SET_3D_INFO,
+				  MGMT_STATUS_NOT_SUPPORTED);
+
+	if (cp->len > 2)
+		return cmd_status(sk, hdev->id, MGMT_OP_SET_3D_INFO,
+				  MGMT_STATUS_INVALID_PARAMS);
+
+	hci_dev_lock(hdev);
+
+	hdev->data_3d_len = cp->len;
+	if (cp->len > 0)
+		memcpy(hdev->data_3d, cp->data, cp->len);
+
+	err = cmd_complete(sk, hdev->id, MGMT_OP_SET_3D_INFO, 0, NULL, 0);
+
+	hci_req_init(&req, hdev);
+	update_eir(&req);
+	hci_req_run(&req, NULL);
+
+	hci_dev_unlock(hdev);
+
+	return err;
+}
+
 static void fast_connectable_complete(struct hci_dev *hdev, u8 status)
 {
 	struct pending_cmd *cmd;
@@ -3750,6 +3794,7 @@ static const struct mgmt_handler {
 	{ set_bredr,              false, MGMT_SETTING_SIZE },
 	{ set_static_address,     false, MGMT_SET_STATIC_ADDRESS_SIZE },
 	{ set_scan_params,        false, MGMT_SET_SCAN_PARAMS_SIZE },
+	{ set_3d_info,            true,  MGMT_SET_3D_INFO_SIZE },
 };
 
 
-- 
1.8.3.1

