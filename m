Return-Path: <cyrus@holtmann.org>
From: Marcin Kraglak <marcin.kraglak@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/5] android/handsfree: Add support for handling incoming SCO connections
Date: Fri,  7 Mar 2014 21:23:17 +0100
Message-Id: <1394223800-11961-2-git-send-email-marcin.kraglak@tieto.com>
In-Reply-To: <1394223800-11961-1-git-send-email-marcin.kraglak@tieto.com>
References: <1394223800-11961-1-git-send-email-marcin.kraglak@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This adds support for accepting SCO connections from remote devices.
---
 android/handsfree.c | 148 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 148 insertions(+)

diff --git a/android/handsfree.c b/android/handsfree.c
index fa27f10..40f3652 100644
--- a/android/handsfree.c
+++ b/android/handsfree.c
@@ -83,11 +83,14 @@ static const struct indicator inds_defaults[] = {
 static struct {
 	bdaddr_t bdaddr;
 	uint8_t state;
+	uint8_t audio_state;
 	uint32_t features;
 	bool indicators_enabled;
 	struct indicator inds[IND_COUNT];
 	bool hsp;
 	struct hfp_gw *gw;
+	GIOChannel *sco;
+	guint sco_watch;
 } device;
 
 static bdaddr_t adapter_addr;
@@ -99,6 +102,8 @@ static GIOChannel *hfp_server = NULL;
 static uint32_t hsp_record_id = 0;
 static GIOChannel *hsp_server = NULL;
 
+static GIOChannel *sco_server = NULL;
+
 static void device_set_state(uint8_t state)
 {
 	struct hal_ev_handsfree_conn_state ev;
@@ -119,6 +124,26 @@ static void device_set_state(uint8_t state)
 				HAL_EV_HANDSFREE_CONN_STATE, sizeof(ev), &ev);
 }
 
+static void device_set_audio_state(uint8_t state)
+{
+	struct hal_ev_handsfree_audio_state ev;
+	char address[18];
+
+	if (device.audio_state == state)
+		return;
+
+	device.audio_state = state;
+
+	ba2str(&device.bdaddr, address);
+	DBG("device %s audio state %u", address, state);
+
+	bdaddr2android(&device.bdaddr, ev.bdaddr);
+	ev.state = state;
+
+	ipc_send_notif(hal_ipc, HAL_SERVICE_ID_HANDSFREE,
+				HAL_EV_HANDSFREE_AUDIO_STATE, sizeof(ev), &ev);
+}
+
 static void device_init(const bdaddr_t *bdaddr)
 {
 	bacpy(&device.bdaddr, bdaddr);
@@ -137,6 +162,19 @@ static void device_cleanup(void)
 
 	device_set_state(HAL_EV_HANDSFREE_CONN_STATE_DISCONNECTED);
 
+	if (device.sco_watch) {
+		g_source_remove(device.sco_watch);
+		device.sco_watch = 0;
+	}
+
+	if (device.sco) {
+		g_io_channel_shutdown(device.sco, TRUE, NULL);
+		g_io_channel_unref(device.sco);
+		device.sco = NULL;
+	}
+
+	device_set_audio_state(HAL_EV_HANDSFREE_AUDIO_STATE_DISCONNECTED);
+
 	memset(&device, 0, sizeof(device));
 }
 
@@ -739,6 +777,42 @@ failed:
 					HAL_OP_HANDSFREE_DISCONNECT, status);
 }
 
