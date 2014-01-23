Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 2/8] android/AVCTP: Strip dependencies
Date: Thu, 23 Jan 2014 18:39:52 +0200
Message-Id: <1390495198-28400-2-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1390495198-28400-1-git-send-email-luiz.dentz@gmail.com>
References: <1390495198-28400-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This strips AVCTP code of any dependency of core and btio to make it
transport agnostic.
---
 android/Android.mk  |   1 +
 android/Makefile.am |   1 +
 android/avctp.c     | 793 ++++++++--------------------------------------------
 android/avctp.h     |  40 +--
 4 files changed, 134 insertions(+), 701 deletions(-)

diff --git a/android/Android.mk b/android/Android.mk
index 43e6036..b43119e 100644
--- a/android/Android.mk
+++ b/android/Android.mk
@@ -28,6 +28,7 @@ LOCAL_SRC_FILES := \
 	bluez/android/audio-ipc.c \
 	bluez/android/avdtp.c \
 	bluez/android/a2dp.c \
+	bluez/android/avctp.c \
 	bluez/android/pan.c \
 	bluez/src/log.c \
 	bluez/src/shared/mgmt.c \
diff --git a/android/Makefile.am b/android/Makefile.am
index 910beb5..41694ee 100644
--- a/android/Makefile.am
+++ b/android/Makefile.am
@@ -33,6 +33,7 @@ android_bluetoothd_SOURCES = android/main.c \
 				android/audio-ipc.h android/audio-ipc.c \
 				android/avdtp.h android/avdtp.c \
 				android/a2dp.h android/a2dp.c \
+				android/avctp.h android/avctp.c \
 				android/socket.h android/socket.c \
 				android/pan.h android/pan.c \
 				btio/btio.h btio/btio.c \
diff --git a/android/avctp.c b/android/avctp.c
index 6669ddc..a31dcc6 100644
--- a/android/avctp.c
+++ b/android/avctp.c
@@ -34,27 +34,20 @@
 #include <unistd.h>
 #include <assert.h>
 #include <signal.h>
+#include <string.h>
 #include <sys/types.h>
 #include <sys/stat.h>
 #include <fcntl.h>
 #include <netinet/in.h>
 
-#include <bluetooth/bluetooth.h>
 #include <bluetooth/sdp.h>
-#include <bluetooth/l2cap.h>
 
 #include <glib.h>
-#include <btio/btio.h>
-
-#include "lib/uuid.h"
-#include "src/adapter.h"
-#include "src/device.h"
 
 #include "log.h"
 #include "error.h"
 #include "uinput.h"
 #include "avctp.h"
