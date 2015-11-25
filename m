Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Johan Hedberg <johan.hedberg@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/4] Bluetooth: Move EIR update to hci_request.c
Date: Wed, 25 Nov 2015 16:15:42 +0200
Message-Id: <1448460944-17002-3-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1448460944-17002-1-git-send-email-johan.hedberg@gmail.com>
References: <1448460944-17002-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

We'll soon need to update the EIR both from hci_request.c and mgmt.c
so move update_eir() as a more generic request helper to
hci_request.c.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/hci_request.c | 189 +++++++++++++++++++++++++++++++++++++++++
 net/bluetooth/hci_request.h |   1 +
 net/bluetooth/mgmt.c        | 203 ++------------------------------------------
 3 files changed, 198 insertions(+), 195 deletions(-)

diff --git a/net/bluetooth/hci_request.c b/net/bluetooth/hci_request.c
index 3150461c52a4..030a1bb66ef5 100644
--- a/net/bluetooth/hci_request.c
+++ b/net/bluetooth/hci_request.c
@@ -21,6 +21,8 @@
    SOFTWARE IS DISCLAIMED.
 */
 
+#include <asm/unaligned.h>
+
 #include <net/bluetooth/bluetooth.h>
 #include <net/bluetooth/hci_core.h>
 #include <net/bluetooth/mgmt.h>
@@ -430,6 +432,193 @@ void __hci_req_update_name(struct hci_request *req)
 	hci_req_add(req, HCI_OP_WRITE_LOCAL_NAME, sizeof(cp), &cp);
 }
 
