Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: szymon.janc@tieto.com, johan.hedberg@gmail.com,
	Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH v4 15/38] shared/gatt: Add att_opcode to read/write callback
Date: Wed, 30 Apr 2014 11:13:46 +0200
Message-Id: <1398849249-5868-16-git-send-email-lukasz.rymanowski@tieto.com>
In-Reply-To: <1398849249-5868-1-git-send-email-lukasz.rymanowski@tieto.com>
References: <1398849249-5868-1-git-send-email-lukasz.rymanowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This is because there is many types of read/write requests and user
needs to know if and what response send back.
---
 src/shared/gatt-db.h | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/src/shared/gatt-db.h b/src/shared/gatt-db.h
index d05f4c1..74817a0 100644
--- a/src/shared/gatt-db.h
+++ b/src/shared/gatt-db.h
@@ -31,11 +31,13 @@ uint16_t gatt_db_add_service(struct gatt_db *db, const bt_uuid_t *uuid,
 bool gatt_db_remove_service(struct gatt_db *db, uint16_t handle);
 
 typedef void (*gatt_db_read_t) (uint16_t handle, uint16_t offset,
-					bdaddr_t *bdaddr, void *user_data);
+					uint8_t att_opcode, bdaddr_t *bdaddr,
+					void *user_data);
 
 typedef void (*gatt_db_write_t) (uint16_t handle, uint16_t offset,
 					const uint8_t *value, size_t len,
-					bdaddr_t *bdaddr, void *user_data);
+					uint8_t att_opcode, bdaddr_t *bdaddr,
+					void *user_data);
 
 uint16_t gatt_db_add_characteristic(struct gatt_db *db, uint16_t handle,
 						const bt_uuid_t *uuid,
-- 
1.8.4

