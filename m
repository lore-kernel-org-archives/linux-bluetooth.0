Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 05/12] android/hog: Add support to auto discover primary if not set
Date: Tue, 10 Jun 2014 18:53:56 +0300
Message-Id: <1402415643-32300-5-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1402415643-32300-1-git-send-email-luiz.dentz@gmail.com>
References: <1402415643-32300-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds support to auto discover primary service stopping once HoG
UUID is found.
---
 android/hog.c | 100 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 99 insertions(+), 1 deletion(-)

diff --git a/android/hog.c b/android/hog.c
index bfb9c17..e929d7d 100644
--- a/android/hog.c
+++ b/android/hog.c
@@ -674,7 +674,9 @@ struct bt_hog *bt_hog_new(const char *name, uint16_t vendor, uint16_t product,
 	hog->vendor = vendor;
 	hog->product = product;
 	hog->version = version;
-	hog->primary = g_memdup(primary, sizeof(*primary));
+
+	if (primary)
+		hog->primary = g_memdup(primary, sizeof(*hog->primary));
 
 	return bt_hog_ref(hog);
 }
@@ -700,6 +702,97 @@ void bt_hog_unref(struct bt_hog *hog)
 	hog_free(hog);
 }
 
+static void find_included_cb(uint8_t status, GSList *services, void *user_data)
+{
+	struct bt_hog *hog = user_data;
+	struct gatt_included *include;
+	GSList *l;
+
+	DBG("");
+
+	if (hog->primary)
+		return;
+
+	if (status) {
+		const char *str = att_ecode2str(status);
+		DBG("Find included failed: %s", str);
+		return;
+	}
+
+	if (!services) {
+		DBG("No included service found");
+		return;
+	}
+
+	for (l = services; l; l = l->next) {
+		include = l->data;
+
+		if (strcmp(include->uuid, HOG_UUID) == 0)
+			break;
+
+		gatt_find_included(hog->attrib, include->range.start,
+				include->range.end, find_included_cb, hog);
+	}
+
+	if (!l)
+		return;
+
+	hog->primary = g_new0(struct gatt_primary, 1);
+	memcpy(hog->primary->uuid, include->uuid, sizeof(include->uuid));
+	memcpy(&hog->primary->range, &include->range, sizeof(include->range));
+
+	gatt_discover_char(hog->attrib, hog->primary->range.start,
+						hog->primary->range.end, NULL,
+						char_discovered_cb, hog);
+}
+
+static void primary_cb(uint8_t status, GSList *services, void *user_data)
+{
+	struct bt_hog *hog = user_data;
+	struct gatt_primary *primary;
+	GSList *l;
+
+	DBG("");
+
+	if (status) {
+		const char *str = att_ecode2str(status);
+		DBG("Discover primary failed: %s", str);
+		return;
+	}
+
+	if (!services) {
+		DBG("No primary service found");
+		return;
+	}
+
+	for (l = services; l; l = l->next) {
+		primary = l->data;
+
+		if (strcmp(primary->uuid, HOG_UUID) == 0)
+			break;
+
+		gatt_find_included(hog->attrib, primary->range.start,
+				primary->range.end, find_included_cb, hog);
+	}
+
+	if (!l) {
+		for (l = services; l; l = l->next) {
+			primary = l->data;
+
+			gatt_find_included(hog->attrib, primary->range.start,
+					primary->range.end, find_included_cb,
+					hog);
+		}
+		return;
+	}
+
+	hog->primary = g_memdup(primary, sizeof(*primary));
+
+	gatt_discover_char(hog->attrib, hog->primary->range.start,
+						hog->primary->range.end, NULL,
+						char_discovered_cb, hog);
+}
+
 bool bt_hog_attach(struct bt_hog *hog, void *gatt)
 {
 	struct gatt_primary *primary = hog->primary;
@@ -710,6 +803,11 @@ bool bt_hog_attach(struct bt_hog *hog, void *gatt)
 
 	hog->attrib = g_attrib_ref(gatt);
 
+	if (!primary) {
+		gatt_discover_primary(hog->attrib, NULL, primary_cb, hog);
+		return true;
+	}
+
 	if (hog->reports == NULL) {
 		gatt_discover_char(hog->attrib, primary->range.start,
 						primary->range.end, NULL,
-- 
1.9.3

