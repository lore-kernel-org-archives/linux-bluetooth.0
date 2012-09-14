Return-Path: <cyrus@holtmann.org>
From: Mikel Astiz <mikel.astiz.oss@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Mikel Astiz <mikel.astiz@bmw-carit.de>
Subject: [RFC v4 3/9] media: Add gateway_get_state() to internal API
Date: Fri, 14 Sep 2012 14:03:10 +0200
Message-Id: <1347624196-11281-4-git-send-email-mikel.astiz.oss@gmail.com>
In-Reply-To: <1347624196-11281-1-git-send-email-mikel.astiz.oss@gmail.com>
References: <1347624196-11281-1-git-send-email-mikel.astiz.oss@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Mikel Astiz <mikel.astiz@bmw-carit.de>

Expose the state of the gateway interface in the internal API.
---
 audio/gateway.c |    7 +++++++
 audio/gateway.h |    1 +
 2 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/audio/gateway.c b/audio/gateway.c
index 0603f12..53094af 100644
--- a/audio/gateway.c
+++ b/audio/gateway.c
@@ -787,6 +787,13 @@ gboolean gateway_is_active(struct audio_device *dev)
 	return FALSE;
 }
 
+gateway_state_t gateway_get_state(struct audio_device *dev)
+{
+	struct gateway *gw = dev->gateway;
+
+	return gw->state;
+}
+
 int gateway_connect_rfcomm(struct audio_device *dev, GIOChannel *io)
 {
 	if (!io)
diff --git a/audio/gateway.h b/audio/gateway.h
index 0893962..d87d76a 100644
--- a/audio/gateway.h
+++ b/audio/gateway.h
@@ -59,6 +59,7 @@ void gateway_unregister(struct audio_device *dev);
 struct gateway *gateway_init(struct audio_device *dev);
 gboolean gateway_is_active(struct audio_device *dev);
 gboolean gateway_is_connected(struct audio_device *dev);
+gateway_state_t gateway_get_state(struct audio_device *dev);
 int gateway_connect_rfcomm(struct audio_device *dev, GIOChannel *io);
 int gateway_connect_sco(struct audio_device *dev, GIOChannel *chan);
 void gateway_start_service(struct audio_device *device);
-- 
1.7.7.6

