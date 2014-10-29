Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ] shared/gatt-db: Fix use of INT_TO_PTR for handles
Date: Wed, 29 Oct 2014 11:26:32 +0200
Message-Id: <1414574792-2339-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This make use of UINT_TO_PTR since handles are uint16_t.
---
 src/shared/gatt-db.c | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/src/shared/gatt-db.c b/src/shared/gatt-db.c
index 65c5759..6b5e84c 100644
--- a/src/shared/gatt-db.c
+++ b/src/shared/gatt-db.c
@@ -67,7 +67,7 @@ static bool match_service_by_handle(const void *data, const void *user_data)
 {
 	const struct gatt_db_service *service = data;
 
-	return service->attributes[0]->handle == PTR_TO_INT(user_data);
+	return service->attributes[0]->handle == PTR_TO_UINT(user_data);
 }
 
 static struct gatt_db_attribute *new_attribute(const bt_uuid_t *type,
@@ -214,7 +214,7 @@ bool gatt_db_remove_service(struct gatt_db *db, uint16_t handle)
 	struct gatt_db_service *service;
 
 	service = queue_remove_if(db->services, match_service_by_handle,
-							INT_TO_PTR(handle));
+							UINT_TO_PTR(handle));
 	if (!service)
 		return false;
 
@@ -282,7 +282,7 @@ uint16_t gatt_db_add_characteristic(struct gatt_db *db, uint16_t handle,
 	int i;
 
 	service = queue_find(db->services, match_service_by_handle,
-							INT_TO_PTR(handle));
+							UINT_TO_PTR(handle));
 	if (!service)
 		return 0;
 
@@ -327,7 +327,7 @@ uint16_t gatt_db_add_char_descriptor(struct gatt_db *db, uint16_t handle,
 	int i;
 
 	service = queue_find(db->services, match_service_by_handle,
-							INT_TO_PTR(handle));
+							UINT_TO_PTR(handle));
 	if (!service)
 		return 0;
 
@@ -355,12 +355,12 @@ uint16_t gatt_db_add_included_service(struct gatt_db *db, uint16_t handle,
 	int index;
 
 	service = queue_find(db->services, match_service_by_handle,
-							INT_TO_PTR(handle));
+							UINT_TO_PTR(handle));
 	if (!service)
 		return 0;
 
 	included_service = queue_find(db->services, match_service_by_handle,
-						INT_TO_PTR(included_handle));
+						UINT_TO_PTR(included_handle));
 
 	if (!included_service)
 		return 0;
@@ -406,7 +406,7 @@ bool gatt_db_service_set_active(struct gatt_db *db, uint16_t handle,
 	struct gatt_db_service *service;
 
 	service = queue_find(db->services, match_service_by_handle,
-							INT_TO_PTR(handle));
+							UINT_TO_PTR(handle));
 	if (!service)
 		return false;
 
@@ -636,7 +636,7 @@ void gatt_db_find_information(struct gatt_db *db, uint16_t start_handle,
 static bool find_service_for_handle(const void *data, const void *user_data)
 {
 	const struct gatt_db_service *service = data;
-	uint16_t handle = PTR_TO_INT(user_data);
+	uint16_t handle = PTR_TO_UINT(user_data);
 	uint16_t start, end;
 
 	start = service->attributes[0]->handle;
@@ -657,7 +657,7 @@ bool gatt_db_read(struct gatt_db *db, uint16_t handle, uint16_t offset,
 		return false;
 
 	service = queue_find(db->services, find_service_for_handle,
-						INT_TO_PTR(handle));
+						UINT_TO_PTR(handle));
 	if (!service)
 		return false;
 
@@ -695,7 +695,7 @@ bool gatt_db_write(struct gatt_db *db, uint16_t handle, uint16_t offset,
 	struct gatt_db_attribute *a;
 
 	service = queue_find(db->services, find_service_for_handle,
-						INT_TO_PTR(handle));
+						UINT_TO_PTR(handle));
 	if (!service)
 		return false;
 
@@ -719,7 +719,7 @@ const bt_uuid_t *gatt_db_get_attribute_type(struct gatt_db *db,
 	uint16_t service_handle;
 
 	service = queue_find(db->services, find_service_for_handle,
-						INT_TO_PTR(handle));
+						UINT_TO_PTR(handle));
 	if (!service)
 		return NULL;
 
@@ -737,7 +737,7 @@ uint16_t gatt_db_get_end_handle(struct gatt_db *db, uint16_t handle)
 	struct gatt_db_service *service;
 
 	service = queue_find(db->services, find_service_for_handle,
-						INT_TO_PTR(handle));
+						UINT_TO_PTR(handle));
 	if (!service)
 		return 0;
 
@@ -750,7 +750,7 @@ bool gatt_db_get_service_uuid(struct gatt_db *db, uint16_t handle,
 	struct gatt_db_service *service;
 
 	service = queue_find(db->services, find_service_for_handle,
-						INT_TO_PTR(handle));
+						UINT_TO_PTR(handle));
 	if (!service)
 		return false;
 
@@ -783,7 +783,7 @@ bool gatt_db_get_attribute_permissions(struct gatt_db *db, uint16_t handle,
 	uint16_t service_handle;
 
 	service = queue_find(db->services, find_service_for_handle,
-							INT_TO_PTR(handle));
+							UINT_TO_PTR(handle));
 	if (!service)
 		return false;
 
-- 
1.9.3

