Return-Path: <cyrus@holtmann.org>
From: Arman Uguray <armansito@chromium.org>
To: linux-bluetooth@vger.kernel.org
Cc: Arman Uguray <armansito@chromium.org>
Subject: [PATCH BlueZ 3/8] shared/gatt-db: Add complete callback to gatt_db_write.
Date: Mon, 20 Oct 2014 14:00:56 -0700
Message-Id: <1413838861-29956-4-git-send-email-armansito@chromium.org>
In-Reply-To: <1413838861-29956-1-git-send-email-armansito@chromium.org>
References: <1413838861-29956-1-git-send-email-armansito@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch introduces a completion callback parameter to gatt_db_write,
which is meant to be used by a gatt_db_write_t implementation to signal
the end of an asynchronous read operation performed in the upper layer.
---
 android/gatt.c       | 21 +++++++++++++--------
 src/shared/gatt-db.c |  7 +++++--
 src/shared/gatt-db.h |  8 +++++++-
 3 files changed, 25 insertions(+), 11 deletions(-)

diff --git a/android/gatt.c b/android/gatt.c
index e2aa686..80ba728 100644
--- a/android/gatt.c
+++ b/android/gatt.c
@@ -4799,6 +4799,8 @@ failed:
 static void write_cb(uint16_t handle, uint16_t offset,
 					const uint8_t *value, size_t len,
 					uint8_t att_opcode, bdaddr_t *bdaddr,
+					gatt_db_write_complete_t complete_func,
+					void *complete_data,
 					void *user_data)
 {
 	uint8_t buf[IPC_MTU];
@@ -5880,7 +5882,8 @@ static void write_cmd_request(const uint8_t *cmd, uint16_t cmd_len,
 	if (check_device_permissions(dev, cmd[0], permissions))
 		return;
 
-	gatt_db_write(gatt_db, handle, 0, value, vlen, cmd[0], &dev->bdaddr);
+	gatt_db_write(gatt_db, handle, 0, value, vlen, cmd[0], &dev->bdaddr,
+								NULL, NULL);
 }
 
 static void write_signed_cmd_request(const uint8_t *cmd, uint16_t cmd_len,
@@ -5948,7 +5951,7 @@ static void write_signed_cmd_request(const uint8_t *cmd, uint16_t cmd_len,
 		/* Signature OK, proceed with write */
 		bt_update_sign_counter(&dev->bdaddr, REMOTE_CSRK, r_sign_cnt);
 		gatt_db_write(gatt_db, handle, 0, value, vlen, cmd[0],
-								&dev->bdaddr);
+						&dev->bdaddr, NULL, NULL);
 	}
 }
 
@@ -5990,7 +5993,7 @@ static uint8_t write_req_request(const uint8_t *cmd, uint16_t cmd_len,
 	}
 
 	if (!gatt_db_write(gatt_db, handle, 0, value, vlen, cmd[0],
-								&dev->bdaddr)) {
+						&dev->bdaddr, NULL, NULL)) {
 		queue_remove(dev->pending_requests, data);
 		free(data);
 		return ATT_ECODE_UNLIKELY;
@@ -6042,7 +6045,7 @@ static uint8_t write_prep_request(const uint8_t *cmd, uint16_t cmd_len,
 	}
 
 	if (!gatt_db_write(gatt_db, handle, offset, value, vlen, cmd[0],
-								&dev->bdaddr))
+						&dev->bdaddr, NULL, NULL))
 		return ATT_ECODE_UNLIKELY;
 
 	return 0;
@@ -6583,10 +6586,12 @@ static void register_device_info_service(void)
 }
 
 static void gatt_srvc_change_write_cb(uint16_t handle, uint16_t offset,
-						const uint8_t *val, size_t len,
-						uint8_t att_opcode,
-						bdaddr_t *bdaddr,
-						void *user_data)
+					const uint8_t *val, size_t len,
+					uint8_t att_opcode,
+					bdaddr_t *bdaddr,
+					gatt_db_write_complete_t complete_func,
+					void *complete_data,
+					void *user_data)
 {
 	struct pending_request *entry;
 	struct gatt_device *dev;
diff --git a/src/shared/gatt-db.c b/src/shared/gatt-db.c
index c342e32..afb0c75 100644
--- a/src/shared/gatt-db.c
+++ b/src/shared/gatt-db.c
@@ -682,7 +682,9 @@ bool gatt_db_read(struct gatt_db *db, uint16_t handle, uint16_t offset,
 
 bool gatt_db_write(struct gatt_db *db, uint16_t handle, uint16_t offset,
 					const uint8_t *value, size_t len,
-					uint8_t att_opcode, bdaddr_t *bdaddr)
+					uint8_t att_opcode, bdaddr_t *bdaddr,
+					gatt_db_write_complete_t complete_func,
+					void *complete_data)
 {
 	struct gatt_db_service *service;
 	uint16_t service_handle;
@@ -700,7 +702,8 @@ bool gatt_db_write(struct gatt_db *db, uint16_t handle, uint16_t offset,
 		return false;
 
 	a->write_func(handle, offset, value, len, att_opcode, bdaddr,
-								a->user_data);
+						complete_func, complete_data,
+						a->user_data);
 
 	return true;
 }
diff --git a/src/shared/gatt-db.h b/src/shared/gatt-db.h
index 1c8739e..c940b71 100644
--- a/src/shared/gatt-db.h
+++ b/src/shared/gatt-db.h
@@ -39,9 +39,13 @@ typedef void (*gatt_db_read_t) (uint16_t handle, uint16_t offset,
 					void *complete_data,
 					void *user_data);
 
+typedef void (*gatt_db_write_complete_t)(uint16_t handle, uint16_t att_ecode,
+							void *complete_data);
 typedef void (*gatt_db_write_t) (uint16_t handle, uint16_t offset,
 					const uint8_t *value, size_t len,
 					uint8_t att_opcode, bdaddr_t *bdaddr,
+					gatt_db_write_complete_t complete_func,
+					void *complete_data,
 					void *user_data);
 
 uint16_t gatt_db_add_characteristic(struct gatt_db *db, uint16_t handle,
@@ -92,7 +96,9 @@ bool gatt_db_read(struct gatt_db *db, uint16_t handle, uint16_t offset,
 
 bool gatt_db_write(struct gatt_db *db, uint16_t handle, uint16_t offset,
 					const uint8_t *value, size_t len,
-					uint8_t att_opcode, bdaddr_t *bdaddr);
+					uint8_t att_opcode, bdaddr_t *bdaddr,
+					gatt_db_write_complete_t complete_func,
+					void *complete_data);
 
 const bt_uuid_t *gatt_db_get_attribute_type(struct gatt_db *db,
 							uint16_t handle);
-- 
2.1.0.rc2.206.gedb03e5

