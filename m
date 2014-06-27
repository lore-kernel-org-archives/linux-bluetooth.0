Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v4 09/12] android/hog: Add support for multiple instaces
Date: Fri, 27 Jun 2014 21:08:57 +0300
Message-Id: <1403892540-21222-9-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1403892540-21222-1-git-send-email-luiz.dentz@gmail.com>
References: <1403892540-21222-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This is necessary to pass PTS tests which does include 2 instances.
---
 android/hog.c | 49 +++++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 41 insertions(+), 8 deletions(-)

diff --git a/android/hog.c b/android/hog.c
index f93f246..42b7d73 100644
--- a/android/hog.c
+++ b/android/hog.c
@@ -95,6 +95,7 @@ struct bt_hog {
 	struct bt_scpp		*scpp;
 	struct bt_dis		*dis;
 	struct bt_bas		*bas;
+	GSList			*instances;
 };
 
 struct report {
@@ -648,8 +649,12 @@ static void report_free(void *data)
 	g_free(report);
 }
 
-static void hog_free(struct bt_hog *hog)
+static void hog_free(void *data)
 {
+	struct bt_hog *hog = data;
+
+	g_slist_free_full(hog->instances, hog_free);
+
 	bt_scpp_unref(hog->scpp);
 	bt_dis_unref(hog->dis);
 	bt_bas_unref(hog->bas);
@@ -804,6 +809,27 @@ static void hog_attach_bas(struct bt_hog *hog, struct gatt_primary *primary)
 		bt_bas_attach(hog->bas, hog->attrib);
 }
 
+static void hog_attach_hog(struct bt_hog *hog, struct gatt_primary *primary)
+{
+	struct bt_hog *instance;
+
+	if (!hog->primary) {
+		hog->primary = g_memdup(primary, sizeof(*primary));
+		gatt_discover_char(hog->attrib, primary->range.start,
+						primary->range.end, NULL,
+						char_discovered_cb, hog);
+		return;
+	}
+
+	instance = bt_hog_new(hog->name, hog->vendor, hog->product,
+							hog->version, primary);
+	if (!instance)
+		return;
+
+	bt_hog_attach(instance, hog->attrib);
+	hog->instances = g_slist_append(hog->instances, instance);
+}
+
 static void primary_cb(uint8_t status, GSList *services, void *user_data)
 {
 	struct bt_hog *hog = user_data;
@@ -842,16 +868,11 @@ static void primary_cb(uint8_t status, GSList *services, void *user_data)
 		}
 
 		if (strcmp(primary->uuid, HOG_UUID) == 0)
-			hog->primary = g_memdup(primary, sizeof(*primary));
+			hog_attach_hog(hog, primary);
 	}
 
-	if (hog->primary) {
-		gatt_discover_char(hog->attrib, hog->primary->range.start,
-						hog->primary->range.end, NULL,
-						char_discovered_cb, hog);
-
+	if (hog->primary)
 		return;
-	}
 
 	for (l = services; l; l = l->next) {
 		primary = l->data;
@@ -886,6 +907,12 @@ bool bt_hog_attach(struct bt_hog *hog, void *gatt)
 	if (hog->bas)
 		bt_bas_attach(hog->bas, gatt);
 
+	for (l = hog->instances; l; l = l->next) {
+		struct bt_hog *instance = l->data;
+
+		bt_hog_attach(instance, gatt);
+	}
+
 	if (hog->reports == NULL) {
 		gatt_discover_char(hog->attrib, primary->range.start,
 						primary->range.end, NULL,
@@ -912,6 +939,12 @@ void bt_hog_detach(struct bt_hog *hog)
 	if (!hog->attrib)
 		return;
 
+	for (l = hog->instances; l; l = l->next) {
+		struct bt_hog *instance = l->data;
+
+		bt_hog_detach(instance);
+	}
+
 	for (l = hog->reports; l; l = l->next) {
 		struct report *r = l->data;
 
-- 
1.9.3

