Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv2 09/21] android/hal-sco: Fix memory leak
Date: Fri, 18 Jul 2014 12:48:08 +0300
Message-Id: <1405676900-17703-10-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1405676900-17703-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1405676900-17703-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

Release resampler on exit.
---
 android/hal-sco.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/android/hal-sco.c b/android/hal-sco.c
index e084c31..a3fb710 100644
--- a/android/hal-sco.c
+++ b/android/hal-sco.c
@@ -731,8 +731,10 @@ static void sco_close_output_stream(struct audio_hw_device *dev,
 
 	close_sco_socket();
 
-	if (out->resampler)
+	if (out->resampler) {
 		release_resampler(out->resampler);
+		free(out->resample_buf);
+	}
 
 	free(out->cache);
 	free(out->downmix_buf);
-- 
1.9.1

