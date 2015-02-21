Return-Path: <cyrus@holtmann.org>
From: Arman Uguray <armansito@chromium.org>
To: linux-bluetooth@vger.kernel.org
Cc: luiz.dentz@gmail.com, Arman Uguray <armansito@chromium.org>
Subject: [PATCH BlueZ 03/18] shared/gatt: Cancel timeouts when attrib removed
Date: Fri, 20 Feb 2015 17:56:48 -0800
Message-Id: <1424483824-27374-4-git-send-email-armansito@chromium.org>
In-Reply-To: <1424483824-27374-1-git-send-email-armansito@chromium.org>
References: <1424483824-27374-1-git-send-email-armansito@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This cancels the pending request timeouts when a gatt_db_attribute
structure is removed from the gatt-db, to prevent an invalid access
when the timeout fires after a free. This patch also increases the
pending request timeout interval from 1 second to 5 seconds.
---
 src/shared/gatt-db.c | 62 ++++++++++++++++++++++++++++++++--------------------
 1 file changed, 38 insertions(+), 24 deletions(-)

diff --git a/src/shared/gatt-db.c b/src/shared/gatt-db.c
index 2a00171..606ae84 100644
--- a/src/shared/gatt-db.c
+++ b/src/shared/gatt-db.c
@@ -38,7 +38,7 @@
 
 #define MAX_CHAR_DECL_VALUE_LEN 19
 #define MAX_INCLUDED_VALUE_LEN 6
-#define ATTRIBUTE_TIMEOUT 1000
+#define ATTRIBUTE_TIMEOUT 5000
 
 static const bt_uuid_t primary_service_uuid = { .type = BT_UUID16,
 					.value.u16 = GATT_PRIM_SVC_UUID };
@@ -109,14 +109,49 @@ struct gatt_db_service {
 	struct gatt_db_attribute **attributes;
 };
 
+static void pending_read_result(struct pending_read *p, int err,
+					const uint8_t *data, size_t length)
+{
+	if (p->timeout_id > 0)
+		timeout_remove(p->timeout_id);
+
+	p->func(p->attrib, err, data, length, p->user_data);
+
+	free(p);
+}
+
+static void pending_read_free(void *data)
+{
+	struct pending_read *p = data;
+
+	pending_read_result(p, -ECANCELED, NULL, 0);
+}
+
+static void pending_write_result(struct pending_write *p, int err)
+{
+	if (p->timeout_id > 0)
+		timeout_remove(p->timeout_id);
+
+	p->func(p->attrib, err, p->user_data);
+
+	free(p);
+}
+
+static void pending_write_free(void *data)
+{
+	struct pending_write *p = data;
+
+	pending_write_result(p, -ECANCELED);
+}
+
 static void attribute_destroy(struct gatt_db_attribute *attribute)
 {
 	/* Attribute was not initialized by user */
 	if (!attribute)
 		return;
 
-	queue_destroy(attribute->pending_reads, free);
-	queue_destroy(attribute->pending_writes, free);
+	queue_destroy(attribute->pending_reads, pending_read_free);
+	queue_destroy(attribute->pending_writes, pending_write_free);
 
 	free(attribute->value);
 	free(attribute);
@@ -1403,17 +1438,6 @@ gatt_db_attribute_get_permissions(const struct gatt_db_attribute *attrib)
 	return attrib->permissions;
 }
 
-static void pending_read_result(struct pending_read *p, int err,
-					const uint8_t *data, size_t length)
-{
-	if (p->timeout_id > 0)
-		timeout_remove(p->timeout_id);
-
-	p->func(p->attrib, err, data, length, p->user_data);
-
-	free(p);
-}
-
 static bool read_timeout(void *user_data)
 {
 	struct pending_read *p = user_data;
@@ -1498,16 +1522,6 @@ bool gatt_db_attribute_read_result(struct gatt_db_attribute *attrib,
 	return true;
 }
 
-static void pending_write_result(struct pending_write *p, int err)
-{
-	if (p->timeout_id > 0)
-		timeout_remove(p->timeout_id);
-
-	p->func(p->attrib, err, p->user_data);
-
-	free(p);
-}
-
 static bool write_timeout(void *user_data)
 {
 	struct pending_write *p = user_data;
-- 
2.2.0.rc0.207.ga3a616c

