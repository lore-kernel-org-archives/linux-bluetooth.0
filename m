Return-Path: <cyrus@holtmann.org>
From: Mikel Astiz <mikel.astiz.oss@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Mikel Astiz <mikel.astiz@bmw-carit.de>
Subject: [RFC BlueZ v0 01/10] media: Expose Media API internally
Date: Fri, 12 Jul 2013 12:54:34 +0200
Message-Id: <1373626483-2031-2-git-send-email-mikel.astiz.oss@gmail.com>
In-Reply-To: <1373626483-2031-1-git-send-email-mikel.astiz.oss@gmail.com>
References: <1373626483-2031-1-git-send-email-mikel.astiz.oss@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Mikel Astiz <mikel.astiz@bmw-carit.de>

The API is exposed in D-Bus but not internally, so make this possible
in case some plugins are interested in using it.
---
 profiles/audio/media.c | 52 +++++++++++++++++++++++++++++++++-----------------
 profiles/audio/media.h | 20 +++++++++++++++++++
 2 files changed, 54 insertions(+), 18 deletions(-)

diff --git a/profiles/audio/media.c b/profiles/audio/media.c
index d4d82cf..c24ac7d 100644
--- a/profiles/audio/media.c
+++ b/profiles/audio/media.c
@@ -217,7 +217,7 @@ static void media_endpoint_exit(DBusConnection *connection, void *user_data)
 	media_endpoint_remove(endpoint);
 }
 
