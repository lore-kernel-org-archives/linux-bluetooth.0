Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 11/20] audio/A2DP: Remove dependency on struct audio_device
Date: Mon,  8 Jul 2013 17:10:17 +0300
Message-Id: <1373292626-3776-12-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1373292626-3776-1-git-send-email-luiz.dentz@gmail.com>
References: <1373292626-3776-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This is part of the work necessary to completely remove
struct audio_device
---
 profiles/audio/a2dp.c      | 111 ++++++++++++++++++++-------------------------
 profiles/audio/a2dp.h      |   4 +-
 profiles/audio/media.c     |  27 +++++------
 profiles/audio/sink.c      |  11 ++---
 profiles/audio/source.c    |  10 ++--
 profiles/audio/transport.c | 109 ++++++++++++++++++++++++++++----------------
 profiles/audio/transport.h |   4 +-
 7 files changed, 148 insertions(+), 128 deletions(-)

diff --git a/profiles/audio/a2dp.c b/profiles/audio/a2dp.c
index e89be07..8db43f9 100644
--- a/profiles/audio/a2dp.c
+++ b/profiles/audio/a2dp.c
@@ -37,10 +37,12 @@
 #include <bluetooth/sdp.h>
 #include <bluetooth/sdp_lib.h>
 
-#include "../src/adapter.h"
+#include "lib/uuid.h"
+#include "src/adapter.h"
+#include "src/device.h"
+#include "src/service.h"
 
 #include "log.h"
-#include "device.h"
 #include "manager.h"
 #include "avdtp.h"
 #include "sink.h"
@@ -83,7 +85,6 @@ struct a2dp_setup_cb {
 };
 
 struct a2dp_setup {
-	struct audio_device *dev;
 	struct avdtp *session;
 	struct a2dp_sep *sep;
 	struct avdtp_remote_sep *rsep;
@@ -120,25 +121,12 @@ static struct a2dp_setup *setup_ref(struct a2dp_setup *setup)
 	return setup;
 }
 
-static struct audio_device *a2dp_get_dev(struct avdtp *session)
-{
-	return manager_get_audio_device(avdtp_get_device(session), FALSE);
-}
-
 static struct a2dp_setup *setup_new(struct avdtp *session)
 {
-	struct audio_device *dev;
 	struct a2dp_setup *setup;
 
-	dev = a2dp_get_dev(session);
-	if (!dev) {
-		error("Unable to create setup");
-		return NULL;
-	}
-
 	setup = g_new0(struct a2dp_setup, 1);
 	setup->session = avdtp_ref(session);
-	setup->dev = a2dp_get_dev(session);
 	setups = g_slist_append(setups, setup);
 
 	return setup;
@@ -322,20 +310,6 @@ static struct a2dp_setup *a2dp_setup_get(struct avdtp *session)
 	return setup_ref(setup);
 }
 
