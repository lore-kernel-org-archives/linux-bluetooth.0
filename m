Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ] media: Fix custom property registration for multiple adapters
Date: Mon, 21 Jan 2013 15:34:13 +0200
Message-Id: <1358775253-29202-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

The function btd_profile_add_custom_prop register a custom property for
an UUID which is valid for every adapter so its user_data cannot be tied
to a single adapter.

To fix this now NULL is passed as user_data and the callbacks checks if
the adapter passed has been registered and if there is an endpoint for
the UUID requested.
---
 profiles/audio/media.c | 27 +++++++++++++++++++++++----
 1 file changed, 23 insertions(+), 4 deletions(-)

diff --git a/profiles/audio/media.c b/profiles/audio/media.c
index 15dab8c..0ae9932 100644
--- a/profiles/audio/media.c
+++ b/profiles/audio/media.c
@@ -607,13 +607,28 @@ static gboolean endpoint_init_a2dp_sink(struct media_endpoint *endpoint,
 	return TRUE;
 }
 
+static struct media_adapter *find_adapter(struct btd_device *device)
+{
+	GSList *l;
+
+	for (l = adapters; l; l = l->next) {
+		struct media_adapter *adapter = l->data;
+
+		if (adapter->btd_adapter == device_get_adapter(device))
+			return adapter;
+	}
+
+	return NULL;
+}
+
 static bool endpoint_properties_exists(const char *uuid,
 						struct btd_device *dev,
 						void *user_data)
 {
-	struct media_adapter *adapter = user_data;
+	struct media_adapter *adapter;
 
-	if (adapter->btd_adapter != device_get_adapter(dev))
+	adapter = find_adapter(dev);
+	if (adapter == NULL)
 		return false;
 
 	if (media_adapter_find_endpoint(adapter, NULL, NULL, uuid) == NULL)
@@ -659,10 +674,14 @@ static bool endpoint_properties_get(const char *uuid,
 						DBusMessageIter *iter,
 						void *user_data)
 {
-	struct media_adapter *adapter = user_data;
+	struct media_adapter *adapter;
 	DBusMessageIter dict;
 	GSList *l;
 
+	adapter = find_adapter(dev);
+	if (adapter == NULL)
+		return false;
+
 	dbus_message_iter_open_container(iter, DBUS_TYPE_ARRAY,
 					DBUS_DICT_ENTRY_BEGIN_CHAR_AS_STRING
 					DBUS_TYPE_STRING_AS_STRING
@@ -743,7 +762,7 @@ static struct media_endpoint *media_endpoint_create(struct media_adapter *adapte
 		btd_profile_add_custom_prop(uuid, "a{sv}", "MediaEndpoints",
 						endpoint_properties_exists,
 						endpoint_properties_get,
-						adapter);
+						NULL);
 	}
 
 	adapter->endpoints = g_slist_append(adapter->endpoints, endpoint);
-- 
1.8.0.2

