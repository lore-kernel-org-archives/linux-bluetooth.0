Return-Path: <cyrus@holtmann.org>
From: Marcel Holtmann <marcel@holtmann.org>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 6/7] Bluetooth: Add logic for UUID filter handling
Date: Fri,  5 Dec 2014 10:55:58 +0100
Message-Id: <1417773359-122811-6-git-send-email-marcel@holtmann.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Jakub Pawlowski <jpawlowski@google.com>

The previous patch provided the framework for integrating the UUID
filtering into the service discovery. This patch now provides the
actual filter logic.

Signed-off-by: Jakub Pawlowski <jpawlowski@google.com>
Signed-off-by: Marcel Holtmann <marcel@holtmann.org>
---
 net/bluetooth/mgmt.c | 70 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 70 insertions(+)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index e39190a51590..be4219d8c07d 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -6802,8 +6802,78 @@ void mgmt_read_local_oob_data_complete(struct hci_dev *hdev, u8 *hash192,
 	mgmt_pending_remove(cmd);
 }
 
+/* this is reversed hex representation of bluetooth base uuid. We need it for
+ * service uuid parsing in eir.
+ */
+static const u8 reverse_base_uuid[] = {
+			0xfb, 0x34, 0x9b, 0x5f, 0x80, 0x00, 0x00, 0x80,
+			0x00, 0x10, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
+};
+
+static inline bool has_uuid(u8 *uuid, u16 uuid_count, u8 (*uuids)[16])
+{
+	int i;
+
+	for (i = 0; i < uuid_count; i++) {
+		if (!memcmp(uuid, uuids[i], 16))
+			return true;
+	}
+
+	return false;
+}
+
 static bool eir_has_uuids(u8 *eir, u16 eir_len, u16 uuid_count, u8 (*uuids)[16])
 {
+	u16 parsed = 0;
+
+	while (parsed < eir_len) {
+		u8 field_len = eir[0];
+		u8 uuid[16];
+		int i;
+
+		if (field_len == 0)
+			break;
+
+		if (eir_len - parsed < field_len + 1)
+			break;
+
+		switch (eir[1]) {
+		case EIR_UUID16_ALL:
+		case EIR_UUID16_SOME:
+			for (i = 0; i + 3 <= field_len; i += 2) {
+				memcpy(uuid, reverse_base_uuid, 16);
+				uuid[13] = eir[i + 3];
+				uuid[12] = eir[i + 2];
+				if (has_uuid(uuid, uuid_count, uuids))
+					return true;
+			}
+			break;
+		case EIR_UUID32_ALL:
+		case EIR_UUID32_SOME:
+			for (i = 0; i + 5 <= field_len; i += 4) {
+				memcpy(uuid, reverse_base_uuid, 16);
+				uuid[15] = eir[i + 5];
+				uuid[14] = eir[i + 4];
+				uuid[13] = eir[i + 3];
+				uuid[12] = eir[i + 2];
+				if (has_uuid(uuid, uuid_count, uuids))
+					return true;
+			}
+			break;
+		case EIR_UUID128_ALL:
+		case EIR_UUID128_SOME:
+			for (i = 0; i + 17 <= field_len; i += 16) {
+				memcpy(uuid, eir + i + 2, 16);
+				if (has_uuid(uuid, uuid_count, uuids))
+					return true;
+			}
+			break;
+		}
+
+		parsed += field_len + 1;
+		eir += field_len + 1;
+	}
+
 	return false;
 }
 
-- 
1.9.3

