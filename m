Return-Path: <cyrus@holtmann.org>
From: chanyeol.park@samsung.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/3] audio: Remove legacy SBC endpoint
Date: Thu, 09 Aug 2012 15:09:27 +0900
Message-id: <1344492568-22777-3-git-send-email-chanyeol.park@samsung.com>
In-reply-to: <1344492568-22777-1-git-send-email-chanyeol.park@samsung.com>
References: <1344492568-22777-1-git-send-email-chanyeol.park@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Chan-yeol Park <chanyeol.park@samsung.com>


diff --git a/audio/a2dp.c b/audio/a2dp.c
index a4369f5..fc8f1b7 100644
--- a/audio/a2dp.c
+++ b/audio/a2dp.c
@@ -411,134 +411,6 @@ done:
 	return FALSE;
 }
 
-static gboolean sbc_setconf_ind(struct avdtp *session,
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
-	/* Check valid settings */
-	for (; caps != NULL; caps = g_slist_next(caps)) {
-		struct avdtp_service_capability *cap = caps->data;
-		struct avdtp_media_codec_capability *codec_cap;
-		struct sbc_codec_cap *sbc_cap;
-
-		if (cap->category == AVDTP_DELAY_REPORTING &&
-					!a2dp_sep->delay_reporting) {
-			setup->err = g_new(struct avdtp_error, 1);
-			avdtp_error_init(setup->err, AVDTP_DELAY_REPORTING,
-						AVDTP_UNSUPPORTED_CONFIGURATION);
-			goto done;
-		}
-
-		if (cap->category != AVDTP_MEDIA_CODEC)
-			continue;
-
-		if (cap->length < sizeof(struct sbc_codec_cap))
-			continue;
-
-		codec_cap = (void *) cap->data;
-
-		if (codec_cap->media_codec_type != A2DP_CODEC_SBC)
-			continue;
-
-		sbc_cap = (void *) codec_cap;
-
-		if (sbc_cap->min_bitpool < MIN_BITPOOL ||
-					sbc_cap->max_bitpool > MAX_BITPOOL) {
-			setup->err = g_new(struct avdtp_error, 1);
-			avdtp_error_init(setup->err, AVDTP_MEDIA_CODEC,
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
-static gboolean sbc_getcap_ind(struct avdtp *session, struct avdtp_local_sep *sep,
-				gboolean get_all, GSList **caps, uint8_t *err,
-				void *user_data)
-{
-	struct a2dp_sep *a2dp_sep = user_data;
-	struct avdtp_service_capability *media_transport, *media_codec;
-	struct sbc_codec_cap sbc_cap;
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
-	memset(&sbc_cap, 0, sizeof(struct sbc_codec_cap));
-
-	sbc_cap.cap.media_type = AVDTP_MEDIA_TYPE_AUDIO;
-	sbc_cap.cap.media_codec_type = A2DP_CODEC_SBC;
-
-	sbc_cap.frequency = ( SBC_SAMPLING_FREQ_48000 |
-				SBC_SAMPLING_FREQ_44100 |
-				SBC_SAMPLING_FREQ_32000 |
-				SBC_SAMPLING_FREQ_16000 );
-
-	sbc_cap.channel_mode = ( SBC_CHANNEL_MODE_JOINT_STEREO |
-					SBC_CHANNEL_MODE_STEREO |
-					SBC_CHANNEL_MODE_DUAL_CHANNEL |
-					SBC_CHANNEL_MODE_MONO );
-
-	sbc_cap.block_length = ( SBC_BLOCK_LENGTH_16 |
-					SBC_BLOCK_LENGTH_12 |
-					SBC_BLOCK_LENGTH_8 |
-					SBC_BLOCK_LENGTH_4 );
-
-	sbc_cap.subbands = ( SBC_SUBBANDS_8 | SBC_SUBBANDS_4 );
-
-	sbc_cap.allocation_method = ( SBC_ALLOCATION_LOUDNESS |
-					SBC_ALLOCATION_SNR );
-
-	sbc_cap.min_bitpool = MIN_BITPOOL;
-	sbc_cap.max_bitpool = MAX_BITPOOL;
-
-	media_codec = avdtp_service_cap_new(AVDTP_MEDIA_CODEC, &sbc_cap,
-						sizeof(sbc_cap));
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
 static gboolean mpeg_setconf_ind(struct avdtp *session,
 					struct avdtp_local_sep *sep,
 					struct avdtp_stream *stream,
@@ -1317,19 +1189,6 @@ static struct avdtp_sep_cfm cfm = {
 	.delay_report		= delay_report_cfm,
 };
 
-static struct avdtp_sep_ind sbc_ind = {
-	.get_capability		= sbc_getcap_ind,
-	.set_configuration	= sbc_setconf_ind,
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
 static struct avdtp_sep_ind mpeg_ind = {
 	.get_capability		= mpeg_getcap_ind,
 	.set_configuration	= mpeg_setconf_ind,
-- 
1.7.9.5

