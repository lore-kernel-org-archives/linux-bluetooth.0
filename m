Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 06/10] Add initial implementation of org.bluez.Media spec
Date: Mon, 13 Sep 2010 17:15:33 +0300
Message-Id: <1284387337-18822-7-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1284387337-18822-1-git-send-email-luiz.dentz@gmail.com>
References: <1284387337-18822-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.dentz-von@nokia.com>

---
 Makefile.am       |    2 +
 audio/a2dp.c      |  726 ++++++++++++++++++++++++++++++++++++++++++++---------
 audio/a2dp.h      |   15 ++
 audio/avdtp.c     |   88 +++----
 audio/avdtp.h     |    5 +-
 audio/manager.c   |   54 ++++
 audio/manager.h   |    1 +
 audio/media.c     |  683 +++++++++++++++++++++++++++++++++++++++++++++++++
 audio/media.h     |   52 ++++
 audio/sink.c      |  179 ++------------
 audio/source.c    |  174 ++-----------
 audio/transport.c |  671 +++++++++++++++++++++++++++++++++++++++++++++++++
 audio/transport.h |   34 +++
 audio/unix.c      |    1 +
 14 files changed, 2198 insertions(+), 487 deletions(-)
 create mode 100644 audio/media.c
 create mode 100644 audio/media.h
 create mode 100644 audio/transport.c
 create mode 100644 audio/transport.h

diff --git a/Makefile.am b/Makefile.am
index 46f5449..347205e 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -139,6 +139,8 @@ builtin_sources += audio/main.c \
 			audio/avdtp.h audio/avdtp.c \
 			audio/ipc.h audio/ipc.c \
 			audio/unix.h audio/unix.c \
+			audio/media.h audio/media.c \
+			audio/transport.h audio/transport.c \
 			audio/telephony.h
 builtin_nodist += audio/telephony.c
 
diff --git a/audio/a2dp.c b/audio/a2dp.c
index ef0df17..e6daf3b 100644
--- a/audio/a2dp.c
+++ b/audio/a2dp.c
@@ -43,6 +43,7 @@
 #include "sink.h"
 #include "source.h"
 #include "unix.h"
+#include "media.h"
 #include "a2dp.h"
 #include "sdpd.h"
 
