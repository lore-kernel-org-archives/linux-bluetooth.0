Return-Path: <cyrus@holtmann.org>
From: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
Subject: [PATCH_v2 4/7] android/pan: Implement pan connect method in daemon
Date: Thu, 28 Nov 2013 16:45:52 +0200
Message-Id: <1385649955-29276-5-git-send-email-ravikumar.veeramally@linux.intel.com>
In-Reply-To: <1385649955-29276-1-git-send-email-ravikumar.veeramally@linux.intel.com>
References: <1385649955-29276-1-git-send-email-ravikumar.veeramally@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Implements the PAN connect method in android daemon with PANU role
only. Setting up the bnep environment, adds connection and makes
bnep interface up are part of bnep_connect call. Notifies bnep
interface on control state call back and connection status on
connection state call back.
---
 android/Android.mk  |   2 +
 android/Makefile.am |   3 +-
 android/pan.c       | 216 ++++++++++++++++++++++++++++++++++++++++++++++++++--
 3 files changed, 213 insertions(+), 8 deletions(-)

diff --git a/android/Android.mk b/android/Android.mk
index c4d722d..549613c 100644
--- a/android/Android.mk
+++ b/android/Android.mk
@@ -42,6 +42,7 @@ LOCAL_SRC_FILES := \
 	../lib/hci.c \
 	../btio/btio.c \
 	../src/sdp-client.c \
+	../profiles/network/bnep.c \
 
 LOCAL_C_INCLUDES := \
 	$(call include-path-for, glib) \
@@ -66,6 +67,7 @@ lib_headers := \
 	sdp.h \
 	rfcomm.h \
 	sco.h \
+	bnep.h \
 
 $(shell mkdir -p $(LOCAL_PATH)/../lib/bluetooth)
 
diff --git a/android/Makefile.am b/android/Makefile.am
index 38aa00a..ea8cb5b 100644
--- a/android/Makefile.am
+++ b/android/Makefile.am
@@ -24,7 +24,8 @@ android_bluetoothd_SOURCES = android/main.c \
 				android/socket.h android/socket.c \
 				android/pan.h android/pan.c \
 				btio/btio.h btio/btio.c \
-				src/sdp-client.h src/sdp-client.c
+				src/sdp-client.h src/sdp-client.c \
+				profiles/network/bnep.h profiles/network/bnep.c
 
 android_bluetoothd_LDADD = lib/libbluetooth-internal.la @GLIB_LIBS@
 
diff --git a/android/pan.c b/android/pan.c
index ada458a..058ce70 100644
--- a/android/pan.c
+++ b/android/pan.c
@@ -29,37 +29,228 @@
 #include <fcntl.h>
 #include <glib.h>
 
+#include "btio/btio.h"
 #include "lib/bluetooth.h"
+#include "lib/bnep.h"
+#include "lib/sdp.h"
+#include "lib/sdp_lib.h"
+#include "src/glib-helper.h"
+#include "profiles/network/bnep.h"
+
 #include "log.h"
 #include "pan.h"
 #include "hal-msg.h"
 #include "ipc.h"
+#include "utils.h"
+#include "bluetooth.h"
 
+static bdaddr_t adapter_addr;
 static int notification_sk = -1;
+GSList *peers = NULL;
+uint8_t local_role = HAL_PAN_ROLE_NONE;
 
-static uint8_t bt_pan_enable(struct hal_cmd_pan_enable *cmd, uint16_t len)
+struct network_peer {
+	char		dev[16];
+	bdaddr_t	dst;
+	uint8_t		conn_state;
+	uint8_t		role;
+	GIOChannel	*io;
+	guint		watch;
+};
+
+static int peer_cmp(gconstpointer s, gconstpointer user_data)
 {
-	DBG("Not Implemented");
+	const struct network_peer *np = s;
+	const bdaddr_t *dst = user_data;
 
-	return HAL_STATUS_FAILED;
+	return bacmp(&np->dst, dst);
 }
 
