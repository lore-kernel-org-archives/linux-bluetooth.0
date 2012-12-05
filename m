Return-Path: <cyrus@holtmann.org>
From: Chan-yeol Park <chanyeol.park@samsung.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/2] audio: Remove not used auto connect flag
Date: Wed, 05 Dec 2012 19:16:35 +0900
Message-id: <1354702595-5040-2-git-send-email-chanyeol.park@samsung.com>
In-reply-to: <1354702595-5040-1-git-send-email-chanyeol.park@samsung.com>
References: <1354702595-5040-1-git-send-email-chanyeol.park@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This flag is not used anymore because HFP is moved away from bluez
It was used for Automatic HFP+A2DP connection with incomming connection.
---
 profiles/audio/audio.conf |    7 -------
 profiles/audio/avdtp.c    |   11 -----------
 profiles/audio/device.h   |    2 --
 profiles/audio/manager.c  |   10 ----------
 profiles/audio/sink.c     |    2 --
 profiles/audio/source.c   |    2 --
 6 files changed, 34 deletions(-)

diff --git a/profiles/audio/audio.conf b/profiles/audio/audio.conf
index 12b9c55..f556610 100644
--- a/profiles/audio/audio.conf
+++ b/profiles/audio/audio.conf
@@ -10,10 +10,3 @@
 # If we want to disable support for specific services
 # Defaults to supporting the services: Sink, Control
 #Disable=Source
-
-# Automatically connect both A2DP and HFP/HSP profiles for incoming
-# connections. Some headsets that support both profiles will only connect the
-# other one automatically so the default setting of true is usually a good
-# idea.
-#AutoConnect=true
-
diff --git a/profiles/audio/avdtp.c b/profiles/audio/avdtp.c
index e38c95b..4b74b65 100644
--- a/profiles/audio/avdtp.c
+++ b/profiles/audio/avdtp.c
@@ -436,8 +436,6 @@ static GSList *servers = NULL;
 
 static GSList *avdtp_callbacks = NULL;
 
-static gboolean auto_connect = TRUE;
-
 static int send_request(struct avdtp *session, gboolean priority,
 			struct avdtp_stream *stream, uint8_t signal_id,
 			void *buffer, size_t size);
@@ -2549,8 +2547,6 @@ static void avdtp_confirm_cb(GIOChannel *chan, gpointer data)
 		goto drop;
 	}
 
-	dev->auto_connect = auto_connect;
-
 	return;
 
 drop:
@@ -3880,13 +3876,6 @@ int avdtp_init(const bdaddr_t *src, GKeyFile *config)
 	} else
 		master = tmp;
 
-	tmp = g_key_file_get_boolean(config, "General", "AutoConnect",
-			&err);
-	if (err)
-		g_clear_error(&err);
-	else
-		auto_connect = tmp;
-
 proceed:
 	server = g_new0(struct avdtp_server, 1);
 
diff --git a/profiles/audio/device.h b/profiles/audio/device.h
index 0801cda..77e3c98 100644
--- a/profiles/audio/device.h
+++ b/profiles/audio/device.h
@@ -39,8 +39,6 @@ struct audio_device {
 	bdaddr_t src;
 	bdaddr_t dst;
 
-	gboolean auto_connect;
-
 	struct sink *sink;
 	struct source *source;
 	struct control *control;
diff --git a/profiles/audio/manager.c b/profiles/audio/manager.c
index 4e0c631..355d7fb 100644
--- a/profiles/audio/manager.c
+++ b/profiles/audio/manager.c
@@ -80,7 +80,6 @@ struct profile_req {
 	btd_profile_cb		cb;
 };
 
-static gboolean auto_connect = TRUE;
 static GKeyFile *config = NULL;
 static GSList *adapters = NULL;
 static GSList *devices = NULL;
@@ -579,8 +578,6 @@ int audio_manager_init(GKeyFile *conf)
 {
 	char **list;
 	int i;
-	gboolean b;
-	GError *err = NULL;
 
 	if (!conf)
 		goto proceed;
@@ -611,13 +608,6 @@ int audio_manager_init(GKeyFile *conf)
 	}
 	g_strfreev(list);
 
-	b = g_key_file_get_boolean(config, "General", "AutoConnect", &err);
-	if (err) {
-		DBG("audio.conf: %s", err->message);
-		g_clear_error(&err);
-	} else
-		auto_connect = b;
-
 proceed:
 	if (enabled.source)
 		btd_profile_register(&a2dp_source_profile);
diff --git a/profiles/audio/sink.c b/profiles/audio/sink.c
index 466c0a8..bc9a194 100644
--- a/profiles/audio/sink.c
+++ b/profiles/audio/sink.c
@@ -366,8 +366,6 @@ int sink_connect(struct audio_device *dev, audio_device_cb cb, void *data)
 		return -EIO;
 	}
 
-	dev->auto_connect = FALSE;
-
 	pending = sink->connect;
 
 	pending->cb = cb;
diff --git a/profiles/audio/source.c b/profiles/audio/source.c
index 157a4e8..1105d3e 100644
--- a/profiles/audio/source.c
+++ b/profiles/audio/source.c
@@ -366,8 +366,6 @@ int source_connect(struct audio_device *dev, audio_device_cb cb, void *data)
 		return -EIO;
 	}
 
-	dev->auto_connect = FALSE;
-
 	pending = source->connect;
 	pending->cb = cb;
 	pending->cb_data = data;
-- 
1.7.9.5

