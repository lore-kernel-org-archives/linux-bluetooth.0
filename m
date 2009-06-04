Return-Path: <cyrus@holtmann.org>
From: =?utf-8?q?Jo=C3=A3o=20Paulo=20Rechi=20Vita?= <jprvita@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: =?utf-8?q?Jo=C3=A3o=20Paulo=20Rechi=20Vita?= <jprvita@gmail.com>
Subject: [PATCH 4/6] Create a2dp_sink_config().
Date: Thu,  4 Jun 2009 16:09:54 -0300
Message-Id: <1244142596-8076-4-git-send-email-jprvita@gmail.com>
In-Reply-To: <1244142596-8076-3-git-send-email-jprvita@gmail.com>
References: <1244142596-8076-1-git-send-email-jprvita@gmail.com>
 <1244142596-8076-2-git-send-email-jprvita@gmail.com>
 <1244142596-8076-3-git-send-email-jprvita@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 audio/a2dp.c |  118 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 audio/a2dp.h |    3 +
 2 files changed, 121 insertions(+), 0 deletions(-)

diff --git a/audio/a2dp.c b/audio/a2dp.c
index 605dfed..dc4f699 100644
--- a/audio/a2dp.c
+++ b/audio/a2dp.c
@@ -1634,6 +1634,124 @@ struct a2dp_sep *a2dp_sink_get(struct avdtp *session,
 	return NULL;
 }
 
+unsigned int a2dp_sink_config(struct avdtp *session, struct a2dp_sep *sep,
+				a2dp_config_cb_t cb, GSList *caps,
+				void *user_data)
+{
+	struct a2dp_setup_cb *cb_data;
+	GSList *l;
+	struct a2dp_server *server;
+	struct a2dp_setup *setup;
+	struct a2dp_sep *tmp;
+	struct avdtp_local_sep *lsep;
+	struct avdtp_remote_sep *rsep;
+	struct avdtp_service_capability *cap;
+	struct avdtp_media_codec_capability *codec_cap = NULL;
+	int posix_err;
+	bdaddr_t src;
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
+	debug("a2dp_sink_config: selected SEP %p", sep->sep);
+
+	cb_data = g_new0(struct a2dp_setup_cb, 1);
+	cb_data->config_cb = cb;
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
+	setup->stream = sep->stream;
+	setup->client_caps = caps;
+
+	switch (avdtp_sep_get_state(sep->sep)) {
+	case AVDTP_STATE_IDLE:
+		for (l = server->sinks; l != NULL; l = l->next) {
+			tmp = l->data;
+
+			if (avdtp_has_stream(session, tmp->stream))
+				break;
+		}
+
+		if (l != NULL) {
+			setup->reconfigure = TRUE;
+			if (avdtp_close(session, tmp->stream) < 0) {
+				error("avdtp_close failed");
+				goto failed;
+			}
+			break;
+		}
+
+		if (avdtp_get_seps(session, AVDTP_SEP_TYPE_SOURCE,
+				codec_cap->media_type,
+				codec_cap->media_codec_type,
+				&lsep, &rsep) < 0) {
+			error("No matching ACP and INT SEPs found");
+			goto failed;
+		}
+
+		posix_err = avdtp_set_configuration(session, rsep, lsep,
+							caps, &setup->stream);
+		if (posix_err < 0) {
+			error("avdtp_set_configuration: %s",
+				strerror(-posix_err));
+			goto failed;
+		}
+		break;
+	case AVDTP_STATE_OPEN:
+	case AVDTP_STATE_STREAMING:
+		if (avdtp_stream_has_capabilities(setup->stream, caps)) {
+			debug("Configuration match: resuming");
+			g_idle_add((GSourceFunc) finalize_config, setup);
+		} else if (!setup->reconfigure) {
+			setup->reconfigure = TRUE;
+			if (avdtp_close(session, sep->stream) < 0) {
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
+	setup_unref(setup);
+	cb_id--;
+	return 0;
+}
+
 gboolean a2dp_sep_lock(struct a2dp_sep *sep, struct avdtp *session)
 {
 	if (sep->locked)
diff --git a/audio/a2dp.h b/audio/a2dp.h
index f0a61e3..3be38a7 100644
--- a/audio/a2dp.h
+++ b/audio/a2dp.h
@@ -145,6 +145,9 @@ gboolean a2dp_source_cancel(struct audio_device *dev, unsigned int id);
 
 struct a2dp_sep *a2dp_sink_get(struct avdtp *session,
 				struct avdtp_remote_sep *sep);
+unsigned int a2dp_sink_config(struct avdtp *session, struct a2dp_sep *sep,
+				a2dp_config_cb_t cb, GSList *caps,
+				void *user_data);
 gboolean a2dp_sink_cancel(struct audio_device *dev, unsigned int id);
 
 gboolean a2dp_sep_lock(struct a2dp_sep *sep, struct avdtp *session);
-- 
1.6.0.4

