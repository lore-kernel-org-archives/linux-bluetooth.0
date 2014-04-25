Return-Path: <cyrus@holtmann.org>
From: Marcin Kraglak <marcin.kraglak@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/4] gatt: Add characteristic descriptor functionality
Date: Fri, 25 Apr 2014 11:01:10 +0200
Message-Id: <1398416472-7852-2-git-send-email-marcin.kraglak@tieto.com>
In-Reply-To: <1398416472-7852-1-git-send-email-marcin.kraglak@tieto.com>
References: <1398416472-7852-1-git-send-email-marcin.kraglak@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

It will add characteristic descriptor to service attribute's list.
Returns 0 if there is no free handle in service or descriptor's handle
if attribute has been added successfully.
---
 src/shared/gatt-db.c | 29 +++++++++++++++++++++++++++++
 src/shared/gatt-db.h |  7 +++++++
 2 files changed, 36 insertions(+)

diff --git a/src/shared/gatt-db.c b/src/shared/gatt-db.c
index 91590d3..a0f860c 100644
--- a/src/shared/gatt-db.c
+++ b/src/shared/gatt-db.c
@@ -286,3 +286,32 @@ uint16_t gatt_db_new_characteristic(struct gatt_db *db, uint16_t handle,
 
 	return update_attribute_handle(service, i);
 }
+
+uint16_t gatt_db_new_char_descriptor(struct gatt_db *db, uint16_t handle,
+						const bt_uuid_t *uuid,
+						uint8_t permissions,
+						gatt_db_read_t read_func,
+						gatt_db_write_t write_func,
+						void *user_data)
+{
+	struct gatt_db_service *service;
+	int i;
+
+	service = queue_find(db->services, match_service_by_handle,
+							INT_TO_PTR(handle));
+	if (!service)
+		return 0;
+
+	i = get_attribute_index(service, 0);
+	if (!i)
+		return 0;
+
+	service->attributes[i] = new_attribute(uuid, NULL, 0);
+	if (!service->attributes[i])
+		return 0;
+
+	set_attribute_data(service->attributes[i], read_func, write_func,
+							permissions, user_data);
+
+	return update_attribute_handle(service, i);
+}
diff --git a/src/shared/gatt-db.h b/src/shared/gatt-db.h
index 9ee1a08..281ae6a 100644
--- a/src/shared/gatt-db.h
+++ b/src/shared/gatt-db.h
@@ -44,3 +44,10 @@ uint16_t gatt_db_new_characteristic(struct gatt_db *db, uint16_t handle,
 						gatt_db_read_t read_func,
 						gatt_db_write_t write_func,
 						void *user_data);
+
+uint16_t gatt_db_new_char_descriptor(struct gatt_db *db, uint16_t handle,
+						const bt_uuid_t *uuid,
+						uint8_t permissions,
+						gatt_db_read_t read_func,
+						gatt_db_write_t write_func,
+						void *user_data);
-- 
1.8.5.3

