Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 04/12] android/hog: Add support for reading device details via DIS
Date: Tue, 24 Jun 2014 11:36:11 +0300
Message-Id: <1403598979-31032-4-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1403598979-31032-1-git-send-email-luiz.dentz@gmail.com>
References: <1403598979-31032-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

If primary is not provided meaning primary should be auto discovered it
probably means other primary services such as Device Information
Service are not being handled either so just handle DIS as well in such
case.
---
 android/hog.c | 58 ++++++++++++++++++++++++++++++++++++++++++++++------------
 1 file changed, 46 insertions(+), 12 deletions(-)

diff --git a/android/hog.c b/android/hog.c
index d42400d..5d37eca 100644
--- a/android/hog.c
+++ b/android/hog.c
@@ -52,6 +52,7 @@
 
 #include "btio/btio.h"
 
+#include "android/dis.h"
 #include "android/hog.h"
 
 #define HOG_UUID		"00001812-0000-1000-8000-00805f9b34fb"
@@ -89,6 +90,7 @@ struct bt_hog {
 	uint16_t		proto_mode_handle;
 	uint16_t		ctrlpt_handle;
 	uint8_t			flags;
+	struct bt_dis		*dis;
 };
 
 struct report {
@@ -647,6 +649,7 @@ static void report_free(void *data)
 
 static void hog_free(struct bt_hog *hog)
 {
+	bt_dis_unref(hog->dis);
 	bt_uhid_unref(hog->uhid);
 	g_slist_free_full(hog->reports, report_free);
 	g_attrib_unref(hog->attrib);
@@ -750,6 +753,30 @@ static void find_included_cb(uint8_t status, GSList *services, void *user_data)
 						char_discovered_cb, hog);
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
@@ -772,26 +799,30 @@ static void primary_cb(uint8_t status, GSList *services, void *user_data)
 	for (l = services; l; l = l->next) {
 		primary = l->data;
 
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
@@ -841,6 +872,9 @@ void bt_hog_detach(struct bt_hog *hog)
 		g_attrib_unregister(hog->attrib, r->notifyid);
 	}
 
+	if (hog->dis)
+		bt_dis_detach(hog->dis);
+
 	g_attrib_unref(hog->attrib);
 	hog->attrib = NULL;
 }
-- 
1.9.3

