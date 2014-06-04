Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFCV2 04/28] android/hal-sco: Fixes for unreliable mtu
Date: Wed,  4 Jun 2014 17:17:35 +0300
Message-Id: <1401891479-11965-4-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1401891479-11965-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1401891479-11965-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

---
 android/hal-sco.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/android/hal-sco.c b/android/hal-sco.c
index 701d15e..ecf7a09 100644
--- a/android/hal-sco.c
+++ b/android/hal-sco.c
@@ -300,7 +300,7 @@ static bool write_data(struct sco_stream_out *out, const uint8_t *buffer,
 	struct pollfd pfd;
 	size_t len, written = 0;
 	int ret;
-	uint16_t mtu = /* out->cfg.mtu */ 48;
+	uint16_t mtu = out->cfg.mtu;
 	uint64_t audio_sent_us, audio_passed_us;
 
 	pfd.fd = out->fd;
@@ -594,7 +594,9 @@ static int sco_open_output_stream(struct audio_hw_device *dev,
 	out->cfg.channels = AUDIO_CHANNEL_OUT_STEREO;
 	out->cfg.rate = AUDIO_STREAM_DEFAULT_RATE;
 	out->cfg.frame_num = OUT_STREAM_FRAMES;
-	out->cfg.mtu = mtu;
+
+	/* we get wrong mtu size for some reason */
+	out->cfg.mtu = /* mtu */ 48;
 
 	out->downmix_buf = malloc(out_get_buffer_size(&out->stream.common));
 	if (!out->downmix_buf) {
-- 
1.8.3.2

