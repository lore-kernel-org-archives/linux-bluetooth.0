Return-Path: <cyrus@holtmann.org>
From: Syam Sidhardhan <s.syam@samsung.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFC PATCH v0 6/6] Bluetooth: Add support for UUID-128 bit parsing for
 EIR
Date: Thu, 24 Jan 2013 11:27:59 +0530
Message-id: <1359007079-11724-7-git-send-email-s.syam@samsung.com>
In-reply-to: <1359007079-11724-1-git-send-email-s.syam@samsung.com>
References: <1359007079-11724-1-git-send-email-s.syam@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch add the support for UUID-128 bit parsing for the EIR.

Signed-off-by: Syam Sidhardhan <s.syam@samsung.com>
Tested-by: Chan-yeol Park <chanyeol.park@samsung.com>
---
 net/bluetooth/mgmt.c |   75 +++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 74 insertions(+), 1 deletion(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index e1fbf95..52cce2f 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -586,6 +586,52 @@ static u16 update_eir_uuid32_list(u8 *list32, u8 *uuid, bool updated_16, bool up
 	return eir_len;
 }
 
+static u16 update_eir_uuid128_list(u8 *list128, u8 *uuid, bool updated_16, bool updated_32, u16 eir_len, bool *truncated)
+{
+	int i;
+	u128 *uuid128_list = (u128 *) list128;
+	u128 u;
+
+	memset(u.data, 0, sizeof(u128));
+
+	/* Stop if not enough space to put next UUID128 */
+	if (eir_len + 2 + sizeof(u128) > HCI_MAX_EIR_LENGTH) {
+		*truncated = true;
+		return 1;
+	}
+
+	i = 0;
+
+	/* Comparing uuid128_list[i] with 0*/
+	while (memcmp(uuid128_list[i].data, u.data, sizeof(u128))) {
+		if (!memcmp(uuid128_list[i].data, uuid, sizeof(u128)))
+			break;
+
+		++i;
+	}
+
+	if (!memcmp(uuid128_list[i].data, u.data, sizeof(u128))) {
+
+		/* if any other uuid types has been already added into the
+		 * corresponding list, then consider it's header length(2 bytes)
+		 * in eir_len calculation.
+		 */
+		if (!memcmp(uuid128_list[0].data, u.data, sizeof(u128))) {
+			if (updated_16)
+				eir_len += 2;
+
+			if (updated_32)
+				eir_len += 2;
+
+		}
+
+		memcpy(uuid128_list[i].data, uuid, sizeof(u128));
+		eir_len += sizeof(u128);
+	}
+
+	return eir_len;
+}
+
 static u8 *prepare_eir_from_list(u8 *list, u8 *ptr, u16 type, bool truncated)
 {
 	int i;
@@ -666,10 +712,12 @@ static void create_eir(struct hci_dev *hdev, u8 *data)
 	u16 eir_len = 0;
 	u16 uuid16_list[HCI_MAX_EIR_LENGTH / sizeof(u16)];
 	u32 uuid32_list[HCI_MAX_EIR_LENGTH / sizeof(u32)];
+	u128 uuid128_list[HCI_MAX_EIR_LENGTH / sizeof(u128)];
 	struct bt_uuid *uuid;
 	size_t name_len;
-	bool truncated_16 = false, truncated_32 = false;
+	bool truncated_16 = false, truncated_32 = false, truncated_128 = false;
 	bool updated_128 = false;
+	u128 u;
 
 	name_len = strlen(hdev->dev_name);
 
@@ -714,6 +762,8 @@ static void create_eir(struct hci_dev *hdev, u8 *data)
 
 	memset(uuid16_list, 0, sizeof(uuid16_list));
 	memset(uuid32_list, 0, sizeof(uuid32_list));
+	memset(uuid128_list, 0, sizeof(uuid128_list));
+	memset(u.data, 0, sizeof(u128));
 
 	list_for_each_entry(uuid, &hdev->uuids, list) {
 		u16 uuid_type;
@@ -746,6 +796,23 @@ static void create_eir(struct hci_dev *hdev, u8 *data)
 				break;
 
 			eir_len = ret;
+		} else {
+			ret = update_eir_uuid128_list((u8 *) uuid128_list,
+						      uuid->uuid,
+						      uuid16_list[0] ? 1 : 0,
+						      uuid32_list[0] ? 1 : 0,
+						      eir_len,
+						      &truncated_128);
+			/* Truncated */
+			if (ret == 1)
+				break;
+
+			/* In other cases we will directly check uuid*_list[0].
+			 * Here we use a flag updated_128 to avoid memcmp().
+			 */
+			updated_128 = true;
+
+			eir_len = ret;
 		}
 	} /* list_for_each_entry end */
 
@@ -760,6 +827,12 @@ static void create_eir(struct hci_dev *hdev, u8 *data)
 					    EIR_TYPE_UUID32, truncated_32);
 		eir_len += 2;
 	}
+
+	if (memcmp(uuid128_list[0].data, u.data, sizeof(u128)) != 0) {
+		ptr = prepare_eir_from_list((u8 *) uuid128_list, ptr,
+					    EIR_TYPE_UUID128, truncated_128);
+		eir_len += 2;
+	}
 }
 
 static int update_eir(struct hci_dev *hdev)
-- 
1.7.9.5