-static uint8_t bt_pan_get_role(void *cmd, uint16_t len)
+static void network_peer_free(struct network_peer *np)
+{
+	local_role = HAL_PAN_ROLE_NONE;
+
+	if (np->watch > 0) {
+		g_source_remove(np->watch);
+		np->watch = 0;
+	}
+
+	if (np->io) {
+		g_io_channel_unref(np->io);
+		np->io = NULL;
+	}
+
+	peers = g_slist_remove(peers, np);
+	g_free(np);
+	np = NULL;
+}
+
+static void bt_pan_notify_conn_state(struct network_peer *np, uint8_t state)
+{
+	struct hal_ev_pan_conn_state ev;
+	char addr[18];
+
+	if (np->conn_state == state)
+		return;
+
+	np->conn_state = state;
+	ba2str(&np->dst, addr);
+	DBG("device %s state %u", addr, state);
+
+	bdaddr2android(&np->dst, ev.bdaddr);
+	ev.state = state;
+	ev.local_role = local_role;
+	ev.remote_role = np->role;
+	ev.status = HAL_STATUS_SUCCESS;
+
+	ipc_send(notification_sk, HAL_SERVICE_ID_PAN, HAL_EV_PAN_CONN_STATE,
+							sizeof(ev), &ev, -1);
+}
+
+static void bt_pan_notify_ctrl_state(struct network_peer *np, uint8_t state)
+{
+	struct hal_ev_pan_ctrl_state ev;
+
+	DBG("");
+
+	ev.state = state;
+	ev.local_role = local_role;
+	ev.status = HAL_STATUS_SUCCESS;
+	memcpy(ev.name, np->dev, sizeof(np->dev));
+
+	ipc_send(notification_sk, HAL_SERVICE_ID_PAN, HAL_EV_PAN_CTRL_STATE,
+							sizeof(ev), &ev, -1);
+}
+
+static gboolean bnep_watchdog_cb(GIOChannel *chan, GIOCondition cond,
+								gpointer data)
+{
+	struct network_peer *np = data;
+
+	DBG("%s disconnected", np->dev);
+
+	bt_pan_notify_conn_state(np, HAL_PAN_STATE_DISCONNECTED);
+	network_peer_free(np);
+
+	return FALSE;
+}
+
+static void bnep_conn_cb(GIOChannel *chan, char *iface, int err, void *data)
+{
+	struct network_peer *np = data;
+
+	DBG("");
+
+	if (err < 0) {
+		error("bnep connect req failed: %s", strerror(-err));
+		bt_pan_notify_conn_state(np, HAL_PAN_STATE_DISCONNECTED);
+		network_peer_free(np);
+		return;
+	}
+
+	memcpy(np->dev, iface, sizeof(np->dev));
+
+	DBG("%s connected", np->dev);
+
+	bt_pan_notify_ctrl_state(np, HAL_PAN_CTRL_ENABLED);
+	bt_pan_notify_conn_state(np, HAL_PAN_STATE_CONNECTED);
+
+	np->watch = g_io_add_watch(chan, G_IO_ERR | G_IO_HUP | G_IO_NVAL,
+							bnep_watchdog_cb, np);
+	g_io_channel_unref(np->io);
+	np->io = NULL;
+}
+
+static void connect_cb(GIOChannel *chan, GError *err, gpointer data)
+{
+	struct network_peer *np = data;
+	uint16_t src, dst;
+	int perr;
+
+	DBG("");
+
+	if (err) {
+		error("%s", err->message);
+		bt_pan_notify_conn_state(np, HAL_PAN_STATE_DISCONNECTED);
+		network_peer_free(np);
+	}
+
+	src = (local_role == HAL_PAN_ROLE_NAP) ? BNEP_SVC_NAP : BNEP_SVC_PANU;
+	dst = (np->role == HAL_PAN_ROLE_NAP) ? BNEP_SVC_NAP : BNEP_SVC_PANU;
+
+	perr = bnep_connect(np->io, src, dst, bnep_conn_cb, np);
+	if (perr < 0) {
+		error("bnep connect req failed: %s", strerror(-perr));
+		bt_pan_notify_conn_state(np, HAL_PAN_STATE_DISCONNECTED);
+		network_peer_free(np);
+		return;
+	}
+}
+
+static uint8_t bt_pan_connect(struct hal_cmd_pan_connect *cmd, uint16_t len)
+{
+	struct network_peer *np;
+	bdaddr_t dst;
+	char addr[18];
+	GSList *l;
+	GError *gerr = NULL;
+
+	DBG("");
+
+	if (len < sizeof(*cmd))
+		return HAL_STATUS_INVALID;
+
+	android2bdaddr(&cmd->bdaddr, &dst);
+
+	l = g_slist_find_custom(peers, &dst, peer_cmp);
+	if (l)
+		return HAL_STATUS_FAILED;
+
+	np = g_new0(struct network_peer, 1);
+	bacpy(&np->dst, &dst);
+	local_role = cmd->local_role;
+	np->role = cmd->remote_role;
+
+	ba2str(&np->dst, addr);
+	DBG("connecting to %s %s", addr, np->dev);
+
+	np->io = bt_io_connect(connect_cb, np, NULL, &gerr,
+					BT_IO_OPT_SOURCE_BDADDR, &adapter_addr,
+					BT_IO_OPT_DEST_BDADDR, &np->dst,
+					BT_IO_OPT_PSM, BNEP_PSM,
+					BT_IO_OPT_SEC_LEVEL, BT_IO_SEC_MEDIUM,
+					BT_IO_OPT_OMTU, BNEP_MTU,
+					BT_IO_OPT_IMTU, BNEP_MTU,
+					BT_IO_OPT_INVALID);
+	if (!np->io) {
+		error("%s", gerr->message);
+		g_error_free(gerr);
+		g_free(np);
+		return HAL_STATUS_FAILED;
+	}
+
+	peers = g_slist_append(peers, np);
+	bt_pan_notify_conn_state(np, HAL_PAN_STATE_CONNECTING);
+
+	return HAL_STATUS_SUCCESS;
+}
+
+static uint8_t bt_pan_disconnect(struct hal_cmd_pan_disconnect *cmd,
+								uint16_t len)
 {
 	DBG("Not Implemented");
 
 	return HAL_STATUS_FAILED;
 }
 
