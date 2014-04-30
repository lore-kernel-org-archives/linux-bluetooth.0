Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: szymon.janc@tieto.com, johan.hedberg@gmail.com,
	Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH v4 14/38] shared/gatt: Extend read/write callback with offset
Date: Wed, 30 Apr 2014 11:13:45 +0200
Message-Id: <1398849249-5868-15-git-send-email-lukasz.rymanowski@tieto.com>
In-Reply-To: <1398849249-5868-1-git-send-email-lukasz.rymanowski@tieto.com>
References: <1398849249-5868-1-git-send-email-lukasz.rymanowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Offset is needed for read blob and prep write
---
 src/shared/gatt-db.h | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/src/shared/gatt-db.h b/src/shared/gatt-db.h
index 0261e5b..d05f4c1 100644
--- a/src/shared/gatt-db.h
+++ b/src/shared/gatt-db.h
@@ -30,12 +30,12 @@ uint16_t gatt_db_add_service(struct gatt_db *db, const bt_uuid_t *uuid,
 					bool primary, uint16_t num_handles);
 bool gatt_db_remove_service(struct gatt_db *db, uint16_t handle);
 
-typedef void (*gatt_db_read_t) (uint16_t handle, bdaddr_t *bdaddr,
-							void *user_data);
+typedef void (*gatt_db_read_t) (uint16_t handle, uint16_t offset,
+					bdaddr_t *bdaddr, void *user_data);
 
-typedef void (*gatt_db_write_t) (uint16_t handle, const uint8_t *value,
-						size_t len, bdaddr_t *bdaddr,
-						void *user_data);
+typedef void (*gatt_db_write_t) (uint16_t handle, uint16_t offset,
+					const uint8_t *value, size_t len,
+					bdaddr_t *bdaddr, void *user_data);
 
 uint16_t gatt_db_add_characteristic(struct gatt_db *db, uint16_t handle,
 						const bt_uuid_t *uuid,
-- 
1.8.4

