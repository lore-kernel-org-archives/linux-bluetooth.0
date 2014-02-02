Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 11/13] android/handsfree: Add AT+BRSF command support
Date: Sun,  2 Feb 2014 22:09:22 +0100
Message-Id: <1391375364-27106-12-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1391375364-27106-1-git-send-email-szymon.janc@tieto.com>
References: <1391375364-27106-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/handsfree.c | 66 ++++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 65 insertions(+), 1 deletion(-)

diff --git a/android/handsfree.c b/android/handsfree.c
index 5fe7638..990ba2f 100644
--- a/android/handsfree.c
+++ b/android/handsfree.c
@@ -49,12 +49,16 @@
 #define HFP_AG_CHANNEL 13
 #define HFP_AG_FEATURES 0
 
+#define AG_FEATURES 0
+
 static struct {
 	bdaddr_t bdaddr;
 	uint8_t state;
 	GIOChannel *io;
 	guint watch;
 	struct hfp_gw *gw;
+
+	uint32_t features;
 } device;
 
 static bdaddr_t adapter_addr;
@@ -123,11 +127,69 @@ static gboolean watch_cb(GIOChannel *chan, GIOCondition cond,
 	return FALSE;
 }
 
+static bool at_brsf(const char *at)
+{
+	uint32_t feat;
+
+	if (sscanf(at, " = %u", &feat) != 1) {
+		hfp_gw_send_result(device.gw, HFP_RESULT_ERROR);
+		return false;
+	}
+
+	/* TODO verify features */
+	device.features = feat;
+
+	hfp_gw_send_info(device.gw, "+BRSF=%u", AG_FEATURES);
+
+	hfp_gw_send_result(device.gw, HFP_RESULT_OK);
+
+	return true;
+}
+
+static const struct {
+	const char *prefix;
+	int prefix_len;
+	bool (*func)(const char *at_cmds);
+} at_cmds[] = {
+	{ "+BRSF", sizeof("+BRSF") - 1, at_brsf },
+};
+
 static void at_command_handler(const char *command, void *user_data)
 {
+	unsigned int i;
+
+	if (strlen(command) < 3)
+		goto error;
+
+	if (strncmp(command, "AT", sizeof("AT") - 1))
+		goto error;
+
+	command += sizeof("AT") - 1;
+
+	for (i = 0; i < G_N_ELEMENTS(at_cmds); i++) {
+		if (strncmp(command, at_cmds[i].prefix, at_cmds[i].prefix_len))
+			continue;
+
+		command += at_cmds[i].prefix_len;
+
+		if (at_cmds[i].func(command))
+			return;
+
+		goto check_slc;
+	}
+
+error:
 	hfp_gw_send_result(device.gw, HFP_RESULT_ERROR);
 
-	g_io_channel_shutdown(device.io, TRUE, NULL);
+check_slc:
+	/* Error while establishing SLC */
+	if (device.state != HAL_EV_HANDSFREE_CONNECTION_STATE_SLC_CONNECTED)
+		g_io_channel_shutdown(device.io, TRUE, NULL);
+}
+
+static void hfp_gw_debug(const char *str, void *user_data)
+{
+	DBG("%s", str);
 }
 
 static void connect_cb(GIOChannel *chan, GError *err, gpointer user_data)
@@ -148,6 +210,8 @@ static void connect_cb(GIOChannel *chan, GError *err, gpointer user_data)
 	hfp_gw_set_close_on_unref(device.gw, true);
 	hfp_gw_set_command_handler(device.gw, at_command_handler, NULL, NULL);
 
+	hfp_gw_set_debug(device.gw, hfp_gw_debug, NULL, NULL);
+
 	device.watch = g_io_add_watch(chan,
 					G_IO_HUP | G_IO_ERR | G_IO_NVAL,
 					watch_cb, NULL);
-- 
1.8.5.3

