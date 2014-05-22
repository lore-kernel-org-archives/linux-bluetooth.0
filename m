Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFCv0 12/14] android/hal-sco: Fix memory leak
Date: Thu, 22 May 2014 15:06:05 +0300
Message-Id: <1400760367-24915-12-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1400760367-24915-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1400760367-24915-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Release resampler on exit.
---
 android/hal-sco.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/android/hal-sco.c b/android/hal-sco.c
index 8635866..bf3b6d4 100644
--- a/android/hal-sco.c
+++ b/android/hal-sco.c
@@ -692,6 +692,8 @@ static int sco_open_output_stream(struct audio_hw_device *dev,
 
 	return 0;
 failed:
+	if (out->resampler)
+		release_resampler(out->resampler);
 	free(out->cache);
 	free(out->downmix_buf);
 	free(out);
@@ -726,6 +728,9 @@ static void sco_close_output_stream(struct audio_hw_device *dev,
 
 	close_sco_socket();
 
+	if (out->resampler)
+		release_resampler(out->resampler);
+	free(out->resample_buf);
 	free(out->cache);
 	free(out->downmix_buf);
 	free(out);
-- 
1.8.3.2

