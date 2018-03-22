Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Szymon Janc <szymon.janc@codecoup.pl>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@codecoup.pl>
Subject: [PATCH] gatt: Fail to register service with invalid Includes property
Date: Thu, 22 Mar 2018 21:07:55 +0100
Message-Id: <20180322200755.21972-1-szymon.janc@codecoup.pl>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This is optional property but if it is present it must be of
proper type.
---
 src/gatt-database.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/src/gatt-database.c b/src/gatt-database.c
index a22fc3b85..19f03c544 100644
--- a/src/gatt-database.c
+++ b/src/gatt-database.c
@@ -1676,6 +1676,7 @@ static bool parse_includes(GDBusProxy *proxy, struct external_service *service)
 	DBusMessageIter array;
 	char *obj;
 
+	/* Includes property is optional */
 	if (!g_dbus_proxy_get_property(proxy, "Includes", &iter))
 		return true;
 
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

