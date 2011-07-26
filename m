Return-Path: <cyrus@holtmann.org>
From: Prasad Bhat <prasadbhat22@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 1/6] Initial VDP implementation.
Date: Tue, 26 Jul 2011 19:39:42 +0530
Message-Id: <1311689387-10114-1-git-send-email-prasadbhat22@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 Makefile.am |    1 +
 audio/vdp.c | 2303 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 audio/vdp.h |   92 +++
 3 files changed, 2396 insertions(+), 0 deletions(-)
 create mode 100755 audio/vdp.c
 create mode 100755 audio/vdp.h

diff --git a/Makefile.am b/Makefile.am
index 52c49fb..af41604 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -136,6 +136,7 @@ builtin_sources += audio/main.c \
 			audio/sink.h audio/sink.c \
 			audio/a2dp.h audio/a2dp.c \
 			audio/avdtp.h audio/avdtp.c \
+			audio/vdp.h audio/vdp.c \
 			audio/ipc.h audio/ipc.c \
 			audio/unix.h audio/unix.c \
 			audio/media.h audio/media.c \
diff --git a/audio/vdp.c b/audio/vdp.c
new file mode 100755
index 0000000..6d16a39
--- /dev/null
+++ b/audio/vdp.c
@@ -0,0 +1,2303 @@
+/*
+ *
+ *  BlueZ - Bluetooth protocol stack for Linux
+ *
+ *  Copyright (C) 2006-2010  Nokia Corporation
+ *  Copyright (C) 2004-2010  Marcel Holtmann <marcel@holtmann.org>
+ *
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation; either version 2 of the License, or
+ *  (at your option) any later version.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program; if not, write to the Free Software
+ *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
+ *
+ */
+
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
+#include "transport.h"
+#include "vdp.h"
+#include "sdpd.h"
+
+#define RECONFIGURE_TIMEOUT 500
+#define SUSPEND_TIMEOUT 5
+
+struct vdp_sep {
+	struct vdp_server *server;
+	struct media_endpoint *endpoint;
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
+};
+
+struct vdp_setup_cb {
+	struct vdp_setup *setup;
+	vdp_select_cb_t select_cb;
+	vdp_config_cb_t config_cb;
+	vdp_stream_cb_t resume_cb;
+	vdp_stream_cb_t suspend_cb;
+	guint source_id;
+	void *user_data;
+	unsigned int id;
+};
+
+struct vdp_setup {
+	struct audio_device *dev;
+	struct avdtp *session;
+	struct vdp_sep *sep;
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
+static DBusConnection *connection = NULL;
+
+struct vdp_server {
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
+static GSList *servers = NULL;
+static GSList *setups = NULL;
+static unsigned int cb_id = 0;
+
+static struct vdp_setup *setup_ref(struct vdp_setup *setup)
+{
+	setup->ref++;
+
+	DBG("%p: ref=%d", setup, setup->ref);
+
+	return setup;
+}
+
+static struct audio_device *vdp_get_dev(struct avdtp *session)
+{
+	bdaddr_t src, dst;
+
+	avdtp_get_peers(session, &src, &dst);
+
+	return manager_find_device(NULL, &src, &dst, NULL, FALSE);
+}
+
+static struct vdp_setup *setup_new(struct avdtp *session)
+{
+	struct audio_device *dev;
+	struct vdp_setup *setup;
+
+	dev = vdp_get_dev(session);
+	if (!dev) {
+		error("Unable to create setup");
+		return NULL;
+	}
+
+	setup = g_new0(struct vdp_setup, 1);
+	setup->session = avdtp_ref(session);
+	setup->dev = vdp_get_dev(session);
+	setups = g_slist_append(setups, setup);
+
+	return setup;
+}
+
+static void setup_free(struct vdp_setup *s)
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
+static void setup_unref(struct vdp_setup *setup)
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
+static struct vdp_setup_cb *setup_cb_new(struct vdp_setup *setup)
+{
+	struct vdp_setup_cb *cb;
+
+	cb = g_new0(struct vdp_setup_cb, 1);
+	cb->setup = setup;
+	cb->id = ++cb_id;
+
+	setup->cb = g_slist_append(setup->cb, cb);
+	return cb;
+}
+
+static void setup_cb_free(struct vdp_setup_cb *cb)
+{
+	struct vdp_setup *setup = cb->setup;
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
+static void finalize_setup_errno(struct vdp_setup *s, int err,
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
+static gboolean finalize_config(gpointer data)
+{
+	struct vdp_setup *s = data;
+	GSList *l;
+	struct avdtp_stream *stream = s->err ? NULL : s->stream;
+
+	DBG("");
+	
+	for (l = s->cb; l != NULL; ) {
+		struct vdp_setup_cb *cb = l->data;
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
+	struct vdp_setup *s = data;
+	GSList *l;
+	
+	DBG("");
+
+	for (l = s->cb; l != NULL; ) {
+		struct vdp_setup_cb *cb = l->data;
+
+		l = l->next;
+
+		if (!cb->resume_cb)
+			continue;
+
+		cb->resume_cb(s->session, s->err, cb->user_data);
+		setup_cb_free(cb);
+	}
+
+	return FALSE;
+}
+
+static gboolean finalize_suspend(gpointer data)
+{
+	struct vdp_setup *s = data;
+	GSList *l;
+	
+	DBG("");
+
+	for (l = s->cb; l != NULL; ) {
+		struct vdp_setup_cb *cb = l->data;
+
+		l = l->next;
+
+		if (!cb->suspend_cb)
+			continue;
+
+		cb->suspend_cb(s->session, s->err, cb->user_data);
+		setup_cb_free(cb);
+	}
+
+	return FALSE;
+}
+
+static void finalize_select(struct vdp_setup *s)
+{
+	GSList *l;
+
+	DBG("");
+	
+	for (l = s->cb; l != NULL; ) {
+		struct vdp_setup_cb *cb = l->data;
+
+		l = l->next;
+
+		if (!cb->select_cb)
+			continue;
+
+		cb->select_cb(s->session, s->sep, s->caps, cb->user_data);
+		setup_cb_free(cb);
+	}
+}
+
+static struct vdp_setup *find_setup_by_session(struct avdtp *session)
+{
+	GSList *l;
+
+	for (l = setups; l != NULL; l = l->next) {
+		struct vdp_setup *setup = l->data;
+
+		if (setup->session == session)
+			return setup;
+	}
+
+	return NULL;
+}
+
+static struct vdp_setup *vdp_setup_get(struct avdtp *session)
+{
+	struct vdp_setup *setup;
+
+	setup = find_setup_by_session(session);
+	if (!setup) {
+		setup = setup_new(session);
+		if (!setup)
+			return NULL;
+	}
+
+	return setup_ref(setup);
+}
+
+static struct vdp_setup *find_setup_by_dev(struct audio_device *dev)
+{
+	GSList *l;
+
+	for (l = setups; l != NULL; l = l->next) {
+		struct vdp_setup *setup = l->data;
+
+		if (setup->dev == dev)
+			return setup;
+	}
+
+	return NULL;
+}
+
+static void stream_state_changed(struct avdtp_stream *stream,
+					avdtp_state_t old_state,
+					avdtp_state_t new_state,
+					struct avdtp_error *err,
+					void *user_data)
+{
+	struct vdp_sep *sep = user_data;
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
+	if (sep->endpoint)
+		media_endpoint_clear_configuration(sep->endpoint);
+}
+
+static gboolean auto_config(gpointer data)
+{
+	struct vdp_setup *setup = data;
+	struct avdtp_error *err = NULL;
+	
+	DBG("");
+
+	/* Check if configuration was aborted */
+	if (setup->sep->stream == NULL)
+		return FALSE;
+
+	if (setup->err != NULL) {
+		err = setup->err;
+		goto done;
+	}
+
+	avdtp_stream_add_cb(setup->session, setup->stream,
+				stream_state_changed, setup->sep);
+
+done:
+	if (setup->setconf_cb)
+		setup->setconf_cb(setup->session, setup->stream, setup->err);
+
+	finalize_config(setup);
+
+	if (err)
+		g_free(err);
+
+	setup_unref(setup);
+
+	return FALSE;
+}
+
+static struct vdp_server *find_server(GSList *list, const bdaddr_t *src)
+{
+
+	for (; list; list = list->next) {
+		struct vdp_server *server = list->data;
+
+		if (bacmp(&server->src, src) == 0)
+			return server;
+	}
+	DBG("find server no server found");
+	return NULL;
+}
+
+gboolean vdp_sep_get_lock(struct vdp_sep *sep)
+{
+	return sep->locked;
+}
+
+static void endpoint_open_cb(struct media_endpoint *endpoint, void *ret,
+						int size, void *user_data)
+{
+	struct vdp_setup *setup = user_data;
+	int err;
+
+	if (ret == NULL) {
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
+unsigned int vdp_config(struct avdtp *session, struct vdp_sep *sep,
+				vdp_config_cb_t cb, GSList *caps,
+				void *user_data)
+{
+	struct vdp_setup_cb *cb_data;
+	GSList *l;
+	struct vdp_server *server;
+	struct vdp_setup *setup;
+	struct vdp_sep *tmp;
+	struct avdtp_service_capability *cap;
+	struct avdtp_media_codec_capability *codec_cap = NULL;
+	int posix_err;
+	bdaddr_t src;
+
+	DBG("");
+	
+	avdtp_get_peers(session, &src, NULL);
+	server = find_server(servers, &src);
+	if (!server)
+		return 0;
+
+	for (l = caps; l != NULL; l = l->next) {
+		cap = l->data;
+
+		if (cap->category != AVDTP_MEDIA_CODEC)
+			continue;
+
+		codec_cap = (void *) cap->data;
+		break;
+	}
+
+	if (!codec_cap)
+		return 0;
+
+	if (sep->codec != codec_cap->media_codec_type)
+		return 0;
+
+	DBG("vdp_config: selected SEP %p", sep->lsep);
+
+	setup = vdp_setup_get(session);
+	if (!setup)
+		return 0;
+
+	cb_data = setup_cb_new(setup);
+	cb_data->config_cb = cb;
+	cb_data->user_data = user_data;
+
+	setup->sep = sep;
+	setup->stream = sep->stream;
+
+	/* Copy given caps if they are different than current caps */
+	if (setup->caps != caps) {
+		g_slist_foreach(setup->caps, (GFunc) g_free, NULL);
+		g_slist_free(setup->caps);
+		setup->caps = g_slist_copy(caps);
+	}
+
+	switch (avdtp_sep_get_state(sep->lsep)) {
+	case AVDTP_STATE_IDLE:
+		if (sep->type == AVDTP_SEP_TYPE_SOURCE)
+			l = server->sources;
+		else
+			l = server->sinks;
+
+		for (; l != NULL; l = l->next) {
+			tmp = l->data;
+			if (avdtp_has_stream(session, tmp->stream))
+				break;
+		}
+
+		if (l != NULL) {
+			if (vdp_sep_get_lock(tmp))
+				goto failed;
+			setup->reconfigure = TRUE;
+			if (avdtp_close(session, tmp->stream, FALSE) < 0) {
+				error("avdtp_close failed");
+				goto failed;
+			}
+			break;
+		}
+
+		setup->rsep = avdtp_find_remote_sep(session, sep->lsep);
+		if (setup->rsep == NULL) {
+			error("No matching ACP and INT SEPs found");
+			goto failed;
+		}
+
+		posix_err = avdtp_set_configuration(session, setup->rsep,
+							sep->lsep, caps,
+							&setup->stream);
+		if (posix_err < 0) {
+			error("avdtp_set_configuration: %s",
+				strerror(-posix_err));
+			goto failed;
+		}
+		break;
+	case AVDTP_STATE_OPEN:
+	case AVDTP_STATE_STREAMING:
+		if (avdtp_stream_has_capabilities(setup->stream, caps)) {
+			DBG("Configuration match: resuming");
+			cb_data->source_id = g_idle_add(finalize_config,
+								setup);
+		} else if (!setup->reconfigure) {
+			setup->reconfigure = TRUE;
+			if (avdtp_close(session, sep->stream, FALSE) < 0) {
+				error("avdtp_close failed");
+				goto failed;
+			}
+		}
+		break;
+	default:
+		error("SEP in bad state for requesting a new stream");
+		goto failed;
+	}
+
+	return cb_data->id;
+
+failed:
+	setup_cb_free(cb_data);
+	return 0;
+}
+
+static struct vdp_sep *vdp_find_sep(struct avdtp *session, GSList *list,
+                                        const char *sender)
+{
+	for (; list; list = list->next) {
+		struct vdp_sep *sep = list->data;
+
+		/* Use sender's endpoint if available */
+		if (sender) {
+			const char *name;
+
+			if (sep->endpoint == NULL)
+				continue;
+
+			name = media_endpoint_get_sender(sep->endpoint);
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
+
+static struct vdp_sep *vdp_select_sep(struct avdtp *session, uint8_t type,
+					const char *sender)
+{
+	struct vdp_server *server;
+	struct vdp_sep *sep;
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
+	/* Check sender's seps first */
+	sep = vdp_find_sep(session, l, sender);
+	if (sep != NULL)
+		return sep;
+
+	return vdp_find_sep(session, l, NULL);
+}
+
+static gboolean select_h263_params(struct h263_baseline_codec_cap *cap,
+					struct h263_baseline_codec_cap *supported)
+{
+	memset(cap, 0, sizeof(struct h263_baseline_codec_cap));
+
+	cap->cap.media_type = AVDTP_MEDIA_TYPE_VIDEO;
+	cap->cap.media_codec_type = VDP_CODEC_H263_BASELINE;
+
+	if (supported->level & H263_LEVEL_10)
+		cap->level = H263_LEVEL_10;
+	else {
+		error("No supported level");
+		return FALSE;
+	}
+	return TRUE;
+}
+
+static gboolean select_capabilities(struct avdtp *session,
+					struct avdtp_remote_sep *rsep,
+					GSList **caps)
+{
+	struct avdtp_service_capability *media_transport, *media_codec;
+	struct h263_baseline_codec_cap h263_cap;
+
+	media_codec = avdtp_get_codec(rsep);
+	if (!media_codec)
+		return FALSE;
+
+	select_h263_params(&h263_cap, (struct h263_baseline_codec_cap *) media_codec->data);
+
+	media_transport = avdtp_service_cap_new(AVDTP_MEDIA_TRANSPORT,
+						NULL, 0);
+
+	*caps = g_slist_append(*caps, media_transport);
+
+	media_codec = avdtp_service_cap_new(AVDTP_MEDIA_CODEC, &h263_cap,
+						sizeof(h263_cap));
+
+	*caps = g_slist_append(*caps, media_codec);
+
+	if (avdtp_get_delay_reporting(rsep)) {
+		struct avdtp_service_capability *delay_reporting;
+		delay_reporting = avdtp_service_cap_new(AVDTP_DELAY_REPORTING,
+								NULL, 0);
+		*caps = g_slist_append(*caps, delay_reporting);
+	}
+
+	return TRUE;
+}
+
+static void select_cb(struct media_endpoint *endpoint, void *ret, int size,
+			void *user_data)
+{
+	struct vdp_setup *setup = user_data;
+	struct avdtp_service_capability *media_transport, *media_codec;
+	struct avdtp_media_codec_capability *cap;
+
+	if (size < 0) {
+		DBG("Endpoint replied an invalid configuration");
+		goto done;
+	}
+
+	media_transport = avdtp_service_cap_new(AVDTP_MEDIA_TRANSPORT,
+						NULL, 0);
+
+	setup->caps = g_slist_append(setup->caps, media_transport);
+
+	cap = g_malloc0(sizeof(*cap) + size);
+	cap->media_type = AVDTP_MEDIA_TYPE_VIDEO;
+	cap->media_codec_type = setup->sep->codec;
+	memcpy(cap->data, ret, size);
+
+	media_codec = avdtp_service_cap_new(AVDTP_MEDIA_CODEC, cap,
+						sizeof(*cap) + size);
+
+	setup->caps = g_slist_append(setup->caps, media_codec);
+	g_free(cap);
+
+done:
+	finalize_select(setup);
+}
+
+static gboolean auto_select(gpointer data)
+{
+	struct vdp_setup *setup = data;
+
+	finalize_select(setup);
+
+	return FALSE;
+}
+
+unsigned int vdp_select_capabilities(struct avdtp *session,
+					uint8_t type, const char *sender,
+					vdp_select_cb_t cb,
+					void *user_data)
+{
+	struct vdp_setup *setup;
+	struct vdp_setup_cb *cb_data;
+	struct vdp_sep *sep;
+	struct avdtp_service_capability *service;
+	struct avdtp_media_codec_capability *codec;
+
+	DBG("");
+	
+	sep = vdp_select_sep(session, type, sender);
+	if (!sep) {
+		error("Unable to select SEP");
+		return 0;
+	}
+
+	setup = vdp_setup_get(session);
+	if (!setup)
+		return 0;
+
+	cb_data = setup_cb_new(setup);
+	cb_data->select_cb = cb;
+	cb_data->user_data = user_data;
+
+	setup->sep = sep;
+	setup->rsep = avdtp_find_remote_sep(session, sep->lsep);
+
+	if (setup->rsep == NULL) {
+		error("Could not find remote sep");
+		goto fail;
+	}
+
+	/* FIXME: Remove auto select when it is not longer possible to register
+	endpoint in the configuration file */
+	if (sep->endpoint == NULL) {
+		if (!select_capabilities(session, setup->rsep,
+					&setup->caps)) {
+			error("Unable to auto select remote SEP capabilities");
+			goto fail;
+		}
+
+		g_idle_add(auto_select, setup);
+
+		return cb_data->id;
+	}
+
+	service = avdtp_get_codec(setup->rsep);
+	codec = (struct avdtp_media_codec_capability *) service->data;
+
+	if (media_endpoint_select_configuration(sep->endpoint, codec->data,
+						service->length - sizeof(*codec),
+						select_cb, setup) ==
+						TRUE)
+		return cb_data->id;
+
+fail:
+	setup_cb_free(cb_data);
+	return 0;
+
+}
+
+static void setconf_cfm(struct avdtp *session, struct avdtp_local_sep *sep,
+				struct avdtp_stream *stream,
+				struct avdtp_error *err, void *user_data)
+{
+	struct vdp_sep *vdp_sep = user_data;
+	struct vdp_setup *setup;
+	struct audio_device *dev;
+	int ret;
+
+	if (vdp_sep->type == AVDTP_SEP_TYPE_SINK)
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
+	avdtp_stream_add_cb(session, stream, stream_state_changed, vdp_sep);
+	vdp_sep->stream = stream;
+
+	if (!setup)
+		return;
+
+	dev = vdp_get_dev(session);
+	
+	/* Notify Endpoint */
+	if (vdp_sep->endpoint) {
+		struct avdtp_service_capability *service;
+		struct avdtp_media_codec_capability *codec;
+
+		service = avdtp_stream_get_codec(stream);
+		codec = (struct avdtp_media_codec_capability *) service->data;
+
+		if (media_endpoint_set_configuration(vdp_sep->endpoint, dev,
+						codec->data, service->length -
+						sizeof(*codec),
+						endpoint_open_cb, setup) ==
+						TRUE)
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
+static void getconf_cfm(struct avdtp *session, struct avdtp_local_sep *sep,
+			struct avdtp_stream *stream, struct avdtp_error *err,
+			void *user_data)
+{
+	struct vdp_sep *vdp_sep = user_data;
+
+	if (vdp_sep->type == AVDTP_SEP_TYPE_SINK)
+		DBG("Sink %p: Set_Configuration_Cfm", sep);
+	else
+		DBG("Source %p: Set_Configuration_Cfm", sep);
+}
+
+static void open_cfm(struct avdtp *session, struct avdtp_local_sep *sep,
+			struct avdtp_stream *stream, struct avdtp_error *err,
+			void *user_data)
+{
+	struct vdp_sep *vdp_sep = user_data;
+	struct vdp_setup *setup;
+
+	if (vdp_sep->type == AVDTP_SEP_TYPE_SINK)
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
+static void start_cfm(struct avdtp *session, struct avdtp_local_sep *sep,
+			struct avdtp_stream *stream, struct avdtp_error *err,
+			void *user_data)
+{
+	struct vdp_sep *vdp_sep = user_data;
+	struct vdp_setup *setup;
+
+	if (vdp_sep->type == AVDTP_SEP_TYPE_SINK)
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
+static void suspend_cfm(struct avdtp *session, struct avdtp_local_sep *sep,
+			struct avdtp_stream *stream, struct avdtp_error *err,
+			void *user_data)
+{
+	struct vdp_sep *vdp_sep = user_data;
+	struct vdp_setup *setup;
+	gboolean start;
+	int perr;
+
+	if (vdp_sep->type == AVDTP_SEP_TYPE_SINK)
+		DBG("Sink %p: Suspend_Cfm", sep);
+	else
+		DBG("Source %p: Suspend_Cfm", sep);
+
+	vdp_sep->suspending = FALSE;
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
+	perr = avdtp_start(session, vdp_sep->stream);
+	if (perr < 0) {
+		error("Error on avdtp_start %s (%d)", strerror(-perr), -perr);
+		finalize_setup_errno(setup, -EIO, finalize_suspend, NULL);
+	}
+}
+
+static gboolean vdp_reconfigure(gpointer data)
+{
+	struct vdp_setup *setup = data;
+	struct vdp_sep *sep = setup->sep;
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
+static void close_cfm(struct avdtp *session, struct avdtp_local_sep *sep,
+			struct avdtp_stream *stream, struct avdtp_error *err,
+			void *user_data)
+{
+	struct vdp_sep *vdp_sep = user_data;
+	struct vdp_setup *setup;
+
+	if (vdp_sep->type == AVDTP_SEP_TYPE_SINK)
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
+static void abort_cfm(struct avdtp *session, struct avdtp_local_sep *sep,
+			struct avdtp_stream *stream, struct avdtp_error *err,
+			void *user_data)
+{
+	struct vdp_sep *vdp_sep = user_data;
+	struct vdp_setup *setup;
+
+	DBG("");
+	
+	if (vdp_sep->type == AVDTP_SEP_TYPE_SINK)
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
+static void reconf_cfm(struct avdtp *session, struct avdtp_local_sep *sep,
+			struct avdtp_stream *stream, struct avdtp_error *err,
+			void *user_data)
+{
+	struct vdp_sep *vdp_sep = user_data;
+	struct vdp_setup *setup;
+
+	if (vdp_sep->type == AVDTP_SEP_TYPE_SINK)
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
+static void delay_report_cfm(struct avdtp *session, struct avdtp_local_sep *sep,
+				struct avdtp_stream *stream,
+				struct avdtp_error *err, void *user_data)
+{
+	struct vdp_sep *vdp_sep = user_data;
+
+	if (vdp_sep->type == AVDTP_SEP_TYPE_SINK)
+		DBG("Sink %p: DelayReport_Cfm", sep);
+	else
+		DBG("Source %p: DelayReport_Cfm", sep);
+}
+
+
+static struct avdtp_sep_cfm cfm = {
+	.set_configuration	= setconf_cfm,
+	.get_configuration	= getconf_cfm,
+	.open			= open_cfm,
+	.start			= start_cfm,
+	.suspend		= suspend_cfm,
+	.close			= close_cfm,
+	.abort			= abort_cfm,
+	.reconfigure		= reconf_cfm,
+	.delay_report		= delay_report_cfm,
+};
+
+static gboolean endpoint_getcap_ind(struct avdtp *session,
+					struct avdtp_local_sep *sep,
+					gboolean get_all, GSList **caps,
+					uint8_t *err, void *user_data)
+{
+	struct vdp_sep *vdp_sep = user_data;
+	struct avdtp_service_capability *media_transport, *media_codec;
+	struct avdtp_media_codec_capability *codec_caps;
+	uint8_t *capabilities;
+	size_t length;
+
+	if (vdp_sep->type == AVDTP_SEP_TYPE_SINK)
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
+	length = media_endpoint_get_capabilities(vdp_sep->endpoint,
+						&capabilities);
+
+	codec_caps = g_malloc0(sizeof(*codec_caps) + length);
+	codec_caps->media_type = AVDTP_MEDIA_TYPE_VIDEO;
+	codec_caps->media_codec_type = vdp_sep->codec;
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
+static void endpoint_setconf_cb(struct media_endpoint *endpoint, void *ret,
+						int size, void *user_data)
+{
+	struct vdp_setup *setup = user_data;
+
+	if (ret == NULL) {
+		setup->err = g_new(struct avdtp_error, 1);
+		avdtp_error_init(setup->err, AVDTP_MEDIA_CODEC,
+					AVDTP_UNSUPPORTED_CONFIGURATION);
+	}
+
+	auto_config(setup);
+}
+
+static gboolean endpoint_setconf_ind(struct avdtp *session,
+						struct avdtp_local_sep *sep,
+						struct avdtp_stream *stream,
+						GSList *caps,
+						avdtp_set_configuration_cb cb,
+						void *user_data)
+{
+	struct vdp_sep *vdp_sep = user_data;
+	struct vdp_setup *setup;
+
+	if (vdp_sep->type == AVDTP_SEP_TYPE_SINK)
+		DBG("Sink %p: Set_Configuration_Ind", sep);
+	else
+		DBG("Source %p: Set_Configuration_Ind", sep);
+
+	setup = vdp_setup_get(session);
+	if (!session)
+		return FALSE;
+
+	vdp_sep->stream = stream;
+	setup->sep = vdp_sep;
+	setup->stream = stream;
+	setup->setconf_cb = cb;
+
+	for (; caps != NULL; caps = g_slist_next(caps)) {
+		struct avdtp_service_capability *cap = caps->data;
+		struct avdtp_media_codec_capability *codec;
+		gboolean ret;
+
+		if (cap->category == AVDTP_DELAY_REPORTING &&
+					!vdp_sep->delay_reporting) {
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
+		if (codec->media_codec_type != vdp_sep->codec) {
+			setup->err = g_new(struct avdtp_error, 1);
+			avdtp_error_init(setup->err, AVDTP_MEDIA_CODEC,
+					AVDTP_UNSUPPORTED_CONFIGURATION);
+			goto done;
+		}
+
+		ret = media_endpoint_set_configuration(vdp_sep->endpoint,
+						setup->dev, codec->data,
+						cap->length - sizeof(*codec),
+						endpoint_setconf_cb, setup);
+		if (ret)
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
+static gboolean getconf_ind(struct avdtp *session, struct avdtp_local_sep *sep,
+				uint8_t *err, void *user_data)
+{
+	struct vdp_sep *vdp_sep = user_data;
+
+	if (vdp_sep->type == AVDTP_SEP_TYPE_SINK)
+		DBG("Sink %p: Get_Configuration_Ind", sep);
+	else
+		DBG("Source %p: Get_Configuration_Ind", sep);
+	return TRUE;
+}
+
+static gboolean open_ind(struct avdtp *session, struct avdtp_local_sep *sep,
+				struct avdtp_stream *stream, uint8_t *err,
+				void *user_data)
+{
+	struct vdp_sep *vdp_sep = user_data;
+
+	if (vdp_sep->type == AVDTP_SEP_TYPE_SINK)
+		DBG("Sink %p: Open_Ind", sep);
+	else
+		DBG("Source %p: Open_Ind", sep);
+	return TRUE;
+}
+
+static gboolean suspend_timeout(struct vdp_sep *sep)
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
+static gboolean start_ind(struct avdtp *session, struct avdtp_local_sep *sep,
+				struct avdtp_stream *stream, uint8_t *err,
+				void *user_data)
+{
+	struct vdp_sep *vdp_sep = user_data;
+	struct vdp_setup *setup;
+
+	if (vdp_sep->type == AVDTP_SEP_TYPE_SINK)
+		DBG("Sink %p: Start_Ind", sep);
+	else
+		DBG("Source %p: Start_Ind", sep);
+
+	setup = find_setup_by_session(session);
+	if (setup)
+		finalize_resume(setup);
+
+	if (!vdp_sep->locked) {
+		vdp_sep->session = avdtp_ref(session);
+		vdp_sep->suspend_timer = g_timeout_add_seconds(SUSPEND_TIMEOUT,
+						(GSourceFunc) suspend_timeout,
+						vdp_sep);
+	}
+
+	return TRUE;
+}
+
+static gboolean suspend_ind(struct avdtp *session, struct avdtp_local_sep *sep,
+				struct avdtp_stream *stream, uint8_t *err,
+				void *user_data)
+{
+	struct vdp_sep *vdp_sep = user_data;
+
+	if (vdp_sep->type == AVDTP_SEP_TYPE_SINK)
+		DBG("Sink %p: Suspend_Ind", sep);
+	else
+		DBG("Source %p: Suspend_Ind", sep);
+
+	if (vdp_sep->suspend_timer) {
+		g_source_remove(vdp_sep->suspend_timer);
+		vdp_sep->suspend_timer = 0;
+		avdtp_unref(vdp_sep->session);
+		vdp_sep->session = NULL;
+	}
+
+	return TRUE;
+}
+
+static gboolean close_ind(struct avdtp *session, struct avdtp_local_sep *sep,
+				struct avdtp_stream *stream, uint8_t *err,
+				void *user_data)
+{
+	struct vdp_sep *vdp_sep = user_data;
+	struct vdp_setup *setup;
+
+	if (vdp_sep->type == AVDTP_SEP_TYPE_SINK)
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
+static gboolean abort_ind(struct avdtp *session, struct avdtp_local_sep *sep,
+				struct avdtp_stream *stream, uint8_t *err,
+				void *user_data)
+{
+	struct vdp_sep *vdp_sep = user_data;
+
+	if (vdp_sep->type == AVDTP_SEP_TYPE_SINK)
+		DBG("Sink %p: Abort_Ind", sep);
+	else
+		DBG("Source %p: Abort_Ind", sep);
+
+	vdp_sep->stream = NULL;
+
+	return TRUE;
+}
+
+static gboolean reconf_ind(struct avdtp *session, struct avdtp_local_sep *sep,
+				uint8_t *err, void *user_data)
+{
+	struct vdp_sep *vdp_sep = user_data;
+
+	if (vdp_sep->type == AVDTP_SEP_TYPE_SINK)
+		DBG("Sink %p: ReConfigure_Ind", sep);
+	else
+		DBG("Source %p: ReConfigure_Ind", sep);
+
+	return TRUE;
+}
+
+static gboolean delayreport_ind(struct avdtp *session,
+				struct avdtp_local_sep *sep,
+				uint8_t rseid, uint16_t delay,
+				uint8_t *err, void *user_data)
+{
+	struct vdp_sep *vdp_sep = user_data;
+	struct audio_device *dev = vdp_get_dev(session);
+
+	if (vdp_sep->type == AVDTP_SEP_TYPE_SINK)
+		DBG("Sink %p: DelayReport_Ind", sep);
+	else
+		DBG("Source %p: DelayReport_Ind", sep);
+
+	unix_delay_report(dev, rseid, delay);
+
+	return TRUE;
+}
+
+static gboolean endpoint_delayreport_ind(struct avdtp *session,
+						struct avdtp_local_sep *sep,
+						uint8_t rseid, uint16_t delay,
+						uint8_t *err, void *user_data)
+{
+	struct vdp_sep *vdp_sep = user_data;
+	struct media_transport *transport;
+
+	if (vdp_sep->type == AVDTP_SEP_TYPE_SINK)
+		DBG("Sink %p: DelayReport_Ind", sep);
+	else
+		DBG("Source %p: DelayReport_Ind", sep);
+
+	transport = media_endpoint_get_transport(vdp_sep->endpoint);
+	if (transport == NULL)
+		return FALSE;
+
+	media_transport_update_delay(transport, delay);
+
+	return TRUE;
+}
+
+static struct avdtp_sep_ind endpoint_ind = {
+	.get_capability		= endpoint_getcap_ind,
+	.set_configuration	= endpoint_setconf_ind,
+	.get_configuration	= getconf_ind,
+	.open			= open_ind,
+	.start			= start_ind,
+	.suspend		= suspend_ind,
+	.close			= close_ind,
+	.abort			= abort_ind,
+	.reconfigure		= reconf_ind,
+	.delayreport		= endpoint_delayreport_ind,
+};
+
+static gboolean h263_baseline_getcap_ind(struct avdtp *session,
+				struct avdtp_local_sep *sep, gboolean get_all,
+				GSList **caps, uint8_t *err, void *user_data)
+{
+	struct vdp_sep *vdp_sep = user_data;
+	struct avdtp_service_capability *media_transport, *media_codec;
+	struct h263_baseline_codec_cap h263_cap;
+
+	if (vdp_sep->type == AVDTP_SEP_TYPE_SINK)
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
+	memset(&h263_cap, 0, sizeof(struct h263_baseline_codec_cap));
+
+	h263_cap.cap.media_type = AVDTP_MEDIA_TYPE_VIDEO;
+	h263_cap.cap.media_codec_type = VDP_CODEC_H263_BASELINE;
+
+	h263_cap.level = ( H263_LEVEL_10 |
+				H263_LEVEL_20 |
+				H263_LEVEL_30 );
+
+	media_codec = avdtp_service_cap_new(AVDTP_MEDIA_CODEC, &h263_cap,
+						sizeof(h263_cap));
+
+	*caps = g_slist_append(*caps, media_codec);
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
+static gboolean h263_baseline_setconf_ind(struct avdtp *session,
+					struct avdtp_local_sep *sep,
+					struct avdtp_stream *stream,
+					GSList *caps,
+					avdtp_set_configuration_cb cb,
+					void *user_data)
+{
+	struct vdp_sep *vdp_sep = user_data;
+	struct vdp_setup *setup;
+
+	if (vdp_sep->type == AVDTP_SEP_TYPE_SINK)
+		DBG("Sink %p: Set_Configuration_Ind", sep);
+	else
+		DBG("Source %p: Set_Configuration_Ind", sep);
+
+	setup = vdp_setup_get(session);
+	if (!setup)
+		return FALSE;
+
+	vdp_sep->stream = stream;
+	setup->sep = vdp_sep;
+	setup->stream = stream;
+	setup->setconf_cb = cb;
+
+	/* Check valid settings */
+	for (; caps != NULL; caps = g_slist_next(caps)) {
+		struct avdtp_service_capability *cap = caps->data;
+		struct avdtp_media_codec_capability *codec_cap;
+
+		if (cap->category == AVDTP_DELAY_REPORTING &&
+					!vdp_sep->delay_reporting) {
+			setup->err = g_new(struct avdtp_error, 1);
+			avdtp_error_init(setup->err, AVDTP_DELAY_REPORTING,
+						AVDTP_UNSUPPORTED_CONFIGURATION);
+			goto done;
+		}
+
+		if (cap->category != AVDTP_MEDIA_CODEC)
+			continue;
+
+		if (cap->length < sizeof(struct h263_baseline_codec_cap))
+			continue;
+
+		codec_cap = (void *) cap->data;
+
+		if (codec_cap->media_codec_type != VDP_CODEC_H263_BASELINE)
+			continue;
+
+	}
+
+done:
+	g_idle_add(auto_config, setup);
+	return TRUE;
+}
+
+static struct avdtp_sep_ind h263_baseline_ind = {
+	.get_capability		= h263_baseline_getcap_ind,
+	.set_configuration	= h263_baseline_setconf_ind,
+	.get_configuration	= getconf_ind,
+	.open			= open_ind,
+	.start			= start_ind,
+	.suspend		= suspend_ind,
+	.close			= close_ind,
+	.abort			= abort_ind,
+	.reconfigure		= reconf_ind,
+	.delayreport		= delayreport_ind,
+};
+
+static gboolean mpeg4_getcap_ind(struct avdtp *session,
+				struct avdtp_local_sep *sep, gboolean get_all,
+				GSList **caps, uint8_t *err, void *user_data)
+{
+	struct vdp_sep *vdp_sep = user_data;
+	struct avdtp_service_capability *media_transport, *media_codec;
+	struct mpeg4_codec_cap mpeg4_cap;
+
+	if (vdp_sep->type == AVDTP_SEP_TYPE_SINK)
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
+	memset(&mpeg4_cap, 0, sizeof(struct mpeg4_codec_cap));
+
+	mpeg4_cap.cap.media_type = AVDTP_MEDIA_TYPE_VIDEO;
+	mpeg4_cap.cap.media_codec_type = VDP_CODEC_MPEG4_VISUAL_SAMPLE;
+
+	mpeg4_cap.level = ( MPEG4_LEVEL_0 |
+				MPEG4_LEVEL_1 |
+				MPEG4_LEVEL_2 );
+
+	media_codec = avdtp_service_cap_new(AVDTP_MEDIA_CODEC, &mpeg4_cap,
+						sizeof(mpeg4_cap));
+
+	*caps = g_slist_append(*caps, media_codec);
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
+static gboolean mpeg4_setconf_ind(struct avdtp *session,
+					struct avdtp_local_sep *sep,
+					struct avdtp_stream *stream,
+					GSList *caps,
+					avdtp_set_configuration_cb cb,
+					void *user_data)
+{
+	struct vdp_sep *vdp_sep = user_data;
+	struct vdp_setup *setup;
+
+	if (vdp_sep->type == AVDTP_SEP_TYPE_SINK)
+		DBG("Sink %p: Set_Configuration_Ind", sep);
+	else
+		DBG("Source %p: Set_Configuration_Ind", sep);
+
+	setup = vdp_setup_get(session);
+	if (!setup)
+		return FALSE;
+
+	vdp_sep->stream = stream;
+	setup->sep = vdp_sep;
+	setup->stream = stream;
+	setup->setconf_cb = cb;
+
+	/* Check valid settings */
+	for (; caps != NULL; caps = g_slist_next(caps)) {
+		struct avdtp_service_capability *cap = caps->data;
+		struct avdtp_media_codec_capability *codec_cap;
+
+		if (cap->category == AVDTP_DELAY_REPORTING &&
+					!vdp_sep->delay_reporting) {
+			setup->err = g_new(struct avdtp_error, 1);
+			avdtp_error_init(setup->err, AVDTP_DELAY_REPORTING,
+						AVDTP_UNSUPPORTED_CONFIGURATION);
+			goto done;
+		}
+
+		if (cap->category != AVDTP_MEDIA_CODEC)
+			continue;
+
+		if (cap->length < sizeof(struct h263_baseline_codec_cap))
+			continue;
+
+		codec_cap = (void *) cap->data;
+
+		if (codec_cap->media_codec_type != VDP_CODEC_H263_BASELINE)
+			continue;
+
+	}
+
+done:
+	g_idle_add(auto_config, setup);
+	return TRUE;
+}
+
+static struct avdtp_sep_ind mpeg4_ind = {
+        .get_capability         = mpeg4_getcap_ind,
+        .set_configuration      = mpeg4_setconf_ind,
+        .get_configuration      = getconf_ind,
+        .open                   = open_ind,
+        .start                  = start_ind,
+        .suspend                = suspend_ind,
+        .close                  = close_ind,
+        .abort                  = abort_ind,
+        .reconfigure            = reconf_ind,
+        .delayreport            = delayreport_ind,
+};
+
+static gboolean h263_profile3_getcap_ind(struct avdtp *session,
+				struct avdtp_local_sep *sep, gboolean get_all,
+				GSList **caps, uint8_t *err, void *user_data)
+{
+	struct vdp_sep *vdp_sep = user_data;
+	struct avdtp_service_capability *media_transport, *media_codec;
+	struct h263_profile3_codec_cap h263_cap;
+
+	if (vdp_sep->type == AVDTP_SEP_TYPE_SINK)
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
+	memset(&h263_cap, 0, sizeof(struct h263_profile3_codec_cap));
+
+	h263_cap.cap.media_type = AVDTP_MEDIA_TYPE_VIDEO;
+	h263_cap.cap.media_codec_type = VDP_CODEC_H263_PROFILE_3;
+
+	h263_cap.level = ( H263_LEVEL_10 |
+				H263_LEVEL_20 |
+				H263_LEVEL_30 );
+
+	media_codec = avdtp_service_cap_new(AVDTP_MEDIA_CODEC, &h263_cap,
+						sizeof(h263_cap));
+
+	*caps = g_slist_append(*caps, media_codec);
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
+static gboolean h263_profile3_setconf_ind(struct avdtp *session,
+					struct avdtp_local_sep *sep,
+					struct avdtp_stream *stream,
+					GSList *caps,
+					avdtp_set_configuration_cb cb,
+					void *user_data)
+{
+	struct vdp_sep *vdp_sep = user_data;
+	struct vdp_setup *setup;
+
+	if (vdp_sep->type == AVDTP_SEP_TYPE_SINK)
+		DBG("Sink %p: Set_Configuration_Ind", sep);
+	else
+		DBG("Source %p: Set_Configuration_Ind", sep);
+
+	setup = vdp_setup_get(session);
+	if (!setup)
+		return FALSE;
+
+	vdp_sep->stream = stream;
+	setup->sep = vdp_sep;
+	setup->stream = stream;
+	setup->setconf_cb = cb;
+
+	/* Check valid settings */
+	for (; caps != NULL; caps = g_slist_next(caps)) {
+		struct avdtp_service_capability *cap = caps->data;
+		struct avdtp_media_codec_capability *codec_cap;
+
+		if (cap->category == AVDTP_DELAY_REPORTING &&
+					!vdp_sep->delay_reporting) {
+			setup->err = g_new(struct avdtp_error, 1);
+			avdtp_error_init(setup->err, AVDTP_DELAY_REPORTING,
+						AVDTP_UNSUPPORTED_CONFIGURATION);
+			goto done;
+		}
+
+		if (cap->category != AVDTP_MEDIA_CODEC)
+			continue;
+
+		if (cap->length < sizeof(struct h263_profile3_codec_cap))
+			continue;
+
+		codec_cap = (void *) cap->data;
+
+		if (codec_cap->media_codec_type != VDP_CODEC_H263_PROFILE_3)
+			continue;
+
+	}
+
+done:
+	g_idle_add(auto_config, setup);
+	return TRUE;
+}
+
+static struct avdtp_sep_ind h263_profile3_ind = {
+        .get_capability         = h263_profile3_getcap_ind,
+        .set_configuration      = h263_profile3_setconf_ind,
+        .get_configuration      = getconf_ind,
+        .open                   = open_ind,
+        .start                  = start_ind,
+        .suspend                = suspend_ind,
+        .close                  = close_ind,
+        .abort                  = abort_ind,
+        .reconfigure            = reconf_ind,
+        .delayreport            = delayreport_ind,
+};
+
+static gboolean h263_profile8_getcap_ind(struct avdtp *session,
+				struct avdtp_local_sep *sep, gboolean get_all,
+				GSList **caps, uint8_t *err, void *user_data)
+{
+	struct vdp_sep *vdp_sep = user_data;
+	struct avdtp_service_capability *media_transport, *media_codec;
+	struct h263_profile8_codec_cap h263_cap;
+
+	if (vdp_sep->type == AVDTP_SEP_TYPE_SINK)
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
+	memset(&h263_cap, 0, sizeof(struct h263_profile8_codec_cap));
+
+	h263_cap.cap.media_type = AVDTP_MEDIA_TYPE_VIDEO;
+	h263_cap.cap.media_codec_type = VDP_CODEC_H263_PROFILE_8;
+
+	h263_cap.level = ( H263_LEVEL_10 |
+				H263_LEVEL_20 |
+				H263_LEVEL_30 );
+
+	media_codec = avdtp_service_cap_new(AVDTP_MEDIA_CODEC, &h263_cap,
+						sizeof(h263_cap));
+
+	*caps = g_slist_append(*caps, media_codec);
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
+static gboolean h263_profile8_setconf_ind(struct avdtp *session,
+					struct avdtp_local_sep *sep,
+					struct avdtp_stream *stream,
+					GSList *caps,
+					avdtp_set_configuration_cb cb,
+					void *user_data)
+{
+	struct vdp_sep *vdp_sep = user_data;
+	struct vdp_setup *setup;
+
+	if (vdp_sep->type == AVDTP_SEP_TYPE_SINK)
+		DBG("Sink %p: Set_Configuration_Ind", sep);
+	else
+		DBG("Source %p: Set_Configuration_Ind", sep);
+
+	setup = vdp_setup_get(session);
+	if (!setup)
+		return FALSE;
+
+	vdp_sep->stream = stream;
+	setup->sep = vdp_sep;
+	setup->stream = stream;
+	setup->setconf_cb = cb;
+
+	/* Check valid settings */
+	for (; caps != NULL; caps = g_slist_next(caps)) {
+		struct avdtp_service_capability *cap = caps->data;
+		struct avdtp_media_codec_capability *codec_cap;
+
+		if (cap->category == AVDTP_DELAY_REPORTING &&
+					!vdp_sep->delay_reporting) {
+			setup->err = g_new(struct avdtp_error, 1);
+			avdtp_error_init(setup->err, AVDTP_DELAY_REPORTING,
+						AVDTP_UNSUPPORTED_CONFIGURATION);
+			goto done;
+		}
+
+		if (cap->category != AVDTP_MEDIA_CODEC)
+			continue;
+
+		if (cap->length < sizeof(struct h263_profile8_codec_cap))
+			continue;
+
+		codec_cap = (void *) cap->data;
+
+		if (codec_cap->media_codec_type != VDP_CODEC_H263_PROFILE_8)
+			continue;
+
+	}
+
+done:
+	g_idle_add(auto_config, setup);
+	return TRUE;
+}
+
+static struct avdtp_sep_ind h263_profile8_ind = {
+        .get_capability         = h263_profile8_getcap_ind,
+        .set_configuration      = h263_profile8_setconf_ind,
+        .get_configuration      = getconf_ind,
+        .open                   = open_ind,
+        .start                  = start_ind,
+        .suspend                = suspend_ind,
+        .close                  = close_ind,
+        .abort                  = abort_ind,
+        .reconfigure            = reconf_ind,
+        .delayreport            = delayreport_ind,
+};
+
+
+static sdp_record_t *vdp_record(uint8_t type, uint16_t avdtp_ver)
+{
+	sdp_list_t *svclass_id, *pfseq, *apseq, *root;
+	uuid_t root_uuid, l2cap_uuid, avdtp_uuid, vdp_uuid;
+	sdp_profile_desc_t profile[1];
+	sdp_list_t *aproto, *proto[2];
+	sdp_record_t *record;
+	sdp_data_t *psm, *version, *features;
+	uint16_t lp = AVDTP_UUID;
+	uint16_t vdp_ver = 0x0001, feat = 0x000f;
+
+	DBG("VDP record");
+	record = sdp_record_alloc();
+	if (!record)
+		return NULL;
+
+	sdp_uuid16_create(&root_uuid, PUBLIC_BROWSE_GROUP);
+	root = sdp_list_append(0, &root_uuid);
+	sdp_set_browse_groups(record, root);
+
+	if (type == AVDTP_SEP_TYPE_SOURCE)
+		sdp_uuid16_create(&vdp_uuid, VIDEO_SOURCE_SVCLASS_ID);
+	else
+		sdp_uuid16_create(&vdp_uuid, VIDEO_SINK_SVCLASS_ID);
+	svclass_id = sdp_list_append(0, &vdp_uuid);
+	sdp_set_service_classes(record, svclass_id);
+
+	sdp_uuid16_create(&profile[0].uuid, VIDEO_DISTRIBUTION_PROFILE_ID);
+	profile[0].version = vdp_ver;
+	pfseq = sdp_list_append(0, &profile[0]);
+	sdp_set_profile_descs(record, pfseq);
+
+	sdp_uuid16_create(&l2cap_uuid, L2CAP_UUID);
+	proto[0] = sdp_list_append(0, &l2cap_uuid);
+	psm = sdp_data_alloc(SDP_UINT16, &lp);
+	proto[0] = sdp_list_append(proto[0], psm);
+	apseq = sdp_list_append(0, proto[0]);
+
+	sdp_uuid16_create(&avdtp_uuid, AVDTP_UUID);
+	proto[1] = sdp_list_append(0, &avdtp_uuid);
+	version = sdp_data_alloc(SDP_UINT16, &avdtp_ver);
+	proto[1] = sdp_list_append(proto[1], version);
+	apseq = sdp_list_append(apseq, proto[1]);
+
+	aproto = sdp_list_append(0, apseq);
+	sdp_set_access_protos(record, aproto);
+
+	features = sdp_data_alloc(SDP_UINT16, &feat);
+	sdp_attr_add(record, SDP_ATTR_SUPPORTED_FEATURES, features);
+
+	if (type == AVDTP_SEP_TYPE_SOURCE)
+		sdp_set_info_attr(record, "Video Source", 0, 0);
+	else
+		sdp_set_info_attr(record, "Video Sink", 0, 0);
+
+	free(psm);
+	free(version);
+	sdp_list_free(proto[0], 0);
+	sdp_list_free(proto[1], 0);
+	sdp_list_free(apseq, 0);
+	sdp_list_free(pfseq, 0);
+	sdp_list_free(aproto, 0);
+	sdp_list_free(root, 0);
+	sdp_list_free(svclass_id, 0);
+
+	return record;
+}
+
+struct vdp_sep* vdp_add_sep(const bdaddr_t *src, uint8_t type,
+				uint8_t codec, gboolean delay_reporting,
+				struct media_endpoint *endpoint, int *err)
+{
+	struct vdp_server *server;
+	struct vdp_sep *sep;
+	GSList **l;
+	uint32_t *record_id;
+	sdp_record_t *record;
+	struct avdtp_sep_ind *ind;
+
+	server = find_server(servers, src);
+	if (server == NULL) {
+		if (err)
+			*err = -EINVAL;
+		return NULL;
+	}
+
+	if (type == AVDTP_SEP_TYPE_SINK && !server->sink_enabled) {
+		if (err)
+			*err = -EPROTONOSUPPORT;
+		return NULL;
+	}
+
+	if (type == AVDTP_SEP_TYPE_SOURCE && !server->source_enabled) {
+		if (err)
+			*err = -EPROTONOSUPPORT;
+		return NULL;
+	}
+
+	sep = g_new0(struct vdp_sep, 1);
+
+	if (endpoint) {
+		ind = &endpoint_ind;
+		goto proceed;
+	}
+
+	switch (codec) {
+		case VDP_CODEC_H263_BASELINE:
+			ind = &h263_baseline_ind;
+			break;
+		case VDP_CODEC_MPEG4_VISUAL_SAMPLE:
+			ind = &mpeg4_ind;
+			break;
+		case VDP_CODEC_H263_PROFILE_3:
+			ind = &h263_profile3_ind;
+			break;
+		case VDP_CODEC_H263_PROFILE_8:
+			ind = &h263_profile8_ind;
+			break;
+		default :
+			*err = -EINVAL;
+			return NULL;
+	}
+
+proceed:
+	sep->lsep = avdtp_register_sep(&server->src, type,
+					AVDTP_MEDIA_TYPE_VIDEO, codec,
+					delay_reporting, ind,&cfm, sep);
+	if (sep->lsep == NULL) {
+		g_free(sep);
+		if (err)
+			*err = -EINVAL;
+		return NULL;
+	}
+
+	sep->server = server;
+	sep->endpoint = endpoint;
+	sep->codec = codec;
+	sep->type = type;
+	sep->delay_reporting = delay_reporting;
+
+	if (type == AVDTP_SEP_TYPE_SOURCE) {
+		l = &server->sources;
+		record_id = &server->source_record_id;
+	} else {
+		l = &server->sinks;
+		record_id = &server->sink_record_id;
+	}
+
+	if (*record_id != 0)
+		goto add;
+
+	record = vdp_record(type, server->version);
+	if (!record) {
+		error("Unable to allocate new service record");
+		avdtp_unregister_sep(sep->lsep);
+		g_free(sep);
+		if (err)
+			*err = -EINVAL;
+		return NULL;
+	}
+
+	if (add_record_to_server(&server->src, record) < 0) {
+		error("Unable to register VDP service record");
+		sdp_record_free(record);
+		avdtp_unregister_sep(sep->lsep);
+		g_free(sep);
+		if (err)
+			*err = -EINVAL;
+		return NULL;
+	}
+	*record_id = record->handle;
+
+add:
+	*l = g_slist_append(*l, sep);
+
+	if (err)
+		*err = 0;
+	return sep;
+}
+
+int vdp_register(DBusConnection *conn, const bdaddr_t *src, GKeyFile *config)
+{
+	int h263_baseline_srcs = 1, h263_baseline_sinks = 1;
+	int mpeg4_srcs = 0, mpeg4_sinks = 0;
+	int h263_profile3_srcs = 0, h263_profile3_sinks = 0;
+	int h263_profile8_srcs = 0, h263_profile8_sinks = 0;
+	gboolean source = TRUE, sink = FALSE;
+	struct vdp_server *server;
+	int i;
+	char *str;
+	GError *err = NULL;
+
+	if (!config)
+		goto proceed;
+
+	str = g_key_file_get_string(config, "General", "Enable", &err);
+
+	if (err) {
+		DBG("audio.conf: %s", err->message);
+		g_clear_error(&err);
+	} else {
+		if (strstr(str, "VideoSink"))
+			source = TRUE;
+		if (strstr(str, "VideoSource"))
+			sink = TRUE;
+		g_free(str);
+	}
+
+	str = g_key_file_get_string(config, "General", "Disable", &err);
+
+	if (err) {
+		DBG("audio.conf: %s", err->message);
+		g_clear_error(&err);
+	} else {
+		if (strstr(str, "VideoSink"))
+			source = FALSE;
+		if (strstr(str, "VideoSource"))
+			sink = FALSE;
+		g_free(str);
+	}
+
+	str = g_key_file_get_string(config, "VDP", "H263BaselineSources", &err);
+	if (err) {
+		DBG("audio.conf: %s", err->message);
+		g_clear_error(&err);
+	} else {
+		h263_baseline_srcs = atoi(str);
+		g_free(str);
+	}
+
+	str = g_key_file_get_string(config, "VDP", "MPEG4Sources", &err);
+	if (err) {
+		DBG("audio.conf: %s", err->message);
+		g_clear_error(&err);
+	} else {
+		mpeg4_srcs = atoi(str);
+		g_free(str);
+	}
+
+	str = g_key_file_get_string(config, "VDP", "H263Profile3Sources", &err);
+        if (err) {
+                DBG("audio.conf: %s", err->message);
+                g_clear_error(&err);
+        } else {
+                h263_profile3_srcs = atoi(str);
+                g_free(str);
+        }
+        
+        str = g_key_file_get_string(config, "VDP", "H263Profile8Sources", &err);
+        if (err) {
+                DBG("audio.conf: %s", err->message);
+                g_clear_error(&err);
+        } else {
+                h263_profile8_srcs = atoi(str);
+                g_free(str);
+        }
+
+	str = g_key_file_get_string(config, "VDP", "H263BaselineSinks", &err);
+	if (err) {
+		DBG("audio.conf: %s", err->message);
+		g_clear_error(&err);
+	} else {
+		h263_baseline_sinks = atoi(str);
+		g_free(str);
+	}
+
+	str = g_key_file_get_string(config, "VDP", "MPEG4Sinks", &err);
+	if (err) {
+		DBG("audio.conf: %s", err->message);
+		g_clear_error(&err);
+	} else {
+		mpeg4_sinks = atoi(str);
+		g_free(str);
+	}
+
+	str = g_key_file_get_string(config, "VDP", "H263Profile3Sinks", &err);
+        if (err) {
+                DBG("audio.conf: %s", err->message);
+                g_clear_error(&err);
+        } else {
+                h263_profile3_sinks = atoi(str);
+                g_free(str);
+        }
+
+        str = g_key_file_get_string(config, "VDP", "H263Profile8Sinks", &err);
+        if (err) {
+                DBG("audio.conf: %s", err->message);
+                g_clear_error(&err);
+        } else {
+                h263_profile8_sinks = atoi(str);
+                g_free(str);
+        }
+
+proceed:
+
+	if(!conn)
+		connection = dbus_connection_ref(conn);
+	server = find_server(servers, src);
+
+	if (!server) {
+		int av_err;
+
+		server = g_new0(struct vdp_server, 1);
+		if (!server)
+			return -ENOMEM;
+
+		av_err = avdtp_init(src, config, &server->version);
+		if (av_err < 0) {
+			g_free(server);
+			return av_err;
+		}
+
+		bacpy(&server->src, src);
+		servers = g_slist_append(servers, server);
+	}
+
+	server->source_enabled = source;
+	if (source) {
+		for (i = 0; i < h263_baseline_srcs; i++)
+			vdp_add_sep(src, AVDTP_SEP_TYPE_SOURCE,
+				VDP_CODEC_H263_BASELINE, FALSE,
+								NULL, NULL);
+		
+		for (i = 0; i < mpeg4_srcs; i++)
+			vdp_add_sep(src, AVDTP_SEP_TYPE_SOURCE,
+				VDP_CODEC_MPEG4_VISUAL_SAMPLE, FALSE,
+								NULL, NULL);
+		
+		for (i = 0; i < h263_profile3_srcs; i++)
+			vdp_add_sep(src, AVDTP_SEP_TYPE_SOURCE,
+                                VDP_CODEC_H263_PROFILE_3, FALSE, NULL, NULL);
+
+		for (i = 0; i < h263_profile3_srcs; i++)
+			vdp_add_sep(src, AVDTP_SEP_TYPE_SOURCE,
+                                VDP_CODEC_H263_PROFILE_8, FALSE, NULL, NULL);
+	}
+	server->sink_enabled = sink;
+	if (sink) {
+		for (i = 0; i < h263_baseline_sinks; i++)
+			vdp_add_sep(src, AVDTP_SEP_TYPE_SINK,
+				VDP_CODEC_H263_BASELINE, FALSE, NULL, NULL);
+		
+		for (i = 0; i < mpeg4_sinks; i++)
+			vdp_add_sep(src, AVDTP_SEP_TYPE_SINK,
+                                VDP_CODEC_MPEG4_VISUAL_SAMPLE, FALSE,
+								NULL, NULL);
+
+		for (i = 0; i < h263_profile3_sinks; i++)
+			vdp_add_sep(src, AVDTP_SEP_TYPE_SINK,
+                                VDP_CODEC_H263_PROFILE_3, FALSE, NULL, NULL);
+
+		for (i = 0; i < h263_profile8_sinks; i++)
+			vdp_add_sep(src, AVDTP_SEP_TYPE_SINK,
+                                VDP_CODEC_H263_PROFILE_8, FALSE, NULL, NULL);
+	}
+
+	return 0;
+}
+
+static void vdp_unregister_sep(struct vdp_sep *sep)
+{
+	if (sep->endpoint) {
+		media_endpoint_release(sep->endpoint);
+		sep->endpoint = NULL;
+	}
+
+	avdtp_unregister_sep(sep->lsep);
+	g_free(sep);
+}
+
+void vdp_remove_sep(struct vdp_sep *sep)
+{
+	struct vdp_server *server = sep->server;
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
+	vdp_unregister_sep(sep);
+}
+
+void vdp_unregister(const bdaddr_t *src)
+{
+	struct vdp_server *server;
+
+	server = find_server(servers, src);
+	if (!server)
+		return;
+
+	g_slist_foreach(server->sinks, (GFunc) vdp_remove_sep, NULL);
+	g_slist_free(server->sinks);
+
+	g_slist_foreach(server->sources, (GFunc) vdp_remove_sep, NULL);
+	g_slist_free(server->sources);
+
+	avdtp_exit(src);
+
+	servers = g_slist_remove(servers, server);
+	g_free(server);
+
+	if (servers)
+		return;
+
+	dbus_connection_unref(connection);
+	connection = NULL;
+}
+
+gboolean vdp_cancel(struct audio_device *dev, unsigned int id)
+{
+	struct vdp_setup *setup;
+	GSList *l;
+
+	DBG("");
+	
+	setup = find_setup_by_dev(dev);
+	if (!setup)
+		return FALSE;
+
+	for (l = setup->cb; l != NULL; l = g_slist_next(l)) {
+		struct vdp_setup_cb *cb = l->data;
+
+		if (cb->id != id)
+			continue;
+
+		setup_ref(setup);
+		setup_cb_free(cb);
+
+		if (!setup->cb) {
+			DBG("aborting setup %p", setup);
+			avdtp_abort(setup->session, setup->stream);
+			return TRUE;
+		}
+
+		setup_unref(setup);
+		return TRUE;
+	}
+
+	return FALSE;
+}
diff --git a/audio/vdp.h b/audio/vdp.h
new file mode 100755
index 0000000..daf7168
--- /dev/null
+++ b/audio/vdp.h
@@ -0,0 +1,92 @@
+/*
+ *
+ *  BlueZ - Bluetooth protocol stack for Linux
+ *
+ *  Copyright (C) 2006-2010  Nokia Corporation
+ *  Copyright (C) 2004-2010  Marcel Holtmann <marcel@holtmann.org>
+ *
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation; either version 2 of the License, or
+ *  (at your option) any later version.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program; if not, write to the Free Software
+ *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
+ *
+ */
+
+#define VDP_CODEC_H263_BASELINE		0x01
+#define VDP_CODEC_MPEG4_VISUAL_SAMPLE	0x02
+#define VDP_CODEC_H263_PROFILE_3	0x03
+#define VDP_CODEC_H263_PROFILE_8	0x04
+
+#define H263_LEVEL_10			(1 << 7)
+#define H263_LEVEL_20			(1 << 6)
+#define H263_LEVEL_30			(1 << 5)
+
+#define MPEG4_LEVEL_0			(1 << 7)
+#define MPEG4_LEVEL_1			(1 << 6)
+#define MPEG4_LEVEL_2			(1 << 5)
+
+struct h263_baseline_codec_cap {
+        struct avdtp_media_codec_capability cap;
+        uint8_t level;
+} __attribute__ ((packed));
+ 
+struct h263_profile3_codec_cap {
+	struct avdtp_media_codec_capability cap;
+	uint8_t level;
+} __attribute__ ((packed));
+
+struct h263_profile8_codec_cap {
+	struct avdtp_media_codec_capability cap;
+	uint8_t level;
+} __attribute__ ((packed));
+
+struct mpeg4_codec_cap {
+	struct avdtp_media_codec_capability cap;
+	uint8_t level;
+} __attribute__ ((packed));
+
+struct vdp_sep;
+
+typedef void (*vdp_select_cb_t) (struct avdtp *session,
+					struct vdp_sep *sep, GSList *caps,
+					void *user_data);
+typedef void (*vdp_config_cb_t) (struct avdtp *session, struct vdp_sep *sep,
+					struct avdtp_stream *stream,
+					struct avdtp_error *err,
+					void *user_data);
+typedef void (*vdp_stream_cb_t) (struct avdtp *session,
+					struct avdtp_error *err,
+					void *user_data);
+
+int vdp_register(DBusConnection *conn, const bdaddr_t *src, GKeyFile *config);
+void vdp_unregister(const bdaddr_t *src);
+struct vdp_sep *vdp_add_sep(const bdaddr_t *src, uint8_t type,
+				uint8_t codec, gboolean delay_reporting,
+				struct media_endpoint *endpoint, int *err);
+void vdp_remove_sep(struct vdp_sep *sep);
+
+struct vdp_sep *vdp_get(struct avdtp *session, struct avdtp_remote_sep *sep);
+
+unsigned int vdp_select_capabilities(struct avdtp *session, uint8_t type,
+					const char *sender, vdp_select_cb_t cb,
+					void *user_data);
+unsigned int vdp_config(struct avdtp *session, struct vdp_sep *sep,
+				vdp_config_cb_t cb, GSList *caps,
+				void *user_data);
+gboolean vdp_sep_lock(struct vdp_sep *sep, struct avdtp *session);
+gboolean vdp_sep_unlock(struct vdp_sep *sep, struct avdtp *session);
+gboolean vdp_sep_get_lock(struct vdp_sep *sep);
+struct avdtp_stream *vdp_sep_get_stream(struct vdp_sep *sep);
+struct vdp_sep *vdp_get_sep(struct avdtp *session,
+				struct avdtp_stream *stream);
+gboolean vdp_cancel(struct audio_device *dev, unsigned int id);
-- 
1.7.3.4

