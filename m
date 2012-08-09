Return-Path: <cyrus@holtmann.org>
From: chanyeol.park@samsung.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ V2 2/3] audio: Remove legacy SBC endpoint
Date: Thu, 09 Aug 2012 16:45:43 +0900
Message-id: <1344498344-19268-3-git-send-email-chanyeol.park@samsung.com>
In-reply-to: <1344498344-19268-1-git-send-email-chanyeol.park@samsung.com>
References: <1344498344-19268-1-git-send-email-chanyeol.park@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Chan-yeol Park <chanyeol.park@samsung.com>

---
 audio/a2dp.c |  283 ----------------------------------------------------------
 audio/a2dp.h |   46 ----------
 2 files changed, 329 deletions(-)

diff --git a/audio/a2dp.c b/audio/a2dp.c
index 4567ce0..36fee09 100644
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
@@ -1672,148 +1531,6 @@ void a2dp_remove_sep(struct a2dp_sep *sep)
 	a2dp_unregister_sep(sep);
 }
 
-static uint8_t default_bitpool(uint8_t freq, uint8_t mode)
-{
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
-
-	media_codec = avdtp_service_cap_new(AVDTP_MEDIA_CODEC, &sbc_cap,
-						sizeof(sbc_cap));
-
-	*caps = g_slist_append(*caps, media_codec);
-
-	if (avdtp_get_delay_reporting(rsep)) {
-		struct avdtp_service_capability *delay_reporting;
-		delay_reporting = avdtp_service_cap_new(AVDTP_DELAY_REPORTING,
-								NULL, 0);
-		*caps = g_slist_append(*caps, delay_reporting);
-	}
-
-	return TRUE;
-}
-
 static void select_cb(struct a2dp_setup *setup, void *ret, int size)
 {
 	struct avdtp_service_capability *media_transport, *media_codec;
diff --git a/audio/a2dp.h b/audio/a2dp.h
index 3a677aa..c9feac8 100644
--- a/audio/a2dp.h
+++ b/audio/a2dp.h
@@ -28,27 +28,6 @@
 #define A2DP_CODEC_MPEG24		0x02
 #define A2DP_CODEC_ATRAC		0x03
 
-#define SBC_SAMPLING_FREQ_16000		(1 << 3)
-#define SBC_SAMPLING_FREQ_32000		(1 << 2)
-#define SBC_SAMPLING_FREQ_44100		(1 << 1)
-#define SBC_SAMPLING_FREQ_48000		1
-
-#define SBC_CHANNEL_MODE_MONO		(1 << 3)
-#define SBC_CHANNEL_MODE_DUAL_CHANNEL	(1 << 2)
-#define SBC_CHANNEL_MODE_STEREO		(1 << 1)
-#define SBC_CHANNEL_MODE_JOINT_STEREO	1
-
-#define SBC_BLOCK_LENGTH_4		(1 << 3)
-#define SBC_BLOCK_LENGTH_8		(1 << 2)
-#define SBC_BLOCK_LENGTH_12		(1 << 1)
-#define SBC_BLOCK_LENGTH_16		1
-
-#define SBC_SUBBANDS_4			(1 << 1)
-#define SBC_SUBBANDS_8			1
-
-#define SBC_ALLOCATION_SNR		(1 << 1)
-#define SBC_ALLOCATION_LOUDNESS		1
-
 #define MPEG_CHANNEL_MODE_MONO		(1 << 3)
 #define MPEG_CHANNEL_MODE_DUAL_CHANNEL	(1 << 2)
 #define MPEG_CHANNEL_MODE_STEREO	(1 << 1)
@@ -65,22 +44,8 @@
 #define MPEG_SAMPLING_FREQ_44100	(1 << 1)
 #define MPEG_SAMPLING_FREQ_48000	1
 
-#define MAX_BITPOOL 64
-#define MIN_BITPOOL 2
-
 #if __BYTE_ORDER == __LITTLE_ENDIAN
 
-struct sbc_codec_cap {
-	struct avdtp_media_codec_capability cap;
-	uint8_t channel_mode:4;
-	uint8_t frequency:4;
-	uint8_t allocation_method:2;
-	uint8_t subbands:2;
-	uint8_t block_length:4;
-	uint8_t min_bitpool;
-	uint8_t max_bitpool;
-} __attribute__ ((packed));
-
 struct mpeg_codec_cap {
 	struct avdtp_media_codec_capability cap;
 	uint8_t channel_mode:4;
@@ -94,17 +59,6 @@ struct mpeg_codec_cap {
 
 #elif __BYTE_ORDER == __BIG_ENDIAN
 
-struct sbc_codec_cap {
-	struct avdtp_media_codec_capability cap;
-	uint8_t frequency:4;
-	uint8_t channel_mode:4;
-	uint8_t block_length:4;
-	uint8_t subbands:2;
-	uint8_t allocation_method:2;
-	uint8_t min_bitpool;
-	uint8_t max_bitpool;
-} __attribute__ ((packed));
-
 struct mpeg_codec_cap {
 	struct avdtp_media_codec_capability cap;
 	uint8_t layer:3;
-- 
1.7.9.5

