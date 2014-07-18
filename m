Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv2 08/21] android/hal-sco: Make debug more readable
Date: Fri, 18 Jul 2014 12:48:07 +0300
Message-Id: <1405676900-17703-9-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1405676900-17703-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1405676900-17703-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

---
 android/hal-sco.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/android/hal-sco.c b/android/hal-sco.c
index 09fcf5b..e084c31 100644
--- a/android/hal-sco.c
+++ b/android/hal-sco.c
@@ -656,8 +656,6 @@ static int sco_open_output_stream(struct audio_hw_device *dev,
 		return -ENOMEM;
 	}
 
-	DBG("size %zd", out_get_buffer_size(&out->stream.common));
-
 	/* Channel numbers for resampler */
 	chan_num = 1;
 
@@ -669,9 +667,6 @@ static int sco_open_output_stream(struct audio_hw_device *dev,
 		goto failed;
 	}
 
-	DBG("Created resampler: input rate [%d] output rate [%d] channels [%d]",
-				out->cfg.rate, AUDIO_STREAM_SCO_RATE, chan_num);
-
 	out->resample_frame_num = get_resample_frame_num(AUDIO_STREAM_SCO_RATE,
 							out->cfg.rate,
 							out->cfg.frame_num, 1);
@@ -690,8 +685,9 @@ static int sco_open_output_stream(struct audio_hw_device *dev,
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
1.9.1

