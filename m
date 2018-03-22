Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Szymon Janc <szymon.janc@codecoup.pl>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@codecoup.pl>
Subject: [PATCH v2] gatt: Mark Includes property of org.bluez.GattService1 as optional
Date: Thu, 22 Mar 2018 11:06:13 +0100
Message-Id: <20180322100613.28536-1-szymon.janc@codecoup.pl>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

If property is not present treat it as no Include Services present.
---
 doc/gatt-api.txt    | 2 +-
 src/gatt-database.c | 3 ++-
 2 files changed, 3 insertions(+), 2 deletions(-)

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
index c1ae91211..2e1c20d78 100644
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
-- 
2.14.3

