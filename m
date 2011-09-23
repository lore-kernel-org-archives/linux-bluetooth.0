Return-Path: <cyrus@holtmann.org>
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Dalleau?=
	<frederic.dalleau@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Dalleau?=
	<frederic.dalleau@linux.intel.com>
Subject: [PATCH 1/3] Check all states before allowing gw connection
Date: Fri, 23 Sep 2011 14:59:23 +0200
Message-Id: <1316782765-24147-1-git-send-email-frederic.dalleau@linux.intel.com>
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 audio/gateway.c |   10 ++++++++++
 audio/gateway.h |    1 +
 audio/manager.c |    2 +-
 3 files changed, 12 insertions(+), 1 deletions(-)

diff --git a/audio/gateway.c b/audio/gateway.c
index f3e6c6a..ca44576 100644
--- a/audio/gateway.c
+++ b/audio/gateway.c
@@ -764,6 +764,16 @@ gboolean gateway_is_connected(struct audio_device *dev)
 			dev->gateway->state == GATEWAY_STATE_CONNECTED);
 }
 
+gboolean gateway_is_active(struct audio_device *dev)
+{
+	struct gateway *gw = dev->gateway;
+
+	if (gw->state != GATEWAY_STATE_DISCONNECTED)
+		return TRUE;
+
+	return FALSE;
+}
+
 int gateway_connect_rfcomm(struct audio_device *dev, GIOChannel *io)
 {
 	if (!io)
diff --git a/audio/gateway.h b/audio/gateway.h
index a8ed2f2..77f5787 100644
--- a/audio/gateway.h
+++ b/audio/gateway.h
@@ -57,6 +57,7 @@ typedef void (*gateway_stream_cb_t) (struct audio_device *dev, GError *err,
 void gateway_set_state(struct audio_device *dev, gateway_state_t new_state);
 void gateway_unregister(struct audio_device *dev);
 struct gateway *gateway_init(struct audio_device *device);
+gboolean gateway_is_active(struct audio_device *dev);
 gboolean gateway_is_connected(struct audio_device *dev);
 int gateway_connect_rfcomm(struct audio_device *dev, GIOChannel *io);
 int gateway_connect_sco(struct audio_device *dev, GIOChannel *chan);
diff --git a/audio/manager.c b/audio/manager.c
index 053562e..06d3f0e 100644
--- a/audio/manager.c
+++ b/audio/manager.c
@@ -594,7 +594,7 @@ static void hf_io_cb(GIOChannel *chan, gpointer data)
 			goto drop;
 	}
 
-	if (gateway_is_connected(device)) {
+	if (gateway_is_active(device)) {
 		DBG("Refusing new connection since one already exists");
 		goto drop;
 	}
-- 
1.7.4.1

