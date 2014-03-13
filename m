Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: claudio.takahasi@openbossa.org,
	Andre Guedes <andre.guedes@openbossa.org>
Subject: [PATCH BlueZ v2 02/17] gatt: Add function to create constant attributes
Date: Thu, 13 Mar 2014 11:38:38 -0300
Message-Id: <1394721533-6932-3-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1394721533-6932-1-git-send-email-claudio.takahasi@openbossa.org>
References: <1394641631-1534-1-git-send-email-claudio.takahasi@openbossa.org>
 <1394721533-6932-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andre Guedes <andre.guedes@openbossa.org>

This patch adds a helper function to create attribute with static
values. It is intended to be used to create GATT services, and
characteristic declarations.
---
 src/gatt.c | 37 +++++++++++++++++++++++++++++++------
 1 file changed, 31 insertions(+), 6 deletions(-)

diff --git a/src/gatt.c b/src/gatt.c
index f7b74d6..a4d1665 100644
--- a/src/gatt.c
+++ b/src/gatt.c
@@ -30,6 +30,7 @@
 #include "log.h"
 #include "lib/uuid.h"
 #include "attrib/att.h"
+#include "src/shared/util.h"
 
 #include "gatt-dbus.h"
 #include "gatt.h"
@@ -48,6 +49,28 @@ struct btd_attribute {
 static GList *local_attribute_db;
 static uint16_t next_handle = 0x0001;
 
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
@@ -59,9 +82,9 @@ static int local_database_add(uint16_t handle, struct btd_attribute *attr)
 
 struct btd_attribute *btd_gatt_add_service(const bt_uuid_t *uuid)
 {
+	struct btd_attribute *attr;
 	uint16_t len = bt_uuid_len(uuid);
-	struct btd_attribute *attr = g_malloc0(sizeof(struct btd_attribute) +
-									len);
+	uint8_t value[len];
 
 	/*
 	 * Service DECLARATION
@@ -75,13 +98,15 @@ struct btd_attribute *btd_gatt_add_service(const bt_uuid_t *uuid)
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

