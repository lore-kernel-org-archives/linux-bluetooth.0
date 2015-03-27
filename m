Return-Path: <cyrus@holtmann.org>
From: Grzegorz Kolodziejczyk <grzegorz.kolodziejczyk@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] lib/uuid: Add uuid conversion to 16 bit uuid
Date: Fri, 27 Mar 2015 16:39:54 +0100
Message-Id: <1427470794-30222-1-git-send-email-grzegorz.kolodziejczyk@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch allows to cut bluetooth base if it's bluetooth base uuid.
If the uuid is bluetooth base, src uuid can be converted, otherwise
error is returned.
---
 lib/uuid.c | 44 ++++++++++++++++++++++++++++++++++++++++++++
 lib/uuid.h |  1 +
 2 files changed, 45 insertions(+)

diff --git a/lib/uuid.c b/lib/uuid.c
index 4f34b17..15fbd66 100644
--- a/lib/uuid.c
+++ b/lib/uuid.c
@@ -73,6 +73,34 @@ static void bt_uuid32_to_uuid128(const bt_uuid_t *src, bt_uuid_t *dst)
 	memcpy(&dst->value.u128.data[BASE_UUID32_OFFSET], &be32, sizeof(be32));
 }
 
+static int bt_uuid128_to_uuid16(const bt_uuid_t *src, bt_uuid_t *dst)
+{
+	if (memcmp(&src->value.u128.data, &bluetooth_base_uuid.data, 2) ||
+					memcmp(&src->value.u128.data[4],
+					&bluetooth_base_uuid.data[4], 12))
+		return -EINVAL;
+
+	dst->type = BT_UUID16;
+
+	memcpy(&dst->value.u16, &src->value.u128.data[BASE_UUID16_OFFSET],
+							sizeof(uint16_t));
+
+	return 0;
+}
+
+static int bt_uuid32_to_uuid16(const bt_uuid_t *src, bt_uuid_t *dst)
+{
+	/* Bluetooth base have zeroized first two bytes */
+	if (src->value.u32 & 0xffff0000)
+		return -EINVAL;
+
+	dst->type = BT_UUID16;
+
+	dst->value.u16 = src->value.u32 & 0x0000ffff;
+
+	return 0;
+}
+
 void bt_uuid_to_uuid128(const bt_uuid_t *src, bt_uuid_t *dst)
 {
 	switch (src->type) {
@@ -91,6 +119,22 @@ void bt_uuid_to_uuid128(const bt_uuid_t *src, bt_uuid_t *dst)
 	}
 }
 
+int bt_uuid_to_uuid16(const bt_uuid_t *src, bt_uuid_t *dst)
+{
+	switch (src->type) {
+	case BT_UUID128:
+		return bt_uuid128_to_uuid16(src, dst);
+	case BT_UUID32:
+		return bt_uuid32_to_uuid16(src, dst);
+	case BT_UUID16:
+		*dst = *src;
+		return 0;
+	case BT_UUID_UNSPEC:
+	default:
+		return -EINVAL;
+	}
+}
+
 static int bt_uuid128_cmp(const bt_uuid_t *u1, const bt_uuid_t *u2)
 {
 	return memcmp(&u1->value.u128, &u2->value.u128, sizeof(uint128_t));
diff --git a/lib/uuid.h b/lib/uuid.h
index 2dcfe9e..26f8532 100644
--- a/lib/uuid.h
+++ b/lib/uuid.h
@@ -161,6 +161,7 @@ int bt_uuid128_create(bt_uuid_t *btuuid, uint128_t value);
 
 int bt_uuid_cmp(const bt_uuid_t *uuid1, const bt_uuid_t *uuid2);
 void bt_uuid_to_uuid128(const bt_uuid_t *src, bt_uuid_t *dst);
+int bt_uuid_to_uuid16(const bt_uuid_t *src, bt_uuid_t *dst);
 
 #define MAX_LEN_UUID_STR 37
 
-- 
2.1.0

