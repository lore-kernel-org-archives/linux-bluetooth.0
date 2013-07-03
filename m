Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [RFC 06/20] audio/control: Reduce dependency on struct audio_device
Date: Wed,  3 Jul 2013 18:15:27 +0300
Message-Id: <1372864541-10763-7-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1372864541-10763-1-git-send-email-luiz.dentz@gmail.com>
References: <1372864541-10763-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This is part of the work necessary to completely remove
struct audio_device
---
 profiles/audio/avrcp.c   | 39 +++++++++++++++++++++++++++++--------
 profiles/audio/control.c | 50 +++++++++++++-----------------------------------
 profiles/audio/control.h | 13 ++++---------
 profiles/audio/device.c  |  2 +-
 profiles/audio/manager.c | 18 ++---------------
 5 files changed, 51 insertions(+), 71 deletions(-)

diff --git a/profiles/audio/avrcp.c b/profiles/audio/avrcp.c
index 763012d..cc007c5 100644
--- a/profiles/audio/avrcp.c
+++ b/profiles/audio/avrcp.c
@@ -47,8 +47,9 @@
 #include <gdbus/gdbus.h>
 
 #include "lib/uuid.h"
-#include "../src/adapter.h"
-#include "../src/device.h"
+#include "src/adapter.h"
+#include "src/device.h"
+#include "src/service.h"
 
 #include "log.h"
 #include "error.h"
@@ -3282,6 +3283,7 @@ static void session_tg_init_control(struct avrcp *session)
 {
 	struct avrcp_server *server = session->server;
 	struct avrcp_player *player;
+	struct btd_service *service;
 
 	if (session->version < 0x0103)
 		return;
@@ -3314,7 +3316,10 @@ static void session_tg_init_control(struct avrcp *session)
 		avrcp_register_notification(session,
 						AVRCP_EVENT_VOLUME_CHANGED);
 
-	control_remote_connected(session->dev, 0);
+	service = btd_device_get_service(session->dev->btd_dev,
+							AVRCP_REMOTE_UUID);
+	if (service != NULL)
+		btd_service_connecting_complete(service, 0);
 }
 
 static void session_ct_init_browsing(struct avrcp *session)
