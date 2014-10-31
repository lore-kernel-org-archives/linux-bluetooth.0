Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v4 7/9] shared/gatt-db: Add gatt_db_attribute_get_permissions
Date: Fri, 31 Oct 2014 15:39:52 +0200
Message-Id: <1414762794-30166-7-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1414762794-30166-1-git-send-email-luiz.dentz@gmail.com>
References: <1414762794-30166-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

---
 src/shared/gatt-db.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/src/shared/gatt-db.c b/src/shared/gatt-db.c
index a2684d8..b447199 100644
--- a/src/shared/gatt-db.c
+++ b/src/shared/gatt-db.c
@@ -902,7 +902,12 @@ bool gatt_db_attribute_get_service_handles(struct gatt_db_attribute *attrib,
 bool gatt_db_attribute_get_permissions(struct gatt_db_attribute *attrib,
 							uint32_t *permissions)
 {
-	return false;
+	if (!attrib || !permissions)
+		return false;
+
+	*permissions = attrib->permissions;
+
+	return true;
 }
 
 bool gatt_db_attribute_read(struct gatt_db_attribute *attrib, uint16_t offset,
-- 
1.9.3

