Return-Path: <cyrus@holtmann.org>
From: Johan Hedberg <johan.hedberg@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/6 v2] Bluetooth: Simplify UUID16 list generation for EIR
Date: Fri, 25 Jan 2013 08:57:26 +0200
Message-Id: <1359097050-17552-3-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1359097050-17552-1-git-send-email-johan.hedberg@gmail.com>
References: <1359097050-17552-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

There's no need to use two separate loops to generate a UUID list for
the EIR data. This patch merges the two loops previously used for the
16-bit UUID list generation into a single loop, thus simplifying the
code a great deal.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/mgmt.c |   46 +++++++++++++++-------------------------------
 1 file changed, 15 insertions(+), 31 deletions(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 1257ed0..b3a1397 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -438,9 +438,8 @@ static u32 get_current_settings(struct hci_dev *hdev)
 static void create_eir(struct hci_dev *hdev, u8 *data)
 {
 	u8 *ptr = data;
+	u8 *uuids_start;
 	u16 eir_len = 0;
-	u16 uuid16_list[HCI_MAX_EIR_LENGTH / sizeof(u16)];
-	int i, truncated = 0;
 	struct bt_uuid *uuid;
 	size_t name_len;
 
@@ -485,7 +484,7 @@ static void create_eir(struct hci_dev *hdev, u8 *data)
 		ptr += 10;
 	}
 
-	memset(uuid16_list, 0, sizeof(uuid16_list));
+	uuids_start = NULL;
 
 	/* Group all UUID16 types */
 	list_for_each_entry(uuid, &hdev->uuid16, list) {
@@ -498,39 +497,24 @@ static void create_eir(struct hci_dev *hdev, u8 *data)
 		if (uuid16 == PNP_INFO_SVCLASS_ID)
 			continue;
 
+		if (!uuids_start) {
+			uuids_start = ptr;
+			uuids_start[0] = 1;
+			uuids_start[1] = EIR_UUID16_ALL;
+			ptr += 2;
+			eir_len += 2;
+		}
+
 		/* Stop if not enough space to put next UUID */
 		if (eir_len + 2 + sizeof(u16) > HCI_MAX_EIR_LENGTH) {
-			truncated = 1;
+			uuids_start[1] = EIR_UUID16_SOME;
 			break;
 		}
 
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
+		*ptr++ = (uuid16 & 0x00ff);
+		*ptr++ = (uuid16 & 0xff00) >> 8;
+		eir_len += sizeof(uuid16);
+		uuids_start[0] += sizeof(uuid16);
 	}
 }
 
-- 
1.7.10.4

