Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/4] Remove IMTU and OMTU properties and return its values on Acquire reply
Date: Tue, 18 Jan 2011 12:00:12 +0200
Message-Id: <1295344815-1404-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.dentz-von@nokia.com>

This should make Acquire blocking friendly since the client no longer has
to call GetProperties to discover how much it can write/read when using
the acquired file descriptor.
---
 audio/transport.c |   56 +++++++++++++++++++++++++++++++---------------------
 doc/media-api.txt |   13 ++---------
 2 files changed, 36 insertions(+), 33 deletions(-)

diff --git a/audio/transport.c b/audio/transport.c
index bdec157..d575590 100644
--- a/audio/transport.c
+++ b/audio/transport.c
@@ -181,14 +181,6 @@ static gboolean media_transport_set_fd(struct media_transport *transport,
 
 	info("%s: fd(%d) ready", transport->path, fd);
 
-	emit_property_changed(transport->conn, transport->path,
-				MEDIA_TRANSPORT_INTERFACE, "IMTU",
-				DBUS_TYPE_UINT16, &transport->imtu);
-
-	emit_property_changed(transport->conn, transport->path,
-				MEDIA_TRANSPORT_INTERFACE, "OMTU",
-				DBUS_TYPE_UINT16, &transport->omtu);
-
 	return TRUE;
 }
 
@@ -209,6 +201,7 @@ static void a2dp_resume_complete(struct avdtp *session,
 	struct avdtp_stream *stream;
 	int fd;
 	uint16_t imtu, omtu;
+	gboolean ret;
 
 	req->id = 0;
 
@@ -219,15 +212,24 @@ static void a2dp_resume_complete(struct avdtp *session,
 	if (stream == NULL)
 		goto fail;
 
-	if (avdtp_stream_get_transport(stream, &fd, &imtu, &omtu, NULL) ==
-			FALSE)
+	ret = avdtp_stream_get_transport(stream, &fd, &imtu, &omtu, NULL);
+	if (ret == FALSE)
 		goto fail;
 
 	media_transport_set_fd(transport, fd, imtu, omtu);
 
-	if (g_dbus_send_reply(transport->conn, req->msg,
-				DBUS_TYPE_UNIX_FD, &fd,
-				DBUS_TYPE_INVALID) == FALSE)
+	if (g_strstr_len(owner->accesstype, -1, "r") == NULL)
+		imtu = 0;
+
+	if (g_strstr_len(owner->accesstype, -1, "w") == NULL)
+		omtu = 0;
+
+	ret = g_dbus_send_reply(transport->conn, req->msg,
+						DBUS_TYPE_UNIX_FD, &fd,
+						DBUS_TYPE_UINT16, &imtu,
+						DBUS_TYPE_UINT16, &omtu,
+						DBUS_TYPE_INVALID);
+	if (ret == FALSE)
 		goto fail;
 
 	return;
@@ -282,6 +284,8 @@ static void headset_resume_complete(struct audio_device *dev, void *user_data)
 	struct acquire_request *req = owner->request;
 	struct media_transport *transport = owner->transport;
 	int fd;
+	uint16_t imtu, omtu;
+	gboolean ret;
 
 	req->id = 0;
 
@@ -292,11 +296,23 @@ static void headset_resume_complete(struct audio_device *dev, void *user_data)
 	if (fd < 0)
 		goto fail;
 
-	media_transport_set_fd(transport, fd, 48, 48);
+	imtu = 48;
+	omtu = 48;
 
-	if (g_dbus_send_reply(transport->conn, req->msg,
-				DBUS_TYPE_UNIX_FD, &fd,
-				DBUS_TYPE_INVALID) == FALSE)
+	media_transport_set_fd(transport, fd, imtu, omtu);
+
+	if (g_strstr_len(owner->accesstype, -1, "r") == NULL)
+		imtu = 0;
+
+	if (g_strstr_len(owner->accesstype, -1, "w") == NULL)
+		omtu = 0;
+
+	ret = g_dbus_send_reply(transport->conn, req->msg,
+						DBUS_TYPE_UNIX_FD, &fd,
+						DBUS_TYPE_UINT16, &imtu,
+						DBUS_TYPE_UINT16, &omtu,
+						DBUS_TYPE_INVALID);
+	if (ret == FALSE)
 		goto fail;
 
 	return;
@@ -607,12 +623,6 @@ void transport_get_properties(struct media_transport *transport,
 	dict_append_entry(&dict, "Device", DBUS_TYPE_OBJECT_PATH,
 						&transport->device->path);
 
-	dict_append_entry(&dict, "IMTU", DBUS_TYPE_UINT16,
-						&transport->imtu);
-
-	dict_append_entry(&dict, "OMTU", DBUS_TYPE_UINT16,
-						&transport->omtu);
-
 	uuid = media_endpoint_get_uuid(transport->endpoint);
 	dict_append_entry(&dict, "UUID", DBUS_TYPE_STRING, &uuid);
 
diff --git a/doc/media-api.txt b/doc/media-api.txt
index 5338974..92b8b3f 100644
--- a/doc/media-api.txt
+++ b/doc/media-api.txt
@@ -86,9 +86,10 @@ Methods		dict GetProperties()
 			Returns all properties for the interface. See the
 			properties section for available properties.
 
-		fd Acquire(string accesstype)
+		fd, uint16, uint16 Acquire(string accesstype)
 
-			Acquire transport file descriptor.
+			Acquire transport file descriptor and the MTU for read
+			and write respectively.
 
 			possible accesstype:
 
@@ -118,14 +119,6 @@ Properties	object Device [readonly]
 
 			Device object which the transport is connected to.
 
-		uint16 IMTU [readonly]
-
-			Transport input MTU.
-
-		uint16 OMTU [readonly]
-
-			Transport output MTU.
-
 		string UUID [readonly]
 
 			UUID of the profile which the transport is for.
-- 
1.7.1

