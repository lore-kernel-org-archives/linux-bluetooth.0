Return-Path: <cyrus@holtmann.org>
From: Marcin Kraglak <marcin.kraglak@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv1 2/4] gatt: Add services list to gatt_db struct
Date: Wed, 16 Apr 2014 09:19:05 +0200
Message-Id: <1397632747-13308-3-git-send-email-marcin.kraglak@tieto.com>
In-Reply-To: <1397632747-13308-1-git-send-email-marcin.kraglak@tieto.com>
References: <1397632747-13308-1-git-send-email-marcin.kraglak@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Gatt database will store all services in queue services. Each service
contains attributes and number of handles in this service.
---
 src/shared/gatt-db.c | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/src/shared/gatt-db.c b/src/shared/gatt-db.c
index e56b381..b057c15 100644
--- a/src/shared/gatt-db.c
+++ b/src/shared/gatt-db.c
@@ -21,11 +21,23 @@
  *
  */
 
+#include <stdbool.h>
+
 #include "src/shared/util.h"
+#include "src/shared/queue.h"
 #include "src/shared/gatt-db.h"
 
 struct gatt_db {
 	uint16_t next_handle;
+	struct queue *services;
+};
+
+struct gatt_db_attribute {
+};
+
+struct gatt_db_service {
+	uint16_t num_handles;
+	struct gatt_db_attribute **attributes;
 };
 
 struct gatt_db *gatt_db_new(void)
@@ -36,12 +48,31 @@ struct gatt_db *gatt_db_new(void)
 	if (!db)
 		return NULL;
 
+	db->services = queue_new();
+	if (!db->services) {
+		free(db);
+		return NULL;
+	}
+
 	db->next_handle = 0x0001;
 
 	return db;
 }
 
+static void gatt_db_service_destroy(void *data)
+{
+	struct gatt_db_service *service = data;
+	int i;
+
+	for (i = 0; i < service->num_handles; i++)
+		free(service->attributes[i]);
+
+	free(service->attributes);
+	free(service);
+}
+
 void gatt_db_destroy(struct gatt_db *db)
 {
+	queue_destroy(db->services, gatt_db_service_destroy);
 	free(db);
 }
-- 
1.8.5.3

