Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 5/5] scanparam: Implement disconnect callback
Date: Thu,  8 Sep 2016 15:39:00 +0300
Message-Id: <1473338340-7587-5-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1473338340-7587-1-git-send-email-luiz.dentz@gmail.com>
References: <1473338340-7587-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This implements the profile disconnect callback using it to cleanup
existing references of bt_gatt_client and gatt_db.
---
 profiles/scanparam/scan.c | 31 ++++++++++++++++++++++---------
 1 file changed, 22 insertions(+), 9 deletions(-)

diff --git a/profiles/scanparam/scan.c b/profiles/scanparam/scan.c
index f8ad810..0ff4a43 100644
--- a/profiles/scanparam/scan.c
+++ b/profiles/scanparam/scan.c
@@ -165,6 +165,15 @@ static void foreach_scan_param_service(struct gatt_db_attribute *attr,
 	gatt_db_service_foreach_char(scan->attr, handle_characteristic, scan);
 }
 
+static void scan_reset(struct scan *scan)
+{
+	scan->attr = NULL;
+	gatt_db_unref(scan->db);
+	scan->db = NULL;
+	bt_gatt_client_unref(scan->client);
+	scan->client = NULL;
+}
+
 static int scan_param_accept(struct btd_service *service)
 {
 	struct btd_device *device = btd_service_get_device(service);
@@ -182,11 +191,6 @@ static int scan_param_accept(struct btd_service *service)
 		return -1;
 	}
 
-	/* Clean-up any old client/db and acquire the new ones */
-	scan->attr = NULL;
-	gatt_db_unref(scan->db);
-	bt_gatt_client_unref(scan->client);
-
 	scan->db = gatt_db_ref(db);
 	scan->client = bt_gatt_client_ref(client);
 
@@ -196,10 +200,7 @@ static int scan_param_accept(struct btd_service *service)
 
 	if (!scan->attr) {
 		error("Scan Parameters attribute not found");
-		gatt_db_unref(scan->db);
-		scan->db = NULL;
-		bt_gatt_client_unref(scan->client);
-		scan->client = NULL;
+		scan_reset(scan);
 		return -1;
 	}
 
@@ -208,6 +209,17 @@ static int scan_param_accept(struct btd_service *service)
 	return 0;
 }
 
+static int scan_param_disconnect(struct btd_service *service)
+{
+	struct scan *scan = btd_service_get_user_data(service);
+
+	scan_reset(scan);
+
+	btd_service_disconnecting_complete(service, 0);
+
+	return 0;
+}
+
 static void scan_param_remove(struct btd_service *service)
 {
 	struct btd_device *device = btd_service_get_device(service);
@@ -257,6 +269,7 @@ static struct btd_profile scan_profile = {
 	.device_probe = scan_param_probe,
 	.device_remove = scan_param_remove,
 	.accept = scan_param_accept,
+	.disconnect = scan_param_disconnect,
 };
 
 static int scan_param_init(void)
-- 
2.7.4

