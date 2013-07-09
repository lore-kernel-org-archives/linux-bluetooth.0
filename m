Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 07/21] audio/AVCTP: Remove dependency on struct audio_device
Date: Tue,  9 Jul 2013 17:39:04 +0300
Message-Id: <1373380758-16489-11-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1373380758-16489-1-git-send-email-luiz.dentz@gmail.com>
References: <1373380758-16489-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This is part of the work necessary to completely remove
struct audio_device
---
 profiles/audio/avctp.c   | 69 +++++++++++++++++-------------------------------
 profiles/audio/avctp.h   | 12 +++++----
 profiles/audio/avrcp.c   | 35 ++++++++++++------------
 profiles/audio/control.c | 13 ++++-----
 profiles/audio/device.c  |  9 ++++---
 5 files changed, 62 insertions(+), 76 deletions(-)

diff --git a/profiles/audio/avctp.c b/profiles/audio/avctp.c
index a4d0153..627252a 100644
--- a/profiles/audio/avctp.c
+++ b/profiles/audio/avctp.c
@@ -47,14 +47,13 @@
 #include <btio/btio.h>
 
 #include "lib/uuid.h"
-#include "adapter.h"
-#include "../src/device.h"
+#include "src/adapter.h"
+#include "src/device.h"
 
 #include "log.h"
 #include "error.h"
 #include "uinput.h"
 #include "manager.h"
-#include "device.h"
 #include "avctp.h"
 #include "avrcp.h"
 
