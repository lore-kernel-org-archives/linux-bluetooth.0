Return-Path: <cyrus@holtmann.org>
From: Marcin Kraglak <marcin.kraglak@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv1 3/4] gatt: Add method for creating services in gatt_db
Date: Wed, 16 Apr 2014 09:19:06 +0200
Message-Id: <1397632747-13308-4-git-send-email-marcin.kraglak@tieto.com>
In-Reply-To: <1397632747-13308-1-git-send-email-marcin.kraglak@tieto.com>
References: <1397632747-13308-1-git-send-email-marcin.kraglak@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This function will reserve number of handles and create service attribute.
Primary arguments service type: PRIMARY or SECONDARY.
---
 src/shared/gatt-db.c | 90 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 src/shared/gatt-db.h | 14 ++++++++
 2 files changed, 104 insertions(+)

diff --git a/src/shared/gatt-db.c b/src/shared/gatt-db.c
index b057c15..0094616 100644
--- a/src/shared/gatt-db.c
+++ b/src/shared/gatt-db.c
@@ -23,16 +23,26 @@
 
 #include <stdbool.h>
 
+#include "lib/uuid.h"
 #include "src/shared/util.h"
 #include "src/shared/queue.h"
 #include "src/shared/gatt-db.h"
 
+static const bt_uuid_t primary_service_uuid  = { .type = BT_UUID16,
+					.value.u16 = GATT_PRIM_SVC_UUID };
+static const bt_uuid_t secondary_service_uuid  = { .type = BT_UUID16,
+					.value.u16 = GATT_SND_SVC_UUID };
+
 struct gatt_db {
 	uint16_t next_handle;
 	struct queue *services;
 };
 
 struct gatt_db_attribute {
+	uint16_t handle;
+	bt_uuid_t uuid;
+	uint16_t val_len;
+	uint8_t value[0];
 };
 
 struct gatt_db_service {
@@ -76,3 +86,83 @@ void gatt_db_destroy(struct gatt_db *db)
 	queue_destroy(db->services, gatt_db_service_destroy);
 	free(db);
 }
+
+static struct gatt_db_attribute *new_attribute(const bt_uuid_t *type,
+							const uint8_t *val,
+							uint16_t len)
+{
+	struct gatt_db_attribute *attribute;
+
+	attribute = malloc0(sizeof(struct gatt_db_attribute) + len);
+	if (!attribute)
+		return NULL;
+
+	attribute->uuid = *type;
+	memcpy(&attribute->value, val, len);
+	attribute->val_len = len;
+
+	return attribute;
+}
+
+static int uuid_to_le(const bt_uuid_t *uuid, uint8_t *dst)
+{
+	switch (uuid->type) {
+	case BT_UUID16:
+		put_le16(uuid->value.u16, dst);
+		break;
+	case BT_UUID32:
+		put_le32(uuid->value.u32, dst);
+		break;
+	default:
+		bswap_128(&uuid->value.u128, dst);
+		break;
+	}
+
+	return bt_uuid_len(uuid);
+}
+
+uint16_t gatt_db_new_service(struct gatt_db *db, const bt_uuid_t *uuid,
+					bool primary, uint16_t num_handles)
+{
+	struct gatt_db_service *service;
+	const bt_uuid_t *type;
+	uint8_t value[16];
+	uint16_t len;
+
+	service = new0(struct gatt_db_service, 1);
+	if (!service)
+		return 0;
+
+	service->attributes = new0(struct gatt_db_attribute *, num_handles);
+	if (!service->attributes) {
+		free(service);
+		return 0;
+	}
+
+	if (primary)
+		type = &primary_service_uuid;
+	else
+		type = &secondary_service_uuid;
+
+	len = uuid_to_le(uuid, value);
+
+	service->attributes[0] = new_attribute(type, value, len);
+	if (!service->attributes[0]) {
+		gatt_db_service_destroy(service);
+		return 0;
+	}
+
+	if (!queue_push_tail(db->services, service)) {
+		gatt_db_service_destroy(service);
+		return 0;
+	}
+
+	/* TODO now we get next handle from database. We should first look
+	 * for 'holes' between existing services first, and assign next_handle
+	 * only if enough space was not found. */
+	service->attributes[0]->handle = db->next_handle;
+	db->next_handle += num_handles;
+	service->num_handles = num_handles;
+
+	return service->attributes[0]->handle;
+}
diff --git a/src/shared/gatt-db.h b/src/shared/gatt-db.h
index b3cd7a6..1656bb0 100644
--- a/src/shared/gatt-db.h
+++ b/src/shared/gatt-db.h
@@ -36,3 +36,17 @@ struct gatt_db *gatt_db_new(void);
  * @db - gatt database to be destroyed
  */
 void gatt_db_destroy(struct gatt_db *db);
+
+/*
+ * gatt_db_new_service - Add service attribute and reserve number of handles
+ * for this service
+ *
+ * @db - gatt database to add service
+ * @uuid - service uuid
+ * @primary - if service is primary or secondary
+ * @num_handles - num of handles to reserve for service
+ *
+ * Returns handle of service. In case of error 0 is returned.
+ */
+uint16_t gatt_db_new_service(struct gatt_db *db, const bt_uuid_t *uuid,
+					bool primary, uint16_t num_handles);
-- 
1.8.5.3

