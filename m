Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 2/4] audio: Fix not cleaning up player when device is removed
Date: Wed, 19 Dec 2012 13:26:59 +0200
Message-Id: <1355916421-29304-2-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1355916421-29304-1-git-send-email-luiz.dentz@gmail.com>
References: <1355916421-29304-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

All profile connections need to be reported to the core otherwise it
won't be able to disconnect them properly.
---
 profiles/audio/control.c | 58 ++++++------------------------------------------
 profiles/audio/control.h |  5 ++---
 profiles/audio/manager.c | 14 ++++++++++--
 profiles/audio/manager.h |  2 ++
 4 files changed, 23 insertions(+), 56 deletions(-)

diff --git a/profiles/audio/control.c b/profiles/audio/control.c
index 1600fce..642fdd5 100644
--- a/profiles/audio/control.c
+++ b/profiles/audio/control.c
@@ -61,28 +61,11 @@
 
 static unsigned int avctp_id = 0;
 
-struct pending_request {
-	audio_device_cb cb;
-	void *data;
-	unsigned int id;
-};
-
 struct control {
 	struct avctp *session;
 	gboolean target;
-	struct pending_request *connect;
 };
 
-static void pending_request_free(struct audio_device *dev,
-					struct pending_request *pending,
-					int err)
-{
-	if (pending->cb)
-		pending->cb(dev, err, pending->data);
-
-	g_free(pending);
-}
-
 static void state_changed(struct audio_device *dev, avctp_state_t old_state,
 				avctp_state_t new_state, void *user_data)
 {
@@ -94,13 +77,12 @@ static void state_changed(struct audio_device *dev, avctp_state_t old_state,
 	case AVCTP_STATE_DISCONNECTED:
 		control->session = NULL;
 
-		if (control->connect) {
-			pending_request_free(dev, control->connect, -EIO);
-			control->connect = NULL;
+		if (old_state != AVCTP_STATE_CONNECTED) {
+			audio_control_connected(dev->btd_dev, -EIO);
+			break;
 		}
 
-		if (old_state != AVCTP_STATE_CONNECTED)
-			break;
+		audio_control_disconnected(dev->btd_dev, 0);
 
 		g_dbus_emit_property_changed(conn, path,
 					AUDIO_CONTROL_INTERFACE, "Connected");
@@ -114,10 +96,7 @@ static void state_changed(struct audio_device *dev, avctp_state_t old_state,
 
 		break;
 	case AVCTP_STATE_CONNECTED:
-		if (control->connect) {
-			pending_request_free(dev, control->connect, 0);
-			control->connect = NULL;
-		}
+		audio_control_connected(dev->btd_dev, 0);
 
 		g_dbus_emit_property_changed(conn, path,
 					AUDIO_CONTROL_INTERFACE, "Connected");
@@ -127,10 +106,9 @@ static void state_changed(struct audio_device *dev, avctp_state_t old_state,
 	}
 }
 
-int control_connect(struct audio_device *dev, audio_device_cb cb, void *data)
+int control_connect(struct audio_device *dev)
 {
 	struct control *control = dev->control;
-	struct pending_request *pending;
 
 	if (control->session)
 		return -EALREADY;
@@ -138,42 +116,23 @@ int control_connect(struct audio_device *dev, audio_device_cb cb, void *data)
 	if (!control->target)
 		return -ENOTSUP;
 
-	if (control->connect)
-		return -EINPROGRESS;
-
 	control->session = avctp_connect(dev);
 	if (!control->session)
 		return -EIO;
 
-	pending = g_new0(struct pending_request, 1);
-	pending->cb = cb;
-	pending->data = data;
-	control->connect = pending;
-
 	return 0;
 }
 
-int control_disconnect(struct audio_device *dev, audio_device_cb cb,
-								void *data)
+int control_disconnect(struct audio_device *dev)
 {
 	struct control *control = dev->control;
 
 	if (!control->session)
 		return -ENOTCONN;
 
-	/* cancel pending connect */
-	if (control->connect) {
-		pending_request_free(dev, control->connect, -ECANCELED);
-		control->connect = NULL;
-	}
-
 	avctp_disconnect(control->session);
 
-	if (cb)
-		cb(dev, 0, data);
-
 	return 0;
-
 }
 
 static DBusMessage *key_pressed(DBusConnection *conn, DBusMessage *msg,
@@ -291,9 +250,6 @@ static void path_unregister(void *data)
 	if (control->session)
 		avctp_disconnect(control->session);
 
-	if (control->connect)
-		pending_request_free(dev, control->connect, -ECANCELED);
-
 	g_free(control);
 	dev->control = NULL;
 }
diff --git a/profiles/audio/control.h b/profiles/audio/control.h
index 878dd1e..001b564 100644
--- a/profiles/audio/control.h
+++ b/profiles/audio/control.h
@@ -29,6 +29,5 @@ void control_update(struct control *control, GSList *uuids);
 void control_unregister(struct audio_device *dev);
 gboolean control_is_active(struct audio_device *dev);
 
-int control_connect(struct audio_device *dev, audio_device_cb cb, void *data);
-int control_disconnect(struct audio_device *dev, audio_device_cb cb,
-								void *data);
+int control_connect(struct audio_device *dev);
+int control_disconnect(struct audio_device *dev);
diff --git a/profiles/audio/manager.c b/profiles/audio/manager.c
index 422316e..620127c 100644
--- a/profiles/audio/manager.c
+++ b/profiles/audio/manager.c
@@ -270,7 +270,7 @@ static int avrcp_control_connect(struct btd_device *dev,
 		return -1;
 	}
 
-	return control_connect(audio_dev, connect_cb, profile);
+	return control_connect(audio_dev);
 }
 
 static int avrcp_control_disconnect(struct btd_device *dev,
@@ -287,7 +287,7 @@ static int avrcp_control_disconnect(struct btd_device *dev,
 		return -1;
 	}
 
-	return control_disconnect(audio_dev, disconnect_cb, profile);
+	return control_disconnect(audio_dev);
 }
 
 static struct audio_adapter *audio_adapter_ref(struct audio_adapter *adp)
@@ -512,6 +512,16 @@ void audio_source_disconnected(struct btd_device *dev, int err)
 	device_profile_connected(dev, &a2dp_source_profile, err);
 }
 
+void audio_control_connected(struct btd_device *dev, int err)
+{
+	device_profile_connected(dev, &avrcp_profile, err);
+}
+
+void audio_control_disconnected(struct btd_device *dev, int err)
+{
+	device_profile_disconnected(dev, &avrcp_profile, err);
+}
+
 int audio_manager_init(GKeyFile *conf)
 {
 	char **list;
diff --git a/profiles/audio/manager.h b/profiles/audio/manager.h
index 2b924dc..e70d795 100644
--- a/profiles/audio/manager.h
+++ b/profiles/audio/manager.h
@@ -33,6 +33,8 @@ void audio_sink_connected(struct btd_device *dev, int err);
 void audio_sink_disconnected(struct btd_device *dev, int err);
 void audio_source_connected(struct btd_device *dev, int err);
 void audio_source_disconnected(struct btd_device *dev, int err);
+void audio_control_connected(struct btd_device *dev, int err);
+void audio_control_disconnected(struct btd_device *dev, int err);
 
 int audio_manager_init(GKeyFile *config);
 void audio_manager_exit(void);
-- 
1.7.11.7