@@ -119,8 +118,9 @@ struct avc_header {
 
 struct avctp_state_callback {
 	avctp_state_cb cb;
-	struct audio_device *dev;
+	struct btd_device *dev;
 	unsigned int id;
+	void *user_data;
 };
 
 struct avctp_server {
@@ -530,24 +530,17 @@ static void avctp_disconnected(struct avctp *session)
 static void avctp_set_state(struct avctp *session, avctp_state_t new_state)
 {
 	GSList *l;
-	struct audio_device *dev;
 	avctp_state_t old_state = session->state;
 
-	dev = manager_get_audio_device(session->device, FALSE);
-	if (dev == NULL) {
-		error("%s(): No matching audio device", __func__);
-		return;
-	}
-
 	session->state = new_state;
 
 	for (l = callbacks; l != NULL; l = l->next) {
 		struct avctp_state_callback *cb = l->data;
 
-		if (cb->dev && cb->dev != dev)
+		if (cb->dev && cb->dev != session->device)
 			continue;
 
-		cb->cb(dev, old_state, new_state);
+		cb->cb(session->device, old_state, new_state, cb->user_data);
 	}
 
 	switch (new_state) {
@@ -1059,12 +1052,9 @@ static int uinput_create(char *name)
 
 static void init_uinput(struct avctp *session)
 {
-	struct audio_device *dev;
 	char address[18], name[248 + 1];
 
-	dev = manager_get_audio_device(session->device, FALSE);
-
-	device_get_name(dev->btd_dev, name, sizeof(name));
+	device_get_name(session->device, name, sizeof(name));
 	if (g_str_equal(name, "Nokia CK-20W")) {
 		session->key_quirks[AVC_FORWARD] |= QUIRK_NO_RELEASE;
 		session->key_quirks[AVC_BACKWARD] |= QUIRK_NO_RELEASE;
@@ -1296,7 +1286,7 @@ static struct avctp *avctp_get_internal(struct btd_device *device)
 }
 
 static void avctp_control_confirm(struct avctp *session, GIOChannel *chan,
-						struct audio_device *dev)
+						struct btd_device *dev)
 {
 	const bdaddr_t *src;
 	const bdaddr_t *dst;
@@ -1310,8 +1300,8 @@ static void avctp_control_confirm(struct avctp *session, GIOChannel *chan,
 	avctp_set_state(session, AVCTP_STATE_CONNECTING);
 	session->control = avctp_channel_create(session, chan, NULL);
 
-	src = adapter_get_address(device_get_adapter(dev->btd_dev));
-	dst = device_get_address(dev->btd_dev);
+	src = adapter_get_address(device_get_adapter(dev));
+	dst = device_get_address(dev);
 
 	session->auth_id = btd_request_authorization(src, dst,
 							AVRCP_TARGET_UUID,
@@ -1328,7 +1318,7 @@ drop:
 }
 
 static void avctp_browsing_confirm(struct avctp *session, GIOChannel *chan,
-						struct audio_device *dev)
+						struct btd_device *dev)
 {
 	GError *err = NULL;
 
@@ -1351,7 +1341,6 @@ static void avctp_browsing_confirm(struct avctp *session, GIOChannel *chan,
 static void avctp_confirm_cb(GIOChannel *chan, gpointer data)
 {
 	struct avctp *session;
-	struct audio_device *dev;
 	char address[18];
 	bdaddr_t src, dst;
 	GError *err = NULL;
@@ -1381,34 +1370,22 @@ static void avctp_confirm_cb(GIOChannel *chan, gpointer data)
 	if (session == NULL)
 		return;
 
-	dev = manager_get_audio_device(device, TRUE);
-	if (!dev) {
-		error("Unable to get audio device object for %s", address);
-		goto drop;
-	}
+	if (btd_device_get_service(device, AVRCP_REMOTE_UUID) == NULL)
+		btd_device_add_uuid(device, AVRCP_REMOTE_UUID);
 
-	if (dev->control == NULL) {
-		btd_device_add_uuid(dev->btd_dev, AVRCP_REMOTE_UUID);
-		btd_device_add_uuid(dev->btd_dev, AVRCP_TARGET_UUID);
-
-		if (dev->control == NULL)
-			goto drop;
-	}
+	if (btd_device_get_service(device, AVRCP_TARGET_UUID) == NULL)
+		btd_device_add_uuid(device, AVRCP_TARGET_UUID);
 
 	switch (psm) {
 	case AVCTP_CONTROL_PSM:
-		avctp_control_confirm(session, chan, dev);
+		avctp_control_confirm(session, chan, device);
 		break;
 	case AVCTP_BROWSING_PSM:
-		avctp_browsing_confirm(session, chan, dev);
+		avctp_browsing_confirm(session, chan, device);
 		break;
 	}
 
 	return;
-
-drop:
-	if (psm == AVCTP_CONTROL_PSM)
-		avctp_set_state(session, AVCTP_STATE_DISCONNECTED);
 }
 
 static GIOChannel *avctp_server_socket(const bdaddr_t *src, gboolean master,
@@ -1721,7 +1698,8 @@ int avctp_send_vendordep_req(struct avctp *session, uint8_t code,
 						func, user_data);
 }
 
-unsigned int avctp_add_state_cb(struct audio_device *dev, avctp_state_cb cb)
+unsigned int avctp_add_state_cb(struct btd_device *dev, avctp_state_cb cb,
+							void *user_data)
 {
 	struct avctp_state_callback *state_cb;
 	static unsigned int id = 0;
@@ -1730,6 +1708,7 @@ unsigned int avctp_add_state_cb(struct audio_device *dev, avctp_state_cb cb)
 	state_cb->cb = cb;
 	state_cb->dev = dev;
 	state_cb->id = ++id;
+	state_cb->user_data = user_data;
 
 	callbacks = g_slist_append(callbacks, state_cb);
 
@@ -1919,13 +1898,13 @@ gboolean avctp_unregister_browsing_pdu_handler(unsigned int id)
 	return FALSE;
 }
 
-struct avctp *avctp_connect(struct audio_device *device)
+struct avctp *avctp_connect(struct btd_device *device)
 {
 	struct avctp *session;
 	GError *err = NULL;
 	GIOChannel *io;
 
-	session = avctp_get_internal(device->btd_dev);
+	session = avctp_get_internal(device);
 	if (!session)
 		return NULL;
 
@@ -1999,9 +1978,9 @@ void avctp_disconnect(struct avctp *session)
 	avctp_set_state(session, AVCTP_STATE_DISCONNECTED);
 }
 
-struct avctp *avctp_get(struct audio_device *device)
+struct avctp *avctp_get(struct btd_device *device)
 {
-	return avctp_get_internal(device->btd_dev);
+	return avctp_get_internal(device);
 }
 
 bool avctp_is_initiator(struct avctp *session)
diff --git a/profiles/audio/avctp.h b/profiles/audio/avctp.h
index cd575cc..f9c665e 100644
--- a/profiles/audio/avctp.h
+++ b/profiles/audio/avctp.h
@@ -90,9 +90,10 @@ typedef enum {
 	AVCTP_STATE_BROWSING_CONNECTED
 } avctp_state_t;
 
-typedef void (*avctp_state_cb) (struct audio_device *dev,
+typedef void (*avctp_state_cb) (struct btd_device *dev,
 				avctp_state_t old_state,
-				avctp_state_t new_state);
+				avctp_state_t new_state,
+				void *user_data);
 
 typedef bool (*avctp_passthrough_cb) (struct avctp *session,
 					uint8_t op, bool pressed,
@@ -112,14 +113,15 @@ typedef size_t (*avctp_browsing_pdu_cb) (struct avctp *session,
 					uint8_t *operands, size_t operand_count,
 					void *user_data);
 
-unsigned int avctp_add_state_cb(struct audio_device *dev, avctp_state_cb cb);
+unsigned int avctp_add_state_cb(struct btd_device *dev, avctp_state_cb cb,
+							void *user_data);
 gboolean avctp_remove_state_cb(unsigned int id);
 
 int avctp_register(struct btd_adapter *adapter, gboolean master);
 void avctp_unregister(struct btd_adapter *adapter);
 
-struct avctp *avctp_connect(struct audio_device *device);
-struct avctp *avctp_get(struct audio_device *device);
+struct avctp *avctp_connect(struct btd_device *device);
+struct avctp *avctp_get(struct btd_device *device);
 bool avctp_is_initiator(struct avctp *session);
 int avctp_connect_browsing(struct avctp *session);
 void avctp_disconnect(struct avctp *session);
diff --git a/profiles/audio/avrcp.c b/profiles/audio/avrcp.c
index cc007c5..1a5c477 100644
--- a/profiles/audio/avrcp.c
+++ b/profiles/audio/avrcp.c
@@ -3251,12 +3251,12 @@ static void avrcp_get_capabilities(struct avrcp *session)
 					session);
 }
 
-static struct avrcp *find_session(GSList *list, struct audio_device *dev)
+static struct avrcp *find_session(GSList *list, struct btd_device *dev)
 {
 	for (; list; list = list->next) {
 		struct avrcp *session = list->data;
 
-		if (session->dev == dev)
+		if (session->dev->btd_dev == dev)
 			return session;
 	}
 
@@ -3425,16 +3425,17 @@ static void session_ct_destroy(struct avrcp *session)
 }
 
 static struct avrcp *session_create(struct avrcp_server *server,
-						struct audio_device *dev)
+						struct btd_device *device)
 {
 	struct avrcp *session;
 	const sdp_record_t *rec;
 	sdp_list_t *list;
 	sdp_profile_desc_t *desc;
+	struct audio_device *dev = manager_get_audio_device(device, FALSE);
 
 	session = g_new0(struct avrcp, 1);
 	session->server = server;
-	session->conn = avctp_connect(dev);
+	session->conn = avctp_connect(device);
 	session->dev = dev;
 
 	server->sessions = g_slist_append(server->sessions, session);
@@ -3458,16 +3459,16 @@ static struct avrcp *session_create(struct avrcp_server *server,
 		session->init_browsing = session_tg_init_browsing;
 		session->destroy = session_tg_destroy;
 
-		rec = btd_device_get_record(dev->btd_dev, AVRCP_REMOTE_UUID);
+		rec = btd_device_get_record(device, AVRCP_REMOTE_UUID);
 		if (rec == NULL)
-			btd_device_add_uuid(dev->btd_dev, AVRCP_REMOTE_UUID);
+			btd_device_add_uuid(device, AVRCP_REMOTE_UUID);
 	} else {
 		session->init_control = session_ct_init_control;
 		session->init_browsing = session_ct_init_browsing;
 		session->destroy = session_ct_destroy;
-		rec = btd_device_get_record(dev->btd_dev, AVRCP_TARGET_UUID);
+		rec = btd_device_get_record(device, AVRCP_TARGET_UUID);
 		if (rec == NULL)
-			btd_device_add_uuid(dev->btd_dev, AVRCP_TARGET_UUID);
+			btd_device_add_uuid(device, AVRCP_TARGET_UUID);
 	}
 
 	if (rec == NULL)
@@ -3485,17 +3486,17 @@ static struct avrcp *session_create(struct avrcp_server *server,
 	return session;
 }
 
-static void state_changed(struct audio_device *dev, avctp_state_t old_state,
-							avctp_state_t new_state)
+static void state_changed(struct btd_device *device, avctp_state_t old_state,
+				avctp_state_t new_state, void *user_data)
 {
 	struct avrcp_server *server;
 	struct avrcp *session;
 
-	server = find_server(servers, device_get_adapter(dev->btd_dev));
+	server = find_server(servers, device_get_adapter(device));
 	if (!server)
 		return;
 
-	session = find_session(server->sessions, dev);
+	session = find_session(server->sessions, device);
 
 	switch (new_state) {
 	case AVCTP_STATE_DISCONNECTED:
@@ -3509,7 +3510,7 @@ static void state_changed(struct audio_device *dev, avctp_state_t old_state,
 		if (session != NULL)
 			break;
 
-		session_create(server, dev);
+		session_create(server, device);
 
 		break;
 	case AVCTP_STATE_CONNECTED:
@@ -3538,7 +3539,7 @@ gboolean avrcp_connect(struct audio_device *dev)
 {
 	struct avctp *session;
 
-	session = avctp_connect(dev);
+	session = avctp_connect(dev->btd_dev);
 	if (session)
 		return FALSE;
 
@@ -3549,7 +3550,7 @@ void avrcp_disconnect(struct audio_device *dev)
 {
 	struct avctp *session;
 
-	session = avctp_get(dev);
+	session = avctp_get(dev->btd_dev);
 	if (!session)
 		return;
 
@@ -3582,7 +3583,7 @@ static struct avrcp_server *avrcp_server_register(struct btd_adapter *adapter,
 	servers = g_slist_append(servers, server);
 
 	if (!avctp_id)
-		avctp_id = avctp_add_state_cb(NULL, state_changed);
+		avctp_id = avctp_add_state_cb(NULL, state_changed, NULL);
 
 	return server;
 }
@@ -3791,7 +3792,7 @@ int avrcp_set_volume(struct audio_device *dev, uint8_t volume)
 	if (server == NULL)
 		return -EINVAL;
 
-	session = find_session(server->sessions, dev);
+	session = find_session(server->sessions, dev->btd_dev);
 	if (session == NULL)
 		return -ENOTCONN;
 
diff --git a/profiles/audio/control.c b/profiles/audio/control.c
index 7cfbcc6..9b614c3 100644
--- a/profiles/audio/control.c
+++ b/profiles/audio/control.c
@@ -69,12 +69,12 @@ struct control {
 	unsigned int avctp_id;
 };
 
-static void state_changed(struct audio_device *dev, avctp_state_t old_state,
-							avctp_state_t new_state)
+static void state_changed(struct btd_device *dev, avctp_state_t old_state,
+				avctp_state_t new_state, void *user_data)
 {
+	struct control *control = user_data;
 	DBusConnection *conn = btd_get_dbus_connection();
-	struct control *control = btd_service_get_user_data(dev->control);
-	const char *path = device_get_path(dev->btd_dev);
+	const char *path = device_get_path(dev);
 
 	switch (new_state) {
 	case AVCTP_STATE_DISCONNECTED:
@@ -110,7 +110,7 @@ int control_connect(struct btd_service *service)
 	if (!control->target)
 		return -ENOTSUP;
 
-	control->session = avctp_connect(control->dev);
+	control->session = avctp_connect(control->dev->btd_dev);
 	if (!control->session)
 		return -EIO;
 
@@ -287,7 +287,8 @@ static struct control *control_init(struct audio_device *dev)
 	control = g_new0(struct control, 1);
 
 	control->dev = dev;
-	control->avctp_id = avctp_add_state_cb(dev, state_changed);
+	control->avctp_id = avctp_add_state_cb(dev->btd_dev, state_changed,
+								control);
 
 	return control;
 }
diff --git a/profiles/audio/device.c b/profiles/audio/device.c
index 416e1b2..0112cd1 100644
--- a/profiles/audio/device.c
+++ b/profiles/audio/device.c
@@ -198,9 +198,11 @@ static void device_sink_cb(struct audio_device *dev,
 	}
 }
 
-static void device_avctp_cb(struct audio_device *dev, avctp_state_t old_state,
-							avctp_state_t new_state)
+static void device_avctp_cb(struct btd_device *device, avctp_state_t old_state,
+				avctp_state_t new_state, void *user_data)
 {
+	struct audio_device *dev = user_data;
+
 	if (!dev->control)
 		return;
 
@@ -251,7 +253,8 @@ struct audio_device *audio_device_register(struct btd_device *device)
 							NULL);
 	dev->priv->service_cb_id = btd_service_add_state_cb(service_cb, dev);
 	dev->priv->avdtp_callback_id = avdtp_add_state_cb(dev, device_avdtp_cb);
-	dev->priv->avctp_callback_id = avctp_add_state_cb(dev, device_avctp_cb);
+	dev->priv->avctp_callback_id = avctp_add_state_cb(device,
+							device_avctp_cb, dev);
 
 	return dev;
 }
-- 
1.8.1.4