@@ -3329,6 +3334,7 @@ static void session_ct_init_browsing(struct avrcp *session)
 static void session_ct_init_control(struct avrcp *session)
 {
 	struct avrcp_player *player;
+	struct btd_service *service;
 
 	DBG("%p version 0x%04x", session, session->version);
 
@@ -3340,7 +3346,11 @@ static void session_ct_init_control(struct avrcp *session)
 	if (session->version >= 0x0104)
 		session->supported_events = (1 << AVRCP_EVENT_VOLUME_CHANGED);
 
-	control_target_connected(session->dev, 0);
+
+	service = btd_device_get_service(session->dev->btd_dev,
+							AVRCP_TARGET_UUID);
+	if (service != NULL)
+		btd_service_connecting_complete(service, 0);
 
 	player = create_ct_player(session, 0);
 	if (player == NULL)
@@ -3373,30 +3383,43 @@ static void session_destroy(struct avrcp *session)
 static void session_tg_destroy(struct avrcp *session)
 {
 	struct avrcp_player *player = session->player;
+	struct btd_service *service;
 
 	DBG("%p", session);
 
 	if (player != NULL)
 		player->sessions = g_slist_remove(player->sessions, session);
 
+	service = btd_device_get_service(session->dev->btd_dev,
+							AVRCP_REMOTE_UUID);
+	if (service == NULL)
+		return session_destroy(session);
+
 	if (session->control_id == 0)
-		control_remote_connected(session->dev, -EIO);
+		btd_service_connecting_complete(service, -EIO);
 	else
-		control_remote_disconnected(session->dev, 0);
+		btd_service_disconnecting_complete(service, 0);
 
 	session_destroy(session);
 }
 
 static void session_ct_destroy(struct avrcp *session)
 {
+	struct btd_service *service;
+
 	DBG("%p", session);
 
 	g_slist_free_full(session->players, player_destroy);
 
+	service = btd_device_get_service(session->dev->btd_dev,
+							AVRCP_TARGET_UUID);
+	if (service == NULL)
+		return session_destroy(session);
+
 	if (session->control_id == 0)
-		control_target_connected(session->dev, -EIO);
+		btd_service_connecting_complete(service, -EIO);
 	else
-		control_target_disconnected(session->dev, 0);
+		btd_service_disconnecting_complete(service, 0);
 
 	session_destroy(session);
 }
diff --git a/profiles/audio/control.c b/profiles/audio/control.c
index 4c0a978..1dffbd8 100644
--- a/profiles/audio/control.c
+++ b/profiles/audio/control.c
@@ -62,40 +62,13 @@
 #include "dbus-common.h"
 
 struct control {
+	struct audio_device *dev;
 	struct avctp *session;
 	struct btd_service *target;
 	struct btd_service *remote;
 	unsigned int avctp_id;
 };
 
-void control_target_connected(struct audio_device *dev, int err)
-{
-	struct control *control = btd_service_get_user_data(dev->control);
-
-	btd_service_connecting_complete(control->target, err);
-}
-
-void control_target_disconnected(struct audio_device *dev, int err)
-{
-	struct control *control = btd_service_get_user_data(dev->control);
-
-	btd_service_disconnecting_complete(control->target, err);
-}
-
-void control_remote_connected(struct audio_device *dev, int err)
-{
-	struct control *control = btd_service_get_user_data(dev->control);
-
-	btd_service_connecting_complete(control->remote, err);
-}
-
-void control_remote_disconnected(struct audio_device *dev, int err)
-{
-	struct control *control = btd_service_get_user_data(dev->control);
-
-	btd_service_disconnecting_complete(control->remote, err);
-}
-
 static void state_changed(struct audio_device *dev, avctp_state_t old_state,
 							avctp_state_t new_state)
 {
@@ -127,9 +100,9 @@ static void state_changed(struct audio_device *dev, avctp_state_t old_state,
 	}
 }
 
-int control_connect(struct audio_device *dev)
+int control_connect(struct btd_service *service)
 {
-	struct control *control = btd_service_get_user_data(dev->control);
+	struct control *control = btd_service_get_user_data(service);
 
 	if (control->session)
 		return -EALREADY;
@@ -137,16 +110,16 @@ int control_connect(struct audio_device *dev)
 	if (!control->target)
 		return -ENOTSUP;
 
-	control->session = avctp_connect(dev);
+	control->session = avctp_connect(control->dev);
 	if (!control->session)
 		return -EIO;
 
 	return 0;
 }
 
-int control_disconnect(struct audio_device *dev)
+int control_disconnect(struct btd_service *service)
 {
-	struct control *control = btd_service_get_user_data(dev->control);
+	struct control *control = btd_service_get_user_data(service);
 
 	if (!control->session)
 		return -ENOTCONN;
@@ -284,10 +257,12 @@ static void path_unregister(void *data)
 	dev->control = NULL;
 }
 
-void control_unregister(struct audio_device *dev)
+void control_unregister(struct btd_service *service)
 {
+	struct btd_device *dev = btd_service_get_device(service);
+
 	g_dbus_unregister_interface(btd_get_dbus_connection(),
-						device_get_path(dev->btd_dev),
+						device_get_path(dev),
 						AUDIO_CONTROL_INTERFACE);
 }
 
@@ -311,6 +286,7 @@ static struct control *control_init(struct audio_device *dev)
 
 	control = g_new0(struct control, 1);
 
+	control->dev = dev;
 	control->avctp_id = avctp_add_state_cb(dev, state_changed);
 
 	return control;
@@ -348,9 +324,9 @@ struct btd_service *control_init_remote(struct audio_device *dev,
 	return service;
 }
 
-gboolean control_is_active(struct audio_device *dev)
+gboolean control_is_active(struct btd_service *service)
 {
-	struct control *control = btd_service_get_user_data(dev->control);
+	struct control *control = btd_service_get_user_data(service);
 
 	if (control && control->session)
 		return TRUE;
diff --git a/profiles/audio/control.h b/profiles/audio/control.h
index 9d90c74..57668f9 100644
--- a/profiles/audio/control.h
+++ b/profiles/audio/control.h
@@ -30,13 +30,8 @@ struct btd_service *control_init_target(struct audio_device *dev,
 						struct btd_service *service);
 struct btd_service *control_init_remote(struct audio_device *dev,
 						struct btd_service *service);
-void control_unregister(struct audio_device *dev);
-gboolean control_is_active(struct audio_device *dev);
+void control_unregister(struct btd_service *service);
+gboolean control_is_active(struct btd_service *service);
 
-int control_connect(struct audio_device *dev);
-int control_disconnect(struct audio_device *dev);
-
-void control_target_connected(struct audio_device *dev, int err);
-void control_target_disconnected(struct audio_device *dev, int err);
-void control_remote_connected(struct audio_device *dev, int err);
-void control_remote_disconnected(struct audio_device *dev, int err);
+int control_connect(struct btd_service *service);
+int control_disconnect(struct btd_service *service);
diff --git a/profiles/audio/device.c b/profiles/audio/device.c
index ea9a771..416e1b2 100644
--- a/profiles/audio/device.c
+++ b/profiles/audio/device.c
@@ -267,7 +267,7 @@ void audio_device_unregister(struct audio_device *device)
 		source_unregister(device->source);
 
 	if (device->control)
-		control_unregister(device);
+		control_unregister(device->control);
 
 	device_free(device);
 }
diff --git a/profiles/audio/manager.c b/profiles/audio/manager.c
index 59cdecc..386cd88 100644
--- a/profiles/audio/manager.c
+++ b/profiles/audio/manager.c
@@ -214,34 +214,20 @@ static int avrcp_target_connect(struct btd_service *service)
 {
 	struct btd_device *dev = btd_service_get_device(service);
 	const char *path = device_get_path(dev);
-	struct audio_device *audio_dev;
 
 	DBG("path %s", path);
 
-	audio_dev = get_audio_dev(dev);
-	if (!audio_dev) {
-		DBG("unable to get a device object");
-		return -1;
-	}
-
-	return control_connect(audio_dev);
+	return control_connect(service);
 }
 
 static int avrcp_target_disconnect(struct btd_service *service)
 {
 	struct btd_device *dev = btd_service_get_device(service);
 	const char *path = device_get_path(dev);
-	struct audio_device *audio_dev;
 
 	DBG("path %s", path);
 
-	audio_dev = get_audio_dev(dev);
-	if (!audio_dev) {
-		DBG("unable to get a device object");
-		return -1;
-	}
-
-	return control_disconnect(audio_dev);
+	return control_disconnect(service);
 }
 
 static int a2dp_source_server_probe(struct btd_profile *p,
-- 
1.8.1.4

