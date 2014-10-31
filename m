Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v4 4/9] shared/gatt-db: Add gatt_db_attribute_get_handle
Date: Fri, 31 Oct 2014 15:39:49 +0200
Message-Id: <1414762794-30166-4-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1414762794-30166-1-git-send-email-luiz.dentz@gmail.com>
References: <1414762794-30166-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

---
 src/shared/gatt-db.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/src/shared/gatt-db.c b/src/shared/gatt-db.c
index af1cde9..c24b643 100644
--- a/src/shared/gatt-db.c
+++ b/src/shared/gatt-db.c
@@ -837,7 +837,10 @@ const bt_uuid_t *gatt_db_attribute_get_type(struct gatt_db_attribute *attrib)
 
 uint16_t gatt_db_attribute_get_handle(struct gatt_db_attribute *attrib)
 {
-	return 0;
+	if (!attrib)
+		return 0;
+
+	return attrib->handle;
 }
 
 bool gatt_db_attribute_get_service_uuid(struct gatt_db_attribute *attrib,
-- 
1.9.3

