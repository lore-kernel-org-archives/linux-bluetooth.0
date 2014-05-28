Return-Path: <cyrus@holtmann.org>
From: Marcin Kraglak <marcin.kraglak@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/4] shared/gatt: Return integer value in get_attribute_permission
Date: Wed, 28 May 2014 08:53:59 +0200
Message-Id: <1401260041-693-2-git-send-email-marcin.kraglak@tieto.com>
In-Reply-To: <1401260041-693-1-git-send-email-marcin.kraglak@tieto.com>
References: <1401260041-693-1-git-send-email-marcin.kraglak@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Return -1 to notfiy user that given attribute cannot be found.
---
 src/shared/gatt-db.c | 7 ++++---
 src/shared/gatt-db.h | 2 +-
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/src/shared/gatt-db.c b/src/shared/gatt-db.c
index 5d5739d..e9a0846 100644
--- a/src/shared/gatt-db.c
+++ b/src/shared/gatt-db.c
@@ -30,6 +30,7 @@
 
 #define MAX_CHAR_DECL_VALUE_LEN 19
 #define MAX_INCLUDED_VALUE_LEN 6
+#define ATTRIBUTE_NOT_FOUND -1
 
 static const bt_uuid_t primary_service_uuid = { .type = BT_UUID16,
 					.value.u16 = GATT_PRIM_SVC_UUID };
@@ -735,7 +736,7 @@ uint16_t gatt_db_get_end_handle(struct gatt_db *db, uint16_t handle)
 	return service->attributes[0]->handle + service->num_handles - 1;
 }
 
-uint32_t gatt_db_get_attribute_permissions(struct gatt_db *db, uint16_t handle)
+int64_t gatt_db_get_attribute_permissions(struct gatt_db *db, uint16_t handle)
 {
 	struct gatt_db_attribute *attribute;
 	struct gatt_db_service *service;
@@ -744,7 +745,7 @@ uint32_t gatt_db_get_attribute_permissions(struct gatt_db *db, uint16_t handle)
 	service = queue_find(db->services, find_service_for_handle,
 							INT_TO_PTR(handle));
 	if (!service)
-		return 0;
+		return ATTRIBUTE_NOT_FOUND;
 
 	service_handle = service->attributes[0]->handle;
 
@@ -755,7 +756,7 @@ uint32_t gatt_db_get_attribute_permissions(struct gatt_db *db, uint16_t handle)
 	 */
 	attribute = service->attributes[handle - service_handle];
 	if (!attribute)
-		return 0;
+		return ATTRIBUTE_NOT_FOUND;
 
 	return attribute->permissions;
 }
diff --git a/src/shared/gatt-db.h b/src/shared/gatt-db.h
index 7336823..3ab3478 100644
--- a/src/shared/gatt-db.h
+++ b/src/shared/gatt-db.h
@@ -92,4 +92,4 @@ const bt_uuid_t *gatt_db_get_attribute_type(struct gatt_db *db,
 
 uint16_t gatt_db_get_end_handle(struct gatt_db *db, uint16_t handle);
 
-uint32_t gatt_db_get_attribute_permissions(struct gatt_db *db, uint16_t handle);
+int64_t gatt_db_get_attribute_permissions(struct gatt_db *db, uint16_t handle);
-- 
1.9.0