@@ -60,9 +61,11 @@
 #endif
 
 struct a2dp_sep {
+	struct a2dp_server *server;
+	struct media_endpoint *endpoint;
 	uint8_t type;
 	uint8_t codec;
-	struct avdtp_local_sep *sep;
+	struct avdtp_local_sep *lsep;
 	struct avdtp *session;
 	struct avdtp_stream *stream;
 	guint suspend_timer;
@@ -73,6 +76,7 @@ struct a2dp_sep {
 };
 
 struct a2dp_setup_cb {
+	a2dp_select_cb_t select_cb;
 	a2dp_config_cb_t config_cb;
 	a2dp_stream_cb_t resume_cb;
 	a2dp_stream_cb_t suspend_cb;
@@ -84,6 +88,7 @@ struct a2dp_setup {
 	struct audio_device *dev;
 	struct avdtp *session;
 	struct a2dp_sep *sep;
+	struct avdtp_remote_sep *rsep;
 	struct avdtp_stream *stream;
 	struct avdtp_error *err;
 	GSList *client_caps;
@@ -150,11 +155,11 @@ static struct audio_device *a2dp_get_dev(struct avdtp *session)
 static gboolean finalize_config(struct a2dp_setup *s)
 {
 	GSList *l;
+	struct avdtp_stream *stream = s->err ? NULL : s->stream;
 
 	setup_ref(s);
 	for (l = s->cb; l != NULL; l = l->next) {
 		struct a2dp_setup_cb *cb = l->data;
-		struct avdtp_stream *stream = s->err ? NULL : s->stream;
 
 		if (!cb->config_cb)
 			continue;
@@ -166,6 +171,7 @@ static gboolean finalize_config(struct a2dp_setup *s)
 	}
 
 	setup_unref(s);
+
 	return FALSE;
 }
 
@@ -184,6 +190,7 @@ static gboolean finalize_resume(struct a2dp_setup *s)
 	GSList *l;
 
 	setup_ref(s);
+
 	for (l = s->cb; l != NULL; l = l->next) {
 		struct a2dp_setup_cb *cb = l->data;
 
@@ -195,6 +202,7 @@ static gboolean finalize_resume(struct a2dp_setup *s)
 	}
 
 	setup_unref(s);
+
 	return FALSE;
 }
 
@@ -227,6 +235,25 @@ static gboolean finalize_suspend_errno(struct a2dp_setup *s, int err)
 	return finalize_suspend(s);
 }
 
+static gboolean finalize_select(struct a2dp_setup *s, GSList *caps)
+{
+	GSList *l;
+
+	setup_ref(s);
+	for (l = s->cb; l != NULL; l = l->next) {
+		struct a2dp_setup_cb *cb = l->data;
+
+		if (cb->select_cb) {
+			cb->select_cb(s->session, s->sep, caps, cb->user_data);
+			cb->select_cb = NULL;
+			setup_unref(s);
+		}
+	}
+
+	setup_unref(s);
+	return FALSE;
+}
+
 static struct a2dp_setup *find_setup_by_session(struct avdtp *session)
 {
 	GSList *l;
@@ -276,6 +303,9 @@ static void stream_state_changed(struct avdtp_stream *stream,
 		sep->session = NULL;
 	}
 
+	if (sep->endpoint)
+		media_endpoint_clear_configuration(sep->endpoint);
+
 	sep->stream = NULL;
 
 }
@@ -505,6 +535,117 @@ static gboolean mpeg_getcap_ind(struct avdtp *session,
 	return TRUE;
 }
 
+static gboolean endpoint_setconf_ind(struct avdtp *session,
+					struct avdtp_local_sep *sep,
+					struct avdtp_stream *stream,
+					GSList *caps, uint8_t *err,
+					uint8_t *category, void *user_data)
+{
+	struct a2dp_sep *a2dp_sep = user_data;
+	struct audio_device *dev;
+
+	if (a2dp_sep->type == AVDTP_SEP_TYPE_SINK)
+		DBG("Sink %p: Set_Configuration_Ind", sep);
+	else
+		DBG("Source %p: Set_Configuration_Ind", sep);
+
+	dev = a2dp_get_dev(session);
+	if (!dev) {
+		*err = AVDTP_UNSUPPORTED_CONFIGURATION;
+		*category = 0x00;
+		return FALSE;
+	}
+
+	for (; caps != NULL; caps = g_slist_next(caps)) {
+		struct avdtp_service_capability *cap = caps->data;
+		struct avdtp_media_codec_capability *codec;
+		gboolean ret;
+
+		if (cap->category == AVDTP_DELAY_REPORTING &&
+					!a2dp_sep->delay_reporting) {
+			*err = AVDTP_UNSUPPORTED_CONFIGURATION;
+			*category = AVDTP_DELAY_REPORTING;
+			return FALSE;
+		}
+
+		if (cap->category != AVDTP_MEDIA_CODEC)
+			continue;
+
+		codec = (struct avdtp_media_codec_capability *) cap->data;
+
+		if (codec->media_codec_type != a2dp_sep->codec) {
+			*err = AVDTP_UNSUPPORTED_CONFIGURATION;
+			*category = AVDTP_MEDIA_CODEC;
+			return FALSE;
+		}
+
+		ret = media_endpoint_set_configuration(a2dp_sep->endpoint, dev,
+					codec->data, cap->length - sizeof(*codec),
+					NULL, NULL);
+		if (ret)
+			break;
+
+		*err = AVDTP_UNSUPPORTED_CONFIGURATION;
+		*category = AVDTP_MEDIA_CODEC;
+		return FALSE;
+	}
+
+	avdtp_stream_add_cb(session, stream, stream_state_changed, a2dp_sep);
+	a2dp_sep->stream = stream;
+
+	if (a2dp_sep->type == AVDTP_SEP_TYPE_SOURCE)
+		sink_new_stream(dev, session, stream);
+
+	return TRUE;
+}
+
+static gboolean endpoint_getcap_ind(struct avdtp *session,
+				struct avdtp_local_sep *sep,
+				gboolean get_all,
+				GSList **caps, uint8_t *err, void *user_data)
+{
+	struct a2dp_sep *a2dp_sep = user_data;
+	struct avdtp_service_capability *media_transport, *media_codec;
+	struct avdtp_media_codec_capability *codec_caps;
+	uint8_t *capabilities;
+	size_t length;
+
+	if (a2dp_sep->type == AVDTP_SEP_TYPE_SINK)
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
+	length = media_endpoint_get_capabilities(a2dp_sep->endpoint,
+						&capabilities);
+
+	codec_caps = g_malloc0(sizeof(*codec_caps) + length);
+	codec_caps->media_type = AVDTP_MEDIA_TYPE_AUDIO;
+	codec_caps->media_codec_type = a2dp_sep->codec;
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
 static void setconf_cfm(struct avdtp *session, struct avdtp_local_sep *sep,
 				struct avdtp_stream *stream,
 				struct avdtp_error *err, void *user_data)
@@ -543,6 +684,23 @@ static void setconf_cfm(struct avdtp *session, struct avdtp_local_sep *sep,
 	else
 		source_new_stream(dev, session, setup->stream);
 
+	/* Notify Endpoint */
+	if (a2dp_sep->endpoint) {
+		struct avdtp_service_capability *service;
+		struct avdtp_media_codec_capability *codec;
+
+		service = avdtp_stream_get_codec(stream);
+		codec = (struct avdtp_media_codec_capability *) service->data;
+
+		if (media_endpoint_set_configuration(a2dp_sep->endpoint, dev,
+						codec->data, service->length -
+						sizeof(*codec), NULL, NULL) ==
+						FALSE) {
+			setup->stream = NULL;
+			finalize_config_errno(setup, -EPERM);
+		}
+	}
+
 	ret = avdtp_open(session, stream);
 	if (ret < 0) {
 		error("Error on avdtp_open %s (%d)", strerror(-ret), -ret);
@@ -761,39 +919,11 @@ static gboolean close_ind(struct avdtp *session, struct avdtp_local_sep *sep,
 static gboolean a2dp_reconfigure(gpointer data)
 {
 	struct a2dp_setup *setup = data;
-	struct avdtp_local_sep *lsep;
-	struct avdtp_remote_sep *rsep;
-	struct avdtp_service_capability *cap;
-	struct avdtp_media_codec_capability *codec_cap = NULL;
-	GSList *l;
+	struct a2dp_sep *sep = setup->sep;
 	int posix_err;
 
-	for (l = setup->client_caps; l != NULL; l = l->next) {
-		cap = l->data;
-
-		if (cap->category != AVDTP_MEDIA_CODEC)
-			continue;
-
-		codec_cap = (void *) cap->data;
-		break;
-	}
-
-	if (!codec_cap) {
-		error("Cannot find capabilities to reconfigure");
-		posix_err = -EINVAL;
-		goto failed;
-	}
-
-	posix_err = avdtp_get_seps(setup->session, AVDTP_SEP_TYPE_SINK,
-					codec_cap->media_type,
-					codec_cap->media_codec_type,
-					&lsep, &rsep);
-	if (posix_err < 0) {
-		error("No matching ACP and INT SEPs found");
-		goto failed;
-	}
-
-	posix_err = avdtp_set_configuration(setup->session, rsep, lsep,
+	posix_err = avdtp_set_configuration(setup->session, setup->rsep,
+						sep->lsep,
 						setup->client_caps,
 						&setup->stream);
 	if (posix_err < 0) {
@@ -975,6 +1105,19 @@ static struct avdtp_sep_ind mpeg_ind = {
 	.delayreport		= delayreport_ind,
 };
 
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
+	.delayreport		= delayreport_ind,
+};
+
 static sdp_record_t *a2dp_record(uint8_t type, uint16_t avdtp_ver)
 {
 	sdp_list_t *svclass_id, *pfseq, *apseq, *root;
@@ -1042,64 +1185,6 @@ static sdp_record_t *a2dp_record(uint8_t type, uint16_t avdtp_ver)
 	return record;
 }
 
-static struct a2dp_sep *a2dp_add_sep(struct a2dp_server *server, uint8_t type,
-					uint8_t codec, gboolean delay_reporting)
-{
-	struct a2dp_sep *sep;
-	GSList **l;
-	uint32_t *record_id;
-	sdp_record_t *record;
-	struct avdtp_sep_ind *ind;
-
-	sep = g_new0(struct a2dp_sep, 1);
-
-	ind = (codec == A2DP_CODEC_MPEG12) ? &mpeg_ind : &sbc_ind;
-	sep->sep = avdtp_register_sep(&server->src, type,
-					AVDTP_MEDIA_TYPE_AUDIO, codec,
-					delay_reporting, ind, &cfm, sep);
-	if (sep->sep == NULL) {
-		g_free(sep);
-		return NULL;
-	}
-
-	sep->codec = codec;
-	sep->type = type;
-	sep->delay_reporting = delay_reporting;
-
-	if (type == AVDTP_SEP_TYPE_SOURCE) {
-		l = &server->sources;
-		record_id = &server->source_record_id;
-	} else {
-		l = &server->sinks;
-		record_id = &server->sink_record_id;
-	}
-
-	if (*record_id != 0)
-		goto add;
-
-	record = a2dp_record(type, server->version);
-	if (!record) {
-		error("Unable to allocate new service record");
-		avdtp_unregister_sep(sep->sep);
-		g_free(sep);
-		return NULL;
-	}
-
-	if (add_record_to_server(&server->src, record) < 0) {
-		error("Unable to register A2DP service record");\
-		sdp_record_free(record);
-		avdtp_unregister_sep(sep->sep);
-		g_free(sep);
-		return NULL;
-	}
-	*record_id = record->handle;
-
-add:
-	*l = g_slist_append(*l, sep);
-
-	return sep;
-}
-
 static struct a2dp_server *find_server(GSList *list, const bdaddr_t *src)
 {
 	GSList *l;
@@ -1220,22 +1305,23 @@ proceed:
 
 	if (source) {
 		for (i = 0; i < sbc_srcs; i++)
-			a2dp_add_sep(server, AVDTP_SEP_TYPE_SOURCE,
-					A2DP_CODEC_SBC, delay_reporting);
+			a2dp_add_sep(src, AVDTP_SEP_TYPE_SOURCE,
+					A2DP_CODEC_SBC, delay_reporting, NULL);
 
 		for (i = 0; i < mpeg12_srcs; i++)
-			a2dp_add_sep(server, AVDTP_SEP_TYPE_SOURCE,
-					A2DP_CODEC_MPEG12, delay_reporting);
+			a2dp_add_sep(src, AVDTP_SEP_TYPE_SOURCE,
+					A2DP_CODEC_MPEG12, delay_reporting, NULL);
 	}
 
 	if (sink) {
 		for (i = 0; i < sbc_sinks; i++)
-			a2dp_add_sep(server, AVDTP_SEP_TYPE_SINK,
-					A2DP_CODEC_SBC, delay_reporting);
+			a2dp_add_sep(src, AVDTP_SEP_TYPE_SINK,
+					A2DP_CODEC_SBC, delay_reporting, NULL);
 
 		for (i = 0; i < mpeg12_sinks; i++)
-			a2dp_add_sep(server, AVDTP_SEP_TYPE_SINK,
-					A2DP_CODEC_MPEG12, delay_reporting);
+			a2dp_add_sep(src, AVDTP_SEP_TYPE_SINK,
+					A2DP_CODEC_MPEG12, delay_reporting,
+					NULL);
 	}
 
 	return 0;
@@ -1243,7 +1329,7 @@ proceed:
 
 static void a2dp_unregister_sep(struct a2dp_sep *sep)
 {
-	avdtp_unregister_sep(sep->sep);
+	avdtp_unregister_sep(sep->lsep);
 	g_free(sep);
 }
 
@@ -1255,20 +1341,14 @@ void a2dp_unregister(const bdaddr_t *src)
 	if (!server)
 		return;
 
-	g_slist_foreach(server->sinks, (GFunc) a2dp_unregister_sep, NULL);
+	g_slist_foreach(server->sinks, (GFunc) a2dp_remove_sep, NULL);
 	g_slist_free(server->sinks);
 
-	g_slist_foreach(server->sources, (GFunc) a2dp_unregister_sep, NULL);
+	g_slist_foreach(server->sources, (GFunc) a2dp_remove_sep, NULL);
 	g_slist_free(server->sources);
 
 	avdtp_exit(src);
 
-	if (server->source_record_id)
-		remove_record_from_server(server->source_record_id);
-
-	if (server->sink_record_id)
-		remove_record_from_server(server->sink_record_id);
-
 	servers = g_slist_remove(servers, server);
 	g_free(server);
 
@@ -1279,6 +1359,100 @@ void a2dp_unregister(const bdaddr_t *src)
 	connection = NULL;
 }
 
+struct a2dp_sep *a2dp_add_sep(const bdaddr_t *src, uint8_t type,
+				uint8_t codec, gboolean delay_reporting,
+				struct media_endpoint *endpoint)
+{
+	struct a2dp_server *server;
+	struct a2dp_sep *sep;
+	GSList **l;
+	uint32_t *record_id;
+	sdp_record_t *record;
+	struct avdtp_sep_ind *ind;
+
+	server = find_server(servers, src);
+	if (server == NULL)
+		return NULL;
+
+	sep = g_new0(struct a2dp_sep, 1);
+
+	if (endpoint) {
+		ind = &endpoint_ind;
+		goto proceed;
+	}
+
+	ind = (codec == A2DP_CODEC_MPEG12) ? &mpeg_ind : &sbc_ind;
+
+proceed:
+	sep->lsep = avdtp_register_sep(&server->src, type,
+					AVDTP_MEDIA_TYPE_AUDIO, codec,
+					delay_reporting, ind, &cfm, sep);
+	if (sep->lsep == NULL) {
+		g_free(sep);
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
+	record = a2dp_record(type, server->version);
+	if (!record) {
+		error("Unable to allocate new service record");
+		avdtp_unregister_sep(sep->lsep);
+		g_free(sep);
+		return NULL;
+	}
+
+	if (add_record_to_server(&server->src, record) < 0) {
+		error("Unable to register A2DP service record");\
+		sdp_record_free(record);
+		avdtp_unregister_sep(sep->lsep);
+		g_free(sep);
+		return NULL;
+	}
+	*record_id = record->handle;
+
+add:
+	*l = g_slist_append(*l, sep);
+
+	return sep;
+}
+
+void a2dp_remove_sep(struct a2dp_sep *sep)
+{
+	struct a2dp_server *server = sep->server;
+
+	if (sep->type == AVDTP_SEP_TYPE_SOURCE) {
+		server->sources = g_slist_remove(server->sources, sep);
+		if (server->sources == NULL && server->source_record_id) {
+			remove_record_from_server(server->source_record_id);
+			server->source_record_id = 0;
+		}
+	} else {
+		server->sinks = g_slist_remove(server->sinks, sep);
+		if (server->sinks == NULL && server->sink_record_id) {
+			remove_record_from_server(server->sink_record_id);
+			server->sink_record_id = 0;
+		}
+	}
+
+	a2dp_unregister_sep(sep);
+}
+
 struct a2dp_sep *a2dp_get(struct avdtp *session,
 				struct avdtp_remote_sep *rsep)
 {
@@ -1317,6 +1491,309 @@ struct a2dp_sep *a2dp_get(struct avdtp *session,
 	return NULL;
 }
 
+static uint8_t default_bitpool(uint8_t freq, uint8_t mode)
+{
+	switch (freq) {
+	case SBC_SAMPLING_FREQ_16000:
+	case SBC_SAMPLING_FREQ_32000:
+		return 53;
+	case SBC_SAMPLING_FREQ_44100:
+		switch (mode) {
+		case SBC_CHANNEL_MODE_MONO:
+		case SBC_CHANNEL_MODE_DUAL_CHANNEL:
+			return 31;
+		case SBC_CHANNEL_MODE_STEREO:
+		case SBC_CHANNEL_MODE_JOINT_STEREO:
+			return 53;
+		default:
+			error("Invalid channel mode %u", mode);
+			return 53;
+		}
+	case SBC_SAMPLING_FREQ_48000:
+		switch (mode) {
+		case SBC_CHANNEL_MODE_MONO:
+		case SBC_CHANNEL_MODE_DUAL_CHANNEL:
+			return 29;
+		case SBC_CHANNEL_MODE_STEREO:
+		case SBC_CHANNEL_MODE_JOINT_STEREO:
+			return 51;
+		default:
+			error("Invalid channel mode %u", mode);
+			return 51;
+		}
+	default:
+		error("Invalid sampling freq %u", freq);
+		return 53;
+	}
+}
+
+static gboolean select_sbc_params(struct sbc_codec_cap *cap,
+					struct sbc_codec_cap *supported)
+{
+	unsigned int max_bitpool, min_bitpool;
+
+	memset(cap, 0, sizeof(struct sbc_codec_cap));
+
+	cap->cap.media_type = AVDTP_MEDIA_TYPE_AUDIO;
+	cap->cap.media_codec_type = A2DP_CODEC_SBC;
+
+	if (supported->frequency & SBC_SAMPLING_FREQ_44100)
+		cap->frequency = SBC_SAMPLING_FREQ_44100;
+	else if (supported->frequency & SBC_SAMPLING_FREQ_48000)
+		cap->frequency = SBC_SAMPLING_FREQ_48000;
+	else if (supported->frequency & SBC_SAMPLING_FREQ_32000)
+		cap->frequency = SBC_SAMPLING_FREQ_32000;
+	else if (supported->frequency & SBC_SAMPLING_FREQ_16000)
+		cap->frequency = SBC_SAMPLING_FREQ_16000;
+	else {
+		error("No supported frequencies");
+		return FALSE;
+	}
+
+	if (supported->channel_mode & SBC_CHANNEL_MODE_JOINT_STEREO)
+		cap->channel_mode = SBC_CHANNEL_MODE_JOINT_STEREO;
+	else if (supported->channel_mode & SBC_CHANNEL_MODE_STEREO)
+		cap->channel_mode = SBC_CHANNEL_MODE_STEREO;
+	else if (supported->channel_mode & SBC_CHANNEL_MODE_DUAL_CHANNEL)
+		cap->channel_mode = SBC_CHANNEL_MODE_DUAL_CHANNEL;
+	else if (supported->channel_mode & SBC_CHANNEL_MODE_MONO)
+		cap->channel_mode = SBC_CHANNEL_MODE_MONO;
+	else {
+		error("No supported channel modes");
+		return FALSE;
+	}
+
+	if (supported->block_length & SBC_BLOCK_LENGTH_16)
+		cap->block_length = SBC_BLOCK_LENGTH_16;
+	else if (supported->block_length & SBC_BLOCK_LENGTH_12)
+		cap->block_length = SBC_BLOCK_LENGTH_12;
+	else if (supported->block_length & SBC_BLOCK_LENGTH_8)
+		cap->block_length = SBC_BLOCK_LENGTH_8;
+	else if (supported->block_length & SBC_BLOCK_LENGTH_4)
+		cap->block_length = SBC_BLOCK_LENGTH_4;
+	else {
+		error("No supported block lengths");
+		return FALSE;
+	}
+
+	if (supported->subbands & SBC_SUBBANDS_8)
+		cap->subbands = SBC_SUBBANDS_8;
+	else if (supported->subbands & SBC_SUBBANDS_4)
+		cap->subbands = SBC_SUBBANDS_4;
+	else {
+		error("No supported subbands");
+		return FALSE;
+	}
+
+	if (supported->allocation_method & SBC_ALLOCATION_LOUDNESS)
+		cap->allocation_method = SBC_ALLOCATION_LOUDNESS;
+	else if (supported->allocation_method & SBC_ALLOCATION_SNR)
+		cap->allocation_method = SBC_ALLOCATION_SNR;
+
+	min_bitpool = MAX(MIN_BITPOOL, supported->min_bitpool);
+	max_bitpool = MIN(default_bitpool(cap->frequency, cap->channel_mode),
+							supported->max_bitpool);
+
+	cap->min_bitpool = min_bitpool;
+	cap->max_bitpool = max_bitpool;
+
+	return TRUE;
+}
+
+static gboolean select_capabilities(struct avdtp *session,
+					struct avdtp_remote_sep *rsep,
+					GSList **caps)
+{
+	struct avdtp_service_capability *media_transport, *media_codec;
+	struct sbc_codec_cap sbc_cap;
+
+	media_codec = avdtp_get_codec(rsep);
+	if (!media_codec)
+		return FALSE;
+
+	select_sbc_params(&sbc_cap, (struct sbc_codec_cap *) media_codec->data);
+
+	media_transport = avdtp_service_cap_new(AVDTP_MEDIA_TRANSPORT,
+						NULL, 0);
+
+	*caps = g_slist_append(*caps, media_transport);
+
+	media_codec = avdtp_service_cap_new(AVDTP_MEDIA_CODEC, &sbc_cap,
+						sizeof(sbc_cap));
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
+	struct a2dp_setup *setup = user_data;
+	struct avdtp_service_capability *media_transport, *media_codec;
+	struct avdtp_media_codec_capability *cap;
+	GSList *caps = NULL;
+
+	if (size < 0) {
+		DBG("Endpoint replied an invalid configuration");
+		goto done;
+	}
+
+	media_transport = avdtp_service_cap_new(AVDTP_MEDIA_TRANSPORT,
+						NULL, 0);
+
+	caps = g_slist_append(caps, media_transport);
+
+	cap = g_malloc0(sizeof(*cap) + size);
+	cap->media_type = AVDTP_MEDIA_TYPE_AUDIO;
+	cap->media_codec_type = setup->sep->codec;
+	memcpy(cap->data, ret, size);
+
+	media_codec = avdtp_service_cap_new(AVDTP_MEDIA_CODEC, cap,
+						sizeof(*cap) + size);
+
+	caps = g_slist_append(caps, media_codec);
+
+done:
+	finalize_select(setup, caps);
+}
+
+static gboolean auto_select(gpointer data)
+{
+	struct a2dp_setup *setup = data;
+
+	finalize_select(setup, setup->client_caps);
+
+	return FALSE;
+}
+
+static struct a2dp_sep *a2dp_find_sep(struct avdtp *session, GSList *list,
+					const char *sender)
+{
+	for (; list; list = list->next) {
+		struct a2dp_sep *sep = list->data;
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
+static struct a2dp_sep *a2dp_select_sep(struct avdtp *session, uint8_t type,
+					const char *sender)
+{
+	struct a2dp_server *server;
+	struct a2dp_sep *sep;
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
+	sep = a2dp_find_sep(session, l, sender);
+	if (sep != NULL)
+		return sep;
+
+	return a2dp_find_sep(session, l, NULL);
+}
+
+unsigned int a2dp_select_capabilities(struct avdtp *session,
+					uint8_t type, const char *sender,
+					a2dp_select_cb_t cb,
+					void *user_data)
+{
+	struct a2dp_setup *setup;
+	struct a2dp_setup_cb *cb_data;
+	struct a2dp_sep *sep;
+	struct avdtp_service_capability *service;
+	struct avdtp_media_codec_capability *codec;
+
+	sep = a2dp_select_sep(session, type, sender);
+	if (!sep) {
+		error("Unable to select SEP");
+		return 0;
+	}
+
+	cb_data = g_new0(struct a2dp_setup_cb, 1);
+	cb_data->select_cb = cb;
+	cb_data->user_data = user_data;
+	cb_data->id = ++cb_id;
+
+	setup = find_setup_by_session(session);
+	if (!setup) {
+		setup = g_new0(struct a2dp_setup, 1);
+		setup->session = avdtp_ref(session);
+		setup->dev = a2dp_get_dev(session);
+		setups = g_slist_append(setups, setup);
+	}
+
+	setup_ref(setup);
+	setup->cb = g_slist_append(setup->cb, cb_data);
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
+					&setup->client_caps)) {
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
+	setup_unref(setup);
+	cb_id--;
+	return 0;
+
+}
+
 unsigned int a2dp_config(struct avdtp *session, struct a2dp_sep *sep,
 				a2dp_config_cb_t cb, GSList *caps,
 				void *user_data)
@@ -1326,8 +1803,6 @@ unsigned int a2dp_config(struct avdtp *session, struct a2dp_sep *sep,
 	struct a2dp_server *server;
 	struct a2dp_setup *setup;
 	struct a2dp_sep *tmp;
-	struct avdtp_local_sep *lsep;
-	struct avdtp_remote_sep *rsep;
 	struct avdtp_service_capability *cap;
 	struct avdtp_media_codec_capability *codec_cap = NULL;
 	int posix_err;
@@ -1355,7 +1830,7 @@ unsigned int a2dp_config(struct avdtp *session, struct a2dp_sep *sep,
 	if (sep->codec != codec_cap->media_codec_type)
 		return 0;
 
-	DBG("a2dp_config: selected SEP %p", sep->sep);
+	DBG("a2dp_config: selected SEP %p", sep->lsep);
 
 	cb_data = g_new0(struct a2dp_setup_cb, 1);
 	cb_data->config_cb = cb;
@@ -1376,7 +1851,7 @@ unsigned int a2dp_config(struct avdtp *session, struct a2dp_sep *sep,
 	setup->stream = sep->stream;
 	setup->client_caps = caps;
 
-	switch (avdtp_sep_get_state(sep->sep)) {
+	switch (avdtp_sep_get_state(sep->lsep)) {
 	case AVDTP_STATE_IDLE:
 		if (sep->type == AVDTP_SEP_TYPE_SOURCE) {
 			l = server->sources;
@@ -1403,16 +1878,15 @@ unsigned int a2dp_config(struct avdtp *session, struct a2dp_sep *sep,
 			break;
 		}
 
-		if (avdtp_get_seps(session, remote_type,
-				codec_cap->media_type,
-				codec_cap->media_codec_type,
-				&lsep, &rsep) < 0) {
+		setup->rsep = avdtp_find_remote_sep(session, sep->lsep);
+		if (setup->rsep == NULL) {
 			error("No matching ACP and INT SEPs found");
 			goto failed;
 		}
 
-		posix_err = avdtp_set_configuration(session, rsep, lsep,
-							caps, &setup->stream);
+		posix_err = avdtp_set_configuration(session, setup->rsep,
+							sep->lsep, caps,
+							&setup->stream);
 		if (posix_err < 0) {
 			error("avdtp_set_configuration: %s",
 				strerror(-posix_err));
@@ -1469,7 +1943,7 @@ unsigned int a2dp_resume(struct avdtp *session, struct a2dp_sep *sep,
 	setup->sep = sep;
 	setup->stream = sep->stream;
 
-	switch (avdtp_sep_get_state(sep->sep)) {
+	switch (avdtp_sep_get_state(sep->lsep)) {
 	case AVDTP_STATE_IDLE:
 		goto failed;
 		break;
@@ -1528,7 +2002,7 @@ unsigned int a2dp_suspend(struct avdtp *session, struct a2dp_sep *sep,
 	setup->sep = sep;
 	setup->stream = sep->stream;
 
-	switch (avdtp_sep_get_state(sep->sep)) {
+	switch (avdtp_sep_get_state(sep->lsep)) {
 	case AVDTP_STATE_IDLE:
 		error("a2dp_suspend: no stream to suspend");
 		goto failed;
@@ -1541,6 +2015,7 @@ unsigned int a2dp_suspend(struct avdtp *session, struct a2dp_sep *sep,
 			error("avdtp_suspend failed");
 			goto failed;
 		}
+		sep->suspending = TRUE;
 		break;
 	default:
 		error("SEP in bad state for suspend");
@@ -1595,7 +2070,7 @@ gboolean a2dp_sep_lock(struct a2dp_sep *sep, struct avdtp *session)
 	if (sep->locked)
 		return FALSE;
 
-	DBG("SEP %p locked", sep->sep);
+	DBG("SEP %p locked", sep->lsep);
 	sep->locked = TRUE;
 
 	return TRUE;
@@ -1605,11 +2080,11 @@ gboolean a2dp_sep_unlock(struct a2dp_sep *sep, struct avdtp *session)
 {
 	avdtp_state_t state;
 
-	state = avdtp_sep_get_state(sep->sep);
+	state = avdtp_sep_get_state(sep->lsep);
 
 	sep->locked = FALSE;
 
-	DBG("SEP %p unlocked", sep->sep);
+	DBG("SEP %p unlocked", sep->lsep);
 
 	if (!sep->stream || state == AVDTP_STATE_IDLE)
 		return TRUE;
@@ -1671,3 +2146,8 @@ struct a2dp_sep *a2dp_get_sep(struct avdtp *session,
 
 	return NULL;
 }
+
+struct avdtp_stream *a2dp_sep_get_stream(struct a2dp_sep *sep)
+{
+	return sep->stream;
+}
diff --git a/audio/a2dp.h b/audio/a2dp.h
index fa81776..21fccaa 100644
--- a/audio/a2dp.h
+++ b/audio/a2dp.h
@@ -121,6 +121,10 @@ struct mpeg_codec_cap {
 
 struct a2dp_sep;
 
+
+typedef void (*a2dp_select_cb_t) (struct avdtp *session,
+					struct a2dp_sep *sep, GSList *caps,
+					void *user_data);
 typedef void (*a2dp_config_cb_t) (struct avdtp *session, struct a2dp_sep *sep,
 					struct avdtp_stream *stream,
 					struct avdtp_error *err,
@@ -132,7 +136,17 @@ typedef void (*a2dp_stream_cb_t) (struct avdtp *session,
 int a2dp_register(DBusConnection *conn, const bdaddr_t *src, GKeyFile *config);
 void a2dp_unregister(const bdaddr_t *src);
 
+struct a2dp_sep *a2dp_add_sep(const bdaddr_t *src, uint8_t type,
+				uint8_t codec, gboolean delay_reporting,
+				struct media_endpoint *endpoint);
+void a2dp_remove_sep(struct a2dp_sep *sep);
+
 struct a2dp_sep *a2dp_get(struct avdtp *session, struct avdtp_remote_sep *sep);
+
+unsigned int a2dp_select_capabilities(struct avdtp *session,
+					uint8_t type, const char *sender,
+					a2dp_select_cb_t cb,
+					void *user_data);
 unsigned int a2dp_config(struct avdtp *session, struct a2dp_sep *sep,
 				a2dp_config_cb_t cb, GSList *caps,
 				void *user_data);
@@ -145,5 +159,6 @@ gboolean a2dp_cancel(struct audio_device *dev, unsigned int id);
 gboolean a2dp_sep_lock(struct a2dp_sep *sep, struct avdtp *session);
 gboolean a2dp_sep_unlock(struct a2dp_sep *sep, struct avdtp *session);
 gboolean a2dp_sep_get_lock(struct a2dp_sep *sep);
+struct avdtp_stream *a2dp_sep_get_stream(struct a2dp_sep *sep);
 struct a2dp_sep *a2dp_get_sep(struct avdtp *session,
 				struct avdtp_stream *stream);
diff --git a/audio/avdtp.c b/audio/avdtp.c
index cc7066f..b9a03f8 100644
--- a/audio/avdtp.c
+++ b/audio/avdtp.c
@@ -1191,22 +1191,36 @@ static struct avdtp_local_sep *find_local_sep_by_seid(struct avdtp_server *serve
 	return NULL;
 }
 
-static struct avdtp_local_sep *find_local_sep(struct avdtp_server *server,
-						uint8_t type,
-						uint8_t media_type,
-						uint8_t codec)
+struct avdtp_remote_sep *avdtp_find_remote_sep(struct avdtp *session,
+						struct avdtp_local_sep *lsep)
 {
 	GSList *l;
 
-	for (l = server->seps; l != NULL; l = g_slist_next(l)) {
-		struct avdtp_local_sep *sep = l->data;
+	if (lsep->info.inuse)
+		return NULL;
+
+	for (l = session->seps; l != NULL; l = g_slist_next(l)) {
+		struct avdtp_remote_sep *sep = l->data;
+		struct avdtp_service_capability *cap;
+		struct avdtp_media_codec_capability *codec_data;
+
+		/* Type must be different: source <-> sink */
+		if (sep->type == lsep->info.type)
+			continue;
+
+		if (sep->media_type != lsep->info.media_type)
+			continue;
 
-		if (sep->info.inuse)
+		if (!sep->codec)
 			continue;
 
-		if (sep->info.type == type &&
-				sep->info.media_type == media_type &&
-				sep->codec == codec)
+		cap = sep->codec;
+		codec_data = (void *) cap->data;
+
+		if (codec_data->media_codec_type != lsep->codec)
+			continue;
+
+		if (sep->stream == NULL)
 			return sep;
 	}
 
@@ -3214,49 +3228,6 @@ int avdtp_discover(struct avdtp *session, avdtp_discover_cb_t cb,
 	return err;
 }
 
-int avdtp_get_seps(struct avdtp *session, uint8_t acp_type, uint8_t media_type,
-			uint8_t codec, struct avdtp_local_sep **lsep,
-			struct avdtp_remote_sep **rsep)
-{
-	GSList *l;
-	uint8_t int_type;
-
-	int_type = acp_type == AVDTP_SEP_TYPE_SINK ?
-				AVDTP_SEP_TYPE_SOURCE : AVDTP_SEP_TYPE_SINK;
-
-	*lsep = find_local_sep(session->server, int_type, media_type, codec);
-	if (!*lsep)
-		return -EINVAL;
-
-	for (l = session->seps; l != NULL; l = g_slist_next(l)) {
-		struct avdtp_remote_sep *sep = l->data;
-		struct avdtp_service_capability *cap;
-		struct avdtp_media_codec_capability *codec_data;
-
-		if (sep->type != acp_type)
-			continue;
-
-		if (sep->media_type != media_type)
-			continue;
-
-		if (!sep->codec)
-			continue;
-
-		cap = sep->codec;
-		codec_data = (void *) cap->data;
-
-		if (codec_data->media_codec_type != codec)
-			continue;
-
-		if (!sep->stream) {
-			*rsep = sep;
-			return 0;
-		}
-	}
-
-	return -EINVAL;
-}
-
 gboolean avdtp_stream_remove_cb(struct avdtp *session,
 				struct avdtp_stream *stream,
 				unsigned int id)
@@ -3354,8 +3325,14 @@ int avdtp_set_configuration(struct avdtp *session,
 	new_stream->lsep = lsep;
 	new_stream->rseid = rsep->seid;
 
-	if (rsep->delay_reporting && lsep->delay_reporting)
+	if (rsep->delay_reporting && lsep->delay_reporting) {
+		struct avdtp_service_capability *delay_reporting;
+
+		delay_reporting = avdtp_service_cap_new(AVDTP_DELAY_REPORTING,
+								NULL, 0);
+		caps = g_slist_append(caps, delay_reporting);
 		new_stream->delay_reporting = TRUE;
+	}
 
 	g_slist_foreach(caps, copy_capabilities, &new_stream->caps);
 
@@ -3625,6 +3602,9 @@ int avdtp_unregister_sep(struct avdtp_local_sep *sep)
 	if (sep->stream)
 		release_stream(sep->stream, sep->stream->session);
 
+	DBG("SEP %p unregistered: type:%d codec:%d seid:%d", sep,
+			sep->info.type, sep->codec, sep->info.seid);
+
 	g_free(sep);
 
 	return 0;
diff --git a/audio/avdtp.h b/audio/avdtp.h
index 3fe682b..bf10a2f 100644
--- a/audio/avdtp.h
+++ b/audio/avdtp.h
@@ -290,9 +290,8 @@ struct avdtp_local_sep *avdtp_register_sep(const bdaddr_t *src, uint8_t type,
 						void *user_data);
 
 /* Find a matching pair of local and remote SEP ID's */
-int avdtp_get_seps(struct avdtp *session, uint8_t type, uint8_t media,
-			uint8_t codec, struct avdtp_local_sep **lsep,
-			struct avdtp_remote_sep **rsep);
+struct avdtp_remote_sep *avdtp_find_remote_sep(struct avdtp *session,
+						struct avdtp_local_sep *lsep);
 
 int avdtp_unregister_sep(struct avdtp_local_sep *sep);
 
diff --git a/audio/manager.c b/audio/manager.c
index 87e7a2a..816c807 100644
--- a/audio/manager.c
+++ b/audio/manager.c
@@ -61,6 +61,7 @@
 #include "device.h"
 #include "error.h"
 #include "avdtp.h"
+#include "media.h"
 #include "a2dp.h"
 #include "headset.h"
 #include "gateway.h"
@@ -72,6 +73,10 @@
 #include "telephony.h"
 #include "unix.h"
 
+#ifndef DBUS_TYPE_UNIX_FD
+#define DBUS_TYPE_UNIX_FD -1
+#endif
+
 typedef enum {
 	HEADSET	= 1 << 0,
 	GATEWAY	= 1 << 1,
@@ -115,6 +120,7 @@ static struct enabled_interfaces enabled = {
 	.source		= FALSE,
 	.control	= TRUE,
 	.socket		= TRUE,
+	.media		= FALSE
 };
 
 static struct audio_adapter *find_adapter(GSList *list,
@@ -1015,6 +1021,38 @@ static void avrcp_server_remove(struct btd_adapter *adapter)
 	audio_adapter_unref(adp);
 }
 
+static int media_server_probe(struct btd_adapter *adapter)
+{
+	struct audio_adapter *adp;
+	const gchar *path = adapter_get_path(adapter);
+	bdaddr_t src;
+
+	DBG("path %s", path);
+
+	adp = audio_adapter_get(adapter);
+	if (!adp)
+		return -EINVAL;
+
+	adapter_get_address(adapter, &src);
+
+	return media_register(connection, path, &src);
+}
+
+static void media_server_remove(struct btd_adapter *adapter)
+{
+	struct audio_adapter *adp;
+	const gchar *path = adapter_get_path(adapter);
+
+	DBG("path %s", path);
+
+	adp = find_adapter(adapters, adapter);
+	if (!adp)
+		return;
+
+	media_unregister(path);
+	audio_adapter_unref(adp);
+}
+
 static struct btd_device_driver audio_driver = {
 	.name	= "audio",
 	.uuids	= BTD_UUIDS(HSP_HS_UUID, HFP_HS_UUID, HSP_AG_UUID, HFP_AG_UUID,
@@ -1048,6 +1086,12 @@ static struct btd_adapter_driver avrcp_server_driver = {
 	.remove	= avrcp_server_remove,
 };
 
+static struct btd_adapter_driver media_server_driver = {
+	.name	= "media",
+	.probe	= media_server_probe,
+	.remove	= media_server_remove,
+};
+
 int audio_manager_init(DBusConnection *conn, GKeyFile *conf,
 							gboolean *enable_sco)
 {
@@ -1078,6 +1122,8 @@ int audio_manager_init(DBusConnection *conn, GKeyFile *conf,
 			enabled.control = TRUE;
 		else if (g_str_equal(list[i], "Socket"))
 			enabled.socket = TRUE;
+		else if (g_str_equal(list[i], "Media"))
+			enabled.media = TRUE;
 	}
 	g_strfreev(list);
 
@@ -1096,6 +1142,8 @@ int audio_manager_init(DBusConnection *conn, GKeyFile *conf,
 			enabled.control = FALSE;
 		else if (g_str_equal(list[i], "Socket"))
 			enabled.socket = FALSE;
+		else if (g_str_equal(list[i], "Media"))
+			enabled.media = FALSE;
 	}
 	g_strfreev(list);
 
@@ -1126,6 +1174,9 @@ proceed:
 	if (enabled.socket)
 		unix_init();
 
+	if (enabled.media)
+		btd_register_adapter_driver(&media_server_driver);
+
 	if (enabled.headset) {
 		telephony_init();
 		btd_register_adapter_driver(&headset_server_driver);
@@ -1164,6 +1215,9 @@ void audio_manager_exit(void)
 	if (enabled.socket)
 		unix_exit();
 
+	if (enabled.media)
+		btd_unregister_adapter_driver(&media_server_driver);
+
 	if (enabled.headset) {
 		btd_unregister_adapter_driver(&headset_server_driver);
 		telephony_exit();
diff --git a/audio/manager.h b/audio/manager.h
index c79b761..0bf7663 100644
--- a/audio/manager.h
+++ b/audio/manager.h
@@ -30,6 +30,7 @@ struct enabled_interfaces {
 	gboolean source;
 	gboolean control;
 	gboolean socket;
+	gboolean media;
 };
 
 int audio_manager_init(DBusConnection *conn, GKeyFile *config,
diff --git a/audio/media.c b/audio/media.c
new file mode 100644
index 0000000..da9d3ae
--- /dev/null
+++ b/audio/media.c
@@ -0,0 +1,683 @@
+/*
+ *
+ *  BlueZ - Bluetooth protocol stack for Linux
+ *
+ *  Copyright (C) 2006-2007  Nokia Corporation
+ *  Copyright (C) 2004-2009  Marcel Holtmann <marcel@holtmann.org>
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
+#include <errno.h>
+
+#include <glib.h>
+#include <gdbus.h>
+
+#include "../src/adapter.h"
+#include "../src/dbus-common.h"
+
+#include "log.h"
+#include "error.h"
+#include "device.h"
+#include "avdtp.h"
+#include "media.h"
+#include "transport.h"
+#include "a2dp.h"
+#include "headset.h"
+
+#ifndef DBUS_TYPE_UNIX_FD
+#define DBUS_TYPE_UNIX_FD -1
+#endif
+
+#define MEDIA_INTERFACE "org.bluez.Media"
+#define MEDIA_ENDPOINT_INTERFACE "org.bluez.MediaEndpoint"
+
+#define REQUEST_TIMEOUT (3 * 1000)		/* 3 seconds */
+
+struct media_adapter {
+	bdaddr_t		src;		/* Adapter address */
+	char			*path;		/* Adapter path */
+	DBusConnection		*conn;		/* Adapter connection */
+	GSList			*endpoints;	/* Endpoints list */
+};
+
+struct endpoint_request {
+	DBusMessage		*msg;
+	DBusPendingCall		*call;
+	media_endpoint_cb_t	cb;
+	void			*user_data;
+};
+
+struct media_endpoint {
+	struct a2dp_sep		*sep;
+	char			*sender;	/* Endpoint DBus bus id */
+	char			*path;		/* Endpoint object path */
+	char			*uuid;		/* Endpoint property UUID */
+	uint8_t			codec;		/* Endpoint codec */
+	uint8_t			*capabilities;	/* Endpoint property capabilities */
+	size_t			size;		/* Endpoint capabilities size */
+	guint			hs_watch;
+	guint			watch;
+	struct endpoint_request *request;
+	struct media_transport	*transport;
+	struct media_adapter	*adapter;
+};
+
+static GSList *adapters = NULL;
+
+static void endpoint_request_free(struct endpoint_request *request)
+{
+	if (request->call)
+		dbus_pending_call_cancel(request->call);
+
+	dbus_message_unref(request->msg);
+	g_free(request);
+}
+
+static void media_endpoint_remove(struct media_endpoint *endpoint)
+{
+	struct media_adapter *adapter = endpoint->adapter;
+
+	info("Endpoint unregistered: sender=%s path=%s", endpoint->sender,
+			endpoint->path);
+
+	adapter->endpoints = g_slist_remove(adapter->endpoints, endpoint);
+
+	if (endpoint->sep)
+		a2dp_remove_sep(endpoint->sep);
+
+	if (endpoint->hs_watch)
+		headset_remove_state_cb(endpoint->hs_watch);
+
+	if (endpoint->request)
+		endpoint_request_free(endpoint->request);
+
+	if (endpoint->transport)
+		media_transport_remove(endpoint->transport);
+
+	g_dbus_remove_watch(adapter->conn, endpoint->watch);
+	g_free(endpoint->capabilities);
+	g_free(endpoint->sender);
+	g_free(endpoint->path);
+	g_free(endpoint->uuid);
+	g_free(endpoint);
+}
+
+static void media_endpoint_exit(DBusConnection *connection, void *user_data)
+{
+	struct media_endpoint *endpoint = user_data;
+
+	endpoint->watch = 0;
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
+		if (old_state != HEADSET_STATE_CONNECTING)
+			media_endpoint_clear_configuration(endpoint);
+	case HEADSET_STATE_CONNECTING:
+		break;
+	case HEADSET_STATE_CONNECTED:
+		if (old_state != HEADSET_STATE_PLAY_IN_PROGRESS &&
+				old_state != HEADSET_STATE_PLAYING)
+			media_endpoint_set_configuration(endpoint, dev, NULL,
+								0, NULL, NULL);
+		break;
+	case HEADSET_STATE_PLAY_IN_PROGRESS:
+		break;
+	case HEADSET_STATE_PLAYING:
+		break;
+	}
+}
+
+static struct media_endpoint *media_endpoint_create(struct media_adapter *adapter,
+						const char *sender,
+						const char *path,
+						const char *uuid,
+						gboolean delay_reporting,
+						uint8_t codec,
+						uint8_t *capabilities,
+						int size)
+{
+	struct media_endpoint *endpoint;
+
+	endpoint = g_new0(struct media_endpoint, 1);
+	endpoint->sender = g_strdup(sender);
+	endpoint->path = g_strdup(path);
+	endpoint->uuid = g_strdup(uuid);
+	endpoint->codec = codec;
+	endpoint->capabilities = g_new(uint8_t, size);
+	memcpy(endpoint->capabilities, capabilities, size);
+	endpoint->size = size;
+	endpoint->adapter = adapter;
+
+	if (g_strcmp0(uuid, A2DP_SOURCE_UUID) == 0) {
+		endpoint->sep = a2dp_add_sep(&adapter->src,
+					AVDTP_SEP_TYPE_SOURCE, codec,
+					delay_reporting, endpoint);
+		if (endpoint->sep == NULL)
+			goto failed;
+	} else if (g_strcmp0(uuid, A2DP_SINK_UUID) == 0) {
+		endpoint->sep = a2dp_add_sep(&adapter->src,
+						AVDTP_SEP_TYPE_SINK, codec,
+						delay_reporting, endpoint);
+		if (endpoint->sep == NULL)
+			goto failed;
+	} else if (g_strcmp0(uuid, HFP_AG_UUID) == 0 ||
+					g_strcmp0(uuid, HSP_AG_UUID) == 0)
+		endpoint->hs_watch = headset_add_state_cb(headset_state_changed,
+								endpoint);
+	else
+		goto failed;
+
+	endpoint->watch = g_dbus_add_disconnect_watch(adapter->conn, sender,
+						media_endpoint_exit, endpoint,
+						NULL);
+
+	adapter->endpoints = g_slist_append(adapter->endpoints, endpoint);
+	info("Endpoint registered: sender=%s path=%s", sender, path);
+
+	return endpoint;
+
+failed:
+	g_free(endpoint);
+	return NULL;
+}
+
+static struct media_endpoint *media_adapter_find_endpoint(
+						struct media_adapter *adapter,
+						const char *sender,
+						const char *path,
+						const char *uuid)
+{
+	GSList *l;
+
+	for (l = adapter->endpoints; l; l = l->next) {
+		struct media_endpoint *endpoint = l->data;
+
+		if (sender && g_strcmp0(endpoint->sender, sender) != 0)
+			continue;
+
+		if (path && g_strcmp0(endpoint->path, path) != 0)
+			continue;
+
+		if (uuid && g_strcmp0(endpoint->uuid, uuid) != 0)
+			continue;
+
+		return endpoint;
+	}
+
+	return NULL;
+}
+
+const char *media_endpoint_get_sender(struct media_endpoint *endpoint)
+{
+	return endpoint->sender;
+}
+
+static int parse_properties(DBusMessageIter *props, const char **uuid,
+				gboolean *delay_reporting, uint8_t *codec,
+				uint8_t **capabilities, int *size)
+{
+	while (dbus_message_iter_get_arg_type(props) == DBUS_TYPE_DICT_ENTRY) {
+		const char *key;
+		DBusMessageIter value, entry;
+		int var;
+
+		dbus_message_iter_recurse(props, &entry);
+		dbus_message_iter_get_basic(&entry, &key);
+
+		dbus_message_iter_next(&entry);
+		dbus_message_iter_recurse(&entry, &value);
+
+		var = dbus_message_iter_get_arg_type(&value);
+		if (strcasecmp(key, "UUID") == 0) {
+			if (var != DBUS_TYPE_STRING)
+				return -EINVAL;
+			dbus_message_iter_get_basic(&value, uuid);
+		} else if (strcasecmp(key, "Codec") == 0) {
+			if (var != DBUS_TYPE_BYTE)
+				return -EINVAL;
+			dbus_message_iter_get_basic(&value, codec);
+		} else if (strcasecmp(key, "DelayReporting") == 0) {
+			if (var != DBUS_TYPE_BOOLEAN)
+				return -EINVAL;
+			dbus_message_iter_get_basic(&value, delay_reporting);
+		} else if (strcasecmp(key, "Capabilities") == 0) {
+			DBusMessageIter array;
+
+			if (var != DBUS_TYPE_ARRAY)
+				return -EINVAL;
+
+			dbus_message_iter_recurse(&value, &array);
+			dbus_message_iter_get_fixed_array(&array, capabilities,
+							size);
+		}
+
+		dbus_message_iter_next(props);
+	}
+
+	return 0;
+}
+
+static DBusMessage *register_endpoint(DBusConnection *conn, DBusMessage *msg,
+					void *data)
+{
+	struct media_adapter *adapter = data;
+	DBusMessageIter args, props;
+	const char *sender, *path, *uuid = NULL;
+	gboolean delay_reporting;
+	uint8_t codec;
+	uint8_t *capabilities;
+	int size;
+
+	sender = dbus_message_get_sender(msg);
+
+	dbus_message_iter_init(msg, &args);
+
+	dbus_message_iter_get_basic(&args, &path);
+	dbus_message_iter_next(&args);
+
+	if (media_adapter_find_endpoint(adapter, sender, path, NULL) != NULL)
+		return g_dbus_create_error(msg, ERROR_INTERFACE ".Failed",
+				"Endpoint already registered");
+
+	dbus_message_iter_recurse(&args, &props);
+	if (dbus_message_iter_get_arg_type(&props) != DBUS_TYPE_DICT_ENTRY)
+		return g_dbus_create_error(msg, ERROR_INTERFACE
+					".Failed", "Invalid argument");
+
+	if (parse_properties(&props, &uuid, &delay_reporting, &codec,
+				&capabilities, &size) || uuid == NULL)
+		return g_dbus_create_error(msg, ERROR_INTERFACE ".Failed",
+						"Invalid argument");
+
+	if (media_endpoint_create(adapter, sender, path, uuid, delay_reporting,
+				codec, capabilities, size) == FALSE)
+		return g_dbus_create_error(msg, ERROR_INTERFACE ".Failed",
+						"Invalid argument");
+
+	return g_dbus_create_reply(msg, DBUS_TYPE_INVALID);
+}
+
+static DBusMessage *unregister_endpoint(DBusConnection *conn, DBusMessage *msg,
+					void *data)
+{
+	struct media_adapter *adapter = data;
+	struct media_endpoint *endpoint;
+	const char *sender, *path;
+
+	if (!dbus_message_get_args(msg, NULL,
+				DBUS_TYPE_OBJECT_PATH, &path,
+				DBUS_TYPE_INVALID))
+		return NULL;
+
+	sender = dbus_message_get_sender(msg);
+
+	endpoint = media_adapter_find_endpoint(adapter, sender, path, NULL);
+	if (endpoint == NULL)
+		return g_dbus_create_error(msg, ERROR_INTERFACE ".Failed",
+				"Endpoint not registered");
+
+	media_endpoint_remove(endpoint);
+
+	return g_dbus_create_reply(msg, DBUS_TYPE_INVALID);
+}
+
+static GDBusMethodTable media_methods[] = {
+	{ "RegisterEndpoint",	"oa{sv}",	"",	register_endpoint },
+	{ "UnregisterEndpoint",	"o",		"",	unregister_endpoint },
+	{ },
+};
+
+static void path_free(void *data)
+{
+	struct media_adapter *adapter = data;
+
+	g_slist_foreach(adapter->endpoints, (GFunc) media_endpoint_release,
+									NULL);
+	g_slist_free(adapter->endpoints);
+
+	dbus_connection_unref(adapter->conn);
+
+	adapters = g_slist_remove(adapters, adapter);
+
+	g_free(adapter->path);
+	g_free(adapter);
+}
+
+int media_register(DBusConnection *conn, const char *path, const bdaddr_t *src)
+{
+	struct media_adapter *adapter;
+
+	if (DBUS_TYPE_UNIX_FD < 0)
+		return -EPERM;
+
+	adapter = g_new0(struct media_adapter, 1);
+	adapter->conn = dbus_connection_ref(conn);
+	bacpy(&adapter->src, src);
+	adapter->path = g_strdup(path);
+
+	if (!g_dbus_register_interface(conn, path, MEDIA_INTERFACE,
+					media_methods, NULL, NULL,
+					adapter, path_free)) {
+		error("D-Bus failed to register %s path", path);
+		path_free(adapter);
+		return -1;
+	}
+
+	adapters = g_slist_append(adapters, adapter);
+
+	return 0;
+}
+
+void media_unregister(const char *path)
+{
+	GSList *l;
+
+	for (l = adapters; l; l = l->next) {
+		struct media_adapter *adapter = l->data;
+
+		if (g_strcmp0(path, adapter->path) == 0) {
+			g_dbus_unregister_interface(adapter->conn, path,
+							MEDIA_INTERFACE);
+			return;
+		}
+	}
+}
+
+size_t media_endpoint_get_capabilities(struct media_endpoint *endpoint,
+					uint8_t **capabilities)
+{
+	*capabilities = endpoint->capabilities;
+	return endpoint->size;
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
+			media_endpoint_clear_configuration(endpoint);
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
+	request->cb(endpoint, ret, size, request->user_data);
+
+	endpoint_request_free(request);
+	endpoint->request = NULL;
+}
+
+static gboolean media_endpoint_async_call(DBusConnection *conn,
+					DBusMessage *msg,
+					struct media_endpoint *endpoint,
+					media_endpoint_cb_t cb,
+					void *user_data)
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
+gboolean media_endpoint_set_configuration(struct media_endpoint *endpoint,
+					struct audio_device *device,
+					uint8_t *configuration, size_t size,
+					media_endpoint_cb_t cb,
+					void *user_data)
+{
+	DBusConnection *conn;
+	DBusMessage *msg, *reply;
+	DBusError err;
+	const char *path;
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
+	path = media_transport_get_path(endpoint->transport);
+	dbus_message_append_args(msg, DBUS_TYPE_OBJECT_PATH, &path,
+					DBUS_TYPE_ARRAY, DBUS_TYPE_BYTE,
+					&configuration, size,
+					DBUS_TYPE_INVALID);
+
+	if (cb != NULL)
+		return media_endpoint_async_call(conn, msg, endpoint, cb, user_data);
+
+	dbus_error_init(&err);
+
+	DBG("Calling %s: name = %s path = %s", dbus_message_get_member(msg),
+			dbus_message_get_destination(msg),
+			dbus_message_get_path(msg));
+
+	/* FIXME: remove once we can reply setconf asynchronously */
+	reply = dbus_connection_send_with_reply_and_block(conn, msg,
+							REQUEST_TIMEOUT, &err);
+
+	dbus_message_unref(msg);
+
+	if (reply) {
+		dbus_message_unref(reply);
+		return TRUE;
+	}
+
+	if (dbus_error_is_set(&err)) {
+		error("Endpoint replied with an error: %s", err.name);
+
+		if (dbus_error_has_name(&err, DBUS_ERROR_NO_REPLY))
+			media_endpoint_clear_configuration(endpoint);
+
+		dbus_error_free(&err);
+	}
+
+	return FALSE;
+}
+
+gboolean media_endpoint_select_configuration(struct media_endpoint *endpoint,
+						uint8_t *capabilities,
+						size_t length,
+						media_endpoint_cb_t cb,
+						void *user_data)
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
+	return media_endpoint_async_call(conn, msg, endpoint, cb, user_data);
+}
+
+void media_endpoint_clear_configuration(struct media_endpoint *endpoint)
+{
+	DBusConnection *conn;
+	DBusMessage *msg;
+
+	if (endpoint->transport == NULL)
+		return;
+
+	if (endpoint->request) {
+		endpoint_request_free(endpoint->request);
+		endpoint->request = NULL;
+	}
+
+	conn = endpoint->adapter->conn;
+
+	media_transport_remove(endpoint->transport);
+	endpoint->transport = NULL;
+
+	msg = dbus_message_new_method_call(endpoint->sender, endpoint->path,
+						MEDIA_ENDPOINT_INTERFACE,
+						"ClearConfiguration");
+	if (msg == NULL) {
+		error("Couldn't allocate D-Bus message");
+		return;
+	}
+
+	g_dbus_send_message(conn, msg);
+}
+
+void media_endpoint_release(struct media_endpoint *endpoint)
+{
+	DBusMessage *msg;
+
+	DBG("sender=%s path=%s", endpoint->sender, endpoint->path);
+
+	/* already exit */
+	if (endpoint->watch == 0)
+		return;
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
+	media_endpoint_remove(endpoint);
+}
+
+struct a2dp_sep *media_endpoint_get_sep(struct media_endpoint *endpoint)
+{
+	return endpoint->sep;
+}
+
+const char *media_endpoint_get_uuid(struct media_endpoint *endpoint)
+{
+	return endpoint->uuid;
+}
+
+uint8_t media_endpoint_get_codec(struct media_endpoint *endpoint)
+{
+	return endpoint->codec;
+}
diff --git a/audio/media.h b/audio/media.h
new file mode 100644
index 0000000..f6d144c
--- /dev/null
+++ b/audio/media.h
@@ -0,0 +1,52 @@
+/*
+ *
+ *  BlueZ - Bluetooth protocol stack for Linux
+ *
+ *  Copyright (C) 2006-2007  Nokia Corporation
+ *  Copyright (C) 2004-2009  Marcel Holtmann <marcel@holtmann.org>
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
+struct media_endpoint;
+
+typedef void (*media_endpoint_cb_t) (struct media_endpoint *endpoint,
+					void *ret, int size, void *user_data);
+
+int media_register(DBusConnection *conn, const char *path, const bdaddr_t *src);
+void media_unregister(const char *path);
+
+const char *media_endpoint_get_sender(struct media_endpoint *endpoint);
+
+size_t media_endpoint_get_capabilities(struct media_endpoint *endpoint,
+					uint8_t **capabilities);
+gboolean media_endpoint_set_configuration(struct media_endpoint *endpoint,
+					struct audio_device *device,
+					uint8_t *configuration, size_t size,
+					media_endpoint_cb_t cb,
+					void *user_data);
+gboolean media_endpoint_select_configuration(struct media_endpoint *endpoint,
+						uint8_t *capabilities,
+						size_t length,
+						media_endpoint_cb_t cb,
+						void *user_data);
+void media_endpoint_clear_configuration(struct media_endpoint *endpoint);
+void media_endpoint_release(struct media_endpoint *endpoint);
+
+struct a2dp_sep *media_endpoint_get_sep(struct media_endpoint *endpoint);
+const char *media_endpoint_get_uuid(struct media_endpoint *endpoint);
+uint8_t media_endpoint_get_codec(struct media_endpoint *endpoint);
diff --git a/audio/sink.c b/audio/sink.c
index f4dce28..67cffee 100644
--- a/audio/sink.c
+++ b/audio/sink.c
@@ -40,6 +40,7 @@
 
 #include "device.h"
 #include "avdtp.h"
+#include "media.h"
 #include "a2dp.h"
 #include "error.h"
 #include "sink.h"
@@ -343,146 +344,30 @@ static void stream_setup_complete(struct avdtp *session, struct a2dp_sep *sep,
 	}
 }
 
-static uint8_t default_bitpool(uint8_t freq, uint8_t mode)
+static void select_complete(struct avdtp *session, struct a2dp_sep *sep,
+			GSList *caps, void *user_data)
 {
-	switch (freq) {
-	case SBC_SAMPLING_FREQ_16000:
-	case SBC_SAMPLING_FREQ_32000:
-		return 53;
-	case SBC_SAMPLING_FREQ_44100:
-		switch (mode) {
-		case SBC_CHANNEL_MODE_MONO:
-		case SBC_CHANNEL_MODE_DUAL_CHANNEL:
-			return 31;
-		case SBC_CHANNEL_MODE_STEREO:
-		case SBC_CHANNEL_MODE_JOINT_STEREO:
-			return 53;
-		default:
-			error("Invalid channel mode %u", mode);
-			return 53;
-		}
-	case SBC_SAMPLING_FREQ_48000:
-		switch (mode) {
-		case SBC_CHANNEL_MODE_MONO:
-		case SBC_CHANNEL_MODE_DUAL_CHANNEL:
-			return 29;
-		case SBC_CHANNEL_MODE_STEREO:
-		case SBC_CHANNEL_MODE_JOINT_STEREO:
-			return 51;
-		default:
-			error("Invalid channel mode %u", mode);
-			return 51;
-		}
-	default:
-		error("Invalid sampling freq %u", freq);
-		return 53;
-	}
-}
-
-static gboolean select_sbc_params(struct sbc_codec_cap *cap,
-					struct sbc_codec_cap *supported)
-{
-	unsigned int max_bitpool, min_bitpool;
-
-	memset(cap, 0, sizeof(struct sbc_codec_cap));
-
-	cap->cap.media_type = AVDTP_MEDIA_TYPE_AUDIO;
-	cap->cap.media_codec_type = A2DP_CODEC_SBC;
-
-	if (supported->frequency & SBC_SAMPLING_FREQ_44100)
-		cap->frequency = SBC_SAMPLING_FREQ_44100;
-	else if (supported->frequency & SBC_SAMPLING_FREQ_48000)
-		cap->frequency = SBC_SAMPLING_FREQ_48000;
-	else if (supported->frequency & SBC_SAMPLING_FREQ_32000)
-		cap->frequency = SBC_SAMPLING_FREQ_32000;
-	else if (supported->frequency & SBC_SAMPLING_FREQ_16000)
-		cap->frequency = SBC_SAMPLING_FREQ_16000;
-	else {
-		error("No supported frequencies");
-		return FALSE;
-	}
-
-	if (supported->channel_mode & SBC_CHANNEL_MODE_JOINT_STEREO)
-		cap->channel_mode = SBC_CHANNEL_MODE_JOINT_STEREO;
-	else if (supported->channel_mode & SBC_CHANNEL_MODE_STEREO)
-		cap->channel_mode = SBC_CHANNEL_MODE_STEREO;
-	else if (supported->channel_mode & SBC_CHANNEL_MODE_DUAL_CHANNEL)
-		cap->channel_mode = SBC_CHANNEL_MODE_DUAL_CHANNEL;
-	else if (supported->channel_mode & SBC_CHANNEL_MODE_MONO)
-		cap->channel_mode = SBC_CHANNEL_MODE_MONO;
-	else {
-		error("No supported channel modes");
-		return FALSE;
-	}
-
-	if (supported->block_length & SBC_BLOCK_LENGTH_16)
-		cap->block_length = SBC_BLOCK_LENGTH_16;
-	else if (supported->block_length & SBC_BLOCK_LENGTH_12)
-		cap->block_length = SBC_BLOCK_LENGTH_12;
-	else if (supported->block_length & SBC_BLOCK_LENGTH_8)
-		cap->block_length = SBC_BLOCK_LENGTH_8;
-	else if (supported->block_length & SBC_BLOCK_LENGTH_4)
-		cap->block_length = SBC_BLOCK_LENGTH_4;
-	else {
-		error("No supported block lengths");
-		return FALSE;
-	}
-
-	if (supported->subbands & SBC_SUBBANDS_8)
-		cap->subbands = SBC_SUBBANDS_8;
-	else if (supported->subbands & SBC_SUBBANDS_4)
-		cap->subbands = SBC_SUBBANDS_4;
-	else {
-		error("No supported subbands");
-		return FALSE;
-	}
-
-	if (supported->allocation_method & SBC_ALLOCATION_LOUDNESS)
-		cap->allocation_method = SBC_ALLOCATION_LOUDNESS;
-	else if (supported->allocation_method & SBC_ALLOCATION_SNR)
-		cap->allocation_method = SBC_ALLOCATION_SNR;
-
-	min_bitpool = MAX(MIN_BITPOOL, supported->min_bitpool);
-	max_bitpool = MIN(default_bitpool(cap->frequency, cap->channel_mode),
-							supported->max_bitpool);
-
-	cap->min_bitpool = min_bitpool;
-	cap->max_bitpool = max_bitpool;
-
-	return TRUE;
-}
-
-static gboolean select_capabilities(struct avdtp *session,
-					struct avdtp_remote_sep *rsep,
-					GSList **caps)
-{
-	struct avdtp_service_capability *media_transport, *media_codec;
-	struct sbc_codec_cap sbc_cap;
-
-	media_codec = avdtp_get_codec(rsep);
-	if (!media_codec)
-		return FALSE;
-
-	select_sbc_params(&sbc_cap, (struct sbc_codec_cap *) media_codec->data);
-
-	media_transport = avdtp_service_cap_new(AVDTP_MEDIA_TRANSPORT,
-						NULL, 0);
-
-	*caps = g_slist_append(*caps, media_transport);
+	struct sink *sink = user_data;
+	struct pending_request *pending;
+	int id;
 
-	media_codec = avdtp_service_cap_new(AVDTP_MEDIA_CODEC, &sbc_cap,
-						sizeof(sbc_cap));
+	pending = sink->connect;
+	pending->id = 0;
 
-	*caps = g_slist_append(*caps, media_codec);
+	id = a2dp_config(session, sep, stream_setup_complete, caps, sink);
+	if (id == 0)
+		goto failed;
 
-	if (avdtp_get_delay_reporting(rsep)) {
-		struct avdtp_service_capability *delay_reporting;
-		delay_reporting = avdtp_service_cap_new(AVDTP_DELAY_REPORTING,
-								NULL, 0);
-		*caps = g_slist_append(*caps, delay_reporting);
-	}
+	pending->id = id;
+	return;
 
-	return TRUE;
+failed:
+	if (pending->msg)
+		error_failed(pending->conn, pending->msg, "Stream setup failed");
+	pending_request_free(sink->dev, pending);
+	sink->connect = NULL;
+	avdtp_unref(sink->session);
+	sink->session = NULL;
 }
 
 static void discovery_complete(struct avdtp *session, GSList *seps, struct avdtp_error *err,
@@ -490,10 +375,6 @@ static void discovery_complete(struct avdtp *session, GSList *seps, struct avdtp
 {
 	struct sink *sink = user_data;
 	struct pending_request *pending;
-	struct avdtp_local_sep *lsep;
-	struct avdtp_remote_sep *rsep;
-	struct a2dp_sep *sep;
-	GSList *caps = NULL;
 	int id;
 
 	pending = sink->connect;
@@ -515,24 +396,8 @@ static void discovery_complete(struct avdtp *session, GSList *seps, struct avdtp
 
 	DBG("Discovery complete");
 
-	if (avdtp_get_seps(session, AVDTP_SEP_TYPE_SINK, AVDTP_MEDIA_TYPE_AUDIO,
-				A2DP_CODEC_SBC, &lsep, &rsep) < 0) {
-		error("No matching ACP and INT SEPs found");
-		goto failed;
-	}
-
-	if (!select_capabilities(session, rsep, &caps)) {
-		error("Unable to select remote SEP capabilities");
-		goto failed;
-	}
-
-	sep = a2dp_get(session, rsep);
-	if (!sep) {
-		error("Unable to get a local source SEP");
-		goto failed;
-	}
-
-	id = a2dp_config(sink->session, sep, stream_setup_complete, caps, sink);
+	id = a2dp_select_capabilities(sink->session, AVDTP_SEP_TYPE_SINK, NULL,
+						select_complete, sink);
 	if (id == 0)
 		goto failed;
 
diff --git a/audio/source.c b/audio/source.c
index 35d8136..01173f5 100644
--- a/audio/source.c
+++ b/audio/source.c
@@ -41,6 +41,7 @@
 
 #include "device.h"
 #include "avdtp.h"
+#include "media.h"
 #include "a2dp.h"
 #include "error.h"
 #include "source.h"
@@ -310,140 +311,34 @@ static void stream_setup_complete(struct avdtp *session, struct a2dp_sep *sep,
 	}
 }
 
-static uint8_t default_bitpool(uint8_t freq, uint8_t mode)
+static void select_complete(struct avdtp *session, struct a2dp_sep *sep,
+			GSList *caps, void *user_data)
 {
-	switch (freq) {
-	case SBC_SAMPLING_FREQ_16000:
-	case SBC_SAMPLING_FREQ_32000:
-		return 53;
-	case SBC_SAMPLING_FREQ_44100:
-		switch (mode) {
-		case SBC_CHANNEL_MODE_MONO:
-		case SBC_CHANNEL_MODE_DUAL_CHANNEL:
-			return 31;
-		case SBC_CHANNEL_MODE_STEREO:
-		case SBC_CHANNEL_MODE_JOINT_STEREO:
-			return 53;
-		default:
-			error("Invalid channel mode %u", mode);
-			return 53;
-		}
-	case SBC_SAMPLING_FREQ_48000:
-		switch (mode) {
-		case SBC_CHANNEL_MODE_MONO:
-		case SBC_CHANNEL_MODE_DUAL_CHANNEL:
-			return 29;
-		case SBC_CHANNEL_MODE_STEREO:
-		case SBC_CHANNEL_MODE_JOINT_STEREO:
-			return 51;
-		default:
-			error("Invalid channel mode %u", mode);
-			return 51;
-		}
-	default:
-		error("Invalid sampling freq %u", freq);
-		return 53;
-	}
-}
-
-static gboolean select_sbc_params(struct sbc_codec_cap *cap,
-					struct sbc_codec_cap *supported)
-{
-	unsigned int max_bitpool, min_bitpool;
-
-	memset(cap, 0, sizeof(struct sbc_codec_cap));
-
-	cap->cap.media_type = AVDTP_MEDIA_TYPE_AUDIO;
-	cap->cap.media_codec_type = A2DP_CODEC_SBC;
-
-	if (supported->frequency & SBC_SAMPLING_FREQ_44100)
-		cap->frequency = SBC_SAMPLING_FREQ_44100;
-	else if (supported->frequency & SBC_SAMPLING_FREQ_48000)
-		cap->frequency = SBC_SAMPLING_FREQ_48000;
-	else if (supported->frequency & SBC_SAMPLING_FREQ_32000)
-		cap->frequency = SBC_SAMPLING_FREQ_32000;
-	else if (supported->frequency & SBC_SAMPLING_FREQ_16000)
-		cap->frequency = SBC_SAMPLING_FREQ_16000;
-	else {
-		error("No supported frequencies");
-		return FALSE;
-	}
-
-	if (supported->channel_mode & SBC_CHANNEL_MODE_JOINT_STEREO)
-		cap->channel_mode = SBC_CHANNEL_MODE_JOINT_STEREO;
-	else if (supported->channel_mode & SBC_CHANNEL_MODE_STEREO)
-		cap->channel_mode = SBC_CHANNEL_MODE_STEREO;
-	else if (supported->channel_mode & SBC_CHANNEL_MODE_DUAL_CHANNEL)
-		cap->channel_mode = SBC_CHANNEL_MODE_DUAL_CHANNEL;
-	else if (supported->channel_mode & SBC_CHANNEL_MODE_MONO)
-		cap->channel_mode = SBC_CHANNEL_MODE_MONO;
-	else {
-		error("No supported channel modes");
-		return FALSE;
-	}
-
-	if (supported->block_length & SBC_BLOCK_LENGTH_16)
-		cap->block_length = SBC_BLOCK_LENGTH_16;
-	else if (supported->block_length & SBC_BLOCK_LENGTH_12)
-		cap->block_length = SBC_BLOCK_LENGTH_12;
-	else if (supported->block_length & SBC_BLOCK_LENGTH_8)
-		cap->block_length = SBC_BLOCK_LENGTH_8;
-	else if (supported->block_length & SBC_BLOCK_LENGTH_4)
-		cap->block_length = SBC_BLOCK_LENGTH_4;
-	else {
-		error("No supported block lengths");
-		return FALSE;
-	}
-
-	if (supported->subbands & SBC_SUBBANDS_8)
-		cap->subbands = SBC_SUBBANDS_8;
-	else if (supported->subbands & SBC_SUBBANDS_4)
-		cap->subbands = SBC_SUBBANDS_4;
-	else {
-		error("No supported subbands");
-		return FALSE;
-	}
-
-	if (supported->allocation_method & SBC_ALLOCATION_LOUDNESS)
-		cap->allocation_method = SBC_ALLOCATION_LOUDNESS;
-	else if (supported->allocation_method & SBC_ALLOCATION_SNR)
-		cap->allocation_method = SBC_ALLOCATION_SNR;
-
-	min_bitpool = MAX(MIN_BITPOOL, supported->min_bitpool);
-	max_bitpool = MIN(default_bitpool(cap->frequency, cap->channel_mode),
-							supported->max_bitpool);
-
-	cap->min_bitpool = min_bitpool;
-	cap->max_bitpool = max_bitpool;
-
-	return TRUE;
-}
-
-static gboolean select_capabilities(struct avdtp *session,
-					struct avdtp_remote_sep *rsep,
-					GSList **caps)
-{
-	struct avdtp_service_capability *media_transport, *media_codec;
-	struct sbc_codec_cap sbc_cap;
-
-	media_codec = avdtp_get_codec(rsep);
-	if (!media_codec)
-		return FALSE;
-
-	select_sbc_params(&sbc_cap, (struct sbc_codec_cap *) media_codec->data);
+	struct source *source = user_data;
+	struct pending_request *pending;
+	int id;
 
-	media_transport = avdtp_service_cap_new(AVDTP_MEDIA_TRANSPORT,
-						NULL, 0);
+	pending = source->connect;
 
-	*caps = g_slist_append(*caps, media_transport);
+	pending->id = 0;
 
-	media_codec = avdtp_service_cap_new(AVDTP_MEDIA_CODEC, &sbc_cap,
-						sizeof(sbc_cap));
+	if (caps == NULL)
+		goto failed;
 
-	*caps = g_slist_append(*caps, media_codec);
+	id = a2dp_config(session, sep, stream_setup_complete, caps, source);
+	if (id == 0)
+		goto failed;
 
+	pending->id = id;
+	return;
 
-	return TRUE;
+failed:
+	if (pending->msg)
+		error_failed(pending->conn, pending->msg, "Stream setup failed");
+	pending_request_free(source->dev, pending);
+	source->connect = NULL;
+	avdtp_unref(source->session);
+	source->session = NULL;
 }
 
 static void discovery_complete(struct avdtp *session, GSList *seps, struct avdtp_error *err,
@@ -451,10 +346,6 @@ static void discovery_complete(struct avdtp *session, GSList *seps, struct avdtp
 {
 	struct source *source = user_data;
 	struct pending_request *pending;
-	struct avdtp_local_sep *lsep;
-	struct avdtp_remote_sep *rsep;
-	struct a2dp_sep *sep;
-	GSList *caps = NULL;
 	int id;
 
 	pending = source->connect;
@@ -476,25 +367,8 @@ static void discovery_complete(struct avdtp *session, GSList *seps, struct avdtp
 
 	DBG("Discovery complete");
 
-	if (avdtp_get_seps(session, AVDTP_SEP_TYPE_SOURCE, AVDTP_MEDIA_TYPE_AUDIO,
-				A2DP_CODEC_SBC, &lsep, &rsep) < 0) {
-		error("No matching ACP and INT SEPs found");
-		goto failed;
-	}
-
-	if (!select_capabilities(session, rsep, &caps)) {
-		error("Unable to select remote SEP capabilities");
-		goto failed;
-	}
-
-	sep = a2dp_get(session, rsep);
-	if (!sep) {
-		error("Unable to get a local sink SEP");
-		goto failed;
-	}
-
-	id = a2dp_config(source->session, sep, stream_setup_complete, caps,
-				source);
+	id = a2dp_select_capabilities(source->session, AVDTP_SEP_TYPE_SOURCE, NULL,
+						select_complete, source);
 	if (id == 0)
 		goto failed;
 
diff --git a/audio/transport.c b/audio/transport.c
new file mode 100644
index 0000000..c4d78a4
--- /dev/null
+++ b/audio/transport.c
@@ -0,0 +1,671 @@
+/*
+ *
+ *  BlueZ - Bluetooth protocol stack for Linux
+ *
+ *  Copyright (C) 2006-2007  Nokia Corporation
+ *  Copyright (C) 2004-2009  Marcel Holtmann <marcel@holtmann.org>
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
+#include <errno.h>
+
+#include <glib.h>
+#include <gdbus.h>
+
+#include "../src/adapter.h"
+#include "../src/dbus-common.h"
+
+#include "log.h"
+#include "error.h"
+#include "device.h"
+#include "avdtp.h"
+#include "media.h"
+#include "transport.h"
+#include "a2dp.h"
+#include "headset.h"
+
+#define MEDIA_TRANSPORT_INTERFACE "org.bluez.MediaTransport"
+
+struct acquire_request {
+	DBusMessage		*msg;
+	guint			id;
+	struct media_renderer	*renderer;
+};
+
+struct media_renderer {
+	struct media_transport	*transport;
+	struct acquire_request *request;
+	char			*name;
+	char			*accesstype;
+	guint			watch;
+};
+
+struct media_transport {
+	DBusConnection		*conn;
+	char			*path;		/* Transport object path */
+	struct audio_device	*device;	/* Transport device */
+	struct avdtp		*session;	/* Signalling session (a2dp only) */
+	struct media_endpoint	*endpoint;	/* Transport endpoint */
+	GSList			*renderers;	/* Transport renderers */
+	uint8_t			*configuration; /* Transport configuration */
+	int			size;		/* Transport configuration size */
+	int			fd;		/* Transport file descriptor */
+	uint16_t		imtu;		/* Transport input mtu */
+	uint16_t		omtu;		/* Transport output mtu */
+	uint16_t		delay;		/* Transport delay (a2dp only) */
+	gboolean		nrec;		/* Transport nrec (hfp only) */
+	gboolean		inband;		/* Transport inband ringtone support (hfp only) */
+	gboolean		read_lock;
+	gboolean		write_lock;
+	gboolean		in_use;
+	guint			(*resume) (struct media_transport *transport,
+					struct media_renderer *renderer);
+	void			(*suspend) (struct media_transport *transport);
+	void			(*cancel) (struct media_transport *transport,
+								guint id);
+	void			(*get_properties) (
+					struct media_transport *transport,
+					DBusMessageIter *dict);
+	DBusMessage		*(*set_property) (
+					struct media_transport *transport,
+					DBusConnection *conn,
+					DBusMessage *msg);
+};
+
+void media_transport_remove(struct media_transport *transport)
+{
+	char *path;
+
+	path = g_strdup(transport->path);
+
+	g_dbus_unregister_interface(transport->conn, path,
+						MEDIA_TRANSPORT_INTERFACE);
+
+	g_free(path);
+}
+
+static void acquire_request_free(struct acquire_request *req)
+{
+	struct media_renderer *renderer = req->renderer;
+	struct media_transport *transport = renderer->transport;
+
+	if (req->id)
+		transport->cancel(renderer->transport, req->id);
+
+	if (req->msg)
+		dbus_message_unref(req->msg);
+
+	renderer->request = NULL;
+	g_free(req);
+}
+
+static gboolean media_transport_release(struct media_transport *transport,
+					const char *accesstype)
+{
+	if (g_strstr_len(accesstype, -1, "r") != NULL) {
+		transport->read_lock = FALSE;
+		DBG("Transport %s: read lock released", transport->path);
+	}
+
+	if (g_strstr_len(accesstype, -1, "w") != NULL) {
+		transport->write_lock = FALSE;
+		DBG("Transport %s: write lock released", transport->path);
+	}
+
+	return TRUE;
+}
+
+static void media_renderer_remove(struct media_renderer *renderer)
+{
+	struct media_transport *transport = renderer->transport;
+
+	media_transport_release(transport, renderer->accesstype);
+
+	if (renderer->watch)
+		g_dbus_remove_watch(transport->conn, renderer->watch);
+
+	if (renderer->request) {
+		DBusMessage *reply = g_dbus_create_error(renderer->request->msg,
+						ERROR_INTERFACE ".Failed",
+						"%s", strerror(EIO));
+
+		g_dbus_send_message(transport->conn, reply);
+
+		acquire_request_free(renderer->request);
+	}
+
+	transport->renderers = g_slist_remove(transport->renderers, renderer);
+
+	/* Suspend if the is no longer any renderer */
+	if (transport->renderers == NULL)
+		transport->suspend(transport);
+
+	DBG("Renderer removed: sender=%s accesstype=%s", renderer->name,
+							renderer->accesstype);
+
+	g_free(renderer->name);
+	g_free(renderer->accesstype);
+	g_free(renderer);
+}
+
+static gboolean media_transport_set_fd(struct media_transport *transport,
+					int fd, uint16_t imtu, uint16_t omtu)
+{
+	if (transport->fd == fd)
+		return TRUE;
+
+	transport->fd = fd;
+	transport->imtu = imtu;
+	transport->omtu = omtu;
+
+	info("%s: fd(%d) ready", transport->path, fd);
+
+	emit_property_changed(transport->conn, transport->path,
+				MEDIA_TRANSPORT_INTERFACE, "IMTU",
+				DBUS_TYPE_UINT16, &transport->imtu);
+
+	emit_property_changed(transport->conn, transport->path,
+				MEDIA_TRANSPORT_INTERFACE, "OMTU",
+				DBUS_TYPE_UINT16, &transport->omtu);
+
+	return TRUE;
+}
+
+static gboolean remove_renderer(gpointer data)
+{
+	media_renderer_remove(data);
+
+	return FALSE;
+}
+
+static void a2dp_resume_complete(struct avdtp *session,
+				struct avdtp_error *err, void *user_data)
+{
+	struct media_renderer *renderer = user_data;
+	struct acquire_request *req = renderer->request;
+	struct media_transport *transport = renderer->transport;
+	struct a2dp_sep *sep = media_endpoint_get_sep(transport->endpoint);
+	struct avdtp_stream *stream;
+	int fd;
+	uint16_t imtu, omtu;
+
+	req->id = 0;
+
+	if (err)
+		goto fail;
+
+	stream = a2dp_sep_get_stream(sep);
+	if (stream == NULL)
+		goto fail;
+
+	if (avdtp_stream_get_transport(stream, &fd, &imtu, &omtu, NULL) ==
+			FALSE)
+		goto fail;
+
+	media_transport_set_fd(transport, fd, imtu, omtu);
+
+	if (g_dbus_send_reply(transport->conn, req->msg,
+				DBUS_TYPE_UNIX_FD, &fd,
+				DBUS_TYPE_INVALID) == FALSE)
+		goto fail;
+
+	return;
+
+fail:
+	/* Let the stream state change before removing the renderer */
+	g_idle_add(remove_renderer, renderer);
+}
+
+static guint resume_a2dp(struct media_transport *transport,
+				struct media_renderer *renderer)
+{
+	struct media_endpoint *endpoint = transport->endpoint;
+	struct audio_device *device = transport->device;
+	struct a2dp_sep *sep = media_endpoint_get_sep(endpoint);
+
+	if (transport->session == NULL) {
+		transport->session = avdtp_get(&device->src, &device->dst);
+		if (transport->session == NULL)
+			return 0;
+	}
+
+	if (transport->in_use == TRUE)
+		goto done;
+
+	transport->in_use = a2dp_sep_lock(sep, transport->session);
+	if (transport->in_use == FALSE)
+		return 0;
+
+done:
+	return a2dp_resume(transport->session, sep, a2dp_resume_complete,
+				renderer);
+}
+
+static void suspend_a2dp(struct media_transport *transport)
+{
+	struct media_endpoint *endpoint = transport->endpoint;
+	struct a2dp_sep *sep = media_endpoint_get_sep(endpoint);
+
+	a2dp_sep_unlock(sep, transport->session);
+	transport->in_use = FALSE;
+}
+
+static void cancel_a2dp(struct media_transport *transport, guint id)
+{
+	a2dp_cancel(transport->device, id);
+}
+
+static void headset_resume_complete(struct audio_device *dev, void *user_data)
+{
+	struct media_renderer *renderer = user_data;
+	struct acquire_request *req = renderer->request;
+	struct media_transport *transport = renderer->transport;
+	int fd;
+
+	req->id = 0;
+
+	if (dev == NULL)
+		goto fail;
+
+	fd = headset_get_sco_fd(dev);
+	if (fd < 0)
+		goto fail;
+
+	media_transport_set_fd(transport, fd, 48, 48);
+
+	if (g_dbus_send_reply(transport->conn, req->msg,
+				DBUS_TYPE_UNIX_FD, &fd,
+				DBUS_TYPE_INVALID) == FALSE)
+		goto fail;
+
+	return;
+
+fail:
+	media_renderer_remove(renderer);
+}
+
+static guint resume_headset(struct media_transport *transport,
+				struct media_renderer *renderer)
+{
+	struct audio_device *device = transport->device;
+
+	if (transport->in_use == TRUE)
+		goto done;
+
+	transport->in_use = headset_lock(device, HEADSET_LOCK_READ |
+						HEADSET_LOCK_WRITE);
+	if (transport->in_use == FALSE)
+		return 0;
+
+done:
+	return headset_request_stream(device, headset_resume_complete,
+					renderer);
+}
+
+static void suspend_headset(struct media_transport *transport)
+{
+	struct audio_device *device = transport->device;
+
+	headset_unlock(device, HEADSET_LOCK_READ | HEADSET_LOCK_WRITE);
+	transport->in_use = FALSE;
+}
+
+static void cancel_headset(struct media_transport *transport, guint id)
+{
+	headset_cancel_stream(transport->device, id);
+}
+
+static void media_renderer_exit(DBusConnection *connection, void *user_data)
+{
+	struct media_renderer *renderer = user_data;
+
+	renderer->watch = 0;
+	if (renderer->request != NULL)
+		acquire_request_free(renderer->request);
+
+	media_renderer_remove(renderer);
+}
+
+static gboolean media_transport_acquire(struct media_transport *transport,
+							const char *accesstype)
+{
+	gboolean read_lock = FALSE, write_lock = FALSE;
+
+	if (g_strstr_len(accesstype, -1, "r") != NULL) {
+		if (transport->read_lock == TRUE)
+			return FALSE;
+		read_lock = TRUE;
+	}
+
+	if (g_strstr_len(accesstype, -1, "w") != NULL) {
+		if (transport->write_lock == TRUE)
+			return FALSE;
+		write_lock = TRUE;
+	}
+
+	/* Check invalid accesstype */
+	if (read_lock == FALSE && write_lock == FALSE)
+		return FALSE;
+
+	if (read_lock) {
+		transport->read_lock = read_lock;
+		DBG("Transport %s: read lock acquired", transport->path);
+	}
+
+	if (write_lock) {
+		transport->write_lock = write_lock;
+		DBG("Transport %s: write lock acquired", transport->path);
+	}
+
+
+	return TRUE;
+}
+
+static struct media_renderer *media_renderer_create(
+					struct media_transport *transport,
+					DBusMessage *msg,
+					const char *accesstype)
+{
+	struct media_renderer *renderer;
+
+	renderer = g_new0(struct media_renderer, 1);
+	renderer->transport = transport;
+	renderer->name = g_strdup(dbus_message_get_sender(msg));
+	renderer->accesstype = g_strdup(accesstype);
+	renderer->watch = g_dbus_add_disconnect_watch(transport->conn,
+							renderer->name,
+							media_renderer_exit,
+							renderer, NULL);
+	transport->renderers = g_slist_append(transport->renderers, renderer);
+
+	DBG("Renderer created: sender=%s accesstype=%s", renderer->name,
+			accesstype);
+
+	return renderer;
+}
+
+static struct media_renderer *media_transport_find_renderer(
+					struct media_transport *transport,
+					const char *name)
+{
+	GSList *l;
+
+	for (l = transport->renderers; l; l = l->next) {
+		struct media_renderer *renderer = l->data;
+
+		if (g_strcmp0(renderer->name, name) == 0)
+			return renderer;
+	}
+
+	return NULL;
+}
+
+static DBusMessage *acquire(DBusConnection *conn, DBusMessage *msg,
+					void *data)
+{
+	struct media_transport *transport = data;
+	struct media_renderer *renderer;
+	struct acquire_request *req;
+	const char *accesstype, *sender;
+
+	if (!dbus_message_get_args(msg, NULL,
+				DBUS_TYPE_STRING, &accesstype,
+				DBUS_TYPE_INVALID))
+		return NULL;
+
+	sender = dbus_message_get_sender(msg);
+
+	renderer = media_transport_find_renderer(transport, sender);
+	if (renderer != NULL)
+		return g_dbus_create_error(msg, ERROR_INTERFACE
+						".Failed",
+						"Permission denied");
+
+	if (media_transport_acquire(transport, accesstype) == FALSE)
+		return g_dbus_create_error(msg, ERROR_INTERFACE
+						".Failed",
+						"Permission denied");
+
+	renderer = media_renderer_create(transport, msg, accesstype);
+	req = g_new0(struct acquire_request, 1);
+	req->msg = dbus_message_ref(msg);
+	req->renderer = renderer;
+	req->id = transport->resume(transport, renderer);
+	renderer->request = req;
+	if (req->id == 0)
+		media_renderer_remove(renderer);
+
+	return NULL;
+}
+
+static DBusMessage *release(DBusConnection *conn, DBusMessage *msg,
+					void *data)
+{
+	struct media_transport *transport = data;
+	struct media_renderer *renderer;
+	const char *accesstype, *sender;
+
+	if (!dbus_message_get_args(msg, NULL,
+				DBUS_TYPE_STRING, &accesstype,
+				DBUS_TYPE_INVALID))
+		return NULL;
+
+	sender = dbus_message_get_sender(msg);
+
+	renderer = media_transport_find_renderer(transport, sender);
+	if (renderer == NULL)
+		return g_dbus_create_error(msg, ERROR_INTERFACE
+						".Failed",
+						"Permission denied");
+
+	if (g_strcmp0(renderer->accesstype, accesstype) == 0)
+		media_renderer_remove(renderer);
+	else if (g_strstr_len(renderer->accesstype, -1, accesstype) != NULL) {
+		media_transport_release(transport, accesstype);
+		g_strdelimit(renderer->accesstype, accesstype, ' ');
+	} else
+		return g_dbus_create_error(msg, ERROR_INTERFACE
+						".Failed",
+						"Permission denied");
+
+	return g_dbus_create_reply(msg, DBUS_TYPE_INVALID);
+}
+
+static DBusMessage *set_property_a2dp(struct media_transport *transport,
+					DBusConnection *conn, DBusMessage *msg)
+{
+	return NULL;
+}
+
+static DBusMessage *set_property_headset(struct media_transport *transport,
+					DBusConnection *conn, DBusMessage *msg)
+{
+	return NULL;
+}
+
+static DBusMessage *set_property(DBusConnection *conn, DBusMessage *msg,
+								void *data)
+{
+	struct media_transport *transport = data;
+
+	return transport->set_property(transport, conn, msg);
+}
+
+static void get_properties_a2dp(struct media_transport *transport,
+						DBusMessageIter *dict)
+{
+	dict_append_entry(dict, "Delay", DBUS_TYPE_UINT16, &transport->delay);
+}
+
+static void get_properties_headset(struct media_transport *transport,
+						DBusMessageIter *dict)
+{
+	dict_append_entry(dict, "NREC", DBUS_TYPE_BOOLEAN, &transport->nrec);
+
+	dict_append_entry(dict, "InbandRingtone", DBUS_TYPE_BOOLEAN,
+							&transport->inband);
+}
+
+static DBusMessage *get_properties(DBusConnection *conn, DBusMessage *msg,
+					void *data)
+{
+	struct media_transport *transport = data;
+	DBusMessage *reply;
+	DBusMessageIter iter;
+	DBusMessageIter dict;
+	const char *uuid;
+	uint8_t codec;
+
+	reply = dbus_message_new_method_return(msg);
+	if (!reply)
+		return NULL;
+
+	dbus_message_iter_init_append(reply, &iter);
+
+	dbus_message_iter_open_container(&iter, DBUS_TYPE_ARRAY,
+			DBUS_DICT_ENTRY_BEGIN_CHAR_AS_STRING
+			DBUS_TYPE_STRING_AS_STRING DBUS_TYPE_VARIANT_AS_STRING
+			DBUS_DICT_ENTRY_END_CHAR_AS_STRING, &dict);
+
+	/* Device */
+	dict_append_entry(&dict, "Device", DBUS_TYPE_OBJECT_PATH,
+						&transport->device->path);
+
+	dict_append_entry(&dict, "ReadLock", DBUS_TYPE_BOOLEAN,
+						&transport->read_lock);
+
+	dict_append_entry(&dict, "WriteLock", DBUS_TYPE_BOOLEAN,
+						&transport->write_lock);
+
+	dict_append_entry(&dict, "IMTU", DBUS_TYPE_UINT16,
+						&transport->imtu);
+
+	dict_append_entry(&dict, "OMTU", DBUS_TYPE_UINT16,
+						&transport->omtu);
+
+	uuid = media_endpoint_get_uuid(transport->endpoint);
+	dict_append_entry(&dict, "UUID", DBUS_TYPE_STRING, &uuid);
+
+	codec = media_endpoint_get_codec(transport->endpoint);
+	dict_append_entry(&dict, "Codec", DBUS_TYPE_BYTE, &codec);
+
+	dict_append_array(&dict, "Configuration", DBUS_TYPE_BYTE,
+				&transport->configuration, transport->size);
+
+	if (transport->get_properties)
+		transport->get_properties(transport, &dict);
+
+	dbus_message_iter_close_container(&iter, &dict);
+
+	return reply;
+}
+
+static GDBusMethodTable transport_methods[] = {
+	{ "GetProperties",	"",	"a{sv}",	get_properties },
+	{ "Acquire",		"s",	"h",		acquire,
+						G_DBUS_METHOD_FLAG_ASYNC},
+	{ "Release",		"s",	"",		release },
+	{ "SetProperty",	"sv",	"",		set_property },
+	{ },
+};
+
+static GDBusSignalTable transport_signals[] = {
+	{ "PropertyChanged",	"sv"	},
+	{ }
+};
+
+static void media_transport_free(void *data)
+{
+	struct media_transport *transport = data;
+
+	g_slist_foreach(transport->renderers, (GFunc) media_renderer_remove,
+				NULL);
+	g_slist_free(transport->renderers);
+
+	if (transport->session)
+		avdtp_unref(transport->session);
+
+	if (transport->conn)
+		dbus_connection_unref(transport->conn);
+
+	g_free(transport->configuration);
+	g_free(transport->path);
+	g_free(transport);
+}
+
+struct media_transport *media_transport_create(DBusConnection *conn,
+						struct media_endpoint *endpoint,
+						struct audio_device *device,
+						uint8_t *configuration,
+						size_t size)
+{
+	struct media_transport *transport;
+	const char *uuid;
+	static int fd = 0;
+
+	transport = g_new0(struct media_transport, 1);
+	transport->conn = dbus_connection_ref(conn);
+	transport->device = device;
+	transport->endpoint = endpoint;
+	transport->configuration = g_new(uint8_t, size);
+	memcpy(transport->configuration, configuration, size);
+	transport->size = size;
+	transport->path = g_strdup_printf("%s/fd%d", device->path, fd++);
+	transport->fd = -1;
+
+	uuid = media_endpoint_get_uuid(endpoint);
+	if (g_strcmp0(uuid, A2DP_SOURCE_UUID) == 0 ||
+			g_strcmp0(uuid, A2DP_SINK_UUID) == 0) {
+		transport->resume = resume_a2dp;
+		transport->suspend = suspend_a2dp;
+		transport->cancel = cancel_a2dp;
+		transport->get_properties = get_properties_a2dp;
+		transport->set_property = set_property_a2dp;
+	} else if (g_strcmp0(uuid, HFP_AG_UUID) == 0 ||
+			g_strcmp0(uuid, HSP_AG_UUID) == 0) {
+		transport->resume = resume_headset;
+		transport->suspend = suspend_headset;
+		transport->cancel = cancel_headset;
+		transport->get_properties = get_properties_headset;
+		transport->set_property = set_property_headset;
+	} else
+		goto fail;
+
+	if (g_dbus_register_interface(transport->conn, transport->path,
+				MEDIA_TRANSPORT_INTERFACE,
+				transport_methods, transport_signals, NULL,
+				transport, media_transport_free) == FALSE) {
+		error("Could not register transport %s", transport->path);
+		goto fail;
+	}
+
+	return transport;
+
+fail:
+	media_transport_free(transport);
+	return NULL;
+}
+
+const char *media_transport_get_path(struct media_transport *transport)
+{
+	return transport->path;
+}
diff --git a/audio/transport.h b/audio/transport.h
new file mode 100644
index 0000000..a7594f0
--- /dev/null
+++ b/audio/transport.h
@@ -0,0 +1,34 @@
+/*
+ *
+ *  BlueZ - Bluetooth protocol stack for Linux
+ *
+ *  Copyright (C) 2006-2007  Nokia Corporation
+ *  Copyright (C) 2004-2009  Marcel Holtmann <marcel@holtmann.org>
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
+struct media_transport;
+
+struct media_transport *media_transport_create(DBusConnection *conn,
+						struct media_endpoint *endpoint,
+						struct audio_device *device,
+						uint8_t *configuration,
+						size_t size);
+
+void media_transport_remove(struct media_transport *transport);
+const char *media_transport_get_path(struct media_transport *transport);
diff --git a/audio/unix.c b/audio/unix.c
index cf2704c..ad822bd 100644
--- a/audio/unix.c
+++ b/audio/unix.c
@@ -44,6 +44,7 @@
 #include "device.h"
 #include "manager.h"
 #include "avdtp.h"
+#include "media.h"
 #include "a2dp.h"
 #include "headset.h"
 #include "sink.h"
-- 
1.7.1

