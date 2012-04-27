Return-Path: <cyrus@holtmann.org>
From: Mikel Astiz <mikel.astiz.oss@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Mikel Astiz <mikel.astiz@bmw-carit.de>
Subject: [PATCH BlueZ v1 3/5] media: Support multiple transports per endpoint
Date: Fri, 27 Apr 2012 12:59:45 +0200
Message-Id: <1335524387-22831-4-git-send-email-mikel.astiz.oss@gmail.com>
In-Reply-To: <1335524387-22831-1-git-send-email-mikel.astiz.oss@gmail.com>
References: <1335524387-22831-1-git-send-email-mikel.astiz.oss@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Mikel Astiz <mikel.astiz@bmw-carit.de>

Several transports may exist for each endpoint, for example if several
HFGW are connected. This should be exposed to the endpoint as one
transport each.
---
 audio/media.c |  111 ++++++++++++++++++++++++++++++++++++++++-----------------
 1 files changed, 78 insertions(+), 33 deletions(-)

diff --git a/audio/media.c b/audio/media.c
index c0fd0c3..23c3217 100644
--- a/audio/media.c
+++ b/audio/media.c
@@ -86,8 +86,8 @@ struct media_endpoint {
 	guint			ag_watch;
 	guint			watch;
 	struct endpoint_request *request;
-	struct media_transport	*transport;
 	struct media_adapter	*adapter;
+	GSList			*transports;
 };
 
 struct media_player {
@@ -153,8 +153,8 @@ static void media_endpoint_destroy(struct media_endpoint *endpoint)
 	if (endpoint->request)
 		media_endpoint_cancel(endpoint);
 
-	if (endpoint->transport)
-		media_transport_destroy(endpoint->transport);
+	g_slist_free_full(endpoint->transports,
+				(GDestroyNotify) media_transport_destroy);
 
 	g_dbus_remove_watch(adapter->conn, endpoint->watch);
 	g_free(endpoint->capabilities);
@@ -200,18 +200,12 @@ static void headset_setconf_cb(struct media_endpoint *endpoint, void *ret,
 	headset_shutdown(dev);
 }
 
-static void clear_configuration(struct media_endpoint *endpoint)
+static void clear_configuration(struct media_endpoint *endpoint,
+					struct media_transport *transport)
 {
 	DBusConnection *conn;
 	DBusMessage *msg;
 	const char *path;
-	struct media_transport *transport = endpoint->transport;
-
-	if (endpoint->transport == NULL)
-		return;
-
-	if (endpoint->request)
-		media_endpoint_cancel(endpoint);
 
 	conn = endpoint->adapter->conn;
 
@@ -223,15 +217,24 @@ static void clear_configuration(struct media_endpoint *endpoint)
 		goto done;
 	}
 
-	path = media_transport_get_path(endpoint->transport);
+	path = media_transport_get_path(transport);
 	dbus_message_append_args(msg, DBUS_TYPE_OBJECT_PATH, &path,
 							DBUS_TYPE_INVALID);
 	g_dbus_send_message(conn, msg);
 done:
-	endpoint->transport = NULL;
+	endpoint->transports = g_slist_remove(endpoint->transports, transport);
 	media_transport_destroy(transport);
 }
 
+static void clear_endpoint(struct media_endpoint *endpoint)
+{
+	if (endpoint->request)
+		media_endpoint_cancel(endpoint);
+
+	while (endpoint->transports != NULL)
+		clear_configuration(endpoint, endpoint->transports->data);
+}
+
 static void endpoint_reply(DBusPendingCall *call, void *user_data)
 {
 	struct media_endpoint *endpoint = user_data;
@@ -256,7 +259,7 @@ static void endpoint_reply(DBusPendingCall *call, void *user_data)
 			if (request->cb)
 				request->cb(endpoint, NULL, size,
 							request->user_data);
-			clear_configuration(endpoint);
+			clear_endpoint(endpoint);
 			dbus_message_unref(reply);
 			dbus_error_free(&err);
 			return;
@@ -369,6 +372,31 @@ static gboolean select_configuration(struct media_endpoint *endpoint,
 								destroy);
 }
 
