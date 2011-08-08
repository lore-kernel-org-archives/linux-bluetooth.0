Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2] Fix possible invalid read/free on media.c
Date: Mon,  8 Aug 2011 15:45:50 +0300
Message-Id: <1312807550-9603-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This also fix the circular dependency of media.c and a2dp.c

 Invalid read of size 8
    at 0x4EA8CC2: g_slice_free_chain_with_offset (in /lib64/libglib-2.0.so.0.2908.0)
    by 0x13AF33: path_free (media.c:417)
    by 0x11EB39: remove_interface (object.c:563)
    by 0x11F360: g_dbus_unregister_interface (object.c:715)
    by 0x120C49: media_server_remove (manager.c:1098)
    by 0x4EA9826: g_slist_foreach (in /lib64/libglib-2.0.so.0.2908.0)
    by 0x178915: adapter_remove (adapter.c:2326)
    by 0x17535F: btd_manager_unregister_adapter (manager.c:293)
    by 0x154081: device_event (hciops.c:2643)
    by 0x1543C1: io_stack_event (hciops.c:2763)
    by 0x4E8C88C: g_main_context_dispatch (in /lib64/libglib-2.0.so.0.2908.0)
    by 0x4E8D087: ??? (in /lib64/libglib-2.0.so.0.2908.0)
  Address 0x63f6638 is 8 bytes inside a block of size 16 free'd
    at 0x4A055FE: free (vg_replace_malloc.c:366)
    by 0x4E938F2: g_free (in /lib64/libglib-2.0.so.0.2908.0)
    by 0x4EA854E: g_slice_free1 (in /lib64/libglib-2.0.so.0.2908.0)
    by 0x4EA930C: g_slist_remove (in /lib64/libglib-2.0.so.0.2908.0)
    by 0x13AE53: media_endpoint_remove (media.c:118)
    by 0x4EA9826: g_slist_foreach (in /lib64/libglib-2.0.so.0.2908.0)
    by 0x4EA984A: g_slist_free_full (in /lib64/libglib-2.0.so.0.2908.0)
    by 0x13AF33: path_free (media.c:417)
    by 0x11EB39: remove_interface (object.c:563)
    by 0x11F360: g_dbus_unregister_interface (object.c:715)
    by 0x120C49: media_server_remove (manager.c:1098)
    by 0x4EA9826: g_slist_foreach (in /lib64/libglib-2.0.so.0.2908.0)
---
 audio/a2dp.c      |   92 ++++---
 audio/a2dp.h      |   32 +++-
 audio/media.c     |  706 +++++++++++++++++++++++++++++++----------------------
 audio/media.h     |   17 --
 audio/transport.c |    3 +-
 5 files changed, 502 insertions(+), 348 deletions(-)

diff --git a/audio/a2dp.c b/audio/a2dp.c
index 72a0df5..8347a60 100644
--- a/audio/a2dp.c
+++ b/audio/a2dp.c
@@ -44,8 +44,6 @@
 #include "sink.h"
 #include "source.h"
 #include "unix.h"
-#include "media.h"
-#include "transport.h"
 #include "a2dp.h"
 #include "sdpd.h"
 
