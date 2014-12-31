Return-Path: <cyrus@holtmann.org>
From: Michael Janssen <jamuraa@chromium.org>
To: linux-bluetooth@vger.kernel.org
Cc: Michael Janssen <jamuraa@chromium.org>
Subject: [PATCH BlueZ 04/14] unit/gatt: Add add_desc_with_value function
Date: Tue, 30 Dec 2014 16:32:22 -0800
Message-Id: <1419985952-18334-5-git-send-email-jamuraa@chromium.org>
In-Reply-To: <1419985952-18334-1-git-send-email-jamuraa@chromium.org>
References: <1419985952-18334-1-git-send-email-jamuraa@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This function mirrors add_char_with_value and deduplicates some repeated
code from convenience functions.
---
 unit/test-gatt.c | 43 +++++++++++++++++++++----------------------
 1 file changed, 21 insertions(+), 22 deletions(-)

diff --git a/unit/test-gatt.c b/unit/test-gatt.c
index bee8f37..4f5857f 100644
--- a/unit/test-gatt.c
+++ b/unit/test-gatt.c
@@ -660,47 +660,46 @@ static struct gatt_db_attribute *add_char_with_value(struct gatt_db *db,
 	return attrib;
 }
 
+static struct gatt_db_attribute *
+add_desc_with_value(struct gatt_db_attribute *att, bt_uuid_t *uuid,
+				uint32_t att_perms, const uint8_t *value,
+				size_t len)
+{
+	struct gatt_db_attribute *desc_att;
+
+	desc_att = gatt_db_service_add_descriptor(att, uuid, att_perms, NULL,
+								NULL, NULL);
+
+	gatt_db_attribute_write(desc_att, 0, value, len, 0x00, NULL,
+							att_write_cb, NULL);
+
+	return desc_att;
+}
+
 static struct gatt_db_attribute *add_ccc(struct gatt_db_attribute *chrc_att,
 								bool writable)
 {
-	struct gatt_db_attribute *desc_att;
 	bt_uuid_t uuid;
-	uint32_t permissions = BT_ATT_PERM_READ;
 	uint16_t tmp;
 
-	if (writable)
-		permissions |= BT_ATT_PERM_WRITE;
-
 	bt_uuid16_create(&uuid, GATT_CLIENT_CHARAC_CFG_UUID);
-	desc_att = gatt_db_service_add_descriptor(chrc_att, &uuid, permissions,
-							NULL, NULL, NULL);
-
 	tmp = 0x0000;
-	gatt_db_attribute_write(desc_att, 0, (uint8_t *)&tmp, sizeof(uint16_t),
-						0x00, NULL, att_write_cb, NULL);
 
-	return desc_att;
+	return add_desc_with_value(chrc_att, &uuid,
+					BT_ATT_PERM_READ | BT_ATT_PERM_WRITE,
+					(uint8_t *)&tmp, sizeof(tmp));
 }
 
 static struct gatt_db_attribute *
 add_user_description(struct gatt_db_attribute *chrc_att, const char *desc,
 								bool writable)
 {
-	struct gatt_db_attribute *desc_att;
 	bt_uuid_t uuid;
-	uint32_t permissions = BT_ATT_PERM_READ;
-
-	if (writable)
-		permissions |= BT_ATT_PERM_WRITE;
 
 	bt_uuid16_create(&uuid, GATT_CHARAC_USER_DESC_UUID);
-	desc_att = gatt_db_service_add_descriptor(chrc_att, &uuid, permissions,
-							NULL, NULL, NULL);
 
-	gatt_db_attribute_write(desc_att, 0, (uint8_t *)desc, strlen(desc),
-						0x00, NULL, att_write_cb, NULL);
-
-	return desc_att;
+	return add_desc_with_value(chrc_att, &uuid, 0x03, (uint8_t *)desc,
+						strlen(desc));
 }
 
 
-- 
2.2.0.rc0.207.ga3a616c