-#include "avrcp.h"
 
 /* AV/C Panel 1.23, page 76:
  * command with the pressed value is valid for two seconds
@@ -115,20 +108,6 @@ struct avc_header {
 #error "Unknown byte order"
 #endif
 
-struct avctp_state_callback {
-	avctp_state_cb cb;
-	struct btd_device *dev;
-	unsigned int id;
-	void *user_data;
-};
-
-struct avctp_server {
-	struct btd_adapter *adapter;
-	GIOChannel *control_io;
-	GIOChannel *browsing_io;
-	GSList *sessions;
-};
-
 struct avctp_control_req {
 	struct avctp_pending_req *p;
 	uint8_t code;
@@ -157,7 +136,7 @@ struct avctp_pending_req {
 	int err;
 	avctp_process_cb process;
 	void *data;
-	GDestroyNotify destroy;
+	avctp_destroy_cb_t destroy;
 };
 
 struct avctp_channel {
@@ -173,7 +152,7 @@ struct avctp_channel {
 	GQueue *queue;
 	GSList *processed;
 	guint process_id;
-	GDestroyNotify destroy;
+	avctp_destroy_cb_t destroy;
 };
 
 struct key_pressed {
@@ -182,14 +161,8 @@ struct key_pressed {
 };
 
 struct avctp {
-	struct avctp_server *server;
-	struct btd_device *device;
-
-	avctp_state_t state;
-
 	int uinput;
 
-	guint auth_id;
 	unsigned int passthrough_id;
 	unsigned int unit_id;
 	unsigned int subunit_id;
@@ -201,7 +174,7 @@ struct avctp {
 
 	uint8_t key_quirks[256];
 	struct key_pressed key;
-	bool initiator;
+	uint16_t version;
 };
 
 struct avctp_passthrough_handler {
@@ -221,7 +194,7 @@ struct avctp_browsing_pdu_handler {
 	avctp_browsing_pdu_cb cb;
 	void *user_data;
 	unsigned int id;
-	GDestroyNotify destroy;
+	avctp_destroy_cb_t destroy;
 };
 
 static struct {
@@ -259,10 +232,6 @@ static struct {
 	{ NULL }
 };
 
-static GSList *callbacks = NULL;
-static GSList *servers = NULL;
-
-static void auth_cb(DBusError *derr, void *user_data);
 static gboolean process_queue(gpointer user_data);
 static gboolean avctp_passthrough_rsp(struct avctp *session, uint8_t code,
 					uint8_t subunit, uint8_t *operands,
@@ -488,83 +457,6 @@ static void avctp_channel_destroy(struct avctp_channel *chan)
 	g_free(chan);
 }
 
-static void avctp_disconnected(struct avctp *session)
-{
-	struct avctp_server *server;
-
-	if (!session)
-		return;
-
-	if (session->browsing)
-		avctp_channel_destroy(session->browsing);
-
-	if (session->control)
-		avctp_channel_destroy(session->control);
-
-	if (session->auth_id != 0) {
-		btd_cancel_authorization(session->auth_id);
-		session->auth_id = 0;
-	}
-
-	if (session->key.timer > 0)
-		g_source_remove(session->key.timer);
-
-	if (session->uinput >= 0) {
-		char address[18];
-
-		ba2str(device_get_address(session->device), address);
-		DBG("AVCTP: closing uinput for %s", address);
-
-		ioctl(session->uinput, UI_DEV_DESTROY);
-		close(session->uinput);
-		session->uinput = -1;
-	}
-
-	server = session->server;
-	server->sessions = g_slist_remove(server->sessions, session);
-	btd_device_unref(session->device);
-	g_free(session);
-}
-
-static void avctp_set_state(struct avctp *session, avctp_state_t new_state)
-{
-	GSList *l;
-	avctp_state_t old_state = session->state;
-
-	session->state = new_state;
-
-	for (l = callbacks; l != NULL; l = l->next) {
-		struct avctp_state_callback *cb = l->data;
-
-		if (cb->dev && cb->dev != session->device)
-			continue;
-
-		cb->cb(session->device, old_state, new_state, cb->user_data);
-	}
-
-	switch (new_state) {
-	case AVCTP_STATE_DISCONNECTED:
-		DBG("AVCTP Disconnected");
-		avctp_disconnected(session);
-		break;
-	case AVCTP_STATE_CONNECTING:
-		DBG("AVCTP Connecting");
-		break;
-	case AVCTP_STATE_CONNECTED:
-		DBG("AVCTP Connected");
-		break;
-	case AVCTP_STATE_BROWSING_CONNECTING:
-		DBG("AVCTP Browsing Connecting");
-		break;
-	case AVCTP_STATE_BROWSING_CONNECTED:
-		DBG("AVCTP Browsing Connected");
-		break;
-	default:
-		error("Invalid AVCTP state %d", new_state);
-		return;
-	}
-}
-
 static int avctp_send(struct avctp_channel *control, uint8_t transaction,
 				uint8_t cr, uint8_t code,
 				uint8_t subunit, uint8_t opcode,
@@ -874,7 +766,8 @@ static gboolean session_browsing_cb(GIOChannel *chan, GIOCondition cond,
 	handler = g_slist_nth_data(browsing->handlers, 0);
 	if (handler == NULL) {
 		DBG("handler not found");
-		packet_size += avrcp_browsing_general_reject(operands);
+		/* FIXME: Add general reject */
+		/* packet_size += avrcp_browsing_general_reject(operands); */
 		goto send;
 	}
 
@@ -893,7 +786,6 @@ send:
 
 failed:
 	DBG("AVCTP Browsing: disconnected");
