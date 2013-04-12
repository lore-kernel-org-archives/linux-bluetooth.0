Return-Path: <cyrus@holtmann.org>
From: jprvita@gmail.com
To: linux-bluetooth@vger.kernel.org
Cc: =?UTF-8?q?Jo=C3=A3o=20Paulo=20Rechi=20Vita?= <jprvita@gmail.com>
Subject: [PATCH BlueZ 2/3] audio: Remove unused function
Date: Fri, 12 Apr 2013 19:34:23 -0300
Message-Id: <1365806064-12052-2-git-send-email-jprvita@gmail.com>
In-Reply-To: <1365806064-12052-1-git-send-email-jprvita@gmail.com>
References: <1365806064-12052-1-git-send-email-jprvita@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: João Paulo Rechi Vita <jprvita@gmail.com>

Removes the never used function audio_device_is_active.
---
 profiles/audio/device.c | 19 -------------------
 profiles/audio/device.h |  3 ---
 2 files changed, 22 deletions(-)

diff --git a/profiles/audio/device.c b/profiles/audio/device.c
index b9d1dde..7a76284 100644
--- a/profiles/audio/device.c
+++ b/profiles/audio/device.c
@@ -316,25 +316,6 @@ struct audio_device *audio_device_register(struct btd_device *device)
 	return dev;
 }
 
-gboolean audio_device_is_active(struct audio_device *dev,
-						const char *interface)
-{
-	if (!interface) {
-		if ((dev->sink || dev->source) && avdtp_is_connected(dev))
-			return TRUE;
-	} else if (!strcmp(interface, AUDIO_SINK_INTERFACE) && dev->sink &&
-				avdtp_is_connected(dev))
-		return TRUE;
-	else if (!strcmp(interface, AUDIO_SOURCE_INTERFACE) && dev->source &&
-				avdtp_is_connected(dev))
-		return TRUE;
-	else if (!strcmp(interface, AUDIO_CONTROL_INTERFACE) && dev->control &&
-				control_is_active(dev))
-		return TRUE;
-
-	return FALSE;
-}
-
 void audio_device_unregister(struct audio_device *device)
 {
 	DBG("%s", device_get_path(device->btd_dev));
diff --git a/profiles/audio/device.h b/profiles/audio/device.h
index ad4dae5..b772594 100644
--- a/profiles/audio/device.h
+++ b/profiles/audio/device.h
@@ -43,6 +43,3 @@ struct audio_device {
 struct audio_device *audio_device_register(struct btd_device *device);
 
 void audio_device_unregister(struct audio_device *device);
-
-gboolean audio_device_is_active(struct audio_device *dev,
-						const char *interface);
-- 
1.7.11.7

