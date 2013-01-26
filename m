Return-Path: <cyrus@holtmann.org>
From: Johan Hedberg <johan.hedberg@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 3/9 v4] Bluetooth: Keep track of UUID type upon addition
Date: Sun, 27 Jan 2013 00:31:29 +0200
Message-Id: <1359239495-3444-4-git-send-email-johan.hedberg@gmail.com>
In-Reply-To: <1359239495-3444-1-git-send-email-johan.hedberg@gmail.com>
References: <1359239495-3444-1-git-send-email-johan.hedberg@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Johan Hedberg <johan.hedberg@intel.com>

The primary purpose of the UUIDs is to enable generation of EIR and AD
data. In these data formats the UUIDs are split into separate fields
based on whether they're 16, 32 or 128 bit UUIDs. To make the generation
of these data fields simpler this patch adds a type member to the
bt_uuid struct and assigns a value to it as soon as the UUID is added to
the kernel. This way the type doesn't need to be calculated each time
the UUID list is later iterated.

Signed-off-by: Johan Hedberg <johan.hedberg@intel.com>
---
 include/net/bluetooth/hci_core.h |    1 +
 net/bluetooth/mgmt.c             |   48 ++++++++++++++++++--------------------
 2 files changed, 24 insertions(+), 25 deletions(-)

diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/hci_core.h
index bcf8ffe..90cf75a 100644
--- a/include/net/bluetooth/hci_core.h
+++ b/include/net/bluetooth/hci_core.h
@@ -86,6 +86,7 @@ struct bdaddr_list {
 struct bt_uuid {
 	struct list_head list;
 	u8 uuid[16];
+	u8 size;
 	u8 svc_hint;
 };
 
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 4fd45a3..8de6d57 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -435,28 +435,6 @@ static u32 get_current_settings(struct hci_dev *hdev)
 
 #define PNP_INFO_SVCLASS_ID		0x1200
 
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
-	val = get_unaligned_le32(&uuid128[12]);
-	if (val > 0xffff)
-		return 0;
-
-	return (u16) val;
-}
-
 static void create_eir(struct hci_dev *hdev, u8 *data)
 {
 	u8 *ptr = data;
@@ -513,10 +491,10 @@ static void create_eir(struct hci_dev *hdev, u8 *data)
 	list_for_each_entry(uuid, &hdev->uuids, list) {
 		u16 uuid16;
 
-		uuid16 = get_uuid16(uuid->uuid);
-		if (uuid16 == 0)
-			return;
+		if (uuid->size != 16)
+			continue;
 
+		uuid16 = get_unaligned_le16(&uuid->uuid[12]);
 		if (uuid16 < 0x1100)
 			continue;
 
@@ -1304,6 +1282,25 @@ unlock:
 	return err;
 }
 
+static const u8 bluetooth_base_uuid[] = {
+			0xfb, 0x34, 0x9b, 0x5f, 0x80, 0x00, 0x00, 0x80,
+			0x00, 0x10, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
+};
+
+static u8 get_uuid_size(const u8 *uuid)
+{
+	u32 val;
+
+	if (memcmp(uuid, bluetooth_base_uuid, 12))
+		return 128;
+
+	val = get_unaligned_le32(&uuid[12]);
+	if (val > 0xffff)
+		return 32;
+
+	return 16;
+}
+
 static int add_uuid(struct sock *sk, struct hci_dev *hdev, void *data, u16 len)
 {
 	struct mgmt_cp_add_uuid *cp = data;
@@ -1329,6 +1326,7 @@ static int add_uuid(struct sock *sk, struct hci_dev *hdev, void *data, u16 len)
 
 	memcpy(uuid->uuid, cp->uuid, 16);
 	uuid->svc_hint = cp->svc_hint;
+	uuid->size = get_uuid_size(cp->uuid);
 
 	list_add_tail(&uuid->list, &hdev->uuids);
 
-- 
1.7.10.4

