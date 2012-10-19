Return-Path: <cyrus@holtmann.org>
From: Mikel Astiz <mikel.astiz.oss@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Mikel Astiz <mikel.astiz@bmw-carit.de>
Subject: [RFC v0 07/15] audio: Trivial function rename
Date: Fri, 19 Oct 2012 17:39:24 +0200
Message-Id: <1350661172-18125-8-git-send-email-mikel.astiz.oss@gmail.com>
In-Reply-To: <1350661172-18125-1-git-send-email-mikel.astiz.oss@gmail.com>
References: <1350661172-18125-1-git-send-email-mikel.astiz.oss@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Mikel Astiz <mikel.astiz@bmw-carit.de>

Use the local_ name prefix for local functions implementing the D-Bus
API.
---
 audio/sink.c   | 12 ++++++------
 audio/source.c | 12 ++++++------
 2 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/audio/sink.c b/audio/sink.c
index 2e63579..b9e4fe0 100644
--- a/audio/sink.c
+++ b/audio/sink.c
@@ -390,7 +390,7 @@ gboolean sink_setup_stream(struct sink *sink, struct avdtp *session)
 	return TRUE;
 }
 
-static DBusMessage *sink_connect(DBusConnection *conn,
+static DBusMessage *local_connect(DBusConnection *conn,
 				DBusMessage *msg, void *data)
 {
 	struct audio_device *dev = data;
@@ -423,7 +423,7 @@ static DBusMessage *sink_connect(DBusConnection *conn,
 	return NULL;
 }
 
-static DBusMessage *sink_disconnect(DBusConnection *conn,
+static DBusMessage *local_disconnect(DBusConnection *conn,
 					DBusMessage *msg, void *data)
 {
 	struct audio_device *device = data;
@@ -457,7 +457,7 @@ static DBusMessage *sink_disconnect(DBusConnection *conn,
 	return NULL;
 }
 
-static DBusMessage *sink_get_properties(DBusConnection *conn,
+static DBusMessage *local_get_properties(DBusConnection *conn,
 					DBusMessage *msg, void *data)
 {
 	struct audio_device *device = data;
@@ -489,11 +489,11 @@ static DBusMessage *sink_get_properties(DBusConnection *conn,
 }
 
 static const GDBusMethodTable sink_methods[] = {
-	{ GDBUS_ASYNC_METHOD("Connect", NULL, NULL, sink_connect) },
-	{ GDBUS_ASYNC_METHOD("Disconnect", NULL, NULL, sink_disconnect) },
+	{ GDBUS_ASYNC_METHOD("Connect", NULL, NULL, local_connect) },
+	{ GDBUS_ASYNC_METHOD("Disconnect", NULL, NULL, local_disconnect) },
 	{ GDBUS_METHOD("GetProperties",
 				NULL, GDBUS_ARGS({ "properties", "a{sv}" }),
-				sink_get_properties) },
+				local_get_properties) },
 	{ }
 };
 
diff --git a/audio/source.c b/audio/source.c
index 1d0c74a..04971d9 100644
--- a/audio/source.c
+++ b/audio/source.c
@@ -379,7 +379,7 @@ gboolean source_setup_stream(struct source *source, struct avdtp *session)
 	return TRUE;
 }
 
-static DBusMessage *source_connect(DBusConnection *conn,
+static DBusMessage *local_connect(DBusConnection *conn,
 				DBusMessage *msg, void *data)
 {
 	struct audio_device *dev = data;
@@ -412,7 +412,7 @@ static DBusMessage *source_connect(DBusConnection *conn,
 	return NULL;
 }
 
-static DBusMessage *source_disconnect(DBusConnection *conn,
+static DBusMessage *local_disconnect(DBusConnection *conn,
 					DBusMessage *msg, void *data)
 {
 	struct audio_device *device = data;
@@ -446,7 +446,7 @@ static DBusMessage *source_disconnect(DBusConnection *conn,
 	return NULL;
 }
 
-static DBusMessage *source_get_properties(DBusConnection *conn,
+static DBusMessage *local_get_properties(DBusConnection *conn,
 					DBusMessage *msg, void *data)
 {
 	struct audio_device *device = data;
@@ -478,11 +478,11 @@ static DBusMessage *source_get_properties(DBusConnection *conn,
 }
 
 static const GDBusMethodTable source_methods[] = {
-	{ GDBUS_ASYNC_METHOD("Connect", NULL, NULL, source_connect) },
-	{ GDBUS_ASYNC_METHOD("Disconnect", NULL, NULL, source_disconnect) },
+	{ GDBUS_ASYNC_METHOD("Connect", NULL, NULL, local_connect) },
+	{ GDBUS_ASYNC_METHOD("Disconnect", NULL, NULL, local_disconnect) },
 	{ GDBUS_METHOD("GetProperties",
 				NULL, GDBUS_ARGS({ "properties", "a{sv}" }),
-				source_get_properties) },
+				local_get_properties) },
 	{ }
 };
 
-- 
1.7.11.7

