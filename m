Return-Path: <cyrus@holtmann.org>
From: Mikel Astiz <mikel.astiz.oss@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Mikel Astiz <mikel.astiz@bmw-carit.de>
Subject: [RFC BlueZ v0 02/10] media: Add callback to report new endpoints
Date: Fri, 12 Jul 2013 12:54:35 +0200
Message-Id: <1373626483-2031-3-git-send-email-mikel.astiz.oss@gmail.com>
In-Reply-To: <1373626483-2031-1-git-send-email-mikel.astiz.oss@gmail.com>
References: <1373626483-2031-1-git-send-email-mikel.astiz.oss@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Mikel Astiz <mikel.astiz@bmw-carit.de>

When a new endpoint gets registered, propagate information to any
interested user.
---
 profiles/audio/media.c | 80 +++++++++++++++++++++++++++++++++++++++++++++-----
 profiles/audio/media.h | 10 +++++++
 2 files changed, 82 insertions(+), 8 deletions(-)

diff --git a/profiles/audio/media.c b/profiles/audio/media.c
index c24ac7d..8fa2fa3 100644
--- a/profiles/audio/media.c
+++ b/profiles/audio/media.c
@@ -60,6 +60,7 @@ struct media_adapter {
 	struct btd_adapter	*btd_adapter;
 	GSList			*endpoints;	/* Endpoints list */
 	GSList			*players;	/* Players list */
+	GSList			*endpoint_register_callbacks;
 };
 
 struct endpoint_request {
@@ -109,8 +110,16 @@ struct media_player {
 	bool			control;
 };
 
+struct endpoint_register_callback {
+	media_endpoint_register_cb_t cb;
+	void			*user_data;
+	unsigned int		id;
+};
+
 static GSList *adapters = NULL;
 
+static struct media_adapter *find_adapter(struct btd_adapter *adapter);
+
 static void endpoint_request_free(struct endpoint_request *request)
 {
 	if (request->call)
@@ -389,6 +398,54 @@ static int transport_device_cmp(gconstpointer data, gconstpointer user_data)
 	return -1;
 }
 
+unsigned int btd_media_endpoint_add_register_cb(struct btd_adapter *btd_adapter,
+						media_endpoint_register_cb_t cb,
+						void *user_data)
+{
+	struct media_adapter *adapter;
+	struct endpoint_register_callback *register_cb;
+	static unsigned int id = 0;
+
+	adapter = find_adapter(btd_adapter);
+	if (adapter == NULL)
+		return 0;
+
+	register_cb = g_new0(struct endpoint_register_callback, 1);
+	register_cb->cb = cb;
+	register_cb->user_data = user_data;
+	register_cb->id = ++id;
+
+	adapter->endpoint_register_callbacks = g_slist_append(
+			adapter->endpoint_register_callbacks, register_cb);
+
+	return register_cb->id;
+}
+
+bool btd_media_endpoint_remove_register_cb(struct btd_adapter *btd_adapter,
+								unsigned int id)
+{
+	struct media_adapter *adapter;
+	GSList *l;
+
+	adapter = find_adapter(btd_adapter);
+	if (adapter == NULL)
+		return false;
+
+	for (l = adapter->endpoint_register_callbacks; l != NULL;
+							l = g_slist_next(l)) {
+		struct endpoint_register_callback *cb = l->data;
+
+		if (cb && cb->id == id) {
+			adapter->endpoint_register_callbacks = g_slist_remove(
+				adapter->endpoint_register_callbacks, cb);
+			g_free(cb);
+			return true;
+		}
+	}
+
+	return false;
+}
+
 static struct media_transport *find_device_transport(
 					struct media_endpoint *endpoint,
 					struct audio_device *device)
@@ -738,6 +795,7 @@ static struct media_endpoint *media_endpoint_create(struct media_adapter *adapte
 						int *err)
 {
 	struct media_endpoint *endpoint;
+	GSList *l;
 	gboolean succeeded;
 
 	endpoint = g_new0(struct media_endpoint, 1);
@@ -792,6 +850,13 @@ static struct media_endpoint *media_endpoint_create(struct media_adapter *adapte
 	adapter->endpoints = g_slist_append(adapter->endpoints, endpoint);
 	info("Endpoint registered: sender=%s path=%s", sender, path);
 
+	for (l = adapter->endpoint_register_callbacks; l != NULL;
+							l = g_slist_next(l)) {
+		struct endpoint_register_callback *cb = l->data;
+
+		cb->cb(endpoint, cb->user_data);
+	}
+
 	if (err)
 		*err = 0;
 	return endpoint;
@@ -1821,6 +1886,8 @@ static void path_free(void *data)
 	while (adapter->players)
 		media_player_destroy(adapter->players->data);
 
+	g_slist_free(adapter->endpoint_register_callbacks);
+
 	adapters = g_slist_remove(adapters, adapter);
 
 	btd_adapter_unref(adapter->btd_adapter);
@@ -1852,18 +1919,15 @@ int media_register(struct btd_adapter *btd_adapter)
 
 void media_unregister(struct btd_adapter *btd_adapter)
 {
-	GSList *l;
+	struct media_adapter *adapter;
 
-	for (l = adapters; l; l = l->next) {
-		struct media_adapter *adapter = l->data;
+	adapter = find_adapter(btd_adapter);
+	if (adapter == NULL)
+		return;
 
-		if (adapter->btd_adapter == btd_adapter) {
-			g_dbus_unregister_interface(btd_get_dbus_connection(),
+	g_dbus_unregister_interface(btd_get_dbus_connection(),
 						adapter_get_path(btd_adapter),
 						MEDIA_INTERFACE);
-			return;
-		}
-	}
 }
 
 struct a2dp_sep *media_endpoint_get_sep(struct media_endpoint *endpoint)
diff --git a/profiles/audio/media.h b/profiles/audio/media.h
index ab187dd..25013d9 100644
--- a/profiles/audio/media.h
+++ b/profiles/audio/media.h
@@ -28,6 +28,9 @@ struct media_transport;
 typedef void (*media_endpoint_cb_t) (struct media_endpoint *endpoint,
 					void *ret, int size, void *user_data);
 
+typedef void (*media_endpoint_register_cb_t) (struct media_endpoint *endpoint,
+							void *user_data);
+
 int media_register(struct btd_adapter *btd_adapter);
 void media_unregister(struct btd_adapter *btd_adapter);
 
@@ -37,6 +40,13 @@ uint8_t media_endpoint_get_codec(struct media_endpoint *endpoint);
 
 struct media_endpoint *btd_media_endpoint_find(struct btd_adapter *btd_adapter,
 							const char *uuid);
+
+unsigned int btd_media_endpoint_add_register_cb(struct btd_adapter *btd_adapter,
+						media_endpoint_register_cb_t cb,
+						void *user_data);
+bool btd_media_endpoint_remove_register_cb(struct btd_adapter *btd_adapter,
+							unsigned int id);
+
 struct media_transport *btd_media_endpoint_set_configuration(
 					struct media_endpoint *endpoint,
 					struct audio_device *device,
-- 
1.8.1.4

