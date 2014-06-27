Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v4 05/12] android/hog: Add support for reading device details via DIS
Date: Fri, 27 Jun 2014 21:08:53 +0300
Message-Id: <1403892540-21222-5-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1403892540-21222-1-git-send-email-luiz.dentz@gmail.com>
References: <1403892540-21222-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

If primary is not provided meaning primary should be auto discovered it
probably means other primary services such as Device Information
Service are not being handled either so just handle DIS as well in such
case.
---
 android/hog.c | 63 +++++++++++++++++++++++++++++++++++++++++++++++------------
 1 file changed, 50 insertions(+), 13 deletions(-)

diff --git a/android/hog.c b/android/hog.c
index 55a3ee4..aae1f83 100644
--- a/android/hog.c
+++ b/android/hog.c
@@ -53,6 +53,7 @@
 #include "btio/btio.h"
 
 #include "android/scpp.h"
+#include "android/dis.h"
 #include "android/hog.h"
 
 #define HOG_UUID		"00001812-0000-1000-8000-00805f9b34fb"
@@ -91,6 +92,7 @@ struct bt_hog {
 	uint16_t		ctrlpt_handle;
 	uint8_t			flags;
 	struct bt_scpp		*scpp;
+	struct bt_dis		*dis;
 };
 
 struct report {
@@ -647,6 +649,7 @@ static void report_free(void *data)
 static void hog_free(struct bt_hog *hog)
 {
 	bt_scpp_unref(hog->scpp);
+	bt_dis_unref(hog->dis);
 	bt_uhid_unref(hog->uhid);
 	g_slist_free_full(hog->reports, report_free);
 	g_attrib_unref(hog->attrib);
@@ -762,6 +765,30 @@ static void hog_attach_scpp(struct bt_hog *hog, struct gatt_primary *primary)
 		bt_scpp_attach(hog->scpp, hog->attrib);
 }
 
+static void dis_notify(uint8_t source, uint16_t vendor, uint16_t product,
+					uint16_t version, void *user_data)
+{
+	struct bt_hog *hog = user_data;
+
+	hog->vendor = vendor;
+	hog->product = product;
+	hog->version = version;
+}
+
+static void hog_attach_dis(struct bt_hog *hog, struct gatt_primary *primary)
+{
+	if (hog->dis) {
+		bt_dis_attach(hog->dis, hog->attrib);
+		return;
+	}
+
+	hog->dis = bt_dis_new(primary);
+	if (hog->dis) {
+		bt_dis_set_notification(hog->dis, dis_notify, hog);
+		bt_dis_attach(hog->dis, hog->attrib);
+	}
+}
+
 static void primary_cb(uint8_t status, GSList *services, void *user_data)
 {
 	struct bt_hog *hog = user_data;
@@ -789,26 +816,30 @@ static void primary_cb(uint8_t status, GSList *services, void *user_data)
 			continue;
 		}
 
+		if (strcmp(primary->uuid, DEVICE_INFORMATION_UUID) == 0) {
+			hog_attach_dis(hog, primary);
+			continue;
+		}
+
 		if (strcmp(primary->uuid, HOG_UUID) == 0)
-			break;
+			hog->primary = g_memdup(primary, sizeof(*primary));
 	}
 
-	if (!l) {
-		for (l = services; l; l = l->next) {
-			primary = l->data;
+	if (hog->primary) {
+		gatt_discover_char(hog->attrib, hog->primary->range.start,
+						hog->primary->range.end, NULL,
+						char_discovered_cb, hog);
 
-			gatt_find_included(hog->attrib, primary->range.start,
-					primary->range.end, find_included_cb,
-					hog);
-		}
 		return;
 	}
 
-	hog->primary = g_memdup(primary, sizeof(*primary));
+	for (l = services; l; l = l->next) {
+		primary = l->data;
 
-	gatt_discover_char(hog->attrib, hog->primary->range.start,
-						hog->primary->range.end, NULL,
-						char_discovered_cb, hog);
+		gatt_find_included(hog->attrib, primary->range.start,
+				primary->range.end, find_included_cb,
+				hog);
+	}
 }
 
 bool bt_hog_attach(struct bt_hog *hog, void *gatt)
@@ -829,6 +860,9 @@ bool bt_hog_attach(struct bt_hog *hog, void *gatt)
 	if (hog->scpp)
 		bt_scpp_attach(hog->scpp, gatt);
 
+	if (hog->dis)
+		bt_dis_attach(hog->dis, gatt);
+
 	if (hog->reports == NULL) {
 		gatt_discover_char(hog->attrib, primary->range.start,
 						primary->range.end, NULL,
@@ -861,9 +895,12 @@ void bt_hog_detach(struct bt_hog *hog)
 		g_attrib_unregister(hog->attrib, r->notifyid);
 	}
 
-
 	if (hog->scpp)
 		bt_scpp_detach(hog->scpp);
+
+	if (hog->dis)
+		bt_dis_detach(hog->dis);
+
 	g_attrib_unref(hog->attrib);
 	hog->attrib = NULL;
 }
-- 
1.9.3

