Return-Path: <cyrus@holtmann.org>
From: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
Subject: [PATCH_v5 3/6] android/pan: Implement pan connect method in daemon
Date: Fri, 29 Nov 2013 16:20:42 +0200
Message-Id: <1385734845-9725-4-git-send-email-ravikumar.veeramally@linux.intel.com>
In-Reply-To: <1385734845-9725-1-git-send-email-ravikumar.veeramally@linux.intel.com>
References: <1385734845-9725-1-git-send-email-ravikumar.veeramally@linux.intel.com>
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
 android/pan.c       | 219 ++++++++++++++++++++++++++++++++++++++++++++++++++--
 3 files changed, 216 insertions(+), 8 deletions(-)

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
index 15ecf35..df04762 100644
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
index ea15637..031dfff 100644
--- a/android/pan.c
+++ b/android/pan.c
@@ -29,35 +29,228 @@
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
 
-static uint8_t bt_pan_enable(struct hal_cmd_pan_enable *cmd, uint16_t len)
+static bdaddr_t adapter_addr;
+GSList *peers = NULL;
+uint8_t local_role = HAL_PAN_ROLE_NONE;
+
+struct pan_device {
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
+	const struct pan_device *dev = s;
+	const bdaddr_t *dst = user_data;
 
-	return HAL_STATUS_FAILED;
+	return bacmp(&dev->dst, dst);
 }
 
