Return-Path: <cyrus@holtmann.org>
From: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jakub Tyszkowski <jakub.tyszkowski@tieto.com>
Subject: [PATCH 4/6] shared/gatt-db: Fix cropping permissions value
Date: Tue, 27 May 2014 12:15:32 +0200
Message-Id: <1401185734-23672-4-git-send-email-jakub.tyszkowski@tieto.com>
In-Reply-To: <1401185734-23672-1-git-send-email-jakub.tyszkowski@tieto.com>
References: <1401185734-23672-1-git-send-email-jakub.tyszkowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 src/shared/gatt-db.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/shared/gatt-db.c b/src/shared/gatt-db.c
index d6f3143..998e93e 100644
--- a/src/shared/gatt-db.c
+++ b/src/shared/gatt-db.c
@@ -258,7 +258,7 @@ static uint16_t update_attribute_handle(struct gatt_db_service *service,
 static void set_attribute_data(struct gatt_db_attribute *attribute,
 						gatt_db_read_t read_func,
 						gatt_db_write_t write_func,
-						uint8_t permissions,
+						uint32_t permissions,
 						void *user_data)
 {
 	attribute->permissions = permissions;
-- 
1.9.3

