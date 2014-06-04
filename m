Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFCV2 22/28] android/haltest: Add mono to stereo conversion for loopback
Date: Wed,  4 Jun 2014 17:17:53 +0300
Message-Id: <1401891479-11965-22-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1401891479-11965-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1401891479-11965-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

---
 android/client/if-sco.c | 28 +++++++++++++++++++++++++++-
 1 file changed, 27 insertions(+), 1 deletion(-)

diff --git a/android/client/if-sco.c b/android/client/if-sco.c
index 35ed3b0..b7377f4 100644
--- a/android/client/if-sco.c
+++ b/android/client/if-sco.c
@@ -174,10 +174,24 @@ static void prepare_sample(void)
 	sample_pos = 0;
 }
 
+static void mono_to_stereo_pcm16(const int16_t *in, int16_t *out, size_t samples)
+{
+	int16_t mono;
+	size_t i;
+
+	for (i = 0; i < samples; i++) {
+		mono = get_unaligned(&in[i]);
+
+		put_unaligned(mono, &out[2 * i]);
+		put_unaligned(mono, &out[2 * i + 1]);
+	}
+}
+
 static void *playback_thread(void *data)
 {
 	int (*filbuff_cb) (short*, void*);
 	short buffer[buffer_size / sizeof(short)];
+	short buffer_in[buffer_size_in / sizeof(short)];
 	size_t len = 0;
 	ssize_t w_len = 0;
 	FILE *in = data;
@@ -217,7 +231,19 @@ static void *playback_thread(void *data)
 
 		pthread_mutex_unlock(&state_mutex);
 
-		len = filbuff_cb(buffer, cb_data);
+		if (data == stream_in) {
+			int chan_in = popcount(stream_in->common.get_channels(&stream_in->common));
+			int chan_out = popcount(stream_out->common.get_channels(&stream_out->common));
+
+			len = filbuff_cb(buffer_in, cb_data);
+
+			if (chan_in == 1 && chan_out == 2) {
+				mono_to_stereo_pcm16(buffer_in,
+							buffer,
+							buffer_size_in / 2);
+			}
+		} else
+			len = filbuff_cb(buffer, cb_data);
 
 		pthread_mutex_lock(&outstream_mutex);
 		if (!stream_out) {
-- 
1.8.3.2

