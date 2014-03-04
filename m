Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 4/8] android/handsfree: Distinguish between HSP and HFP connection
Date: Tue,  4 Mar 2014 16:32:06 +0100
Message-Id: <1393947130-11999-5-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1393947130-11999-1-git-send-email-szymon.janc@tieto.com>
References: <1393947130-11999-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/handsfree.c | 25 +++++++++++++++++++------
 1 file changed, 19 insertions(+), 6 deletions(-)

diff --git a/android/handsfree.c b/android/handsfree.c
index a437fba..50b32da 100644
--- a/android/handsfree.c
+++ b/android/handsfree.c
@@ -71,6 +71,7 @@ static struct {
 	uint8_t state;
 	uint32_t features;
 	bool indicators_enabled;
+	bool hsp;
 	struct hfp_gw *gw;
 } device;
 
@@ -272,10 +273,16 @@ static void connect_cb(GIOChannel *chan, GError *err, gpointer user_data)
 	hfp_gw_set_disconnect_handler(device.gw, disconnect_watch, NULL, NULL);
 
 
-	hfp_gw_register(device.gw, at_cmd_brsf, "+BRSF", NULL, NULL);
-	hfp_gw_register(device.gw, at_cmd_cind, "+CIND", NULL, NULL);
-	hfp_gw_register(device.gw, at_cmd_cmer, "+CMER", NULL, NULL);
-	device_set_state(HAL_EV_HANDSFREE_CONNECTION_STATE_CONNECTED);
+	if (device.hsp) {
+		/* TODO CKPD, VGS, VGM */
+		device_set_state(HAL_EV_HANDSFREE_CONNECTION_STATE_CONNECTED);
+		device_set_state(HAL_EV_HANDSFREE_CONNECTION_STATE_SLC_CONNECTED);
+	} else {
+		hfp_gw_register(device.gw, at_cmd_brsf, "+BRSF", NULL, NULL);
+		hfp_gw_register(device.gw, at_cmd_cind, "+CIND", NULL, NULL);
+		hfp_gw_register(device.gw, at_cmd_cmer, "+CMER", NULL, NULL);
+		device_set_state(HAL_EV_HANDSFREE_CONNECTION_STATE_CONNECTED);
+	}
 
 	return;
 
@@ -315,6 +322,8 @@ static void confirm_cb(GIOChannel *chan, gpointer data)
 		goto drop;
 	}
 
+	device.hsp = GPOINTER_TO_INT(data);
+
 	return;
 
 drop:
@@ -386,6 +395,8 @@ static void sdp_hsp_search_cb(sdp_list_t *recs, int err, gpointer data)
 		goto fail;
 	}
 
+	device.hsp = true;
+
 	g_io_channel_unref(io);
 	return;
 
@@ -804,7 +815,8 @@ static bool enable_hsp_ag(void)
 
 	DBG("");
 
-	hsp_server =  bt_io_listen(NULL, confirm_cb, NULL, NULL, &err,
+	hsp_server =  bt_io_listen(NULL, confirm_cb, GINT_TO_POINTER(true), NULL,
+					&err,
 					BT_IO_OPT_SOURCE_BDADDR, &adapter_addr,
 					BT_IO_OPT_CHANNEL, HSP_AG_CHANNEL,
 					BT_IO_OPT_SEC_LEVEL, BT_IO_SEC_MEDIUM,
@@ -935,7 +947,8 @@ static bool enable_hfp_ag(void)
 	if (hfp_server)
 		return false;
 
-	hfp_server =  bt_io_listen(NULL, confirm_cb, NULL, NULL, &err,
+	hfp_server =  bt_io_listen(NULL, confirm_cb, GINT_TO_POINTER(false),
+					NULL, &err,
 					BT_IO_OPT_SOURCE_BDADDR, &adapter_addr,
 					BT_IO_OPT_CHANNEL, HFP_AG_CHANNEL,
 					BT_IO_OPT_SEC_LEVEL, BT_IO_SEC_MEDIUM,
-- 
1.8.3.2

