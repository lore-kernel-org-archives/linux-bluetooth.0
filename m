Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 1/2] doc/advertising-api: Mark LEAdvertisingManager1 stable
Date: Wed,  1 Nov 2017 16:31:51 +0200
Message-Id: <20171101143152.30642-1-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

All features supported over management are supported.
---
 doc/advertising-api.txt |  2 +-
 src/adapter.c           | 15 ++++++---------
 src/advertising.c       | 13 +++++--------
 3 files changed, 12 insertions(+), 18 deletions(-)

diff --git a/doc/advertising-api.txt b/doc/advertising-api.txt
index 7cc183043..b10010a19 100644
--- a/doc/advertising-api.txt
+++ b/doc/advertising-api.txt
@@ -92,7 +92,7 @@ Data which should be broadcast to devices.  Advertisement Data elements must
 follow the API for LE Advertisement Data described above.
 
 Service		org.bluez
-Interface	org.bluez.LEAdvertisingManager1 [Experimental]
+Interface	org.bluez.LEAdvertisingManager1
 Object path	/org/bluez/{hci0,hci1,...}
 
 Methods		RegisterAdvertisement(object advertisement, dict options)
diff --git a/src/adapter.c b/src/adapter.c
index 32a89d533..1c751b1d4 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -7722,15 +7722,12 @@ static int adapter_register(struct btd_adapter *adapter)
 		return -EINVAL;
 	}
 
-	if (g_dbus_get_flags() & G_DBUS_FLAG_ENABLE_EXPERIMENTAL) {
-		/* Don't start advertising managers on non-LE controllers. */
-		if (adapter->supported_settings & MGMT_SETTING_LE) {
-			adapter->adv_manager = btd_adv_manager_new(adapter);
-		} else {
-			btd_info(adapter->dev_id,
-				"LEAdvertisingManager skipped, LE unavailable");
-		}
-	}
+	/* Don't start advertising managers on non-LE controllers. */
+	if (adapter->supported_settings & MGMT_SETTING_LE)
+		adapter->adv_manager = btd_adv_manager_new(adapter);
+	else
+		btd_info(adapter->dev_id,
+			"LEAdvertisingManager skipped, LE unavailable");
 
 	db = btd_gatt_database_get_db(adapter->database);
 	adapter->db_id = gatt_db_register(db, services_modified,
diff --git a/src/advertising.c b/src/advertising.c
index b03c36fb6..d4d95c1c3 100644
--- a/src/advertising.c
+++ b/src/advertising.c
@@ -936,21 +936,18 @@ static gboolean get_supported_includes(const GDBusPropertyTable *property,
 }
 
 static const GDBusPropertyTable properties[] = {
-	{ "ActiveInstances", "y", get_active_instances, NULL, NULL,
-					G_DBUS_PROPERTY_FLAG_EXPERIMENTAL },
-	{ "SupportedInstances", "y", get_instances, NULL, NULL,
-					G_DBUS_PROPERTY_FLAG_EXPERIMENTAL },
-	{ "SupportedIncludes", "as", get_supported_includes, NULL, NULL,
-					G_DBUS_PROPERTY_FLAG_EXPERIMENTAL },
+	{ "ActiveInstances", "y", get_active_instances, NULL, NULL },
+	{ "SupportedInstances", "y", get_instances, NULL, NULL },
+	{ "SupportedIncludes", "as", get_supported_includes, NULL, NULL },
 	{ }
 };
 
 static const GDBusMethodTable methods[] = {
-	{ GDBUS_EXPERIMENTAL_ASYNC_METHOD("RegisterAdvertisement",
+	{ GDBUS_ASYNC_METHOD("RegisterAdvertisement",
 					GDBUS_ARGS({ "advertisement", "o" },
 							{ "options", "a{sv}" }),
 					NULL, register_advertisement) },
-	{ GDBUS_EXPERIMENTAL_ASYNC_METHOD("UnregisterAdvertisement",
+	{ GDBUS_ASYNC_METHOD("UnregisterAdvertisement",
 						GDBUS_ARGS({ "service", "o" }),
 						NULL,
 						unregister_advertisement) },
-- 
2.13.6

