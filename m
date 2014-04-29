Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: szymon.janc@tieto.com, johan.hedberg@gmail.com,
	Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH v2 32/40] shared/gatt: Add support for write request
Date: Tue, 29 Apr 2014 18:47:21 +0200
Message-Id: <1398790049-30303-33-git-send-email-lukasz.rymanowski@tieto.com>
In-Reply-To: <1398790049-30303-1-git-send-email-lukasz.rymanowski@tieto.com>
References: <1398790049-30303-1-git-send-email-lukasz.rymanowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 src/shared/gatt-db.c | 23 +++++++++++++++++++++++
 src/shared/gatt-db.h |  4 ++++
 2 files changed, 27 insertions(+)

diff --git a/src/shared/gatt-db.c b/src/shared/gatt-db.c
index dfe1a76..e562695 100644
--- a/src/shared/gatt-db.c
+++ b/src/shared/gatt-db.c
@@ -704,6 +704,29 @@ bool gatt_db_read(struct gatt_db *db, uint16_t handle, uint16_t offset,
 
 	a->read_func(handle, offset, req_data, cb, a->user_data);
 
+	return true;
+}
+
+bool gatt_db_write(struct gatt_db *db, uint16_t handle, uint16_t offset,
+			const uint8_t *value, size_t len, void *req_data,
+			gatt_db_complete_func_t cb)
+{
+	struct gatt_db_service *service;
+	uint16_t service_handle;
+	struct gatt_db_attribute *a;
+
+	service = queue_find(db->services, find_service_for_handle,
+						INT_TO_PTR(handle));
+	if (!service)
+		return false;
+
+	service_handle = service->attributes[0]->handle;
+
+	a = service->attributes[handle - service_handle];
+	if (!a || !a->write_func)
+		return false;
+
+	a->write_func(handle, offset, value, len, req_data, cb, a->user_data);
 
 	return true;
 }
diff --git a/src/shared/gatt-db.h b/src/shared/gatt-db.h
index 9a56c51..90fa66e 100644
--- a/src/shared/gatt-db.h
+++ b/src/shared/gatt-db.h
@@ -112,3 +112,7 @@ void gatt_db_find_information(struct gatt_db *db, uint16_t start_handle,
 
 bool gatt_db_read(struct gatt_db *db, uint16_t handle, uint16_t offset,
 			void *req_data, gatt_db_complete_func_t complete_cb);
+
+bool gatt_db_write(struct gatt_db *db, uint16_t handle, uint16_t offset,
+			const uint8_t *value, size_t len, void *req_data,
+			gatt_db_complete_func_t complete_cb);
-- 
1.8.4

