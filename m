Return-Path: <cyrus@holtmann.org>
From: Syam Sidhardhan <s.syam@samsung.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFC PATCH v0 5/6] Bluetooth: Add support for UUID-32 bit parsing for
 EIR
Date: Thu, 24 Jan 2013 11:27:58 +0530
Message-id: <1359007079-11724-6-git-send-email-s.syam@samsung.com>
In-reply-to: <1359007079-11724-1-git-send-email-s.syam@samsung.com>
References: <1359007079-11724-1-git-send-email-s.syam@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch add the support for UUID 32-bit parsing for EIR.

Signed-off-by: Syam Sidhardhan <s.syam@samsung.com>
Tested-by: Chan-yeol Park <chanyeol.park@samsung.com>
---
 net/bluetooth/mgmt.c |   72 +++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 71 insertions(+), 1 deletion(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 446e4d3..e1fbf95 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -483,6 +483,18 @@ static u16 get_uuid16(u8 *uuid128)
 	return (u16) val;
 }
 
+static u32 get_uuid32(u8 *uuid128)
+{
+	int i;
+
+	for (i = 0; i < 12; i++) {
+		if (bluetooth_base_uuid[i] != uuid128[i])
+			return 0;
+	}
+
+	return get_unaligned_le32(&uuid128[12]);
+}
+
 static u16 update_eir_uuid16_list(u8 *list16, u8 *uuid, bool updated_32, bool updated_128, u16 eir_len, bool *truncated)
 {
 	int i;
@@ -533,6 +545,47 @@ static u16 update_eir_uuid16_list(u8 *list16, u8 *uuid, bool updated_32, bool up
 	return eir_len;
 }
 
+static u16 update_eir_uuid32_list(u8 *list32, u8 *uuid, bool updated_16, bool updated_128, u16 eir_len, bool *truncated)
+{
+	int i;
+	u32 uuid32;
+	u32 *uuid32_list = (u32 *) list32;
+
+	/* Group all UUID32 types */
+	uuid32 = get_uuid32(uuid);
+
+	/* Stop if not enough space to put next UUID32 */
+	if (eir_len + 2 + sizeof(u32) > HCI_MAX_EIR_LENGTH) {
+		*truncated = true;
+		return 1;
+	}
+
+	/* Check for duplicates */
+	for (i = 0; uuid32_list[i] != 0; i++)
+		if (uuid32_list[i] == uuid32)
+			break;
+
+	if (uuid32_list[i] == 0) {
+
+		/* if any other uuid types has been already added into the
+		 * corresponding list, then consider it's header length(2 bytes)
+		 * in eir_len calculation.
+		 */
+		if (uuid32_list[0] == 0) {
+			if (updated_16)
+				eir_len += 2;
+
+			if (updated_128 == true)
+				eir_len += 2;
+		}
+
+		uuid32_list[i] = uuid32;
+		eir_len += sizeof(u32);
+	}
+
+	return eir_len;
+}
+
 static u8 *prepare_eir_from_list(u8 *list, u8 *ptr, u16 type, bool truncated)
 {
 	int i;
@@ -615,7 +668,7 @@ static void create_eir(struct hci_dev *hdev, u8 *data)
 	u32 uuid32_list[HCI_MAX_EIR_LENGTH / sizeof(u32)];
 	struct bt_uuid *uuid;
 	size_t name_len;
-	bool truncated_16 = false;
+	bool truncated_16 = false, truncated_32 = false;
 	bool updated_128 = false;
 
 	name_len = strlen(hdev->dev_name);
@@ -682,6 +735,17 @@ static void create_eir(struct hci_dev *hdev, u8 *data)
 				break;
 
 			eir_len = ret;
+		} else if (uuid_type == EIR_TYPE_UUID32) {
+			ret = update_eir_uuid32_list((u8 *) uuid32_list,
+						     uuid->uuid,
+						     uuid16_list[0] ? 1 : 0,
+						     updated_128, eir_len,
+						     &truncated_32);
+			/* Truncated */
+			if (ret == 1)
+				break;
+
+			eir_len = ret;
 		}
 	} /* list_for_each_entry end */
 
@@ -690,6 +754,12 @@ static void create_eir(struct hci_dev *hdev, u8 *data)
 					    EIR_TYPE_UUID16, truncated_16);
 		eir_len += 2;
 	}
+
+	if (uuid32_list[0]) {
+		ptr = prepare_eir_from_list((u8 *) uuid32_list, ptr,
+					    EIR_TYPE_UUID32, truncated_32);
+		eir_len += 2;
+	}
 }
 
 static int update_eir(struct hci_dev *hdev)
-- 
1.7.9.5

