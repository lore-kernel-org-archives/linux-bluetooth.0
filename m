Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFC v2 BlueZ] shared/gatt-db: Rework API
Date: Tue,  4 Nov 2014 13:59:42 +0200
Message-Id: <1415102382-18458-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Second proposal now without exposing gatt_db_service and adding
dedicated result functions.
---
 src/shared/gatt-db.c     | 411 +++++++++++++++++++----------------------------
 src/shared/gatt-db.h     |  89 +++++-----
 src/shared/gatt-server.c |  37 +++--
 3 files changed, 233 insertions(+), 304 deletions(-)

diff --git a/src/shared/gatt-db.c b/src/shared/gatt-db.c
index 5855f5d..d27e8c6 100644
--- a/src/shared/gatt-db.c
+++ b/src/shared/gatt-db.c
@@ -45,6 +45,18 @@ struct gatt_db {
 	struct queue *services;
 };
 
+struct pending_read {
+	unsigned int id;
+	gatt_db_attribute_read_t func;
+	void *user_data;
+};
+
+struct pending_write {
+	unsigned int id;
+	gatt_db_attribute_write_t func;
+	void *user_data;
+};
+
 struct gatt_db_attribute {
 	struct gatt_db_service *service;
 	uint16_t handle;
@@ -56,6 +68,12 @@ struct gatt_db_attribute {
 	gatt_db_read_t read_func;
 	gatt_db_write_t write_func;
 	void *user_data;
+
+	unsigned int read_id;
+	struct queue *pending_reads;
+
+	unsigned int write_id;
+	struct queue *pending_writes;
 };
 
 struct gatt_db_service {
@@ -64,13 +82,6 @@ struct gatt_db_service {
 	struct gatt_db_attribute **attributes;
 };
 
-static bool match_service_by_handle(const void *data, const void *user_data)
-{
-	const struct gatt_db_service *service = data;
-
-	return service->attributes[0]->handle == PTR_TO_UINT(user_data);
-}
-
 static struct gatt_db_attribute *new_attribute(struct gatt_db_service *service,
 							const bt_uuid_t *type,
 							const uint8_t *val,
@@ -104,6 +115,9 @@ static void attribute_destroy(struct gatt_db_attribute *attribute)
 	if (!attribute)
 		return;
 
+	queue_destroy(attribute->pending_reads, free);
+	queue_destroy(attribute->pending_writes, free);
+
 	free(attribute->value);
 	free(attribute);
 }
@@ -162,8 +176,10 @@ static int uuid_to_le(const bt_uuid_t *uuid, uint8_t *dst)
 	return bt_uuid_len(&uuid128);
 }
 
-uint16_t gatt_db_add_service(struct gatt_db *db, const bt_uuid_t *uuid,
-					bool primary, uint16_t num_handles)
+struct gatt_db_attribute *gatt_db_add_service(struct gatt_db *db,
+						const bt_uuid_t *uuid,
+						bool primary,
+						uint16_t num_handles)
 {
 	struct gatt_db_service *service;
 	const bt_uuid_t *type;
@@ -209,18 +225,21 @@ uint16_t gatt_db_add_service(struct gatt_db *db, const bt_uuid_t *uuid,
 	db->next_handle += num_handles;
 	service->num_handles = num_handles;
 
-	return service->attributes[0]->handle;
+	return service->attributes[0];
 }
 
-bool gatt_db_remove_service(struct gatt_db *db, uint16_t handle)
+bool gatt_db_remove_service(struct gatt_db *db,
+					struct gatt_db_attribute *attrib)
 {
 	struct gatt_db_service *service;
 
-	service = queue_remove_if(db->services, match_service_by_handle,
-							UINT_TO_PTR(handle));
-	if (!service)
+	if (!db || !attrib)
 		return false;
 
+	service = attrib->service;
+
+	queue_remove(db->services, service);
+
 	gatt_db_service_destroy(service);
 
 	return true;
@@ -245,8 +264,8 @@ static uint16_t get_handle_at_index(struct gatt_db_service *service,
 	return service->attributes[index]->handle;
 }
 
-static uint16_t update_attribute_handle(struct gatt_db_service *service,
-								int index)
+static struct gatt_db_attribute *
+attribute_update(struct gatt_db_service *service, int index)
 {
 	uint16_t previous_handle;
 
@@ -256,7 +275,7 @@ static uint16_t update_attribute_handle(struct gatt_db_service *service,
 	previous_handle = service->attributes[index - 1]->handle;
 	service->attributes[index]->handle = previous_handle + 1;
 
-	return service->attributes[index]->handle;
+	return service->attributes[index];
 }
 
 static void set_attribute_data(struct gatt_db_attribute *attribute,
@@ -271,27 +290,28 @@ static void set_attribute_data(struct gatt_db_attribute *attribute,
 	attribute->user_data = user_data;
 }
 
-uint16_t gatt_db_add_characteristic(struct gatt_db *db, uint16_t handle,
-						const bt_uuid_t *uuid,
-						uint32_t permissions,
-						uint8_t properties,
-						gatt_db_read_t read_func,
-						gatt_db_write_t write_func,
-						void *user_data)
+struct gatt_db_attribute *
+gatt_db_service_add_characteristic(struct gatt_db_attribute *attrib,
+					const bt_uuid_t *uuid,
+					uint32_t permissions,
+					uint8_t properties,
+					gatt_db_read_t read_func,
+					gatt_db_write_t write_func,
+					void *user_data)
 {
-	uint8_t value[MAX_CHAR_DECL_VALUE_LEN];
 	struct gatt_db_service *service;
+	uint8_t value[MAX_CHAR_DECL_VALUE_LEN];
 	uint16_t len = 0;
 	int i;
 
-	service = queue_find(db->services, match_service_by_handle,
-							UINT_TO_PTR(handle));
-	if (!service)
-		return 0;
+	if (!attrib)
+		return NULL;
+
+	service = attrib->service;
 
 	i = get_attribute_index(service, 1);
 	if (!i)
-		return 0;
+		return NULL;
 
 	value[0] = properties;
 	len += sizeof(properties);
@@ -303,96 +323,96 @@ uint16_t gatt_db_add_characteristic(struct gatt_db *db, uint16_t handle,
 	service->attributes[i] = new_attribute(service, &characteristic_uuid,
 								value, len);
 	if (!service->attributes[i])
-		return 0;
+		return NULL;
 
-	update_attribute_handle(service, i++);
+	attribute_update(service, i++);
 
 	service->attributes[i] = new_attribute(service, uuid, NULL, 0);
 	if (!service->attributes[i]) {
 		free(service->attributes[i - 1]);
-		return 0;
+		return NULL;
 	}
 
 	set_attribute_data(service->attributes[i], read_func, write_func,
 							permissions, user_data);
 
-	return update_attribute_handle(service, i);
+	return attribute_update(service, i);
 }
 
-uint16_t gatt_db_add_char_descriptor(struct gatt_db *db, uint16_t handle,
-						const bt_uuid_t *uuid,
-						uint32_t permissions,
-						gatt_db_read_t read_func,
-						gatt_db_write_t write_func,
-						void *user_data)
+struct gatt_db_attribute *
+gatt_db_service_add_descriptor(struct gatt_db_attribute *attrib,
+					const bt_uuid_t *uuid,
+					uint32_t permissions,
+					gatt_db_read_t read_func,
+					gatt_db_write_t write_func,
+					void *user_data)
 {
 	struct gatt_db_service *service;
 	int i;
 
-	service = queue_find(db->services, match_service_by_handle,
-							UINT_TO_PTR(handle));
-	if (!service)
-		return 0;
+	if (!attrib)
+		return false;
+
+	service = attrib->service;
 
 	i = get_attribute_index(service, 0);
 	if (!i)
-		return 0;
+		return NULL;
 
 	service->attributes[i] = new_attribute(service, uuid, NULL, 0);
 	if (!service->attributes[i])
-		return 0;
+		return NULL;
 
 	set_attribute_data(service->attributes[i], read_func, write_func,
 							permissions, user_data);
 
-	return update_attribute_handle(service, i);
+	return attribute_update(service, i);
 }
 
-uint16_t gatt_db_add_included_service(struct gatt_db *db, uint16_t handle,
-						uint16_t included_handle)
+struct gatt_db_attribute *
+gatt_db_service_add_included(struct gatt_db_attribute *attrib,
+					struct gatt_db_attribute *include)
 {
-	struct gatt_db_service *included_service;
+	struct gatt_db_service *service, *included;
 	uint8_t value[MAX_INCLUDED_VALUE_LEN];
-	uint16_t len = 0;
-	struct gatt_db_service *service;
+	uint16_t included_handle, len = 0;
 	int index;
 
-	service = queue_find(db->services, match_service_by_handle,
-							UINT_TO_PTR(handle));
-	if (!service)
-		return 0;
+	if (!attrib || !include)
+		return false;
+
+	service = attrib->service;
+	included = include->service;
 
-	included_service = queue_find(db->services, match_service_by_handle,
-						UINT_TO_PTR(included_handle));
+	/* Adjust include to point to the first attribute */
+	if (include != included->attributes[0])
+		include = included->attributes[0];
 
-	if (!included_service)
-		return 0;
+	included_handle = include->handle;
 
 	put_le16(included_handle, &value[len]);
 	len += sizeof(uint16_t);
 
-	put_le16(included_handle + included_service->num_handles - 1,
-								&value[len]);
+	put_le16(included_handle + included->num_handles - 1, &value[len]);
 	len += sizeof(uint16_t);
 
 	/* The Service UUID shall only be present when the UUID is a 16-bit
 	 * Bluetooth UUID. Vol 2. Part G. 3.2
 	 */
-	if (included_service->attributes[0]->value_len == sizeof(uint16_t)) {
-		memcpy(&value[len], included_service->attributes[0]->value,
-				included_service->attributes[0]->value_len);
-		len += included_service->attributes[0]->value_len;
+	if (include->value_len == sizeof(uint16_t)) {
+		memcpy(&value[len], include->value, include->value_len);
+		len += include->value_len;
 	}
 
 	index = get_attribute_index(service, 0);
 	if (!index)
-		return 0;
+		return NULL;
 
 	service->attributes[index] = new_attribute(service,
 							&included_service_uuid,
 							value, len);
 	if (!service->attributes[index])
-		return 0;
+		return NULL;
 
 	/* The Attribute Permissions shall be read only and not require
 	 * authentication or authorization. Vol 2. Part G. 3.2
@@ -401,20 +421,15 @@ uint16_t gatt_db_add_included_service(struct gatt_db *db, uint16_t handle,
 	 */
 	set_attribute_data(service->attributes[index], NULL, NULL, 0, NULL);
 
-	return update_attribute_handle(service, index);
+	return attribute_update(service, index);
 }
 
-bool gatt_db_service_set_active(struct gatt_db *db, uint16_t handle,
-								bool active)
+bool gatt_db_service_set_active(struct gatt_db_attribute *attrib, bool active)
 {
-	struct gatt_db_service *service;
-
-	service = queue_find(db->services, match_service_by_handle,
-							UINT_TO_PTR(handle));
-	if (!service)
+	if (!attrib)
 		return false;
 
-	service->active = active;
+	attrib->service->active = active;
 
 	return true;
 }
@@ -465,8 +480,7 @@ static void read_by_group_type(void *data, void *user_data)
 		return;
 	}
 
-	queue_push_tail(search_data->queue,
-			UINT_TO_PTR(service->attributes[0]->handle));
+	queue_push_tail(search_data->queue, service->attributes[0]);
 }
 
 void gatt_db_read_by_group_type(struct gatt_db *db, uint16_t start_handle,
@@ -516,8 +530,7 @@ static void find_by_type(void *data, void *user_data)
 		if (bt_uuid_cmp(&search_data->uuid, &attribute->uuid))
 			continue;
 
-		queue_push_tail(search_data->queue,
-						UINT_TO_PTR(attribute->handle));
+		queue_push_tail(search_data->queue, attribute);
 	}
 }
 
@@ -567,8 +580,7 @@ static void read_by_type(void *data, void *user_data)
 		if (bt_uuid_cmp(&search_data->uuid, &attribute->uuid))
 			continue;
 
-		queue_push_tail(search_data->queue,
-						UINT_TO_PTR(attribute->handle));
+		queue_push_tail(search_data->queue, attribute);
 	}
 }
 
@@ -619,8 +631,7 @@ static void find_information(void *data, void *user_data)
 		if (attribute->handle > search_data->end_handle)
 			return;
 
-		queue_push_tail(search_data->queue,
-						UINT_TO_PTR(attribute->handle));
+		queue_push_tail(search_data->queue, attribute);
 	}
 }
 
