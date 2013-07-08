Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 03/20] audio/control: Use service user_data for private data
Date: Mon,  8 Jul 2013 17:10:09 +0300
Message-Id: <1373292626-3776-4-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1373292626-3776-1-git-send-email-luiz.dentz@gmail.com>
References: <1373292626-3776-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This remove the need of forward declaration of struct control and prepare
for a complete removal of struct audio_device.
---
 profiles/audio/avrcp.c   | 12 ++++++------
 profiles/audio/control.c | 51 +++++++++++++++++++++++++++++-------------------
 profiles/audio/control.h | 14 ++++++-------
 profiles/audio/device.h  |  3 +--
 profiles/audio/manager.c | 14 +++++++++++--
 5 files changed, 56 insertions(+), 38 deletions(-)

diff --git a/profiles/audio/avrcp.c b/profiles/audio/avrcp.c
index ffc6415..4316f8e 100644
--- a/profiles/audio/avrcp.c
+++ b/profiles/audio/avrcp.c
@@ -3314,7 +3314,7 @@ static void session_tg_init_control(struct avrcp *session)
 		avrcp_register_notification(session,
 						AVRCP_EVENT_VOLUME_CHANGED);
 
-	control_remote_connected(session->dev->control, 0);
+	control_remote_connected(session->dev, 0);
 }
 
 static void session_ct_init_browsing(struct avrcp *session)
@@ -3340,7 +3340,7 @@ static void session_ct_init_control(struct avrcp *session)
 	if (session->version >= 0x0104)
 		session->supported_events = (1 << AVRCP_EVENT_VOLUME_CHANGED);
 
-	control_target_connected(session->dev->control, 0);
+	control_target_connected(session->dev, 0);
 
 	player = create_ct_player(session, 0);
 	if (player == NULL)
@@ -3380,9 +3380,9 @@ static void session_tg_destroy(struct avrcp *session)
 		player->sessions = g_slist_remove(player->sessions, session);
 
 	if (session->control_id == 0)
-		control_remote_connected(session->dev->control, -EIO);
+		control_remote_connected(session->dev, -EIO);
 	else
-		control_remote_disconnected(session->dev->control, 0);
+		control_remote_disconnected(session->dev, 0);
 
 	session_destroy(session);
 }
@@ -3394,9 +3394,9 @@ static void session_ct_destroy(struct avrcp *session)
 	g_slist_free_full(session->players, player_destroy);
 
 	if (session->control_id == 0)
-		control_target_connected(session->dev->control, -EIO);
+		control_target_connected(session->dev, -EIO);
 	else
-		control_target_disconnected(session->dev->control, 0);
+		control_target_disconnected(session->dev, 0);
 
 	session_destroy(session);
 }
diff --git a/profiles/audio/control.c b/profiles/audio/control.c
index c33dcad..0239bff 100644
--- a/profiles/audio/control.c
+++ b/profiles/audio/control.c
@@ -68,23 +68,31 @@ struct control {
 	unsigned int avctp_id;
 };
 
-void control_target_connected(struct control *control, int err)
+void control_target_connected(struct audio_device *dev, int err)
 {
+	struct control *control = btd_service_get_user_data(dev->control);
+
 	btd_service_connecting_complete(control->target, err);
 }
 
-void control_target_disconnected(struct control *control, int err)
+void control_target_disconnected(struct audio_device *dev, int err)
 {
+	struct control *control = btd_service_get_user_data(dev->control);
+
 	btd_service_disconnecting_complete(control->target, err);
 }
 
-void control_remote_connected(struct control *control, int err)
+void control_remote_connected(struct audio_device *dev, int err)
 {
+	struct control *control = btd_service_get_user_data(dev->control);
+
 	btd_service_connecting_complete(control->remote, err);
 }
 
-void control_remote_disconnected(struct control *control, int err)
+void control_remote_disconnected(struct audio_device *dev, int err)
 {
+	struct control *control = btd_service_get_user_data(dev->control);
+
 	btd_service_disconnecting_complete(control->remote, err);
 }
 
