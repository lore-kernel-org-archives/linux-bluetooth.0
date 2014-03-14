Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: claudio.takahasi@openbossa.org,
	Andre Guedes <andre.guedes@openbossa.org>
Subject: [PATCH BlueZ v4 06/20] gatt: Add function to create constant attributes
Date: Fri, 14 Mar 2014 10:13:06 -0300
Message-Id: <1394802800-8424-7-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1394802800-8424-1-git-send-email-claudio.takahasi@openbossa.org>
References: <1394742168-31073-1-git-send-email-claudio.takahasi@openbossa.org>
 <1394802800-8424-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andre Guedes <andre.guedes@openbossa.org>

This patch adds a helper function to create attribute with static
values. It is intended to be used to create GATT services, and
characteristic declarations.
---
 src/gatt.c | 47 +++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 41 insertions(+), 6 deletions(-)

diff --git a/src/gatt.c b/src/gatt.c
index f7b74d6..56a1db1 100644
--- a/src/gatt.c
+++ b/src/gatt.c
@@ -30,6 +30,7 @@
 #include "log.h"
 #include "lib/uuid.h"
 #include "attrib/att.h"
+#include "src/shared/util.h"
 
 #include "gatt-dbus.h"
 #include "gatt.h"
@@ -48,6 +49,38 @@ struct btd_attribute {
 static GList *local_attribute_db;
 static uint16_t next_handle = 0x0001;
 
+static inline void put_uuid(const bt_uuid_t *src, void *dst)
+{
+	if (src->type == BT_UUID16)
+		put_le16(src->value.u16, dst);
+	else if (src->type == BT_UUID32)
+		put_le32(src->value.u32, dst);
+	else
+		put_le128(&(src->value.u128), dst);
+}
+
+/*
+ * Helper function to create new attributes containing constant/static values.
+ * eg: declaration of services/characteristics, and characteristics with
+ * fixed values.
+ */
+static struct btd_attribute *new_const_attribute(const bt_uuid_t *type,
+							const uint8_t *value,
+							uint16_t len)
+{
+	struct btd_attribute *attr;
+
+	attr = malloc0(sizeof(struct btd_attribute) + len);
+	if (attr == NULL)
+		return NULL;
+
+	attr->type = *type;
+	memcpy(&attr->value, value, len);
+	attr->value_len = len;
+
+	return attr;
+}
+
 static int local_database_add(uint16_t handle, struct btd_attribute *attr)
 {
 	attr->handle = handle;
@@ -59,9 +92,9 @@ static int local_database_add(uint16_t handle, struct btd_attribute *attr)
 
 struct btd_attribute *btd_gatt_add_service(const bt_uuid_t *uuid)
 {
+	struct btd_attribute *attr;
 	uint16_t len = bt_uuid_len(uuid);
-	struct btd_attribute *attr = g_malloc0(sizeof(struct btd_attribute) +
-									len);
+	uint8_t value[len];
 
 	/*
 	 * Service DECLARATION
@@ -75,13 +108,15 @@ struct btd_attribute *btd_gatt_add_service(const bt_uuid_t *uuid)
 	 * (2) - 2 or 16 octets: Service UUID
 	 */
 
-	attr->type = primary_uuid;
+	/* Set attribute value */
+	put_uuid(uuid, value);
 
-	att_put_uuid(*uuid, attr->value);
-	attr->value_len = len;
+	attr = new_const_attribute(&primary_uuid, value, len);
+	if (attr == NULL)
+		return NULL;
 
 	if (local_database_add(next_handle, attr) < 0) {
-		g_free(attr);
+		free(attr);
 		return NULL;
 	}
 
-- 
1.8.3.1

