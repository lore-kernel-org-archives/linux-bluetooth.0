Return-Path: <cyrus@holtmann.org>
From: chanyeol.park@samsung.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ V2 1/3] audio: Remove unused local A2DP endpoints
 reference
Date: Thu, 09 Aug 2012 16:45:42 +0900
Message-id: <1344498344-19268-2-git-send-email-chanyeol.park@samsung.com>
In-reply-to: <1344498344-19268-1-git-send-email-chanyeol.park@samsung.com>
References: <1344498344-19268-1-git-send-email-chanyeol.park@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Chan-yeol Park <chanyeol.park@samsung.com>

---
 audio/a2dp.c |   74 +++-------------------------------------------------------
 audio/a2dp.h |    2 --
 2 files changed, 3 insertions(+), 73 deletions(-)

diff --git a/audio/a2dp.c b/audio/a2dp.c
index db4bb13..4567ce0 100644
--- a/audio/a2dp.c
+++ b/audio/a2dp.c
@@ -1562,7 +1562,6 @@ struct a2dp_sep *a2dp_add_sep(const bdaddr_t *src, uint8_t type,
 	GSList **l;
 	uint32_t *record_id;
 	sdp_record_t *record;
-	struct avdtp_sep_ind *ind;
 
 	server = find_server(servers, src);
 	if (server == NULL) {
@@ -1585,17 +1584,11 @@ struct a2dp_sep *a2dp_add_sep(const bdaddr_t *src, uint8_t type,
 
 	sep = g_new0(struct a2dp_sep, 1);
 
-	if (endpoint) {
-		ind = &endpoint_ind;
-		goto proceed;
-	}
-
-	ind = (codec == A2DP_CODEC_MPEG12) ? &mpeg_ind : &sbc_ind;
-
-proceed:
 	sep->lsep = avdtp_register_sep(&server->src, type,
 					AVDTP_MEDIA_TYPE_AUDIO, codec,
-					delay_reporting, ind, &cfm, sep);
+					delay_reporting, &endpoint_ind,
+					&cfm, sep);
+
 	if (sep->lsep == NULL) {
 		g_free(sep);
 		if (err)
@@ -1679,44 +1672,6 @@ void a2dp_remove_sep(struct a2dp_sep *sep)
 	a2dp_unregister_sep(sep);
 }
 
-struct a2dp_sep *a2dp_get(struct avdtp *session,
-				struct avdtp_remote_sep *rsep)
-{
-	GSList *l;
-	struct a2dp_server *server;
-	struct avdtp_service_capability *cap;
-	struct avdtp_media_codec_capability *codec_cap = NULL;
-	bdaddr_t src;
-
-	avdtp_get_peers(session, &src, NULL);
-	server = find_server(servers, &src);
-	if (!server)
-		return NULL;
-
-	cap = avdtp_get_codec(rsep);
-	codec_cap = (void *) cap->data;
-
-	if (avdtp_get_type(rsep) == AVDTP_SEP_TYPE_SINK)
-		l = server->sources;
-	else
-		l = server->sinks;
-
-	for (; l != NULL; l = l->next) {
-		struct a2dp_sep *sep = l->data;
-
-		if (sep->locked)
-			continue;
-
-		if (sep->codec != codec_cap->media_codec_type)
-			continue;
-
-		if (!sep->stream || avdtp_has_stream(session, sep->stream))
-			return sep;
-	}
-
-	return NULL;
-}
-
 static uint8_t default_bitpool(uint8_t freq, uint8_t mode)
 {
 	switch (freq) {
@@ -1889,15 +1844,6 @@ done:
 	finalize_select(setup);
 }
 
-static gboolean auto_select(gpointer data)
-{
-	struct a2dp_setup *setup = data;
-
-	finalize_select(setup);
-
-	return FALSE;
-}
-
 static struct a2dp_sep *a2dp_find_sep(struct avdtp *session, GSList *list,
 					const char *sender)
 {
@@ -1982,20 +1928,6 @@ unsigned int a2dp_select_capabilities(struct avdtp *session,
 		goto fail;
 	}
 
-	/* FIXME: Remove auto select when it is not longer possible to register
-	endpoint in the configuration file */
-	if (sep->endpoint == NULL) {
-		if (!select_capabilities(session, setup->rsep,
-					&setup->caps)) {
-			error("Unable to auto select remote SEP capabilities");
-			goto fail;
-		}
-
-		g_idle_add(auto_select, setup);
-
-		return cb_data->id;
-	}
-
 	service = avdtp_get_codec(setup->rsep);
 	codec = (struct avdtp_media_codec_capability *) service->data;
 
diff --git a/audio/a2dp.h b/audio/a2dp.h
index 887c5ac..3a677aa 100644
--- a/audio/a2dp.h
+++ b/audio/a2dp.h
@@ -171,8 +171,6 @@ struct a2dp_sep *a2dp_add_sep(const bdaddr_t *src, uint8_t type,
 				int *err);
 void a2dp_remove_sep(struct a2dp_sep *sep);
 
-struct a2dp_sep *a2dp_get(struct avdtp *session, struct avdtp_remote_sep *sep);
-
 unsigned int a2dp_select_capabilities(struct avdtp *session,
 					uint8_t type, const char *sender,
 					a2dp_select_cb_t cb,
-- 
1.7.9.5

