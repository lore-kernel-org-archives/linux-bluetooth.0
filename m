Return-Path: <cyrus@holtmann.org>
From: Radoslaw Jablonski <ext-jablonski.radoslaw@nokia.com>
To: linux-bluetooth@vger.kernel.org
Cc: Radoslaw Jablonski <ext-jablonski.radoslaw@nokia.com>
Subject: [PATCH 2/4] Remove unnecessary disconnect callback from headset.c
Date: Wed, 22 Sep 2010 16:35:19 +0300
Message-Id: <1285162521-21997-2-git-send-email-ext-jablonski.radoslaw@nokia.com>
In-Reply-To: <1285162521-21997-1-git-send-email-ext-jablonski.radoslaw@nokia.com>
References: <1285162521-21997-1-git-send-email-ext-jablonski.radoslaw@nokia.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Headsets for proper disconnecting need to disconnect profiles in specified
order(by ex. disconnect a2dp, then sink and hfp at the end). Instead of
adding separate callbacks for disconnecting each profile, now adding only
one callback in audio/device.c for calling audio disconnect functions in
correct order.
---
 audio/headset.c |   19 -------------------
 1 files changed, 0 insertions(+), 19 deletions(-)

diff --git a/audio/headset.c b/audio/headset.c
index dad0716..9955d4b 100644
--- a/audio/headset.c
+++ b/audio/headset.c
@@ -158,7 +158,6 @@ struct headset {
 	GIOChannel *tmp_rfcomm;
 	GIOChannel *sco;
 	guint sco_id;
-	guint dc_id;
 
 	gboolean auto_dc;
 
@@ -2162,9 +2161,6 @@ static void headset_free(struct audio_device *dev)
 		hs->dc_timer = 0;
 	}
 
-	if (hs->dc_id)
-		device_remove_disconnect_watch(dev->btd_dev, hs->dc_id);
-
 	close_sco(dev);
 
 	headset_close_rfcomm(dev);
@@ -2477,16 +2473,6 @@ int headset_connect_sco(struct audio_device *dev, GIOChannel *io)
 	return 0;
 }
 
-static void disconnect_cb(struct btd_device *btd_dev, gboolean removal,
-				void *user_data)
-{
-	struct audio_device *device = user_data;
-
-	info("Headset: disconnect %s", device->path);
-
-	headset_shutdown(device);
-}
-
 void headset_set_state(struct audio_device *dev, headset_state_t state)
 {
 	struct headset *hs = dev->headset;
@@ -2520,8 +2506,6 @@ void headset_set_state(struct audio_device *dev, headset_state_t state)
 			telephony_device_disconnected(dev);
 		}
 		active_devices = g_slist_remove(active_devices, dev);
-		device_remove_disconnect_watch(dev->btd_dev, hs->dc_id);
-		hs->dc_id = 0;
 		break;
 	case HEADSET_STATE_CONNECTING:
 		emit_property_changed(dev->conn, dev->path,
@@ -2550,9 +2534,6 @@ void headset_set_state(struct audio_device *dev, headset_state_t state)
 						DBUS_TYPE_BOOLEAN, &value);
 			active_devices = g_slist_append(active_devices, dev);
 			telephony_device_connected(dev);
-			hs->dc_id = device_add_disconnect_watch(dev->btd_dev,
-								disconnect_cb,
-								dev, NULL);
 		} else if (hs->state == HEADSET_STATE_PLAYING) {
 			value = FALSE;
 			g_dbus_emit_signal(dev->conn, dev->path,
-- 
1.7.0.4