-static struct a2dp_setup *find_setup_by_dev(struct audio_device *dev)
-{
-	GSList *l;
-
-	for (l = setups; l != NULL; l = l->next) {
-		struct a2dp_setup *setup = l->data;
-
-		if (setup->dev == dev)
-			return setup;
-	}
-
-	return NULL;
-}
-
 static struct a2dp_setup *find_setup_by_stream(struct avdtp_stream *stream)
 {
 	GSList *l;
@@ -403,7 +377,8 @@ static void stream_state_changed(struct avdtp_stream *stream,
 static gboolean auto_config(gpointer data)
 {
 	struct a2dp_setup *setup = data;
-	struct audio_device *dev = setup->dev;
+	struct btd_device *dev = avdtp_get_device(setup->session);
+	struct btd_service *service;
 
 	/* Check if configuration was aborted */
 	if (setup->sep->stream == NULL)
@@ -415,10 +390,13 @@ static gboolean auto_config(gpointer data)
 	avdtp_stream_add_cb(setup->session, setup->stream,
 				stream_state_changed, setup->sep);
 
-	if (setup->sep->type == AVDTP_SEP_TYPE_SOURCE)
-		sink_new_stream(dev->sink, setup->session, setup->stream);
-	else
-		source_new_stream(dev->source, setup->session, setup->stream);
+	if (setup->sep->type == AVDTP_SEP_TYPE_SOURCE) {
+		service = btd_device_get_service(dev, A2DP_SINK_UUID);
+		sink_new_stream(service, setup->session, setup->stream);
+	} else {
+		service = btd_device_get_service(dev, A2DP_SOURCE_UUID);
+		source_new_stream(service, setup->session, setup->stream);
+	}
 
 done:
 	if (setup->setconf_cb)
@@ -497,7 +475,7 @@ static gboolean endpoint_setconf_ind(struct avdtp *session,
 		}
 
 		ret = a2dp_sep->endpoint->set_configuration(a2dp_sep,
-						setup->dev, codec->data,
+						codec->data,
 						cap->length - sizeof(*codec),
 						setup,
 						endpoint_setconf_cb,
@@ -588,7 +566,8 @@ static void setconf_cfm(struct avdtp *session, struct avdtp_local_sep *sep,
 {
 	struct a2dp_sep *a2dp_sep = user_data;
 	struct a2dp_setup *setup;
-	struct audio_device *dev;
+	struct btd_device *dev;
+	struct btd_service *service;
 	int ret;
 
 	if (a2dp_sep->type == AVDTP_SEP_TYPE_SINK)
@@ -615,13 +594,16 @@ static void setconf_cfm(struct avdtp *session, struct avdtp_local_sep *sep,
 	if (!setup)
 		return;
 
-	dev = a2dp_get_dev(session);
+	dev = avdtp_get_device(session);
 
 	/* Notify D-Bus interface of the new stream */
-	if (a2dp_sep->type == AVDTP_SEP_TYPE_SOURCE)
-		sink_new_stream(dev->sink, session, setup->stream);
-	else
-		source_new_stream(dev->source, session, setup->stream);
+	if (a2dp_sep->type == AVDTP_SEP_TYPE_SOURCE) {
+		service = btd_device_get_service(dev, A2DP_SINK_UUID);
+		sink_new_stream(service, session, setup->stream);
+	} else {
+		service = btd_device_get_service(dev, A2DP_SOURCE_UUID);
+		source_new_stream(service, session, setup->stream);
+	}
 
 	/* Notify Endpoint */
 	if (a2dp_sep->endpoint) {
@@ -632,7 +614,7 @@ static void setconf_cfm(struct avdtp *session, struct avdtp_local_sep *sep,
 		service = avdtp_stream_get_codec(stream);
 		codec = (struct avdtp_media_codec_capability *) service->data;
 
-		err = a2dp_sep->endpoint->set_configuration(a2dp_sep, dev,
+		err = a2dp_sep->endpoint->set_configuration(a2dp_sep,
 						codec->data, service->length -
 						sizeof(*codec),
 						setup,
@@ -1839,32 +1821,31 @@ failed:
 	return 0;
 }
 
-gboolean a2dp_cancel(struct audio_device *dev, unsigned int id)
+gboolean a2dp_cancel(unsigned int id)
 {
-	struct a2dp_setup *setup;
-	GSList *l;
+	GSList *ls;
 
-	setup = find_setup_by_dev(dev);
-	if (!setup)
-		return FALSE;
+	for (ls = setups; ls != NULL; ls = g_slist_next(ls)) {
+		struct a2dp_setup *setup = ls->data;
+		GSList *l;
+		for (l = setup->cb; l != NULL; l = g_slist_next(l)) {
+			struct a2dp_setup_cb *cb = l->data;
 
-	for (l = setup->cb; l != NULL; l = g_slist_next(l)) {
-		struct a2dp_setup_cb *cb = l->data;
+			if (cb->id != id)
+				continue;
 
-		if (cb->id != id)
-			continue;
+			setup_ref(setup);
+			setup_cb_free(cb);
 
-		setup_ref(setup);
-		setup_cb_free(cb);
+			if (!setup->cb) {
+				DBG("aborting setup %p", setup);
+				avdtp_abort(setup->session, setup->stream);
+				return TRUE;
+			}
 
-		if (!setup->cb) {
-			DBG("aborting setup %p", setup);
-			avdtp_abort(setup->session, setup->stream);
+			setup_unref(setup);
 			return TRUE;
 		}
-
-		setup_unref(setup);
-		return TRUE;
 	}
 
 	return FALSE;
@@ -1926,3 +1907,11 @@ struct avdtp_stream *a2dp_sep_get_stream(struct a2dp_sep *sep)
 {
 	return sep->stream;
 }
+
+struct btd_device *a2dp_setup_get_device(struct a2dp_setup *setup)
+{
+	if (setup->session == NULL)
+		return NULL;
+
+	return avdtp_get_device(setup->session);
+}
diff --git a/profiles/audio/a2dp.h b/profiles/audio/a2dp.h
index 4819f7b..2c06f74 100644
--- a/profiles/audio/a2dp.h
+++ b/profiles/audio/a2dp.h
@@ -42,7 +42,6 @@ struct a2dp_endpoint {
 						a2dp_endpoint_select_t cb,
 						void *user_data);
 	int (*set_configuration) (struct a2dp_sep *sep,
-						struct audio_device *dev,
 						uint8_t *configuration,
 						size_t length,
 						struct a2dp_setup *setup,
@@ -87,8 +86,9 @@ unsigned int a2dp_resume(struct avdtp *session, struct a2dp_sep *sep,
 				a2dp_stream_cb_t cb, void *user_data);
 unsigned int a2dp_suspend(struct avdtp *session, struct a2dp_sep *sep,
 				a2dp_stream_cb_t cb, void *user_data);
-gboolean a2dp_cancel(struct audio_device *dev, unsigned int id);
+gboolean a2dp_cancel(unsigned int id);
 
 gboolean a2dp_sep_lock(struct a2dp_sep *sep, struct avdtp *session);
 gboolean a2dp_sep_unlock(struct a2dp_sep *sep, struct avdtp *session);
 struct avdtp_stream *a2dp_sep_get_stream(struct a2dp_sep *sep);
+struct btd_device *a2dp_setup_get_device(struct a2dp_setup *setup);
diff --git a/profiles/audio/media.c b/profiles/audio/media.c
index 6fe5e04..bb6323d 100644
--- a/profiles/audio/media.c
+++ b/profiles/audio/media.c
@@ -380,9 +380,9 @@ static int transport_device_cmp(gconstpointer data, gconstpointer user_data)
 {
 	struct media_transport *transport = (struct media_transport *) data;
 	const struct btd_device *device = user_data;
-	const struct audio_device *dev = media_transport_get_dev(transport);
+	const struct btd_device *dev = media_transport_get_dev(transport);
 
-	if (device == dev->btd_dev)
+	if (device == dev)
 		return 0;
 
 	return -1;
@@ -402,20 +402,26 @@ static struct media_transport *find_device_transport(
 	return match->data;
 }
 
+struct a2dp_config_data {
+	struct a2dp_setup *setup;
+	a2dp_endpoint_config_t cb;
+};
+
 static gboolean set_configuration(struct media_endpoint *endpoint,
-					struct audio_device *device,
 					uint8_t *configuration, size_t size,
 					media_endpoint_cb_t cb,
 					void *user_data,
 					GDestroyNotify destroy)
 {
+	struct a2dp_config_data *data = user_data;
+	struct btd_device *device = a2dp_setup_get_device(data->setup);
 	DBusConnection *conn = btd_get_dbus_connection();
 	DBusMessage *msg;
 	const char *path;
 	DBusMessageIter iter;
 	struct media_transport *transport;
 
-	transport = find_device_transport(endpoint, device->btd_dev);
+	transport = find_device_transport(endpoint, device);
 
 	if (transport != NULL)
 		return FALSE;
@@ -488,11 +494,6 @@ static size_t get_capabilities(struct a2dp_sep *sep, uint8_t **capabilities,
 	return endpoint->size;
 }
 
-struct a2dp_config_data {
-	struct a2dp_setup *setup;
-	a2dp_endpoint_config_t cb;
-};
-
 struct a2dp_select_data {
 	struct a2dp_setup *setup;
 	a2dp_endpoint_select_t cb;
@@ -533,8 +534,8 @@ static void config_cb(struct media_endpoint *endpoint, void *ret, int size,
 	data->cb(data->setup, ret ? TRUE : FALSE);
 }
 
-static int set_config(struct a2dp_sep *sep, struct audio_device *dev,
-				uint8_t *configuration, size_t length,
+static int set_config(struct a2dp_sep *sep, uint8_t *configuration,
+				size_t length,
 				struct a2dp_setup *setup,
 				a2dp_endpoint_config_t cb,
 				void *user_data)
@@ -546,8 +547,8 @@ static int set_config(struct a2dp_sep *sep, struct audio_device *dev,
 	data->setup = setup;
 	data->cb = cb;
 
-	if (set_configuration(endpoint, dev, configuration, length,
-					config_cb, data, g_free) == TRUE)
+	if (set_configuration(endpoint, configuration, length, config_cb, data,
+							g_free) == TRUE)
 		return 0;
 
 	g_free(data);
diff --git a/profiles/audio/sink.c b/profiles/audio/sink.c
index 9f85cda..898ffea 100644
--- a/profiles/audio/sink.c
+++ b/profiles/audio/sink.c
@@ -154,7 +154,7 @@ static void stream_state_changed(struct avdtp_stream *stream,
 		btd_service_disconnecting_complete(sink->service, 0);
 
 		if (sink->disconnect_id > 0) {
-			a2dp_cancel(sink->dev, sink->disconnect_id);
+			a2dp_cancel(sink->disconnect_id);
 			sink->disconnect_id = 0;
 		}
 
@@ -194,7 +194,7 @@ static gboolean stream_setup_retry(gpointer user_data)
 	}
 
 	if (sink->connect_id > 0) {
-		a2dp_cancel(sink->dev, sink->connect_id);
+		a2dp_cancel(sink->connect_id);
 		sink->connect_id = 0;
 	}
 
@@ -346,13 +346,13 @@ static void sink_free(struct btd_service *service)
 
 	if (sink->connect_id > 0) {
 		btd_service_connecting_complete(sink->service, -ECANCELED);
-		a2dp_cancel(dev, sink->connect_id);
+		a2dp_cancel(sink->connect_id);
 		sink->connect_id = 0;
 	}
 
 	if (sink->disconnect_id > 0) {
 		btd_service_disconnecting_complete(sink->service, -ECANCELED);
-		a2dp_cancel(dev, sink->disconnect_id);
+		a2dp_cancel(sink->disconnect_id);
 		sink->disconnect_id = 0;
 	}
 
@@ -426,7 +426,6 @@ gboolean sink_new_stream(struct btd_service *service, struct avdtp *session,
 int sink_disconnect(struct btd_service *service, gboolean shutdown)
 {
 	struct sink *sink = btd_service_get_user_data(service);
-	struct audio_device *dev = sink->dev;
 
 	if (!sink->session)
 		return -ENOTCONN;
@@ -436,7 +435,7 @@ int sink_disconnect(struct btd_service *service, gboolean shutdown)
 
 	/* cancel pending connect */
 	if (sink->connect_id > 0) {
-		a2dp_cancel(dev, sink->connect_id);
+		a2dp_cancel(sink->connect_id);
 		sink->connect_id = 0;
 		btd_service_connecting_complete(sink->service, -ECANCELED);
 
diff --git a/profiles/audio/source.c b/profiles/audio/source.c
index f9eade5..8430121 100644
--- a/profiles/audio/source.c
+++ b/profiles/audio/source.c
@@ -153,7 +153,7 @@ static void stream_state_changed(struct avdtp_stream *stream,
 		btd_service_disconnecting_complete(source->service, 0);
 
 		if (source->disconnect_id > 0) {
-			a2dp_cancel(source->dev, source->disconnect_id);
+			a2dp_cancel(source->disconnect_id);
 			source->disconnect_id = 0;
 		}
 
@@ -193,7 +193,7 @@ static gboolean stream_setup_retry(gpointer user_data)
 	}
 
 	if (source->connect_id > 0) {
-		a2dp_cancel(source->dev, source->connect_id);
+		a2dp_cancel(source->connect_id);
 		source->connect_id = 0;
 	}
 
@@ -349,13 +349,13 @@ static void source_free(struct btd_service *service)
 
 	if (source->connect_id > 0) {
 		btd_service_connecting_complete(source->service, -ECANCELED);
-		a2dp_cancel(dev, source->connect_id);
+		a2dp_cancel(source->connect_id);
 		source->connect_id = 0;
 	}
 
 	if (source->disconnect_id > 0) {
 		btd_service_disconnecting_complete(source->service, -ECANCELED);
-		a2dp_cancel(dev, source->disconnect_id);
+		a2dp_cancel(source->disconnect_id);
 		source->disconnect_id = 0;
 	}
 
@@ -429,7 +429,7 @@ int source_disconnect(struct btd_service *service, gboolean shutdown)
 
 	/* cancel pending connect */
 	if (source->connect_id > 0) {
-		a2dp_cancel(source->dev, source->connect_id);
+		a2dp_cancel(source->connect_id);
 		source->connect_id = 0;
 		btd_service_connecting_complete(source->service, -ECANCELED);
 
diff --git a/profiles/audio/transport.c b/profiles/audio/transport.c
index c8a806d..8d3d91e 100644
--- a/profiles/audio/transport.c
+++ b/profiles/audio/transport.c
@@ -32,9 +32,9 @@
 #include <gdbus/gdbus.h>
 
 #include "lib/uuid.h"
-#include "../src/adapter.h"
-#include "../src/device.h"
-#include "../src/dbus-common.h"
+#include "src/adapter.h"
+#include "src/device.h"
+#include "src/dbus-common.h"
 
 #include "log.h"
 #include "error.h"
@@ -85,7 +85,7 @@ struct a2dp_transport {
 
 struct media_transport {
 	char			*path;		/* Transport object path */
-	struct audio_device	*device;	/* Transport device */
+	struct btd_device	*device;	/* Transport device */
 	struct media_endpoint	*endpoint;	/* Transport endpoint */
 	struct media_owner	*owner;		/* Transport owner */
 	uint8_t			*configuration; /* Transport configuration */
@@ -332,7 +332,7 @@ static guint resume_a2dp(struct media_transport *transport,
 	guint id;
 
 	if (a2dp->session == NULL) {
-		a2dp->session = avdtp_get(transport->device->btd_dev);
+		a2dp->session = avdtp_get(transport->device);
 		if (a2dp->session == NULL)
 			return 0;
 	}
@@ -396,7 +396,7 @@ static guint suspend_a2dp(struct media_transport *transport,
 
 static void cancel_a2dp(struct media_transport *transport, guint id)
 {
-	a2dp_cancel(transport->device, id);
+	a2dp_cancel(id);
 }
 
 static void media_owner_exit(DBusConnection *connection, void *user_data)
@@ -545,7 +545,7 @@ static gboolean get_device(const GDBusPropertyTable *property,
 					DBusMessageIter *iter, void *data)
 {
 	struct media_transport *transport = data;
-	const char *path = device_get_path(transport->device->btd_dev);
+	const char *path = device_get_path(transport->device);
 
 	dbus_message_iter_append_basic(iter, DBUS_TYPE_OBJECT_PATH, &path);
 
@@ -666,7 +666,7 @@ static void set_volume(const GDBusPropertyTable *property,
 	}
 
 	if (a2dp->volume != volume)
-		avrcp_set_volume(transport->device->btd_dev, volume);
+		avrcp_set_volume(transport->device, volume);
 
 	a2dp->volume = volume;
 
@@ -770,7 +770,57 @@ static void source_state_changed(struct btd_service *service,
 		transport_update_playing(transport, FALSE);
 }
 
-struct media_transport *media_transport_create(struct audio_device *device,
+static int media_transport_init_source(struct media_transport *transport)
+{
+	struct btd_service *service;
+	struct a2dp_transport *a2dp;
+
+	service = btd_device_get_service(transport->device, A2DP_SINK_UUID);
+	if (service == NULL)
+		return -EINVAL;
+
+	a2dp = g_new0(struct a2dp_transport, 1);
+
+	transport->resume = resume_a2dp;
+	transport->suspend = suspend_a2dp;
+	transport->cancel = cancel_a2dp;
+	transport->data = a2dp;
+	transport->destroy = destroy_a2dp;
+
+	a2dp->volume = -1;
+	transport->sink_watch = sink_add_state_cb(service, sink_state_changed,
+								transport);
+
+	return 0;
+}
+
+static int media_transport_init_sink(struct media_transport *transport)
+{
+	struct btd_service *service;
+	struct a2dp_transport *a2dp;
+
+	service = btd_device_get_service(transport->device, A2DP_SOURCE_UUID);
+	if (service == NULL)
+		return -EINVAL;
+
+	a2dp = g_new0(struct a2dp_transport, 1);
+
+	transport->resume = resume_a2dp;
+	transport->suspend = suspend_a2dp;
+	transport->cancel = cancel_a2dp;
+	transport->data = a2dp;
+	transport->destroy = destroy_a2dp;
+
+	a2dp->volume = 127;
+	avrcp_set_volume(transport->device, a2dp->volume);
+	transport->source_watch = source_add_state_cb(service,
+							source_state_changed,
+							transport);
+
+	return 0;
+}
+
+struct media_transport *media_transport_create(struct btd_device *device,
 						uint8_t *configuration,
 						size_t size, void *data)
 {
@@ -785,36 +835,17 @@ struct media_transport *media_transport_create(struct audio_device *device,
 	transport->configuration = g_new(uint8_t, size);
 	memcpy(transport->configuration, configuration, size);
 	transport->size = size;
-	transport->path = g_strdup_printf("%s/fd%d",
-				device_get_path(device->btd_dev), fd++);
+	transport->path = g_strdup_printf("%s/fd%d", device_get_path(device),
+									fd++);
 	transport->fd = -1;
 
 	uuid = media_endpoint_get_uuid(endpoint);
-	if (strcasecmp(uuid, A2DP_SOURCE_UUID) == 0 ||
-			strcasecmp(uuid, A2DP_SINK_UUID) == 0) {
-		struct a2dp_transport *a2dp;
-
-		a2dp = g_new0(struct a2dp_transport, 1);
-
-		transport->resume = resume_a2dp;
-		transport->suspend = suspend_a2dp;
-		transport->cancel = cancel_a2dp;
-		transport->data = a2dp;
-		transport->destroy = destroy_a2dp;
-
-		if (strcasecmp(uuid, A2DP_SOURCE_UUID) == 0) {
-			a2dp->volume = -1;
-			transport->sink_watch = sink_add_state_cb(device->sink,
-							sink_state_changed,
-							transport);
-		} else {
-			a2dp->volume = 127;
-			avrcp_set_volume(device->btd_dev, a2dp->volume);
-			transport->source_watch = source_add_state_cb(
-							device->source,
-							source_state_changed,
-							transport);
-		}
+	if (strcasecmp(uuid, A2DP_SOURCE_UUID) == 0) {
+		if (media_transport_init_source(transport) < 0)
+			goto fail;
+	} else if (strcasecmp(uuid, A2DP_SINK_UUID) == 0) {
+		if (media_transport_init_sink(transport) < 0)
+			goto fail;
 	} else
 		goto fail;
 
@@ -856,7 +887,7 @@ void media_transport_update_delay(struct media_transport *transport,
 					MEDIA_TRANSPORT_INTERFACE, "Delay");
 }
 
-struct audio_device *media_transport_get_dev(struct media_transport *transport)
+struct btd_device *media_transport_get_dev(struct media_transport *transport)
 {
 	return transport->device;
 }
@@ -892,7 +923,7 @@ uint8_t media_transport_get_device_volume(struct btd_device *dev)
 
 	for (l = transports; l; l = l->next) {
 		struct media_transport *transport = l->data;
-		if (transport->device->btd_dev != dev)
+		if (transport->device != dev)
 			continue;
 
 		/* Volume is A2DP only */
@@ -913,7 +944,7 @@ void media_transport_update_device_volume(struct btd_device *dev,
 
 	for (l = transports; l; l = l->next) {
 		struct media_transport *transport = l->data;
-		if (transport->device->btd_dev != dev)
+		if (transport->device != dev)
 			continue;
 
 		/* Volume is A2DP only */
diff --git a/profiles/audio/transport.h b/profiles/audio/transport.h
index 1501bf4..505ad5c 100644
--- a/profiles/audio/transport.h
+++ b/profiles/audio/transport.h
@@ -24,13 +24,13 @@
 
 struct media_transport;
 
-struct media_transport *media_transport_create(struct audio_device *device,
+struct media_transport *media_transport_create(struct btd_device *device,
 						uint8_t *configuration,
 						size_t size, void *data);
 
 void media_transport_destroy(struct media_transport *transport);
 const char *media_transport_get_path(struct media_transport *transport);
-struct audio_device *media_transport_get_dev(struct media_transport *transport);
+struct btd_device *media_transport_get_dev(struct media_transport *transport);
 uint16_t media_transport_get_volume(struct media_transport *transport);
 void media_transport_update_delay(struct media_transport *transport,
 							uint16_t delay);
-- 
1.8.1.4

