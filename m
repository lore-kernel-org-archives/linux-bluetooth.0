Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH v2 4/5] shared/gatt: Add function for getting service UUID
Date: Thu, 10 Jul 2014 16:30:35 +0200
Message-Id: <1405002636-10737-4-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1405002636-10737-1-git-send-email-szymon.janc@tieto.com>
References: <1405002636-10737-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 src/shared/gatt-db.c | 31 +++++++++++++++++++++++++++++++
 src/shared/gatt-db.h |  2 ++
 2 files changed, 33 insertions(+)

diff --git a/src/shared/gatt-db.c b/src/shared/gatt-db.c
index 9cbf409..bd25d47 100644
--- a/src/shared/gatt-db.c
+++ b/src/shared/gatt-db.c
@@ -732,6 +732,37 @@ uint16_t gatt_db_get_end_handle(struct gatt_db *db, uint16_t handle)
 	return service->attributes[0]->handle + service->num_handles - 1;
 }
 
+bool gatt_db_get_service_uuid(struct gatt_db *db, uint16_t handle,
+								bt_uuid_t *uuid)
+{
+	struct gatt_db_service *service;
+
+	service = queue_find(db->services, find_service_for_handle,
+						INT_TO_PTR(handle));
+	if (!service)
+		return false;
+
+	if (service->attributes[0]->value_len == 2) {
+		uint16_t value;
+
+		value = get_le16(service->attributes[0]->value);
+		bt_uuid16_create(uuid, value);
+
+		return true;
+	}
+
+	if (service->attributes[0]->value_len == 8) {
+		uint128_t value;
+
+		bswap_128(service->attributes[0]->value, &value);
+		bt_uuid128_create(uuid, value);
+
+		return true;
+	}
+
+	return false;
+}
+
 bool gatt_db_get_attribute_permissions(struct gatt_db *db, uint16_t handle,
 							uint32_t *permissions)
 {
diff --git a/src/shared/gatt-db.h b/src/shared/gatt-db.h
index a88f637..8d18434 100644
--- a/src/shared/gatt-db.h
+++ b/src/shared/gatt-db.h
@@ -91,6 +91,8 @@ const bt_uuid_t *gatt_db_get_attribute_type(struct gatt_db *db,
 							uint16_t handle);
 
 uint16_t gatt_db_get_end_handle(struct gatt_db *db, uint16_t handle);
+bool gatt_db_get_service_uuid(struct gatt_db *db, uint16_t handle,
+							bt_uuid_t *uuid);
 
 bool gatt_db_get_attribute_permissions(struct gatt_db *db, uint16_t handle,
 							uint32_t *permissions);
-- 
1.9.1

