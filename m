Return-Path: <cyrus@holtmann.org>
From: Mariusz Skamra <mariusz.skamra@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Mariusz Skamra <mariusz.skamra@tieto.com>
Subject: [PATCH] android/hog: Fix find included battery services
Date: Mon, 23 Feb 2015 12:29:38 +0100
Message-Id: <1424690978-10255-1-git-send-email-mariusz.skamra@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch fixes HOGP_TC_HGDR_RH_BV_01_I (Find Included Services).
Battery service in HOG device is always implemented as primary
service. However according to Test Spec if battery level is described
within report map characteristic it shall be included using include
definition. So this relationship discovery shall be performed using
find_included.
---
 android/hog.c | 77 +++++++++++++++++++++--------------------------------------
 1 file changed, 27 insertions(+), 50 deletions(-)

diff --git a/android/hog.c b/android/hog.c
index 7f441f1..b1d02a3 100644
--- a/android/hog.c
+++ b/android/hog.c
@@ -1224,20 +1224,30 @@ void bt_hog_unref(struct bt_hog *hog)
 	hog_free(hog);
 }
 
+static void hog_attach_bas(struct bt_hog *hog, struct gatt_primary *primary)
+{
+	if (hog->bas) {
+		bt_bas_attach(hog->bas, hog->attrib);
+		return;
+	}
+
+	hog->bas = bt_bas_new(primary);
+	if (hog->bas)
+		bt_bas_attach(hog->bas, hog->attrib);
+}
+
 static void find_included_cb(uint8_t status, GSList *services, void *user_data)
 {
 	struct gatt_request *req = user_data;
 	struct bt_hog *hog = req->user_data;
 	struct gatt_included *include;
+	struct gatt_primary *primary;
 	GSList *l;
 
 	DBG("");
 
 	destroy_gatt_req(req);
 
-	if (hog->primary)
-		return;
-
 	if (status) {
 		const char *str = att_ecode2str(status);
 		DBG("Find included failed: %s", str);
@@ -1251,30 +1261,17 @@ static void find_included_cb(uint8_t status, GSList *services, void *user_data)
 
 	for (l = services; l; l = l->next) {
 		include = l->data;
-
-		if (strcmp(include->uuid, HOG_UUID) == 0)
+		if (strcmp(include->uuid, BATTERY_UUID) == 0) {
+			primary = g_new0(struct gatt_primary, 1);
+			memcpy(primary->uuid, include->uuid,
+					sizeof(include->uuid));
+			memcpy(&primary->range, &include->range,
+					sizeof(include->range));
+			hog_attach_bas(hog, primary);
 			break;
-	}
-
-	if (!l) {
-		for (l = services; l; l = l->next) {
-			include = l->data;
-
-			find_included(hog, hog->attrib,
-					include->range.start,
-					include->range.end, find_included_cb,
-					hog);
 		}
-		return;
 	}
-
-	hog->primary = g_new0(struct gatt_primary, 1);
-	memcpy(hog->primary->uuid, include->uuid, sizeof(include->uuid));
-	memcpy(&hog->primary->range, &include->range, sizeof(include->range));
-
-	discover_char(hog, hog->attrib, hog->primary->range.start,
-						hog->primary->range.end, NULL,
-						char_discovered_cb, hog);
+	return;
 }
 
 static void hog_attach_scpp(struct bt_hog *hog, struct gatt_primary *primary)
@@ -1313,18 +1310,6 @@ static void hog_attach_dis(struct bt_hog *hog, struct gatt_primary *primary)
 	}
 }
 
-static void hog_attach_bas(struct bt_hog *hog, struct gatt_primary *primary)
-{
-	if (hog->bas) {
-		bt_bas_attach(hog->bas, hog->attrib);
-		return;
-	}
-
-	hog->bas = bt_bas_new(primary);
-	if (hog->bas)
-		bt_bas_attach(hog->bas, hog->attrib);
-}
-
 static void hog_attach_hog(struct bt_hog *hog, struct gatt_primary *primary)
 {
 	struct bt_hog *instance;
@@ -1334,6 +1319,8 @@ static void hog_attach_hog(struct bt_hog *hog, struct gatt_primary *primary)
 		discover_char(hog, hog->attrib, primary->range.start,
 						primary->range.end, NULL,
 						char_discovered_cb, hog);
+		find_included(hog, hog->attrib, primary->range.start,
+				primary->range.end, find_included_cb, hog);
 		return;
 	}
 
@@ -1342,6 +1329,9 @@ static void hog_attach_hog(struct bt_hog *hog, struct gatt_primary *primary)
 	if (!instance)
 		return;
 
+	find_included(instance, hog->attrib, primary->range.start,
+			primary->range.end, find_included_cb, instance);
+
 	bt_hog_attach(instance, hog->attrib);
 	hog->instances = g_slist_append(hog->instances, instance);
 }
@@ -1381,24 +1371,11 @@ static void primary_cb(uint8_t status, GSList *services, void *user_data)
 			continue;
 		}
 
-		if (strcmp(primary->uuid, BATTERY_UUID) == 0) {
-			hog_attach_bas(hog, primary);
-			continue;
-		}
-
 		if (strcmp(primary->uuid, HOG_UUID) == 0)
 			hog_attach_hog(hog, primary);
 	}
 
-	if (hog->primary)
-		return;
-
-	for (l = services; l; l = l->next) {
-		primary = l->data;
-
-		find_included(hog, hog->attrib, primary->range.start,
-				primary->range.end, find_included_cb, hog);
-	}
+	return;
 }
 
 bool bt_hog_attach(struct bt_hog *hog, void *gatt)
-- 
1.9.1

