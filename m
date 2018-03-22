Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Szymon Janc <szymon.janc@codecoup.pl>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@codecoup.pl>
Subject: [PATCH v3] gatt: Mark Includes property of org.bluez.GattService1 as optional
Date: Thu, 22 Mar 2018 11:10:47 +0100
Message-Id: <20180322101047.28910-1-szymon.janc@codecoup.pl>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

If property is not present treat it as no Include Services present.
---
 doc/gatt-api.txt    | 2 +-
 src/gatt-database.c | 7 +++++--
 2 files changed, 6 insertions(+), 3 deletions(-)


V3:
if property is present require it to be in proper format

diff --git a/doc/gatt-api.txt b/doc/gatt-api.txt
index f58de23c3..60a997cbf 100644
--- a/doc/gatt-api.txt
+++ b/doc/gatt-api.txt
@@ -45,7 +45,7 @@ Properties	string UUID [read-only]
 			belongs to. Only present on services from remote
 			devices.
 
-		array{object} Includes [read-only]
+		array{object} Includes [read-only, optional]
 
 			Array of object paths representing the included
 			services of this service.
diff --git a/src/gatt-database.c b/src/gatt-database.c
index c1ae91211..19f03c544 100644
--- a/src/gatt-database.c
+++ b/src/gatt-database.c
@@ -1676,8 +1676,9 @@ static bool parse_includes(GDBusProxy *proxy, struct external_service *service)
 	DBusMessageIter array;
 	char *obj;
 
+	/* Includes property is optional */
 	if (!g_dbus_proxy_get_property(proxy, "Includes", &iter))
-		return false;
+		return true;
 
 	if (dbus_message_iter_get_arg_type(&iter) != DBUS_TYPE_ARRAY)
 		return false;
@@ -2682,8 +2683,10 @@ static bool database_add_service(struct external_service *service)
 		return false;
 	}
 
-	if (!parse_includes(service->proxy, service))
+	if (!parse_includes(service->proxy, service)) {
 		error("Failed to read \"Includes\" property of service");
+		return false;
+	}
 
 	service->attrib = gatt_db_add_service(service->app->database->db, &uuid,
 						primary, service->attr_cnt);
-- 
2.14.3

