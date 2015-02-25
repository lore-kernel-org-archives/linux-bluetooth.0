Return-Path: <cyrus@holtmann.org>
From: Mariusz Skamra <mariusz.skamra@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Mariusz Skamra <mariusz.skamra@tieto.com>
Subject: [PATCHv4 2/3] android/hog: Fix find included battery services
Date: Wed, 25 Feb 2015 13:22:10 +0100
Message-Id: <1424866931-13334-3-git-send-email-mariusz.skamra@tieto.com>
In-Reply-To: <1424866931-13334-1-git-send-email-mariusz.skamra@tieto.com>
References: <1424866931-13334-1-git-send-email-mariusz.skamra@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

I deleted most of the code related to finding include services. This method was used
only in situation when HID service as primary service was not found. However according to
SPEC HID device shall implement HID service as primary. Further HOG is called
from hidhost's hog_conn_cb when HID service was found and connection was established using LE.
Now searching for include services is performed because TC_HGDR_RH_BV_01_I requires that.

I also added a queue of battery services because according to HOGP SPEC there could be more
than one battery services like in TC_HGDC_HH_BV_14_I where there is only one HID service,
and two battery services. So the first found bas was overwritten by the second one and
after reconnection only one bas was attached.
---
 android/hog.c | 84 +++++++++++++++++++----------------------------------------
 1 file changed, 27 insertions(+), 57 deletions(-)

diff --git a/android/hog.c b/android/hog.c
index 7f441f1..c844893 100644
--- a/android/hog.c
+++ b/android/hog.c
@@ -99,7 +99,7 @@ struct bt_hog {
 	uint16_t		setrep_id;
 	struct bt_scpp		*scpp;
 	struct bt_dis		*dis;
-	struct bt_bas		*bas;
+	struct queue		*bas;
 	GSList			*instances;
 	struct queue		*gatt_op;
 };
@@ -1157,11 +1157,11 @@ static void hog_free(void *data)
 
 	bt_hog_detach(hog);
 
+	queue_destroy(hog->bas, (void *) bt_bas_unref);
 	g_slist_free_full(hog->instances, hog_free);
 
 	bt_scpp_unref(hog->scpp);
 	bt_dis_unref(hog->dis);
-	bt_bas_unref(hog->bas);
 	bt_uhid_unref(hog->uhid);
 	g_slist_free_full(hog->reports, report_free);
 	g_free(hog->name);
@@ -1185,10 +1185,18 @@ struct bt_hog *bt_hog_new(const char *name, uint16_t vendor, uint16_t product,
 		return NULL;
 	}
 
+	hog->bas = queue_new();
+	if (!hog->bas) {
+		queue_destroy(hog->gatt_op, NULL);
+		hog_free(hog);
+		return NULL;
+	}
+
 	hog->uhid = bt_uhid_new_default();
 	if (!hog->uhid) {
 		hog_free(hog);
 		queue_destroy(hog->gatt_op, NULL);
+		queue_destroy(hog->bas, NULL);
 		return NULL;
 	}
 
@@ -1227,54 +1235,23 @@ void bt_hog_unref(struct bt_hog *hog)
 static void find_included_cb(uint8_t status, GSList *services, void *user_data)
 {
 	struct gatt_request *req = user_data;
-	struct bt_hog *hog = req->user_data;
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
+	queue_push_head(hog->bas, instance);
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
@@ -1422,8 +1394,7 @@ bool bt_hog_attach(struct bt_hog *hog, void *gatt)
 	if (hog->dis)
 		bt_dis_attach(hog->dis, gatt);
 
-	if (hog->bas)
-		bt_bas_attach(hog->bas, gatt);
+	queue_foreach(hog->bas, (void *) bt_bas_attach, gatt);
 
 	for (l = hog->instances; l; l = l->next) {
 		struct bt_hog *instance = l->data;
@@ -1457,6 +1428,8 @@ void bt_hog_detach(struct bt_hog *hog)
 	if (!hog->attrib)
 		return;
 
+	queue_foreach(hog->bas, (void *) bt_bas_detach, NULL);
+
 	for (l = hog->instances; l; l = l->next) {
 		struct bt_hog *instance = l->data;
 
@@ -1478,9 +1451,6 @@ void bt_hog_detach(struct bt_hog *hog)
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

