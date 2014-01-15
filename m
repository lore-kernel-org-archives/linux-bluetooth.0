Return-Path: <cyrus@holtmann.org>
From: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
Subject: [PATCH v2 09/11] android/hal-audio: Fix module loading
Date: Wed, 15 Jan 2014 19:03:55 +0100
Message-ID: <1389809037-11575-10-git-send-email-andrzej.kaczmarek@tieto.com>
In-Reply-To: <1389809037-11575-1-git-send-email-andrzej.kaczmarek@tieto.com>
References: <1389809037-11575-1-git-send-email-andrzej.kaczmarek@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/hal-audio.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/android/hal-audio.c b/android/hal-audio.c
index 946531f..3c2dcb2 100644
--- a/android/hal-audio.c
+++ b/android/hal-audio.c
@@ -957,7 +957,7 @@ static char *audio_get_parameters(const struct audio_hw_device *dev,
 static int audio_init_check(const struct audio_hw_device *dev)
 {
 	DBG("");
-	return -ENOSYS;
+	return 0;
 }
 
 static int audio_set_voice_volume(struct audio_hw_device *dev, float volume)
@@ -1194,6 +1194,7 @@ static int audio_open(const hw_module_t *module, const char *name,
 	if (!a2dp_dev)
 		return -ENOMEM;
 
+	a2dp_dev->dev.common.tag = HARDWARE_DEVICE_TAG;
 	a2dp_dev->dev.common.version = AUDIO_DEVICE_API_VERSION_CURRENT;
 	a2dp_dev->dev.common.module = (struct hw_module_t *) module;
 	a2dp_dev->dev.common.close = audio_close;
-- 
1.8.5.2

