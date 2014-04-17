Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 3/7] android/hal-audio: Make code readable
Date: Thu, 17 Apr 2014 15:23:47 +0300
Message-Id: <1397737431-6101-3-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1397737431-6101-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1397737431-6101-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

---
 android/hal-audio.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/android/hal-audio.c b/android/hal-audio.c
index c4bd4fe..76d1efb 100644
--- a/android/hal-audio.c
+++ b/android/hal-audio.c
@@ -1876,12 +1876,12 @@ static struct hw_module_methods_t hal_module_methods = {
 
 struct audio_module HAL_MODULE_INFO_SYM = {
 	.common = {
-	.tag = HARDWARE_MODULE_TAG,
-	.version_major = 1,
-	.version_minor = 0,
-	.id = AUDIO_HARDWARE_MODULE_ID,
-	.name = "A2DP Bluez HW HAL",
-	.author = "Intel Corporation",
-	.methods = &hal_module_methods,
+		.tag = HARDWARE_MODULE_TAG,
+		.version_major = 1,
+		.version_minor = 0,
+		.id = AUDIO_HARDWARE_MODULE_ID,
+		.name = "A2DP Bluez HW HAL",
+		.author = "Intel Corporation",
+		.methods = &hal_module_methods,
 	},
 };
-- 
1.8.3.2

