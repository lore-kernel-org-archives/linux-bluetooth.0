Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH SBC v2 1/2] sbc: Add sbc_init_a2dp
Date: Mon, 20 Jan 2014 20:51:52 +0200
Message-Id: <1390243913-13962-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This adds sbc_init_a2dp that can be used to convert A2DP configuration to
the internal representation since they are not binary compatible.
---
 sbc/sbc.c | 144 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 sbc/sbc.h |   2 +
 2 files changed, 146 insertions(+)

diff --git a/sbc/sbc.c b/sbc/sbc.c
index c589217..9352446 100644
--- a/sbc/sbc.c
+++ b/sbc/sbc.c
@@ -57,6 +57,55 @@
 #define MSBC_SYNCWORD	0xAD
 #define MSBC_BLOCKS	15
 
+#define A2DP_SAMPLING_FREQ_16000		(1 << 3)
+#define A2DP_SAMPLING_FREQ_32000		(1 << 2)
+#define A2DP_SAMPLING_FREQ_44100		(1 << 1)
+#define A2DP_SAMPLING_FREQ_48000		1
+
+#define A2DP_CHANNEL_MODE_MONO			(1 << 3)
+#define A2DP_CHANNEL_MODE_DUAL_CHANNEL		(1 << 2)
+#define A2DP_CHANNEL_MODE_STEREO		(1 << 1)
+#define A2DP_CHANNEL_MODE_JOINT_STEREO		1
+
+#define A2DP_BLOCK_LENGTH_4			(1 << 3)
+#define A2DP_BLOCK_LENGTH_8			(1 << 2)
+#define A2DP_BLOCK_LENGTH_12			(1 << 1)
+#define A2DP_BLOCK_LENGTH_16			1
+
+#define A2DP_SUBBANDS_4				(1 << 1)
+#define A2DP_SUBBANDS_8				1
+
+#define A2DP_ALLOCATION_SNR			(1 << 1)
+#define A2DP_ALLOCATION_LOUDNESS		1
+
+#if __BYTE_ORDER == __LITTLE_ENDIAN
+
+struct a2dp_sbc {
+	uint8_t channel_mode:4;
+	uint8_t frequency:4;
+	uint8_t allocation_method:2;
+	uint8_t subbands:2;
+	uint8_t block_length:4;
+	uint8_t min_bitpool;
+	uint8_t max_bitpool;
+} __attribute__ ((packed));
+
+#elif __BYTE_ORDER == __BIG_ENDIAN
+
+struct a2dp_sbc {
+	uint8_t frequency:4;
+	uint8_t channel_mode:4;
+	uint8_t block_length:4;
+	uint8_t subbands:2;
+	uint8_t allocation_method:2;
+	uint8_t min_bitpool;
+	uint8_t max_bitpool;
+} __attribute__ ((packed));
+
+#else
+#error "Unknown byte order"
+#endif
+
 /* This structure contains an unpacked SBC frame.
    Yes, there is probably quite some unused space herein */
 struct sbc_frame {
@@ -1046,6 +1095,101 @@ SBC_EXPORT int sbc_init_msbc(sbc_t *sbc, unsigned long flags)
 	return 0;
 }
 
+SBC_EXPORT int sbc_init_a2dp(sbc_t *sbc, unsigned long flags,
+						const void *config, size_t len)
+{
+	const struct a2dp_sbc *a2dp;
+	int err;
+
+	if (len != sizeof(*a2dp))
+		return -EINVAL;
+
+	err = sbc_init(sbc, flags);
+	if (err < 0)
+		return err;
+
+	a2dp = config;
+
+	switch (a2dp->frequency) {
+	case A2DP_SAMPLING_FREQ_16000:
+		sbc->frequency = SBC_FREQ_16000;
+		break;
+	case A2DP_SAMPLING_FREQ_32000:
+		sbc->frequency = SBC_FREQ_32000;
+		break;
+	case A2DP_SAMPLING_FREQ_44100:
+		sbc->frequency = SBC_FREQ_44100;
+		break;
+	case A2DP_SAMPLING_FREQ_48000:
+		sbc->frequency = SBC_FREQ_48000;
+		break;
+	default:
+		goto failed;
+	}
+
+	switch (a2dp->channel_mode) {
+	case A2DP_CHANNEL_MODE_MONO:
+		sbc->mode = SBC_MODE_MONO;
+		break;
+	case A2DP_CHANNEL_MODE_DUAL_CHANNEL:
+		sbc->mode = SBC_MODE_DUAL_CHANNEL;
+		break;
+	case A2DP_CHANNEL_MODE_STEREO:
+		sbc->mode = SBC_MODE_STEREO;
+		break;
+	case A2DP_CHANNEL_MODE_JOINT_STEREO:
+		sbc->mode = SBC_MODE_JOINT_STEREO;
+		break;
+	default:
+		goto failed;
+	}
+
+	switch (a2dp->allocation_method) {
+	case A2DP_ALLOCATION_SNR:
+		sbc->allocation = SBC_AM_SNR;
+		break;
+	case A2DP_ALLOCATION_LOUDNESS:
+		sbc->allocation = SBC_AM_LOUDNESS;
+		break;
+	default:
+		goto failed;
+	}
+
+	switch (a2dp->subbands) {
+	case A2DP_SUBBANDS_4:
+		sbc->subbands = SBC_SB_4;
+		break;
+	case A2DP_SUBBANDS_8:
+		sbc->subbands = SBC_SB_8;
+		break;
+	default:
+		goto failed;
+	}
+
+	switch (a2dp->block_length) {
+	case A2DP_BLOCK_LENGTH_4:
+		sbc->blocks = SBC_BLK_4;
+		break;
+	case A2DP_BLOCK_LENGTH_8:
+		sbc->blocks = SBC_BLK_8;
+		break;
+	case A2DP_BLOCK_LENGTH_12:
+		sbc->blocks = SBC_BLK_12;
+		break;
+	case A2DP_BLOCK_LENGTH_16:
+		sbc->blocks = SBC_BLK_16;
+		break;
+	default:
+		goto failed;
+	}
+
+	return 0;
+
+failed:
+	sbc_finish(sbc);
+	return -EINVAL;
+}
+
 SBC_EXPORT ssize_t sbc_parse(sbc_t *sbc, const void *input, size_t input_len)
 {
 	return sbc_decode(sbc, input, input_len, NULL, 0, NULL);
diff --git a/sbc/sbc.h b/sbc/sbc.h
index 5f8a1fc..5791faa 100644
--- a/sbc/sbc.h
+++ b/sbc/sbc.h
@@ -84,6 +84,8 @@ typedef struct sbc_struct sbc_t;
 int sbc_init(sbc_t *sbc, unsigned long flags);
 int sbc_reinit(sbc_t *sbc, unsigned long flags);
 int sbc_init_msbc(sbc_t *sbc, unsigned long flags);
+int sbc_init_a2dp(sbc_t *sbc, unsigned long flags, const void *config,
+								size_t len);
 
 ssize_t sbc_parse(sbc_t *sbc, const void *input, size_t input_len);
 
-- 
1.8.4.2

