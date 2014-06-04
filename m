Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFCV2 14/28] android/hal-sco: Fix memory leak
Date: Wed,  4 Jun 2014 17:17:45 +0300
Message-Id: <1401891479-11965-14-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1401891479-11965-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1401891479-11965-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Release resampler on exit.
---
 android/hal-sco.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/android/hal-sco.c b/android/hal-sco.c
index 42267e0..943a541 100644
--- a/android/hal-sco.c
+++ b/android/hal-sco.c
@@ -729,8 +729,10 @@ static void sco_close_output_stream(struct audio_hw_device *dev,
 
 	close_sco_socket();
 
-	if (out->resampler)
+	if (out->resampler) {
 		release_resampler(out->resampler);
+		free(out->resample_buf);
+	}
 
 	free(out->cache);
 	free(out->downmix_buf);
-- 
1.8.3.2

