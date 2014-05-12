Return-Path: <cyrus@holtmann.org>
From: Marcin Kraglak <marcin.kraglak@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/8] shared/gatt: Extend gatt_db_read function
Date: Mon, 12 May 2014 15:02:32 +0200
Message-Id: <1399899758-4944-3-git-send-email-marcin.kraglak@tieto.com>
In-Reply-To: <1399899758-4944-1-git-send-email-marcin.kraglak@tieto.com>
References: <1399899758-4944-1-git-send-email-marcin.kraglak@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

If value exists in database, return pointer to it instead of returning
false. It is needed because some attributes don't have read_cb callback
and their value can be read directly from database. If read_cb is
registered, it will be called. In case of error false will be returned.
---
 android/gatt.c       |  3 ++-
 src/shared/gatt-db.c | 17 ++++++++++++++---
 src/shared/gatt-db.h |  3 ++-
 3 files changed, 18 insertions(+), 5 deletions(-)

diff --git a/android/gatt.c b/android/gatt.c
index d8bcfb5..0a2abe3 100644
--- a/android/gatt.c
+++ b/android/gatt.c
@@ -4105,7 +4105,8 @@ static uint8_t read_request(const uint8_t *cmd, uint16_t cmd_len,
 		return ATT_ECODE_REQ_NOT_SUPP;
 	}
 
-	if (!gatt_db_read(gatt_db, handle, offset, cmd[0], &dev->bdaddr))
+	if (!gatt_db_read(gatt_db, handle, offset, cmd[0], &dev->bdaddr, NULL,
+									NULL))
 		return ATT_ECODE_UNLIKELY;
 
 	return 0;
diff --git a/src/shared/gatt-db.c b/src/shared/gatt-db.c
index ebfd586..adce153 100644
--- a/src/shared/gatt-db.c
+++ b/src/shared/gatt-db.c
@@ -684,12 +684,16 @@ static bool find_service_for_handle(const void *data, const void *user_data)
 }
 
 bool gatt_db_read(struct gatt_db *db, uint16_t handle, uint16_t offset,
-				uint8_t att_opcode, bdaddr_t *bdaddr)
+				uint8_t att_opcode, bdaddr_t *bdaddr,
+				uint8_t **value, uint16_t *length)
 {
 	struct gatt_db_service *service;
 	uint16_t service_handle;
 	struct gatt_db_attribute *a;
 
+	if (!value || !length)
+		return false;
+
 	service = queue_find(db->services, find_service_for_handle,
 						INT_TO_PTR(handle));
 	if (!service)
@@ -698,10 +702,17 @@ bool gatt_db_read(struct gatt_db *db, uint16_t handle, uint16_t offset,
 	service_handle = service->attributes[0]->handle;
 
 	a = service->attributes[handle - service_handle];
-	if (!a || !a->read_func)
+	if (!a || offset > a->value_len)
 		return false;
 
-	a->read_func(handle, offset, att_opcode, bdaddr, a->user_data);
+	if (!a->read_func) {
+		*value = &a->value[offset];
+		*length = a->value_len - offset;
+	} else {
+		*value = NULL;
+		*length = 0;
+		a->read_func(handle, offset, att_opcode, bdaddr, a->user_data);
+	}
 
 	return true;
 }
diff --git a/src/shared/gatt-db.h b/src/shared/gatt-db.h
index f704b8e..a5a5f41 100644
--- a/src/shared/gatt-db.h
+++ b/src/shared/gatt-db.h
@@ -106,7 +106,8 @@ void gatt_db_find_information(struct gatt_db *db, uint16_t start_handle,
 							struct queue *queue);
 
 bool gatt_db_read(struct gatt_db *db, uint16_t handle, uint16_t offset,
-					uint8_t att_opcode, bdaddr_t *bdaddr);
+					uint8_t att_opcode, bdaddr_t *bdaddr,
+					uint8_t **value, uint16_t *length);
 
 bool gatt_db_write(struct gatt_db *db, uint16_t handle, uint16_t offset,
 					const uint8_t *value, size_t len,
-- 
1.8.5.3

