Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 06/16] media: Convert register/unregister to accept btd_adapter
Date: Wed, 12 Dec 2012 11:27:58 +0100
Message-ID: <1355308088-9080-7-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1355308088-9080-1-git-send-email-szymon.janc@tieto.com>
References: <1355308088-9080-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Keep reference to passed btd_adapter and use it to get adapter address
and path.
---
 profiles/audio/manager.c | 10 ++++------
 profiles/audio/media.c   | 44 ++++++++++++++++++++++++++------------------
 profiles/audio/media.h   |  4 ++--
 3 files changed, 32 insertions(+), 26 deletions(-)

diff --git a/profiles/audio/manager.c b/profiles/audio/manager.c
index b355281..d4c52a6 100644
--- a/profiles/audio/manager.c
+++ b/profiles/audio/manager.c
@@ -410,16 +410,15 @@ static void avrcp_server_remove(struct btd_profile *p,
 static int media_server_probe(struct btd_adapter *adapter)
 {
 	struct audio_adapter *adp;
-	const gchar *path = adapter_get_path(adapter);
 	int err;
 
-	DBG("path %s", path);
+	DBG("path %s", adapter_get_path(adapter));
 
 	adp = audio_adapter_get(adapter);
 	if (!adp)
 		return -EINVAL;
 
-	err = media_register(path, adapter_get_address(adapter));
+	err = media_register(adapter);
 	if (err < 0)
 		audio_adapter_unref(adp);
 
@@ -429,15 +428,14 @@ static int media_server_probe(struct btd_adapter *adapter)
 static void media_server_remove(struct btd_adapter *adapter)
 {
 	struct audio_adapter *adp;
-	const gchar *path = adapter_get_path(adapter);
 
-	DBG("path %s", path);
+	DBG("path %s", adapter_get_path(adapter));
 
 	adp = find_adapter(adapters, adapter);
 	if (!adp)
 		return;
 
-	media_unregister(path);
+	media_unregister(adapter);
 	audio_adapter_unref(adp);
 }
 
diff --git a/profiles/audio/media.c b/profiles/audio/media.c
index 0839f69..c18dc4e 100644
--- a/profiles/audio/media.c
+++ b/profiles/audio/media.c
@@ -57,8 +57,7 @@
 #define REQUEST_TIMEOUT (3 * 1000)		/* 3 seconds */
 
 struct media_adapter {
-	bdaddr_t		src;		/* Adapter address */
-	char			*path;		/* Adapter path */
+	struct btd_adapter	*btd_adapter;
 	GSList			*endpoints;	/* Endpoints list */
 	GSList			*players;	/* Players list */
 };
@@ -553,7 +552,11 @@ static gboolean endpoint_init_a2dp_source(struct media_endpoint *endpoint,
 						gboolean delay_reporting,
 						int *err)
 {
-	endpoint->sep = a2dp_add_sep(&endpoint->adapter->src,
+	const bdaddr_t *src;
+
+	src = adapter_get_address(endpoint->adapter->btd_adapter);
+
+	endpoint->sep = a2dp_add_sep(src,
 					AVDTP_SEP_TYPE_SOURCE, endpoint->codec,
 					delay_reporting, &a2dp_endpoint,
 					endpoint, a2dp_destroy_endpoint, err);
@@ -567,7 +570,11 @@ static gboolean endpoint_init_a2dp_sink(struct media_endpoint *endpoint,
 						gboolean delay_reporting,
 						int *err)
 {
-	endpoint->sep = a2dp_add_sep(&endpoint->adapter->src,
+	const bdaddr_t *src;
+
+	src = adapter_get_address(endpoint->adapter->btd_adapter);
+
+	endpoint->sep = a2dp_add_sep(src,
 					AVDTP_SEP_TYPE_SINK, endpoint->codec,
 					delay_reporting, &a2dp_endpoint,
 					endpoint, a2dp_destroy_endpoint, err);
@@ -608,10 +615,8 @@ static bool endpoint_properties_exists(const char *uuid,
 						void *user_data)
 {
 	struct media_adapter *adapter = user_data;
-	struct btd_adapter *btd_adapter = device_get_adapter(dev);
-	const bdaddr_t *src = adapter_get_address(btd_adapter);
 
-	if (bacmp(&adapter->src, src) != 0)
+	if (adapter->btd_adapter != device_get_adapter(dev))
 		return false;
 
 	if (media_adapter_find_endpoint(adapter, NULL, NULL, uuid) == NULL)
@@ -1444,8 +1449,9 @@ static struct media_player *media_player_create(struct media_adapter *adapter,
 						"TrackChanged",
 						track_changed,
 						mp, NULL);
-	mp->player = avrcp_register_player(&adapter->src, &player_cb, mp,
-						media_player_free);
+	mp->player = avrcp_register_player(adapter_get_address(adapter->btd_adapter),
+							&player_cb, mp,
+							media_player_free);
 	if (!mp->player) {
 		if (err)
 			*err = -EPROTONOSUPPORT;
@@ -1558,23 +1564,24 @@ static void path_free(void *data)
 
 	adapters = g_slist_remove(adapters, adapter);
 
-	g_free(adapter->path);
+	btd_adapter_unref(adapter->btd_adapter);
 	g_free(adapter);
 }
 
-int media_register(const char *path, const bdaddr_t *src)
+int media_register(struct btd_adapter *btd_adapter)
 {
 	struct media_adapter *adapter;
 
 	adapter = g_new0(struct media_adapter, 1);
-	bacpy(&adapter->src, src);
-	adapter->path = g_strdup(path);
+	adapter->btd_adapter = btd_adapter_ref(btd_adapter);
 
 	if (!g_dbus_register_interface(btd_get_dbus_connection(),
-					path, MEDIA_INTERFACE,
+					adapter_get_path(btd_adapter),
+					MEDIA_INTERFACE,
 					media_methods, NULL, NULL,
 					adapter, path_free)) {
-		error("D-Bus failed to register %s path", path);
+		error("D-Bus failed to register %s path",
+						adapter_get_path(btd_adapter));
 		path_free(adapter);
 		return -1;
 	}
@@ -1584,16 +1591,17 @@ int media_register(const char *path, const bdaddr_t *src)
 	return 0;
 }
 
-void media_unregister(const char *path)
+void media_unregister(struct btd_adapter *btd_adapter)
 {
 	GSList *l;
 
 	for (l = adapters; l; l = l->next) {
 		struct media_adapter *adapter = l->data;
 
-		if (g_strcmp0(path, adapter->path) == 0) {
+		if (adapter->btd_adapter == btd_adapter) {
 			g_dbus_unregister_interface(btd_get_dbus_connection(),
-						path, MEDIA_INTERFACE);
+						adapter_get_path(btd_adapter),
+						MEDIA_INTERFACE);
 			return;
 		}
 	}
diff --git a/profiles/audio/media.h b/profiles/audio/media.h
index 82b9694..dd630d4 100644
--- a/profiles/audio/media.h
+++ b/profiles/audio/media.h
@@ -27,8 +27,8 @@ struct media_endpoint;
 typedef void (*media_endpoint_cb_t) (struct media_endpoint *endpoint,
 					void *ret, int size, void *user_data);
 
-int media_register(const char *path, const bdaddr_t *src);
-void media_unregister(const char *path);
+int media_register(struct btd_adapter *btd_adapter);
+void media_unregister(struct btd_adapter *btd_adapter);
 
 struct a2dp_sep *media_endpoint_get_sep(struct media_endpoint *endpoint);
 const char *media_endpoint_get_uuid(struct media_endpoint *endpoint);
-- 
1.8.0

