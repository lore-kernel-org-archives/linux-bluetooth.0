Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Szymon Janc <szymon.janc@codecoup.pl>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@codecoup.pl>
Subject: [PATCH] core/gatt: Fix not marking GATT D-Bus properties as stable
Date: Thu,  4 Aug 2016 15:31:38 +0200
Message-Id: <1470317498-4092-1-git-send-email-szymon.janc@codecoup.pl>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Those are no longer experimental. This fix not being able to use
GATT client over D-Bus without -E option.
---
 src/gatt-client.c | 18 ++++++------------
 1 file changed, 6 insertions(+), 12 deletions(-)

diff --git a/src/gatt-client.c b/src/gatt-client.c
index f50db0b..029a9d1 100644
--- a/src/gatt-client.c
+++ b/src/gatt-client.c
@@ -613,12 +613,9 @@ static DBusMessage *descriptor_write_value(DBusConnection *conn,
 }
 
 static const GDBusPropertyTable descriptor_properties[] = {
-	{ "UUID", "s", descriptor_get_uuid, NULL, NULL,
-					G_DBUS_PROPERTY_FLAG_EXPERIMENTAL },
-	{ "Characteristic", "o", descriptor_get_characteristic, NULL, NULL,
-					G_DBUS_PROPERTY_FLAG_EXPERIMENTAL },
-	{ "Value", "ay", descriptor_get_value, NULL, descriptor_value_exists,
-					G_DBUS_PROPERTY_FLAG_EXPERIMENTAL },
+	{ "UUID", "s", descriptor_get_uuid },
+	{ "Characteristic", "o", descriptor_get_characteristic, },
+	{ "Value", "ay", descriptor_get_value, NULL, descriptor_value_exists },
 	{ }
 };
 
@@ -1402,12 +1399,9 @@ static gboolean service_get_primary(const GDBusPropertyTable *property,
 }
 
 static const GDBusPropertyTable service_properties[] = {
-	{ "UUID", "s", service_get_uuid, NULL, NULL,
-					G_DBUS_PROPERTY_FLAG_EXPERIMENTAL },
-	{ "Device", "o", service_get_device, NULL, NULL,
-					G_DBUS_PROPERTY_FLAG_EXPERIMENTAL },
-	{ "Primary", "b", service_get_primary, NULL, NULL,
-					G_DBUS_PROPERTY_FLAG_EXPERIMENTAL },
+	{ "UUID", "s", service_get_uuid },
+	{ "Device", "o", service_get_device },
+	{ "Primary", "b", service_get_primary },
 	{ }
 };
 
-- 
2.7.4