-	avctp_set_state(session, AVCTP_STATE_CONNECTED);
 
 	if (session->browsing) {
 		avctp_channel_destroy(session->browsing);
@@ -966,7 +858,9 @@ static gboolean session_cb(GIOChannel *chan, GIOCondition cond,
 	handler = find_handler(control->handlers, avc->opcode);
 	if (!handler) {
 		DBG("handler not found for 0x%02x", avc->opcode);
-		packet_size += avrcp_handle_vendor_reject(&code, operands);
+		/* FIXME:
+		 * packet_size += avrcp_handle_vendor_reject(&code, operands);
+		 */
 		avc->code = code;
 		goto done;
 	}
@@ -990,11 +884,11 @@ done:
 
 failed:
 	DBG("AVCTP session %p got disconnected", session);
-	avctp_set_state(session, AVCTP_STATE_DISCONNECTED);
+	avctp_shutdown(session);
 	return FALSE;
 }
 
-static int uinput_create(char *name)
+static int uinput_create(const char *name)
 {
 	struct uinput_dev dev;
 	int fd, err, i;
@@ -1049,11 +943,9 @@ static int uinput_create(char *name)
 	return fd;
 }
 
-static void init_uinput(struct avctp *session)
+int avctp_init_uinput(struct avctp *session, const char *name,
+							const char *address)
 {
-	char address[18], name[248 + 1];
-
-	device_get_name(session->device, name, sizeof(name));
 	if (g_str_equal(name, "Nokia CK-20W")) {
 		session->key_quirks[AVC_FORWARD] |= QUIRK_NO_RELEASE;
 		session->key_quirks[AVC_BACKWARD] |= QUIRK_NO_RELEASE;
@@ -1061,24 +953,28 @@ static void init_uinput(struct avctp *session)
 		session->key_quirks[AVC_PAUSE] |= QUIRK_NO_RELEASE;
 	}
 
-	ba2str(device_get_address(session->device), address);
 	session->uinput = uinput_create(address);
-	if (session->uinput < 0)
-		error("AVRCP: failed to init uinput for %s", address);
-	else
-		DBG("AVRCP: uinput initialized for %s", address);
+	if (session->uinput < 0) {
+		error("AVCTP: failed to init uinput for %s", address);
+		return session->uinput;
+	}
+
+	return 0;
 }
 
-static struct avctp_channel *avctp_channel_create(struct avctp *session,
-							GIOChannel *io,
-							GDestroyNotify destroy)
+static struct avctp_channel *avctp_channel_create(struct avctp *session, int fd,
+						size_t imtu, size_t omtu,
+						avctp_destroy_cb_t destroy)
 {
 	struct avctp_channel *chan;
 
 	chan = g_new0(struct avctp_channel, 1);
 	chan->session = session;
-	chan->io = g_io_channel_ref(io);
+	chan->io = g_io_channel_unix_new(fd);
 	chan->queue = g_queue_new();
+	chan->imtu = imtu;
+	chan->omtu = omtu;
+	chan->buffer = g_malloc0(MAX(imtu, omtu));
 	chan->destroy = destroy;
 
 	return chan;
@@ -1103,381 +999,10 @@ static void avctp_destroy_browsing(void *data)
 	chan->handlers = NULL;
 }
 
-static void avctp_connect_browsing_cb(GIOChannel *chan, GError *err,
-							gpointer data)
-{
-	struct avctp *session = data;
-	struct avctp_channel *browsing = session->browsing;
-	char address[18];
-	uint16_t imtu, omtu;
-	GError *gerr = NULL;
-
-	if (err) {
-		error("Browsing: %s", err->message);
-		goto fail;
-	}
-
-	bt_io_get(chan, &gerr,
-			BT_IO_OPT_DEST, &address,
-			BT_IO_OPT_IMTU, &imtu,
-			BT_IO_OPT_OMTU, &omtu,
-			BT_IO_OPT_INVALID);
-	if (gerr) {
-		error("%s", gerr->message);
-		g_io_channel_shutdown(chan, TRUE, NULL);
-		g_io_channel_unref(chan);
-		g_error_free(gerr);
-		goto fail;
-	}
-
-	DBG("AVCTP Browsing: connected to %s", address);
-
-	if (browsing == NULL) {
-		browsing = avctp_channel_create(session, chan,
-						avctp_destroy_browsing);
-		session->browsing = browsing;
-	}
-
-	browsing->imtu = imtu;
-	browsing->omtu = omtu;
-	browsing->buffer = g_malloc0(MAX(imtu, omtu));
-	browsing->watch = g_io_add_watch(session->browsing->io,
-				G_IO_IN | G_IO_ERR | G_IO_HUP | G_IO_NVAL,
-				(GIOFunc) session_browsing_cb, session);
-
-	avctp_set_state(session, AVCTP_STATE_BROWSING_CONNECTED);
-
-	/* Process any request that was pending the connection to complete */
-	if (browsing->process_id == 0 && !g_queue_is_empty(browsing->queue))
-		browsing->process_id = g_idle_add(process_queue, browsing);
-
-	return;
-
-fail:
-	avctp_set_state(session, AVCTP_STATE_CONNECTED);
-
-	if (session->browsing) {
-		avctp_channel_destroy(session->browsing);
-		session->browsing = NULL;
-	}
-}
-
-static void avctp_connect_cb(GIOChannel *chan, GError *err, gpointer data)
-{
-	struct avctp *session = data;
-	char address[18];
-	uint16_t imtu, omtu;
-	GError *gerr = NULL;
-
-	if (err) {
-		avctp_set_state(session, AVCTP_STATE_DISCONNECTED);
-		error("%s", err->message);
-		return;
-	}
-
-	bt_io_get(chan, &gerr,
-			BT_IO_OPT_DEST, &address,
-			BT_IO_OPT_IMTU, &imtu,
-			BT_IO_OPT_IMTU, &omtu,
-			BT_IO_OPT_INVALID);
-	if (gerr) {
-		avctp_set_state(session, AVCTP_STATE_DISCONNECTED);
-		error("%s", gerr->message);
-		g_error_free(gerr);
-		return;
-	}
-
-	DBG("AVCTP: connected to %s", address);
-
-	if (session->control == NULL)
-		session->control = avctp_channel_create(session, chan, NULL);
-
-	session->control->imtu = imtu;
-	session->control->omtu = omtu;
-	session->control->buffer = g_malloc0(MAX(imtu, omtu));
-	session->control->watch = g_io_add_watch(session->control->io,
-				G_IO_IN | G_IO_ERR | G_IO_HUP | G_IO_NVAL,
-				(GIOFunc) session_cb, session);
-
-	session->passthrough_id = avctp_register_pdu_handler(session,
-						AVC_OP_PASSTHROUGH,
-						handle_panel_passthrough,
-						NULL);
-	session->unit_id = avctp_register_pdu_handler(session,
-						AVC_OP_UNITINFO,
-						handle_unit_info,
-						NULL);
-	session->subunit_id = avctp_register_pdu_handler(session,
-						AVC_OP_SUBUNITINFO,
-						handle_subunit_info,
-						NULL);
-
-	init_uinput(session);
-
-	avctp_set_state(session, AVCTP_STATE_CONNECTED);
-}
-
-static void auth_cb(DBusError *derr, void *user_data)
-{
-	struct avctp *session = user_data;
-	GError *err = NULL;
-
-	session->auth_id = 0;
-
-	if (session->control->watch > 0) {
-		g_source_remove(session->control->watch);
-		session->control->watch = 0;
-	}
-
-	if (derr && dbus_error_is_set(derr)) {
-		error("Access denied: %s", derr->message);
-		avctp_set_state(session, AVCTP_STATE_DISCONNECTED);
-		return;
-	}
-
-	if (!bt_io_accept(session->control->io, avctp_connect_cb, session,
-								NULL, &err)) {
-		error("bt_io_accept: %s", err->message);
-		g_error_free(err);
-		avctp_set_state(session, AVCTP_STATE_DISCONNECTED);
-	}
-}
-
-static struct avctp_server *find_server(GSList *list, struct btd_adapter *a)
-{
-	for (; list; list = list->next) {
-		struct avctp_server *server = list->data;
-
-		if (server->adapter == a)
-			return server;
-	}
-
-	return NULL;
-}
-
-static struct avctp *find_session(GSList *list, struct btd_device *device)
-{
-	for (; list != NULL; list = g_slist_next(list)) {
-		struct avctp *s = list->data;
-
-		if (s->device == device)
-			return s;
-	}
-
-	return NULL;
-}
-
-static struct avctp *avctp_get_internal(struct btd_device *device)
-{
-	struct avctp_server *server;
-	struct avctp *session;
-
-	server = find_server(servers, device_get_adapter(device));
-	if (server == NULL)
-		return NULL;
-
-	session = find_session(server->sessions, device);
-	if (session)
-		return session;
-
-	session = g_new0(struct avctp, 1);
-
-	session->server = server;
-	session->device = btd_device_ref(device);
-	session->state = AVCTP_STATE_DISCONNECTED;
-	session->uinput = -1;
-
-	server->sessions = g_slist_append(server->sessions, session);
-
-	return session;
-}
-
-static void avctp_control_confirm(struct avctp *session, GIOChannel *chan,
-						struct btd_device *dev)
-{
-	const bdaddr_t *src;
-	const bdaddr_t *dst;
-
-	if (session->control != NULL) {
-		error("Control: Refusing unexpected connect");
-		g_io_channel_shutdown(chan, TRUE, NULL);
-		return;
-	}
-
-	avctp_set_state(session, AVCTP_STATE_CONNECTING);
-	session->control = avctp_channel_create(session, chan, NULL);
-
-	src = btd_adapter_get_address(device_get_adapter(dev));
-	dst = device_get_address(dev);
-
-	session->auth_id = btd_request_authorization(src, dst,
-							AVRCP_REMOTE_UUID,
-							auth_cb, session);
-	if (session->auth_id == 0)
-		goto drop;
-
-	session->control->watch = g_io_add_watch(chan, G_IO_ERR | G_IO_HUP |
-						G_IO_NVAL, session_cb, session);
-	return;
-
-drop:
-	avctp_set_state(session, AVCTP_STATE_DISCONNECTED);
-}
-
-static void avctp_browsing_confirm(struct avctp *session, GIOChannel *chan,
-						struct btd_device *dev)
-{
-	GError *err = NULL;
-
-	if (session->control == NULL || session->browsing != NULL) {
-		error("Browsing: Refusing unexpected connect");
-		g_io_channel_shutdown(chan, TRUE, NULL);
-		return;
-	}
-
-	if (bt_io_accept(chan, avctp_connect_browsing_cb, session, NULL,
-								&err)) {
-		avctp_set_state(session, AVCTP_STATE_BROWSING_CONNECTING);
-		return;
-	}
-
-	error("Browsing: %s", err->message);
-	g_error_free(err);
-
-	return;
-}
-
-static void avctp_confirm_cb(GIOChannel *chan, gpointer data)
-{
-	struct avctp *session;
-	char address[18];
-	bdaddr_t src, dst;
-	GError *err = NULL;
-	uint16_t psm;
-	struct btd_device *device;
-
-	bt_io_get(chan, &err,
-			BT_IO_OPT_SOURCE_BDADDR, &src,
-			BT_IO_OPT_DEST_BDADDR, &dst,
-			BT_IO_OPT_DEST, address,
-			BT_IO_OPT_PSM, &psm,
-			BT_IO_OPT_INVALID);
-	if (err) {
-		error("%s", err->message);
-		g_error_free(err);
-		g_io_channel_shutdown(chan, TRUE, NULL);
-		return;
-	}
-
-	DBG("AVCTP: incoming connect from %s", address);
-
-	device = btd_adapter_find_device(adapter_find(&src), &dst);
-	if (!device)
-		return;
-
-	session = avctp_get_internal(device);
-	if (session == NULL)
-		return;
-
-	if (btd_device_get_service(device, AVRCP_REMOTE_UUID) == NULL)
-		btd_device_add_uuid(device, AVRCP_REMOTE_UUID);
-
-	if (btd_device_get_service(device, AVRCP_TARGET_UUID) == NULL)
-		btd_device_add_uuid(device, AVRCP_TARGET_UUID);
-
-	switch (psm) {
-	case AVCTP_CONTROL_PSM:
-		avctp_control_confirm(session, chan, device);
-		break;
-	case AVCTP_BROWSING_PSM:
-		avctp_browsing_confirm(session, chan, device);
-		break;
-	}
-
-	return;
-}
-
-static GIOChannel *avctp_server_socket(const bdaddr_t *src, gboolean master,
-						uint8_t mode, uint16_t psm)
-{
-	GError *err = NULL;
-	GIOChannel *io;
-
-	io = bt_io_listen(NULL, avctp_confirm_cb, NULL,
-				NULL, &err,
-				BT_IO_OPT_SOURCE_BDADDR, src,
-				BT_IO_OPT_PSM, psm,
-				BT_IO_OPT_SEC_LEVEL, BT_IO_SEC_MEDIUM,
-				BT_IO_OPT_MASTER, master,
-				BT_IO_OPT_MODE, mode,
-				BT_IO_OPT_INVALID);
-	if (!io) {
-		error("%s", err->message);
-		g_error_free(err);
-	}
-
-	return io;
-}
-
-int avctp_register(struct btd_adapter *adapter, gboolean master)
-{
-	struct avctp_server *server;
-	const bdaddr_t *src = btd_adapter_get_address(adapter);
-
-	server = g_new0(struct avctp_server, 1);
-
-	server->control_io = avctp_server_socket(src, master, L2CAP_MODE_BASIC,
-							AVCTP_CONTROL_PSM);
-	if (!server->control_io) {
-		g_free(server);
-		return -1;
-	}
-	server->browsing_io = avctp_server_socket(src, master, L2CAP_MODE_ERTM,
-							AVCTP_BROWSING_PSM);
-	if (!server->browsing_io) {
-		if (server->control_io) {
-			g_io_channel_shutdown(server->control_io, TRUE, NULL);
-			g_io_channel_unref(server->control_io);
-			server->control_io = NULL;
-		}
-		g_free(server);
-		return -1;
-	}
-
-	server->adapter = btd_adapter_ref(adapter);
-
-	servers = g_slist_append(servers, server);
-
-	return 0;
-}
-
-void avctp_unregister(struct btd_adapter *adapter)
-{
-	struct avctp_server *server;
-
-	server = find_server(servers, adapter);
-	if (!server)
-		return;
-
-	while (server->sessions)
-		avctp_disconnected(server->sessions->data);
-
-	servers = g_slist_remove(servers, server);
-
-	g_io_channel_shutdown(server->browsing_io, TRUE, NULL);
-	g_io_channel_unref(server->browsing_io);
-	server->browsing_io = NULL;
-
-	g_io_channel_shutdown(server->control_io, TRUE, NULL);
-	g_io_channel_unref(server->control_io);
-	btd_adapter_unref(server->adapter);
-	g_free(server);
-}
-
 static struct avctp_pending_req *pending_create(struct avctp_channel *chan,
 						avctp_process_cb process,
 						void *data,
-						GDestroyNotify destroy)
+						avctp_destroy_cb_t destroy)
 {
 	struct avctp_pending_req *p;
 	GSList *l, *tmp;
@@ -1732,39 +1257,6 @@ int avctp_send_vendordep_req(struct avctp *session, uint8_t code,
 						func, user_data);
 }
 
