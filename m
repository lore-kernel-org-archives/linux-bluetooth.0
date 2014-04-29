Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: szymon.janc@tieto.com,
	Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH 11/36] shared: Use pointer for request data instead of int
Date: Tue, 29 Apr 2014 03:14:42 +0200
Message-Id: <1398734107-4793-13-git-send-email-lukasz.rymanowski@tieto.com>
In-Reply-To: <1398734107-4793-1-git-send-email-lukasz.rymanowski@tieto.com>
References: <1398734107-4793-1-git-send-email-lukasz.rymanowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This is because user of database might need to get in callback some more
information then request id. It is to avoid keep in database user any
list of request_id data.
---
 src/shared/gatt-db.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/src/shared/gatt-db.h b/src/shared/gatt-db.h
index f68f4b3..d1443cb 100644
--- a/src/shared/gatt-db.h
+++ b/src/shared/gatt-db.h
@@ -30,12 +30,12 @@ uint16_t gatt_db_add_service(struct gatt_db *db, const bt_uuid_t *uuid,
 					bool primary, uint16_t num_handles);
 bool gatt_db_remove_service(struct gatt_db *db, uint16_t handle);
 
-typedef void (*gatt_db_read_t) (uint16_t handle, uint16_t request_id,
+typedef void (*gatt_db_read_t) (uint16_t handle, void *req_data,
 							void *user_data);
 
-typedef void (*gatt_db_write_t) (uint16_t handle, uint16_t request_id,
-					const uint8_t *value, size_t len,
-					void *user_data);
+typedef void (*gatt_db_write_t) (uint16_t handle, const uint8_t *value,
+						size_t len, void *req_data,
+						void *user_data);
 
 uint16_t gatt_db_add_characteristic(struct gatt_db *db, uint16_t handle,
 						const bt_uuid_t *uuid,
-- 
1.8.4

