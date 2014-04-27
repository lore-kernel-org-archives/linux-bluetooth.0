Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: szymon.janc@tieto.com,
	Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH 2/2] shared/gatt: Extend write callback with offset
Date: Sun, 27 Apr 2014 17:11:36 +0200
Message-Id: <1398611496-31433-2-git-send-email-lukasz.rymanowski@tieto.com>
In-Reply-To: <1398611496-31433-1-git-send-email-lukasz.rymanowski@tieto.com>
References: <1398611496-31433-1-git-send-email-lukasz.rymanowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Offset is needed in case of prepare write.
---
 src/shared/gatt-db.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/src/shared/gatt-db.h b/src/shared/gatt-db.h
index d1443cb..2aa833a 100644
--- a/src/shared/gatt-db.h
+++ b/src/shared/gatt-db.h
@@ -33,7 +33,8 @@ bool gatt_db_remove_service(struct gatt_db *db, uint16_t handle);
 typedef void (*gatt_db_read_t) (uint16_t handle, void *req_data,
 							void *user_data);
 
-typedef void (*gatt_db_write_t) (uint16_t handle, const uint8_t *value,
+typedef void (*gatt_db_write_t) (uint16_t handle, uint16_t offset,
+						const uint8_t *value,
 						size_t len, void *req_data,
 						void *user_data);
 
-- 
1.8.4

