Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFCV2 13/28] android/hal-sco: Make debug more readable
Date: Wed,  4 Jun 2014 17:17:44 +0300
Message-Id: <1401891479-11965-13-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1401891479-11965-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1401891479-11965-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

---
 android/hal-sco.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/android/hal-sco.c b/android/hal-sco.c
index 31c93b4..42267e0 100644
--- a/android/hal-sco.c
+++ b/android/hal-sco.c
@@ -654,8 +654,6 @@ static int sco_open_output_stream(struct audio_hw_device *dev,
 		return -ENOMEM;
 	}
 
-	DBG("size %zd", out_get_buffer_size(&out->stream.common));
-
 	/* Channel numbers for resampler */
 	chan_num = 1;
 
@@ -667,9 +665,6 @@ static int sco_open_output_stream(struct audio_hw_device *dev,
 		goto failed;
 	}
 
-	DBG("Created resampler: input rate [%d] output rate [%d] channels [%d]",
-				out->cfg.rate, AUDIO_STREAM_SCO_RATE, chan_num);
-
 	out->resample_frame_num = get_resample_frame_num(AUDIO_STREAM_SCO_RATE,
 							out->cfg.rate,
 							out->cfg.frame_num, 1);
@@ -688,8 +683,9 @@ static int sco_open_output_stream(struct audio_hw_device *dev,
 		goto failed;
 	}
 
-	DBG("resampler: frame num %u buf size %zd bytes",
-					out->resample_frame_num, resample_size);
+	DBG("Resampler: input %d output %d chan %d frames %u size %zd",
+				out->cfg.rate, AUDIO_STREAM_SCO_RATE, chan_num,
+				out->resample_frame_num, resample_size);
 
 	*stream_out = &out->stream;
 	adev->out = out;
-- 
1.8.3.2

