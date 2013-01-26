Return-Path: <cyrus@holtmann.org>
From: Johan Hedberg <johan.hedberg@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 9/9 v4] Bluetooth: Add support for 128-bit UUIDs in EIR data
Date: Sun, 27 Jan 2013 00:31:35 +0200
Message-Id: <1359239495-3444-10-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1359239495-3444-1-git-send-email-johan.hedberg@gmail.com>
References: <1359239495-3444-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

This patch adds the necessary code for encoding a list of 128-bit UUIDs
into the EIR data.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
Acked-by: Marcel Holtmann <marcel@holtmann.org>
---
 net/bluetooth/mgmt.c |   34 ++++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 0110a75..fbc8edf 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -510,6 +510,39 @@ static u8 *create_uuid32_list(struct hci_dev *hdev, u8 *data, ptrdiff_t len)
 	return ptr;
 }
 
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
 static void create_eir(struct hci_dev *hdev, u8 *data)
 {
 	u8 *ptr = data;
@@ -555,6 +588,7 @@ static void create_eir(struct hci_dev *hdev, u8 *data)
 
 	ptr = create_uuid16_list(hdev, ptr, HCI_MAX_EIR_LENGTH - (ptr - data));
 	ptr = create_uuid32_list(hdev, ptr, HCI_MAX_EIR_LENGTH - (ptr - data));
+	ptr = create_uuid128_list(hdev, ptr, HCI_MAX_EIR_LENGTH - (ptr - data));
 }
 
 static int update_eir(struct hci_dev *hdev)
-- 
1.7.10.4

