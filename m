Return-Path: <cyrus@holtmann.org>
From: =?utf-8?q?Jo=C3=A3o=20Paulo=20Rechi=20Vita?= <jprvita@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: luiz.dentz@gmail.com,
	=?utf-8?q?Jo=C3=A3o=20Paulo=20Rechi=20Vita?= <jprvita@gmail.com>
Subject: [PATCH 1/4] Adapt A2DP functions to support the Sink role.
Date: Mon, 13 Jul 2009 12:28:50 -0300
Message-Id: <1247498933-30609-2-git-send-email-jprvita@gmail.com>
In-Reply-To: <1247498933-30609-1-git-send-email-jprvita@gmail.com>
References: <1247498933-30609-1-git-send-email-jprvita@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Modify a2dp_source_* functions to more generic a2dp_record(), a2dp_get(),
a2dp_config(), a2dp_resume(), a2dp_suspend(), and a2dp_cancel() which can handle
both the Sink and Source roles.
---
 audio/a2dp.c |  191 ++++++++++++++++++++++++++++++++++------------------------
 audio/a2dp.h |   11 ++--
 audio/sink.c |    7 +-
 audio/unix.c |   19 +++---
 4 files changed, 128 insertions(+), 100 deletions(-)

diff --git a/audio/a2dp.c b/audio/a2dp.c
index 2c4d047..7d14865 100644
--- a/audio/a2dp.c
+++ b/audio/a2dp.c
@@ -41,6 +41,7 @@
 #include "manager.h"
 #include "avdtp.h"
 #include "sink.h"
+#include "source.h"
 #include "a2dp.h"
 #include "sdpd.h"
 
@@ -933,10 +934,10 @@ static struct avdtp_sep_ind mpeg_ind = {
 	.reconfigure		= reconf_ind
 };
 
-static sdp_record_t *a2dp_source_record()
+static sdp_record_t *a2dp_record(uint8_t type)
 {
 	sdp_list_t *svclass_id, *pfseq, *apseq, *root;
-	uuid_t root_uuid, l2cap, avdtp, a2src;
+	uuid_t root_uuid, l2cap_uuid, avdtp_uuid, a2dp_uuid;
 	sdp_profile_desc_t profile[1];
 	sdp_list_t *aproto, *proto[2];
 	sdp_record_t *record;
@@ -951,8 +952,11 @@ static sdp_record_t *a2dp_source_record()
 	root = sdp_list_append(0, &root_uuid);
 	sdp_set_browse_groups(record, root);
 
-	sdp_uuid16_create(&a2src, AUDIO_SOURCE_SVCLASS_ID);
-	svclass_id = sdp_list_append(0, &a2src);
+	if (type == AVDTP_SEP_TYPE_SOURCE)
+		sdp_uuid16_create(&a2dp_uuid, AUDIO_SOURCE_SVCLASS_ID);
+	else
+		sdp_uuid16_create(&a2dp_uuid, AUDIO_SINK_SVCLASS_ID);
+	svclass_id = sdp_list_append(0, &a2dp_uuid);
 	sdp_set_service_classes(record, svclass_id);
 
 	sdp_uuid16_create(&profile[0].uuid, ADVANCED_AUDIO_PROFILE_ID);
@@ -960,14 +964,14 @@ static sdp_record_t *a2dp_source_record()
 	pfseq = sdp_list_append(0, &profile[0]);
 	sdp_set_profile_descs(record, pfseq);
 
-	sdp_uuid16_create(&l2cap, L2CAP_UUID);
-	proto[0] = sdp_list_append(0, &l2cap);
+	sdp_uuid16_create(&l2cap_uuid, L2CAP_UUID);
+	proto[0] = sdp_list_append(0, &l2cap_uuid);
 	psm = sdp_data_alloc(SDP_UINT16, &lp);
 	proto[0] = sdp_list_append(proto[0], psm);
 	apseq = sdp_list_append(0, proto[0]);
 
-	sdp_uuid16_create(&avdtp, AVDTP_UUID);
-	proto[1] = sdp_list_append(0, &avdtp);
+	sdp_uuid16_create(&avdtp_uuid, AVDTP_UUID);
+	proto[1] = sdp_list_append(0, &avdtp_uuid);
 	version = sdp_data_alloc(SDP_UINT16, &ver);
 	proto[1] = sdp_list_append(proto[1], version);
 	apseq = sdp_list_append(apseq, proto[1]);
@@ -978,7 +982,10 @@ static sdp_record_t *a2dp_source_record()
 	features = sdp_data_alloc(SDP_UINT16, &feat);
 	sdp_attr_add(record, SDP_ATTR_SUPPORTED_FEATURES, features);
 
-	sdp_set_info_attr(record, "Audio Source", 0, 0);
+	if (type == AVDTP_SEP_TYPE_SOURCE)
+		sdp_set_info_attr(record, "Audio Source", 0, 0);
+	else
+		sdp_set_info_attr(record, "Audio Sink", 0, 0);
 
 	free(psm);
 	free(version);
@@ -993,17 +1000,11 @@ static sdp_record_t *a2dp_source_record()
 	return record;
 }
 
