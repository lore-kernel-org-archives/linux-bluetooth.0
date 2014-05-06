Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH] shared/gatt: Check if handles counter is not wrapped
Date: Tue,  6 May 2014 16:27:23 +0200
Message-Id: <1399386443-25537-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Make sure that handles are fitting in UINT16_MAX range before adding
service to database.
---
 src/shared/gatt-db.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/shared/gatt-db.c b/src/shared/gatt-db.c
index 6a15a4c..ebfd586 100644
--- a/src/shared/gatt-db.c
+++ b/src/shared/gatt-db.c
@@ -162,7 +162,7 @@ uint16_t gatt_db_add_service(struct gatt_db *db, const bt_uuid_t *uuid,
 	uint8_t value[16];
 	uint16_t len;
 
-	if (num_handles < 1)
+	if (num_handles < 1 || (num_handles + db->next_handle) > UINT16_MAX)
 		return 0;
 
 	service = new0(struct gatt_db_service, 1);
-- 
1.9.1

