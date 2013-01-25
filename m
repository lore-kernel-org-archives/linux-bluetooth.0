Return-Path: <cyrus@holtmann.org>
From: Johan Hedberg <johan.hedberg@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 3/6 v2] Bluetooth: Remove useless eir_len variable from EIR creation
Date: Fri, 25 Jan 2013 08:57:27 +0200
Message-Id: <1359097050-17552-4-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1359097050-17552-1-git-send-email-johan.hedberg@gmail.com>
References: <1359097050-17552-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

The amount of data encoded so far in the create_eir() function can be
calculated simply through the difference between the data and ptr
pointer variables. The eir_len variable then becomes essentially
useless.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 net/bluetooth/mgmt.c |    8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index b3a1397..abf941d 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -439,7 +439,6 @@ static void create_eir(struct hci_dev *hdev, u8 *data)
 {
 	u8 *ptr = data;
 	u8 *uuids_start;
-	u16 eir_len = 0;
 	struct bt_uuid *uuid;
 	size_t name_len;
 
@@ -458,7 +457,6 @@ static void create_eir(struct hci_dev *hdev, u8 *data)
 
 		memcpy(ptr + 2, hdev->dev_name, name_len);
 
-		eir_len += (name_len + 2);
 		ptr += (name_len + 2);
 	}
 
@@ -467,7 +465,6 @@ static void create_eir(struct hci_dev *hdev, u8 *data)
 		ptr[1] = EIR_TX_POWER;
 		ptr[2] = (u8) hdev->inq_tx_power;
 
-		eir_len += 3;
 		ptr += 3;
 	}
 
@@ -480,7 +477,6 @@ static void create_eir(struct hci_dev *hdev, u8 *data)
 		put_unaligned_le16(hdev->devid_product, ptr + 6);
 		put_unaligned_le16(hdev->devid_version, ptr + 8);
 
-		eir_len += 10;
 		ptr += 10;
 	}
 
@@ -502,18 +498,16 @@ static void create_eir(struct hci_dev *hdev, u8 *data)
 			uuids_start[0] = 1;
 			uuids_start[1] = EIR_UUID16_ALL;
 			ptr += 2;
-			eir_len += 2;
 		}
 
 		/* Stop if not enough space to put next UUID */
-		if (eir_len + 2 + sizeof(u16) > HCI_MAX_EIR_LENGTH) {
+		if ((ptr - data) + 2 + sizeof(u16) > HCI_MAX_EIR_LENGTH) {
 			uuids_start[1] = EIR_UUID16_SOME;
 			break;
 		}
 
 		*ptr++ = (uuid16 & 0x00ff);
 		*ptr++ = (uuid16 & 0xff00) >> 8;
-		eir_len += sizeof(uuid16);
 		uuids_start[0] += sizeof(uuid16);
 	}
 }
-- 
1.7.10.4

