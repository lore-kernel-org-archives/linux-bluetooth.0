Return-Path: <cyrus@holtmann.org>
From: Chan-yeol Park <chanyeol.park@samsung.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFC BlueZ v4 1/2] audio/avdtp: Add a2dp vendor codec match callback
Date: Wed, 20 May 2015 21:09:47 +0900
Message-id: <1432123788-12967-1-git-send-email-chanyeol.park@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

When matching remote SEP to local SEP avdtp does not compare vendor
codecs properly, i.e. neither vendor ID not codec ID are checked,
which may cause wrong endpoint to be selected in case there are more
that one endpoints using vendor codec on remote.

This patch fixes it by adding a2dp codec match call back.
---
 profiles/audio/a2dp.c  | 36 ++++++++++++++++++++++++++++++++++++
 profiles/audio/avdtp.c |  5 +++++
 profiles/audio/avdtp.h |  3 +++
 3 files changed, 44 insertions(+)

diff --git a/profiles/audio/a2dp.c b/profiles/audio/a2dp.c
index 31c5086..3c5a8a2 100644
--- a/profiles/audio/a2dp.c
+++ b/profiles/audio/a2dp.c
@@ -447,6 +447,41 @@ static void endpoint_setconf_cb(struct a2dp_setup *setup, gboolean ret)
 	auto_config(setup);
 }
 
+static gboolean a2dp_codec_matched_ind(struct avdtp *session,
+			struct avdtp_media_codec_capability *rcodec_data,
+						void *user_data)
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
@@ -1114,6 +1149,7 @@ static struct avdtp_sep_cfm cfm = {
 };
 
 static struct avdtp_sep_ind endpoint_ind = {
+	.codec_matched		= a2dp_codec_matched_ind,
 	.get_capability		= endpoint_getcap_ind,
 	.set_configuration	= endpoint_setconf_ind,
 	.get_configuration	= getconf_ind,
diff --git a/profiles/audio/avdtp.c b/profiles/audio/avdtp.c
index f38188f..181658c 100644
--- a/profiles/audio/avdtp.c
+++ b/profiles/audio/avdtp.c
@@ -1226,6 +1226,11 @@ struct avdtp_remote_sep *avdtp_find_remote_sep(struct avdtp *session,
 		if (codec_data->media_codec_type != lsep->codec)
 			continue;
 
+		if (lsep->ind && lsep->ind->codec_matched)
+			if (!lsep->ind->codec_matched(session, codec_data,
+						 lsep->user_data))
+				continue;
+
 		if (sep->stream == NULL)
 			return sep;
 	}
diff --git a/profiles/audio/avdtp.h b/profiles/audio/avdtp.h
index 1b02232..683be45 100644
--- a/profiles/audio/avdtp.h
+++ b/profiles/audio/avdtp.h
@@ -172,6 +172,9 @@ struct avdtp_sep_cfm {
 /* Callbacks for indicating when we received a new command. The return value
  * indicates whether the command should be rejected or accepted */
 struct avdtp_sep_ind {
+	gboolean (*codec_matched) (struct avdtp *session,
+			struct avdtp_media_codec_capability *rcodec_data,
+					void *user_data);
 	gboolean (*get_capability) (struct avdtp *session,
 					struct avdtp_local_sep *sep,
 					gboolean get_all,
-- 
2.1.0

