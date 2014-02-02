Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 07/13] android/handsfree: Add support for RFCOMM connection handling
Date: Sun,  2 Feb 2014 22:09:18 +0100
Message-Id: <1391375364-27106-8-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1391375364-27106-1-git-send-email-szymon.janc@tieto.com>
References: <1391375364-27106-1-git-send-email-szymon.janc@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This adds incoming connection handling and initial connection state
tracking. Only one device is allowed to be connected at the same time.
---
 android/handsfree.c | 167 +++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 165 insertions(+), 2 deletions(-)

diff --git a/android/handsfree.c b/android/handsfree.c
index d2dc543..ad4c0ff 100644
--- a/android/handsfree.c
+++ b/android/handsfree.c
@@ -25,24 +25,162 @@
 #include <config.h>
 #endif
 
+#include <stdlib.h>
 #include <stdbool.h>
+#include <errno.h>
+#include <unistd.h>
 #include <glib.h>
 
 #include "lib/bluetooth.h"
 #include "lib/sdp.h"
 #include "lib/sdp_lib.h"
+#include "lib/uuid.h"
+#include "src/sdp-client.h"
+#include "src/uuid-helper.h"
+#include "btio/btio.h"
 #include "handsfree.h"
 #include "bluetooth.h"
 #include "src/log.h"
 #include "hal-msg.h"
 #include "ipc.h"
+#include "utils.h"
 
 #define HFP_AG_CHANNEL 13
 #define HFP_AG_FEATURES 0
 
+static struct {
+	bdaddr_t bdaddr;
+	uint8_t state;
+	GIOChannel *io;
+	guint watch;
+} device;
+
 static bdaddr_t adapter_addr;
 static uint32_t record_id = 0;
 
+static GIOChannel *server = NULL;
+
+static void device_set_state(uint8_t state)
+{
+	struct hal_ev_handsfree_conn_state ev;
+	char address[18];
+
+	if (device.state == state)
+		return;
+
+	device.state = state;
+
+	ba2str(&device.bdaddr, address);
+	DBG("device %s state %u", address, state);
+
+	bdaddr2android(&device.bdaddr, ev.bdaddr);
+	ev.state = state;
+
+	ipc_send_notif(HAL_SERVICE_ID_HANDSFREE, HAL_EV_HANDSFREE_CONN_STATE,
+							sizeof(ev), &ev);
+}
+
+static void device_init(const bdaddr_t *bdaddr)
+{
+	bacpy(&device.bdaddr, bdaddr);
+
+	device_set_state(HAL_EV_HANDSFREE_CONNECTION_STATE_CONNECTING);
+}
+
+static void device_cleanup(void)
+{
+	if (device.watch) {
+		g_source_remove(device.watch);
+		device.watch = 0;
+	}
+
+	if (device.io) {
+		g_io_channel_unref(device.io);
+		device.io = NULL;
+	}
+
+	device_set_state(HAL_EV_HANDSFREE_CONNECTION_STATE_DISCONNECTED);
+
+	memset(&device, 0, sizeof(device));
+}
+
+static gboolean watch_cb(GIOChannel *chan, GIOCondition cond,
+							gpointer user_data)
+{
+	DBG("");
+
+	device.watch = 0;
+
+	device_cleanup();
+
+	return FALSE;
+}
+
+static void connect_cb(GIOChannel *chan, GError *err, gpointer user_data)
+{
+	DBG("");
+
+	if (err) {
+		error("handsfree: connect failed (%s)", err->message);
+		goto failed;
+	}
+
+	g_io_channel_set_close_on_unref(chan, TRUE);
+
+	device.watch = g_io_add_watch(chan,
+					G_IO_HUP | G_IO_ERR | G_IO_NVAL,
+					watch_cb, NULL);
+	if (device.watch == 0)
+		goto failed;
+
+	device.io = g_io_channel_ref(chan);
+
+	device_set_state(HAL_EV_HANDSFREE_CONNECTION_STATE_CONNECTED);
+
+	return;
+
+failed:
+	g_io_channel_shutdown(chan, TRUE, NULL);
+	device_cleanup();
+}
+
+static void confirm_cb(GIOChannel *chan, gpointer data)
+{
+	char address[18];
+	bdaddr_t bdaddr;
+	GError *err = NULL;
+
+	bt_io_get(chan, &err,
+			BT_IO_OPT_DEST, address,
+			BT_IO_OPT_DEST_BDADDR, &bdaddr,
+			BT_IO_OPT_INVALID);
+	if (err) {
+		error("handsfree: confirm failed (%s)", err->message);
+		g_error_free(err);
+		goto drop;
+	}
+
+	DBG("incoming connect from %s", address);
+
+	if (device.state != HAL_EV_HANDSFREE_CONNECTION_STATE_DISCONNECTED) {
+		info("handsfree: refusing connection from %s", address);
+		goto drop;
+	}
+
+	device_init(&bdaddr);
+
+	if (!bt_io_accept(chan, connect_cb, NULL, NULL, NULL)) {
+		error("handsfree: failed to accept connection");
+		device_cleanup();
+		goto drop;
+	}
+
+	return;
+
+drop:
+	g_io_channel_shutdown(chan, TRUE, NULL);
+}
+
 static void handle_connect(const void *buf, uint16_t len)
 {
 	DBG("");
@@ -271,21 +409,33 @@ static sdp_record_t *handsfree_ag_record(void)
 bool bt_handsfree_register(const bdaddr_t *addr)
 {
 	sdp_record_t *rec;
+	GError *err = NULL;
 
 	DBG("");
 
 	bacpy(&adapter_addr, addr);
 
+	server =  bt_io_listen( NULL, confirm_cb, NULL, NULL, &err,
+				BT_IO_OPT_SOURCE_BDADDR, &adapter_addr,
+				BT_IO_OPT_CHANNEL, HFP_AG_CHANNEL,
+				BT_IO_OPT_SEC_LEVEL, BT_IO_SEC_MEDIUM,
+				BT_IO_OPT_INVALID);
+	if (!server) {
+		error("Failed to listen on Handsfree rfcomm: %s", err->message);
+		g_error_free(err);
+		return false;
+	}
+
 	rec = handsfree_ag_record();
 	if (!rec) {
 		error("Failed to allocate Handsfree record");
-		return false;
+		goto failed;
 	}
 
 	if (bt_adapter_add_record(rec, 0) < 0) {
 		error("Failed to register Handsfree record");
 		sdp_record_free(rec);
-		return false;
+		goto failed;
 	}
 	record_id = rec->handle;
 
@@ -293,6 +443,13 @@ bool bt_handsfree_register(const bdaddr_t *addr)
 						G_N_ELEMENTS(cmd_handlers));
 
 	return true;
+
+failed:
+	g_io_channel_shutdown(server, TRUE, NULL);
+	g_io_channel_unref(server);
+	server = NULL;
+
+	return false;
 }
 
 void bt_handsfree_unregister(void)
@@ -301,6 +458,12 @@ void bt_handsfree_unregister(void)
 
 	ipc_unregister(HAL_SERVICE_ID_HANDSFREE);
 
+	if (server) {
+		g_io_channel_shutdown(server, TRUE, NULL);
+		g_io_channel_unref(server);
+		server = NULL;
+	}
+
 	bt_adapter_remove_record(record_id);
 	record_id = 0;
 }
-- 
1.8.5.3

