Return-Path: <cyrus@holtmann.org>
From: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
Subject: [PATCH 1/6] android/hal-audio: Remove unsupported mono channel mode
Date: Mon, 3 Feb 2014 16:44:47 +0100
Message-ID: <1391442292-4668-1-git-send-email-andrzej.kaczmarek@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

AudioFlinger can only provide PCM 16bit Stereo data for A2DP track so
we should not advertise mono channel mode in capabilities since we
can't downmix this internally.
---
 android/hal-audio.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/android/hal-audio.c b/android/hal-audio.c
index 8ef5bff..4578c53 100644
--- a/android/hal-audio.c
+++ b/android/hal-audio.c
@@ -227,8 +227,7 @@ struct a2dp_audio_dev {
 static const a2dp_sbc_t sbc_presets[] = {
 	{
 		.frequency = SBC_SAMPLING_FREQ_44100 | SBC_SAMPLING_FREQ_48000,
-		.channel_mode = SBC_CHANNEL_MODE_MONO |
-				SBC_CHANNEL_MODE_DUAL_CHANNEL |
+		.channel_mode = SBC_CHANNEL_MODE_DUAL_CHANNEL |
 				SBC_CHANNEL_MODE_STEREO |
 				SBC_CHANNEL_MODE_JOINT_STEREO,
 		.subbands = SBC_SUBBANDS_4 | SBC_SUBBANDS_8,
-- 
1.8.5.3

