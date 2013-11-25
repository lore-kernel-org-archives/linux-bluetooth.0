Return-Path: <cyrus@holtmann.org>
From: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
Subject: [PATCH 2/4] android/pan: Implement pan connect method in daemon
Date: Mon, 25 Nov 2013 15:49:27 +0200
Message-Id: <1385387369-3015-3-git-send-email-ravikumar.veeramally@linux.intel.com>
In-Reply-To: <1385387369-3015-1-git-send-email-ravikumar.veeramally@linux.intel.com>
References: <1385387369-3015-1-git-send-email-ravikumar.veeramally@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Implements the PAN connect method in android daemon with PANU role
only. Setting up the bnep environment, adds connection and makes
bnep interface up. Notifies bnep interface on control state call back
and connection status on connection state call back.
---
 android/Android.mk  |   2 +
 android/Makefile.am |   3 +-
 android/pan.c       | 289 +++++++++++++++++++++++++++++++++++++++++++++++++++-
 3 files changed, 291 insertions(+), 3 deletions(-)

diff --git a/android/Android.mk b/android/Android.mk
index 616a338..4555284 100644
--- a/android/Android.mk
+++ b/android/Android.mk
@@ -41,6 +41,7 @@ LOCAL_SRC_FILES := \
 	../lib/hci.c \
 	../btio/btio.c \
 	../src/sdp-client.c \
+	../profiles/network/common.c \
 
 LOCAL_C_INCLUDES := \
 	$(call include-path-for, glib) \
@@ -65,6 +66,7 @@ lib_headers := \
 	sdp.h \
 	rfcomm.h \
 	sco.h \
+	bnep.h \
 
 $(shell mkdir -p $(LOCAL_PATH)/../lib/bluetooth)
 
diff --git a/android/Makefile.am b/android/Makefile.am
index 5f6b1a3..5d13434 100644
--- a/android/Makefile.am
+++ b/android/Makefile.am
@@ -23,7 +23,8 @@ android_bluetoothd_SOURCES = android/main.c \
 				android/socket.h android/socket.c \
 				android/pan.h android/pan.c \
 				btio/btio.h btio/btio.c \
-				src/sdp-client.h src/sdp-client.c
+				src/sdp-client.h src/sdp-client.c \
+				profiles/network/common.c profiles/network/common.h
 
 android_bluetoothd_LDADD = lib/libbluetooth-internal.la @GLIB_LIBS@
 
diff --git a/android/pan.c b/android/pan.c
index ada458a..b1d0e15 100644
--- a/android/pan.c
+++ b/android/pan.c
@@ -29,13 +29,246 @@
 #include <fcntl.h>
 #include <glib.h>
 
+#include "btio/btio.h"
 #include "lib/bluetooth.h"
