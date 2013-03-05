Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 4/6] avctp: Remove user data from avdtp_session_state_cb
Date: Tue, 5 Mar 2013 12:06:57 +0100
Message-ID: <1362481619-25815-5-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1362481619-25815-1-git-send-email-szymon.janc@tieto.com>
References: <1362481619-25815-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

All users pass NULL as user data so there is no need to keep that.
---
 profiles/audio/avctp.c   | 7 ++-----
 profiles/audio/avctp.h   | 6 ++----
 profiles/audio/avrcp.c   | 4 ++--
 profiles/audio/control.c | 4 ++--
 profiles/audio/device.c  | 9 +++------
 5 files changed, 11 insertions(+), 19 deletions(-)

diff --git a/profiles/audio/avctp.c b/profiles/audio/avctp.c
index 7fbaacb..509b3af 100644
--- a/profiles/audio/avctp.c
+++ b/profiles/audio/avctp.c
@@ -115,7 +115,6 @@ struct avc_header {
 struct avctp_state_callback {
 	avctp_state_cb cb;
 	struct audio_device *dev;
-	void *user_data;
 	unsigned int id;
 };
 
@@ -482,7 +481,7 @@ static void avctp_set_state(struct avctp *session, avctp_state_t new_state)
 		if (cb->dev && cb->dev != dev)
 			continue;
 
-		cb->cb(dev, old_state, new_state, cb->user_data);
+		cb->cb(dev, old_state, new_state);
 	}
 
 	switch (new_state) {
@@ -1644,8 +1643,7 @@ int avctp_send_vendordep_req(struct avctp *session, uint8_t code,
 						func, user_data);
 }
 
-unsigned int avctp_add_state_cb(avctp_state_cb cb, struct audio_device *dev,
-								void *user_data)
+unsigned int avctp_add_state_cb(avctp_state_cb cb, struct audio_device *dev)
 {
 	struct avctp_state_callback *state_cb;
 	static unsigned int id = 0;
@@ -1653,7 +1651,6 @@ unsigned int avctp_add_state_cb(avctp_state_cb cb, struct audio_device *dev,
 	state_cb = g_new(struct avctp_state_callback, 1);
 	state_cb->cb = cb;
 	state_cb->dev = dev;
-	state_cb->user_data = user_data;
 	state_cb->id = ++id;
 
 	callbacks = g_slist_append(callbacks, state_cb);
diff --git a/profiles/audio/avctp.h b/profiles/audio/avctp.h
index 56ed672..f557466 100644
--- a/profiles/audio/avctp.h
+++ b/profiles/audio/avctp.h
@@ -74,8 +74,7 @@ typedef enum {
 
 typedef void (*avctp_state_cb) (struct audio_device *dev,
 				avctp_state_t old_state,
-				avctp_state_t new_state,
-				void *user_data);
+				avctp_state_t new_state);
 
 typedef size_t (*avctp_control_pdu_cb) (struct avctp *session,
 					uint8_t transaction, uint8_t *code,
@@ -92,8 +91,7 @@ typedef size_t (*avctp_browsing_pdu_cb) (struct avctp *session,
 					uint8_t *operands, size_t operand_count,
 					void *user_data);
 
-unsigned int avctp_add_state_cb(avctp_state_cb cb, struct audio_device *dev,
-							void *user_data);
+unsigned int avctp_add_state_cb(avctp_state_cb cb, struct audio_device *dev);
 gboolean avctp_remove_state_cb(unsigned int id);
 
 int avctp_register(struct btd_adapter *adapter, gboolean master);
diff --git a/profiles/audio/avrcp.c b/profiles/audio/avrcp.c
index b7edc44..6ff37ba 100644
--- a/profiles/audio/avrcp.c
+++ b/profiles/audio/avrcp.c
@@ -2701,7 +2701,7 @@ static struct avrcp *session_create(struct avrcp_server *server,
 }
 
 static void state_changed(struct audio_device *dev, avctp_state_t old_state,
-				avctp_state_t new_state, void *user_data)
+							avctp_state_t new_state)
 {
 	struct avrcp_server *server;
 	struct avrcp *session;
@@ -2832,7 +2832,7 @@ int avrcp_register(struct btd_adapter *adapter, GKeyFile *config)
 	servers = g_slist_append(servers, server);
 
 	if (!avctp_id)
-		avctp_id = avctp_add_state_cb(state_changed, NULL, NULL);
+		avctp_id = avctp_add_state_cb(state_changed, NULL);
 
 	return 0;
 }
diff --git a/profiles/audio/control.c b/profiles/audio/control.c
index b48ff0a..95588c2 100644
--- a/profiles/audio/control.c
+++ b/profiles/audio/control.c
@@ -66,7 +66,7 @@ struct control {
 };
 
 static void state_changed(struct audio_device *dev, avctp_state_t old_state,
-				avctp_state_t new_state, void *user_data)
+							avctp_state_t new_state)
 {
 	DBusConnection *conn = btd_get_dbus_connection();
 	struct control *control = dev->control;
@@ -287,7 +287,7 @@ struct control *control_init(struct audio_device *dev, GSList *uuids)
 
 	control_update(control, uuids);
 
-	control->avctp_id = avctp_add_state_cb(state_changed, dev, NULL);
+	control->avctp_id = avctp_add_state_cb(state_changed, dev);
 
 	return control;
 }
diff --git a/profiles/audio/device.c b/profiles/audio/device.c
index 61bd37c..c45cda6 100644
--- a/profiles/audio/device.c
+++ b/profiles/audio/device.c
@@ -275,10 +275,8 @@ static void device_sink_cb(struct audio_device *dev,
 	}
 }
 
-static void device_avctp_cb(struct audio_device *dev,
-				avctp_state_t old_state,
-				avctp_state_t new_state,
-				void *user_data)
+static void device_avctp_cb(struct audio_device *dev, avctp_state_t old_state,
+							avctp_state_t new_state)
 {
 	if (!dev->control)
 		return;
@@ -316,8 +314,7 @@ struct audio_device *audio_device_register(struct btd_device *device)
 		sink_callback_id = sink_add_state_cb(device_sink_cb, NULL);
 
 	dev->priv->avdtp_callback_id = avdtp_add_state_cb(device_avdtp_cb, dev);
-	dev->priv->avctp_callback_id = avctp_add_state_cb(device_avctp_cb, dev,
-									NULL);
+	dev->priv->avctp_callback_id = avctp_add_state_cb(device_avctp_cb, dev);
 
 	return dev;
 }
-- 
1.8.1.5