@@ -64,7 +62,7 @@
 
 struct a2dp_sep {
 	struct a2dp_server *server;
-	struct media_endpoint *endpoint;
+	struct a2dp_endpoint *endpoint;
 	uint8_t type;
 	uint8_t codec;
 	struct avdtp_local_sep *lsep;
@@ -75,6 +73,8 @@ struct a2dp_sep {
 	gboolean locked;
 	gboolean suspending;
 	gboolean starting;
+	void *user_data;
+	GDestroyNotify destroy;
 };
 
 struct a2dp_setup_cb {
@@ -372,8 +372,8 @@ static void stream_state_changed(struct avdtp_stream *stream,
 
 	sep->stream = NULL;
 
-	if (sep->endpoint)
-		media_endpoint_clear_configuration(sep->endpoint);
+	if (sep->endpoint && sep->endpoint->clear_configuration)
+		sep->endpoint->clear_configuration(sep, sep->user_data);
 }
 
 static gboolean auto_config(gpointer data)
@@ -638,12 +638,12 @@ static gboolean mpeg_getcap_ind(struct avdtp *session,
 	return TRUE;
 }
 
-static void endpoint_setconf_cb(struct media_endpoint *endpoint, void *ret,
-						int size, void *user_data)
+static void endpoint_setconf_cb(struct a2dp_sep *sep, guint setup_id,
+								gboolean ret)
 {
-	struct a2dp_setup *setup = user_data;
+	struct a2dp_setup *setup = GUINT_TO_POINTER(setup_id);
 
-	if (ret == NULL) {
+	if (ret == FALSE) {
 		setup->err = g_new(struct avdtp_error, 1);
 		avdtp_error_init(setup->err, AVDTP_MEDIA_CODEC,
 					AVDTP_UNSUPPORTED_CONFIGURATION);
@@ -701,11 +701,13 @@ static gboolean endpoint_setconf_ind(struct avdtp *session,
 			goto done;
 		}
 
-		ret = media_endpoint_set_configuration(a2dp_sep->endpoint,
+		ret = a2dp_sep->endpoint->set_configuration(a2dp_sep,
 						setup->dev, codec->data,
 						cap->length - sizeof(*codec),
-						endpoint_setconf_cb, setup);
-		if (ret)
+						GPOINTER_TO_UINT(setup),
+						endpoint_setconf_cb,
+						a2dp_sep->user_data);
+		if (ret == 0)
 			return TRUE;
 
 		avdtp_error_init(setup->err, AVDTP_MEDIA_CODEC,
@@ -741,8 +743,8 @@ static gboolean endpoint_getcap_ind(struct avdtp *session,
 
 	*caps = g_slist_append(*caps, media_transport);
 
-	length = media_endpoint_get_capabilities(a2dp_sep->endpoint,
-						&capabilities);
+	length = a2dp_sep->endpoint->get_capabilities(a2dp_sep, &capabilities,
+							a2dp_sep->user_data);
 
 	codec_caps = g_malloc0(sizeof(*codec_caps) + length);
 	codec_caps->media_type = AVDTP_MEDIA_TYPE_AUDIO;
@@ -765,13 +767,13 @@ static gboolean endpoint_getcap_ind(struct avdtp *session,
 	return TRUE;
 }
 
-static void endpoint_open_cb(struct media_endpoint *endpoint, void *ret,
-						int size, void *user_data)
+static void endpoint_open_cb(struct a2dp_sep *sep, guint setup_id,
+								gboolean ret)
 {
-	struct a2dp_setup *setup = user_data;
+	struct a2dp_setup *setup = GUINT_TO_POINTER(setup_id);
 	int err;
 
-	if (ret == NULL) {
+	if (ret == FALSE) {
 		setup->stream = NULL;
 		finalize_setup_errno(setup, -EPERM, finalize_config, NULL);
 		return;
@@ -828,15 +830,18 @@ static void setconf_cfm(struct avdtp *session, struct avdtp_local_sep *sep,
 	if (a2dp_sep->endpoint) {
 		struct avdtp_service_capability *service;
 		struct avdtp_media_codec_capability *codec;
+		int err;
 
 		service = avdtp_stream_get_codec(stream);
 		codec = (struct avdtp_media_codec_capability *) service->data;
 
-		if (media_endpoint_set_configuration(a2dp_sep->endpoint, dev,
+		err = a2dp_sep->endpoint->set_configuration(a2dp_sep, dev,
 						codec->data, service->length -
 						sizeof(*codec),
-						endpoint_open_cb, setup) ==
-						TRUE)
+						GPOINTER_TO_UINT(setup),
+						endpoint_open_cb,
+						a2dp_sep->user_data);
+		if (err == 0)
 			return;
 
 		setup->stream = NULL;
@@ -1254,18 +1259,17 @@ static gboolean endpoint_delayreport_ind(struct avdtp *session,
 						uint8_t *err, void *user_data)
 {
 	struct a2dp_sep *a2dp_sep = user_data;
-	struct media_transport *transport;
 
 	if (a2dp_sep->type == AVDTP_SEP_TYPE_SINK)
 		DBG("Sink %p: DelayReport_Ind", sep);
 	else
 		DBG("Source %p: DelayReport_Ind", sep);
 
-	transport = media_endpoint_get_transport(a2dp_sep->endpoint);
-	if (transport == NULL)
+	if (a2dp_sep->endpoint == NULL ||
+				a2dp_sep->endpoint->set_delay == NULL)
 		return FALSE;
 
-	media_transport_update_delay(transport, delay);
+	a2dp_sep->endpoint->set_delay(a2dp_sep, delay, a2dp_sep->user_data);
 
 	return TRUE;
 }
@@ -1559,23 +1563,25 @@ proceed:
 	if (source) {
 		for (i = 0; i < sbc_srcs; i++)
 			a2dp_add_sep(src, AVDTP_SEP_TYPE_SOURCE,
-				A2DP_CODEC_SBC, delay_reporting, NULL, NULL);
+					A2DP_CODEC_SBC, delay_reporting,
+					NULL, NULL, NULL, NULL);
 
 		for (i = 0; i < mpeg12_srcs; i++)
 			a2dp_add_sep(src, AVDTP_SEP_TYPE_SOURCE,
 					A2DP_CODEC_MPEG12, delay_reporting,
-					NULL, NULL);
+					NULL, NULL, NULL, NULL);
 	}
 	server->sink_enabled = sink;
 	if (sink) {
 		for (i = 0; i < sbc_sinks; i++)
 			a2dp_add_sep(src, AVDTP_SEP_TYPE_SINK,
-				A2DP_CODEC_SBC, delay_reporting, NULL, NULL);
+					A2DP_CODEC_SBC, delay_reporting,
+					NULL, NULL, NULL, NULL);
 
 		for (i = 0; i < mpeg12_sinks; i++)
 			a2dp_add_sep(src, AVDTP_SEP_TYPE_SINK,
 					A2DP_CODEC_MPEG12, delay_reporting,
-					NULL, NULL);
+					NULL, NULL, NULL, NULL);
 	}
 
 	return 0;
@@ -1583,8 +1589,8 @@ proceed:
 
 static void a2dp_unregister_sep(struct a2dp_sep *sep)
 {
-	if (sep->endpoint) {
-		media_endpoint_release(sep->endpoint);
+	if (sep->destroy) {
+		sep->destroy(sep->user_data);
 		sep->endpoint = NULL;
 	}
 
@@ -1625,7 +1631,9 @@ void a2dp_unregister(const bdaddr_t *src)
 
 struct a2dp_sep *a2dp_add_sep(const bdaddr_t *src, uint8_t type,
 				uint8_t codec, gboolean delay_reporting,
-				struct media_endpoint *endpoint, int *err)
+				struct a2dp_endpoint *endpoint,
+				void *user_data, GDestroyNotify destroy,
+				int *err)
 {
 	struct a2dp_server *server;
 	struct a2dp_sep *sep;
@@ -1678,6 +1686,8 @@ proceed:
 	sep->codec = codec;
 	sep->type = type;
 	sep->delay_reporting = delay_reporting;
+	sep->user_data = user_data;
+	sep->destroy = destroy;
 
 	if (type == AVDTP_SEP_TYPE_SOURCE) {
 		l = &server->sources;
@@ -1927,10 +1937,10 @@ static gboolean select_capabilities(struct avdtp *session,
 	return TRUE;
 }
 
-static void select_cb(struct media_endpoint *endpoint, void *ret, int size,
-			void *user_data)
+static void select_cb(struct a2dp_sep *sep, guint setup_id, void *ret,
+								int size)
 {
-	struct a2dp_setup *setup = user_data;
+	struct a2dp_setup *setup = GUINT_TO_POINTER(setup_id);
 	struct avdtp_service_capability *media_transport, *media_codec;
 	struct avdtp_media_codec_capability *cap;
 
@@ -1981,7 +1991,7 @@ static struct a2dp_sep *a2dp_find_sep(struct avdtp *session, GSList *list,
 			if (sep->endpoint == NULL)
 				continue;
 
-			name = media_endpoint_get_sender(sep->endpoint);
+			name = sep->endpoint->get_name(sep, sep->user_data);
 			if (g_strcmp0(sender, name) != 0)
 				continue;
 		}
@@ -2028,6 +2038,7 @@ unsigned int a2dp_select_capabilities(struct avdtp *session,
 	struct a2dp_sep *sep;
 	struct avdtp_service_capability *service;
 	struct avdtp_media_codec_capability *codec;
+	int err;
 
 	sep = a2dp_select_sep(session, type, sender);
 	if (!sep) {
@@ -2068,10 +2079,11 @@ unsigned int a2dp_select_capabilities(struct avdtp *session,
 	service = avdtp_get_codec(setup->rsep);
 	codec = (struct avdtp_media_codec_capability *) service->data;
 
-	if (media_endpoint_select_configuration(sep->endpoint, codec->data,
-						service->length - sizeof(*codec),
-						select_cb, setup) ==
-						TRUE)
+	err = sep->endpoint->select_configuration(sep, codec->data,
+					service->length - sizeof(*codec),
+					GPOINTER_TO_UINT(setup),
+					select_cb, sep->user_data);
+	if (err == 0)
 		return cb_data->id;
 
 fail:
diff --git a/audio/a2dp.h b/audio/a2dp.h
index 5c4232d..ed123e4 100644
--- a/audio/a2dp.h
+++ b/audio/a2dp.h
@@ -121,6 +121,34 @@ struct mpeg_codec_cap {
 
 struct a2dp_sep;
 
+typedef void (*a2dp_endpoint_select_t) (struct a2dp_sep *sep, guint setup_id,
+							void *ret, int size);
+typedef void (*a2dp_endpoint_config_t) (struct a2dp_sep *sep, guint setup_id,
+								gboolean ret);
+
+
+struct a2dp_endpoint {
+	const char *(*get_name) (struct a2dp_sep *sep, void *user_data);
+	size_t (*get_capabilities) (struct a2dp_sep *sep,
+						uint8_t **capabilities,
+						void *user_data);
+	int (*select_configuration) (struct a2dp_sep *sep,
+						uint8_t *capabilities,
+						size_t length,
+						guint setup_id,
+						a2dp_endpoint_select_t cb,
+						void *user_data);
+	int (*set_configuration) (struct a2dp_sep *sep,
+						struct audio_device *dev,
+						uint8_t *configuration,
+						size_t length,
+						guint setup_id,
+						a2dp_endpoint_config_t cb,
+						void *user_data);
+	void (*clear_configuration) (struct a2dp_sep *sep, void *user_data);
+	void (*set_delay) (struct a2dp_sep *sep, uint16_t delay,
+							void *user_data);
+};
 
 typedef void (*a2dp_select_cb_t) (struct avdtp *session,
 					struct a2dp_sep *sep, GSList *caps,
@@ -138,7 +166,9 @@ void a2dp_unregister(const bdaddr_t *src);
 
 struct a2dp_sep *a2dp_add_sep(const bdaddr_t *src, uint8_t type,
 				uint8_t codec, gboolean delay_reporting,
-				struct media_endpoint *endpoint, int *err);
+				struct a2dp_endpoint *endpoint,
+				void *user_data, GDestroyNotify destroy,
+				int *err);
 void a2dp_remove_sep(struct a2dp_sep *sep);
 
 struct a2dp_sep *a2dp_get(struct avdtp *session, struct avdtp_remote_sep *sep);
diff --git a/audio/media.c b/audio/media.c
index 57bf7c9..1303a90 100644
--- a/audio/media.c
+++ b/audio/media.c
@@ -65,6 +65,7 @@ struct endpoint_request {
 	DBusMessage		*msg;
 	DBusPendingCall		*call;
 	media_endpoint_cb_t	cb;
+	GDestroyNotify		destroy;
 	void			*user_data;
 };
 
@@ -90,6 +91,9 @@ static void endpoint_request_free(struct endpoint_request *request)
 	if (request->call)
 		dbus_pending_call_unref(request->call);
 
+	if (request->destroy)
+		request->destroy(request->user_data);
+
 	dbus_message_unref(request->msg);
 	g_free(request);
 }
@@ -105,20 +109,11 @@ static void media_endpoint_cancel(struct media_endpoint *endpoint)
 	endpoint->request = NULL;
 }
 
-static void media_endpoint_remove(struct media_endpoint *endpoint)
+static void media_endpoint_destroy(struct media_endpoint *endpoint)
 {
 	struct media_adapter *adapter = endpoint->adapter;
 
-	if (g_slist_find(adapter->endpoints, endpoint) == NULL)
-		return;
-
-	info("Endpoint unregistered: sender=%s path=%s", endpoint->sender,
-			endpoint->path);
-
-	adapter->endpoints = g_slist_remove(adapter->endpoints, endpoint);
-
-	if (endpoint->sep)
-		a2dp_remove_sep(endpoint->sep);
+	DBG("sender=%s path=%s", endpoint->sender, endpoint->path);
 
 	if (endpoint->hs_watch)
 		headset_remove_state_cb(endpoint->hs_watch);
@@ -137,6 +132,23 @@ static void media_endpoint_remove(struct media_endpoint *endpoint)
 	g_free(endpoint);
 }
 
+static void media_endpoint_remove(struct media_endpoint *endpoint)
+{
+	struct media_adapter *adapter = endpoint->adapter;
+
+	if (endpoint->sep) {
+		a2dp_remove_sep(endpoint->sep);
+		return;
+	}
+
+	info("Endpoint unregistered: sender=%s path=%s", endpoint->sender,
+			endpoint->path);
+
+	adapter->endpoints = g_slist_remove(adapter->endpoints, endpoint);
+
+	media_endpoint_destroy(endpoint);
+}
+
 static void media_endpoint_exit(DBusConnection *connection, void *user_data)
 {
 	struct media_endpoint *endpoint = user_data;
@@ -156,35 +168,396 @@ static void headset_setconf_cb(struct media_endpoint *endpoint, void *ret,
 	headset_set_state(dev, HEADSET_STATE_DISCONNECTED);
 }
 
-static void headset_state_changed(struct audio_device *dev,
-					headset_state_t old_state,
-					headset_state_t new_state,
-					void *user_data)
+static void clear_configuration(struct media_endpoint *endpoint)
+{
+	DBusConnection *conn;
+	DBusMessage *msg;
+	const char *path;
+	struct media_transport *transport = endpoint->transport;
+
+	if (endpoint->transport == NULL)
+		return;
+
+	if (endpoint->request)
+		media_endpoint_cancel(endpoint);
+
+	conn = endpoint->adapter->conn;
+
+	msg = dbus_message_new_method_call(endpoint->sender, endpoint->path,
+						MEDIA_ENDPOINT_INTERFACE,
+						"ClearConfiguration");
+	if (msg == NULL) {
+		error("Couldn't allocate D-Bus message");
+		goto done;
+	}
+
+	path = media_transport_get_path(endpoint->transport);
+	dbus_message_append_args(msg, DBUS_TYPE_OBJECT_PATH, &path,
+							DBUS_TYPE_INVALID);
+	g_dbus_send_message(conn, msg);
+done:
+	endpoint->transport = NULL;
+	media_transport_destroy(transport);
+}
+
+static void endpoint_reply(DBusPendingCall *call, void *user_data)
+{
+	struct media_endpoint *endpoint = user_data;
+	struct endpoint_request *request = endpoint->request;
+	DBusMessage *reply;
+	DBusError err;
+	gboolean value;
+	void *ret = NULL;
+	int size = -1;
+
+	/* steal_reply will always return non-NULL since the callback
+	 * is only called after a reply has been received */
+	reply = dbus_pending_call_steal_reply(call);
+
+	dbus_error_init(&err);
+	if (dbus_set_error_from_message(&err, reply)) {
+		error("Endpoint replied with an error: %s",
+				err.name);
+
+		/* Clear endpoint configuration in case of NO_REPLY error */
+		if (dbus_error_has_name(&err, DBUS_ERROR_NO_REPLY)) {
+			if (request->cb)
+				request->cb(endpoint, NULL, size,
+							request->user_data);
+			clear_configuration(endpoint);
+			dbus_message_unref(reply);
+			dbus_error_free(&err);
+			return;
+		}
+
+		dbus_error_free(&err);
+		goto done;
+	}
+
+	dbus_error_init(&err);
+	if (dbus_message_is_method_call(request->msg, MEDIA_ENDPOINT_INTERFACE,
+				"SelectConfiguration")) {
+		DBusMessageIter args, array;
+		uint8_t *configuration;
+
+		dbus_message_iter_init(reply, &args);
+
+		dbus_message_iter_recurse(&args, &array);
+
+		dbus_message_iter_get_fixed_array(&array, &configuration, &size);
+
+		ret = configuration;
+		goto done;
+	} else  if (!dbus_message_get_args(reply, &err, DBUS_TYPE_INVALID)) {
+		error("Wrong reply signature: %s", err.message);
+		dbus_error_free(&err);
+		goto done;
+	}
+
+	size = 1;
+	value = TRUE;
+	ret = &value;
+
+done:
+	dbus_message_unref(reply);
+
+	if (request->cb)
+		request->cb(endpoint, ret, size, request->user_data);
+
+	endpoint_request_free(request);
+	endpoint->request = NULL;
+}
+
+static gboolean media_endpoint_async_call(DBusConnection *conn,
+					DBusMessage *msg,
+					struct media_endpoint *endpoint,
+					media_endpoint_cb_t cb,
+					void *user_data,
+					GDestroyNotify destroy)
+{
+	struct endpoint_request *request;
+
+	if (endpoint->request)
+		return FALSE;
+
+	request = g_new0(struct endpoint_request, 1);
+
+	/* Timeout should be less than avdtp request timeout (4 seconds) */
+	if (dbus_connection_send_with_reply(conn, msg, &request->call,
+						REQUEST_TIMEOUT) == FALSE) {
+		error("D-Bus send failed");
+		g_free(request);
+		return FALSE;
+	}
+
+	dbus_pending_call_set_notify(request->call, endpoint_reply, endpoint, NULL);
+
+	request->msg = msg;
+	request->cb = cb;
+	request->destroy = destroy;
+	request->user_data = user_data;
+	endpoint->request = request;
+
+	DBG("Calling %s: name = %s path = %s", dbus_message_get_member(msg),
+			dbus_message_get_destination(msg),
+			dbus_message_get_path(msg));
+
+	return TRUE;
+}
+
+static gboolean select_configuration(struct media_endpoint *endpoint,
+						uint8_t *capabilities,
+						size_t length,
+						media_endpoint_cb_t cb,
+						void *user_data,
+						GDestroyNotify destroy)
+{
+	DBusConnection *conn;
+	DBusMessage *msg;
+
+	if (endpoint->request != NULL)
+		return FALSE;
+
+	conn = endpoint->adapter->conn;
+
+	msg = dbus_message_new_method_call(endpoint->sender, endpoint->path,
+						MEDIA_ENDPOINT_INTERFACE,
+						"SelectConfiguration");
+	if (msg == NULL) {
+		error("Couldn't allocate D-Bus message");
+		return FALSE;
+	}
+
+	dbus_message_append_args(msg, DBUS_TYPE_ARRAY, DBUS_TYPE_BYTE,
+					&capabilities, length,
+					DBUS_TYPE_INVALID);
+
+	return media_endpoint_async_call(conn, msg, endpoint, cb, user_data,
+								destroy);
+}
+
+static gboolean set_configuration(struct media_endpoint *endpoint,
+					struct audio_device *device,
+					uint8_t *configuration, size_t size,
+					media_endpoint_cb_t cb,
+					void *user_data,
+					GDestroyNotify destroy)
+{
+	DBusConnection *conn;
+	DBusMessage *msg;
+	const char *path;
+	DBusMessageIter iter;
+
+	if (endpoint->transport != NULL || endpoint->request != NULL)
+		return FALSE;
+
+	conn = endpoint->adapter->conn;
+
+	endpoint->transport = media_transport_create(conn, endpoint, device,
+						configuration, size);
+	if (endpoint->transport == NULL)
+		return FALSE;
+
+	msg = dbus_message_new_method_call(endpoint->sender, endpoint->path,
+						MEDIA_ENDPOINT_INTERFACE,
+						"SetConfiguration");
+	if (msg == NULL) {
+		error("Couldn't allocate D-Bus message");
+		return FALSE;
+	}
+
+	dbus_message_iter_init_append(msg, &iter);
+
+	path = media_transport_get_path(endpoint->transport);
+	dbus_message_iter_append_basic(&iter, DBUS_TYPE_OBJECT_PATH, &path);
+
+	transport_get_properties(endpoint->transport, &iter);
+
+	return media_endpoint_async_call(conn, msg, endpoint, cb, user_data,
+								destroy);
+}
+
+static void release_endpoint(struct media_endpoint *endpoint)
+{
+	DBusMessage *msg;
+
+	DBG("sender=%s path=%s", endpoint->sender, endpoint->path);
+
+	/* already exit */
+	if (endpoint->watch == 0)
+		goto done;
+
+	msg = dbus_message_new_method_call(endpoint->sender, endpoint->path,
+						MEDIA_ENDPOINT_INTERFACE,
+						"Release");
+	if (msg == NULL) {
+		error("Couldn't allocate D-Bus message");
+		return;
+	}
+
+	g_dbus_send_message(endpoint->adapter->conn, msg);
+
+done:
+	media_endpoint_remove(endpoint);
+}
+
+static void headset_state_changed(struct audio_device *dev,
+					headset_state_t old_state,
+					headset_state_t new_state,
+					void *user_data)
+{
+	struct media_endpoint *endpoint = user_data;
+
+	DBG("");
+
+	switch (new_state) {
+	case HEADSET_STATE_DISCONNECTED:
+		if (endpoint->transport &&
+			media_transport_get_dev(endpoint->transport) == dev) {
+
+			DBG("Clear endpoint %p", endpoint);
+			clear_configuration(endpoint);
+		}
+		break;
+	case HEADSET_STATE_CONNECTING:
+		set_configuration(endpoint, dev, NULL, 0, headset_setconf_cb,
+								dev, NULL);
+		break;
+	case HEADSET_STATE_CONNECTED:
+		break;
+	case HEADSET_STATE_PLAY_IN_PROGRESS:
+		break;
+	case HEADSET_STATE_PLAYING:
+		break;
+	}
+}
+
+static const char *a2dp_get_name(struct a2dp_sep *sep, void *user_data)
+{
+	struct media_endpoint *endpoint = user_data;
+
+	return endpoint->sender;
+}
+
+static size_t a2dp_get_capabilities(struct a2dp_sep *sep,
+						uint8_t **capabilities,
+						void *user_data)
+{
+	struct media_endpoint *endpoint = user_data;
+
+	*capabilities = endpoint->capabilities;
+	return endpoint->size;
+}
+
+struct a2dp_config_data {
+	guint setup_id;
+	a2dp_endpoint_config_t cb;
+};
+
+struct a2dp_select_data {
+	guint setup_id;
+	a2dp_endpoint_select_t cb;
+};
+
+static void endpoint_select_cb(struct media_endpoint *endpoint,
+					void *ret, int size, void *user_data)
+{
+	struct a2dp_select_data *data = user_data;
+
+	data->cb(endpoint->sep, data->setup_id, ret, size);
+}
+
+static int a2dp_select_configuration(struct a2dp_sep *sep,
+						uint8_t *capabilities,
+						size_t length,
+						guint setup_id,
+						a2dp_endpoint_select_t cb,
+						void *user_data)
+{
+	struct media_endpoint *endpoint = user_data;
+	struct a2dp_select_data *data;
+
+	data = g_new0(struct a2dp_select_data, 1);
+	data->setup_id = setup_id;
+	data->cb = cb;
+
+	if (select_configuration(endpoint, capabilities, length,
+				endpoint_select_cb, data, g_free) == TRUE)
+		return 0;
+
+	g_free(data);
+	return -ENOMEM;
+}
+
+static void endpoint_config_cb(struct media_endpoint *endpoint,
+					void *ret, int size, void *user_data)
+{
+	struct a2dp_config_data *data = user_data;
+
+	data->cb(endpoint->sep, data->setup_id, ret ? TRUE : FALSE);
+}
+
+static int a2dp_set_configuration(struct a2dp_sep *sep,
+						struct audio_device *dev,
+						uint8_t *configuration,
+						size_t length,
+						guint setup_id,
+						a2dp_endpoint_config_t cb,
+						void *user_data)
+{
+	struct media_endpoint *endpoint = user_data;
+	struct a2dp_config_data *data;
+
+	data = g_new0(struct a2dp_config_data, 1);
+	data->setup_id = setup_id;
+	data->cb = cb;
+
+	if (set_configuration(endpoint, dev, configuration, length,
+				endpoint_config_cb, data, g_free) == TRUE)
+		return 0;
+
+	g_free(data);
+	return -ENOMEM;
+}
+
+static void a2dp_clear_configuration(struct a2dp_sep *sep, void *user_data)
+{
+	struct media_endpoint *endpoint = user_data;
+
+	clear_configuration(endpoint);
+}
+
+static void a2dp_set_delay(struct a2dp_sep *sep, uint16_t delay,
+							void *user_data)
+{
+	struct media_endpoint *endpoint = user_data;
+
+	if (endpoint->transport == NULL)
+		return;
+
+	media_transport_update_delay(endpoint->transport, delay);
+}
+
+static struct a2dp_endpoint a2dp_endpoint = {
+	.get_name = a2dp_get_name,
+	.get_capabilities = a2dp_get_capabilities,
+	.select_configuration = a2dp_select_configuration,
+	.set_configuration = a2dp_set_configuration,
+	.clear_configuration = a2dp_clear_configuration,
+	.set_delay = a2dp_set_delay
+};
+
+static void a2dp_destroy_endpoint(void *user_data)
 {
 	struct media_endpoint *endpoint = user_data;
 
-	DBG("");
-
-	switch (new_state) {
-	case HEADSET_STATE_DISCONNECTED:
-		if (endpoint->transport &&
-			media_transport_get_dev(endpoint->transport) == dev) {
-
-			DBG("Clear endpoint %p", endpoint);
-			media_endpoint_clear_configuration(endpoint);
-		}
-		break;
-	case HEADSET_STATE_CONNECTING:
-		media_endpoint_set_configuration(endpoint, dev, NULL, 0,
-						headset_setconf_cb, dev);
-		break;
-	case HEADSET_STATE_CONNECTED:
-		break;
-	case HEADSET_STATE_PLAY_IN_PROGRESS:
-		break;
-	case HEADSET_STATE_PLAYING:
-		break;
+	if (endpoint->transport) {
+		media_transport_destroy(endpoint->transport);
+		endpoint->transport = NULL;
 	}
+
+	endpoint->sep = NULL;
+	release_endpoint(endpoint);
 }
 
 static struct media_endpoint *media_endpoint_create(struct media_adapter *adapter,
@@ -216,13 +589,15 @@ static struct media_endpoint *media_endpoint_create(struct media_adapter *adapte
 	if (strcasecmp(uuid, A2DP_SOURCE_UUID) == 0) {
 		endpoint->sep = a2dp_add_sep(&adapter->src,
 					AVDTP_SEP_TYPE_SOURCE, codec,
-					delay_reporting, endpoint, err);
+					delay_reporting, &a2dp_endpoint,
+					endpoint, a2dp_destroy_endpoint, err);
 		if (endpoint->sep == NULL)
 			goto failed;
 	} else if (strcasecmp(uuid, A2DP_SINK_UUID) == 0) {
 		endpoint->sep = a2dp_add_sep(&adapter->src,
-						AVDTP_SEP_TYPE_SINK, codec,
-						delay_reporting, endpoint, err);
+					AVDTP_SEP_TYPE_SOURCE, codec,
+					delay_reporting, &a2dp_endpoint,
+					endpoint, a2dp_destroy_endpoint, err);
 		if (endpoint->sep == NULL)
 			goto failed;
 	} else if (strcasecmp(uuid, HFP_AG_UUID) == 0 ||
@@ -234,9 +609,8 @@ static struct media_endpoint *media_endpoint_create(struct media_adapter *adapte
 		dev = manager_find_device(NULL, &adapter->src, BDADDR_ANY,
 						AUDIO_HEADSET_INTERFACE, TRUE);
 		if (dev)
-			media_endpoint_set_configuration(endpoint, dev, NULL,
-							0, headset_setconf_cb,
-							dev);
+			set_configuration(endpoint, dev, NULL, 0,
+						headset_setconf_cb, dev, NULL);
 	} else {
 		if (err)
 			*err = -EINVAL;
@@ -285,11 +659,6 @@ static struct media_endpoint *media_adapter_find_endpoint(
 	return NULL;
 }
 
-const char *media_endpoint_get_sender(struct media_endpoint *endpoint)
-{
-	return endpoint->sender;
-}
-
 static int parse_properties(DBusMessageIter *props, const char **uuid,
 				gboolean *delay_reporting, uint8_t *codec,
 				uint8_t **capabilities, int *size)
@@ -414,8 +783,8 @@ static void path_free(void *data)
 {
 	struct media_adapter *adapter = data;
 
-	g_slist_free_full(adapter->endpoints,
-				(GDestroyNotify) media_endpoint_release);
+	while (adapter->endpoints)
+		release_endpoint(adapter->endpoints->data);
 
 	dbus_connection_unref(adapter->conn);
 
@@ -465,239 +834,6 @@ void media_unregister(const char *path)
 	}
 }
 
-size_t media_endpoint_get_capabilities(struct media_endpoint *endpoint,
-					uint8_t **capabilities)
-{
-	*capabilities = endpoint->capabilities;
-	return endpoint->size;
-}
-
-static void endpoint_reply(DBusPendingCall *call, void *user_data)
-{
-	struct media_endpoint *endpoint = user_data;
-	struct endpoint_request *request = endpoint->request;
-	DBusMessage *reply;
-	DBusError err;
-	gboolean value;
-	void *ret = NULL;
-	int size = -1;
-
-	/* steal_reply will always return non-NULL since the callback
-	 * is only called after a reply has been received */
-	reply = dbus_pending_call_steal_reply(call);
-
-	dbus_error_init(&err);
-	if (dbus_set_error_from_message(&err, reply)) {
-		error("Endpoint replied with an error: %s",
-				err.name);
-
-		/* Clear endpoint configuration in case of NO_REPLY error */
-		if (dbus_error_has_name(&err, DBUS_ERROR_NO_REPLY)) {
-			if (request->cb)
-				request->cb(endpoint, NULL, size,
-							request->user_data);
-			media_endpoint_clear_configuration(endpoint);
-			dbus_message_unref(reply);
-			dbus_error_free(&err);
-			return;
-		}
-
-		dbus_error_free(&err);
-		goto done;
-	}
-
-	dbus_error_init(&err);
-	if (dbus_message_is_method_call(request->msg, MEDIA_ENDPOINT_INTERFACE,
-				"SelectConfiguration")) {
-		DBusMessageIter args, array;
-		uint8_t *configuration;
-
-		dbus_message_iter_init(reply, &args);
-
-		dbus_message_iter_recurse(&args, &array);
-
-		dbus_message_iter_get_fixed_array(&array, &configuration, &size);
-
-		ret = configuration;
-		goto done;
-	} else  if (!dbus_message_get_args(reply, &err, DBUS_TYPE_INVALID)) {
-		error("Wrong reply signature: %s", err.message);
-		dbus_error_free(&err);
-		goto done;
-	}
-
-	size = 1;
-	value = TRUE;
-	ret = &value;
-
-done:
-	dbus_message_unref(reply);
-
-	if (request->cb)
-		request->cb(endpoint, ret, size, request->user_data);
-
-	endpoint_request_free(request);
-	endpoint->request = NULL;
-}
-
-static gboolean media_endpoint_async_call(DBusConnection *conn,
-					DBusMessage *msg,
-					struct media_endpoint *endpoint,
-					media_endpoint_cb_t cb,
-					void *user_data)
-{
-	struct endpoint_request *request;
-
-	if (endpoint->request)
-		return FALSE;
-
-	request = g_new0(struct endpoint_request, 1);
-
-	/* Timeout should be less than avdtp request timeout (4 seconds) */
-	if (dbus_connection_send_with_reply(conn, msg, &request->call,
-						REQUEST_TIMEOUT) == FALSE) {
-		error("D-Bus send failed");
-		g_free(request);
-		return FALSE;
-	}
-
-	dbus_pending_call_set_notify(request->call, endpoint_reply, endpoint, NULL);
-
-	request->msg = msg;
-	request->cb = cb;
-	request->user_data = user_data;
-	endpoint->request = request;
-
-	DBG("Calling %s: name = %s path = %s", dbus_message_get_member(msg),
-			dbus_message_get_destination(msg),
-			dbus_message_get_path(msg));
-
-	return TRUE;
-}
-
-gboolean media_endpoint_set_configuration(struct media_endpoint *endpoint,
-					struct audio_device *device,
-					uint8_t *configuration, size_t size,
-					media_endpoint_cb_t cb,
-					void *user_data)
-{
-	DBusConnection *conn;
-	DBusMessage *msg;
-	const char *path;
-	DBusMessageIter iter;
-
-	if (endpoint->transport != NULL || endpoint->request != NULL)
-		return FALSE;
-
-	conn = endpoint->adapter->conn;
-
-	endpoint->transport = media_transport_create(conn, endpoint, device,
-						configuration, size);
-	if (endpoint->transport == NULL)
-		return FALSE;
-
-	msg = dbus_message_new_method_call(endpoint->sender, endpoint->path,
-						MEDIA_ENDPOINT_INTERFACE,
-						"SetConfiguration");
-	if (msg == NULL) {
-		error("Couldn't allocate D-Bus message");
-		return FALSE;
-	}
-
-	dbus_message_iter_init_append(msg, &iter);
-
-	path = media_transport_get_path(endpoint->transport);
-	dbus_message_iter_append_basic(&iter, DBUS_TYPE_OBJECT_PATH, &path);
-
-	transport_get_properties(endpoint->transport, &iter);
-
-	return media_endpoint_async_call(conn, msg, endpoint, cb, user_data);
-}
-
-gboolean media_endpoint_select_configuration(struct media_endpoint *endpoint,
-						uint8_t *capabilities,
-						size_t length,
-						media_endpoint_cb_t cb,
-						void *user_data)
-{
-	DBusConnection *conn;
-	DBusMessage *msg;
-
-	if (endpoint->request != NULL)
-		return FALSE;
-
-	conn = endpoint->adapter->conn;
-
-	msg = dbus_message_new_method_call(endpoint->sender, endpoint->path,
-						MEDIA_ENDPOINT_INTERFACE,
-						"SelectConfiguration");
-	if (msg == NULL) {
-		error("Couldn't allocate D-Bus message");
-		return FALSE;
-	}
-
-	dbus_message_append_args(msg, DBUS_TYPE_ARRAY, DBUS_TYPE_BYTE,
-					&capabilities, length,
-					DBUS_TYPE_INVALID);
-
-	return media_endpoint_async_call(conn, msg, endpoint, cb, user_data);
-}
-
-void media_endpoint_clear_configuration(struct media_endpoint *endpoint)
-{
-	DBusConnection *conn;
-	DBusMessage *msg;
-	const char *path;
-	struct media_transport *transport = endpoint->transport;
-
-	if (endpoint->transport == NULL)
-		return;
-
-	if (endpoint->request)
-		media_endpoint_cancel(endpoint);
-
-	conn = endpoint->adapter->conn;
-
-	msg = dbus_message_new_method_call(endpoint->sender, endpoint->path,
-						MEDIA_ENDPOINT_INTERFACE,
-						"ClearConfiguration");
-	if (msg == NULL) {
-		error("Couldn't allocate D-Bus message");
-		goto done;
-	}
-
-	path = media_transport_get_path(endpoint->transport);
-	dbus_message_append_args(msg, DBUS_TYPE_OBJECT_PATH, &path,
-							DBUS_TYPE_INVALID);
-	g_dbus_send_message(conn, msg);
-done:
-	endpoint->transport = NULL;
-	media_transport_destroy(transport);
-}
-
-void media_endpoint_release(struct media_endpoint *endpoint)
-{
-	DBusMessage *msg;
-
-	DBG("sender=%s path=%s", endpoint->sender, endpoint->path);
-
-	/* already exit */
-	if (endpoint->watch == 0)
-		return;
-
-	msg = dbus_message_new_method_call(endpoint->sender, endpoint->path,
-						MEDIA_ENDPOINT_INTERFACE,
-						"Release");
-	if (msg == NULL) {
-		error("Couldn't allocate D-Bus message");
-		return;
-	}
-
-	g_dbus_send_message(endpoint->adapter->conn, msg);
-
-	media_endpoint_remove(endpoint);
-}
-
 struct a2dp_sep *media_endpoint_get_sep(struct media_endpoint *endpoint)
 {
 	return endpoint->sep;
@@ -712,9 +848,3 @@ uint8_t media_endpoint_get_codec(struct media_endpoint *endpoint)
 {
 	return endpoint->codec;
 }
-
-struct media_transport *media_endpoint_get_transport(
-					struct media_endpoint *endpoint)
-{
-	return endpoint->transport;
-}
diff --git a/audio/media.h b/audio/media.h
index d089103..ee9a51e 100644
--- a/audio/media.h
+++ b/audio/media.h
@@ -30,23 +30,6 @@ typedef void (*media_endpoint_cb_t) (struct media_endpoint *endpoint,
 int media_register(DBusConnection *conn, const char *path, const bdaddr_t *src);
 void media_unregister(const char *path);
 
-const char *media_endpoint_get_sender(struct media_endpoint *endpoint);
-
-size_t media_endpoint_get_capabilities(struct media_endpoint *endpoint,
-					uint8_t **capabilities);
-gboolean media_endpoint_set_configuration(struct media_endpoint *endpoint,
-					struct audio_device *device,
-					uint8_t *configuration, size_t size,
-					media_endpoint_cb_t cb,
-					void *user_data);
-gboolean media_endpoint_select_configuration(struct media_endpoint *endpoint,
-						uint8_t *capabilities,
-						size_t length,
-						media_endpoint_cb_t cb,
-						void *user_data);
-void media_endpoint_clear_configuration(struct media_endpoint *endpoint);
-void media_endpoint_release(struct media_endpoint *endpoint);
-
 struct a2dp_sep *media_endpoint_get_sep(struct media_endpoint *endpoint);
 const char *media_endpoint_get_uuid(struct media_endpoint *endpoint);
 uint8_t media_endpoint_get_codec(struct media_endpoint *endpoint);
diff --git a/audio/transport.c b/audio/transport.c
index cd2de37..f915262 100644
--- a/audio/transport.c
+++ b/audio/transport.c
@@ -99,7 +99,6 @@ void media_transport_destroy(struct media_transport *transport)
 	char *path;
 
 	path = g_strdup(transport->path);
-
 	g_dbus_unregister_interface(transport->conn, path,
 						MEDIA_TRANSPORT_INTERFACE);
 
@@ -922,4 +921,4 @@ void media_transport_update_delay(struct media_transport *transport,
 struct audio_device *media_transport_get_dev(struct media_transport *transport)
 {
 	return transport->device;
-}
\ No newline at end of file
+}
-- 
1.7.6

