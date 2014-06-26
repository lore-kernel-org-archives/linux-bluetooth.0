Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2 14/15] android/hog: Add support for Battery Service
Date: Thu, 26 Jun 2014 17:46:47 +0300
Message-Id: <1403794008-18585-14-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1403794008-18585-1-git-send-email-luiz.dentz@gmail.com>
References: <1403794008-18585-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

If primary is not provided meaning primary should be auto discovered it
probably means other primary services such as Battery Service are not
being handled either so just handle BaS as well in such case.
---
 android/hog.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/android/hog.c b/android/hog.c
index d891930..5fa8b94 100644
--- a/android/hog.c
+++ b/android/hog.c
@@ -54,6 +54,7 @@
 
 #include "android/dis.h"
 #include "android/scpp.h"
+#include "android/bas.h"
 #include "android/hog.h"
 
 #define HOG_UUID		"00001812-0000-1000-8000-00805f9b34fb"
@@ -93,6 +94,7 @@ struct bt_hog {
 	uint8_t			flags;
 	struct bt_dis		*dis;
 	struct bt_scpp		*scpp;
+	struct bt_bas		*bas;
 };
 
 struct report {
@@ -650,6 +652,7 @@ static void hog_free(struct bt_hog *hog)
 {
 	bt_dis_unref(hog->dis);
 	bt_scpp_unref(hog->scpp);
+	bt_bas_unref(hog->bas);
 	bt_uhid_unref(hog->uhid);
 	g_slist_free_full(hog->reports, report_free);
 	g_attrib_unref(hog->attrib);
@@ -789,6 +792,18 @@ static void hog_attach_scpp(struct bt_hog *hog, struct gatt_primary *primary)
 		bt_scpp_attach(hog->scpp, hog->attrib);
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
 static void primary_cb(uint8_t status, GSList *services, void *user_data)
 {
 	struct bt_hog *hog = user_data;
@@ -821,6 +836,11 @@ static void primary_cb(uint8_t status, GSList *services, void *user_data)
 			continue;
 		}
 
+		if (strcmp(primary->uuid, BATTERY_UUID) == 0) {
+			hog_attach_bas(hog, primary);
+			continue;
+		}
+
 		if (strcmp(primary->uuid, HOG_UUID) == 0)
 			hog->primary = g_memdup(primary, sizeof(*primary));
 	}
@@ -863,6 +883,9 @@ bool bt_hog_attach(struct bt_hog *hog, void *gatt)
 	if (hog->scpp)
 		bt_scpp_attach(hog->scpp, gatt);
 
+	if (hog->bas)
+		bt_bas_attach(hog->bas, gatt);
+
 	if (hog->reports == NULL) {
 		gatt_discover_char(hog->attrib, primary->range.start,
 						primary->range.end, NULL,
@@ -901,6 +924,9 @@ void bt_hog_detach(struct bt_hog *hog)
 	if (hog->scpp)
 		bt_scpp_detach(hog->scpp);
 
+	if (hog->bas)
+		bt_bas_detach(hog->bas);
+
 	g_attrib_unref(hog->attrib);
 	hog->attrib = NULL;
 }
-- 
1.9.3

