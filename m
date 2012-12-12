Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 11/16] avctp: Convert register/unregister to accept btd_adapter
Date: Wed, 12 Dec 2012 11:28:03 +0100
Message-ID: <1355308088-9080-12-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1355308088-9080-1-git-send-email-szymon.janc@tieto.com>
References: <1355308088-9080-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Use btd_adapter and btd_device refs instead of source and destination
bdaddr_t.
---
 profiles/audio/avctp.c | 94 +++++++++++++++++++++++++-------------------------
 profiles/audio/avctp.h |  4 +--
 profiles/audio/avrcp.c |  4 +--
 3 files changed, 51 insertions(+), 51 deletions(-)

diff --git a/profiles/audio/avctp.c b/profiles/audio/avctp.c
index e7dba37..e56885a 100644
--- a/profiles/audio/avctp.c
+++ b/profiles/audio/avctp.c
@@ -49,6 +49,7 @@
 
 #include "adapter.h"
 #include "../src/device.h"
+#include "../src/manager.h"
 
 #include "log.h"
 #include "error.h"
@@ -119,7 +120,7 @@ struct avctp_state_callback {
 };
 
 struct avctp_server {
-	bdaddr_t src;
+	struct btd_adapter *adapter;
 	GIOChannel *control_io;
 	GIOChannel *browsing_io;
 	GSList *sessions;
@@ -169,7 +170,7 @@ struct key_pressed {
 
 struct avctp {
 	struct avctp_server *server;
-	bdaddr_t dst;
+	struct btd_device *device;
 
 	avctp_state_t state;
 
@@ -427,7 +428,7 @@ static void avctp_disconnected(struct avctp *session)
 	if (session->uinput >= 0) {
 		char address[18];
 
-		ba2str(&session->dst, address);
+		ba2str(device_get_address(session->device), address);
 		DBG("AVCTP: closing uinput for %s", address);
 
 		ioctl(session->uinput, UI_DEV_DESTROY);
@@ -437,6 +438,7 @@ static void avctp_disconnected(struct avctp *session)
 
 	server = session->server;
 	server->sessions = g_slist_remove(server->sessions, session);
+	btd_device_unref(session->device);
 	g_free(session);
 }
 
@@ -446,7 +448,9 @@ static void avctp_set_state(struct avctp *session, avctp_state_t new_state)
 	struct audio_device *dev;
 	avctp_state_t old_state = session->state;
 
-	dev = manager_get_device(&session->server->src, &session->dst, FALSE);
+	dev = manager_get_device(adapter_get_address(session->server->adapter),
+					device_get_address(session->device),
+					FALSE);
 	if (dev == NULL) {
 		error("%s(): No matching audio device", __func__);
 		return;
@@ -838,7 +842,9 @@ static void init_uinput(struct avctp *session)
 	struct audio_device *dev;
 	char address[18], name[248 + 1];
 
-	dev = manager_get_device(&session->server->src, &session->dst, FALSE);
+	dev = manager_get_device(adapter_get_address(session->server->adapter),
+					device_get_address(session->device),
+					FALSE);
 
 	device_get_name(dev->btd_dev, name, sizeof(name));
 	if (g_str_equal(name, "Nokia CK-20W")) {
@@ -848,7 +854,7 @@ static void init_uinput(struct avctp *session)
 		session->key_quirks[AVC_PAUSE] |= QUIRK_NO_RELEASE;
 	}
 
-	ba2str(&session->dst, address);
+	ba2str(device_get_address(session->device), address);
 
 	session->uinput = uinput_create(address);
 	if (session->uinput < 0)
@@ -998,53 +1004,47 @@ static void auth_cb(DBusError *derr, void *user_data)
 	}
 }
 
-static struct avctp_server *find_server(GSList *list, const bdaddr_t *src)
+static struct avctp_server *find_server(GSList *list, struct btd_adapter *a)
 {
 	for (; list; list = list->next) {
 		struct avctp_server *server = list->data;
 
-		if (bacmp(&server->src, src) == 0)
+		if (server->adapter == a)
 			return server;
 	}
 
 	return NULL;
 }
 
-static struct avctp *find_session(GSList *list, const bdaddr_t *dst)
+static struct avctp *find_session(GSList *list, struct btd_device *device)
 {
 	for (; list != NULL; list = g_slist_next(list)) {
 		struct avctp *s = list->data;
 
-		if (bacmp(dst, &s->dst))
-			continue;
-
-		return s;
+		if (s->device == device)
+			return s;
 	}
 
 	return NULL;
 }
 
-static struct avctp *avctp_get_internal(const bdaddr_t *src,
-							const bdaddr_t *dst)
+static struct avctp *avctp_get_internal(struct btd_device *device)
 {
 	struct avctp_server *server;
 	struct avctp *session;
 
-	assert(src != NULL);
-	assert(dst != NULL);
-
-	server = find_server(servers, src);
+	server = find_server(servers, device_get_adapter(device));
 	if (server == NULL)
 		return NULL;
 
-	session = find_session(server->sessions, dst);
+	session = find_session(server->sessions, device);
 	if (session)
 		return session;
 
 	session = g_new0(struct avctp, 1);
 
 	session->server = server;
-	bacpy(&session->dst, dst);
+	session->device = btd_device_ref(device);
 	session->state = AVCTP_STATE_DISCONNECTED;
 
 	server->sessions = g_slist_append(server->sessions, session);
@@ -1110,13 +1110,13 @@ static void avctp_confirm_cb(GIOChannel *chan, gpointer data)
 	struct avctp *session;
 	struct audio_device *dev;
 	char address[18];
-	bdaddr_t src, dst;
+	bdaddr_t src;
 	GError *err = NULL;
 	uint16_t psm;
+	struct btd_device *device;
 
 	bt_io_get(chan, &err,
 			BT_IO_OPT_SOURCE_BDADDR, &src,
-			BT_IO_OPT_DEST_BDADDR, &dst,
 			BT_IO_OPT_DEST, address,
 			BT_IO_OPT_PSM, &psm,
 			BT_IO_OPT_INVALID);
@@ -1129,13 +1129,18 @@ static void avctp_confirm_cb(GIOChannel *chan, gpointer data)
 
 	DBG("AVCTP: incoming connect from %s", address);
 
-	session = avctp_get_internal(&src, &dst);
+	device = adapter_find_device(manager_find_adapter(&src), address);
+	if (!device)
+		return;
+
+	session = avctp_get_internal(device);
 	if (session == NULL)
 		return;
 
-	dev = manager_get_device(&src, &dst, FALSE);
+	dev = manager_get_device(&src, device_get_address(device), FALSE);
 	if (!dev) {
-		dev = manager_get_device(&src, &dst, TRUE);
+		dev = manager_get_device(&src, device_get_address(device),
+									TRUE);
 		if (!dev) {
 			error("Unable to get audio device object for %s",
 					address);
@@ -1187,9 +1192,10 @@ static GIOChannel *avctp_server_socket(const bdaddr_t *src, gboolean master,
 	return io;
 }
 
-int avctp_register(const bdaddr_t *src, gboolean master)
+int avctp_register(struct btd_adapter *adapter, gboolean master)
 {
 	struct avctp_server *server;
+	const bdaddr_t *src = adapter_get_address(adapter);
 
 	server = g_new0(struct avctp_server, 1);
 
@@ -1211,18 +1217,18 @@ int avctp_register(const bdaddr_t *src, gboolean master)
 		return -1;
 	}
 
-	bacpy(&server->src, src);
+	server->adapter = btd_adapter_ref(adapter);
 
 	servers = g_slist_append(servers, server);
 
 	return 0;
 }
 
-void avctp_unregister(const bdaddr_t *src)
+void avctp_unregister(struct btd_adapter *adapter)
 {
 	struct avctp_server *server;
 
-	server = find_server(servers, src);
+	server = find_server(servers, adapter);
 	if (!server)
 		return;
 
@@ -1237,6 +1243,7 @@ void avctp_unregister(const bdaddr_t *src)
 
 	g_io_channel_shutdown(server->control_io, TRUE, NULL);
 	g_io_channel_unref(server->control_io);
+	btd_adapter_unref(server->adapter);
 	g_free(server);
 }
 
@@ -1605,13 +1612,8 @@ struct avctp *avctp_connect(struct audio_device *device)
 	struct avctp *session;
 	GError *err = NULL;
 	GIOChannel *io;
-	const bdaddr_t *src;
-	const bdaddr_t *dst;
 
-	src = adapter_get_address(device_get_adapter(device->btd_dev));
-	dst = device_get_address(device->btd_dev);
-
-	session = avctp_get_internal(src, dst);
+	session = avctp_get_internal(device->btd_dev);
 	if (!session)
 		return NULL;
 
@@ -1621,8 +1623,10 @@ struct avctp *avctp_connect(struct audio_device *device)
 	avctp_set_state(session, AVCTP_STATE_CONNECTING);
 
 	io = bt_io_connect(avctp_connect_cb, session, NULL, &err,
-				BT_IO_OPT_SOURCE_BDADDR, &session->server->src,
-				BT_IO_OPT_DEST_BDADDR, &session->dst,
+				BT_IO_OPT_SOURCE_BDADDR,
+				adapter_get_address(session->server->adapter),
+				BT_IO_OPT_DEST_BDADDR,
+				device_get_address(session->device),
 				BT_IO_OPT_SEC_LEVEL, BT_IO_SEC_MEDIUM,
 				BT_IO_OPT_PSM, AVCTP_CONTROL_PSM,
 				BT_IO_OPT_INVALID);
@@ -1651,8 +1655,10 @@ int avctp_connect_browsing(struct avctp *session)
 		return 0;
 
 	io = bt_io_connect(avctp_connect_browsing_cb, session, NULL, &err,
-				BT_IO_OPT_SOURCE_BDADDR, &session->server->src,
-				BT_IO_OPT_DEST_BDADDR, &session->dst,
+				BT_IO_OPT_SOURCE_BDADDR,
+				adapter_get_address(session->server->adapter),
+				BT_IO_OPT_DEST_BDADDR,
+				device_get_address(session->device),
 				BT_IO_OPT_SEC_LEVEL, BT_IO_SEC_MEDIUM,
 				BT_IO_OPT_PSM, AVCTP_BROWSING_PSM,
 				BT_IO_OPT_MODE, L2CAP_MODE_ERTM,
@@ -1679,11 +1685,5 @@ void avctp_disconnect(struct avctp *session)
 
 struct avctp *avctp_get(struct audio_device *device)
 {
-	const bdaddr_t *src;
-	const bdaddr_t *dst;
-
-	src = adapter_get_address(device_get_adapter(device->btd_dev));
-	dst = device_get_address(device->btd_dev);
-
-	return avctp_get_internal(src, dst);
+	return avctp_get_internal(device->btd_dev);
 }
diff --git a/profiles/audio/avctp.h b/profiles/audio/avctp.h
index 2597e6e..c25a3b3 100644
--- a/profiles/audio/avctp.h
+++ b/profiles/audio/avctp.h
@@ -90,8 +90,8 @@ typedef size_t (*avctp_browsing_pdu_cb) (struct avctp *session,
 unsigned int avctp_add_state_cb(avctp_state_cb cb, void *user_data);
 gboolean avctp_remove_state_cb(unsigned int id);
 
-int avctp_register(const bdaddr_t *src, gboolean master);
-void avctp_unregister(const bdaddr_t *src);
+int avctp_register(struct btd_adapter *adapter, gboolean master);
+void avctp_unregister(struct btd_adapter *adapter);
 
 struct avctp *avctp_connect(struct audio_device *device);
 struct avctp *avctp_get(struct audio_device *device);
diff --git a/profiles/audio/avrcp.c b/profiles/audio/avrcp.c
index 668cd87..4e3d31d 100644
--- a/profiles/audio/avrcp.c
+++ b/profiles/audio/avrcp.c
@@ -2321,7 +2321,7 @@ int avrcp_register(struct btd_adapter *adapter, GKeyFile *config)
 	}
 	server->ct_record_id = record->handle;
 
-	if (avctp_register(adapter_get_address(adapter), master) < 0) {
+	if (avctp_register(adapter, master) < 0) {
 		remove_record_from_server(server->ct_record_id);
 		remove_record_from_server(server->tg_record_id);
 		g_free(server);
@@ -2354,7 +2354,7 @@ void avrcp_unregister(struct btd_adapter *adapter)
 	remove_record_from_server(server->ct_record_id);
 	remove_record_from_server(server->tg_record_id);
 
-	avctp_unregister(adapter_get_address(server->adapter));
+	avctp_unregister(server->adapter);
 	btd_adapter_unref(server->adapter);
 	g_free(server);
 
-- 
1.8.0