-static sdp_record_t *a2dp_sink_record()
-{
-	return NULL;
-}
-
 static struct a2dp_sep *a2dp_add_sep(struct a2dp_server *server, uint8_t type,
 					uint8_t codec)
 {
 	struct a2dp_sep *sep;
 	GSList **l;
-	sdp_record_t *(*create_record)(void);
 	uint32_t *record_id;
 	sdp_record_t *record;
 	struct avdtp_sep_ind *ind;
@@ -1024,18 +1025,16 @@ static struct a2dp_sep *a2dp_add_sep(struct a2dp_server *server, uint8_t type,
 
 	if (type == AVDTP_SEP_TYPE_SOURCE) {
 		l = &server->sources;
-		create_record = a2dp_source_record;
 		record_id = &server->source_record_id;
 	} else {
 		l = &server->sinks;
-		create_record = a2dp_sink_record;
 		record_id = &server->sink_record_id;
 	}
 
 	if (*record_id != 0)
 		goto add;
 
-	record = create_record();
+	record = a2dp_record(type);
 	if (!record) {
 		error("Unable to allocate new service record");
 		avdtp_unregister_sep(sep->sep);
@@ -1215,42 +1214,7 @@ void a2dp_unregister(const bdaddr_t *src)
 	connection = NULL;
 }
 
-gboolean a2dp_source_cancel(struct audio_device *dev, unsigned int id)
-{
-	struct a2dp_setup_cb *cb_data;
-	struct a2dp_setup *setup;
-	GSList *l;
-
-	debug("a2dp_source_cancel()");
-
-	setup = find_setup_by_dev(dev);
-	if (!setup)
-		return FALSE;
-
-	for (cb_data = NULL, l = setup->cb; l != NULL; l = g_slist_next(l)) {
-		struct a2dp_setup_cb *cb = l->data;
-
-		if (cb->id == id) {
-			cb_data = cb;
-			break;
-		}
-	}
-
-	if (!cb_data)
-		error("a2dp_source_cancel: no matching callback with id %u", id);
-
-	setup->cb = g_slist_remove(setup->cb, cb_data);
-	g_free(cb_data);
-
-	if (!setup->cb) {
-		setup->canceled = TRUE;
-		setup->sep = NULL;
-	}
-
-	return TRUE;
-}
-
-struct a2dp_sep *a2dp_source_get(struct avdtp *session,
+struct a2dp_sep *a2dp_get(struct avdtp *session,
 				struct avdtp_remote_sep *rsep)
 {
 	GSList *l;
@@ -1267,23 +1231,38 @@ struct a2dp_sep *a2dp_source_get(struct avdtp *session,
 	cap = avdtp_get_codec(rsep);
 	codec_cap = (void *) cap->data;
 
-	for (l = server->sources; l != NULL; l = l->next) {
-		struct a2dp_sep *sep = l->data;
+	if (avdtp_get_type(rsep) == AVDTP_SEP_TYPE_SINK)
+		for (l = server->sources; l != NULL; l = l->next) {
+			struct a2dp_sep *sep = l->data;
 
-		if (sep->locked)
-			continue;
+			if (sep->locked)
+				continue;
 
-		if (sep->codec != codec_cap->media_codec_type)
-			continue;
+			if (sep->codec != codec_cap->media_codec_type)
+				continue;
 
-		if (!sep->stream || avdtp_has_stream(session, sep->stream))
-			return sep;
-	}
+			if (!sep->stream || avdtp_has_stream(session, sep->stream))
+				return sep;
+		}
+
+	if (avdtp_get_type(rsep) == AVDTP_SEP_TYPE_SOURCE)
+		for (l = server->sinks; l != NULL; l = l->next) {
+			struct a2dp_sep *sep = l->data;
+
+			if (sep->locked)
+				continue;
+
+			if (sep->codec != codec_cap->media_codec_type)
+				continue;
+
+			if (!sep->stream || avdtp_has_stream(session, sep->stream))
+				return sep;
+		}
 
 	return NULL;
 }
 
-unsigned int a2dp_source_config(struct avdtp *session, struct a2dp_sep *sep,
+unsigned int a2dp_config(struct avdtp *session, struct a2dp_sep *sep,
 				a2dp_config_cb_t cb, GSList *caps,
 				void *user_data)
 {
@@ -1320,7 +1299,7 @@ unsigned int a2dp_source_config(struct avdtp *session, struct a2dp_sep *sep,
 	if (sep->codec != codec_cap->media_codec_type)
 		return 0;
 
-	debug("a2dp_source_config: selected SEP %p", sep->sep);
+	debug("a2dp_config: selected SEP %p", sep->sep);
 
 	cb_data = g_new0(struct a2dp_setup_cb, 1);
 	cb_data->config_cb = cb;
@@ -1343,12 +1322,19 @@ unsigned int a2dp_source_config(struct avdtp *session, struct a2dp_sep *sep,
 
 	switch (avdtp_sep_get_state(sep->sep)) {
 	case AVDTP_STATE_IDLE:
-		for (l = server->sources; l != NULL; l = l->next) {
-			tmp = l->data;
+		if (sep->type == AVDTP_SEP_TYPE_SOURCE)
+			for (l = server->sources; l != NULL; l = l->next) {
+				tmp = l->data;
+				if (avdtp_has_stream(session, tmp->stream))
+					break;
+			}
 
-			if (avdtp_has_stream(session, tmp->stream))
-				break;
-		}
+		if (sep->type == AVDTP_SEP_TYPE_SINK)
+			for (l = server->sinks; l != NULL; l = l->next) {
+				tmp = l->data;
+				if (avdtp_has_stream(session, tmp->stream))
+					break;
+			}
 
 		if (l != NULL) {
 			setup->reconfigure = TRUE;
@@ -1359,13 +1345,23 @@ unsigned int a2dp_source_config(struct avdtp *session, struct a2dp_sep *sep,
 			break;
 		}
 
-		if (avdtp_get_seps(session, AVDTP_SEP_TYPE_SINK,
-				codec_cap->media_type,
-				codec_cap->media_codec_type,
-				&lsep, &rsep) < 0) {
-			error("No matching ACP and INT SEPs found");
-			goto failed;
-		}
+		if (sep->type == AVDTP_SEP_TYPE_SOURCE)
+			if (avdtp_get_seps(session, AVDTP_SEP_TYPE_SINK,
+					codec_cap->media_type,
+					codec_cap->media_codec_type,
+					&lsep, &rsep) < 0) {
+				error("No matching ACP and INT SEPs found");
+				goto failed;
+			}
+
+		if (sep->type == AVDTP_SEP_TYPE_SINK)
+			if (avdtp_get_seps(session, AVDTP_SEP_TYPE_SOURCE,
+					codec_cap->media_type,
+					codec_cap->media_codec_type,
+					&lsep, &rsep) < 0) {
+				error("No matching ACP and INT SEPs found");
+				goto failed;
+			}
 
 		posix_err = avdtp_set_configuration(session, rsep, lsep,
 							caps, &setup->stream);
@@ -1401,7 +1397,7 @@ failed:
 	return 0;
 }
 
-unsigned int a2dp_source_resume(struct avdtp *session, struct a2dp_sep *sep,
+unsigned int a2dp_resume(struct avdtp *session, struct a2dp_sep *sep,
 				a2dp_stream_cb_t cb, void *user_data)
 {
 	struct a2dp_setup_cb *cb_data;
@@ -1460,7 +1456,7 @@ failed:
 	return 0;
 }
 
-unsigned int a2dp_source_suspend(struct avdtp *session, struct a2dp_sep *sep,
+unsigned int a2dp_suspend(struct avdtp *session, struct a2dp_sep *sep,
 				a2dp_stream_cb_t cb, void *user_data)
 {
 	struct a2dp_setup_cb *cb_data;
@@ -1486,7 +1482,7 @@ unsigned int a2dp_source_suspend(struct avdtp *session, struct a2dp_sep *sep,
 
 	switch (avdtp_sep_get_state(sep->sep)) {
 	case AVDTP_STATE_IDLE:
-		error("a2dp_source_suspend: no stream to suspend");
+		error("a2dp_suspend: no stream to suspend");
 		goto failed;
 		break;
 	case AVDTP_STATE_OPEN:
@@ -1511,6 +1507,41 @@ failed:
 	return 0;
 }
 
+gboolean a2dp_cancel(struct audio_device *dev, unsigned int id)
+{
+	struct a2dp_setup_cb *cb_data;
+	struct a2dp_setup *setup;
+	GSList *l;
+
+	debug("a2dp_cancel()");
+
+	setup = find_setup_by_dev(dev);
+	if (!setup)
+		return FALSE;
+
+	for (cb_data = NULL, l = setup->cb; l != NULL; l = g_slist_next(l)) {
+		struct a2dp_setup_cb *cb = l->data;
+
+		if (cb->id == id) {
+			cb_data = cb;
+			break;
+		}
+	}
+
+	if (!cb_data)
+		error("a2dp_cancel: no matching callback with id %u", id);
+
+	setup->cb = g_slist_remove(setup->cb, cb_data);
+	g_free(cb_data);
+
+	if (!setup->cb) {
+		setup->canceled = TRUE;
+		setup->sep = NULL;
+	}
+
+	return TRUE;
+}
+
 gboolean a2dp_sep_lock(struct a2dp_sep *sep, struct avdtp *session)
 {
 	if (sep->locked)
diff --git a/audio/a2dp.h b/audio/a2dp.h
index 0e5f796..f08c643 100644
--- a/audio/a2dp.h
+++ b/audio/a2dp.h
@@ -132,16 +132,15 @@ typedef void (*a2dp_stream_cb_t) (struct avdtp *session,
 int a2dp_register(DBusConnection *conn, const bdaddr_t *src, GKeyFile *config);
 void a2dp_unregister(const bdaddr_t *src);
 
-struct a2dp_sep *a2dp_source_get(struct avdtp *session,
-				struct avdtp_remote_sep *sep);
-unsigned int a2dp_source_config(struct avdtp *session, struct a2dp_sep *sep,
+struct a2dp_sep *a2dp_get(struct avdtp *session, struct avdtp_remote_sep *sep);
+unsigned int a2dp_config(struct avdtp *session, struct a2dp_sep *sep,
 				a2dp_config_cb_t cb, GSList *caps,
 				void *user_data);
-unsigned int a2dp_source_resume(struct avdtp *session, struct a2dp_sep *sep,
+unsigned int a2dp_resume(struct avdtp *session, struct a2dp_sep *sep,
 				a2dp_stream_cb_t cb, void *user_data);
-unsigned int a2dp_source_suspend(struct avdtp *session, struct a2dp_sep *sep,
+unsigned int a2dp_suspend(struct avdtp *session, struct a2dp_sep *sep,
 				a2dp_stream_cb_t cb, void *user_data);
-gboolean a2dp_source_cancel(struct audio_device *dev, unsigned int id);
+gboolean a2dp_cancel(struct audio_device *dev, unsigned int id);
 
 gboolean a2dp_sep_lock(struct a2dp_sep *sep, struct avdtp *session);
 gboolean a2dp_sep_unlock(struct a2dp_sep *sep, struct avdtp *session);
diff --git a/audio/sink.c b/audio/sink.c
index 17e07b1..00b2ea7 100644
--- a/audio/sink.c
+++ b/audio/sink.c
@@ -165,7 +165,7 @@ static void pending_request_free(struct audio_device *dev,
 	if (pending->msg)
 		dbus_message_unref(pending->msg);
 	if (pending->id)
-		a2dp_source_cancel(dev, pending->id);
+		a2dp_cancel(dev, pending->id);
 
 	g_free(pending);
 }
@@ -520,14 +520,13 @@ static void discovery_complete(struct avdtp *session, GSList *seps, struct avdtp
 		goto failed;
 	}
 
-	sep = a2dp_source_get(session, rsep);
+	sep = a2dp_get(session, rsep);
 	if (!sep) {
 		error("Unable to get a local source SEP");
 		goto failed;
 	}
 
-	id = a2dp_source_config(sink->session, sep, stream_setup_complete,
-				caps, sink);
+	id = a2dp_config(sink->session, sep, stream_setup_complete, caps, sink);
 	if (id == 0)
 		goto failed;
 
diff --git a/audio/unix.c b/audio/unix.c
index 1212f5b..f241a83 100644
--- a/audio/unix.c
+++ b/audio/unix.c
@@ -903,7 +903,7 @@ static void start_open(struct audio_device *dev, struct unix_client *client)
 			goto failed;
 		}
 
-		a2dp->sep = a2dp_source_get(a2dp->session, rsep);
+		a2dp->sep = a2dp_get(a2dp->session, rsep);
 		if (!a2dp->sep) {
 			error("seid %d not available or locked", client->seid);
 			goto failed;
@@ -972,10 +972,9 @@ static void start_config(struct audio_device *dev, struct unix_client *client)
 			goto failed;
 		}
 
-		id = a2dp_source_config(a2dp->session, a2dp->sep,
-					a2dp_config_complete, client->caps,
-					client);
-		client->cancel = a2dp_source_cancel;
+		id = a2dp_config(a2dp->session, a2dp->sep, a2dp_config_complete,
+					client->caps, client);
+		client->cancel = a2dp_cancel;
 		break;
 
 	case TYPE_HEADSET:
@@ -1039,9 +1038,9 @@ static void start_resume(struct audio_device *dev, struct unix_client *client)
 			goto failed;
 		}
 
-		id = a2dp_source_resume(a2dp->session, a2dp->sep,
-					a2dp_resume_complete, client);
-		client->cancel = a2dp_source_cancel;
+		id = a2dp_resume(a2dp->session, a2dp->sep, a2dp_resume_complete,
+					client);
+		client->cancel = a2dp_cancel;
 
 		break;
 
@@ -1107,9 +1106,9 @@ static void start_suspend(struct audio_device *dev, struct unix_client *client)
 			goto failed;
 		}
 
-		id = a2dp_source_suspend(a2dp->session, a2dp->sep,
+		id = a2dp_suspend(a2dp->session, a2dp->sep,
 					a2dp_suspend_complete, client);
-		client->cancel = a2dp_source_cancel;
+		client->cancel = a2dp_cancel;
 		break;
 
 	case TYPE_HEADSET:
-- 
1.6.0.4

