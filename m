Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFC 2/2] android/hal-audio: Make code readable
Date: Mon, 31 Mar 2014 14:44:20 +0300
Message-Id: <1396266260-31712-2-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1396266260-31712-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1396266260-31712-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

---
 android/hal-audio.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/android/hal-audio.c b/android/hal-audio.c
index 00dde49..c145533 100644
--- a/android/hal-audio.c
+++ b/android/hal-audio.c
@@ -1732,12 +1732,12 @@ static struct hw_module_methods_t hal_module_methods = {
 
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

