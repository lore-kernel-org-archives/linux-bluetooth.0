Return-Path: <cyrus@holtmann.org>
From: johan.hedberg@gmail.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 4/7] Bluetooth: Move EIR and CoD update functions to a better position
Date: Wed, 14 Dec 2011 23:52:01 +0200
Message-Id: <1323899524-13653-5-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1323899524-13653-1-git-send-email-johan.hedberg@gmail.com>
References: <1323899524-13653-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

Due to the upcoming addition of a service cache timer the functions to
update the EIR and CoD need to be higher up in mgmt.c in order to avoid
unnecessary forward-declarations. This patch simply moves code around
without any other changes in order to make subsequent patches more
readable.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/mgmt.c |  346 +++++++++++++++++++++++++-------------------------
 1 files changed, 173 insertions(+), 173 deletions(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 25e7bf9..696e585 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -299,6 +299,179 @@ static u32 get_current_settings(struct hci_dev *hdev)
 	return settings;
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
+	struct bt_uuid *uuid;
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
+	list_for_each_entry(uuid, &hdev->uuids, list) {
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
+static u8 get_service_classes(struct hci_dev *hdev)
+{
+	struct bt_uuid *uuid;
+	u8 val = 0;
+
+	list_for_each_entry(uuid, &hdev->uuids, list)
+		val |= uuid->svc_hint;
+
+	return val;
+}
+
+static int update_class(struct hci_dev *hdev)
+{
+	u8 cod[3];
+
+	BT_DBG("%s", hdev->name);
+
+	if (test_bit(HCI_SERVICE_CACHE, &hdev->flags))
+		return 0;
+
+	cod[0] = hdev->minor_class;
+	cod[1] = hdev->major_class;
+	cod[2] = get_service_classes(hdev);
+
+	if (memcmp(cod, hdev->dev_class, 3) == 0)
+		return 0;
+
+	return hci_send_cmd(hdev, HCI_OP_WRITE_CLASS_OF_DEV, sizeof(cod), cod);
+}
+
 static int read_controller_info(struct sock *sk, u16 index)
 {
 	struct mgmt_rp_read_info rp;
@@ -681,179 +854,6 @@ failed:
 	return err;
 }
 
-#define EIR_FLAGS		0x01 /* flags */
-#define EIR_UUID16_SOME		0x02 /* 16-bit UUID, more available */
-#define EIR_UUID16_ALL		0x03 /* 16-bit UUID, all listed */
-#define EIR_UUID32_SOME		0x04 /* 32-bit UUID, more available */
-#define EIR_UUID32_ALL		0x05 /* 32-bit UUID, all listed */
-#define EIR_UUID128_SOME	0x06 /* 128-bit UUID, more available */
-#define EIR_UUID128_ALL		0x07 /* 128-bit UUID, all listed */
-#define EIR_NAME_SHORT		0x08 /* shortened local name */
-#define EIR_NAME_COMPLETE	0x09 /* complete local name */
-#define EIR_TX_POWER		0x0A /* transmit power level */
-#define EIR_DEVICE_ID		0x10 /* device ID */
-
-#define PNP_INFO_SVCLASS_ID		0x1200
-
-static u8 bluetooth_base_uuid[] = {
-			0xFB, 0x34, 0x9B, 0x5F, 0x80, 0x00, 0x00, 0x80,
-			0x00, 0x10, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
-};
-
-static u16 get_uuid16(u8 *uuid128)
-{
-	u32 val;
-	int i;
-
-	for (i = 0; i < 12; i++) {
-		if (bluetooth_base_uuid[i] != uuid128[i])
-			return 0;
-	}
-
-	memcpy(&val, &uuid128[12], 4);
-
-	val = le32_to_cpu(val);
-	if (val > 0xffff)
-		return 0;
-
-	return (u16) val;
-}
-
-static void create_eir(struct hci_dev *hdev, u8 *data)
-{
-	u8 *ptr = data;
-	u16 eir_len = 0;
-	u16 uuid16_list[HCI_MAX_EIR_LENGTH / sizeof(u16)];
-	int i, truncated = 0;
-	struct bt_uuid *uuid;
-	size_t name_len;
-
-	name_len = strlen(hdev->dev_name);
-
-	if (name_len > 0) {
-		/* EIR Data type */
-		if (name_len > 48) {
-			name_len = 48;
-			ptr[1] = EIR_NAME_SHORT;
-		} else
-			ptr[1] = EIR_NAME_COMPLETE;
-
-		/* EIR Data length */
-		ptr[0] = name_len + 1;
-
-		memcpy(ptr + 2, hdev->dev_name, name_len);
-
-		eir_len += (name_len + 2);
-		ptr += (name_len + 2);
-	}
-
-	memset(uuid16_list, 0, sizeof(uuid16_list));
-
-	/* Group all UUID16 types */
-	list_for_each_entry(uuid, &hdev->uuids, list) {
-		u16 uuid16;
-
-		uuid16 = get_uuid16(uuid->uuid);
-		if (uuid16 == 0)
-			return;
-
-		if (uuid16 < 0x1100)
-			continue;
-
-		if (uuid16 == PNP_INFO_SVCLASS_ID)
-			continue;
-
-		/* Stop if not enough space to put next UUID */
-		if (eir_len + 2 + sizeof(u16) > HCI_MAX_EIR_LENGTH) {
-			truncated = 1;
-			break;
-		}
-
-		/* Check for duplicates */
-		for (i = 0; uuid16_list[i] != 0; i++)
-			if (uuid16_list[i] == uuid16)
-				break;
-
-		if (uuid16_list[i] == 0) {
-			uuid16_list[i] = uuid16;
-			eir_len += sizeof(u16);
-		}
-	}
-
-	if (uuid16_list[0] != 0) {
-		u8 *length = ptr;
-
-		/* EIR Data type */
-		ptr[1] = truncated ? EIR_UUID16_SOME : EIR_UUID16_ALL;
-
-		ptr += 2;
-		eir_len += 2;
-
-		for (i = 0; uuid16_list[i] != 0; i++) {
-			*ptr++ = (uuid16_list[i] & 0x00ff);
-			*ptr++ = (uuid16_list[i] & 0xff00) >> 8;
-		}
-
-		/* EIR Data length */
-		*length = (i * sizeof(u16)) + 1;
-	}
-}
-
-static int update_eir(struct hci_dev *hdev)
-{
-	struct hci_cp_write_eir cp;
-
-	if (!(hdev->features[6] & LMP_EXT_INQ))
-		return 0;
-
-	if (hdev->ssp_mode == 0)
-		return 0;
-
-	if (test_bit(HCI_SERVICE_CACHE, &hdev->flags))
-		return 0;
-
-	memset(&cp, 0, sizeof(cp));
-
-	create_eir(hdev, cp.data);
-
-	if (memcmp(cp.data, hdev->eir, sizeof(cp.data)) == 0)
-		return 0;
-
-	memcpy(hdev->eir, cp.data, sizeof(cp.data));
-
-	return hci_send_cmd(hdev, HCI_OP_WRITE_EIR, sizeof(cp), &cp);
-}
-
-static u8 get_service_classes(struct hci_dev *hdev)
-{
-	struct bt_uuid *uuid;
-	u8 val = 0;
-
-	list_for_each_entry(uuid, &hdev->uuids, list)
-		val |= uuid->svc_hint;
-
-	return val;
-}
-
-static int update_class(struct hci_dev *hdev)
-{
-	u8 cod[3];
-
-	BT_DBG("%s", hdev->name);
-
-	if (test_bit(HCI_SERVICE_CACHE, &hdev->flags))
-		return 0;
-
-	cod[0] = hdev->minor_class;
-	cod[1] = hdev->major_class;
-	cod[2] = get_service_classes(hdev);
-
-	if (memcmp(cod, hdev->dev_class, 3) == 0)
-		return 0;
-
-	return hci_send_cmd(hdev, HCI_OP_WRITE_CLASS_OF_DEV, sizeof(cod), cod);
-}
-
 static int add_uuid(struct sock *sk, u16 index, unsigned char *data, u16 len)
 {
 	struct mgmt_cp_add_uuid *cp;
-- 
1.7.7.3

