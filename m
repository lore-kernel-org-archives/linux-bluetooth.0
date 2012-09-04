Return-Path: <cyrus@holtmann.org>
From: Mikel Astiz <mikel.astiz.oss@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Mikel Astiz <mikel.astiz@bmw-carit.de>
Subject: [PATCH v0 1/3] audio: Remove unused function
Date: Tue,  4 Sep 2012 13:15:54 +0200
Message-Id: <1346757356-20341-1-git-send-email-mikel.astiz.oss@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Mikel Astiz <mikel.astiz@bmw-carit.de>

gateway_config_stream() is now unnecessary after the removal of the unix
socket support in commit 1d9d0527cfb6d96a976ede56bd43a2bc16bb5f21.
---
 audio/gateway.c |   16 ----------------
 audio/gateway.h |    2 --
 2 files changed, 0 insertions(+), 18 deletions(-)

diff --git a/audio/gateway.c b/audio/gateway.c
index c0159a4..77a8cb0 100644
--- a/audio/gateway.c
+++ b/audio/gateway.c
@@ -858,22 +858,6 @@ unsigned int gateway_request_stream(struct audio_device *dev,
 	return connect_cb_new(gw, cb, user_data);
 }
 
-int gateway_config_stream(struct audio_device *dev, gateway_stream_cb_t cb,
-				void *user_data)
-{
-	struct gateway *gw = dev->gateway;
-	unsigned int id;
-
-	id = connect_cb_new(gw, cb, user_data);
-
-	if (!gw->rfcomm)
-		get_records(dev);
-	else if (cb)
-		g_idle_add(request_stream_cb, dev);
-
-	return id;
-}
-
 gboolean gateway_cancel_stream(struct audio_device *dev, unsigned int id)
 {
 	struct gateway *gw = dev->gateway;
diff --git a/audio/gateway.h b/audio/gateway.h
index 6fde445..0893962 100644
--- a/audio/gateway.h
+++ b/audio/gateway.h
@@ -64,8 +64,6 @@ int gateway_connect_sco(struct audio_device *dev, GIOChannel *chan);
 void gateway_start_service(struct audio_device *device);
 unsigned int gateway_request_stream(struct audio_device *dev,
 			gateway_stream_cb_t cb, void *user_data);
-int gateway_config_stream(struct audio_device *dev, gateway_stream_cb_t cb,
-			void *user_data);
 gboolean gateway_cancel_stream(struct audio_device *dev, unsigned int id);
 int gateway_get_sco_fd(struct audio_device *dev);
 void gateway_suspend_stream(struct audio_device *dev);
-- 
1.7.7.6

