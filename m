Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFCV2 19/28] android/hal-sco: Skip resampling for output stream with 8k
Date: Wed,  4 Jun 2014 17:17:50 +0300
Message-Id: <1401891479-11965-19-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1401891479-11965-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1401891479-11965-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

---
 android/hal-sco.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/android/hal-sco.c b/android/hal-sco.c
index 06e0261..e3d5242 100644
--- a/android/hal-sco.c
+++ b/android/hal-sco.c
@@ -659,6 +659,9 @@ static int sco_open_output_stream(struct audio_hw_device *dev,
 		return -ENOMEM;
 	}
 
+	if (out->cfg.rate == AUDIO_STREAM_SCO_RATE)
+		goto skip_resampler;
+
 	/* Channel numbers for resampler */
 	chan_num = 1;
 
@@ -691,7 +694,7 @@ static int sco_open_output_stream(struct audio_hw_device *dev,
 	DBG("Resampler: input %d output %d chan %d frames %u size %zd",
 				out->cfg.rate, AUDIO_STREAM_SCO_RATE, chan_num,
 				out->resample_frame_num, resample_size);
-
+skip_resampler:
 	*stream_out = &out->stream;
 	adev->out = out;
 
-- 
1.8.3.2

