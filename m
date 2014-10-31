Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v4 6/9] shared/gatt-db: Add gatt_db_attribute_get_service_handles
Date: Fri, 31 Oct 2014 15:39:51 +0200
Message-Id: <1414762794-30166-6-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1414762794-30166-1-git-send-email-luiz.dentz@gmail.com>
References: <1414762794-30166-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

---
 src/shared/gatt-db.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/src/shared/gatt-db.c b/src/shared/gatt-db.c
index e164055..a2684d8 100644
--- a/src/shared/gatt-db.c
+++ b/src/shared/gatt-db.c
@@ -882,7 +882,21 @@ bool gatt_db_attribute_get_service_handles(struct gatt_db_attribute *attrib,
 						uint16_t *start_handle,
 						uint16_t *end_handle)
 {
-	return false;
+	struct gatt_db_service *service;
+
+	if (!attrib)
+		return false;
+
+	service = attrib->service;
+
+	if (start_handle)
+		*start_handle = service->attributes[0]->handle;
+
+	if (end_handle)
+		*end_handle = service->attributes[0]->handle +
+						service->num_handles - 1;
+
+	return true;
 }
 
 bool gatt_db_attribute_get_permissions(struct gatt_db_attribute *attrib,
-- 
1.9.3

