Return-Path: <cyrus@holtmann.org>
From: Mariusz Skamra <mariusz.skamra@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: szymon.janc@tieto.com, Mariusz Skamra <mariusz.skamra@tieto.com>
Subject: [PATCHv3 1/2] android/hog: Fix find included battery services
Date: Tue, 24 Feb 2015 19:15:30 +0100
Message-Id: <1424801730-17858-1-git-send-email-mariusz.skamra@tieto.com>
In-Reply-To: <9254902.0pts8jDy8t@uw000953>
References: <9254902.0pts8jDy8t@uw000953>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

In TC_HGDC_HH_BV_14_I there is only one HID service which includes one battery service.
However there is another battery service not refferenced as include. So a list of battery
services inside bt_hog struct is needed, because according to HOGP specification HID
device shall have one or more instances of battery service.
For TC_HGDR_RH_BV_01_I test purposes scan of include services is performed.
---
 android/hog.c | 91 +++++++++++++++++++++++------------------------------------
 1 file changed, 35 insertions(+), 56 deletions(-)

diff --git a/android/hog.c b/android/hog.c
index 7f441f1..771f299 100644
--- a/android/hog.c
+++ b/android/hog.c
@@ -99,7 +99,7 @@ struct bt_hog {
 	uint16_t		setrep_id;
 	struct bt_scpp		*scpp;
 	struct bt_dis		*dis;
-	struct bt_bas		*bas;
+	GSList			*bas;
 	GSList			*instances;
 	struct queue		*gatt_op;
 };
@@ -1151,6 +1151,13 @@ static void cancel_gatt_req(struct gatt_request *req)
 		destroy_gatt_req(req);
 }
 
+static void free_bas(void *data)
+{
+	struct bt_bas *bas = data;
+
+	bt_bas_unref(bas);
+}
+
 static void hog_free(void *data)
 {
 	struct bt_hog *hog = data;
@@ -1161,7 +1168,7 @@ static void hog_free(void *data)
 
 	bt_scpp_unref(hog->scpp);
 	bt_dis_unref(hog->dis);
-	bt_bas_unref(hog->bas);
+	g_slist_free_full(hog->bas, free_bas);
 	bt_uhid_unref(hog->uhid);
 	g_slist_free_full(hog->reports, report_free);
 	g_free(hog->name);
@@ -1228,53 +1235,23 @@ static void find_included_cb(uint8_t status, GSList *services, void *user_data)
 {
 	struct gatt_request *req = user_data;
 	struct bt_hog *hog = req->user_data;
-	struct gatt_included *include;
 	GSList *l;
 
 	DBG("");
 
 	destroy_gatt_req(req);
 
-	if (hog->primary)
-		return;
-
 	if (status) {
 		const char *str = att_ecode2str(status);
 		DBG("Find included failed: %s", str);
 		return;
 	}
 
-	if (!services) {
-		DBG("No included service found");
-		return;
-	}
-
 	for (l = services; l; l = l->next) {
-		include = l->data;
-
-		if (strcmp(include->uuid, HOG_UUID) == 0)
-			break;
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
-		}
-		return;
+		struct gatt_included *include = l->data;
+		DBG("included: handle %x, uuid %s",
+			include->handle, include->uuid);
 	}
-
-	hog->primary = g_new0(struct gatt_primary, 1);
-	memcpy(hog->primary->uuid, include->uuid, sizeof(include->uuid));
-	memcpy(&hog->primary->range, &include->range, sizeof(include->range));
-
-	discover_char(hog, hog->attrib, hog->primary->range.start,
-						hog->primary->range.end, NULL,
-						char_discovered_cb, hog);
 }
 
 static void hog_attach_scpp(struct bt_hog *hog, struct gatt_primary *primary)
@@ -1315,14 +1292,14 @@ static void hog_attach_dis(struct bt_hog *hog, struct gatt_primary *primary)
 
 static void hog_attach_bas(struct bt_hog *hog, struct gatt_primary *primary)
 {
-	if (hog->bas) {
-		bt_bas_attach(hog->bas, hog->attrib);
+	struct bt_bas *instance;
+
+	instance = bt_bas_new(primary);
+	if (!instance)
 		return;
-	}
 
-	hog->bas = bt_bas_new(primary);
-	if (hog->bas)
-		bt_bas_attach(hog->bas, hog->attrib);
+	bt_bas_attach(instance, hog->attrib);
+	hog->bas = g_slist_append(hog->bas, instance);
 }
 
 static void hog_attach_hog(struct bt_hog *hog, struct gatt_primary *primary)
@@ -1334,6 +1311,8 @@ static void hog_attach_hog(struct bt_hog *hog, struct gatt_primary *primary)
 		discover_char(hog, hog->attrib, primary->range.start,
 						primary->range.end, NULL,
 						char_discovered_cb, hog);
+		find_included(hog, hog->attrib, primary->range.start,
+				primary->range.end, find_included_cb, hog);
 		return;
 	}
 
@@ -1342,6 +1321,9 @@ static void hog_attach_hog(struct bt_hog *hog, struct gatt_primary *primary)
 	if (!instance)
 		return;
 
+	find_included(instance, hog->attrib, primary->range.start,
+			primary->range.end, find_included_cb, instance);
+
 	bt_hog_attach(instance, hog->attrib);
 	hog->instances = g_slist_append(hog->instances, instance);
 }
@@ -1389,16 +1371,6 @@ static void primary_cb(uint8_t status, GSList *services, void *user_data)
 		if (strcmp(primary->uuid, HOG_UUID) == 0)
 			hog_attach_hog(hog, primary);
 	}
-
-	if (hog->primary)
-		return;
-
-	for (l = services; l; l = l->next) {
-		primary = l->data;
-
-		find_included(hog, hog->attrib, primary->range.start,
-				primary->range.end, find_included_cb, hog);
-	}
 }
 
 bool bt_hog_attach(struct bt_hog *hog, void *gatt)
@@ -1422,8 +1394,12 @@ bool bt_hog_attach(struct bt_hog *hog, void *gatt)
 	if (hog->dis)
 		bt_dis_attach(hog->dis, gatt);
 
-	if (hog->bas)
-		bt_bas_attach(hog->bas, gatt);
+	for (l = hog->bas; l; l = l->next) {
+		struct bt_bas *instance = l->data;
+
+		bt_bas_attach(instance, gatt);
+	}
+
 
 	for (l = hog->instances; l; l = l->next) {
 		struct bt_hog *instance = l->data;
@@ -1457,6 +1433,12 @@ void bt_hog_detach(struct bt_hog *hog)
 	if (!hog->attrib)
 		return;
 
+	for (l = hog->bas; l; l = l->next) {
+		struct bt_bas *instance = l->data;
+
+		bt_bas_detach(instance);
+	}
+
 	for (l = hog->instances; l; l = l->next) {
 		struct bt_hog *instance = l->data;
 
@@ -1478,9 +1460,6 @@ void bt_hog_detach(struct bt_hog *hog)
 	if (hog->dis)
 		bt_dis_detach(hog->dis);
 
-	if (hog->bas)
-		bt_bas_detach(hog->bas);
-
 	queue_foreach(hog->gatt_op, (void *) cancel_gatt_req, NULL);
 	g_attrib_unref(hog->attrib);
 	hog->attrib = NULL;
-- 
1.9.1