+#define PNP_INFO_SVCLASS_ID		0x1200
+
+static u8 *create_uuid16_list(struct hci_dev *hdev, u8 *data, ptrdiff_t len)
+{
+	u8 *ptr = data, *uuids_start = NULL;
+	struct bt_uuid *uuid;
+
+	if (len < 4)
+		return ptr;
+
+	list_for_each_entry(uuid, &hdev->uuids, list) {
+		u16 uuid16;
+
+		if (uuid->size != 16)
+			continue;
+
+		uuid16 = get_unaligned_le16(&uuid->uuid[12]);
+		if (uuid16 < 0x1100)
+			continue;
+
+		if (uuid16 == PNP_INFO_SVCLASS_ID)
+			continue;
+
+		if (!uuids_start) {
+			uuids_start = ptr;
+			uuids_start[0] = 1;
+			uuids_start[1] = EIR_UUID16_ALL;
+			ptr += 2;
+		}
+
+		/* Stop if not enough space to put next UUID */
+		if ((ptr - data) + sizeof(u16) > len) {
+			uuids_start[1] = EIR_UUID16_SOME;
+			break;
+		}
+
+		*ptr++ = (uuid16 & 0x00ff);
+		*ptr++ = (uuid16 & 0xff00) >> 8;
+		uuids_start[0] += sizeof(uuid16);
+	}
+
+	return ptr;
+}
+
+static u8 *create_uuid32_list(struct hci_dev *hdev, u8 *data, ptrdiff_t len)
+{
+	u8 *ptr = data, *uuids_start = NULL;
+	struct bt_uuid *uuid;
+
+	if (len < 6)
+		return ptr;
+
+	list_for_each_entry(uuid, &hdev->uuids, list) {
+		if (uuid->size != 32)
+			continue;
+
+		if (!uuids_start) {
+			uuids_start = ptr;
+			uuids_start[0] = 1;
+			uuids_start[1] = EIR_UUID32_ALL;
+			ptr += 2;
+		}
+
+		/* Stop if not enough space to put next UUID */
+		if ((ptr - data) + sizeof(u32) > len) {
+			uuids_start[1] = EIR_UUID32_SOME;
+			break;
+		}
+
+		memcpy(ptr, &uuid->uuid[12], sizeof(u32));
+		ptr += sizeof(u32);
+		uuids_start[0] += sizeof(u32);
+	}
+
+	return ptr;
+}
+
+static u8 *create_uuid128_list(struct hci_dev *hdev, u8 *data, ptrdiff_t len)
+{
+	u8 *ptr = data, *uuids_start = NULL;
+	struct bt_uuid *uuid;
+
+	if (len < 18)
+		return ptr;
+
+	list_for_each_entry(uuid, &hdev->uuids, list) {
+		if (uuid->size != 128)
+			continue;
+
+		if (!uuids_start) {
+			uuids_start = ptr;
+			uuids_start[0] = 1;
+			uuids_start[1] = EIR_UUID128_ALL;
+			ptr += 2;
+		}
+
+		/* Stop if not enough space to put next UUID */
+		if ((ptr - data) + 16 > len) {
+			uuids_start[1] = EIR_UUID128_SOME;
+			break;
+		}
+
+		memcpy(ptr, uuid->uuid, 16);
+		ptr += 16;
+		uuids_start[0] += 16;
+	}
+
+	return ptr;
+}
+
+static void create_eir(struct hci_dev *hdev, u8 *data)
+{
+	u8 *ptr = data;
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
+		ptr += (name_len + 2);
+	}
+
+	if (hdev->inq_tx_power != HCI_TX_POWER_INVALID) {
+		ptr[0] = 2;
+		ptr[1] = EIR_TX_POWER;
+		ptr[2] = (u8) hdev->inq_tx_power;
+
+		ptr += 3;
+	}
+
+	if (hdev->devid_source > 0) {
+		ptr[0] = 9;
+		ptr[1] = EIR_DEVICE_ID;
+
+		put_unaligned_le16(hdev->devid_source, ptr + 2);
+		put_unaligned_le16(hdev->devid_vendor, ptr + 4);
+		put_unaligned_le16(hdev->devid_product, ptr + 6);
+		put_unaligned_le16(hdev->devid_version, ptr + 8);
+
+		ptr += 10;
+	}
+
+	ptr = create_uuid16_list(hdev, ptr, HCI_MAX_EIR_LENGTH - (ptr - data));
+	ptr = create_uuid32_list(hdev, ptr, HCI_MAX_EIR_LENGTH - (ptr - data));
+	ptr = create_uuid128_list(hdev, ptr, HCI_MAX_EIR_LENGTH - (ptr - data));
+}
+
+void __hci_req_update_eir(struct hci_request *req)
+{
+	struct hci_dev *hdev = req->hdev;
+	struct hci_cp_write_eir cp;
+
+	if (!hdev_is_powered(hdev))
+		return;
+
+	if (!lmp_ext_inq_capable(hdev))
+		return;
+
+	if (!hci_dev_test_flag(hdev, HCI_SSP_ENABLED))
+		return;
+
+	if (hci_dev_test_flag(hdev, HCI_SERVICE_CACHE))
+		return;
+
+	memset(&cp, 0, sizeof(cp));
+
+	create_eir(hdev, cp.data);
+
+	if (memcmp(cp.data, hdev->eir, sizeof(cp.data)) == 0)
+		return;
+
+	memcpy(hdev->eir, cp.data, sizeof(cp.data));
+
+	hci_req_add(req, HCI_OP_WRITE_EIR, sizeof(cp), &cp);
+}
+
 void hci_req_add_le_scan_disable(struct hci_request *req)
 {
 	struct hci_cp_le_set_scan_enable cp;
diff --git a/net/bluetooth/hci_request.h b/net/bluetooth/hci_request.h
index 4e65a9c7906a..5af40395afa8 100644
--- a/net/bluetooth/hci_request.h
+++ b/net/bluetooth/hci_request.h
@@ -56,6 +56,7 @@ struct sk_buff *hci_prepare_cmd(struct hci_dev *hdev, u16 opcode, u32 plen,
 				const void *param);
 
 void __hci_req_update_name(struct hci_request *req);
+void __hci_req_update_eir(struct hci_request *req);
 
 void hci_req_add_le_scan_disable(struct hci_request *req);
 void hci_req_add_le_passive_scan(struct hci_request *req);
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 001a29a320e6..fa5dc67a800a 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -719,116 +719,6 @@ static u32 get_current_settings(struct hci_dev *hdev)
 	return settings;
 }
 
