Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 1/8] audio: Move btd_device unref after last use in device_free
Date: Tue, 16 Oct 2012 12:12:52 +0200
Message-ID: <1350382379-30489-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

btd_device should not be used after local reference was dropped.

---
 audio/device.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/audio/device.c b/audio/device.c
index 175e3c0..be63031 100644
--- a/audio/device.c
+++ b/audio/device.c
@@ -98,8 +98,6 @@ static void device_free(struct audio_device *dev)
 {
 	struct dev_priv *priv = dev->priv;
 
-	btd_device_unref(dev->btd_dev);
-
 	if (priv) {
 		if (priv->control_timer)
 			g_source_remove(priv->control_timer);
@@ -117,6 +115,8 @@ static void device_free(struct audio_device *dev)
 		g_free(priv);
 	}
 
+	btd_device_unref(dev->btd_dev);
+
 	g_free(dev->path);
 	g_free(dev);
 }
-- 
1.7.9.5

