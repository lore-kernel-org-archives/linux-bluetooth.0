Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 9/9] audio: Remove src and dst from struct audio_device
Date: Wed, 5 Dec 2012 11:10:24 +0100
Message-ID: <1354702224-15895-10-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1354702224-15895-1-git-send-email-szymon.janc@tieto.com>
References: <1354702224-15895-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Those are not used anymore as addresses are takes from btd_device
reference.
---
 profiles/audio/device.c  |    6 +-----
 profiles/audio/device.h  |    7 +------
 profiles/audio/manager.c |    2 +-
 3 files changed, 3 insertions(+), 12 deletions(-)

diff --git a/profiles/audio/device.c b/profiles/audio/device.c
index ba1efec..d135ce9 100644
--- a/profiles/audio/device.c
+++ b/profiles/audio/device.c
@@ -292,9 +292,7 @@ static void device_avctp_cb(struct audio_device *dev,
 	}
 }
 
-struct audio_device *audio_device_register(struct btd_device *device,
-							const bdaddr_t *src,
-							const bdaddr_t *dst)
+struct audio_device *audio_device_register(struct btd_device *device)
 {
 	struct audio_device *dev;
 
@@ -303,8 +301,6 @@ struct audio_device *audio_device_register(struct btd_device *device,
 	dev = g_new0(struct audio_device, 1);
 
 	dev->btd_dev = btd_device_ref(device);
-	bacpy(&dev->dst, dst);
-	bacpy(&dev->src, src);
 	dev->priv = g_new0(struct dev_priv, 1);
 	dev->priv->state = AUDIO_STATE_DISCONNECTED;
 
diff --git a/profiles/audio/device.h b/profiles/audio/device.h
index 0801cda..e3dc519 100644
--- a/profiles/audio/device.h
+++ b/profiles/audio/device.h
@@ -36,9 +36,6 @@ typedef void (*audio_device_cb) (struct audio_device *dev, int err, void *data);
 struct audio_device {
 	struct btd_device *btd_dev;
 
-	bdaddr_t src;
-	bdaddr_t dst;
-
 	gboolean auto_connect;
 
 	struct sink *sink;
@@ -52,9 +49,7 @@ struct audio_device {
 	struct dev_priv *priv;
 };
 
-struct audio_device *audio_device_register(struct btd_device *device,
-							const bdaddr_t *src,
-							const bdaddr_t *dst);
+struct audio_device *audio_device_register(struct btd_device *device);
 
 void audio_device_unregister(struct audio_device *device);
 
diff --git a/profiles/audio/manager.c b/profiles/audio/manager.c
index 98ae694..0c21287 100644
--- a/profiles/audio/manager.c
+++ b/profiles/audio/manager.c
@@ -761,7 +761,7 @@ struct audio_device *manager_get_device(const bdaddr_t *src,
 		return NULL;
 	}
 
-	dev = audio_device_register(device, src, dst);
+	dev = audio_device_register(device);
 	if (!dev)
 		return NULL;
 
-- 
1.7.9.5