-#define PNP_INFO_SVCLASS_ID		0x1200
-
-static u8 *create_uuid16_list(struct hci_dev *hdev, u8 *data, ptrdiff_t len)
-{
-	u8 *ptr = data, *uuids_start = NULL;
-	struct bt_uuid *uuid;
-
-	if (len < 4)
-		return ptr;
-
-	list_for_each_entry(uuid, &hdev->uuids, list) {
-		u16 uuid16;
-
-		if (uuid->size != 16)
-			continue;
-
-		uuid16 = get_unaligned_le16(&uuid->uuid[12]);
-		if (uuid16 < 0x1100)
-			continue;
-
-		if (uuid16 == PNP_INFO_SVCLASS_ID)
-			continue;
-
-		if (!uuids_start) {
-			uuids_start = ptr;
-			uuids_start[0] = 1;
-			uuids_start[1] = EIR_UUID16_ALL;
-			ptr += 2;
-		}
-
-		/* Stop if not enough space to put next UUID */
-		if ((ptr - data) + sizeof(u16) > len) {
-			uuids_start[1] = EIR_UUID16_SOME;
-			break;
-		}
-
-		*ptr++ = (uuid16 & 0x00ff);
-		*ptr++ = (uuid16 & 0xff00) >> 8;
-		uuids_start[0] += sizeof(uuid16);
-	}
-
-	return ptr;
-}
-
-static u8 *create_uuid32_list(struct hci_dev *hdev, u8 *data, ptrdiff_t len)
-{
-	u8 *ptr = data, *uuids_start = NULL;
-	struct bt_uuid *uuid;
-
-	if (len < 6)
-		return ptr;
-
-	list_for_each_entry(uuid, &hdev->uuids, list) {
-		if (uuid->size != 32)
-			continue;
-
-		if (!uuids_start) {
-			uuids_start = ptr;
-			uuids_start[0] = 1;
-			uuids_start[1] = EIR_UUID32_ALL;
-			ptr += 2;
-		}
-
-		/* Stop if not enough space to put next UUID */
-		if ((ptr - data) + sizeof(u32) > len) {
-			uuids_start[1] = EIR_UUID32_SOME;
-			break;
-		}
-
-		memcpy(ptr, &uuid->uuid[12], sizeof(u32));
-		ptr += sizeof(u32);
-		uuids_start[0] += sizeof(u32);
-	}
-
-	return ptr;
-}
-
-static u8 *create_uuid128_list(struct hci_dev *hdev, u8 *data, ptrdiff_t len)
-{
-	u8 *ptr = data, *uuids_start = NULL;
-	struct bt_uuid *uuid;
-
-	if (len < 18)
-		return ptr;
-
-	list_for_each_entry(uuid, &hdev->uuids, list) {
-		if (uuid->size != 128)
-			continue;
-
-		if (!uuids_start) {
-			uuids_start = ptr;
-			uuids_start[0] = 1;
-			uuids_start[1] = EIR_UUID128_ALL;
-			ptr += 2;
-		}
-
-		/* Stop if not enough space to put next UUID */
-		if ((ptr - data) + 16 > len) {
-			uuids_start[1] = EIR_UUID128_SOME;
-			break;
-		}
-
-		memcpy(ptr, uuid->uuid, 16);
-		ptr += 16;
-		uuids_start[0] += 16;
-	}
-
-	return ptr;
-}
-
 static struct mgmt_pending_cmd *pending_find(u16 opcode, struct hci_dev *hdev)
 {
 	return mgmt_pending_find(HCI_CHANNEL_CONTROL, opcode, hdev);
@@ -882,83 +772,6 @@ bool mgmt_get_connectable(struct hci_dev *hdev)
 	return hci_dev_test_flag(hdev, HCI_CONNECTABLE);
 }
 
