Return-Path: <cyrus@holtmann.org>
From: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
Subject: [PATCH v2 4/6] android/hal-audio: Write SBC parameters to logcat
Date: Mon, 10 Feb 2014 11:45:43 +0100
Message-ID: <1392029145-7954-4-git-send-email-andrzej.kaczmarek@tieto.com>
In-Reply-To: <1392029145-7954-1-git-send-email-andrzej.kaczmarek@tieto.com>
References: <1392029145-7954-1-git-send-email-andrzej.kaczmarek@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/hal-audio.c | 81 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 81 insertions(+)

diff --git a/android/hal-audio.c b/android/hal-audio.c
index 766327b..9312659 100644
--- a/android/hal-audio.c
+++ b/android/hal-audio.c
@@ -289,6 +289,78 @@ static int sbc_get_presets(struct audio_preset *preset, size_t *len)
 	return i;
 }
 
+static int sbc_freq2int(uint8_t freq)
+{
+	switch (freq) {
+	case SBC_SAMPLING_FREQ_16000:
+		return 16000;
+	case SBC_SAMPLING_FREQ_32000:
+		return 32000;
+	case SBC_SAMPLING_FREQ_44100:
+		return 44100;
+	case SBC_SAMPLING_FREQ_48000:
+		return 48000;
+	default:
+		return 0;
+	}
+}
+
+static const char *sbc_mode2str(uint8_t mode)
+{
+	switch (mode) {
+	case SBC_CHANNEL_MODE_MONO:
+		return "Mono";
+	case SBC_CHANNEL_MODE_DUAL_CHANNEL:
+		return "DualChannel";
+	case SBC_CHANNEL_MODE_STEREO:
+		return "Stereo";
+	case SBC_CHANNEL_MODE_JOINT_STEREO:
+		return "JointStereo";
+	default:
+		return "(unknown)";
+	}
+}
+
+static int sbc_blocks2int(uint8_t blocks)
+{
+	switch (blocks) {
+	case SBC_BLOCK_LENGTH_4:
+		return 4;
+	case SBC_BLOCK_LENGTH_8:
+		return 8;
+	case SBC_BLOCK_LENGTH_12:
+		return 12;
+	case SBC_BLOCK_LENGTH_16:
+		return 16;
+	default:
+		return 0;
+	}
+}
+
+static int sbc_subbands2int(uint8_t subbands)
+{
+	switch (subbands) {
+	case SBC_SUBBANDS_4:
+		return 4;
+	case SBC_SUBBANDS_8:
+		return 8;
+	default:
+		return 0;
+	}
+}
+
+static const char *sbc_allocation2str(uint8_t allocation)
+{
+	switch (allocation) {
+	case SBC_ALLOCATION_SNR:
+		return "SNR";
+	case SBC_ALLOCATION_LOUDNESS:
+		return "Loudness";
+	default:
+		return "(unknown)";
+	}
+}
+
 static void sbc_init_encoder(struct sbc_data *sbc_data)
 {
 	a2dp_sbc_t *in = &sbc_data->sbc;
@@ -298,6 +370,15 @@ static void sbc_init_encoder(struct sbc_data *sbc_data)
 
 	out->endian = SBC_LE;
 	out->bitpool = in->max_bitpool;
+
+	DBG("frequency=%d channel_mode=%s block_length=%d subbands=%d "
+			"allocation=%s bitpool=%d-%d",
+			sbc_freq2int(in->frequency),
+			sbc_mode2str(in->channel_mode),
+			sbc_blocks2int(in->block_length),
+			sbc_subbands2int(in->subbands),
+			sbc_allocation2str(in->allocation_method),
+			in->min_bitpool, in->max_bitpool);
 }
 
 static int sbc_codec_init(struct audio_preset *preset, uint16_t mtu,
-- 
1.8.5.3