-unsigned int avctp_add_state_cb(struct btd_device *dev, avctp_state_cb cb,
-							void *user_data)
-{
-	struct avctp_state_callback *state_cb;
-	static unsigned int id = 0;
-
-	state_cb = g_new(struct avctp_state_callback, 1);
-	state_cb->cb = cb;
-	state_cb->dev = dev;
-	state_cb->id = ++id;
-	state_cb->user_data = user_data;
-
-	callbacks = g_slist_append(callbacks, state_cb);
-
-	return state_cb->id;
-}
-
-gboolean avctp_remove_state_cb(unsigned int id)
-{
-	GSList *l;
-
-	for (l = callbacks; l != NULL; l = l->next) {
-		struct avctp_state_callback *cb = l->data;
-		if (cb && cb->id == id) {
-			callbacks = g_slist_remove(callbacks, cb);
-			g_free(cb);
-			return TRUE;
-		}
-	}
-
-	return FALSE;
-}
-
 unsigned int avctp_register_passthrough_handler(struct avctp *session,
 						avctp_passthrough_cb cb,
 						void *user_data)
@@ -1786,29 +1278,18 @@ unsigned int avctp_register_passthrough_handler(struct avctp *session,
 	return handler->id;
 }
 
-bool avctp_unregister_passthrough_handler(unsigned int id)
+bool avctp_unregister_passthrough_handler(struct avctp *session,
+							unsigned int id)
 {
-	GSList *l;
-
-	for (l = servers; l; l = l->next) {
-		struct avctp_server *server = l->data;
-		GSList *s;
+	if (session->handler == NULL)
+		return false;
 
-		for (s = server->sessions; s; s = s->next) {
-			struct avctp *session = s->data;
-
-			if (session->handler == NULL)
-				continue;
-
-			if (session->handler->id == id) {
-				g_free(session->handler);
-				session->handler = NULL;
-				return true;
-			}
-		}
-	}
+	if (session->handler->id != id)
+		return false;
 
-	return false;
+	g_free(session->handler);
+	session->handler = NULL;
+	return true;
 }
 
 unsigned int avctp_register_pdu_handler(struct avctp *session, uint8_t opcode,
@@ -1840,7 +1321,7 @@ unsigned int avctp_register_pdu_handler(struct avctp *session, uint8_t opcode,
 unsigned int avctp_register_browsing_pdu_handler(struct avctp *session,
 						avctp_browsing_pdu_cb cb,
 						void *user_data,
-						GDestroyNotify destroy)
+						avctp_destroy_cb_t destroy)
 {
 	struct avctp_channel *browsing = session->browsing;
 	struct avctp_browsing_pdu_handler *handler;
@@ -1863,165 +1344,129 @@ unsigned int avctp_register_browsing_pdu_handler(struct avctp *session,
 	return handler->id;
 }
 
-gboolean avctp_unregister_pdu_handler(unsigned int id)
+bool avctp_unregister_pdu_handler(struct avctp *session, unsigned int id)
 {
+	struct avctp_channel *control = session->control;
 	GSList *l;
 
-	for (l = servers; l; l = l->next) {
-		struct avctp_server *server = l->data;
-		GSList *s;
-
-		for (s = server->sessions; s; s = s->next) {
-			struct avctp *session = s->data;
-			struct avctp_channel *control = session->control;
-			GSList *h;
+	if (!control)
+		return false;
 
-			if (control == NULL)
-				continue;
+	for (l = control->handlers; l; l = g_slist_next(l)) {
+		struct avctp_pdu_handler *handler = l->data;
 
-			for (h = control->handlers; h; h = h->next) {
-				struct avctp_pdu_handler *handler = h->data;
-
-				if (handler->id != id)
-					continue;
+		if (handler->id != id)
+			continue;
 
-				control->handlers = g_slist_remove(
-							control->handlers,
-							handler);
-				g_free(handler);
-				return TRUE;
-			}
-		}
+		control->handlers = g_slist_remove(control->handlers, handler);
+		g_free(handler);
+		return true;
 	}
 
-	return FALSE;
+	return false;
 }
 
-gboolean avctp_unregister_browsing_pdu_handler(unsigned int id)
+bool avctp_unregister_browsing_pdu_handler(struct avctp *session,
+							unsigned int id)
 {
+	struct avctp_channel *browsing = session->browsing;
 	GSList *l;
 
-	for (l = servers; l; l = l->next) {
-		struct avctp_server *server = l->data;
-		GSList *s;
-
-		for (s = server->sessions; s; s = s->next) {
-			struct avctp *session = s->data;
-			struct avctp_channel *browsing = session->browsing;
-			GSList *h;
-
-			if (browsing == NULL)
-				continue;
+	if (browsing == NULL)
+		return false;
 
-			for (h = browsing->handlers; h; h = h->next) {
-				struct avctp_browsing_pdu_handler *handler =
-								h->data;
+	for (l = browsing->handlers; l; l = g_slist_next(l)) {
+		struct avctp_browsing_pdu_handler *handler = l->data;
 
-				if (handler->id != id)
-					continue;
+		if (handler->id != id)
+			continue;
 
-				browsing->handlers = g_slist_remove(
-							browsing->handlers,
-							handler);
-				g_free(handler);
-				return TRUE;
-			}
-		}
+		browsing->handlers = g_slist_remove(browsing->handlers,
+								handler);
+		g_free(handler);
+		return true;
 	}
 
-	return FALSE;
+	return false;
 }
 
-struct avctp *avctp_connect(struct btd_device *device)
+struct avctp *avctp_new(int fd, size_t imtu, size_t omtu, uint16_t version)
 {
 	struct avctp *session;
-	GError *err = NULL;
-	GIOChannel *io;
-	const bdaddr_t *src;
-
-	session = avctp_get_internal(device);
-	if (!session)
-		return NULL;
-
-	if (session->state > AVCTP_STATE_DISCONNECTED)
-		return session;
-
-	avctp_set_state(session, AVCTP_STATE_CONNECTING);
+	struct avctp_channel *control;
+	GIOCondition cond = G_IO_IN | G_IO_ERR | G_IO_HUP | G_IO_NVAL;
 
-	src = btd_adapter_get_address(session->server->adapter);
+	session = g_new0(struct avctp, 1);
+	session->version = version;
 
-	io = bt_io_connect(avctp_connect_cb, session, NULL, &err,
-				BT_IO_OPT_SOURCE_BDADDR, src,
-				BT_IO_OPT_DEST_BDADDR,
-				device_get_address(session->device),
-				BT_IO_OPT_SEC_LEVEL, BT_IO_SEC_MEDIUM,
-				BT_IO_OPT_PSM, AVCTP_CONTROL_PSM,
-				BT_IO_OPT_INVALID);
-	if (err) {
-		avctp_set_state(session, AVCTP_STATE_DISCONNECTED);
-		error("%s", err->message);
-		g_error_free(err);
+	control = avctp_channel_create(session, fd, imtu, omtu, NULL);
+	if (!control) {
+		g_free(session);
 		return NULL;
 	}
 
-	session->control = avctp_channel_create(session, io, NULL);
-	session->initiator = true;
-	g_io_channel_unref(io);
+	session->passthrough_id = avctp_register_pdu_handler(session,
+						AVC_OP_PASSTHROUGH,
+						handle_panel_passthrough,
+						NULL);
+	session->unit_id = avctp_register_pdu_handler(session,
+						AVC_OP_UNITINFO,
+						handle_unit_info,
+						NULL);
+	session->subunit_id = avctp_register_pdu_handler(session,
+						AVC_OP_SUBUNITINFO,
+						handle_subunit_info,
+						NULL);
+
+	session->control = control;
+	control->watch = g_io_add_watch(session->control->io, cond,
+						(GIOFunc) session_cb, session);
 
 	return session;
 }
 
-int avctp_connect_browsing(struct avctp *session)
+int avctp_connect_browsing(struct avctp *session, int fd, size_t imtu,
+								size_t omtu)
 {
-	const bdaddr_t *src;
-	GError *err = NULL;
-	GIOChannel *io;
-
-	if (session->state != AVCTP_STATE_CONNECTED)
-		return -ENOTCONN;
-
-	if (session->browsing != NULL)
-		return 0;
+	struct avctp_channel *browsing;
+	GIOCondition cond = G_IO_IN | G_IO_ERR | G_IO_HUP | G_IO_NVAL;
 
-	avctp_set_state(session, AVCTP_STATE_BROWSING_CONNECTING);
-
-	src = btd_adapter_get_address(session->server->adapter);
-
-	io = bt_io_connect(avctp_connect_browsing_cb, session, NULL, &err,
-				BT_IO_OPT_SOURCE_BDADDR, src,
-				BT_IO_OPT_DEST_BDADDR,
-				device_get_address(session->device),
-				BT_IO_OPT_SEC_LEVEL, BT_IO_SEC_MEDIUM,
-				BT_IO_OPT_PSM, AVCTP_BROWSING_PSM,
-				BT_IO_OPT_MODE, L2CAP_MODE_ERTM,
-				BT_IO_OPT_INVALID);
-	if (err) {
-		error("%s", err->message);
-		g_error_free(err);
-		return -EIO;
-	}
+	if (session->browsing)
+		return -EISCONN;
 
-	session->browsing = avctp_channel_create(session, io,
+	browsing = avctp_channel_create(session, fd, imtu, omtu,
 						avctp_destroy_browsing);
-	g_io_channel_unref(io);
+	if (!browsing)
+		return -EINVAL;
+
+	session->browsing = browsing;
+	browsing->watch = g_io_add_watch(session->browsing->io, cond,
+					(GIOFunc) session_browsing_cb, session);
 
 	return 0;
 }
 
-void avctp_disconnect(struct avctp *session)
+void avctp_shutdown(struct avctp *session)
 {
-	if (session->state == AVCTP_STATE_DISCONNECTED)
+	if (!session)
 		return;
 
-	avctp_set_state(session, AVCTP_STATE_DISCONNECTED);
-}
+	if (session->browsing)
+		avctp_channel_destroy(session->browsing);
 
-struct avctp *avctp_get(struct btd_device *device)
-{
-	return avctp_get_internal(device);
-}
+	if (session->control)
+		avctp_channel_destroy(session->control);
 
-bool avctp_is_initiator(struct avctp *session)
-{
-	return session->initiator;
+	if (session->key.timer > 0)
+		g_source_remove(session->key.timer);
+
+	if (session->uinput >= 0) {
+		DBG("AVCTP: closing uinput");
+
+		ioctl(session->uinput, UI_DEV_DESTROY);
+		close(session->uinput);
+		session->uinput = -1;
+	}
+
+	g_free(session);
 }
diff --git a/android/avctp.h b/android/avctp.h
index f9c665e..99aaf95 100644
--- a/android/avctp.h
+++ b/android/avctp.h
@@ -82,19 +82,6 @@
 
 struct avctp;
 
-typedef enum {
-	AVCTP_STATE_DISCONNECTED = 0,
-	AVCTP_STATE_CONNECTING,
-	AVCTP_STATE_CONNECTED,
-	AVCTP_STATE_BROWSING_CONNECTING,
-	AVCTP_STATE_BROWSING_CONNECTED
-} avctp_state_t;
-
-typedef void (*avctp_state_cb) (struct btd_device *dev,
-				avctp_state_t old_state,
-				avctp_state_t new_state,
-				void *user_data);
-
 typedef bool (*avctp_passthrough_cb) (struct avctp *session,
 					uint8_t op, bool pressed,
 					void *user_data);
@@ -113,34 +100,33 @@ typedef size_t (*avctp_browsing_pdu_cb) (struct avctp *session,
 					uint8_t *operands, size_t operand_count,
 					void *user_data);
 
-unsigned int avctp_add_state_cb(struct btd_device *dev, avctp_state_cb cb,
-							void *user_data);
-gboolean avctp_remove_state_cb(unsigned int id);
+typedef void (*avctp_destroy_cb_t) (void *user_data);
 
-int avctp_register(struct btd_adapter *adapter, gboolean master);
-void avctp_unregister(struct btd_adapter *adapter);
+struct avctp *avctp_new(int fd, size_t imtu, size_t omtu, uint16_t version);
+int avctp_init_uinput(struct avctp *session, const char *name,
+							const char *address);
+int avctp_connect_browsing(struct avctp *session, int fd, size_t imtu,
+								size_t omtu);
 
-struct avctp *avctp_connect(struct btd_device *device);
-struct avctp *avctp_get(struct btd_device *device);
-bool avctp_is_initiator(struct avctp *session);
-int avctp_connect_browsing(struct avctp *session);
-void avctp_disconnect(struct avctp *session);
+void avctp_shutdown(struct avctp *session);
 
 unsigned int avctp_register_passthrough_handler(struct avctp *session,
 						avctp_passthrough_cb cb,
 						void *user_data);
-bool avctp_unregister_passthrough_handler(unsigned int id);
+bool avctp_unregister_passthrough_handler(struct avctp *session,
+							unsigned int id);
 
 unsigned int avctp_register_pdu_handler(struct avctp *session, uint8_t opcode,
 						avctp_control_pdu_cb cb,
 						void *user_data);
-gboolean avctp_unregister_pdu_handler(unsigned int id);
+bool avctp_unregister_pdu_handler(struct avctp *session, unsigned int id);
 
 unsigned int avctp_register_browsing_pdu_handler(struct avctp *session,
 						avctp_browsing_pdu_cb cb,
 						void *user_data,
-						GDestroyNotify destroy);
-gboolean avctp_unregister_browsing_pdu_handler(unsigned int id);
+						avctp_destroy_cb_t destroy);
+bool avctp_unregister_browsing_pdu_handler(struct avctp *session,
+							unsigned int id);
 
 int avctp_send_passthrough(struct avctp *session, uint8_t op);
 int avctp_send_vendordep(struct avctp *session, uint8_t transaction,
-- 
1.8.4.2