-static void create_eir(struct hci_dev *hdev, u8 *data)
-{
-	u8 *ptr = data;
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
-		ptr += (name_len + 2);
-	}
-
-	if (hdev->inq_tx_power != HCI_TX_POWER_INVALID) {
-		ptr[0] = 2;
-		ptr[1] = EIR_TX_POWER;
-		ptr[2] = (u8) hdev->inq_tx_power;
-
-		ptr += 3;
-	}
-
-	if (hdev->devid_source > 0) {
-		ptr[0] = 9;
-		ptr[1] = EIR_DEVICE_ID;
-
-		put_unaligned_le16(hdev->devid_source, ptr + 2);
-		put_unaligned_le16(hdev->devid_vendor, ptr + 4);
-		put_unaligned_le16(hdev->devid_product, ptr + 6);
-		put_unaligned_le16(hdev->devid_version, ptr + 8);
-
-		ptr += 10;
-	}
-
-	ptr = create_uuid16_list(hdev, ptr, HCI_MAX_EIR_LENGTH - (ptr - data));
-	ptr = create_uuid32_list(hdev, ptr, HCI_MAX_EIR_LENGTH - (ptr - data));
-	ptr = create_uuid128_list(hdev, ptr, HCI_MAX_EIR_LENGTH - (ptr - data));
-}
-
-static void update_eir(struct hci_request *req)
-{
-	struct hci_dev *hdev = req->hdev;
-	struct hci_cp_write_eir cp;
-
-	if (!hdev_is_powered(hdev))
-		return;
-
-	if (!lmp_ext_inq_capable(hdev))
-		return;
-
-	if (!hci_dev_test_flag(hdev, HCI_SSP_ENABLED))
-		return;
-
-	if (hci_dev_test_flag(hdev, HCI_SERVICE_CACHE))
-		return;
-
-	memset(&cp, 0, sizeof(cp));
-
-	create_eir(hdev, cp.data);
-
-	if (memcmp(cp.data, hdev->eir, sizeof(cp.data)) == 0)
-		return;
-
-	memcpy(hdev->eir, cp.data, sizeof(cp.data));
-
-	hci_req_add(req, HCI_OP_WRITE_EIR, sizeof(cp), &cp);
-}
-
 static void service_cache_off(struct work_struct *work)
 {
 	struct hci_dev *hdev = container_of(work, struct hci_dev,
@@ -972,7 +785,7 @@ static void service_cache_off(struct work_struct *work)
 
 	hci_dev_lock(hdev);
 
-	update_eir(&req);
+	__hci_req_update_eir(&req);
 	__hci_req_update_class(&req);
 
 	hci_dev_unlock(hdev);
@@ -2074,7 +1887,7 @@ static int add_uuid(struct sock *sk, struct hci_dev *hdev, void *data, u16 len)
 	hci_req_init(&req, hdev);
 
 	__hci_req_update_class(&req);
-	update_eir(&req);
+	__hci_req_update_eir(&req);
 
 	err = hci_req_run(&req, add_uuid_complete);
 	if (err < 0) {
@@ -2174,7 +1987,7 @@ update_class:
 	hci_req_init(&req, hdev);
 
 	__hci_req_update_class(&req);
-	update_eir(&req);
+	__hci_req_update_eir(&req);
 
 	err = hci_req_run(&req, remove_uuid_complete);
 	if (err < 0) {
@@ -2249,7 +2062,7 @@ static int set_dev_class(struct sock *sk, struct hci_dev *hdev, void *data,
 		hci_dev_unlock(hdev);
 		cancel_delayed_work_sync(&hdev->service_cache);
 		hci_dev_lock(hdev);
-		update_eir(&req);
+		__hci_req_update_eir(&req);
 	}
 
 	__hci_req_update_class(&req);
@@ -3232,7 +3045,7 @@ static int set_local_name(struct sock *sk, struct hci_dev *hdev, void *data,
 
 	if (lmp_bredr_capable(hdev)) {
 		__hci_req_update_name(&req);
-		update_eir(&req);
+		__hci_req_update_eir(&req);
 	}
 
 	/* The name is stored in the scan response data and so
@@ -3917,7 +3730,7 @@ static int set_device_id(struct sock *sk, struct hci_dev *hdev, void *data,
 				NULL, 0);
 
 	hci_req_init(&req, hdev);
-	update_eir(&req);
+	__hci_req_update_eir(&req);
 	hci_req_run(&req, NULL);
 
 	hci_dev_unlock(hdev);
@@ -6759,7 +6572,7 @@ static int powered_update_hci(struct hci_dev *hdev)
 		__hci_req_update_scan(&req);
 		__hci_req_update_class(&req);
 		__hci_req_update_name(&req);
-		update_eir(&req);
+		__hci_req_update_eir(&req);
 	}
 
 	return hci_req_run(&req, powered_complete);
@@ -7380,7 +7193,7 @@ void mgmt_ssp_enable_complete(struct hci_dev *hdev, u8 enable, u8 status)
 		if (hci_dev_test_flag(hdev, HCI_USE_DEBUG_KEYS))
 			hci_req_add(&req, HCI_OP_WRITE_SSP_DEBUG_MODE,
 				    sizeof(enable), &enable);
-		update_eir(&req);
+		__hci_req_update_eir(&req);
 	} else {
 		clear_eir(&req);
 	}
-- 
2.5.0