-static uint8_t bt_pan_get_role(void *cmd, uint16_t len)
+static void pan_device_free(struct pan_device *dev)
+{
+	local_role = HAL_PAN_ROLE_NONE;
+
+	if (dev->watch > 0) {
+		g_source_remove(dev->watch);
+		dev->watch = 0;
+	}
+
+	if (dev->io) {
+		g_io_channel_unref(dev->io);
+		dev->io = NULL;
+	}
+
+	peers = g_slist_remove(peers, dev);
+	g_free(dev);
+	dev = NULL;
+}
+
+static void bt_pan_notify_conn_state(struct pan_device *dev, uint8_t state)
+{
+	struct hal_ev_pan_conn_state ev;
+	char addr[18];
+
+	if (dev->conn_state == state)
+		return;
+
+	dev->conn_state = state;
+	ba2str(&dev->dst, addr);
+	DBG("device %s state %u", addr, state);
+
+	bdaddr2android(&dev->dst, ev.bdaddr);
+	ev.state = state;
+	ev.local_role = local_role;
+	ev.remote_role = dev->role;
+	ev.status = HAL_STATUS_SUCCESS;
+
+	ipc_send_notif(HAL_SERVICE_ID_PAN, HAL_EV_PAN_CONN_STATE, sizeof(ev),
+									&ev);
+}
+
+static void bt_pan_notify_ctrl_state(struct pan_device *dev, uint8_t state)
+{
+	struct hal_ev_pan_ctrl_state ev;
+
+	DBG("");
+
+	ev.state = state;
+	ev.local_role = local_role;
+	ev.status = HAL_STATUS_SUCCESS;
+	memcpy(ev.name, dev->dev, sizeof(dev->dev));
+
+	ipc_send_notif(HAL_SERVICE_ID_PAN, HAL_EV_PAN_CTRL_STATE, sizeof(ev),
+									&ev);
+}
+
+static gboolean bnep_watchdog_cb(GIOChannel *chan, GIOCondition cond,
+								gpointer data)
+{
+	struct pan_device *dev = data;
+
+	DBG("%s disconnected", dev->dev);
+
+	bt_pan_notify_conn_state(dev, HAL_PAN_STATE_DISCONNECTED);
+	pan_device_free(dev);
+
+	return FALSE;
+}
+
+static void bnep_conn_cb(GIOChannel *chan, char *iface, int err, void *data)
+{
+	struct pan_device *dev = data;
+
+	DBG("");
+
+	if (err < 0) {
+		error("bnep connect req failed: %s", strerror(-err));
+		bt_pan_notify_conn_state(dev, HAL_PAN_STATE_DISCONNECTED);
+		pan_device_free(dev);
+		return;
+	}
+
+	memcpy(dev->dev, iface, sizeof(dev->dev));
+
+	DBG("%s connected", dev->dev);
+
+	bt_pan_notify_ctrl_state(dev, HAL_PAN_CTRL_ENABLED);
+	bt_pan_notify_conn_state(dev, HAL_PAN_STATE_CONNECTED);
+
+	dev->watch = g_io_add_watch(chan, G_IO_ERR | G_IO_HUP | G_IO_NVAL,
+							bnep_watchdog_cb, dev);
+	g_io_channel_unref(dev->io);
+	dev->io = NULL;
+}
+
+static void connect_cb(GIOChannel *chan, GError *err, gpointer data)
+{
+	struct pan_device *dev = data;
+	uint16_t src, dst;
+	int perr, sk;
+
+	DBG("");
+
+	if (err) {
+		error("%s", err->message);
+		bt_pan_notify_conn_state(dev, HAL_PAN_STATE_DISCONNECTED);
+		pan_device_free(dev);
+	}
+
+	src = (local_role == HAL_PAN_ROLE_NAP) ? BNEP_SVC_NAP : BNEP_SVC_PANU;
+	dst = (dev->role == HAL_PAN_ROLE_NAP) ? BNEP_SVC_NAP : BNEP_SVC_PANU;
+	sk = g_io_channel_unix_get_fd(dev->io);
+
+	perr = bnep_connect(sk, src, dst, bnep_conn_cb, dev);
+	if (perr < 0) {
+		error("bnep connect req failed: %s", strerror(-perr));
+		bt_pan_notify_conn_state(dev, HAL_PAN_STATE_DISCONNECTED);
+		pan_device_free(dev);
+		return;
+	}
+}
+
+static uint8_t bt_pan_connect(struct hal_cmd_pan_connect *cmd, uint16_t len)
+{
+	struct pan_device *dev;
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
+	dev = g_new0(struct pan_device, 1);
+	bacpy(&dev->dst, &dst);
+	local_role = cmd->local_role;
+	dev->role = cmd->remote_role;
+
+	ba2str(&dev->dst, addr);
+	DBG("connecting to %s %s", addr, dev->dev);
+
+	dev->io = bt_io_connect(connect_cb, dev, NULL, &gerr,
+					BT_IO_OPT_SOURCE_BDADDR, &adapter_addr,
+					BT_IO_OPT_DEST_BDADDR, &dev->dst,
+					BT_IO_OPT_PSM, BNEP_PSM,
+					BT_IO_OPT_SEC_LEVEL, BT_IO_SEC_MEDIUM,
+					BT_IO_OPT_OMTU, BNEP_MTU,
+					BT_IO_OPT_IMTU, BNEP_MTU,
+					BT_IO_OPT_INVALID);
+	if (!dev->io) {
+		error("%s", gerr->message);
+		g_error_free(gerr);
+		g_free(dev);
+		return HAL_STATUS_FAILED;
+	}
+
+	peers = g_slist_append(peers, dev);
+	bt_pan_notify_conn_state(dev, HAL_PAN_STATE_CONNECTING);
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
 
@@ -91,12 +284,24 @@ void bt_pan_handle_cmd(int sk, uint8_t opcode, void *buf, uint16_t len)
 
 bool bt_pan_register(const bdaddr_t *addr)
 {
+	int err;
+
 	DBG("");
 
+	bacpy(&adapter_addr, addr);
+
+	err = bnep_init();
+	if (err) {
+		error("bnep init failed");
+		return false;
+	}
+
 	return true;
 }
 
 void bt_pan_unregister(void)
 {
 	DBG("");
+
+	bnep_cleanup();
 }
-- 
1.8.3.2

