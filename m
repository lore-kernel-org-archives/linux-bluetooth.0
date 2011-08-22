Return-Path: <cyrus@holtmann.org>
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Dalleau?=
	<frederic.dalleau@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Dalleau?=
	<frederic.dalleau@linux.intel.com>
Subject: [PATCH v2 8/9] Introduce gateway locking mechanism
Date: Mon, 22 Aug 2011 17:30:46 +0200
Message-Id: <1314027047-5476-9-git-send-email-frederic.dalleau@linux.intel.com>
In-Reply-To: <1314027047-5476-1-git-send-email-frederic.dalleau@linux.intel.com>
References: <1314027047-5476-1-git-send-email-frederic.dalleau@linux.intel.com>
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 audio/gateway.c |   38 ++++++++++++++++++++++++++++++++++++++
 audio/gateway.h |    8 ++++++++
 2 files changed, 46 insertions(+), 0 deletions(-)

diff --git a/audio/gateway.c b/audio/gateway.c
index d41bbc3..e1db84b 100644
--- a/audio/gateway.c
+++ b/audio/gateway.c
@@ -70,6 +70,7 @@ struct gateway {
 	struct hf_agent *agent;
 	DBusMessage *msg;
 	int version;
+	gateway_lock_t lock;
 };
 
 struct gateway_state_callback {
@@ -875,3 +876,40 @@ gboolean gateway_remove_state_cb(unsigned int id)
 
 	return FALSE;
 }
+
+gateway_lock_t gateway_get_lock(struct audio_device *dev)
+{
+	struct gateway *gw = dev->gateway;
+
+	return gw->lock;
+}
+
+gboolean gateway_lock(struct audio_device *dev, gateway_lock_t lock)
+{
+	struct gateway *gw = dev->gateway;
+
+	if (gw->lock & lock)
+		return FALSE;
+
+	gw->lock |= lock;
+
+	return TRUE;
+}
+
+gboolean gateway_unlock(struct audio_device *dev, gateway_lock_t lock)
+{
+	struct gateway *gw = dev->gateway;
+
+	if (!(gw->lock & lock))
+		return FALSE;
+
+	gw->lock &= ~lock;
+
+	if (gw->lock)
+		return TRUE;
+
+	if (gw->state == GATEWAY_STATE_PLAYING)
+		gateway_suspend_stream(dev);
+
+	return TRUE;
+}
diff --git a/audio/gateway.h b/audio/gateway.h
index 32b5d6d..2dca32a 100644
--- a/audio/gateway.h
+++ b/audio/gateway.h
@@ -33,6 +33,11 @@ typedef enum {
 	GATEWAY_STATE_PLAYING,
 } gateway_state_t;
 
+typedef enum {
+	GATEWAY_LOCK_READ = 1,
+	GATEWAY_LOCK_WRITE = 1 << 1,
+} gateway_lock_t;
+
 typedef void (*gateway_state_cb) (struct audio_device *dev,
 					gateway_state_t old_state,
 					gateway_state_t new_state,
@@ -56,3 +61,6 @@ int gateway_get_sco_fd(struct audio_device *dev);
 void gateway_suspend_stream(struct audio_device *dev);
 unsigned int gateway_add_state_cb(gateway_state_cb cb, void *user_data);
 gboolean gateway_remove_state_cb(unsigned int id);
+gateway_lock_t gateway_get_lock(struct audio_device *dev);
+gboolean gateway_lock(struct audio_device *dev, gateway_lock_t lock);
+gboolean gateway_unlock(struct audio_device *dev, gateway_lock_t lock);
-- 
1.7.1

