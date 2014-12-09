Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH 09/25] android/hog: Add support to track gatt operations
Date: Tue,  9 Dec 2014 16:11:31 +0100
Message-Id: <1418137907-16981-10-git-send-email-lukasz.rymanowski@tieto.com>
In-Reply-To: <1418137907-16981-1-git-send-email-lukasz.rymanowski@tieto.com>
References: <1418137907-16981-1-git-send-email-lukasz.rymanowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/hog.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/android/hog.c b/android/hog.c
index 872f4a5..95b7cb0 100644
--- a/android/hog.c
+++ b/android/hog.c
@@ -45,6 +45,7 @@
 #include "lib/uuid.h"
 #include "src/shared/util.h"
 #include "src/shared/uhid.h"
+#include "src/shared/queue.h"
 
 #include "attrib/att.h"
 #include "attrib/gattrib.h"
@@ -96,6 +97,7 @@ struct bt_hog {
 	struct bt_dis		*dis;
 	struct bt_bas		*bas;
 	GSList			*instances;
+	struct queue		*gatt_op;
 };
 
 struct report {
@@ -787,6 +789,7 @@ static void hog_free(void *data)
 	g_slist_free_full(hog->reports, report_free);
 	g_free(hog->name);
 	g_free(hog->primary);
+	queue_destroy(hog->gatt_op, NULL);
 	g_free(hog);
 }
 
@@ -799,9 +802,16 @@ struct bt_hog *bt_hog_new(const char *name, uint16_t vendor, uint16_t product,
 	if (!hog)
 		return NULL;
 
+	hog->gatt_op = queue_new();
+	if (!hog->gatt_op) {
+		hog_free(hog);
+		return NULL;
+	}
+
 	hog->uhid = bt_uhid_new_default();
 	if (!hog->uhid) {
 		hog_free(hog);
+		queue_destroy(hog->gatt_op, NULL);
 		return NULL;
 	}
 
-- 
1.8.4