+static gint transport_device_cmp(gconstpointer data, gconstpointer user_data)
+{
+	struct media_transport *transport = (struct media_transport *) data;
+	const struct audio_device *device = user_data;
+
+	if (device == media_transport_get_dev(transport))
+		return 0;
+
+	return -1;
+}
+
+static struct media_transport *find_device_transport(
+					struct media_endpoint *endpoint,
+					struct audio_device *device)
+{
+	GSList *match;
+
+	match = g_slist_find_custom(endpoint->transports, device,
+							transport_device_cmp);
+	if (match == NULL)
+		return NULL;
+
+	return match->data;
+}
+
 static gboolean set_configuration(struct media_endpoint *endpoint,
 					struct audio_device *device,
 					uint8_t *configuration, size_t size,
@@ -380,15 +408,18 @@ static gboolean set_configuration(struct media_endpoint *endpoint,
 	DBusMessage *msg;
 	const char *path;
 	DBusMessageIter iter;
+	struct media_transport *transport;
+
+	transport = find_device_transport(endpoint, device);
 
-	if (endpoint->transport != NULL || endpoint->request != NULL)
+	if (transport != NULL || endpoint->request != NULL)
 		return FALSE;
 
 	conn = endpoint->adapter->conn;
 
-	endpoint->transport = media_transport_create(conn, endpoint, device,
+	transport = media_transport_create(conn, endpoint, device,
 						configuration, size);
-	if (endpoint->transport == NULL)
+	if (transport == NULL)
 		return FALSE;
 
 	msg = dbus_message_new_method_call(endpoint->sender, endpoint->path,
@@ -396,15 +427,18 @@ static gboolean set_configuration(struct media_endpoint *endpoint,
 						"SetConfiguration");
 	if (msg == NULL) {
 		error("Couldn't allocate D-Bus message");
+		media_transport_destroy(transport);
 		return FALSE;
 	}
 
+	endpoint->transports = g_slist_append(endpoint->transports, transport);
+
 	dbus_message_iter_init_append(msg, &iter);
 
-	path = media_transport_get_path(endpoint->transport);
+	path = media_transport_get_path(transport);
 	dbus_message_iter_append_basic(&iter, DBUS_TYPE_OBJECT_PATH, &path);
 
-	transport_get_properties(endpoint->transport, &iter);
+	transport_get_properties(transport, &iter);
 
 	return media_endpoint_async_call(conn, msg, endpoint, cb, user_data,
 								destroy);
@@ -440,16 +474,17 @@ static void headset_state_changed(struct audio_device *dev,
 					void *user_data)
 {
 	struct media_endpoint *endpoint = user_data;
+	struct media_transport *transport;
 
 	DBG("");
 
 	switch (new_state) {
 	case HEADSET_STATE_DISCONNECTED:
-		if (endpoint->transport &&
-			media_transport_get_dev(endpoint->transport) == dev) {
+		transport = find_device_transport(endpoint, dev);
 
+		if (transport != NULL) {
 			DBG("Clear endpoint %p", endpoint);
-			clear_configuration(endpoint);
+			clear_configuration(endpoint, transport);
 		}
 		break;
 	case HEADSET_STATE_CONNECTING:
@@ -551,17 +586,30 @@ static void clear_config(struct a2dp_sep *sep, void *user_data)
 {
 	struct media_endpoint *endpoint = user_data;
 
-	clear_configuration(endpoint);
+	clear_endpoint(endpoint);
+}
+
+static struct media_transport *get_unique_transport(
+					struct media_endpoint *endpoint)
+{
+	if (endpoint->transports == NULL)
+		return NULL;
+
+	if (endpoint->transports->next != NULL)
+		return NULL;
+
+	return endpoint->transports->data;
 }
 
 static void set_delay(struct a2dp_sep *sep, uint16_t delay, void *user_data)
 {
 	struct media_endpoint *endpoint = user_data;
+	struct media_transport *transport = get_unique_transport(endpoint);
 
-	if (endpoint->transport == NULL)
+	if (transport == NULL)
 		return;
 
-	media_transport_update_delay(endpoint->transport, delay);
+	media_transport_update_delay(transport, delay);
 }
 
 static struct a2dp_endpoint a2dp_endpoint = {
@@ -577,10 +625,7 @@ static void a2dp_destroy_endpoint(void *user_data)
 {
 	struct media_endpoint *endpoint = user_data;
 
-	if (endpoint->transport) {
-		media_transport_destroy(endpoint->transport);
-		endpoint->transport = NULL;
-	}
+	clear_endpoint(endpoint);
 
 	endpoint->sep = NULL;
 	release_endpoint(endpoint);
@@ -603,16 +648,16 @@ static void gateway_state_changed(struct audio_device *dev,
 					void *user_data)
 {
 	struct media_endpoint *endpoint = user_data;
+	struct media_transport *transport;
 
 	DBG("");
 
 	switch (new_state) {
 	case GATEWAY_STATE_DISCONNECTED:
-		if (endpoint->transport &&
-			media_transport_get_dev(endpoint->transport) == dev) {
-
+		transport = find_device_transport(endpoint, dev);
+		if (transport != NULL) {
 			DBG("Clear endpoint %p", endpoint);
-			clear_configuration(endpoint);
+			clear_configuration(endpoint, transport);
 		}
 		break;
 	case GATEWAY_STATE_CONNECTING:
-- 
1.7.7.6

