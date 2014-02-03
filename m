Return-Path: <cyrus@holtmann.org>
From: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
Subject: [PATCH 3/6] android/hal-audio: Print calculated SBC parameters
Date: Mon, 3 Feb 2014 16:44:49 +0100
Message-ID: <1391442292-4668-3-git-send-email-andrzej.kaczmarek@tieto.com>
In-Reply-To: <1391442292-4668-1-git-send-email-andrzej.kaczmarek@tieto.com>
References: <1391442292-4668-1-git-send-email-andrzej.kaczmarek@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/hal-audio.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/android/hal-audio.c b/android/hal-audio.c
index bccaf15..cda1359 100644
--- a/android/hal-audio.c
+++ b/android/hal-audio.c
@@ -332,6 +332,9 @@ static int sbc_codec_init(struct audio_preset *preset, uint16_t mtu,
 	sbc_data->frame_duration = sbc_get_frame_duration(&sbc_data->enc);
 	sbc_data->frames_per_packet = num_frames;
 
+	DBG("mtu=%u in_frame_len=%zu out_frame_len=%zu frames_per_packet=%zu",
+			mtu, in_frame_len, out_frame_len, num_frames);
+
 	*codec_data = sbc_data;
 
 	return AUDIO_STATUS_SUCCESS;
-- 
1.8.5.3

