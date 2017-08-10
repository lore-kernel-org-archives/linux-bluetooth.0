Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v8 03/14] advertising: Add ActiveInstances property
Date: Thu, 10 Aug 2017 16:32:40 +0300
Message-Id: <20170810133251.23920-3-luiz.dentz@gmail.com>
In-Reply-To: <20170810133251.23920-1-luiz.dentz@gmail.com>
References: <20170810133251.23920-1-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This property indicates how many instance are currently in use.
---
 doc/advertising-api.txt |  6 +++++-
 src/advertising.c       | 24 ++++++++++++++++++++++++
 2 files changed, 29 insertions(+), 1 deletion(-)

diff --git a/doc/advertising-api.txt b/doc/advertising-api.txt
index 4daa30b75..a8a738c0f 100644
--- a/doc/advertising-api.txt
+++ b/doc/advertising-api.txt
@@ -113,6 +113,10 @@ Methods		RegisterAdvertisement(object advertisement, dict options)
 			Possible errors: org.bluez.Error.InvalidArguments
 					 org.bluez.Error.DoesNotExist
 
-Properties	byte SupportedInstances
+Properties	byte ActiveInstances
+
+			Number of active advertising instances.
+
+		byte SupportedInstances
 
 			Number of available advertising instances.
diff --git a/src/advertising.c b/src/advertising.c
index f92d5d33f..0d3487cd3 100644
--- a/src/advertising.c
+++ b/src/advertising.c
@@ -180,6 +180,10 @@ static void client_remove(void *data)
 	g_dbus_emit_property_changed(btd_get_dbus_connection(),
 				adapter_get_path(client->manager->adapter),
 				LE_ADVERTISING_MGR_IFACE, "SupportedInstances");
+
+	g_dbus_emit_property_changed(btd_get_dbus_connection(),
+				adapter_get_path(client->manager->adapter),
+				LE_ADVERTISING_MGR_IFACE, "ActiveInstances");
 }
 
 static void client_disconnect_cb(DBusConnection *conn, void *user_data)
@@ -470,6 +474,10 @@ static void add_adv_callback(uint8_t status, uint16_t length,
 				adapter_get_path(client->manager->adapter),
 				LE_ADVERTISING_MGR_IFACE, "SupportedInstances");
 
+	g_dbus_emit_property_changed(btd_get_dbus_connection(),
+				adapter_get_path(client->manager->adapter),
+				LE_ADVERTISING_MGR_IFACE, "ActiveInstances");
+
 done:
 	add_client_complete(client, status);
 }
@@ -752,9 +760,25 @@ static gboolean get_instances(const GDBusPropertyTable *property,
 	return TRUE;
 }
 
+static gboolean get_active_instances(const GDBusPropertyTable *property,
+					DBusMessageIter *iter, void *data)
+{
+	struct btd_adv_manager *manager = data;
+	uint8_t instances;
+
+	instances = queue_length(manager->clients);
+
+	dbus_message_iter_append_basic(iter, DBUS_TYPE_BYTE, &instances);
+
+	return TRUE;
+}
+
 static const GDBusPropertyTable properties[] = {
+	{ "ActiveInstances", "y", get_active_instances, NULL, NULL,
+					G_DBUS_PROPERTY_FLAG_EXPERIMENTAL },
 	{ "SupportedInstances", "y", get_instances, NULL, NULL,
 					G_DBUS_PROPERTY_FLAG_EXPERIMENTAL },
+	{ }
 };
 
 static const GDBusMethodTable methods[] = {
-- 
2.13.4

