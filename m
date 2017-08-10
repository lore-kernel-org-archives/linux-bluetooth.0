Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v8 02/14] advertising: Rename AdvertisementInstaces to SupportedInstances
Date: Thu, 10 Aug 2017 16:32:39 +0300
Message-Id: <20170810133251.23920-2-luiz.dentz@gmail.com>
In-Reply-To: <20170810133251.23920-1-luiz.dentz@gmail.com>
References: <20170810133251.23920-1-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This fixes the typo and removes the term advertisement since it is
implicit given the interface name, also make it experimental since
AdvertisingManager is still experimental.
---
 doc/advertising-api.txt | 4 ++--
 src/advertising.c       | 9 ++++-----
 2 files changed, 6 insertions(+), 7 deletions(-)

diff --git a/doc/advertising-api.txt b/doc/advertising-api.txt
index 7a29b7095..4daa30b75 100644
--- a/doc/advertising-api.txt
+++ b/doc/advertising-api.txt
@@ -113,6 +113,6 @@ Methods		RegisterAdvertisement(object advertisement, dict options)
 			Possible errors: org.bluez.Error.InvalidArguments
 					 org.bluez.Error.DoesNotExist
 
-Properties	byte AdvertisementInstaces
+Properties	byte SupportedInstances
 
-			Number of available advertisement instances.
+			Number of available advertising instances.
diff --git a/src/advertising.c b/src/advertising.c
index 64d5a27bb..f92d5d33f 100644
--- a/src/advertising.c
+++ b/src/advertising.c
@@ -179,8 +179,7 @@ static void client_remove(void *data)
 
 	g_dbus_emit_property_changed(btd_get_dbus_connection(),
 				adapter_get_path(client->manager->adapter),
-				LE_ADVERTISING_MGR_IFACE,
-				"AdvertisementInstances");
+				LE_ADVERTISING_MGR_IFACE, "SupportedInstances");
 }
 
 static void client_disconnect_cb(DBusConnection *conn, void *user_data)
@@ -469,8 +468,7 @@ static void add_adv_callback(uint8_t status, uint16_t length,
 
 	g_dbus_emit_property_changed(btd_get_dbus_connection(),
 				adapter_get_path(client->manager->adapter),
-				LE_ADVERTISING_MGR_IFACE,
-				"AdvertisementInstances");
+				LE_ADVERTISING_MGR_IFACE, "SupportedInstances");
 
 done:
 	add_client_complete(client, status);
@@ -755,7 +753,8 @@ static gboolean get_instances(const GDBusPropertyTable *property,
 }
 
 static const GDBusPropertyTable properties[] = {
-	{ "AdvertisementInstances", "y", get_instances },
+	{ "SupportedInstances", "y", get_instances, NULL, NULL,
+					G_DBUS_PROPERTY_FLAG_EXPERIMENTAL },
 };
 
 static const GDBusMethodTable methods[] = {
-- 
2.13.4

