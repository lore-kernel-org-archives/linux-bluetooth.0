Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 3/4] audio: Remove unused parameters from sink_connect/sink_disconnect
Date: Wed, 19 Dec 2012 13:27:00 +0200
Message-Id: <1355916421-29304-3-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1355916421-29304-1-git-send-email-luiz.dentz@gmail.com>
References: <1355916421-29304-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Profile .connect and .disconnect no longer use callbacks so there is no
reason to keep these parameters around.
---
 profiles/audio/device.c  |  2 +-
 profiles/audio/manager.c | 18 ++----------------
 profiles/audio/sink.c    |  5 ++---
 profiles/audio/sink.h    |  5 ++---
 4 files changed, 7 insertions(+), 23 deletions(-)

diff --git a/profiles/audio/device.c b/profiles/audio/device.c
index 080ebc9..d4ba6d2 100644
--- a/profiles/audio/device.c
+++ b/profiles/audio/device.c
@@ -184,7 +184,7 @@ static void disconnect_cb(struct btd_device *btd_dev, gboolean removal,
 		avrcp_disconnect(dev);
 
 	if (dev->sink && priv->sink_state != SINK_STATE_DISCONNECTED)
-		sink_disconnect(dev, TRUE, NULL, NULL);
+		sink_disconnect(dev, TRUE);
 	else
 		priv->disconnecting = FALSE;
 }
diff --git a/profiles/audio/manager.c b/profiles/audio/manager.c
index 620127c..1f49aa3 100644
--- a/profiles/audio/manager.c
+++ b/profiles/audio/manager.c
@@ -174,20 +174,6 @@ static int avrcp_probe(struct btd_profile *p, struct btd_device *device,
 	return 0;
 }
 
-static void connect_cb(struct audio_device *dev, int err, void *data)
-{
-	struct btd_profile *profile = data;
-
-	device_profile_connected(dev->btd_dev, profile, err);
-}
-
-static void disconnect_cb(struct audio_device *dev, int err, void *data)
-{
-	struct btd_profile *profile = data;
-
-	device_profile_disconnected(dev->btd_dev, profile, err);
-}
-
 static int a2dp_source_connect(struct btd_device *dev,
 						struct btd_profile *profile)
 {
@@ -236,7 +222,7 @@ static int a2dp_sink_connect(struct btd_device *dev,
 		return -1;
 	}
 
-	return sink_connect(audio_dev, connect_cb, profile);
+	return sink_connect(audio_dev);
 }
 
 static int a2dp_sink_disconnect(struct btd_device *dev,
@@ -253,7 +239,7 @@ static int a2dp_sink_disconnect(struct btd_device *dev,
 		return -1;
 	}
 
-	return sink_disconnect(audio_dev, FALSE, disconnect_cb, profile);
+	return sink_disconnect(audio_dev, FALSE);
 }
 
 static int avrcp_control_connect(struct btd_device *dev,
diff --git a/profiles/audio/sink.c b/profiles/audio/sink.c
index b12c913..02e1a65 100644
--- a/profiles/audio/sink.c
+++ b/profiles/audio/sink.c
@@ -305,7 +305,7 @@ gboolean sink_setup_stream(struct sink *sink, struct avdtp *session)
 	return TRUE;
 }
 
-int sink_connect(struct audio_device *dev, audio_device_cb cb, void *data)
+int sink_connect(struct audio_device *dev)
 {
 	struct sink *sink = dev->sink;
 
@@ -415,8 +415,7 @@ gboolean sink_new_stream(struct audio_device *dev, struct avdtp *session,
 	return TRUE;
 }
 
-int sink_disconnect(struct audio_device *dev, gboolean shutdown,
-						audio_device_cb cb, void *data)
+int sink_disconnect(struct audio_device *dev, gboolean shutdown)
 {
 	struct sink *sink = dev->sink;
 
diff --git a/profiles/audio/sink.h b/profiles/audio/sink.h
index b9e97e3..fc7ed92 100644
--- a/profiles/audio/sink.h
+++ b/profiles/audio/sink.h
@@ -42,9 +42,8 @@ gboolean sink_remove_state_cb(unsigned int id);
 struct sink *sink_init(struct audio_device *dev);
 void sink_unregister(struct audio_device *dev);
 gboolean sink_is_active(struct audio_device *dev);
-int sink_connect(struct audio_device *dev, audio_device_cb cb, void *data);
+int sink_connect(struct audio_device *dev);
 gboolean sink_new_stream(struct audio_device *dev, struct avdtp *session,
 				struct avdtp_stream *stream);
 gboolean sink_setup_stream(struct sink *sink, struct avdtp *session);
-int sink_disconnect(struct audio_device *dev, gboolean shutdown,
-						audio_device_cb cb, void *data);
+int sink_disconnect(struct audio_device *dev, gboolean shutdown);
-- 
1.7.11.7

