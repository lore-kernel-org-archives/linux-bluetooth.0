Return-Path: <cyrus@holtmann.org>
From: Syam Sidhardhan <s.syam@samsung.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFC PATCH v0 4/6] Bluetooth: Add EIR UUID-16 bit parsing for EIR
Date: Thu, 24 Jan 2013 11:27:57 +0530
Message-id: <1359007079-11724-5-git-send-email-s.syam@samsung.com>
In-reply-to: <1359007079-11724-1-git-send-email-s.syam@samsung.com>
References: <1359007079-11724-1-git-send-email-s.syam@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Here we are enhancing the existing code to support 16bit UUID's along
with other types. Also it fixes one issue related to EIR 16 bit UUID
updation. Earlier UUID 16bit updation fails further when any other
non 16 bit UUID types are trying to get registed.

Signed-off-by: Syam Sidhardhan <s.syam@samsung.com>
Tested-by: Chan-yeol Park <chanyeol.park@samsung.com>
---
 net/bluetooth/mgmt.c |  117 ++++++++++++++++++++++++++++++++------------------
 1 file changed, 75 insertions(+), 42 deletions(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index d2569f8..446e4d3 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -483,6 +483,56 @@ static u16 get_uuid16(u8 *uuid128)
 	return (u16) val;
 }
 
+static u16 update_eir_uuid16_list(u8 *list16, u8 *uuid, bool updated_32, bool updated_128, u16 eir_len, bool *truncated)
+{
+	int i;
+	u16 uuid16;
+	u16 *uuid16_list = (u16 *) list16;
+
+	/* Group all UUID16 types */
+	uuid16 = get_uuid16(uuid);
+	if (uuid16 == 0)
+		return 0;
+
+	if (uuid16 < 0x1100)
+		return 0;
+
+	if (uuid16 == PNP_INFO_SVCLASS_ID)
+		return 0;
+
+	/* Stop if not enough space to put next UUID16 */
+	if (eir_len + 2 + sizeof(u16) > HCI_MAX_EIR_LENGTH) {
+		*truncated = true;
+		return 1;
+	}
+
+	/* Check for duplicates */
+	for (i = 0; uuid16_list[i] != 0; i++)
+		if (uuid16_list[i] == uuid16)
+			return 0;
+
+	if (uuid16_list[i] == 0) {
+
+		/* if any other uuid types has been already added into the
+		 * corresponding list, then consider it's header length(2 bytes)
+		 * in eir_len calculation.
+		 */
+		if (uuid16_list[0] == 0) {
+
+			if (updated_32)
+				eir_len += 2;
+
+			if (updated_128 == true)
+				eir_len += 2;
+		}
+
+		uuid16_list[i] = uuid16;
+		eir_len += sizeof(u16);
+	}
+
+	return eir_len;
+}
+
 static u8 *prepare_eir_from_list(u8 *list, u8 *ptr, u16 type, bool truncated)
 {
 	int i;
@@ -562,9 +612,11 @@ static void create_eir(struct hci_dev *hdev, u8 *data)
 	u8 *ptr = data;
 	u16 eir_len = 0;
 	u16 uuid16_list[HCI_MAX_EIR_LENGTH / sizeof(u16)];
-	int i, truncated = 0;
+	u32 uuid32_list[HCI_MAX_EIR_LENGTH / sizeof(u32)];
 	struct bt_uuid *uuid;
 	size_t name_len;
+	bool truncated_16 = false;
+	bool updated_128 = false;
 
 	name_len = strlen(hdev->dev_name);
 
@@ -608,54 +660,35 @@ static void create_eir(struct hci_dev *hdev, u8 *data)
 	}
 
 	memset(uuid16_list, 0, sizeof(uuid16_list));
+	memset(uuid32_list, 0, sizeof(uuid32_list));
 
-	/* Group all UUID16 types */
 	list_for_each_entry(uuid, &hdev->uuids, list) {
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
+		u16 uuid_type;
+		u16 ret;
+
+		uuid_type = get_uuid_type(uuid->uuid);
+
+		if (uuid_type == EIR_TYPE_UUID16) {
+			ret = update_eir_uuid16_list((u8 *) uuid16_list,
+						     uuid->uuid,
+						     uuid32_list[0] ? 1 : 0,
+						     updated_128, eir_len,
+						     &truncated_16);
+			if (ret == 0)
+				continue;
+
+			/* Truncated */
+			if (ret == 1)
 				break;
 
-		if (uuid16_list[i] == 0) {
-			uuid16_list[i] = uuid16;
-			eir_len += sizeof(u16);
+			eir_len = ret;
 		}
-	}
+	} /* list_for_each_entry end */
 
-	if (uuid16_list[0] != 0) {
-		u8 *length = ptr;
-
-		/* EIR Data type */
-		ptr[1] = truncated ? EIR_UUID16_SOME : EIR_UUID16_ALL;
-
-		ptr += 2;
+	if (uuid16_list[0]) {
+		ptr = prepare_eir_from_list((u8 *) uuid16_list, ptr,
+					    EIR_TYPE_UUID16, truncated_16);
 		eir_len += 2;
-
-		for (i = 0; uuid16_list[i] != 0; i++) {
-			*ptr++ = (uuid16_list[i] & 0x00ff);
-			*ptr++ = (uuid16_list[i] & 0xff00) >> 8;
-		}
-
-		/* EIR Data length */
-		*length = (i * sizeof(u16)) + 1;
 	}
 }
 
-- 
1.7.9.5

