Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: szymon.janc@tieto.com,
	Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH 28/36] shared/gatt: Add support for write request
Date: Tue, 29 Apr 2014 03:14:59 +0200
Message-Id: <1398734107-4793-30-git-send-email-lukasz.rymanowski@tieto.com>
In-Reply-To: <1398734107-4793-1-git-send-email-lukasz.rymanowski@tieto.com>
References: <1398734107-4793-1-git-send-email-lukasz.rymanowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 src/shared/gatt-db.c | 23 +++++++++++++++++++++++
 src/shared/gatt-db.h |  3 +++
 2 files changed, 26 insertions(+)

diff --git a/src/shared/gatt-db.c b/src/shared/gatt-db.c
index 42b0903..527e4a7 100644
--- a/src/shared/gatt-db.c
+++ b/src/shared/gatt-db.c
@@ -706,3 +706,26 @@ bool gatt_db_read(struct gatt_db *db, uint16_t handle, uint16_t offset,
 
 	return true;
 }
+
+bool gatt_db_write(struct gatt_db *db, uint16_t handle, uint16_t offset,
+			const uint8_t *value, size_t len, void *req_data)
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
+	a->write_func(handle, offset, value, len, req_data, a->user_data);
+
+	return true;
+}
diff --git a/src/shared/gatt-db.h b/src/shared/gatt-db.h
index b63d1f6..2c77a07 100644
--- a/src/shared/gatt-db.h
+++ b/src/shared/gatt-db.h
@@ -106,3 +106,6 @@ void gatt_db_find_information(struct gatt_db *db, uint16_t start_handle,
 
 bool gatt_db_read(struct gatt_db *db, uint16_t handle, uint16_t offset,
 							void *req_data);
+
+bool gatt_db_write(struct gatt_db *db, uint16_t handle, uint16_t offset,
+			const uint8_t *value, size_t len, void *req_data);
-- 
1.8.4

