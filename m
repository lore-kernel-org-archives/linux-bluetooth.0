Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv1 11/23] android/hal-sco: Skip resampling for output stream with 8k
Date: Thu, 17 Jul 2014 11:54:11 +0300
Message-Id: <1405587263-19867-12-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1405587263-19867-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1405587263-19867-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

---
 android/hal-sco.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/android/hal-sco.c b/android/hal-sco.c
index ed90b23..f316340 100644
--- a/android/hal-sco.c
+++ b/android/hal-sco.c
@@ -661,6 +661,9 @@ static int sco_open_output_stream(struct audio_hw_device *dev,
 		return -ENOMEM;
 	}
 
+	if (out->cfg.rate == AUDIO_STREAM_SCO_RATE)
+		goto skip_resampler;
+
 	/* Channel numbers for resampler */
 	chan_num = 1;
 
@@ -693,7 +696,7 @@ static int sco_open_output_stream(struct audio_hw_device *dev,
 	DBG("Resampler: input %d output %d chan %d frames %u size %zd",
 				out->cfg.rate, AUDIO_STREAM_SCO_RATE, chan_num,
 				out->resample_frame_num, resample_size);
-
+skip_resampler:
 	*stream_out = &out->stream;
 	adev->out = out;
 
-- 
1.9.1

