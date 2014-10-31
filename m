Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v4 3/9] shared/gatt-db: Add gatt_db_attribute_get_type
Date: Fri, 31 Oct 2014 15:39:48 +0200
Message-Id: <1414762794-30166-3-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1414762794-30166-1-git-send-email-luiz.dentz@gmail.com>
References: <1414762794-30166-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

---
 src/shared/gatt-db.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/src/shared/gatt-db.c b/src/shared/gatt-db.c
index cc8e494..af1cde9 100644
--- a/src/shared/gatt-db.c
+++ b/src/shared/gatt-db.c
@@ -829,7 +829,10 @@ struct gatt_db_attribute *gatt_db_get_attribute(struct gatt_db *db,
 
 const bt_uuid_t *gatt_db_attribute_get_type(struct gatt_db_attribute *attrib)
 {
-	return NULL;
+	if (!attrib)
+		return NULL;
+
+	return &attrib->uuid;
 }
 
 uint16_t gatt_db_attribute_get_handle(struct gatt_db_attribute *attrib)
-- 
1.9.3

