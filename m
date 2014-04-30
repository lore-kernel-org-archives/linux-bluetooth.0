Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: szymon.janc@tieto.com, johan.hedberg@gmail.com,
	Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH v4 27/38] shared/gatt: Add support to read from database
Date: Wed, 30 Apr 2014 11:13:58 +0200
Message-Id: <1398849249-5868-28-git-send-email-lukasz.rymanowski@tieto.com>
In-Reply-To: <1398849249-5868-1-git-send-email-lukasz.rymanowski@tieto.com>
References: <1398849249-5868-1-git-send-email-lukasz.rymanowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 src/shared/gatt-db.c | 36 ++++++++++++++++++++++++++++++++++++
 src/shared/gatt-db.h |  3 +++
 2 files changed, 39 insertions(+)

diff --git a/src/shared/gatt-db.c b/src/shared/gatt-db.c
index cbdd8a0..1f57c8a 100644
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
+				uint8_t att_opcode, bdaddr_t *bdaddr)
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
+	a->read_func(handle, offset, att_opcode, bdaddr, a->user_data);
+
+
+	return true;
+}
diff --git a/src/shared/gatt-db.h b/src/shared/gatt-db.h
index a91c798..6cf07db 100644
--- a/src/shared/gatt-db.h
+++ b/src/shared/gatt-db.h
@@ -104,3 +104,6 @@ struct gatt_db_find_information {
 void gatt_db_find_information(struct gatt_db *db, uint16_t start_handle,
 							uint16_t end_handle,
 							struct queue *queue);
+
+bool gatt_db_read(struct gatt_db *db, uint16_t handle, uint16_t offset,
+					uint8_t att_opcode, bdaddr_t *bdaddr);
-- 
1.8.4

