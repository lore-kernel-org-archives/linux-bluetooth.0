Return-Path: <cyrus@holtmann.org>
From: Claudio Takahasi <claudio.takahasi@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: claudio.takahasi@openbossa.org,
	Andre Guedes <andre.guedes@openbossa.org>
Subject: [PATCH BlueZ v0 01/16] gatt: Add function to create constant attributes
Date: Mon, 10 Mar 2014 15:50:30 -0300
Message-Id: <1394477445-8987-2-git-send-email-claudio.takahasi@openbossa.org>
In-Reply-To: <1394477445-8987-1-git-send-email-claudio.takahasi@openbossa.org>
References: <1394477445-8987-1-git-send-email-claudio.takahasi@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andre Guedes <andre.guedes@openbossa.org>

This patch adds a helper function to create attribute with static
values. It is intended to be used to create GATT services, and
characteristic declarations.
---
 src/gatt.c | 32 ++++++++++++++++++++++++++------
 1 file changed, 26 insertions(+), 6 deletions(-)

diff --git a/src/gatt.c b/src/gatt.c
index f7b74d6..7882a91 100644
--- a/src/gatt.c
+++ b/src/gatt.c
@@ -30,6 +30,7 @@
 #include "log.h"
 #include "lib/uuid.h"
 #include "attrib/att.h"
+#include "src/shared/util.h"
 
 #include "gatt-dbus.h"
 #include "gatt.h"
@@ -48,6 +49,25 @@ struct btd_attribute {
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
+	struct btd_attribute *attr = malloc0(sizeof(struct btd_attribute) +
+									len);
+
+	memcpy(&attr->type, type, sizeof(*type));
+	memcpy(&attr->value, value, len);
+	attr->value_len = len;
+
+	return attr;
+}
+
 static int local_database_add(uint16_t handle, struct btd_attribute *attr)
 {
 	attr->handle = handle;
@@ -59,9 +79,9 @@ static int local_database_add(uint16_t handle, struct btd_attribute *attr)
 
 struct btd_attribute *btd_gatt_add_service(const bt_uuid_t *uuid)
 {
+	struct btd_attribute *attr;
 	uint16_t len = bt_uuid_len(uuid);
-	struct btd_attribute *attr = g_malloc0(sizeof(struct btd_attribute) +
-									len);
+	uint8_t value[len];
 
 	/*
 	 * Service DECLARATION
@@ -75,13 +95,13 @@ struct btd_attribute *btd_gatt_add_service(const bt_uuid_t *uuid)
 	 * (2) - 2 or 16 octets: Service UUID
 	 */
 
-	attr->type = primary_uuid;
+	/* Set attribute value */
+	att_put_uuid(*uuid, value);
 
-	att_put_uuid(*uuid, attr->value);
-	attr->value_len = len;
+	attr = new_const_attribute(&primary_uuid, value, len);
 
 	if (local_database_add(next_handle, attr) < 0) {
-		g_free(attr);
+		free(attr);
 		return NULL;
 	}
 
-- 
1.8.3.1