+static gboolean sco_watch_cb(GIOChannel *chan, GIOCondition cond,
+							gpointer user_data)
+{
+	g_source_remove(device.sco_watch);
+	device.sco_watch = 0;
+
+	g_io_channel_shutdown(device.sco, TRUE, NULL);
+	g_io_channel_unref(device.sco);
+	device.sco = NULL;
+
+	device_set_audio_state(HAL_EV_HANDSFREE_AUDIO_STATE_DISCONNECTED);
+
+	return FALSE;
+}
+
+static void connect_sco_cb(GIOChannel *chan, GError *err, gpointer user_data)
+{
+	if (err) {
+		uint8_t status;
+
+		error("SCO: connect failed (%s)", err->message);
+		status = HAL_EV_HANDSFREE_AUDIO_STATE_DISCONNECTED;
+		device_set_audio_state(status);
+
+		return;
+	}
+
+	g_io_channel_set_close_on_unref(chan, TRUE);
+
+	device.sco = g_io_channel_ref(chan);
+	device.sco_watch = g_io_add_watch(chan, G_IO_ERR | G_IO_HUP | G_IO_NVAL,
+							sco_watch_cb, NULL);
+
+	device_set_audio_state(HAL_EV_HANDSFREE_AUDIO_STATE_CONNECTED);
+}
+
 static void handle_connect_audio(const void *buf, uint16_t len)
 {
 	DBG("");
@@ -1044,6 +1118,46 @@ static sdp_record_t *headset_ag_record(void)
 	return record;
 }
 
+static void confirm_sco_cb(GIOChannel *chan, gpointer user_data)
+{
+	char address[18];
+	bdaddr_t bdaddr;
+	GError *err = NULL;
+
+	if (device.sco)
+		goto drop;
+
+	bt_io_get(chan, &err,
+			BT_IO_OPT_DEST, address,
+			BT_IO_OPT_DEST_BDADDR, &bdaddr,
+			BT_IO_OPT_INVALID);
+	if (err) {
+		error("SCO: confirm failed (%s)", err->message);
+		g_error_free(err);
+		goto drop;
+	}
+
+	DBG("incoming SCO connection from %s", address);
+
+	if (device.state != HAL_EV_HANDSFREE_CONN_STATE_SLC_CONNECTED ||
+			bacmp(&device.bdaddr, &bdaddr)) {
+		error("SCO: connection from %s rejected", address);
+		goto drop;
+	}
+
+	if (!bt_io_accept(chan, connect_sco_cb, NULL, NULL, NULL)) {
+		error("SCO: failed to accept connection");
+		goto drop;
+	}
+
+	device_set_audio_state(HAL_EV_HANDSFREE_AUDIO_STATE_CONNECTING);
+
+	return;
+
+drop:
+	g_io_channel_shutdown(chan, TRUE, NULL);
+}
+
 static bool enable_hsp_ag(void)
 {
 	sdp_record_t *rec;
@@ -1233,6 +1347,33 @@ static void cleanup_hfp_ag(void)
 	}
 }
 
+static bool enable_sco_server(void)
+{
+	GError *err = NULL;
+
+	sco_server = bt_io_listen(NULL, confirm_sco_cb, NULL, NULL, &err,
+				BT_IO_OPT_SOURCE_BDADDR, &adapter_addr,
+				BT_IO_OPT_INVALID);
+	if (!sco_server) {
+		error("Failed to listen on SCO: %s", err->message);
+		g_error_free(err);
+		cleanup_hsp_ag();
+		cleanup_hfp_ag();
+		return false;
+	}
+
+	return true;
+}
+
+static void disable_sco_server(void)
+{
+	if (sco_server) {
+		g_io_channel_shutdown(sco_server, TRUE, NULL);
+		g_io_channel_unref(sco_server);
+		sco_server = NULL;
+	}
+}
+
 bool bt_handsfree_register(struct ipc *ipc, const bdaddr_t *addr, uint8_t mode)
 {
 	DBG("mode 0x%x", mode);
@@ -1247,6 +1388,12 @@ bool bt_handsfree_register(struct ipc *ipc, const bdaddr_t *addr, uint8_t mode)
 		return false;
 	}
 
+	if (!enable_sco_server()) {
+		cleanup_hsp_ag();
+		cleanup_hfp_ag();
+		return false;
+	}
+
 	hal_ipc = ipc;
 	ipc_register(hal_ipc, HAL_SERVICE_ID_HANDSFREE, cmd_handlers,
 						G_N_ELEMENTS(cmd_handlers));
@@ -1263,4 +1410,5 @@ void bt_handsfree_unregister(void)
 
 	cleanup_hfp_ag();
 	cleanup_hsp_ag();
+	disable_sco_server();
 }
-- 
1.8.3.1

