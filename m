Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv3 04/12] android/handsfree: Add SCO Audio IPC
Date: Thu,  8 May 2014 11:01:35 +0300
Message-Id: <1399536103-19052-5-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1399536103-19052-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1399536103-19052-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

If SCO Audio IPC gets connected it provides only one command:
connect_sco().
---
 android/handsfree.c | 58 ++++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 57 insertions(+), 1 deletion(-)

diff --git a/android/handsfree.c b/android/handsfree.c
index 8202e53..96f0f6e 100644
--- a/android/handsfree.c
+++ b/android/handsfree.c
@@ -45,6 +45,7 @@
 #include "bluetooth.h"
 #include "src/log.h"
 #include "utils.h"
+#include "sco-msg.h"
 
 #define HSP_AG_CHANNEL 12
 #define HFP_AG_CHANNEL 13
@@ -156,7 +157,9 @@ static struct {
 static uint32_t hfp_ag_features = 0;
 
 static bdaddr_t adapter_addr;
+
 static struct ipc *hal_ipc = NULL;
+static struct ipc *audio_ipc = NULL;
 
 static uint32_t hfp_record_id = 0;
 static GIOChannel *hfp_server = NULL;
@@ -822,6 +825,8 @@ static gboolean sco_watch_cb(GIOChannel *chan, GIOCondition cond,
 	g_io_channel_unref(device.sco);
 	device.sco = NULL;
 
+	DBG("");
+
 	device.sco_watch = 0;
 
 	device_set_audio_state(HAL_EV_HANDSFREE_AUDIO_STATE_DISCONNECTED);
@@ -887,6 +892,27 @@ static void connect_sco_cb(GIOChannel *chan, GError *err, gpointer user_data)
 							sco_watch_cb, NULL);
 
 	device_set_audio_state(HAL_EV_HANDSFREE_AUDIO_STATE_CONNECTED);
+
+	if (audio_ipc) {
+		int fd = g_io_channel_unix_get_fd(chan);
+		GError *err = NULL;
+		uint16_t mtu = 48;
+		struct audio_rsp_connect_sco rsp;
+
+		if (!bt_io_get(chan, &err, BT_IO_OPT_MTU, &mtu,
+							BT_IO_OPT_INVALID)) {
+			error("Unable to get MTU: %s\n", err->message);
+			g_clear_error(&err);
+		}
+
+		DBG("fd %d mtu %u", fd, mtu);
+
+		rsp.mtu = mtu;
+
+		ipc_send_rsp_full(audio_ipc, AUDIO_SERVICE_SCO_ID,
+					AUDIO_OP_CONNECT_SCO, sizeof(rsp), &rsp,
+					fd);
+	}
 }
 
 static bool connect_sco(void)
@@ -904,7 +930,7 @@ static bool connect_sco(void)
 				device.negotiated_codec != CODEC_ID_CVSD)
 		voice_settings = BT_VOICE_TRANSPARENT;
 	else
-		voice_settings = BT_VOICE_CVSD_16BIT;
+		voice_settings = 0;
 
 	io = bt_io_connect(connect_sco_cb, NULL, NULL, &gerr,
 				BT_IO_OPT_SOURCE_BDADDR, &adapter_addr,
@@ -2563,6 +2589,33 @@ static void disable_sco_server(void)
 	}
 }
 
+static void bt_audio_connect_sco(const void *buf, uint16_t len)
+{
+	DBG("");
+
+	connect_audio();
+}
+
+static const struct ipc_handler audio_handlers[] = {
+	/* AUDIO_OP_CONNECT_SCO */
+	{ bt_audio_connect_sco, false, 0 }
+};
+
+static bool bt_audio_register(ipc_disconnect_cb disconnect)
+{
+	DBG("");
+
+	audio_ipc = ipc_init(BLUEZ_SCO_SK_PATH, sizeof(BLUEZ_SCO_SK_PATH),
+				AUDIO_SERVICE_SCO_ID, false, disconnect, NULL);
+	if (!audio_ipc)
+		return false;
+
+	ipc_register(audio_ipc, AUDIO_SERVICE_SCO_ID, audio_handlers,
+						G_N_ELEMENTS(audio_handlers));
+
+	return true;
+}
+
 bool bt_handsfree_register(struct ipc *ipc, const bdaddr_t *addr, uint8_t mode)
 {
 	DBG("mode 0x%x", mode);
@@ -2597,6 +2650,9 @@ done:
 	hal_ipc = ipc;
 	ipc_register(hal_ipc, HAL_SERVICE_ID_HANDSFREE, cmd_handlers,
 						G_N_ELEMENTS(cmd_handlers));
+
+	bt_audio_register(NULL);
+
 	return true;
 }
 
-- 
1.8.3.2