@@ -92,7 +100,7 @@ static void state_changed(struct audio_device *dev, avctp_state_t old_state,
 							avctp_state_t new_state)
 {
 	DBusConnection *conn = btd_get_dbus_connection();
-	struct control *control = dev->control;
+	struct control *control = btd_service_get_user_data(dev->control);
 	const char *path = device_get_path(dev->btd_dev);
 
 	switch (new_state) {
@@ -121,7 +129,7 @@ static void state_changed(struct audio_device *dev, avctp_state_t old_state,
 
 int control_connect(struct audio_device *dev)
 {
-	struct control *control = dev->control;
+	struct control *control = btd_service_get_user_data(dev->control);
 
 	if (control->session)
 		return -EALREADY;
@@ -138,7 +146,7 @@ int control_connect(struct audio_device *dev)
 
 int control_disconnect(struct audio_device *dev)
 {
-	struct control *control = dev->control;
+	struct control *control = btd_service_get_user_data(dev->control);
 
 	if (!control->session)
 		return -ENOTCONN;
@@ -152,7 +160,7 @@ static DBusMessage *key_pressed(DBusConnection *conn, DBusMessage *msg,
 						uint8_t op, void *data)
 {
 	struct audio_device *device = data;
-	struct control *control = device->control;
+	struct control *control = btd_service_get_user_data(device->control);
 	int err;
 
 	if (!control->session)
@@ -227,7 +235,8 @@ static gboolean control_property_get_connected(
 					DBusMessageIter *iter, void *data)
 {
 	struct audio_device *device = data;
-	dbus_bool_t value = (device->control->session != NULL);
+	struct control *control = btd_service_get_user_data(device->control);
+	dbus_bool_t value = (control->session != NULL);
 
 	dbus_message_iter_append_basic(iter, DBUS_TYPE_BOOLEAN, &value);
 
@@ -255,7 +264,7 @@ static const GDBusPropertyTable control_properties[] = {
 static void path_unregister(void *data)
 {
 	struct audio_device *dev = data;
-	struct control *control = dev->control;
+	struct control *control = btd_service_get_user_data(dev->control);
 
 	DBG("Unregistered interface %s on path %s",
 		AUDIO_CONTROL_INTERFACE, device_get_path(dev->btd_dev));
@@ -287,7 +296,7 @@ static struct control *control_init(struct audio_device *dev)
 	struct control *control;
 
 	if (dev->control != NULL)
-		return dev->control;
+		return btd_service_get_user_data(dev->control);
 
 	if (!g_dbus_register_interface(btd_get_dbus_connection(),
 					device_get_path(dev->btd_dev),
@@ -307,37 +316,39 @@ static struct control *control_init(struct audio_device *dev)
 	return control;
 }
 
-struct control *control_init_target(struct audio_device *dev,
-						struct btd_service *service)
+int control_init_target(struct audio_device *dev, struct btd_service *service)
 {
 	struct control *control;
 
 	control = control_init(dev);
 	if (control == NULL)
-		return NULL;
+		return -EINVAL;
 
 	control->target = btd_service_ref(service);
 
-	return control;
+	btd_service_set_user_data(service, control);
+
+	return 0;
 }
 
-struct control *control_init_remote(struct audio_device *dev,
-						struct btd_service *service)
+int control_init_remote(struct audio_device *dev, struct btd_service *service)
 {
 	struct control *control;
 
 	control = control_init(dev);
 	if (control == NULL)
-		return NULL;
+		return -EINVAL;
 
 	control->remote = btd_service_ref(service);
 
-	return control;
+	btd_service_set_user_data(service, control);
+
+	return 0;
 }
 
 gboolean control_is_active(struct audio_device *dev)
 {
-	struct control *control = dev->control;
+	struct control *control = btd_service_get_user_data(dev->control);
 
 	if (control && control->session)
 		return TRUE;
diff --git a/profiles/audio/control.h b/profiles/audio/control.h
index af6893b..d0aa3c3 100644
--- a/profiles/audio/control.h
+++ b/profiles/audio/control.h
@@ -26,17 +26,15 @@
 
 struct btd_service;
 
-struct control *control_init_target(struct audio_device *dev,
-						struct btd_service *service);
-struct control *control_init_remote(struct audio_device *dev,
-						struct btd_service *service);
+int control_init_target(struct audio_device *dev, struct btd_service *service);
+int control_init_remote(struct audio_device *dev, struct btd_service *service);
 void control_unregister(struct audio_device *dev);
 gboolean control_is_active(struct audio_device *dev);
 
 int control_connect(struct audio_device *dev);
 int control_disconnect(struct audio_device *dev);
 
-void control_target_connected(struct control *control, int err);
-void control_target_disconnected(struct control *control, int err);
-void control_remote_connected(struct control *control, int err);
-void control_remote_disconnected(struct control *control, int err);
+void control_target_connected(struct audio_device *dev, int err);
+void control_target_disconnected(struct audio_device *dev, int err);
+void control_remote_connected(struct audio_device *dev, int err);
+void control_remote_disconnected(struct audio_device *dev, int err);
diff --git a/profiles/audio/device.h b/profiles/audio/device.h
index 9e0147e..87fc067 100644
--- a/profiles/audio/device.h
+++ b/profiles/audio/device.h
@@ -23,7 +23,6 @@
  */
 
 struct audio_device;
-struct control;
 struct dev_priv;
 
 struct audio_device {
@@ -31,7 +30,7 @@ struct audio_device {
 
 	struct btd_service *sink;
 	struct btd_service *source;
-	struct control *control;
+	struct btd_service *control;
 
 	struct dev_priv *priv;
 };
diff --git a/profiles/audio/manager.c b/profiles/audio/manager.c
index 9de5a02..e905abb 100644
--- a/profiles/audio/manager.c
+++ b/profiles/audio/manager.c
@@ -139,6 +139,7 @@ static int avrcp_target_probe(struct btd_service *service)
 {
 	struct btd_device *device = btd_service_get_device(service);
 	struct audio_device *audio_dev;
+	int err;
 
 	audio_dev = get_audio_dev(device);
 	if (!audio_dev) {
@@ -146,7 +147,11 @@ static int avrcp_target_probe(struct btd_service *service)
 		return -1;
 	}
 
-	audio_dev->control = control_init_target(audio_dev, service);
+	err = control_init_target(audio_dev, service);
+	if (err < 0)
+		return 0;
+
+	audio_dev->control = service;
 
 	if (audio_dev->sink && sink_is_active(audio_dev))
 		avrcp_connect(audio_dev);
@@ -158,6 +163,7 @@ static int avrcp_remote_probe(struct btd_service *service)
 {
 	struct btd_device *device = btd_service_get_device(service);
 	struct audio_device *audio_dev;
+	int err;
 
 	audio_dev = get_audio_dev(device);
 	if (!audio_dev) {
@@ -165,7 +171,11 @@ static int avrcp_remote_probe(struct btd_service *service)
 		return -1;
 	}
 
-	audio_dev->control = control_init_remote(audio_dev, service);
+	err = control_init_remote(audio_dev, service);
+	if (err < 0)
+		return err;
+
+	audio_dev->control = service;
 
 	return 0;
 }
-- 
1.8.1.4

