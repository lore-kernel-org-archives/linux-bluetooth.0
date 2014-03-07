Return-Path: <cyrus@holtmann.org>
From: Marcin Kraglak <marcin.kraglak@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 5/5] android/handsfree: Remove empty line
Date: Fri,  7 Mar 2014 21:23:20 +0100
Message-Id: <1394223800-11961-5-git-send-email-marcin.kraglak@tieto.com>
In-Reply-To: <1394223800-11961-1-git-send-email-marcin.kraglak@tieto.com>
References: <1394223800-11961-1-git-send-email-marcin.kraglak@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/handsfree.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/android/handsfree.c b/android/handsfree.c
index 69de670..1b42142 100644
--- a/android/handsfree.c
+++ b/android/handsfree.c
@@ -475,7 +475,6 @@ static void connect_cb(GIOChannel *chan, GError *err, gpointer user_data)
 	hfp_gw_set_command_handler(device.gw, at_command_handler, NULL, NULL);
 	hfp_gw_set_disconnect_handler(device.gw, disconnect_watch, NULL, NULL);
 
-
 	if (device.hsp) {
 		register_post_slc_at();
 		device_set_state(HAL_EV_HANDSFREE_CONN_STATE_CONNECTED);
-- 
1.8.3.1

