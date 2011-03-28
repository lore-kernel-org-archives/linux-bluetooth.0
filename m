Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2] Bluetooth: Add local Extended Inquiry Response (EIR) support
Date: Mon, 28 Mar 2011 14:07:23 +0300
Message-Id: <1301310443-13197-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@nokia.com>

This patch adds automated creation of the local EIR data based on what
16-bit UUIDs are registered and what the device name is. This should
cover the majority use cases, however things like 32/128-bit UUIDs, TX
power and Device ID will need to be added later to be on par with what
bluetoothd is capable of doing (without the Management interface).

Signed-off-by: Johan Hedberg <johan.hedberg@nokia.com>
---
v2: Updated to assume that the UUIDs are in little endian byte order
like like all other data types in the management interface.

 include/net/bluetooth/hci.h      |    8 ++
 include/net/bluetooth/hci_core.h |    1 +
 net/bluetooth/mgmt.c             |  163 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 172 insertions(+), 0 deletions(-)

diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index b989a8c..6846ec0 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -614,6 +614,14 @@ struct hci_cp_host_buffer_size {
 
 #define HCI_OP_WRITE_INQUIRY_MODE	0x0c45
 
+#define HCI_MAX_EIR_LENGTH		240
+
+#define HCI_OP_WRITE_EIR		0x0c52
+struct hci_cp_write_eir {
+	uint8_t		fec;
+	uint8_t		data[HCI_MAX_EIR_LENGTH];
+} __packed;
+
 #define HCI_OP_READ_SSP_MODE		0x0c55
 struct hci_rp_read_ssp_mode {
 	__u8     status;
diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index 87bff51..3b2f09d 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -102,6 +102,7 @@ struct hci_dev {
 	__u8		dev_type;
 	bdaddr_t	bdaddr;
 	__u8		dev_name[HCI_MAX_NAME_LENGTH];
+	__u8		eir[HCI_MAX_EIR_LENGTH];
 	__u8		dev_class[3];
 	__u8		major_class;
 	__u8		minor_class;
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index a42dc8c..62055c9 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -544,6 +544,150 @@ failed:
 	return err;
 }
 
+#define EIR_FLAGS		0x01 /* flags */
+#define EIR_UUID16_SOME		0x02 /* 16-bit UUID, more available */
+#define EIR_UUID16_ALL		0x03 /* 16-bit UUID, all listed */
+#define EIR_UUID32_SOME		0x04 /* 32-bit UUID, more available */
+#define EIR_UUID32_ALL		0x05 /* 32-bit UUID, all listed */
+#define EIR_UUID128_SOME	0x06 /* 128-bit UUID, more available */
+#define EIR_UUID128_ALL		0x07 /* 128-bit UUID, all listed */
+#define EIR_NAME_SHORT		0x08 /* shortened local name */
+#define EIR_NAME_COMPLETE	0x09 /* complete local name */
+#define EIR_TX_POWER		0x0A /* transmit power level */
+#define EIR_DEVICE_ID		0x10 /* device ID */
+
+#define PNP_INFO_SVCLASS_ID		0x1200
+
+static u8 bluetooth_base_uuid[] = {
+			0xFB, 0x34, 0x9B, 0x5F, 0x80, 0x00, 0x00, 0x80,
+			0x00, 0x10, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+};
+
+static u16 get_uuid16(u8 *uuid128)
+{
+	u32 val;
+	int i;
+
+	for (i = 0; i < 12; i++) {
+		if (bluetooth_base_uuid[i] != uuid128[i])
+			return 0;
+	}
+
+	memcpy(&val, &uuid128[12], 4);
+
+	val = le32_to_cpu(val);
+	if (val > 0xffff)
+		return 0;
+
+	return (u16) val;
+}
+
+static void create_eir(struct hci_dev *hdev, u8 *data)
+{
+	u8 *ptr = data;
+	u16 eir_len = 0;
+	u16 uuid16_list[HCI_MAX_EIR_LENGTH / sizeof(u16)];
+	int i, truncated = 0;
+	struct list_head *p;
+	size_t name_len;
+
+	name_len = strlen(hdev->dev_name);
+
+	if (name_len > 0) {
+		/* EIR Data type */
+		if (name_len > 48) {
+			name_len = 48;
+			ptr[1] = EIR_NAME_SHORT;
+		} else
+			ptr[1] = EIR_NAME_COMPLETE;
+
+		/* EIR Data length */
+		ptr[0] = name_len + 1;
+
+		memcpy(ptr + 2, hdev->dev_name, name_len);
+
+		eir_len += (name_len + 2);
+		ptr += (name_len + 2);
+	}
+
+	memset(uuid16_list, 0, sizeof(uuid16_list));
+
+	/* Group all UUID16 types */
+	list_for_each(p, &hdev->uuids) {
+		struct bt_uuid *uuid = list_entry(p, struct bt_uuid, list);
+		u16 uuid16;
+
+		uuid16 = get_uuid16(uuid->uuid);
+		if (uuid16 == 0)
+			return;
+
+		if (uuid16 < 0x1100)
+			continue;
+
+		if (uuid16 == PNP_INFO_SVCLASS_ID)
+			continue;
+
+		/* Stop if not enough space to put next UUID */
+		if (eir_len + 2 + sizeof(u16) > HCI_MAX_EIR_LENGTH) {
+			truncated = 1;
+			break;
+		}
+
+		/* Check for duplicates */
+		for (i = 0; uuid16_list[i] != 0; i++)
+			if (uuid16_list[i] == uuid16)
+				break;
+
+		if (uuid16_list[i] == 0) {
+			uuid16_list[i] = uuid16;
+			eir_len += sizeof(u16);
+		}
+	}
+
+	if (uuid16_list[0] != 0) {
+		u8 *length = ptr;
+
+		/* EIR Data type */
+		ptr[1] = truncated ? EIR_UUID16_SOME : EIR_UUID16_ALL;
+
+		ptr += 2;
+		eir_len += 2;
+
+		for (i = 0; uuid16_list[i] != 0; i++) {
+			*ptr++ = (uuid16_list[i] & 0x00ff);
+			*ptr++ = (uuid16_list[i] & 0xff00) >> 8;
+		}
+
+		/* EIR Data length */
+		*length = (i * sizeof(u16)) + 1;
+	}
+}
+
+static int update_eir(struct hci_dev *hdev)
+{
+	struct hci_cp_write_eir cp;
+
+	if (!(hdev->features[6] & LMP_EXT_INQ))
+		return 0;
+
+	if (hdev->ssp_mode == 0)
+		return 0;
+
+	if (test_bit(HCI_SERVICE_CACHE, &hdev->flags))
+		return 0;
+
+	memset(&cp, 0, sizeof(cp));
+
+	create_eir(hdev, cp.data);
+
+	if (memcmp(cp.data, hdev->eir, sizeof(cp.data)) == 0)
+		return 0;
+
+	memcpy(hdev->eir, cp.data, sizeof(cp.data));
+
+	return hci_send_cmd(hdev, HCI_OP_WRITE_EIR, sizeof(cp), &cp);
+}
+
 static u8 get_service_classes(struct hci_dev *hdev)
 {
 	struct list_head *p;
@@ -612,6 +756,10 @@ static int add_uuid(struct sock *sk, u16 index, unsigned char *data, u16 len)
 	if (err < 0)
 		goto failed;
 
+	err = update_eir(hdev);
+	if (err < 0)
+		goto failed;
+
 	err = cmd_complete(sk, index, MGMT_OP_ADD_UUID, NULL, 0);
 
 failed:
@@ -668,6 +816,10 @@ static int remove_uuid(struct sock *sk, u16 index, unsigned char *data, u16 len)
 	if (err < 0)
 		goto unlock;
 
+	err = update_eir(hdev);
+	if (err < 0)
+		goto unlock;
+
 	err = cmd_complete(sk, index, MGMT_OP_REMOVE_UUID, NULL, 0);
 
 unlock:
@@ -737,6 +889,8 @@ static int set_service_cache(struct sock *sk, u16 index,  unsigned char *data,
 	} else {
 		clear_bit(HCI_SERVICE_CACHE, &hdev->flags);
 		err = update_class(hdev);
+		if (err == 0)
+			err = update_eir(hdev);
 	}
 
 	if (err == 0)
@@ -1822,6 +1976,7 @@ int mgmt_auth_failed(u16 index, bdaddr_t *bdaddr, u8 status)
 int mgmt_set_local_name_complete(u16 index, u8 *name, u8 status)
 {
 	struct pending_cmd *cmd;
+	struct hci_dev *hdev;
 	struct mgmt_cp_set_local_name ev;
 	int err;
 
@@ -1837,6 +1992,14 @@ int mgmt_set_local_name_complete(u16 index, u8 *name, u8 status)
 		goto failed;
 	}
 
+	hdev = hci_dev_get(index);
+	if (hdev) {
+		hci_dev_lock_bh(hdev);
+		update_eir(hdev);
+		hci_dev_unlock_bh(hdev);
+		hci_dev_put(hdev);
+	}
+
 	err = cmd_complete(cmd->sk, index, MGMT_OP_SET_LOCAL_NAME, &ev,
 								sizeof(ev));
 	if (err < 0)
-- 
1.7.4.1

