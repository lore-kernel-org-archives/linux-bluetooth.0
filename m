Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 13/13] audio: Add support for passing endpoints as custom property
Date: Tue, 13 Nov 2012 15:21:20 +0200
Message-Id: <1352812880-7306-17-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1352812880-7306-1-git-send-email-luiz.dentz@gmail.com>
References: <1352812880-7306-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds the possibility to pass the registered endpoints to external
components implementing the same profile.
---
 profiles/audio/media.c | 140 ++++++++++++++++++++++++++++++++++++++++---------
 1 file changed, 114 insertions(+), 26 deletions(-)

diff --git a/profiles/audio/media.c b/profiles/audio/media.c
index 65037fe..6d45373 100644
--- a/profiles/audio/media.c
+++ b/profiles/audio/media.c
@@ -35,7 +35,9 @@
 #include <gdbus.h>
 
 #include "../src/adapter.h"
+#include "../src/device.h"
 #include "../src/dbus-common.h"
+#include "../src/profile.h"
 
 #include "glib-helper.h"
 #include "log.h"
@@ -574,6 +576,111 @@ static gboolean endpoint_init_a2dp_sink(struct media_endpoint *endpoint,
 	return TRUE;
 }
 
+static struct media_endpoint *media_adapter_find_endpoint(
+						struct media_adapter *adapter,
+						const char *sender,
+						const char *path,
+						const char *uuid)
+{
+	GSList *l;
+
+	for (l = adapter->endpoints; l; l = l->next) {
+		struct media_endpoint *endpoint = l->data;
+
+		if (sender && g_strcmp0(endpoint->sender, sender) != 0)
+			continue;
+
+		if (path && g_strcmp0(endpoint->path, path) != 0)
+			continue;
+
+		if (uuid && g_strcmp0(endpoint->uuid, uuid) != 0)
+			continue;
+
+		return endpoint;
+	}
+
+	return NULL;
+}
+
+static bool endpoint_properties_exists(const char *uuid,
+						struct btd_device *dev,
+						void *user_data)
+{
+	struct media_adapter *adapter = user_data;
+	struct btd_adapter *btd_adapter = device_get_adapter(dev);
+	const bdaddr_t *src = adapter_get_address(btd_adapter);
+
+	if (bacmp(&adapter->src, src) != 0)
+		return false;
+
+	if (media_adapter_find_endpoint(adapter, NULL, NULL, uuid) == NULL)
+		return false;
+
+	return true;
+}
+
+static void append_endpoint(struct media_endpoint *endpoint,
+						DBusMessageIter *dict)
+{
+	DBusMessageIter entry, var, props;
+
+	dbus_message_iter_open_container(dict, DBUS_TYPE_DICT_ENTRY,
+							NULL, &entry);
+
+	dbus_message_iter_append_basic(&entry, DBUS_TYPE_STRING,
+						&endpoint->sender);
+
+	dbus_message_iter_open_container(&entry, DBUS_TYPE_VARIANT, "a{sv}",
+								&var);
+
+	dbus_message_iter_open_container(&var, DBUS_TYPE_ARRAY,
+					DBUS_DICT_ENTRY_BEGIN_CHAR_AS_STRING
+					DBUS_TYPE_STRING_AS_STRING
+					DBUS_TYPE_VARIANT_AS_STRING
+					DBUS_DICT_ENTRY_END_CHAR_AS_STRING,
+					&props);
+
+	dict_append_entry(&props, "Path", DBUS_TYPE_OBJECT_PATH,
+							&endpoint->path);
+	dict_append_entry(&props, "Codec", DBUS_TYPE_BYTE, &endpoint->codec);
+	dict_append_array(&props, "Capabilities", DBUS_TYPE_BYTE,
+				&endpoint->capabilities, endpoint->size);
+
+	dbus_message_iter_close_container(&var, &props);
+	dbus_message_iter_close_container(&entry, &var);
+	dbus_message_iter_close_container(dict, &entry);
+}
+
+static bool endpoint_properties_get(const char *uuid,
+						struct btd_device *dev,
+						DBusMessageIter *iter,
+						void *user_data)
+{
+	struct media_adapter *adapter = user_data;
+	DBusMessageIter dict;
+	GSList *l;
+
+	dbus_message_iter_open_container(iter, DBUS_TYPE_ARRAY,
+					DBUS_DICT_ENTRY_BEGIN_CHAR_AS_STRING
+					DBUS_TYPE_STRING_AS_STRING
+					DBUS_TYPE_VARIANT_AS_STRING
+					DBUS_DICT_ENTRY_END_CHAR_AS_STRING,
+					&dict);
+
+	for (l = adapter->endpoints; l; l = l->next) {
+		struct media_endpoint *endpoint = l->data;
+
+		if (g_strcmp0(endpoint->uuid, uuid) != 0)
+			continue;
+
+		append_endpoint(endpoint, &dict);
+	}
+
+	dbus_message_iter_close_container(iter, &dict);
+
+	return true;
+}
+
 static struct media_endpoint *media_endpoint_create(struct media_adapter *adapter,
 						const char *sender,
 						const char *path,
@@ -629,6 +736,13 @@ static struct media_endpoint *media_endpoint_create(struct media_adapter *adapte
 						sender, media_endpoint_exit,
 						endpoint, NULL);
 
+	if (media_adapter_find_endpoint(adapter, NULL, NULL, uuid) == NULL) {
+		btd_profile_add_custom_prop(uuid, "a{sv}", "Endpoints",
+						endpoint_properties_exists,
+						endpoint_properties_get,
+						adapter);
+	}
+
 	adapter->endpoints = g_slist_append(adapter->endpoints, endpoint);
 	info("Endpoint registered: sender=%s path=%s", sender, path);
 
@@ -637,32 +751,6 @@ static struct media_endpoint *media_endpoint_create(struct media_adapter *adapte
 	return endpoint;
 }
 
-static struct media_endpoint *media_adapter_find_endpoint(
-						struct media_adapter *adapter,
-						const char *sender,
-						const char *path,
-						const char *uuid)
-{
-	GSList *l;
-
-	for (l = adapter->endpoints; l; l = l->next) {
-		struct media_endpoint *endpoint = l->data;
-
-		if (sender && g_strcmp0(endpoint->sender, sender) != 0)
-			continue;
-
-		if (path && g_strcmp0(endpoint->path, path) != 0)
-			continue;
-
-		if (uuid && g_strcmp0(endpoint->uuid, uuid) != 0)
-			continue;
-
-		return endpoint;
-	}
-
-	return NULL;
-}
-
 static int parse_properties(DBusMessageIter *props, const char **uuid,
 				gboolean *delay_reporting, uint8_t *codec,
 				uint8_t **capabilities, int *size)
-- 
1.7.11.7

