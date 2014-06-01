Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ] android/hal-audio-sbc: Fix use of incorrect number of frames per packet
Date: Sun,  1 Jun 2014 18:26:04 +0300
Message-Id: <1401636364-10858-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Number of frames should always be limited to the maximun that can be set
in the payload header.
---
 android/hal-audio-sbc.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/android/hal-audio-sbc.c b/android/hal-audio-sbc.c
index ad20f51..0c31035 100644
--- a/android/hal-audio-sbc.c
+++ b/android/hal-audio-sbc.c
@@ -241,6 +241,9 @@ static void sbc_codec_calculate(struct sbc_data *sbc_data)
 	out_frame_len = sbc_get_frame_length(&sbc_data->enc);
 	num_frames = sbc_data->payload_len / out_frame_len;
 
+	if (num_frames > MAX_FRAMES_IN_PAYLOAD)
+		num_frames = MAX_FRAMES_IN_PAYLOAD;
+
 	sbc_data->in_frame_len = in_frame_len;
 	sbc_data->in_buf_size = num_frames * in_frame_len;
 
@@ -346,7 +349,7 @@ static ssize_t sbc_encode_mediapacket(void *codec_data, const uint8_t *buffer,
 
 	while (len - consumed >= sbc_data->in_frame_len &&
 			mp_data_len - encoded >= sbc_data->out_frame_len &&
-			frame_count < MAX_FRAMES_IN_PAYLOAD) {
+			frame_count < sbc_data->frames_per_packet) {
 		ssize_t read;
 		ssize_t written = 0;
 
-- 
1.9.0

