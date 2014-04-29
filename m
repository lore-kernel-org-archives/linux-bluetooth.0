Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: szymon.janc@tieto.com, johan.hedberg@gmail.com,
	Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH v2 27/40] shared/gatt: Add support to read from database
Date: Tue, 29 Apr 2014 18:47:16 +0200
Message-Id: <1398790049-30303-28-git-send-email-lukasz.rymanowski@tieto.com>
In-Reply-To: <1398790049-30303-1-git-send-email-lukasz.rymanowski@tieto.com>
References: <1398790049-30303-1-git-send-email-lukasz.rymanowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 src/shared/gatt-db.c | 36 ++++++++++++++++++++++++++++++++++++
 src/shared/gatt-db.h |  3 +++
 2 files changed, 39 insertions(+)

diff --git a/src/shared/gatt-db.c b/src/shared/gatt-db.c
index b716ae6..dfe1a76 100644
--- a/src/shared/gatt-db.c
+++ b/src/shared/gatt-db.c
@@ -671,3 +671,39 @@ void gatt_db_find_information(struct gatt_db *db, uint16_t start_handle,
 
 	queue_foreach(db->services, find_information, &data);
 }
+
+static bool find_service_for_handle(const void *data, const void *user_data)
+{
+	const struct gatt_db_service *service = data;
+	uint16_t handle = PTR_TO_INT(user_data);
+	uint16_t start, end;
+
+	start = service->attributes[0]->handle;
+	end = start + service->num_handles;
+
+	return (start <= handle) && (handle < end);
+}
+
+bool gatt_db_read(struct gatt_db *db, uint16_t handle, uint16_t offset,
+				void *req_data, gatt_db_complete_func_t cb)
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
+	if (!a || !a->read_func)
+		return false;
+
+	a->read_func(handle, offset, req_data, cb, a->user_data);
+
+
+	return true;
+}
diff --git a/src/shared/gatt-db.h b/src/shared/gatt-db.h
index 921e896..9a56c51 100644
--- a/src/shared/gatt-db.h
+++ b/src/shared/gatt-db.h
@@ -109,3 +109,6 @@ struct gatt_db_find_information {
 void gatt_db_find_information(struct gatt_db *db, uint16_t start_handle,
 							uint16_t end_handle,
 							struct queue *queue);
+
+bool gatt_db_read(struct gatt_db *db, uint16_t handle, uint16_t offset,
+			void *req_data, gatt_db_complete_func_t complete_cb);
-- 
1.8.4

