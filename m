Return-Path: <cyrus@holtmann.org>
From: Arman Uguray <armansito@chromium.org>
To: linux-bluetooth@vger.kernel.org
Cc: luiz.dentz@gmail.com, Arman Uguray <armansito@chromium.org>
Subject: [PATCH BlueZ 13/18] core: gatt: Send not/ind for D-Bus characteristics
Date: Fri, 20 Feb 2015 17:56:58 -0800
Message-Id: <1424483824-27374-14-git-send-email-armansito@chromium.org>
In-Reply-To: <1424483824-27374-1-git-send-email-armansito@chromium.org>
References: <1424483824-27374-1-git-send-email-armansito@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch adds support for sending out notification/indication packets
for external characteristics whenever a PropertiesChanged signal is
received for the "Value" property of an external characteristic that has
either the 'notify' or the 'indicate' property.
---
 src/gatt-manager.c | 55 ++++++++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 53 insertions(+), 2 deletions(-)

diff --git a/src/gatt-manager.c b/src/gatt-manager.c
index 03f754a..5d4b609 100644
--- a/src/gatt-manager.c
+++ b/src/gatt-manager.c
@@ -73,6 +73,7 @@ struct external_service {
 };
 
 struct external_chrc {
+	struct external_service *service;
 	GDBusProxy *proxy;
 	uint8_t props;
 	uint8_t ext_props;
@@ -210,7 +211,8 @@ static void service_remove(void *data)
 	service_remove_helper(service);
 }
 
-static struct external_chrc *chrc_create(GDBusProxy *proxy)
+static struct external_chrc *chrc_create(struct external_service *service,
+							GDBusProxy *proxy)
 {
 	struct external_chrc *chrc;
 
@@ -224,6 +226,7 @@ static struct external_chrc *chrc_create(GDBusProxy *proxy)
 		return NULL;
 	}
 
+	chrc->service = service;
 	chrc->proxy = g_dbus_proxy_ref(proxy);
 
 	return chrc;
@@ -352,7 +355,7 @@ static void proxy_added_cb(GDBusProxy *proxy, void *user_data)
 			return;
 		}
 
-		chrc = chrc_create(proxy);
+		chrc = chrc_create(service, proxy);
 		if (!chrc) {
 			service->failed = true;
 			return;
@@ -728,6 +731,48 @@ static uint8_t ccc_write_cb(uint16_t value, void *user_data)
 	return 0;
 }
 
+static void property_changed_cb(GDBusProxy *proxy, const char *name,
+					DBusMessageIter *iter, void *user_data)
+{
+	struct external_chrc *chrc = user_data;
+	struct btd_gatt_database *database;
+	DBusMessageIter array;
+	uint8_t *value = NULL;
+	int len = 0;
+
+	if (strcmp(name, "Value"))
+		return;
+
+	if (dbus_message_iter_get_arg_type(iter) != DBUS_TYPE_ARRAY) {
+		DBG("Malformed \"Value\" property received");
+		return;
+	}
+
+	dbus_message_iter_recurse(iter, &array);
+	dbus_message_iter_get_fixed_array(&array, &value, &len);
+
+	if (len < 0) {
+		DBG("Malformed \"Value\" property received");
+		return;
+	}
+
+	/* Truncate the value if it's too large */
+	len = MIN(BT_ATT_MAX_VALUE_LEN, len);
+	value = len ? value : NULL;
+
+	database = btd_adapter_get_database(chrc->service->manager->adapter);
+	if (!database) {
+		error("Failed to obtain GATT database from adapter!");
+		return;
+	}
+
+	btd_gatt_database_notify(database,
+				gatt_db_attribute_get_handle(chrc->attrib),
+				value, len,
+				gatt_db_attribute_get_handle(chrc->ccc),
+				chrc->props & BT_GATT_CHRC_PROP_INDICATE);
+}
+
 static bool create_ccc_entry(struct external_service *service,
 						struct external_chrc *chrc)
 {
@@ -752,6 +797,12 @@ static bool create_ccc_entry(struct external_service *service,
 		return false;
 	}
 
+	if (g_dbus_proxy_set_property_watch(chrc->proxy, property_changed_cb,
+							chrc) == FALSE) {
+		error("Failed to set up property watch for characteristic");
+		return false;
+	}
+
 	return true;
 }
 
-- 
2.2.0.rc0.207.ga3a616c

