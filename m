Return-Path: <cyrus@holtmann.org>
From: Prasad Bhat <prasadbhat22@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 2/2] This is the vdp implemention after refactoring the code.
Date: Tue, 23 Aug 2011 07:52:18 -0400
Message-Id: <1314100338-13410-2-git-send-email-prasadbhat22@gmail.com>
In-Reply-To: <1314100338-13410-1-git-send-email-prasadbhat22@gmail.com>
References: <1314100338-13410-1-git-send-email-prasadbhat22@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Prasad Bhat <prasadbhat22@.gmail.com>

---
 audio/vdp.c |  987 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 audio/vdp.h |   62 ++++
 2 files changed, 1049 insertions(+), 0 deletions(-)
 create mode 100755 audio/vdp.c
 create mode 100755 audio/vdp.h

diff --git a/audio/vdp.c b/audio/vdp.c
new file mode 100755
index 0000000..7541d4f
--- /dev/null
+++ b/audio/vdp.c
@@ -0,0 +1,987 @@
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
+#include "vdp.h"
+#include "sdpd.h"
+
+#define RECONFIGURE_TIMEOUT 500
+#define SUSPEND_TIMEOUT 5
+
+static DBusConnection *connection = NULL;
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
+
+unsigned int vdp_config(struct avdtp *session, struct sep *sep,
+				avdtp_config_cb_t cb, GSList *caps,
+				void *user_data)
+{
+	struct avdtp_setup_cb *cb_data;
+	GSList *l;
+	struct avdtp_server *server;
+	struct avdtp_setup *setup;
+	struct sep *tmp;
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
+	setup = setup_get(session);
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
+			if (sep_get_lock(tmp))
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
+static gboolean select_capabilities(struct avdtp *session,
+                                        struct avdtp_remote_sep *rsep,
+                                        GSList **caps)
+{
+        struct avdtp_service_capability *media_transport, *media_codec;
+        struct h263_baseline_codec_cap h263_cap;
+
+        media_codec = avdtp_get_codec(rsep);
+        if (!media_codec)
+                return FALSE;
+
+        select_h263_params(&h263_cap, (struct h263_baseline_codec_cap *) media_codec->data);
+
+        media_transport = avdtp_service_cap_new(AVDTP_MEDIA_TRANSPORT,
+                                                NULL, 0);
+
+        *caps = g_slist_append(*caps, media_transport);
+
+        media_codec = avdtp_service_cap_new(AVDTP_MEDIA_CODEC, &h263_cap,
+                                                sizeof(h263_cap));
+
+        *caps = g_slist_append(*caps, media_codec);
+
+        if (avdtp_get_delay_reporting(rsep)) {
+                struct avdtp_service_capability *delay_reporting;
+                delay_reporting = avdtp_service_cap_new(AVDTP_DELAY_REPORTING,
+                                                                NULL, 0);
+                *caps = g_slist_append(*caps, delay_reporting);
+        }
+
+        return TRUE;
+}
+
+static void finalize_select(struct avdtp_setup *s)
+{
+        GSList *l;
+
+        DBG("");
+        
+        for (l = s->cb; l != NULL; ) {
+                struct avdtp_setup_cb *cb = l->data;
+
+                l = l->next;
+
+                if (!cb->select_cb)
+                        continue;
+
+                cb->select_cb(s->session, s->sep, s->caps, cb->user_data);
+                setup_cb_free(cb);
+        }
+}
+
+static gboolean auto_select(gpointer data)
+{
+        struct avdtp_setup *setup = data;
+
+        finalize_select(setup);
+
+        return FALSE;
+}
+
+static void select_cb(struct sep *sep, guint setup_id, void *ret,
+                                                                int size)
+{
+        struct avdtp_setup *setup = GUINT_TO_POINTER(setup_id);
+        struct avdtp_service_capability *media_transport, *media_codec;
+        struct avdtp_media_codec_capability *cap;
+
+        if (size < 0) {
+                DBG("Endpoint replied an invalid configuration");
+                goto done;
+        }
+
+        media_transport = avdtp_service_cap_new(AVDTP_MEDIA_TRANSPORT,
+                                                NULL, 0);
+
+        setup->caps = g_slist_append(setup->caps, media_transport);
+
+        cap = g_malloc0(sizeof(*cap) + size);
+        cap->media_type = AVDTP_MEDIA_TYPE_VIDEO;
+        cap->media_codec_type = setup->sep->codec;
+        memcpy(cap->data, ret, size);
+
+        media_codec = avdtp_service_cap_new(AVDTP_MEDIA_CODEC, cap,
+                                                sizeof(*cap) + size);
+
+        setup->caps = g_slist_append(setup->caps, media_codec);
+        g_free(cap);
+
+done:
+        finalize_select(setup);
+}
+
+unsigned int vdp_select_capabilities(struct avdtp *session,
+					uint8_t type, const char *sender,
+					avdtp_select_cb_t cb,
+					void *user_data)
+{
+	struct avdtp_setup *setup;
+	struct avdtp_setup_cb *cb_data;
+	struct sep *sep;
+	struct avdtp_service_capability *service;
+	struct avdtp_media_codec_capability *codec;
+	int err;
+
+	DBG("");
+	
+	sep = select_sep(session, type, sender);
+	if (!sep) {
+		error("Unable to select SEP");
+		return 0;
+	}
+
+	setup = setup_get(session);
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
+	err = sep->endpoint->select_configuration(sep, codec->data,
+					service->length - sizeof(*codec),
+					GPOINTER_TO_UINT(setup),
+					select_cb, sep->user_data);
+	if (err == 0)
+		return cb_data->id;
+
+fail:
+	setup_cb_free(cb_data);
+	return 0;
+
+}
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
+	struct sep *vdp_sep = user_data;
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
+	struct sep *vdp_sep = user_data;
+	struct avdtp_setup *setup;
+
+	if (vdp_sep->type == AVDTP_SEP_TYPE_SINK)
+		DBG("Sink %p: Set_Configuration_Ind", sep);
+	else
+		DBG("Source %p: Set_Configuration_Ind", sep);
+
+	setup = setup_get(session);
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
+	struct sep *vdp_sep = user_data;
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
+	struct sep *vdp_sep = user_data;
+	struct avdtp_setup *setup;
+
+	if (vdp_sep->type == AVDTP_SEP_TYPE_SINK)
+		DBG("Sink %p: Set_Configuration_Ind", sep);
+	else
+		DBG("Source %p: Set_Configuration_Ind", sep);
+
+	setup = setup_get(session);
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
+struct sep *vdp_add_sep(const bdaddr_t *src, uint8_t type,
+				uint8_t codec, gboolean delay_reporting,
+				struct avdtp_endpoint *endpoint,
+				void *user_data, GDestroyNotify destroy,
+				int *err)
+{
+	struct avdtp_server *server;
+	struct sep *sep;
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
+	sep = g_new0(struct sep, 1);
+
+	if (endpoint) {
+		ind = &endpoint_ind;
+		goto proceed;
+	}
+
+	ind = (codec == VDP_CODEC_H263_BASELINE) ? &h263_baseline_ind: &mpeg4_ind;
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
+	sep->user_data = user_data;
+	sep->destroy = destroy;
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
+	gboolean source = TRUE, sink = FALSE;
+	struct avdtp_server *server;
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
+proceed:
+
+	if(!conn)
+		connection = dbus_connection_ref(conn);
+	server = find_server(servers, src);
+
+	if (!server) {
+		int av_err;
+
+		server = g_new0(struct avdtp_server, 1);
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
+					NULL, NULL, NULL, NULL);
+		
+		for (i = 0; i < mpeg4_srcs; i++)
+			vdp_add_sep(src, AVDTP_SEP_TYPE_SOURCE,
+				VDP_CODEC_MPEG4_VISUAL_SAMPLE, FALSE,
+					NULL, NULL, NULL, NULL);
+	}
+	server->sink_enabled = sink;
+	if (sink) {
+		for (i = 0; i < h263_baseline_sinks; i++)
+			vdp_add_sep(src, AVDTP_SEP_TYPE_SINK,
+				VDP_CODEC_H263_BASELINE, FALSE, 
+					NULL, NULL, NULL, NULL);
+		
+		for (i = 0; i < mpeg4_sinks; i++)
+			vdp_add_sep(src, AVDTP_SEP_TYPE_SINK,
+                                VDP_CODEC_MPEG4_VISUAL_SAMPLE, FALSE,
+					NULL, NULL, NULL, NULL);
+	}
+
+	return 0;
+}
+
+void vdp_unregister(const bdaddr_t *src)
+{
+	struct avdtp_server *server;
+
+	server = find_server(servers, src);
+	if (!server)
+		return;
+
+	g_slist_foreach(server->sinks, (GFunc) remove_sep, NULL);
+	g_slist_free(server->sinks);
+
+	g_slist_foreach(server->sources, (GFunc) remove_sep, NULL);
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
+	struct avdtp_setup *setup;
+	GSList *l;
+
+	DBG("");
+	
+	setup = find_setup_by_dev(dev);
+	if (!setup)
+		return FALSE;
+
+	for (l = setup->cb; l != NULL; l = g_slist_next(l)) {
+		struct avdtp_setup_cb *cb = l->data;
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
index 0000000..1fa4dcd
--- /dev/null
+++ b/audio/vdp.h
@@ -0,0 +1,62 @@
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
+#include "sep.h"
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
+struct mpeg4_codec_cap {
+	struct avdtp_media_codec_capability cap;
+	uint8_t level;
+} __attribute__ ((packed));
+
+int vdp_register(DBusConnection *conn, const bdaddr_t *src, GKeyFile *config);
+void vdp_unregister(const bdaddr_t *src);
+struct sep *vdp_add_sep(const bdaddr_t *src, uint8_t type,
+				uint8_t codec, gboolean delay_reporting,
+				struct avdtp_endpoint *endpoint,
+				void *user_data, GDestroyNotify destroy,
+				int *err);
+unsigned int vdp_select_capabilities(struct avdtp *session, uint8_t type,
+					const char *sender, avdtp_select_cb_t cb,
+					void *user_data);
+unsigned int vdp_config(struct avdtp *session, struct sep *sep,
+				avdtp_config_cb_t cb, GSList *caps,
+				void *user_data);
+gboolean vdp_cancel(struct audio_device *dev, unsigned int id);
-- 
1.7.3.4

