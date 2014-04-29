Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: szymon.janc@tieto.com, johan.hedberg@gmail.com,
	Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH v2 15/40] shared/gatt: Add complete command callback
Date: Tue, 29 Apr 2014 18:47:04 +0200
Message-Id: <1398790049-30303-16-git-send-email-lukasz.rymanowski@tieto.com>
In-Reply-To: <1398790049-30303-1-git-send-email-lukasz.rymanowski@tieto.com>
References: <1398790049-30303-1-git-send-email-lukasz.rymanowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

GATT server calls db and provides request data. Once characteristic
callback is done, complete callback shall be fired with request data
and pdu which should be sent to remote device.
---
 src/shared/gatt-db.h | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/src/shared/gatt-db.h b/src/shared/gatt-db.h
index 73f5119..5a6513a 100644
--- a/src/shared/gatt-db.h
+++ b/src/shared/gatt-db.h
@@ -30,11 +30,17 @@ uint16_t gatt_db_add_service(struct gatt_db *db, const bt_uuid_t *uuid,
 					bool primary, uint16_t num_handles);
 bool gatt_db_remove_service(struct gatt_db *db, uint16_t handle);
 
+typedef void (*gatt_db_complete_func_t)(void *req_data, const uint8_t *pdu,
+								uint16_t len);
+
 typedef void (*gatt_db_read_t) (uint16_t handle, uint16_t offset,
-					void *req_data, void *user_data);
+						void *req_data,
+						gatt_db_complete_func_t cb,
+						void *user_data);
 
 typedef void (*gatt_db_write_t) (uint16_t handle, const uint8_t *value,
 						size_t len, void *req_data,
+						gatt_db_complete_func_t cb,
 						void *user_data);
 
 uint16_t gatt_db_add_characteristic(struct gatt_db *db, uint16_t handle,
-- 
1.8.4

