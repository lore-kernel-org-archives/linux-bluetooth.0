Return-Path: <cyrus@holtmann.org>
From: Chan-yeol Park <chanyeol.park@samsung.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFC BlueZ v5 1/2] audio/avdtp: Add a2dp vendor codec match callback
Date: Thu, 21 May 2015 19:24:19 +0900
Message-id: <1432203860-12371-1-git-send-email-chanyeol.park@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

When matching remote SEP to local SEP avdtp does not compare vendor
codecs properly, i.e. neither vendor ID not codec ID are checked,
which may cause wrong endpoint to be selected in case there are more
that one endpoints using vendor codec on remote.

This patch fixes it by adding a2dp codec match call back.
---
 profiles/audio/a2dp.c  | 37 ++++++++++++++++++++++++++++++++++++-
 profiles/audio/avdtp.c |  7 +++++++
 profiles/audio/avdtp.h |  4 ++++
 3 files changed, 47 insertions(+), 1 deletion(-)

diff --git a/profiles/audio/a2dp.c b/profiles/audio/a2dp.c
index 31c5086..e9579c0 100644
--- a/profiles/audio/a2dp.c
+++ b/profiles/audio/a2dp.c
@@ -447,6 +447,41 @@ static void endpoint_setconf_cb(struct a2dp_setup *setup, gboolean ret)
 	auto_config(setup);
 }
 
+static gboolean a2dp_codec_matched_cb(
+			struct avdtp_media_codec_capability *rcodec_data,
+					void *user_data)
+{
+	struct a2dp_sep *sep = user_data;
+	a2dp_vendor_codec_t *remote_codec;
+	a2dp_vendor_codec_t *local_codec;
+	uint8_t *capabilities;
+	size_t length;
+
+	if (rcodec_data->media_codec_type != A2DP_CODEC_VENDOR)
+		return TRUE;
+
+	if (sep->endpoint == NULL)
+		return FALSE;
+
+	length = sep->endpoint->get_capabilities(sep, &capabilities,
+							sep->user_data);
+	if (length < sizeof(a2dp_vendor_codec_t))
+		return FALSE;
+
+	local_codec = (a2dp_vendor_codec_t *) capabilities;
+	remote_codec = (a2dp_vendor_codec_t *) rcodec_data->data;
+
+	if (remote_codec->vendor_id != local_codec->vendor_id)
+		return FALSE;
+
+	if (remote_codec->codec_id != local_codec->codec_id)
+		return FALSE;
+
+	DBG("vendor 0x%08x codec 0x%04x", btohl(remote_codec->vendor_id),
+						btohs(remote_codec->codec_id));
+	return TRUE;
+}
+
 static gboolean endpoint_setconf_ind(struct avdtp *session,
 						struct avdtp_local_sep *sep,
 						struct avdtp_stream *stream,
@@ -1588,7 +1623,7 @@ struct a2dp_sep *a2dp_add_sep(struct btd_adapter *adapter, uint8_t type,
 	sep->lsep = avdtp_register_sep(server->seps, type,
 					AVDTP_MEDIA_TYPE_AUDIO, codec,
 					delay_reporting, &endpoint_ind,
-					&cfm, sep);
+					&cfm, a2dp_codec_matched_cb, sep);
 
 	if (sep->lsep == NULL) {
 		g_free(sep);
diff --git a/profiles/audio/avdtp.c b/profiles/audio/avdtp.c
index f38188f..de44f6f 100644
--- a/profiles/audio/avdtp.c
+++ b/profiles/audio/avdtp.c
@@ -332,6 +332,7 @@ struct avdtp_local_sep {
 	GSList *caps;
 	struct avdtp_sep_ind *ind;
 	struct avdtp_sep_cfm *cfm;
+	codec_matched_cb codec_matched;
 	void *user_data;
 };
 
@@ -1226,6 +1227,10 @@ struct avdtp_remote_sep *avdtp_find_remote_sep(struct avdtp *session,
 		if (codec_data->media_codec_type != lsep->codec)
 			continue;
 
+		if (lsep->codec_matched &&
+			!lsep->codec_matched(codec_data, lsep->user_data))
+				continue;
+
 		if (sep->stream == NULL)
 			return sep;
 	}
@@ -3521,6 +3526,7 @@ struct avdtp_local_sep *avdtp_register_sep(struct queue *lseps, uint8_t type,
 						gboolean delay_reporting,
 						struct avdtp_sep_ind *ind,
 						struct avdtp_sep_cfm *cfm,
+						codec_matched_cb cb,
 						void *user_data)
 {
 	struct avdtp_local_sep *sep;
@@ -3538,6 +3544,7 @@ struct avdtp_local_sep *avdtp_register_sep(struct queue *lseps, uint8_t type,
 	sep->codec = codec_type;
 	sep->ind = ind;
 	sep->cfm = cfm;
+	sep->codec_matched = cb;
 	sep->user_data = user_data;
 	sep->delay_reporting = delay_reporting;
 
diff --git a/profiles/audio/avdtp.h b/profiles/audio/avdtp.h
index 1b02232..906f53e 100644
--- a/profiles/audio/avdtp.h
+++ b/profiles/audio/avdtp.h
@@ -132,6 +132,9 @@ typedef void (*avdtp_stream_state_cb) (struct avdtp_stream *stream,
 typedef void (*avdtp_set_configuration_cb) (struct avdtp *session,
 						struct avdtp_stream *stream,
 						struct avdtp_error *err);
+typedef	gboolean (*codec_matched_cb) (
+			struct avdtp_media_codec_capability *rcodec_data,
+					void *user_data);
 
 /* Callbacks for when a reply is received to a command that we sent */
 struct avdtp_sep_cfm {
@@ -275,6 +278,7 @@ struct avdtp_local_sep *avdtp_register_sep(struct queue *lseps, uint8_t type,
 						gboolean delay_reporting,
 						struct avdtp_sep_ind *ind,
 						struct avdtp_sep_cfm *cfm,
+						codec_matched_cb cb,
 						void *user_data);
 
 /* Find a matching pair of local and remote SEP ID's */
-- 
2.1.0