+#include "lib/bnep.h"
+#include "lib/sdp.h"
+#include "lib/sdp_lib.h"
+#include "src/glib-helper.h"
+#include "profiles/network/common.h"
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
+
+struct network_peer {
+	char		dev[16];
+	bdaddr_t	dst;
+	uint8_t		conn_state;
+	uint8_t		role;
+	GIOChannel	*io;
+	guint		watch;
+};
+
+struct __service_16 {
+	 uint16_t dst;
+	uint16_t src;
+} __attribute__ ((packed));
+
+static int peer_cmp(gconstpointer s, gconstpointer user_data)
+{
+	const struct network_peer *np = s;
+	const bdaddr_t *dst = user_data;
+
+	return bacmp(&np->dst, dst);
+}
+
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
+	bnep_if_down(np->dev);
+	bt_pan_notify_conn_state(np, HAL_PAN_STATE_DISCONNECTED);
+	network_peer_free(np);
+
+	return FALSE;
+}
+
+static gboolean bnep_setup_cb(GIOChannel *chan, GIOCondition cond,
+								gpointer data)
+{
+	struct network_peer *np = data;
+	struct bnep_control_rsp *rsp;
+	struct timeval timeo;
+	char pkt[BNEP_MTU];
+	uint16_t bnep_role;
+	ssize_t r;
+	int sk;
+
+	DBG("cond %u", cond);
+
+	if (cond & (G_IO_HUP | G_IO_ERR | G_IO_NVAL)) {
+		error("Hangup or error ir invalid on l2cap server socket");
+		goto failed;
+	}
+
+	sk = g_io_channel_unix_get_fd(chan);
+	memset(pkt, 0, BNEP_MTU);
+
+	r = read(sk, pkt, sizeof(pkt) - 1);
+	if (r < 0) {
+		error("IO Channel read error");
+		goto failed;
+	}
+
+	if (r == 0) {
+		error("No packet received on l2cap socket");
+		goto failed;
+	}
+
+	errno = EPROTO;
+
+	if ((size_t) r < sizeof(*rsp)) {
+		error("Packet received is not bnep type");
+		goto failed;
+	}
+
+	rsp = (void *) pkt;
+	if (rsp->type != BNEP_CONTROL) {
+		error("Packet received is not bnep type");
+		goto failed;
+	}
+
+	if (rsp->ctrl != BNEP_SETUP_CONN_RSP) {
+		DBG("rsp->ctrl != BNEP_SETUP_CONN_RSP");
+		return TRUE;
+	}
+
+	r = ntohs(rsp->resp);
+
+	if (r != BNEP_SUCCESS) {
+		error("bnep failed");
+		goto failed;
+	}
+
+	memset(&timeo, 0, sizeof(timeo));
+	timeo.tv_sec = 0;
+
+	setsockopt(sk, SOL_SOCKET, SO_RCVTIMEO, &timeo, sizeof(timeo));
+	bnep_role = (local_role == HAL_PAN_ROLE_PANU) ? BNEP_SVC_PANU :
+								BNEP_SVC_NAP;
+
+	if (bnep_connadd(sk, bnep_role, np->dev))
+		goto failed;
+
+	if (bnep_if_up(np->dev)) {
+		bnep_kill_connection(&np->dst);
+		goto failed;
+	}
+
+	bt_pan_notify_ctrl_state(np, HAL_PAN_CTRL_ENABLED);
+	bt_pan_notify_conn_state(np, HAL_PAN_STATE_CONNECTED);
+
+	DBG("%s connected", np->dev);
+
+	/* Start watchdog */
+	np->watch = g_io_add_watch(chan, G_IO_ERR | G_IO_HUP | G_IO_NVAL,
+						(GIOFunc) bnep_watchdog_cb, np);
+	g_io_channel_unref(np->io);
+	np->io = NULL;
+
+	return FALSE;
+
+failed:
+	bt_pan_notify_conn_state(np, HAL_PAN_STATE_DISCONNECTED);
+	network_peer_free(np);
+	return FALSE;
+}
+
+static void connect_cb(GIOChannel *chan, GError *err, gpointer data)
+{
+	struct network_peer *np = data;
+	struct bnep_setup_conn_req *req;
+	struct __service_16 *s;
+	unsigned char pkt[BNEP_MTU];
+	int fd;
+
+	DBG("");
+
+	if (err) {
+		error("%s", err->message);
+		bt_pan_notify_conn_state(np, HAL_PAN_STATE_DISCONNECTED);
+		network_peer_free(np);
+	}
+
+	/* Send request */
+	req = (void *) pkt;
+	req->type = BNEP_CONTROL;
+	req->ctrl = BNEP_SETUP_CONN_REQ;
+	req->uuid_size = 2;     /* 16bit UUID */
+	s = (void *) req->service;
+	s->dst = (np->role == HAL_PAN_ROLE_NAP) ? htons(BNEP_SVC_NAP) :
+							htons(BNEP_SVC_PANU);
+	s->src = (local_role == HAL_PAN_ROLE_NAP) ? htons(BNEP_SVC_NAP) :
+							htons(BNEP_SVC_PANU);
+
+	fd = g_io_channel_unix_get_fd(np->io);
+	if (write(fd, pkt, sizeof(*req) + sizeof(*s)) < 0) {
+		error("bnep connection req send failed: %s", strerror(errno));
+		bt_pan_notify_conn_state(np, HAL_PAN_STATE_DISCONNECTED);
+		network_peer_free(np);
+		return;
+	}
+
+	g_io_add_watch(np->io, G_IO_IN | G_IO_ERR | G_IO_HUP | G_IO_NVAL,
+							bnep_setup_cb, np);
+}
 
 static uint8_t bt_pan_enable(struct hal_cmd_pan_enable *cmd, uint16_t len)
 {
@@ -53,9 +286,50 @@ static uint8_t bt_pan_get_role(void *cmd, uint16_t len)
 
 static uint8_t bt_pan_connect(struct hal_cmd_pan_connect *cmd, uint16_t len)
 {
-	DBG("Not Implemented");
+	struct network_peer *np;
+	bdaddr_t dst;
+	char addr[18];
+	GSList *l;
+	GError *gerr = NULL;
 
-	return HAL_STATUS_FAILED;
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
+	DBG("connecting to %s", addr);
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
 }
 
 static uint8_t bt_pan_disconnect(struct hal_cmd_pan_disconnect *cmd,
@@ -93,11 +367,21 @@ void bt_pan_handle_cmd(int sk, uint8_t opcode, void *buf, uint16_t len)
 
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
@@ -111,4 +395,5 @@ void bt_pan_unregister(void)
 		return;
 
 	notification_sk = -1;
+	bnep_cleanup();
 }
-- 
1.8.3.2

