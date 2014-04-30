Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: szymon.janc@tieto.com, johan.hedberg@gmail.com,
	Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH v4 13/38] shared/gatt: Use bdaddr instead of request_id
Date: Wed, 30 Apr 2014 11:13:44 +0200
Message-Id: <1398849249-5868-14-git-send-email-lukasz.rymanowski@tieto.com>
In-Reply-To: <1398849249-5868-1-git-send-email-lukasz.rymanowski@tieto.com>
References: <1398849249-5868-1-git-send-email-lukasz.rymanowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

As it turns out we do not need request_id but bdaddr. It is because
response to remote device will be sent from read/write callback.
---
 src/shared/gatt-db.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/src/shared/gatt-db.h b/src/shared/gatt-db.h
index f68f4b3..0261e5b 100644
--- a/src/shared/gatt-db.h
+++ b/src/shared/gatt-db.h
@@ -30,12 +30,12 @@ uint16_t gatt_db_add_service(struct gatt_db *db, const bt_uuid_t *uuid,
 					bool primary, uint16_t num_handles);
 bool gatt_db_remove_service(struct gatt_db *db, uint16_t handle);
 
-typedef void (*gatt_db_read_t) (uint16_t handle, uint16_t request_id,
+typedef void (*gatt_db_read_t) (uint16_t handle, bdaddr_t *bdaddr,
 							void *user_data);
 
-typedef void (*gatt_db_write_t) (uint16_t handle, uint16_t request_id,
-					const uint8_t *value, size_t len,
-					void *user_data);
+typedef void (*gatt_db_write_t) (uint16_t handle, const uint8_t *value,
+						size_t len, bdaddr_t *bdaddr,
+						void *user_data);
 
 uint16_t gatt_db_add_characteristic(struct gatt_db *db, uint16_t handle,
 						const bt_uuid_t *uuid,
-- 
1.8.4

