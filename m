Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: szymon.janc@tieto.com, johan.hedberg@gmail.com,
	Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH v4 31/38] shared/gatt: Add support for write request
Date: Wed, 30 Apr 2014 11:14:02 +0200
Message-Id: <1398849249-5868-32-git-send-email-lukasz.rymanowski@tieto.com>
In-Reply-To: <1398849249-5868-1-git-send-email-lukasz.rymanowski@tieto.com>
References: <1398849249-5868-1-git-send-email-lukasz.rymanowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 src/shared/gatt-db.c | 24 ++++++++++++++++++++++++
 src/shared/gatt-db.h |  4 ++++
 2 files changed, 28 insertions(+)

diff --git a/src/shared/gatt-db.c b/src/shared/gatt-db.c
index 1f57c8a..f63a7fd 100644
--- a/src/shared/gatt-db.c
+++ b/src/shared/gatt-db.c
@@ -704,6 +704,30 @@ bool gatt_db_read(struct gatt_db *db, uint16_t handle, uint16_t offset,
 
 	a->read_func(handle, offset, att_opcode, bdaddr, a->user_data);
 
+	return true;
+}
+
+bool gatt_db_write(struct gatt_db *db, uint16_t handle, uint16_t offset,
+					const uint8_t *value, size_t len,
+					uint8_t att_opcode, bdaddr_t *bdaddr)
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
+	a->write_func(handle, offset, value, len, att_opcode, bdaddr,
+								a->user_data);
 
 	return true;
 }
diff --git a/src/shared/gatt-db.h b/src/shared/gatt-db.h
index 6cf07db..f704b8e 100644
--- a/src/shared/gatt-db.h
+++ b/src/shared/gatt-db.h
@@ -107,3 +107,7 @@ void gatt_db_find_information(struct gatt_db *db, uint16_t start_handle,
 
 bool gatt_db_read(struct gatt_db *db, uint16_t handle, uint16_t offset,
 					uint8_t att_opcode, bdaddr_t *bdaddr);
+
+bool gatt_db_write(struct gatt_db *db, uint16_t handle, uint16_t offset,
+					const uint8_t *value, size_t len,
+					uint8_t att_opcode, bdaddr_t *bdaddr);
-- 
1.8.4

