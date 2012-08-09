Return-Path: <cyrus@holtmann.org>
From: chanyeol.park@samsung.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 3/3] audio: Remove legacy MPEG endpoint
Date: Thu, 09 Aug 2012 15:09:28 +0900
Message-id: <1344492568-22777-4-git-send-email-chanyeol.park@samsung.com>
In-reply-to: <1344492568-22777-1-git-send-email-chanyeol.park@samsung.com>
References: <1344492568-22777-1-git-send-email-chanyeol.park@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Chan-yeol Park <chanyeol.park@samsung.com>


diff --git a/audio/a2dp.c b/audio/a2dp.c
index fc8f1b7..05eb777 100644
--- a/audio/a2dp.c
+++ b/audio/a2dp.c
@@ -411,105 +411,6 @@ done:
 	return FALSE;
 }
 
-static gboolean mpeg_setconf_ind(struct avdtp *session,
-					struct avdtp_local_sep *sep,
-					struct avdtp_stream *stream,
-					GSList *caps,
-					avdtp_set_configuration_cb cb,
-					void *user_data)
-{
-	struct a2dp_sep *a2dp_sep = user_data;
-	struct a2dp_setup *setup;
-
-	if (a2dp_sep->type == AVDTP_SEP_TYPE_SINK)
-		DBG("Sink %p: Set_Configuration_Ind", sep);
-	else
-		DBG("Source %p: Set_Configuration_Ind", sep);
-
-	setup = a2dp_setup_get(session);
-	if (!setup)
-		return FALSE;
-
-	a2dp_sep->stream = stream;
-	setup->sep = a2dp_sep;
-	setup->stream = stream;
-	setup->setconf_cb = cb;
-
-	for (; caps != NULL; caps = g_slist_next(caps)) {
-		struct avdtp_service_capability *cap = caps->data;
-
-		if (cap->category == AVDTP_DELAY_REPORTING &&
-					!a2dp_sep->delay_reporting) {
-			setup->err = g_new(struct avdtp_error, 1);
-			avdtp_error_init(setup->err, AVDTP_DELAY_REPORTING,
-					AVDTP_UNSUPPORTED_CONFIGURATION);
-			goto done;
-		}
-	}
-
-done:
-	g_idle_add(auto_config, setup);
-	return TRUE;
-}
-
-static gboolean mpeg_getcap_ind(struct avdtp *session,
-				struct avdtp_local_sep *sep,
-				gboolean get_all,
-				GSList **caps, uint8_t *err, void *user_data)
-{
-	struct a2dp_sep *a2dp_sep = user_data;
-	struct avdtp_service_capability *media_transport, *media_codec;
-	struct mpeg_codec_cap mpeg_cap;
-
-	if (a2dp_sep->type == AVDTP_SEP_TYPE_SINK)
-		DBG("Sink %p: Get_Capability_Ind", sep);
-	else
-		DBG("Source %p: Get_Capability_Ind", sep);
-
-	*caps = NULL;
-
-	media_transport = avdtp_service_cap_new(AVDTP_MEDIA_TRANSPORT,
-						NULL, 0);
-
-	*caps = g_slist_append(*caps, media_transport);
-
-	memset(&mpeg_cap, 0, sizeof(struct mpeg_codec_cap));
-
-	mpeg_cap.cap.media_type = AVDTP_MEDIA_TYPE_AUDIO;
-	mpeg_cap.cap.media_codec_type = A2DP_CODEC_MPEG12;
-
-	mpeg_cap.frequency = ( MPEG_SAMPLING_FREQ_48000 |
-				MPEG_SAMPLING_FREQ_44100 |
-				MPEG_SAMPLING_FREQ_32000 |
-				MPEG_SAMPLING_FREQ_24000 |
-				MPEG_SAMPLING_FREQ_22050 |
-				MPEG_SAMPLING_FREQ_16000 );
-
-	mpeg_cap.channel_mode = ( MPEG_CHANNEL_MODE_JOINT_STEREO |
-					MPEG_CHANNEL_MODE_STEREO |
-					MPEG_CHANNEL_MODE_DUAL_CHANNEL |
-					MPEG_CHANNEL_MODE_MONO );
-
-	mpeg_cap.layer = ( MPEG_LAYER_MP3 | MPEG_LAYER_MP2 | MPEG_LAYER_MP1 );
-
-	mpeg_cap.bitrate = 0xFFFF;
-
-	media_codec = avdtp_service_cap_new(AVDTP_MEDIA_CODEC, &mpeg_cap,
-						sizeof(mpeg_cap));
-
-	*caps = g_slist_append(*caps, media_codec);
-
-	if (get_all) {
-		struct avdtp_service_capability *delay_reporting;
-		delay_reporting = avdtp_service_cap_new(AVDTP_DELAY_REPORTING,
-								NULL, 0);
-		*caps = g_slist_append(*caps, delay_reporting);
-	}
-
-	return TRUE;
-}
-
-
 static void endpoint_setconf_cb(struct a2dp_setup *setup, gboolean ret)
 {
 	if (ret == FALSE) {
@@ -1105,21 +1006,6 @@ static gboolean reconf_ind(struct avdtp *session, struct avdtp_local_sep *sep,
 	return TRUE;
 }
 
-static gboolean delayreport_ind(struct avdtp *session,
-				struct avdtp_local_sep *sep,
-				uint8_t rseid, uint16_t delay,
-				uint8_t *err, void *user_data)
-{
-	struct a2dp_sep *a2dp_sep = user_data;
-
-	if (a2dp_sep->type == AVDTP_SEP_TYPE_SINK)
-		DBG("Sink %p: DelayReport_Ind", sep);
-	else
-		DBG("Source %p: DelayReport_Ind", sep);
-
-	return TRUE;
-}
-
 static gboolean endpoint_delayreport_ind(struct avdtp *session,
 						struct avdtp_local_sep *sep,
 						uint8_t rseid, uint16_t delay,
@@ -1189,19 +1075,6 @@ static struct avdtp_sep_cfm cfm = {
 	.delay_report		= delay_report_cfm,
 };
 
-static struct avdtp_sep_ind mpeg_ind = {
-	.get_capability		= mpeg_getcap_ind,
-	.set_configuration	= mpeg_setconf_ind,
-	.get_configuration	= getconf_ind,
-	.open			= open_ind,
-	.start			= start_ind,
-	.suspend		= suspend_ind,
-	.close			= close_ind,
-	.abort			= abort_ind,
-	.reconfigure		= reconf_ind,
-	.delayreport		= delayreport_ind,
-};
-
 static struct avdtp_sep_ind endpoint_ind = {
 	.get_capability		= endpoint_getcap_ind,
 	.set_configuration	= endpoint_setconf_ind,
-- 
1.7.9.5

