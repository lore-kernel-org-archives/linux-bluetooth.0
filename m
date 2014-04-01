Return-Path: <cyrus@holtmann.org>
From: Marcin Kraglak <marcin.kraglak@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] gatt: replace GList with struct queue
Date: Tue,  1 Apr 2014 14:02:51 +0200
Message-Id: <1396353771-10434-1-git-send-email-marcin.kraglak@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Store local attributes in queue instead of GList, which depends on Glib.
---
 src/gatt.c | 22 +++++++++++++---------
 1 file changed, 13 insertions(+), 9 deletions(-)

diff --git a/src/gatt.c b/src/gatt.c
index f07effa..018ca27 100644
--- a/src/gatt.c
+++ b/src/gatt.c
@@ -31,6 +31,7 @@
 #include "lib/uuid.h"
 #include "attrib/att.h"
 #include "src/shared/util.h"
+#include "src/shared/queue.h"
 
 #include "gatt-dbus.h"
 #include "gatt.h"
@@ -51,7 +52,7 @@ struct btd_attribute {
 	uint8_t value[0];
 };
 
-static GList *local_attribute_db;
+static struct queue *local_attribute_db;
 static uint16_t next_handle = 0x0001;
 
 static inline void put_uuid_le(const bt_uuid_t *src, void *dst)
@@ -104,13 +105,11 @@ static struct btd_attribute *new_attribute(const bt_uuid_t *type,
 	return attr;
 }
 
-static int local_database_add(uint16_t handle, struct btd_attribute *attr)
+static bool local_database_add(uint16_t handle, struct btd_attribute *attr)
 {
 	attr->handle = handle;
 
-	local_attribute_db = g_list_append(local_attribute_db, attr);
-
-	return 0;
+	return queue_push_tail(local_attribute_db, attr);
 }
 
 struct btd_attribute *btd_gatt_add_service(const bt_uuid_t *uuid)
@@ -138,7 +137,7 @@ struct btd_attribute *btd_gatt_add_service(const bt_uuid_t *uuid)
 	if (!attr)
 		return NULL;
 
-	if (local_database_add(next_handle, attr) < 0) {
+	if (!local_database_add(next_handle, attr)) {
 		free(attr);
 		return NULL;
 	}
@@ -191,7 +190,7 @@ struct btd_attribute *btd_gatt_add_char(const bt_uuid_t *uuid,
 	if (!char_value)
 		goto fail;
 
-	if (local_database_add(next_handle, char_decl) < 0)
+	if (!local_database_add(next_handle, char_decl))
 		goto fail;
 
 	next_handle = next_handle + 1;
@@ -209,7 +208,7 @@ struct btd_attribute *btd_gatt_add_char(const bt_uuid_t *uuid,
 	 * implementation (external entity).
 	 */
 
-	if (local_database_add(next_handle, char_value) < 0)
+	if (!local_database_add(next_handle, char_value))
 		/* TODO: remove declaration */
 		goto fail;
 
@@ -253,7 +252,7 @@ struct btd_attribute *btd_gatt_add_char_desc(const bt_uuid_t *uuid,
 	if (!attr)
 		return NULL;
 
-	if (local_database_add(next_handle, attr) < 0) {
+	if (!local_database_add(next_handle, attr)) {
 		free(attr);
 		return NULL;
 	}
@@ -267,6 +266,8 @@ void gatt_init(void)
 {
 	DBG("Starting GATT server");
 
+	local_attribute_db = queue_new();
+
 	gatt_dbus_manager_register();
 }
 
@@ -274,5 +275,8 @@ void gatt_cleanup(void)
 {
 	DBG("Stopping GATT server");
 
+	queue_destroy(local_attribute_db, free);
+	local_attribute_db = NULL;
+
 	gatt_dbus_manager_unregister();
 }
-- 
1.8.5.3

