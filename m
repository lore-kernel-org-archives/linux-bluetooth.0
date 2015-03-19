Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v3 1/7] shared/gatt-client: Fix handling of services
Date: Thu, 19 Mar 2015 16:21:21 +0200
Message-Id: <1426774887-25646-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Remote services may contain gaps between their handles so they need to be
inserted in a proper position.
---
v2: Fix gatt_db_get_attribute to work with non-sequential handles
v3: Fix gatt_db_service_foreach_desc to work with non-sequential handles

 src/shared/gatt-client.c |   8 ++-
 src/shared/gatt-db.c     | 147 +++++++++++++++++++++++++++++++++++++----------
 src/shared/gatt-db.h     |  17 ++++++
 3 files changed, 139 insertions(+), 33 deletions(-)

diff --git a/src/shared/gatt-client.c b/src/shared/gatt-client.c
index f33d8c9..3e28c6e 100644
--- a/src/shared/gatt-client.c
+++ b/src/shared/gatt-client.c
@@ -588,7 +588,8 @@ static bool discover_descs(struct discovery_op *op, bool *discovering)
 	*discovering = false;
 
 	while ((chrc_data = queue_pop_head(op->pending_chrcs))) {
-		attr = gatt_db_service_add_characteristic(op->cur_svc,
+		attr = gatt_db_service_insert_characteristic(op->cur_svc,
+							chrc_data->value_handle,
 							&chrc_data->uuid, 0,
 							chrc_data->properties,
 							NULL, NULL, NULL);
@@ -679,8 +680,9 @@ static void discover_descs_cb(bool success, uint8_t att_ecode,
 						"handle: 0x%04x, uuid: %s",
 						handle, uuid_str);
 
-		attr = gatt_db_service_add_descriptor(op->cur_svc, &uuid, 0,
-							NULL, NULL, NULL);
+		attr = gatt_db_service_insert_descriptor(op->cur_svc, handle,
+							&uuid, 0, NULL, NULL,
+							NULL);
 		if (!attr)
 			goto failed;
 
diff --git a/src/shared/gatt-db.c b/src/shared/gatt-db.c
index eb81372..2b2090c 100644
--- a/src/shared/gatt-db.c
+++ b/src/shared/gatt-db.c
@@ -158,6 +158,7 @@ static void attribute_destroy(struct gatt_db_attribute *attribute)
 }
 
 static struct gatt_db_attribute *new_attribute(struct gatt_db_service *service,
+							uint16_t handle,
 							const bt_uuid_t *type,
 							const uint8_t *val,
 							uint16_t len)
@@ -169,6 +170,7 @@ static struct gatt_db_attribute *new_attribute(struct gatt_db_service *service,
 		return NULL;
 
 	attribute->service = service;
+	attribute->handle = handle;
 	attribute->uuid = *type;
 	attribute->value_len = len;
 	if (len) {
@@ -371,6 +373,7 @@ static bool le_to_uuid(const uint8_t *src, size_t len, bt_uuid_t *uuid)
 }
 
 static struct gatt_db_service *gatt_db_service_create(const bt_uuid_t *uuid,
+							uint16_t handle,
 							bool primary,
 							uint16_t num_handles)
 {
@@ -399,7 +402,8 @@ static struct gatt_db_service *gatt_db_service_create(const bt_uuid_t *uuid,
 
 	len = uuid_to_le(uuid, value);
 
-	service->attributes[0] = new_attribute(service, type, value, len);
+	service->attributes[0] = new_attribute(service, handle, type, value,
+									len);
 	if (!service->attributes[0]) {
 		gatt_db_service_destroy(service);
 		return NULL;
@@ -533,7 +537,7 @@ struct gatt_db_attribute *gatt_db_insert_service(struct gatt_db *db,
 	if (!find_insert_loc(db, handle, handle + num_handles - 1, &after))
 		return NULL;
 
-	service = gatt_db_service_create(uuid, primary, num_handles);
+	service = gatt_db_service_create(uuid, handle, primary, num_handles);
 
 	if (!service)
 		return NULL;
@@ -663,8 +667,9 @@ static void set_attribute_data(struct gatt_db_attribute *attribute,
 	attribute->user_data = user_data;
 }
 
-struct gatt_db_attribute *
-gatt_db_service_add_characteristic(struct gatt_db_attribute *attrib,
+static struct gatt_db_attribute *
+service_insert_characteristic(struct gatt_db_service *service,
+					uint16_t handle,
 					const bt_uuid_t *uuid,
 					uint32_t permissions,
 					uint8_t properties,
@@ -672,35 +677,38 @@ gatt_db_service_add_characteristic(struct gatt_db_attribute *attrib,
 					gatt_db_write_t write_func,
 					void *user_data)
 {
-	struct gatt_db_service *service;
 	uint8_t value[MAX_CHAR_DECL_VALUE_LEN];
 	uint16_t len = 0;
 	int i;
 
-	if (!attrib)
+	/* Check if handle is in within service range */
+	if (handle && handle <= service->attributes[0]->handle)
 		return NULL;
 
-	service = attrib->service;
-
 	i = get_attribute_index(service, 1);
 	if (!i)
 		return NULL;
 
+	if (!handle)
+		handle = get_handle_at_index(service, i - 1) + 2;
+
 	value[0] = properties;
 	len += sizeof(properties);
+
 	/* We set handle of characteristic value, which will be added next */
-	put_le16(get_handle_at_index(service, i - 1) + 2, &value[1]);
+	put_le16(handle, &value[1]);
 	len += sizeof(uint16_t);
 	len += uuid_to_le(uuid, &value[3]);
 
-	service->attributes[i] = new_attribute(service, &characteristic_uuid,
-								value, len);
+	service->attributes[i] = new_attribute(service, handle - 1,
+							&characteristic_uuid,
+							value, len);
 	if (!service->attributes[i])
 		return NULL;
 
-	attribute_update(service, i++);
+	i++;
 
-	service->attributes[i] = new_attribute(service, uuid, NULL, 0);
+	service->attributes[i] = new_attribute(service, handle, uuid, NULL, 0);
 	if (!service->attributes[i]) {
 		free(service->attributes[i - 1]);
 		return NULL;
@@ -709,37 +717,109 @@ gatt_db_service_add_characteristic(struct gatt_db_attribute *attrib,
 	set_attribute_data(service->attributes[i], read_func, write_func,
 							permissions, user_data);
 
-	return attribute_update(service, i);
+	return service->attributes[i];
 }
 
 struct gatt_db_attribute *
-gatt_db_service_add_descriptor(struct gatt_db_attribute *attrib,
+gatt_db_service_insert_characteristic(struct gatt_db_attribute *attrib,
+					uint16_t handle,
 					const bt_uuid_t *uuid,
 					uint32_t permissions,
+					uint8_t properties,
 					gatt_db_read_t read_func,
 					gatt_db_write_t write_func,
 					void *user_data)
 {
-	struct gatt_db_service *service;
-	int i;
+	if (!attrib || !handle)
+		return NULL;
 
+	return service_insert_characteristic(attrib->service, handle, uuid,
+						permissions, properties,
+						read_func, write_func,
+						user_data);
+}
+
+struct gatt_db_attribute *
+gatt_db_service_add_characteristic(struct gatt_db_attribute *attrib,
+					const bt_uuid_t *uuid,
+					uint32_t permissions,
+					uint8_t properties,
+					gatt_db_read_t read_func,
+					gatt_db_write_t write_func,
+					void *user_data)
+{
 	if (!attrib)
 		return NULL;
 
-	service = attrib->service;
+	return service_insert_characteristic(attrib->service, 0, uuid,
+						permissions, properties,
+						read_func, write_func,
+						user_data);
+}
+
+static struct gatt_db_attribute *
+service_insert_descriptor(struct gatt_db_service *service,
+					uint16_t handle,
+					const bt_uuid_t *uuid,
+					uint32_t permissions,
+					gatt_db_read_t read_func,
+					gatt_db_write_t write_func,
+					void *user_data)
+{
+	int i;
 
 	i = get_attribute_index(service, 0);
 	if (!i)
 		return NULL;
 
-	service->attributes[i] = new_attribute(service, uuid, NULL, 0);
+	/* Check if handle is in within service range */
+	if (handle && handle <= service->attributes[0]->handle)
+		return NULL;
+
+	if (!handle)
+		handle = get_handle_at_index(service, i - 1) + 1;
+
+	service->attributes[i] = new_attribute(service, handle, uuid, NULL, 0);
 	if (!service->attributes[i])
 		return NULL;
 
 	set_attribute_data(service->attributes[i], read_func, write_func,
 							permissions, user_data);
 
-	return attribute_update(service, i);
+	return service->attributes[i];
+}
+
+struct gatt_db_attribute *
+gatt_db_service_insert_descriptor(struct gatt_db_attribute *attrib,
+					uint16_t handle,
+					const bt_uuid_t *uuid,
+					uint32_t permissions,
+					gatt_db_read_t read_func,
+					gatt_db_write_t write_func,
+					void *user_data)
+{
+	if (!attrib || !handle)
+		return NULL;
+
+	return service_insert_descriptor(attrib->service, handle, uuid,
+					permissions, read_func, write_func,
+					user_data);
+}
+
+struct gatt_db_attribute *
+gatt_db_service_add_descriptor(struct gatt_db_attribute *attrib,
+					const bt_uuid_t *uuid,
+					uint32_t permissions,
+					gatt_db_read_t read_func,
+					gatt_db_write_t write_func,
+					void *user_data)
+{
+	if (!attrib)
+		return NULL;
+
+	return service_insert_descriptor(attrib->service, 0, uuid,
+					permissions, read_func, write_func,
+					user_data);
 }
 
 struct gatt_db_attribute *
@@ -781,7 +861,7 @@ gatt_db_service_add_included(struct gatt_db_attribute *attrib,
 	if (!index)
 		return NULL;
 
-	service->attributes[index] = new_attribute(service,
+	service->attributes[index] = new_attribute(service, 0,
 							&included_service_uuid,
 							value, len);
 	if (!service->attributes[index])
@@ -1184,7 +1264,13 @@ void gatt_db_service_foreach_desc(struct gatt_db_attribute *attrib,
 	service = attrib->service;
 
 	/* Start from the attribute following the value handle */
-	i = attrib->handle - service->attributes[0]->handle + 2;
+	for (i = 0; i < service->num_handles; i++) {
+		if (service->attributes[i] == attrib) {
+			i += 2;
+			break;
+		}
+	}
+
 	for (; i < service->num_handles; i++) {
 		attr = service->attributes[i];
 		if (!attr)
@@ -1222,7 +1308,7 @@ struct gatt_db_attribute *gatt_db_get_attribute(struct gatt_db *db,
 							uint16_t handle)
 {
 	struct gatt_db_service *service;
-	uint16_t service_handle;
+	int i;
 
 	if (!db || !handle)
 		return NULL;
@@ -1232,14 +1318,15 @@ struct gatt_db_attribute *gatt_db_get_attribute(struct gatt_db *db,
 	if (!service)
 		return NULL;
 
-	service_handle = service->attributes[0]->handle;
+	for (i = 0; i < service->num_handles; i++) {
+		if (!service->attributes[i])
+			continue;
 
-	/*
-	 * We can safely get attribute from attributes array with offset,
-	 * because find_service_for_handle() check if given handle is
-	 * in service range.
-	 */
-	return service->attributes[handle - service_handle];
+		if (service->attributes[i]->handle == handle)
+			return service->attributes[i];
+	}
+
+	return NULL;
 }
 
 static bool find_service_with_uuid(const void *data, const void *user_data)
diff --git a/src/shared/gatt-db.h b/src/shared/gatt-db.h
index 74b37bc..96cceb9 100644
--- a/src/shared/gatt-db.h
+++ b/src/shared/gatt-db.h
@@ -67,6 +67,15 @@ gatt_db_service_add_characteristic(struct gatt_db_attribute *attrib,
 					gatt_db_read_t read_func,
 					gatt_db_write_t write_func,
 					void *user_data);
+struct gatt_db_attribute *
+gatt_db_service_insert_characteristic(struct gatt_db_attribute *attrib,
+					uint16_t handle,
+					const bt_uuid_t *uuid,
+					uint32_t permissions,
+					uint8_t properties,
+					gatt_db_read_t read_func,
+					gatt_db_write_t write_func,
+					void *user_data);
 
 struct gatt_db_attribute *
 gatt_db_service_add_descriptor(struct gatt_db_attribute *attrib,
@@ -75,6 +84,14 @@ gatt_db_service_add_descriptor(struct gatt_db_attribute *attrib,
 					gatt_db_read_t read_func,
 					gatt_db_write_t write_func,
 					void *user_data);
+struct gatt_db_attribute *
+gatt_db_service_insert_descriptor(struct gatt_db_attribute *attrib,
+					uint16_t handle,
+					const bt_uuid_t *uuid,
+					uint32_t permissions,
+					gatt_db_read_t read_func,
+					gatt_db_write_t write_func,
+					void *user_data);
 
 struct gatt_db_attribute *
 gatt_db_service_add_included(struct gatt_db_attribute *attrib,
-- 
2.1.0

