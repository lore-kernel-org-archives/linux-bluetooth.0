Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 08/13] android/handsfree: Move clip into device structure
Date: Wed,  8 Oct 2014 09:12:18 +0200
Message-Id: <1412752343-7001-8-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1412752343-7001-1-git-send-email-szymon.janc@tieto.com>
References: <1412752343-7001-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/handsfree.c | 36 ++++++++++++++++++++++++------------
 1 file changed, 24 insertions(+), 12 deletions(-)

diff --git a/android/handsfree.c b/android/handsfree.c
index d83f0a2..e7b8a6e 100644
--- a/android/handsfree.c
+++ b/android/handsfree.c
@@ -131,6 +131,7 @@ struct hf_device {
 	struct hfp_codec codecs[CODECS_COUNT];
 
 	guint ring;
+	char *clip;
 	bool hsp;
 
 	struct hfp_gw *gw;
@@ -255,6 +256,11 @@ static void device_cleanup(struct hf_device *dev)
 	if (dev->ring) {
 		g_source_remove(dev->ring);
 		dev->ring = 0;
+
+		if (dev->clip) {
+			g_free(dev->clip);
+			dev->clip = NULL;
+		}
 	}
 
 	set_audio_state(dev, HAL_EV_HANDSFREE_AUDIO_STATE_DISCONNECTED);
@@ -2018,12 +2024,12 @@ done:
 
 static gboolean ring_cb(gpointer user_data)
 {
-	char *clip = user_data;
+	struct hf_device *dev = user_data;
 
-	hfp_gw_send_info(device.gw, "RING");
+	hfp_gw_send_info(dev->gw, "RING");
 
-	if (device.clip_enabled && clip)
-		hfp_gw_send_info(device.gw, "%s", clip);
+	if (dev->clip_enabled && dev->clip)
+		hfp_gw_send_info(dev->gw, "%s", dev->clip);
 
 	return TRUE;
 }
@@ -2065,7 +2071,7 @@ static void phone_state_waiting(int num_active, int num_held, uint8_t type,
 static void phone_state_incoming(int num_active, int num_held, uint8_t type,
 					const uint8_t *number, int number_len)
 {
-	char *clip, *num;
+	char *num;
 
 	if (device.setup_state == HAL_HANDSFREE_CALL_STATE_INCOMING) {
 		if (device.num_active != num_active ||
@@ -2096,19 +2102,20 @@ static void phone_state_incoming(int num_active, int num_held, uint8_t type,
 	num = number_len ? (char *) number : "";
 
 	if (type == HAL_HANDSFREE_CALL_ADDRTYPE_INTERNATIONAL && num[0] != '+')
-		clip = g_strdup_printf("+CLIP: \"+%s\",%u", num, type);
+		device.clip = g_strdup_printf("+CLIP: \"+%s\",%u", num, type);
 	else
-		clip = g_strdup_printf("+CLIP: \"%s\",%u", num, type);
+		device.clip = g_strdup_printf("+CLIP: \"%s\",%u", num, type);
 
 	/* send first RING */
-	ring_cb(clip);
+	ring_cb(&device);
 
 	device.ring = g_timeout_add_seconds_full(G_PRIORITY_DEFAULT,
 							RING_TIMEOUT, ring_cb,
-							clip, g_free);
-
-	if (!device.ring)
-		g_free(clip);
+							&device, NULL);
+	if (!device.ring) {
+		g_free(device.clip);
+		device.clip = NULL;
+	}
 }
 
 static void phone_state_idle(int num_active, int num_held)
@@ -2116,6 +2123,11 @@ static void phone_state_idle(int num_active, int num_held)
 	if (device.ring) {
 		g_source_remove(device.ring);
 		device.ring = 0;
+
+		if (device.clip) {
+			g_free(device.clip);
+			device.clip = NULL;
+		}
 	}
 
 	switch (device.setup_state) {
-- 
1.9.1

