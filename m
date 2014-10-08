Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH v2 09/12] android/handsfree: Pass device object to disconnect watch
Date: Wed,  8 Oct 2014 12:15:11 +0200
Message-Id: <1412763314-12871-9-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1412763314-12871-1-git-send-email-szymon.janc@tieto.com>
References: <1412763314-12871-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/handsfree.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/android/handsfree.c b/android/handsfree.c
index fadbdce..4a55559 100644
--- a/android/handsfree.c
+++ b/android/handsfree.c
@@ -267,9 +267,11 @@ static void device_cleanup(struct hf_device *dev)
 
 static void disconnect_watch(void *user_data)
 {
+	struct hf_device *dev = user_data;
+
 	DBG("");
 
-	device_cleanup(&device);
+	device_cleanup(dev);
 }
 
 static void at_cmd_unknown(const char *command, void *user_data)
@@ -1375,7 +1377,7 @@ static void connect_cb(GIOChannel *chan, GError *err, gpointer user_data)
 
 	hfp_gw_set_close_on_unref(dev->gw, true);
 	hfp_gw_set_command_handler(dev->gw, at_cmd_unknown, dev, NULL);
-	hfp_gw_set_disconnect_handler(dev->gw, disconnect_watch, NULL, NULL);
+	hfp_gw_set_disconnect_handler(dev->gw, disconnect_watch, dev, NULL);
 
 	if (dev->hsp) {
 		register_post_slc_at(dev);
-- 
1.9.1

