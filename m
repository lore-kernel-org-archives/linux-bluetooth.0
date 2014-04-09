Return-Path: <cyrus@holtmann.org>
From: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
Subject: [PATCH 2/7] android/hal-audio: Remove preset with 48000 frequency
Date: Wed, 9 Apr 2014 16:16:53 +0200
Message-ID: <1397053018-4610-3-git-send-email-andrzej.kaczmarek@tieto.com>
In-Reply-To: <1397053018-4610-1-git-send-email-andrzej.kaczmarek@tieto.com>
References: <1397053018-4610-1-git-send-email-andrzej.kaczmarek@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Having two presets with all parameters identical except of frequency is
redundant since SNK has mandatory support for both 44100 and 48000 so
in case we're INT we'll always set 44100 as this is first one we try.
---
 android/hal-audio.c | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/android/hal-audio.c b/android/hal-audio.c
index 23eb6b8..2f28b13 100644
--- a/android/hal-audio.c
+++ b/android/hal-audio.c
@@ -265,15 +265,6 @@ static const a2dp_sbc_t sbc_presets[] = {
 		.min_bitpool = MIN_BITPOOL,
 		.max_bitpool = MAX_BITPOOL
 	},
-	{
-		.frequency = SBC_SAMPLING_FREQ_48000,
-		.channel_mode = SBC_CHANNEL_MODE_JOINT_STEREO,
-		.subbands = SBC_SUBBANDS_8,
-		.allocation_method = SBC_ALLOCATION_LOUDNESS,
-		.block_length = SBC_BLOCK_LENGTH_16,
-		.min_bitpool = MIN_BITPOOL,
-		.max_bitpool = MAX_BITPOOL
-	},
 };
 
 static int sbc_get_presets(struct audio_preset *preset, size_t *len)
-- 
1.9.1