-static uint8_t bt_pan_connect(struct hal_cmd_pan_connect *cmd, uint16_t len)
+static uint8_t bt_pan_enable(struct hal_cmd_pan_enable *cmd, uint16_t len)
 {
 	DBG("Not Implemented");
 
 	return HAL_STATUS_FAILED;
 }
 
-static uint8_t bt_pan_disconnect(struct hal_cmd_pan_disconnect *cmd,
-								uint16_t len)
+static uint8_t bt_pan_get_role(void *cmd, uint16_t len)
 {
 	DBG("Not Implemented");
 
@@ -93,11 +284,21 @@ void bt_pan_handle_cmd(int sk, uint8_t opcode, void *buf, uint16_t len)
 
 bool bt_pan_register(int sk, const bdaddr_t *addr)
 {
+	int err;
+
 	DBG("");
 
 	if (notification_sk >= 0)
 		return false;
 
+	bacpy(&adapter_addr, addr);
+
+	err = bnep_init();
+	if (err) {
+		error("bnep init failed");
+		return false;
+	}
+
 	notification_sk = sk;
 
 	return true;
@@ -111,4 +312,5 @@ void bt_pan_unregister(void)
 		return;
 
 	notification_sk = -1;
+	bnep_cleanup();
 }
-- 
1.8.3.2

