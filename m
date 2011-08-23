Return-Path: <cyrus@holtmann.org>
From: Prasad Bhat <prasadbhat22@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 1/2] This is the code refactoring for the vdp and a2dp.
Date: Tue, 23 Aug 2011 07:52:17 -0400
Message-Id: <1314100338-13410-1-git-send-email-prasadbhat22@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Prasad Bhat <prasadbhat22@.gmail.com>

---
 audio/sep.c | 1080 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 audio/sep.h |  207 ++++++++++++
 2 files changed, 1287 insertions(+), 0 deletions(-)
 create mode 100644 audio/sep.c
 create mode 100644 audio/sep.h

diff --git a/audio/sep.c b/audio/sep.c
new file mode 100644
index 0000000..24847cb
--- /dev/null
+++ b/audio/sep.c
@@ -0,0 +1,1080 @@
+#ifdef HAVE_CONFIG_H
+#include <config.h>
+#endif
+
+#include <stdlib.h>
+#include <errno.h>
+
+#include <dbus/dbus.h>
+#include <glib.h>
+
+#include <bluetooth/bluetooth.h>
+#include <bluetooth/sdp.h>
+#include <bluetooth/sdp_lib.h>
+
+#include "log.h"
+#include "device.h"
+#include "manager.h"
+#include "avdtp.h"
+#include "video-sink.h"
+#include "video-source.h"
+#include "unix.h"
+#include "media.h"
+#include "sep.h"
+#include "sdpd.h"
+
+struct avdtp_setup *setup_ref(struct avdtp_setup *setup)
+{
+        setup->ref++;
+
+        DBG("%p: ref=%d", setup, setup->ref);
+
+        return setup;
+}
+
+struct audio_device *get_dev(struct avdtp *session)
+{
+        bdaddr_t src, dst;
+
+        avdtp_get_peers(session, &src, &dst);
+
+        return manager_find_device(NULL, &src, &dst, NULL, FALSE);
+}
+
+struct avdtp_setup *setup_new(struct avdtp *session)
+{
+	struct audio_device *dev;
+	struct avdtp_setup *setup;
+
+	dev = get_dev(session);
+	if (!dev) {
+		error("Unable to create setup");
+		return NULL;
+	}
+
+	setup = g_new0(struct avdtp_setup, 1);
+	setup->session = avdtp_ref(session);
+	setup->dev = get_dev(session);
+	setups = g_slist_append(setups, setup);
+
+	return setup;
+}
+
+static void setup_free(struct avdtp_setup *s)
+{
+	DBG("%p", s);
+
+	setups = g_slist_remove(setups, s);
+	if (s->session)
+		avdtp_unref(s->session);
+	g_slist_foreach(s->cb, (GFunc) g_free, NULL);
+	g_slist_free(s->cb);
+	g_slist_foreach(s->caps, (GFunc) g_free, NULL);
+	g_slist_free(s->caps);
+	g_free(s);
+}
+
+void setup_unref(struct avdtp_setup *setup)
+{
+	setup->ref--;
+
+	DBG("%p: ref=%d", setup, setup->ref);
+
+	if (setup->ref > 0)
+		return;
+
+	setup_free(setup);
+}
+
+struct avdtp_setup_cb *setup_cb_new(struct avdtp_setup *setup)
+{
+        struct avdtp_setup_cb *cb;
+
+        cb = g_new0(struct avdtp_setup_cb, 1);
+        cb->setup = setup;
+        cb->id = ++cb_id;
+
+        setup->cb = g_slist_append(setup->cb, cb);
+        return cb;
+}
+
+void setup_cb_free(struct avdtp_setup_cb *cb)
+{
+	struct avdtp_setup *setup = cb->setup;
+
+	DBG("");
+	
+	if (cb->source_id)
+		g_source_remove(cb->source_id);
+
+	setup->cb = g_slist_remove(setup->cb, cb);
+	setup_unref(cb->setup);
+	g_free(cb);
+}
+
+static void finalize_setup_errno(struct avdtp_setup *s, int err,
+					GSourceFunc cb1, ...)
+{
+	GSourceFunc finalize;
+	va_list args;
+	struct avdtp_error avdtp_err;
+
+	DBG("");
+	
+	if (err < 0) {
+		avdtp_error_init(&avdtp_err, AVDTP_ERRNO, -err);
+		s->err = &avdtp_err;
+	}
+
+	va_start(args, cb1);
+	finalize = cb1;
+	setup_ref(s);
+	while (finalize != NULL) {
+		finalize(s);
+		finalize = va_arg(args, GSourceFunc);
+	}
+	setup_unref(s);
+	va_end(args);
+}
+
+gboolean finalize_config(gpointer data)
+{
+	struct avdtp_setup *s = data;
+	GSList *l;
+	struct avdtp_stream *stream = s->err ? NULL : s->stream;
+
+	DBG("");
+	
+	for (l = s->cb; l != NULL; ) {
+		struct avdtp_setup_cb *cb = l->data;
+
+		l = l->next;
+
+		if (!cb->config_cb)
+			continue;
+
+		cb->config_cb(s->session, s->sep, stream, s->err,
+							cb->user_data);
+		setup_cb_free(cb);
+	}
+
+	return FALSE;
+}
+
+static gboolean finalize_resume(gpointer data)
+{
+        struct avdtp_setup *s = data;
+        GSList *l;
+
+        DBG("");
+
+        for (l = s->cb; l != NULL; ) {
+                struct avdtp_setup_cb *cb = l->data;
+
+                l = l->next;
+
+                if (!cb->resume_cb)
+                        continue;
+
+                cb->resume_cb(s->session, s->err, cb->user_data);
+                setup_cb_free(cb);
+        }
+
+        return FALSE;
+}
+
+static gboolean finalize_suspend(gpointer data)
+{
+        struct avdtp_setup *s = data;
+        GSList *l;
+        
+        DBG("");
+
+        for (l = s->cb; l != NULL; ) {
+                struct avdtp_setup_cb *cb = l->data;
+
+                l = l->next;
+
+                if (!cb->suspend_cb)
+                        continue;
+
+                cb->suspend_cb(s->session, s->err, cb->user_data);
+                setup_cb_free(cb);
+        }
+
+        return FALSE;
+}
+
+struct avdtp_setup *setup_get(struct avdtp *session)
+{
+        struct avdtp_setup *setup;
+
+        setup = find_setup_by_session(session);
+        if (!setup) {
+                setup = setup_new(session);
+                if (!setup)
+                        return NULL;
+        }
+
+        return setup_ref(setup);
+}
+
+struct avdtp_setup *find_setup_by_session(struct avdtp *session)
+{
+        GSList *l;
+
+        for (l = setups; l != NULL; l = l->next) {
+                struct avdtp_setup *setup = l->data;
+
+                if (setup->session == session)
+                        return setup;
+        }
+
+        return NULL;
+}
+
+struct avdtp_setup *find_setup_by_dev(struct audio_device *dev)
+{
+	GSList *l;
+
+	for (l = setups; l != NULL; l = l->next) {
+		struct avdtp_setup *setup = l->data;
+
+		if (setup->dev == dev)
+			return setup;
+	}
+
+	return NULL;
+}
+
+void avdtp_stream_state_changed(struct avdtp_stream *stream,
+					avdtp_state_t old_state,
+					avdtp_state_t new_state,
+					struct avdtp_error *err,
+					void *user_data)
+{
+	struct sep *sep = user_data;
+
+	if (new_state != AVDTP_STATE_IDLE)
+		return;
+
+	if (sep->suspend_timer) {
+		g_source_remove(sep->suspend_timer);
+		sep->suspend_timer = 0;
+	}
+
+	if (sep->session) {
+		avdtp_unref(sep->session);
+		sep->session = NULL;
+	}
+
+	sep->stream = NULL;
+
+	if (sep->endpoint && sep->endpoint->clear_configuration)
+		sep->endpoint->clear_configuration(sep, sep->user_data);
+}
+
+gboolean auto_config(gpointer data)
+{
+        struct avdtp_setup *setup = data;
+        struct avdtp_error *err = NULL;
+
+        DBG("");
+
+        // Check if configuration was aborted 
+        if (setup->sep->stream == NULL)
+                return FALSE;
+
+        if (setup->err != NULL) {
+                err = setup->err;
+                goto done;
+        }
+
+        avdtp_stream_add_cb(setup->session, setup->stream,
+                                avdtp_stream_state_changed, setup->sep);
+
+done:
+        if (setup->setconf_cb)
+                setup->setconf_cb(setup->session, setup->stream, setup->err);
+
+        finalize_config(setup);
+
+        if (err)
+                g_free(err);
+
+        setup_unref(setup);
+
+        return FALSE;
+}
+
+struct avdtp_server *find_server(GSList *list, const bdaddr_t *src)
+{
+
+        for (; list; list = list->next) {
+                struct avdtp_server *server = list->data;
+
+                if (bacmp(&server->src, src) == 0)
+                        return server;
+        }
+        DBG("find server no server found");
+        return NULL;
+}
+
+gboolean sep_get_lock(struct sep *sep)
+{
+	return sep->locked;
+}
+
+static void endpoint_open_cb(struct sep *sep, guint setup_id,
+								gboolean ret)
+{
+	struct avdtp_setup *setup = GUINT_TO_POINTER(setup_id);
+	int err;
+
+	if (ret == FALSE) {
+		setup->stream = NULL;
+		finalize_setup_errno(setup, -EPERM, finalize_config, NULL);
+		return;
+	}
+
+	err = avdtp_open(setup->session, setup->stream);
+	if (err == 0)
+		return;
+
+	error("Error on avdtp_open %s (%d)", strerror(-err), -err);
+	setup->stream = NULL;
+	finalize_setup_errno(setup, err, finalize_config, NULL);
+}
+
+static struct sep *avdtp_find_sep(struct avdtp *session, GSList *list,
+                                        const char *sender)
+{
+	for (; list; list = list->next) {
+		struct sep *sep = list->data;
+
+		/* Use sender's endpoint if available */
+		if (sender) {
+			const char *name;
+
+			if (sep->endpoint == NULL)
+				continue;
+
+			name = sep->endpoint->get_name(sep, sep->user_data);
+			if (g_strcmp0(sender, name) != 0)
+				continue;
+		}
+
+		if (avdtp_find_remote_sep(session, sep->lsep) == NULL)
+			continue;
+
+		return sep;
+	}
+
+	return NULL;
+}
+
+static int stream_cmp(gconstpointer data, gconstpointer user_data)
+{
+	const struct sep *sep = data;
+	const struct avdtp_stream *stream = user_data;
+
+	return (sep->stream != stream);
+}
+
+struct sep *avdtp_get_sep(struct avdtp *session,
+				struct avdtp_stream *stream)
+{
+	struct avdtp_server *server;
+	bdaddr_t src, dst;
+	GSList *l;
+
+	avdtp_get_peers(session, &src, &dst);
+
+	for (l = servers; l; l = l->next) {
+		server = l->data;
+
+		if (bacmp(&src, &server->src) == 0)
+			break;
+	}
+
+	if (!l)
+		return NULL;
+
+	l = g_slist_find_custom(server->sources, stream, stream_cmp);
+	if (l)
+		return l->data;
+
+	l = g_slist_find_custom(server->sinks, stream, stream_cmp);
+	if (l)
+		return l->data;
+
+	return NULL;
+}
+
+struct sep *select_sep(struct avdtp *session, uint8_t type,
+					const char *sender)
+{
+	struct avdtp_server *server;
+	struct sep *sep;
+	GSList *l;
+	bdaddr_t src;
+
+	avdtp_get_peers(session, &src, NULL);
+	server = find_server(servers, &src);
+	if (!server)
+		return NULL;
+
+	l = type == AVDTP_SEP_TYPE_SINK ? server->sources : server->sinks;
+
+	// Check sender's seps first 
+	sep = avdtp_find_sep(session, l, sender);
+	if (sep != NULL)
+		return sep;
+
+	return avdtp_find_sep(session, l, NULL);
+}
+
+void unregister_sep(struct sep *sep)
+{
+	if (sep->destroy) {
+		sep->destroy(sep->user_data);
+		sep->endpoint = NULL;
+	}
+
+	avdtp_unregister_sep(sep->lsep);
+	g_free(sep);
+}
+
+void remove_sep(struct sep *sep)
+{
+	struct avdtp_server *server = sep->server;
+
+	if (sep->type == AVDTP_SEP_TYPE_SOURCE) {
+		if (g_slist_find(server->sources, sep) == NULL)
+			return;
+		server->sources = g_slist_remove(server->sources, sep);
+		if (server->sources == NULL && server->source_record_id) {
+			remove_record_from_server(server->source_record_id);
+			server->source_record_id = 0;
+		}
+	} else {
+		if (g_slist_find(server->sinks, sep) == NULL)
+			return;
+		server->sinks = g_slist_remove(server->sinks, sep);
+		if (server->sinks == NULL && server->sink_record_id) {
+			remove_record_from_server(server->sink_record_id);
+			server->sink_record_id = 0;
+		}
+	}
+
+	if (sep->locked)
+		return;
+
+	unregister_sep(sep);
+}
+
+gboolean endpoint_getcap_ind(struct avdtp *session,
+					struct avdtp_local_sep *sep,
+					gboolean get_all, GSList **caps,
+					uint8_t *err, void *user_data)
+{
+	struct sep *avdtp_sep = user_data;
+	struct avdtp_service_capability *media_transport, *media_codec;
+	struct avdtp_media_codec_capability *codec_caps;
+	uint8_t *capabilities;
+	size_t length;
+
+	if (avdtp_sep->type == AVDTP_SEP_TYPE_SINK)
+		DBG("Sink %p: Get_Capability_Ind", sep);
+	else
+		DBG("Source %p: Get_Capability_Ind", sep);
+
+	*caps = NULL;
+
+	media_transport = avdtp_service_cap_new(AVDTP_MEDIA_TRANSPORT,
+						NULL, 0);
+
+	*caps = g_slist_append(*caps, media_transport);
+
+	length = avdtp_sep->endpoint->get_capabilities(avdtp_sep, &capabilities,
+							avdtp_sep->user_data);
+	codec_caps = g_malloc0(sizeof(*codec_caps) + length);
+	codec_caps->media_type = AVDTP_MEDIA_TYPE_VIDEO;
+	codec_caps->media_codec_type = avdtp_sep->codec;
+	memcpy(codec_caps->data, capabilities, length);
+
+	media_codec = avdtp_service_cap_new(AVDTP_MEDIA_CODEC, codec_caps,
+						sizeof(*codec_caps) + length);
+
+	*caps = g_slist_append(*caps, media_codec);
+	g_free(codec_caps);
+
+	if (get_all) {
+		struct avdtp_service_capability *delay_reporting;
+		delay_reporting = avdtp_service_cap_new(AVDTP_DELAY_REPORTING,
+								NULL, 0);
+		*caps = g_slist_append(*caps, delay_reporting);
+	}
+
+	return TRUE;
+}
+
+static void endpoint_setconf_cb(struct sep *sep, guint setup_id,
+							gboolean ret)
+{
+	struct avdtp_setup *setup = GUINT_TO_POINTER(setup_id);
+
+	if (ret == FALSE) {
+		setup->err = g_new(struct avdtp_error, 1);
+		avdtp_error_init(setup->err, AVDTP_MEDIA_CODEC,
+					AVDTP_UNSUPPORTED_CONFIGURATION);
+	}
+
+	auto_config(setup);
+}
+
+gboolean endpoint_setconf_ind(struct avdtp *session,
+						struct avdtp_local_sep *sep,
+						struct avdtp_stream *stream,
+						GSList *caps,
+						avdtp_set_configuration_cb cb,
+						void *user_data)
+{
+	struct sep *avdtp_sep = user_data;
+	struct avdtp_setup *setup;
+
+	if (avdtp_sep->type == AVDTP_SEP_TYPE_SINK)
+		DBG("Sink %p: Set_Configuration_Ind", sep);
+	else
+		DBG("Source %p: Set_Configuration_Ind", sep);
+
+	setup = setup_get(session);
+	if (!session)
+		return FALSE;
+
+	avdtp_sep->stream = stream;
+	setup->sep = avdtp_sep;
+	setup->stream = stream;
+	setup->setconf_cb = cb;
+
+	for (; caps != NULL; caps = g_slist_next(caps)) {
+		struct avdtp_service_capability *cap = caps->data;
+		struct avdtp_media_codec_capability *codec;
+		gboolean ret;
+
+		if (cap->category == AVDTP_DELAY_REPORTING &&
+					!avdtp_sep->delay_reporting) {
+			setup->err = g_new(struct avdtp_error, 1);
+			avdtp_error_init(setup->err, AVDTP_DELAY_REPORTING,
+					AVDTP_UNSUPPORTED_CONFIGURATION);
+			goto done;
+		}
+
+		if (cap->category != AVDTP_MEDIA_CODEC)
+			continue;
+
+		codec = (struct avdtp_media_codec_capability *) cap->data;
+
+		if (codec->media_codec_type != avdtp_sep->codec) {
+			setup->err = g_new(struct avdtp_error, 1);
+			avdtp_error_init(setup->err, AVDTP_MEDIA_CODEC,
+					AVDTP_UNSUPPORTED_CONFIGURATION);
+			goto done;
+		}
+
+		ret = avdtp_sep->endpoint->set_configuration(avdtp_sep,
+						setup->dev, codec->data,
+						cap->length - sizeof(*codec),
+						GPOINTER_TO_UINT(setup),
+						endpoint_setconf_cb,
+						avdtp_sep->user_data);
+		if (ret == 0)
+			return TRUE;
+
+		avdtp_error_init(setup->err, AVDTP_MEDIA_CODEC,
+					AVDTP_UNSUPPORTED_CONFIGURATION);
+		break;
+	}
+
+done:
+	g_idle_add(auto_config, setup);
+	return TRUE;
+}
+
+gboolean getconf_ind(struct avdtp *session, struct avdtp_local_sep *sep,
+				uint8_t *err, void *user_data)
+{
+	struct sep *avdtp_sep = user_data;
+
+	if (avdtp_sep->type == AVDTP_SEP_TYPE_SINK)
+		DBG("Sink %p: Get_Configuration_Ind", sep);
+	else
+		DBG("Source %p: Get_Configuration_Ind", sep);
+	return TRUE;
+}
+
+gboolean open_ind(struct avdtp *session, struct avdtp_local_sep *sep,
+				struct avdtp_stream *stream, uint8_t *err,
+				void *user_data)
+{
+	struct sep *avdtp_sep = user_data;
+
+	if (avdtp_sep->type == AVDTP_SEP_TYPE_SINK)
+		DBG("Sink %p: Open_Ind", sep);
+	else
+		DBG("Source %p: Open_Ind", sep);
+	return TRUE;
+}
+
+static gboolean suspend_timeout(struct sep *sep)
+{
+	if (avdtp_suspend(sep->session, sep->stream) == 0)
+		sep->suspending = TRUE;
+
+	sep->suspend_timer = 0;
+
+	avdtp_unref(sep->session);
+	sep->session = NULL;
+
+	return FALSE;
+}
+
+
+gboolean start_ind(struct avdtp *session, struct avdtp_local_sep *sep,
+				struct avdtp_stream *stream, uint8_t *err,
+				void *user_data)
+{
+	struct sep *avdtp_sep = user_data;
+	struct avdtp_setup *setup;
+
+	if (avdtp_sep->type == AVDTP_SEP_TYPE_SINK)
+		DBG("Sink %p: Start_Ind", sep);
+	else
+		DBG("Source %p: Start_Ind", sep);
+
+	setup = find_setup_by_session(session);
+	if (setup)
+		finalize_resume(setup);
+
+	if (!avdtp_sep->locked) {
+		avdtp_sep->session = avdtp_ref(session);
+		avdtp_sep->suspend_timer = g_timeout_add_seconds(SUSPEND_TIMEOUT,
+						(GSourceFunc) suspend_timeout,
+						avdtp_sep);
+	}
+
+	return TRUE;
+}
+
+gboolean suspend_ind(struct avdtp *session, struct avdtp_local_sep *sep,
+				struct avdtp_stream *stream, uint8_t *err,
+				void *user_data)
+{
+	struct sep *avdtp_sep = user_data;
+
+	if (avdtp_sep->type == AVDTP_SEP_TYPE_SINK)
+		DBG("Sink %p: Suspend_Ind", sep);
+	else
+		DBG("Source %p: Suspend_Ind", sep);
+
+	if (avdtp_sep->suspend_timer) {
+		g_source_remove(avdtp_sep->suspend_timer);
+		avdtp_sep->suspend_timer = 0;
+		avdtp_unref(avdtp_sep->session);
+		avdtp_sep->session = NULL;
+	}
+
+	return TRUE;
+}
+
+
+gboolean close_ind(struct avdtp *session, struct avdtp_local_sep *sep,
+				struct avdtp_stream *stream, uint8_t *err,
+				void *user_data)
+{
+	struct sep *avdtp_sep = user_data;
+	struct avdtp_setup *setup;
+
+	if (avdtp_sep->type == AVDTP_SEP_TYPE_SINK)
+		DBG("Sink %p: Close_Ind", sep);
+	else
+		DBG("Source %p: Close_Ind", sep);
+
+	setup = find_setup_by_session(session);
+	if (!setup)
+		return TRUE;
+
+	finalize_setup_errno(setup, -ECONNRESET, finalize_suspend,
+							finalize_resume, NULL);
+
+	return TRUE;
+}
+
+gboolean abort_ind(struct avdtp *session, struct avdtp_local_sep *sep,
+				struct avdtp_stream *stream, uint8_t *err,
+				void *user_data)
+{
+	struct sep *avdtp_sep = user_data;
+
+	if (avdtp_sep->type == AVDTP_SEP_TYPE_SINK)
+		DBG("Sink %p: Abort_Ind", sep);
+	else
+		DBG("Source %p: Abort_Ind", sep);
+
+	avdtp_sep->stream = NULL;
+
+	return TRUE;
+}
+
+gboolean reconf_ind(struct avdtp *session, struct avdtp_local_sep *sep,
+				uint8_t *err, void *user_data)
+{
+	struct sep *avdtp_sep = user_data;
+
+	if (avdtp_sep->type == AVDTP_SEP_TYPE_SINK)
+		DBG("Sink %p: ReConfigure_Ind", sep);
+	else
+		DBG("Source %p: ReConfigure_Ind", sep);
+
+	return TRUE;
+}
+
+gboolean delayreport_ind(struct avdtp *session,
+				struct avdtp_local_sep *sep,
+				uint8_t rseid, uint16_t delay,
+				uint8_t *err, void *user_data)
+{
+	struct sep *avdtp_sep = user_data;
+	struct audio_device *dev = get_dev(session);
+
+	if (avdtp_sep->type == AVDTP_SEP_TYPE_SINK)
+		DBG("Sink %p: DelayReport_Ind", sep);
+	else
+		DBG("Source %p: DelayReport_Ind", sep);
+
+	unix_delay_report(dev, rseid, delay);
+
+	return TRUE;
+}
+
+gboolean endpoint_delayreport_ind(struct avdtp *session,
+						struct avdtp_local_sep *sep,
+						uint8_t rseid, uint16_t delay,
+						uint8_t *err, void *user_data)
+{
+	struct sep *avdtp_sep = user_data;
+
+	if (avdtp_sep->type == AVDTP_SEP_TYPE_SINK)
+		DBG("Sink %p: DelayReport_Ind", sep);
+	else
+		DBG("Source %p: DelayReport_Ind", sep);
+
+	if (avdtp_sep->endpoint == NULL ||
+				avdtp_sep->endpoint->set_delay == NULL)
+		return FALSE;
+
+	avdtp_sep->endpoint->set_delay(avdtp_sep, delay, avdtp_sep->user_data);
+
+	return TRUE;
+}
+
+
+void getconf_cfm(struct avdtp *session, struct avdtp_local_sep *sep,
+			struct avdtp_stream *stream, struct avdtp_error *err,
+			void *user_data)
+{
+	struct sep *avdtp_sep = user_data;
+
+	if (avdtp_sep->type == AVDTP_SEP_TYPE_SINK)
+		DBG("Sink %p: Set_Configuration_Cfm", sep);
+	else
+		DBG("Source %p: Set_Configuration_Cfm", sep);
+}
+
+void open_cfm(struct avdtp *session, struct avdtp_local_sep *sep,
+			struct avdtp_stream *stream, struct avdtp_error *err,
+			void *user_data)
+{
+	struct sep *avdtp_sep = user_data;
+	struct avdtp_setup *setup;
+
+	if (avdtp_sep->type == AVDTP_SEP_TYPE_SINK)
+		DBG("Sink %p: Open_Cfm", sep);
+	else
+		DBG("Source %p: Open_Cfm", sep);
+
+	setup = find_setup_by_session(session);
+	if (!setup)
+		return;
+
+	if (setup->reconfigure)
+		setup->reconfigure = FALSE;
+
+	if (err) {
+		setup->stream = NULL;
+		setup->err = err;
+	}
+
+	finalize_config(setup);
+}
+
+void start_cfm(struct avdtp *session, struct avdtp_local_sep *sep,
+			struct avdtp_stream *stream, struct avdtp_error *err,
+			void *user_data)
+{
+	struct sep *avdtp_sep = user_data;
+	struct avdtp_setup *setup;
+
+	if (avdtp_sep->type == AVDTP_SEP_TYPE_SINK)
+		DBG("Sink %p: Start_Cfm", sep);
+	else
+		DBG("Source %p: Start_Cfm", sep);
+
+	setup = find_setup_by_session(session);
+	if (!setup)
+		return;
+
+	if (err) {
+		setup->stream = NULL;
+		setup->err = err;
+	}
+
+	finalize_resume(setup);
+}
+
+void suspend_cfm(struct avdtp *session, struct avdtp_local_sep *sep,
+			struct avdtp_stream *stream, struct avdtp_error *err,
+			void *user_data)
+{
+	struct sep *avdtp_sep = user_data;
+	struct avdtp_setup *setup;
+	gboolean start;
+	int perr;
+
+	if (avdtp_sep->type == AVDTP_SEP_TYPE_SINK)
+		DBG("Sink %p: Suspend_Cfm", sep);
+	else
+		DBG("Source %p: Suspend_Cfm", sep);
+
+	avdtp_sep->suspending = FALSE;
+
+	setup = find_setup_by_session(session);
+	if (!setup)
+		return;
+
+	start = setup->start;
+	setup->start = FALSE;
+
+	if (err) {
+		setup->stream = NULL;
+		setup->err = err;
+	}
+
+	finalize_suspend(setup);
+
+	if (!start)
+		return;
+
+	if (err) {
+		finalize_resume(setup);
+		return;
+	}
+
+	perr = avdtp_start(session, avdtp_sep->stream);
+	if (perr < 0) {
+		error("Error on avdtp_start %s (%d)", strerror(-perr), -perr);
+		finalize_setup_errno(setup, -EIO, finalize_suspend, NULL);
+	}
+}
+
+static gboolean vdp_reconfigure(gpointer data)
+{
+	struct avdtp_setup *setup = data;
+	struct sep *sep = setup->sep;
+	int posix_err;
+	struct avdtp_media_codec_capability *rsep_codec;
+	struct avdtp_service_capability *cap;
+
+	if (setup->rsep) {
+		cap = avdtp_get_codec(setup->rsep);
+		rsep_codec = (struct avdtp_media_codec_capability *) cap->data;
+	}
+
+	if (!setup->rsep || sep->codec != rsep_codec->media_codec_type)
+		setup->rsep = avdtp_find_remote_sep(setup->session, sep->lsep);
+
+	posix_err = avdtp_set_configuration(setup->session, setup->rsep,
+						sep->lsep,
+						setup->caps,
+						&setup->stream);
+	if (posix_err < 0) {
+		error("avdtp_set_configuration: %s", strerror(-posix_err));
+		goto failed;
+	}
+
+	return FALSE;
+
+failed:
+	finalize_setup_errno(setup, posix_err, finalize_config, NULL);
+	return FALSE;
+}
+
+void close_cfm(struct avdtp *session, struct avdtp_local_sep *sep,
+			struct avdtp_stream *stream, struct avdtp_error *err,
+			void *user_data)
+{
+	struct sep *avdtp_sep = user_data;
+	struct avdtp_setup *setup;
+
+	if (avdtp_sep->type == AVDTP_SEP_TYPE_SINK)
+		DBG("Sink %p: Close_Cfm", sep);
+	else
+		DBG("Source %p: Close_Cfm", sep);
+
+	setup = find_setup_by_session(session);
+	if (!setup)
+		return;
+
+	if (err) {
+		setup->stream = NULL;
+		setup->err = err;
+		finalize_config(setup);
+		return;
+	}
+
+	if (!setup->rsep)
+		setup->rsep = avdtp_stream_get_remote_sep(stream);
+
+	if (setup->reconfigure)
+		g_timeout_add(RECONFIGURE_TIMEOUT, vdp_reconfigure, setup);
+}
+
+void abort_cfm(struct avdtp *session, struct avdtp_local_sep *sep,
+			struct avdtp_stream *stream, struct avdtp_error *err,
+			void *user_data)
+{
+	struct sep *avdtp_sep = user_data;
+	struct avdtp_setup *setup;
+
+	DBG("");
+	
+	if (avdtp_sep->type == AVDTP_SEP_TYPE_SINK)
+		DBG("Sink %p: Abort_Cfm", sep);
+	else
+		DBG("Source %p: Abort_Cfm", sep);
+
+	setup = find_setup_by_session(session);
+	if (!setup)
+		return;
+
+	setup_unref(setup);
+}
+
+void reconf_cfm(struct avdtp *session, struct avdtp_local_sep *sep,
+			struct avdtp_stream *stream, struct avdtp_error *err,
+			void *user_data)
+{
+	struct sep *avdtp_sep = user_data;
+	struct avdtp_setup *setup;
+
+	if (avdtp_sep->type == AVDTP_SEP_TYPE_SINK)
+		DBG("Sink %p: ReConfigure_Cfm", sep);
+	else
+		DBG("Source %p: ReConfigure_Cfm", sep);
+
+	setup = find_setup_by_session(session);
+	if (!setup)
+		return;
+
+	if (err) {
+		setup->stream = NULL;
+		setup->err = err;
+	}
+
+	finalize_config(setup);
+}
+
+void delay_report_cfm(struct avdtp *session, struct avdtp_local_sep *sep,
+				struct avdtp_stream *stream,
+				struct avdtp_error *err, void *user_data)
+{
+	struct sep *avdtp_sep = user_data;
+
+	if (avdtp_sep->type == AVDTP_SEP_TYPE_SINK)
+		DBG("Sink %p: DelayReport_Cfm", sep);
+	else
+		DBG("Source %p: DelayReport_Cfm", sep);
+}
+
+
+
+
+void setconf_cfm(struct avdtp *session, struct avdtp_local_sep *sep,
+				struct avdtp_stream *stream,
+				struct avdtp_error *err, void *user_data)
+{
+	struct sep *avdtp_sep = user_data;
+	struct avdtp_setup *setup;
+	struct audio_device *dev;
+	int ret;
+
+	if (avdtp_sep->type == AVDTP_SEP_TYPE_SINK)
+		DBG("Sink %p: Set_Configuration_Cfm", sep);
+	else
+		DBG("Source %p: Set_Configuration_Cfm", sep);
+
+	setup = find_setup_by_session(session);
+
+	if (err) {
+		if (setup) {
+			setup->err = err;
+			finalize_config(setup);
+		}
+		return;
+	}
+
+	avdtp_stream_add_cb(session, stream, avdtp_stream_state_changed, avdtp_sep);
+	avdtp_sep->stream = stream;
+
+	if (!setup)
+		return;
+
+	dev = get_dev(session);
+	
+	// Notify D-Bus interface of the new stream 
+	if (avdtp_sep->type == AVDTP_SEP_TYPE_SOURCE)
+		video_sink_new_stream(dev, session, setup->stream);
+	else
+		video_source_new_stream(dev, session, setup->stream);
+
+	// Notify Endpoint 
+	if (avdtp_sep->endpoint) {
+		struct avdtp_service_capability *service;
+		struct avdtp_media_codec_capability *codec;
+		int err;
+
+		service = avdtp_stream_get_codec(stream);
+		codec = (struct avdtp_media_codec_capability *) service->data;
+
+		err = avdtp_sep->endpoint->set_configuration(avdtp_sep, dev,
+						codec->data, service->length -
+						sizeof(*codec),
+						GPOINTER_TO_UINT(setup),
+						endpoint_open_cb,
+						avdtp_sep->user_data);
+		if (err == 0)
+			return;
+
+		setup->stream = NULL;
+		finalize_setup_errno(setup, -EPERM, finalize_config, NULL);
+		return;
+	}
+
+	ret = avdtp_open(session, stream);
+	if (ret < 0) {
+		error("Error on avdtp_open %s (%d)", strerror(-ret), -ret);
+		setup->stream = NULL;
+		finalize_setup_errno(setup, ret, finalize_config, NULL);
+	}
+}
+
diff --git a/audio/sep.h b/audio/sep.h
new file mode 100644
index 0000000..8a662f4
--- /dev/null
+++ b/audio/sep.h
@@ -0,0 +1,207 @@
+#define RECONFIGURE_TIMEOUT 500
+#define SUSPEND_TIMEOUT 5
+
+GSList *servers = NULL;
+GSList *setups = NULL;
+unsigned int cb_id = 0;
+
+struct sep {
+	struct avdtp_server *server;
+	struct avdtp_endpoint *endpoint;
+	uint8_t type;
+	uint8_t codec;
+	struct avdtp_local_sep *lsep;
+	struct avdtp *session;
+	struct avdtp_stream *stream;
+	guint suspend_timer;
+	gboolean delay_reporting;
+	gboolean locked;
+	gboolean suspending;
+	gboolean starting;
+	void *user_data;
+	GDestroyNotify destroy;
+};
+
+struct avdtp_setup {
+	struct audio_device *dev;
+	struct avdtp *session;
+	struct sep *sep;
+	struct avdtp_remote_sep *rsep;
+	struct avdtp_stream *stream;
+	struct avdtp_error *err;
+	avdtp_set_configuration_cb setconf_cb;
+	GSList *caps;
+	gboolean reconfigure;
+	gboolean start;
+	GSList *cb;
+	int ref;
+};
+
+struct avdtp_server {
+	bdaddr_t src;
+	GSList *sinks;
+	GSList *sources;
+	uint32_t source_record_id;
+	uint32_t sink_record_id;
+	uint16_t version;
+	gboolean sink_enabled;
+	gboolean source_enabled;
+};
+
+typedef void (*avdtp_endpoint_select_t) (struct sep *sep, guint setup_id,
+                                                        void *ret, int size);
+typedef void (*avdtp_endpoint_config_t) (struct sep *sep, guint setup_id,
+                                                                gboolean ret);
+
+struct avdtp_endpoint {
+        const char *(*get_name) (struct sep *sep, void *user_data);
+        size_t (*get_capabilities) (struct sep *sep,
+                                                uint8_t **capabilities,
+                                                void *user_data);
+        int (*select_configuration) (struct sep *sep,
+                                                uint8_t *capabilities,
+                                                size_t length,
+                                                guint setup_id,
+                                                avdtp_endpoint_select_t cb,
+                                                void *user_data);
+        int (*set_configuration) (struct sep *sep,
+                                                struct audio_device *dev,
+                                                uint8_t *configuration,
+                                                size_t length,
+                                                guint setup_id,
+                                                avdtp_endpoint_config_t cb,
+                                                void *user_data);
+        void (*clear_configuration) (struct sep *sep, void *user_data);
+        void (*set_delay) (struct sep *sep, uint16_t delay,
+                                                        void *user_data);
+};
+
+typedef void (*avdtp_select_cb_t) (struct avdtp *session,
+                                        struct sep *sep, GSList *caps,
+                                        void *user_data);
+typedef void (*avdtp_config_cb_t) (struct avdtp *session, struct sep *sep,
+                                        struct avdtp_stream *stream,
+                                        struct avdtp_error *err,
+                                        void *user_data);
+typedef void (*avdtp_stream_cb_t) (struct avdtp *session,
+                                        struct avdtp_error *err,
+                                        void *user_data);
+
+
+struct avdtp_setup_cb {
+        struct avdtp_setup *setup;
+        avdtp_select_cb_t select_cb;
+        avdtp_config_cb_t config_cb;
+        avdtp_stream_cb_t resume_cb;
+        avdtp_stream_cb_t suspend_cb;
+        guint source_id;
+        void *user_data;
+        unsigned int id;
+};
+
+void remove_sep(struct sep *sep);
+struct sep *select_sep(struct avdtp *session, uint8_t type,
+                                        const char *sender);
+gboolean sep_get_lock(struct sep *sep);
+struct sep *avdtp_get_sep(struct avdtp *session,
+				struct avdtp_stream *stream);
+void unregister_sep(struct sep *sep);
+
+
+gboolean auto_config(gpointer data);
+gboolean finalize_config(gpointer data);
+//gboolean auto_select(gpointer data);
+void setup_cb_free(struct avdtp_setup_cb *cb);
+
+void setconf_cfm(struct avdtp *session, struct avdtp_local_sep *sep,
+                                struct avdtp_stream *stream,
+                                struct avdtp_error *err, void *user_data);
+
+struct avdtp_setup *setup_get(struct avdtp *session);
+struct avdtp_setup *setup_new(struct avdtp *session);
+struct avdtp_setup *setup_ref(struct avdtp_setup *setup);
+
+void avdtp_stream_state_changed(struct avdtp_stream *stream,
+					avdtp_state_t old_state,
+					avdtp_state_t new_state,
+					struct avdtp_error *err,
+					void *user_data);
+
+struct avdtp_server *find_server(GSList *list, const bdaddr_t *src);
+struct audio_device *get_dev(struct avdtp *session);
+struct avdtp_setup_cb *setup_cb_new(struct avdtp_setup *setup);
+struct avdtp_setup *find_setup_by_session(struct avdtp *session);
+struct avdtp_setup *find_setup_by_dev(struct audio_device *dev);
+void setup_unref(struct avdtp_setup *setup);
+gboolean endpoint_delayreport_ind(struct avdtp *session,
+						struct avdtp_local_sep *sep,
+						uint8_t rseid, uint16_t delay,
+						uint8_t *err, void *user_data);
+
+gboolean delayreport_ind(struct avdtp *session,
+				struct avdtp_local_sep *sep,
+				uint8_t rseid, uint16_t delay,
+				uint8_t *err, void *user_data);
+
+gboolean reconf_ind(struct avdtp *session, struct avdtp_local_sep *sep,
+				uint8_t *err, void *user_data);
+
+gboolean abort_ind(struct avdtp *session, struct avdtp_local_sep *sep,
+				struct avdtp_stream *stream, uint8_t *err,
+				void *user_data);
+
+gboolean close_ind(struct avdtp *session, struct avdtp_local_sep *sep,
+				struct avdtp_stream *stream, uint8_t *err,
+				void *user_data);
+
+gboolean suspend_ind(struct avdtp *session, struct avdtp_local_sep *sep,
+				struct avdtp_stream *stream, uint8_t *err,
+				void *user_data);
+
+gboolean start_ind(struct avdtp *session, struct avdtp_local_sep *sep,
+				struct avdtp_stream *stream, uint8_t *err,
+				void *user_data);
+
+gboolean open_ind(struct avdtp *session, struct avdtp_local_sep *sep,
+				struct avdtp_stream *stream, uint8_t *err,
+				void *user_data);
+
+gboolean getconf_ind(struct avdtp *session, struct avdtp_local_sep *sep,
+				uint8_t *err, void *user_data);
+
+gboolean endpoint_setconf_ind(struct avdtp *session,
+						struct avdtp_local_sep *sep,
+						struct avdtp_stream *stream,
+						GSList *caps,
+						avdtp_set_configuration_cb cb,
+						void *user_data);
+gboolean endpoint_getcap_ind(struct avdtp *session,
+                                        struct avdtp_local_sep *sep,
+                                        gboolean get_all, GSList **caps,
+                                        uint8_t *err, void *user_data);
+void close_cfm(struct avdtp *session, struct avdtp_local_sep *sep,
+                        struct avdtp_stream *stream, struct avdtp_error *err,
+                        void *user_data);
+void abort_cfm(struct avdtp *session, struct avdtp_local_sep *sep,
+                        struct avdtp_stream *stream, struct avdtp_error *err,
+                        void *user_data);
+void reconf_cfm(struct avdtp *session, struct avdtp_local_sep *sep,
+                        struct avdtp_stream *stream, struct avdtp_error *err,
+                        void *user_data);
+void delay_report_cfm(struct avdtp *session, struct avdtp_local_sep *sep,
+                                struct avdtp_stream *stream,
+                                struct avdtp_error *err, void *user_data);
+void getconf_cfm(struct avdtp *session, struct avdtp_local_sep *sep,
+                        struct avdtp_stream *stream, struct avdtp_error *err,
+                        void *user_data);
+void open_cfm(struct avdtp *session, struct avdtp_local_sep *sep,
+                        struct avdtp_stream *stream, struct avdtp_error *err,
+                        void *user_data);
+void start_cfm(struct avdtp *session, struct avdtp_local_sep *sep,
+                        struct avdtp_stream *stream, struct avdtp_error *err,
+                        void *user_data);
+void suspend_cfm(struct avdtp *session, struct avdtp_local_sep *sep,
+                        struct avdtp_stream *stream, struct avdtp_error *err,
+                        void *user_data);
+
+
-- 
1.7.3.4