@@ -649,164 +660,6 @@ static bool find_service_for_handle(const void *data, const void *user_data)
 	return (start <= handle) && (handle < end);
 }
 
-bool gatt_db_read(struct gatt_db *db, uint16_t handle, uint16_t offset,
-				uint8_t att_opcode, bdaddr_t *bdaddr,
-				uint8_t **value, int *length)
-{
-	struct gatt_db_service *service;
-	uint16_t service_handle;
-	struct gatt_db_attribute *a;
-
-	if (!value || !length)
-		return false;
-
-	service = queue_find(db->services, find_service_for_handle,
-						UINT_TO_PTR(handle));
-	if (!service)
-		return false;
-
-	service_handle = service->attributes[0]->handle;
-
-	a = service->attributes[handle - service_handle];
-	if (!a)
-		return false;
-
-	/*
-	 * We call callback, and set length to -1, to notify user that callback
-	 * has been called. Otherwise we set length to value length in database.
-	 */
-	if (a->read_func) {
-		*value = NULL;
-		*length = -1;
-		a->read_func(handle, offset, att_opcode, bdaddr, a->user_data);
-	} else {
-		if (offset > a->value_len)
-			return false;
-
-		*value = &a->value[offset];
-		*length = a->value_len - offset;
-	}
-
-	return true;
-}
-
-bool gatt_db_write(struct gatt_db *db, uint16_t handle, uint16_t offset,
-					const uint8_t *value, size_t len,
-					uint8_t att_opcode, bdaddr_t *bdaddr)
-{
-	struct gatt_db_service *service;
-	uint16_t service_handle;
-	struct gatt_db_attribute *a;
-
-	service = queue_find(db->services, find_service_for_handle,
-						UINT_TO_PTR(handle));
-	if (!service)
-		return false;
-
-	service_handle = service->attributes[0]->handle;
-
-	a = service->attributes[handle - service_handle];
-	if (!a || !a->write_func)
-		return false;
-
-	a->write_func(handle, offset, value, len, att_opcode, bdaddr,
-								a->user_data);
-
-	return true;
-}
-
-const bt_uuid_t *gatt_db_get_attribute_type(struct gatt_db *db,
-							uint16_t handle)
-{
-	struct gatt_db_service *service;
-	struct gatt_db_attribute *attribute;
-	uint16_t service_handle;
-
-	service = queue_find(db->services, find_service_for_handle,
-						UINT_TO_PTR(handle));
-	if (!service)
-		return NULL;
-
-	service_handle = service->attributes[0]->handle;
-
-	attribute = service->attributes[handle - service_handle];
-	if (!attribute)
-		return NULL;
-
-	return &attribute->uuid;
-}
-
-uint16_t gatt_db_get_end_handle(struct gatt_db *db, uint16_t handle)
-{
-	struct gatt_db_service *service;
-
-	service = queue_find(db->services, find_service_for_handle,
-						UINT_TO_PTR(handle));
-	if (!service)
-		return 0;
-
-	return service->attributes[0]->handle + service->num_handles - 1;
-}
-
-bool gatt_db_get_service_uuid(struct gatt_db *db, uint16_t handle,
-								bt_uuid_t *uuid)
-{
-	struct gatt_db_service *service;
-
-	service = queue_find(db->services, find_service_for_handle,
-						UINT_TO_PTR(handle));
-	if (!service)
-		return false;
-
-	if (service->attributes[0]->value_len == 2) {
-		uint16_t value;
-
-		value = get_le16(service->attributes[0]->value);
-		bt_uuid16_create(uuid, value);
-
-		return true;
-	}
-
-	if (service->attributes[0]->value_len == 16) {
-		uint128_t value;
-
-		bswap_128(service->attributes[0]->value, &value);
-		bt_uuid128_create(uuid, value);
-
-		return true;
-	}
-
-	return false;
-}
-
-bool gatt_db_get_attribute_permissions(struct gatt_db *db, uint16_t handle,
-							uint32_t *permissions)
-{
-	struct gatt_db_attribute *attribute;
-	struct gatt_db_service *service;
-	uint16_t service_handle;
-
-	service = queue_find(db->services, find_service_for_handle,
-							UINT_TO_PTR(handle));
-	if (!service)
-		return false;
-
-	service_handle = service->attributes[0]->handle;
-
-	/*
-	 * We can safely get attribute from attributes array with offset,
-	 * because find_service_for_handle() check if given handle is
-	 * in service range.
-	 */
-	attribute = service->attributes[handle - service_handle];
-	if (!attribute)
-		return false;
-
-	*permissions = attribute->permissions;
-	return true;
-
-}
-
 struct gatt_db_attribute *gatt_db_get_attribute(struct gatt_db *db,
 							uint16_t handle)
 {
@@ -920,8 +773,16 @@ bool gatt_db_attribute_read(struct gatt_db_attribute *attrib, uint16_t offset,
 		return false;
 
 	if (attrib->read_func) {
-		/* TODO: Pass callback function to read_func */
-		attrib->read_func(attrib->handle, offset, opcode, bdaddr,
+		struct pending_read *p;
+
+		p = new0(struct pending_read, 1);
+		p->id = ++attrib->read_id;
+		p->func = func;
+		p->user_data = user_data;
+
+		queue_push_tail(attrib->pending_reads, p);
+
+		attrib->read_func(attrib, p->id, offset, opcode, bdaddr,
 							attrib->user_data);
 		return true;
 	}
@@ -938,6 +799,35 @@ bool gatt_db_attribute_read(struct gatt_db_attribute *attrib, uint16_t offset,
 	return true;
 }
 
+static bool find_pending(const void *a, const void *b)
+{
+	const struct pending_read *p = a;
+	unsigned int id = PTR_TO_UINT(b);
+
+	return p->id == id;
+}
+
+bool gatt_db_attribute_read_result(struct gatt_db_attribute *attrib,
+					unsigned int id, int err,
+					const uint8_t *value, size_t length)
+{
+	struct pending_read *p;
+
+	if (!attrib || !id)
+		return false;
+
+	p = queue_remove_if(attrib->pending_reads, find_pending,
+							UINT_TO_PTR(id));
+	if (!p)
+		return false;
+
+	p->func(attrib, err, value, length, p->user_data);
+
+	free(p);
+
+	return true;
+}
+
 bool gatt_db_attribute_write(struct gatt_db_attribute *attrib, uint16_t offset,
 					const uint8_t *value, size_t len,
 					uint8_t opcode, bdaddr_t *bdaddr,
@@ -948,7 +838,16 @@ bool gatt_db_attribute_write(struct gatt_db_attribute *attrib, uint16_t offset,
 		return false;
 
 	if (attrib->write_func) {
-		attrib->write_func(attrib->handle, offset, value, len, opcode,
+		struct pending_write *p;
+
+		p = new0(struct pending_write, 1);
+		p->id = ++attrib->write_id;
+		p->func = func;
+		p->user_data = user_data;
+
+		queue_push_tail(attrib->pending_writes, p);
+
+		attrib->write_func(attrib, p->id, offset, opcode, value, len,
 						bdaddr, attrib->user_data);
 		return true;
 	}
@@ -971,3 +870,23 @@ bool gatt_db_attribute_write(struct gatt_db_attribute *attrib, uint16_t offset,
 
 	return true;
 }
+
+bool gatt_db_attribute_write_result(struct gatt_db_attribute *attrib,
+						unsigned int id, int err)
+{
+	struct pending_write *p;
+
+	if (!attrib || !id)
+		return false;
+
+	p = queue_remove_if(attrib->pending_writes, find_pending,
+							UINT_TO_PTR(id));
+	if (!p)
+		return false;
+
+	p->func(attrib, err, p->user_data);
+
+	free(p);
+
+	return true;
+}
diff --git a/src/shared/gatt-db.h b/src/shared/gatt-db.h
index 15be67f..9e51a9b 100644
--- a/src/shared/gatt-db.h
+++ b/src/shared/gatt-db.h
@@ -22,43 +22,52 @@
  */
 
 struct gatt_db;
+struct gatt_db_attribute;
 
 struct gatt_db *gatt_db_new(void);
 void gatt_db_destroy(struct gatt_db *db);
 
-uint16_t gatt_db_add_service(struct gatt_db *db, const bt_uuid_t *uuid,
-					bool primary, uint16_t num_handles);
-bool gatt_db_remove_service(struct gatt_db *db, uint16_t handle);
+struct gatt_db_attribute *gatt_db_add_service(struct gatt_db *db,
+						const bt_uuid_t *uuid,
+						bool primary,
+						uint16_t num_handles);
+
+bool gatt_db_remove_service(struct gatt_db *db,
+					struct gatt_db_attribute *attrib);
 
-typedef void (*gatt_db_read_t) (uint16_t handle, uint16_t offset,
-					uint8_t att_opcode, bdaddr_t *bdaddr,
+typedef void (*gatt_db_read_t) (struct gatt_db_attribute *attrib,
+					unsigned int id, uint16_t offset,
+					uint8_t opcode, bdaddr_t *bdaddr,
 					void *user_data);
 
-typedef void (*gatt_db_write_t) (uint16_t handle, uint16_t offset,
-					const uint8_t *value, size_t len,
-					uint8_t att_opcode, bdaddr_t *bdaddr,
+typedef void (*gatt_db_write_t) (struct gatt_db_attribute *attrib,
+					unsigned int id, uint16_t offset,
+					uint8_t opcode ,const uint8_t *value,
+					size_t len, bdaddr_t *bdaddr,
 					void *user_data);
 
-uint16_t gatt_db_add_characteristic(struct gatt_db *db, uint16_t handle,
-						const bt_uuid_t *uuid,
-						uint32_t permissions,
-						uint8_t properties,
-						gatt_db_read_t read_func,
-						gatt_db_write_t write_func,
-						void *user_data);
+struct gatt_db_attribute *
+gatt_db_service_add_characteristic(struct gatt_db_attribute *attrib,
+					const bt_uuid_t *uuid,
+					uint32_t permissions,
+					uint8_t properties,
+					gatt_db_read_t read_func,
+					gatt_db_write_t write_func,
+					void *user_data);
 
-uint16_t gatt_db_add_char_descriptor(struct gatt_db *db, uint16_t handle,
-						const bt_uuid_t *uuid,
-						uint32_t permissions,
-						gatt_db_read_t read_func,
-						gatt_db_write_t write_func,
-						void *user_data);
+struct gatt_db_attribute *
+gatt_db_service_add_descriptor(struct gatt_db_attribute *attrib,
+					const bt_uuid_t *uuid,
+					uint32_t permissions,
+					gatt_db_read_t read_func,
+					gatt_db_write_t write_func,
+					void *user_data);
 
-uint16_t gatt_db_add_included_service(struct gatt_db *db, uint16_t handle,
-						uint16_t included_handle);
+struct gatt_db_attribute *
+gatt_db_service_add_included(struct gatt_db_attribute *attrib,
+					struct gatt_db_attribute *include);
 
-bool gatt_db_service_set_active(struct gatt_db *db, uint16_t handle,
-								bool active);
+bool gatt_db_service_set_active(struct gatt_db_attribute *attrib, bool active);
 
 void gatt_db_read_by_group_type(struct gatt_db *db, uint16_t start_handle,
 							uint16_t end_handle,
@@ -79,25 +88,6 @@ void gatt_db_find_information(struct gatt_db *db, uint16_t start_handle,
 							uint16_t end_handle,
 							struct queue *queue);
 
-bool gatt_db_read(struct gatt_db *db, uint16_t handle, uint16_t offset,
-					uint8_t att_opcode, bdaddr_t *bdaddr,
-					uint8_t **value, int *length);
-
-bool gatt_db_write(struct gatt_db *db, uint16_t handle, uint16_t offset,
-					const uint8_t *value, size_t len,
-					uint8_t att_opcode, bdaddr_t *bdaddr);
-
-const bt_uuid_t *gatt_db_get_attribute_type(struct gatt_db *db,
-							uint16_t handle);
-
-uint16_t gatt_db_get_end_handle(struct gatt_db *db, uint16_t handle);
-bool gatt_db_get_service_uuid(struct gatt_db *db, uint16_t handle,
-							bt_uuid_t *uuid);
-
-bool gatt_db_get_attribute_permissions(struct gatt_db *db, uint16_t handle,
-							uint32_t *permissions);
-
-struct gatt_db_attribute;
 
 struct gatt_db_attribute *gatt_db_get_attribute(struct gatt_db *db,
 							uint16_t handle);
@@ -117,13 +107,17 @@ bool gatt_db_attribute_get_permissions(struct gatt_db_attribute *attrib,
 							uint32_t *permissions);
 
 typedef void (*gatt_db_attribute_read_t) (struct gatt_db_attribute *attrib,
-					int err, uint8_t *value, size_t length,
-					void *user_data);
+						int err, const uint8_t *value,
+						size_t length, void *user_data);
 
 bool gatt_db_attribute_read(struct gatt_db_attribute *attrib, uint16_t offset,
 				uint8_t opcode, bdaddr_t *bdaddr,
 				gatt_db_attribute_read_t func, void *user_data);
 
+bool gatt_db_attribute_read_result(struct gatt_db_attribute *attrib,
+					unsigned int id, int err,
+					const uint8_t *value, size_t length);
+
 typedef void (*gatt_db_attribute_write_t) (struct gatt_db_attribute *attrib,
 						int err, void *user_data);
 
@@ -132,3 +126,6 @@ bool gatt_db_attribute_write(struct gatt_db_attribute *attrib, uint16_t offset,
 					uint8_t opcode, bdaddr_t *bdaddr,
 					gatt_db_attribute_write_t func,
 					void *user_data);
+
+bool gatt_db_attribute_write_result(struct gatt_db_attribute *attrib,
+						unsigned int id, int err);
diff --git a/src/shared/gatt-server.c b/src/shared/gatt-server.c
index 657b564..18f82c4 100644
--- a/src/shared/gatt-server.c
+++ b/src/shared/gatt-server.c
@@ -21,6 +21,8 @@
  *
  */
 
+#include <sys/uio.h>
+
 #include "src/shared/att.h"
 #include "lib/uuid.h"
 #include "src/shared/queue.h"
@@ -91,31 +93,41 @@ static bool get_uuid_le(const uint8_t *uuid, size_t len, bt_uuid_t *out_uuid)
 	return false;
 }
 
+static void attribute_read_cb(struct gatt_db_attribute *attrib, int err,
+					const uint8_t *value, size_t length,
+					void *user_data)
+{
+	struct iovec *iov = user_data;
+
+	iov->iov_base = (void *) value;
+	iov->iov_len = length;
+}
+
 static bool encode_read_by_grp_type_rsp(struct gatt_db *db, struct queue *q,
 						uint16_t mtu,
 						uint8_t *pdu, uint16_t *len)
 {
 	int iter = 0;
 	uint16_t start_handle, end_handle;
-	uint8_t *value;
-	int value_len;
+	struct iovec value;
 	uint8_t data_val_len;
 
 	*len = 0;
 
 	while (queue_peek_head(q)) {
-		start_handle = PTR_TO_UINT(queue_pop_head(q));
-		value = NULL;
-		value_len = 0;
+		struct gatt_db_attribute *attrib = queue_pop_head(q);
+
+		value.iov_base = NULL;
+		value.iov_len = 0;
 
 		/*
 		 * This should never be deferred to the read callback for
 		 * primary/secondary service declarations.
 		 */
-		if (!gatt_db_read(db, start_handle, 0,
+		if (!gatt_db_attribute_read(attrib, 0,
 						BT_ATT_OP_READ_BY_GRP_TYPE_REQ,
-						NULL, &value,
-						&value_len) || value_len < 0)
+						NULL, attribute_read_cb,
+						&value) || !value.iov_len)
 			return false;
 
 		/*
@@ -124,21 +136,22 @@ static bool encode_read_by_grp_type_rsp(struct gatt_db *db, struct queue *q,
 		 * value is seen.
 		 */
 		if (iter == 0) {
-			data_val_len = value_len;
+			data_val_len = value.iov_len;
 			pdu[0] = data_val_len + 4;
 			iter++;
-		} else if (value_len != data_val_len)
+		} else if (value.iov_len != data_val_len)
 			break;
 
 		/* Stop if this unit would surpass the MTU */
 		if (iter + data_val_len + 4 > mtu)
 			break;
 
-		end_handle = gatt_db_get_end_handle(db, start_handle);
+		gatt_db_attribute_get_service_handles(attrib, &start_handle,
+								&end_handle);
 
 		put_le16(start_handle, pdu + iter);
 		put_le16(end_handle, pdu + iter + 2);
-		memcpy(pdu + iter + 4, value, value_len);
+		memcpy(pdu + iter + 4, value.iov_base, value.iov_len);
 
 		iter += data_val_len + 4;
 	}
-- 
1.9.3

