Return-Path: <cyrus@holtmann.org>
From: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv6 03/11] android/handsfree: Add SCO Audio IPC
Date: Mon, 12 May 2014 11:57:01 +0300
Message-Id: <1399885029-6358-3-git-send-email-Andrei.Emeltchenko.news@gmail.com>
In-Reply-To: <1399885029-6358-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1399885029-6358-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Andrei Emeltchenko <andrei.emeltchenko@intel.com>

If SCO Audio IPC gets connected it provides only one command:
connect_sco().
---
 android/handsfree.c | 69 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 69 insertions(+)

diff --git a/android/handsfree.c b/android/handsfree.c
index 8a27840..befaa6f 100644
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
+static struct ipc *sco_ipc = NULL;
 
 static uint32_t hfp_record_id = 0;
 static GIOChannel *hfp_server = NULL;
@@ -822,6 +825,8 @@ static gboolean sco_watch_cb(GIOChannel *chan, GIOCondition cond,
 	g_io_channel_unref(device.sco);
 	device.sco = NULL;
 
+	DBG("");
+
 	device.sco_watch = 0;
 
 	device_set_audio_state(HAL_EV_HANDSFREE_AUDIO_STATE_DISCONNECTED);
@@ -856,6 +861,30 @@ done:
 	hfp_gw_send_info(device.gw, "+BCS: %u", type);
 }
 
+static void send_sco_fd(GIOChannel *chan)
+{
+	if (sco_ipc) {
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
+		ipc_send_rsp_full(sco_ipc, AUDIO_SERVICE_SCO_ID,
+					AUDIO_OP_CONNECT_SCO, sizeof(rsp), &rsp,
+					fd);
+	}
+}
+
 static void connect_sco_cb(GIOChannel *chan, GError *err, gpointer user_data)
 {
 	DBG("");
@@ -887,6 +916,7 @@ static void connect_sco_cb(GIOChannel *chan, GError *err, gpointer user_data)
 							sco_watch_cb, NULL);
 
 	device_set_audio_state(HAL_EV_HANDSFREE_AUDIO_STATE_CONNECTED);
+	send_sco_fd(chan);
 }
 
 static bool connect_sco(void)
@@ -2564,6 +2594,41 @@ static void disable_sco_server(void)
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
+static void bt_sco_unregister(void)
+{
+	DBG("");
+
+	ipc_cleanup(sco_ipc);
+	sco_ipc = NULL;
+}
+
+static bool bt_sco_register(ipc_disconnect_cb disconnect)
+{
+	DBG("");
+
+	sco_ipc = ipc_init(BLUEZ_SCO_SK_PATH, sizeof(BLUEZ_SCO_SK_PATH),
+				AUDIO_SERVICE_SCO_ID, false, disconnect, NULL);
+	if (!sco_ipc)
+		return false;
+
+	ipc_register(sco_ipc, AUDIO_SERVICE_SCO_ID, audio_handlers,
+						G_N_ELEMENTS(audio_handlers));
+
+	return true;
+}
+
 bool bt_handsfree_register(struct ipc *ipc, const bdaddr_t *addr, uint8_t mode)
 {
 	DBG("mode 0x%x", mode);
@@ -2598,6 +2663,9 @@ done:
 	hal_ipc = ipc;
 	ipc_register(hal_ipc, HAL_SERVICE_ID_HANDSFREE, cmd_handlers,
 						G_N_ELEMENTS(cmd_handlers));
+
+	bt_sco_register(NULL);
+
 	return true;
 }
 
@@ -2605,6 +2673,7 @@ void bt_handsfree_unregister(void)
 {
 	DBG("");
 
+	bt_sco_unregister();
 	ipc_unregister(hal_ipc, HAL_SERVICE_ID_HANDSFREE);
 	hal_ipc = NULL;
 
-- 
1.8.3.2

