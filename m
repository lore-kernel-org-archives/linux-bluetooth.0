Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 2/3] dis: Add support to gatt-db
Date: Tue, 27 Dec 2016 14:40:38 +0200
Message-Id: <20161227124039.10405-2-luiz.dentz@gmail.com>
In-Reply-To: <20161227124039.10405-1-luiz.dentz@gmail.com>
References: <20161227124039.10405-1-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This add support of passing a gatt-db to avoid having to discover the
services again, this should also make it easier to port to bt_gatt_client
once Android code support it.
---
 profiles/deviceinfo/dis.c | 45 +++++++++++++++++++++++++++++++++++++++++++--
 profiles/deviceinfo/dis.h |  3 ++-
 profiles/input/hog-lib.c  |  2 +-
 3 files changed, 46 insertions(+), 4 deletions(-)

diff --git a/profiles/deviceinfo/dis.c b/profiles/deviceinfo/dis.c
index 91c5d39..91ce26b 100644
--- a/profiles/deviceinfo/dis.c
+++ b/profiles/deviceinfo/dis.c
@@ -37,6 +37,8 @@
 
 #include "src/shared/util.h"
 #include "src/shared/queue.h"
+#include "src/shared/att.h"
+#include "src/shared/gatt-db.h"
 
 #include "attrib/gattrib.h"
 #include "attrib/att.h"
@@ -44,6 +46,7 @@
 
 #include "profiles/deviceinfo/dis.h"
 
+#define DIS_UUID16	0x180a
 #define PNP_ID_SIZE	7
 
 struct bt_dis {
@@ -87,7 +90,43 @@ static void dis_free(struct bt_dis *dis)
 	g_free(dis);
 }
 
-struct bt_dis *bt_dis_new(void *primary)
+static void foreach_dis_service(struct gatt_db_attribute *attr, void *user_data)
+{
+	struct bt_dis *dis = user_data;
+
+	/* Ignore if there are multiple instances */
+	if (dis->handle)
+		return;
+
+	dis->handle = gatt_db_attribute_get_handle(attr);
+}
+
+struct bt_dis *bt_dis_new(struct gatt_db *db)
+{
+	struct bt_dis *dis;
+
+	dis = g_try_new0(struct bt_dis, 1);
+	if (!dis)
+		return NULL;
+
+	dis->gatt_op = queue_new();
+
+	if (db) {
+		bt_uuid_t uuid;
+
+		/* Handle the DIS service */
+		bt_uuid16_create(&uuid, DIS_UUID16);
+		gatt_db_foreach_service(db, &uuid, foreach_dis_service, dis);
+		if (!dis->handle) {
+			dis_free(dis);
+			return NULL;
+		}
+	}
+
+	return bt_dis_ref(dis);
+}
+
+struct bt_dis *bt_dis_new_primary(void *primary)
 {
 	struct bt_dis *dis;
 
@@ -251,7 +290,7 @@ bool bt_dis_attach(struct bt_dis *dis, void *attrib)
 {
 	struct gatt_primary *primary = dis->primary;
 
-	if (dis->attrib || !primary)
+	if (dis->attrib)
 		return false;
 
 	dis->attrib = g_attrib_ref(attrib);
@@ -260,6 +299,8 @@ bool bt_dis_attach(struct bt_dis *dis, void *attrib)
 		discover_char(dis, dis->attrib, primary->range.start,
 						primary->range.end, NULL,
 						configure_deviceinfo_cb, dis);
+	else
+		read_char(dis, attrib, dis->handle, read_pnpid_cb, dis);
 
 	return true;
 }
diff --git a/profiles/deviceinfo/dis.h b/profiles/deviceinfo/dis.h
index faf27b3..305ba1a 100644
--- a/profiles/deviceinfo/dis.h
+++ b/profiles/deviceinfo/dis.h
@@ -23,7 +23,8 @@
 
 struct bt_dis;
 
-struct bt_dis *bt_dis_new(void *primary);
+struct bt_dis *bt_dis_new(struct gatt_db *db);
+struct bt_dis *bt_dis_new_primary(void *primary);
 
 struct bt_dis *bt_dis_ref(struct bt_dis *dis);
 void bt_dis_unref(struct bt_dis *dis);
diff --git a/profiles/input/hog-lib.c b/profiles/input/hog-lib.c
index ed38916..0f2f394 100644
--- a/profiles/input/hog-lib.c
+++ b/profiles/input/hog-lib.c
@@ -1503,7 +1503,7 @@ static void hog_attach_dis(struct bt_hog *hog, struct gatt_primary *primary)
 		return;
 	}
 
-	hog->dis = bt_dis_new(primary);
+	hog->dis = bt_dis_new_primary(primary);
 	if (hog->dis) {
 		bt_dis_set_notification(hog->dis, dis_notify, hog);
 		bt_dis_attach(hog->dis, hog->attrib);
-- 
2.9.3

