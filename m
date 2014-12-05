Return-Path: <cyrus@holtmann.org>
From: Johan Hedberg <johan.hedberg@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Bluetooth: Remove redundant reverse_base_uuid variable
Date: Fri,  5 Dec 2014 13:40:01 +0200
Message-Id: <1417779601-9394-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

The mgmt.c file already has a bluetooth_base_uuid variable which has the
exact same value as the reverse_base_uuid one. This patch removes the
redundant variable.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
This should apply both before and after my cmd_complete patch set, but
I've only tested it after it.

 net/bluetooth/mgmt.c | 12 ++----------
 1 file changed, 2 insertions(+), 10 deletions(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 3bbc93ed4206..748454e20821 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -6915,14 +6915,6 @@ void mgmt_read_local_oob_data_complete(struct hci_dev *hdev, u8 *hash192,
 	mgmt_pending_remove(cmd);
 }
 
-/* this is reversed hex representation of bluetooth base uuid. We need it for
- * service uuid parsing in eir.
- */
-static const u8 reverse_base_uuid[] = {
-			0xfb, 0x34, 0x9b, 0x5f, 0x80, 0x00, 0x00, 0x80,
-			0x00, 0x10, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
-};
-
 static inline bool has_uuid(u8 *uuid, u16 uuid_count, u8 (*uuids)[16])
 {
 	int i;
@@ -6954,7 +6946,7 @@ static bool eir_has_uuids(u8 *eir, u16 eir_len, u16 uuid_count, u8 (*uuids)[16])
 		case EIR_UUID16_ALL:
 		case EIR_UUID16_SOME:
 			for (i = 0; i + 3 <= field_len; i += 2) {
-				memcpy(uuid, reverse_base_uuid, 16);
+				memcpy(uuid, bluetooth_base_uuid, 16);
 				uuid[13] = eir[i + 3];
 				uuid[12] = eir[i + 2];
 				if (has_uuid(uuid, uuid_count, uuids))
@@ -6964,7 +6956,7 @@ static bool eir_has_uuids(u8 *eir, u16 eir_len, u16 uuid_count, u8 (*uuids)[16])
 		case EIR_UUID32_ALL:
 		case EIR_UUID32_SOME:
 			for (i = 0; i + 5 <= field_len; i += 4) {
-				memcpy(uuid, reverse_base_uuid, 16);
+				memcpy(uuid, bluetooth_base_uuid, 16);
 				uuid[15] = eir[i + 5];
 				uuid[14] = eir[i + 4];
 				uuid[13] = eir[i + 3];
-- 
2.1.0

