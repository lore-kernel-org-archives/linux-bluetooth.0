Return-Path: <cyrus@holtmann.org>
From: gowtham babu <gowtham.ab@samsung.com>
To: linux-bluetooth@vger.kernel.org
Cc: bharat.panda@samsung.com, p.sinha@samsung.com,
	gowtham babu <gowtham.ab@samsung.com>
Subject: [PATCH 3/3] android/audio_utils/resampler : Fix the null pointer
 dereference.
Date: Fri, 05 Sep 2014 19:42:45 +0530
Message-id: <1409926365-6436-1-git-send-email-gowtham.ab@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Checks for NULL.
---
 android/audio_utils/resampler.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/android/audio_utils/resampler.c b/android/audio_utils/resampler.c
index ce30375..f845e2c 100644
--- a/android/audio_utils/resampler.c
+++ b/android/audio_utils/resampler.c
@@ -50,8 +50,10 @@ static void resampler_reset(struct resampler_itfe *resampler)
 {
     struct resampler *rsmp = (struct resampler *)resampler;
 
-    rsmp->frames_in = 0;
-    rsmp->frames_rq = 0;
+    if(rsmp != NULL) {
+	rsmp->frames_in = 0;
+	rsmp->frames_rq = 0;
+    }
 
     if (rsmp != NULL && rsmp->speex_resampler != NULL) {
         speex_resampler_reset_mem(rsmp->speex_resampler);
-- 
1.9.1

