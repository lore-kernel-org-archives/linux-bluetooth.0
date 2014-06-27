Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v3 11/15] android/hog: Add support for Scan Parameter Service
Date: Fri, 27 Jun 2014 11:27:55 +0300
Message-Id: <1403857679-14341-11-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1403857679-14341-1-git-send-email-luiz.dentz@gmail.com>
References: <1403857679-14341-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

If primary is not provided meaning primary should be auto discovered it
probably means other primary services such as Scan Parameter Profile
are not being handled either so just handle ScPP as well in such case.
---
 android/hog.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/android/hog.c b/android/hog.c
index 007146a..d891930 100644
--- a/android/hog.c
+++ b/android/hog.c
@@ -53,6 +53,7 @@
 #include "btio/btio.h"
 
 #include "android/dis.h"
+#include "android/scpp.h"
 #include "android/hog.h"
 
 #define HOG_UUID		"00001812-0000-1000-8000-00805f9b34fb"
@@ -91,6 +92,7 @@ struct bt_hog {
 	uint16_t		ctrlpt_handle;
 	uint8_t			flags;
 	struct bt_dis		*dis;
+	struct bt_scpp		*scpp;
 };
 
 struct report {
@@ -647,6 +649,7 @@ static void report_free(void *data)
 static void hog_free(struct bt_hog *hog)
 {
 	bt_dis_unref(hog->dis);
+	bt_scpp_unref(hog->scpp);
 	bt_uhid_unref(hog->uhid);
 	g_slist_free_full(hog->reports, report_free);
 	g_attrib_unref(hog->attrib);
@@ -774,6 +777,18 @@ static void hog_attach_dis(struct bt_hog *hog, struct gatt_primary *primary)
 	}
 }
 
+static void hog_attach_scpp(struct bt_hog *hog, struct gatt_primary *primary)
+{
+	if (hog->scpp) {
+		bt_scpp_attach(hog->scpp, hog->attrib);
+		return;
+	}
+
+	hog->scpp = bt_scpp_new(primary);
+	if (hog->scpp)
+		bt_scpp_attach(hog->scpp, hog->attrib);
+}
+
 static void primary_cb(uint8_t status, GSList *services, void *user_data)
 {
 	struct bt_hog *hog = user_data;
@@ -801,6 +816,11 @@ static void primary_cb(uint8_t status, GSList *services, void *user_data)
 			continue;
 		}
 
+		if (strcmp(primary->uuid, SCAN_PARAMETERS_UUID) == 0) {
+			hog_attach_scpp(hog, primary);
+			continue;
+		}
+
 		if (strcmp(primary->uuid, HOG_UUID) == 0)
 			hog->primary = g_memdup(primary, sizeof(*primary));
 	}
@@ -840,6 +860,9 @@ bool bt_hog_attach(struct bt_hog *hog, void *gatt)
 	if (hog->dis)
 		bt_dis_attach(hog->dis, gatt);
 
+	if (hog->scpp)
+		bt_scpp_attach(hog->scpp, gatt);
+
 	if (hog->reports == NULL) {
 		gatt_discover_char(hog->attrib, primary->range.start,
 						primary->range.end, NULL,
@@ -875,6 +898,9 @@ void bt_hog_detach(struct bt_hog *hog)
 	if (hog->dis)
 		bt_dis_detach(hog->dis);
 
+	if (hog->scpp)
+		bt_scpp_detach(hog->scpp);
+
 	g_attrib_unref(hog->attrib);
 	hog->attrib = NULL;
 }
-- 
1.9.3