-static void clear_configuration(struct media_endpoint *endpoint,
+void btd_media_endpoint_clear_configuration(struct media_endpoint *endpoint,
 					struct media_transport *transport)
 {
 	DBusMessage *msg;
@@ -245,7 +245,8 @@ static void clear_endpoint(struct media_endpoint *endpoint)
 	media_endpoint_cancel_all(endpoint);
 
 	while (endpoint->transports != NULL)
-		clear_configuration(endpoint, endpoint->transports->data);
+		btd_media_endpoint_clear_configuration(endpoint,
+						endpoint->transports->data);
 }
 
 static void endpoint_reply(DBusPendingCall *call, void *user_data)
@@ -352,7 +353,8 @@ static gboolean media_endpoint_async_call(DBusMessage *msg,
 	return TRUE;
 }
 
-static gboolean select_configuration(struct media_endpoint *endpoint,
+gboolean btd_media_endpoint_select_configuration(
+						struct media_endpoint *endpoint,
 						uint8_t *capabilities,
 						size_t length,
 						media_endpoint_cb_t cb,
@@ -401,7 +403,8 @@ static struct media_transport *find_device_transport(
 	return match->data;
 }
 
-static gboolean set_configuration(struct media_endpoint *endpoint,
+struct media_transport *btd_media_endpoint_set_configuration(
+					struct media_endpoint *endpoint,
 					struct audio_device *device,
 					uint8_t *configuration, size_t size,
 					media_endpoint_cb_t cb,
@@ -417,12 +420,12 @@ static gboolean set_configuration(struct media_endpoint *endpoint,
 	transport = find_device_transport(endpoint, device);
 
 	if (transport != NULL)
-		return FALSE;
+		return NULL;
 
 	transport = media_transport_create(device, configuration, size,
 								endpoint);
 	if (transport == NULL)
-		return FALSE;
+		return NULL;
 
 	msg = dbus_message_new_method_call(endpoint->sender, endpoint->path,
 						MEDIA_ENDPOINT_INTERFACE,
@@ -430,11 +433,9 @@ static gboolean set_configuration(struct media_endpoint *endpoint,
 	if (msg == NULL) {
 		error("Couldn't allocate D-Bus message");
 		media_transport_destroy(transport);
-		return FALSE;
+		return NULL;
 	}
 
-	endpoint->transports = g_slist_append(endpoint->transports, transport);
-
 	dbus_message_iter_init_append(msg, &iter);
 
 	path = media_transport_get_path(transport);
@@ -442,7 +443,14 @@ static gboolean set_configuration(struct media_endpoint *endpoint,
 
 	g_dbus_get_properties(conn, path, "org.bluez.MediaTransport1", &iter);
 
-	return media_endpoint_async_call(msg, endpoint, cb, user_data, destroy);
+	if (!media_endpoint_async_call(msg, endpoint, cb, user_data, destroy)) {
+		media_transport_destroy(transport);
+		return NULL;
+	}
+
+	endpoint->transports = g_slist_append(endpoint->transports, transport);
+
+	return transport;
 }
 
 static void release_endpoint(struct media_endpoint *endpoint)
@@ -516,8 +524,8 @@ static int select_config(struct a2dp_sep *sep, uint8_t *capabilities,
 	data->setup = setup;
 	data->cb = cb;
 
-	if (select_configuration(endpoint, capabilities, length,
-					select_cb, data, g_free) == TRUE)
+	if (btd_media_endpoint_select_configuration(endpoint, capabilities,
+				length, select_cb, data, g_free) == TRUE)
 		return 0;
 
 	g_free(data);
@@ -545,8 +553,8 @@ static int set_config(struct a2dp_sep *sep, struct audio_device *dev,
 	data->setup = setup;
 	data->cb = cb;
 
-	if (set_configuration(endpoint, dev, configuration, length,
-					config_cb, data, g_free) == TRUE)
+	if (btd_media_endpoint_set_configuration(endpoint, dev, configuration,
+				length, config_cb, data, g_free) != NULL)
 		return 0;
 
 	g_free(data);
@@ -615,27 +623,35 @@ static gboolean endpoint_init_a2dp_sink(struct media_endpoint *endpoint,
 	return TRUE;
 }
 
-static struct media_adapter *find_adapter(struct btd_device *device)
+static struct media_adapter *find_adapter(struct btd_adapter *btd_adapter)
 {
 	GSList *l;
 
 	for (l = adapters; l; l = l->next) {
 		struct media_adapter *adapter = l->data;
 
-		if (adapter->btd_adapter == device_get_adapter(device))
+		if (adapter->btd_adapter == btd_adapter)
 			return adapter;
 	}
 
 	return NULL;
 }
 
+struct media_endpoint *btd_media_endpoint_find(struct btd_adapter *btd_adapter,
+							const char *uuid)
+{
+	struct media_adapter *adapter = find_adapter(btd_adapter);
+
+	return media_adapter_find_endpoint(adapter, NULL, NULL, uuid);
+}
+
 static bool endpoint_properties_exists(const char *uuid,
 						struct btd_device *dev,
 						void *user_data)
 {
 	struct media_adapter *adapter;
 
-	adapter = find_adapter(dev);
+	adapter = find_adapter(device_get_adapter(dev));
 	if (adapter == NULL)
 		return false;
 
@@ -686,7 +702,7 @@ static bool endpoint_properties_get(const char *uuid,
 	DBusMessageIter dict;
 	GSList *l;
 
-	adapter = find_adapter(dev);
+	adapter = find_adapter(device_get_adapter(dev));
 	if (adapter == NULL)
 		return false;
 
diff --git a/profiles/audio/media.h b/profiles/audio/media.h
index dd630d4..ab187dd 100644
--- a/profiles/audio/media.h
+++ b/profiles/audio/media.h
@@ -23,6 +23,7 @@
  */
 
 struct media_endpoint;
+struct media_transport;
 
 typedef void (*media_endpoint_cb_t) (struct media_endpoint *endpoint,
 					void *ret, int size, void *user_data);
@@ -33,3 +34,22 @@ void media_unregister(struct btd_adapter *btd_adapter);
 struct a2dp_sep *media_endpoint_get_sep(struct media_endpoint *endpoint);
 const char *media_endpoint_get_uuid(struct media_endpoint *endpoint);
 uint8_t media_endpoint_get_codec(struct media_endpoint *endpoint);
+
+struct media_endpoint *btd_media_endpoint_find(struct btd_adapter *btd_adapter,
+							const char *uuid);
+struct media_transport *btd_media_endpoint_set_configuration(
+					struct media_endpoint *endpoint,
+					struct audio_device *device,
+					uint8_t *configuration, size_t size,
+					media_endpoint_cb_t cb,
+					void *user_data,
+					GDestroyNotify destroy);
+gboolean btd_media_endpoint_select_configuration(
+						struct media_endpoint *endpoint,
+						uint8_t *capabilities,
+						size_t length,
+						media_endpoint_cb_t cb,
+						void *user_data,
+						GDestroyNotify destroy);
+void btd_media_endpoint_clear_configuration(struct media_endpoint *endpoint,
+					struct media_transport *transport);
-- 
1.8.1.4

