Return-Path: <cyrus@holtmann.org>
From: Mikel Astiz <mikel.astiz.oss@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Mikel Astiz <mikel.astiz@bmw-carit.de>
Subject: [RFC BlueZ v0 05/10] transport: Add API to report suspend/resume complete
Date: Fri, 12 Jul 2013 12:54:38 +0200
Message-Id: <1373626483-2031-6-git-send-email-mikel.astiz.oss@gmail.com>
In-Reply-To: <1373626483-2031-1-git-send-email-mikel.astiz.oss@gmail.com>
References: <1373626483-2031-1-git-send-email-mikel.astiz.oss@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Mikel Astiz <mikel.astiz@bmw-carit.de>

The driver needs to inform the core about the completion of these
asynchronous operations.
---
 profiles/audio/transport.c | 60 ++++++++++++++++++++++++++--------------------
 profiles/audio/transport.h |  4 ++++
 2 files changed, 38 insertions(+), 26 deletions(-)

diff --git a/profiles/audio/transport.c b/profiles/audio/transport.c
index 14e4b9b..a9b8c3b 100644
--- a/profiles/audio/transport.c
+++ b/profiles/audio/transport.c
@@ -251,19 +251,32 @@ static void media_transport_remove_owner(struct media_transport *transport)
 		transport->driver->suspend(transport, NULL);
 }
 
-static gboolean media_transport_set_fd(struct media_transport *transport,
-					int fd, uint16_t imtu, uint16_t omtu)
+void media_transport_resume_complete(struct media_owner *owner, int fd,
+						uint16_t imtu, uint16_t omtu)
 {
-	if (transport->fd == fd)
-		return TRUE;
+	struct media_transport *transport = owner->transport;
+	struct media_request *req = owner->pending;
+
+	if (fd < 0) {
+		media_transport_remove_owner(transport);
+		return;
+	}
+
+	info("%s: fd(%d) ready", transport->path, fd);
 
 	transport->fd = fd;
 	transport->imtu = imtu;
 	transport->omtu = omtu;
 
-	info("%s: fd(%d) ready", transport->path, fd);
+	g_dbus_send_reply(btd_get_dbus_connection(), req->msg,
+						DBUS_TYPE_UNIX_FD, &fd,
+						DBUS_TYPE_UINT16, &imtu,
+						DBUS_TYPE_UINT16, &omtu,
+						DBUS_TYPE_INVALID);
 
-	return TRUE;
+	media_owner_remove(owner);
+
+	transport_set_state(transport, TRANSPORT_STATE_ACTIVE);
 }
 
 static void a2dp_resume_complete(struct avdtp *session,
@@ -291,24 +304,12 @@ static void a2dp_resume_complete(struct avdtp *session,
 	if (ret == FALSE)
 		goto fail;
 
-	media_transport_set_fd(transport, fd, imtu, omtu);
-
-	ret = g_dbus_send_reply(btd_get_dbus_connection(), req->msg,
-						DBUS_TYPE_UNIX_FD, &fd,
-						DBUS_TYPE_UINT16, &imtu,
-						DBUS_TYPE_UINT16, &omtu,
-						DBUS_TYPE_INVALID);
-	if (ret == FALSE)
-		goto fail;
-
-	media_owner_remove(owner);
-
-	transport_set_state(transport, TRANSPORT_STATE_ACTIVE);
+	media_transport_resume_complete(owner, fd, imtu, omtu);
 
 	return;
 
 fail:
-	media_transport_remove_owner(transport);
+	media_transport_resume_complete(owner, -1, 0, 0);
 }
 
 static guint resume_a2dp(struct media_transport *transport,
@@ -342,13 +343,9 @@ static guint resume_a2dp(struct media_transport *transport,
 	return id;
 }
 
-static void a2dp_suspend_complete(struct avdtp *session,
-				struct avdtp_error *err, void *user_data)
+void media_transport_suspend_complete(struct media_owner *owner)
 {
-	struct media_owner *owner = user_data;
 	struct media_transport *transport = owner->transport;
-	struct a2dp_transport *a2dp = transport->data;
-	struct a2dp_sep *sep = media_endpoint_get_sep(transport->endpoint);
 
 	/* Release always succeeds */
 	if (owner->pending) {
@@ -357,11 +354,22 @@ static void a2dp_suspend_complete(struct avdtp *session,
 		media_owner_remove(owner);
 	}
 
-	a2dp_sep_unlock(sep, a2dp->session);
 	transport_set_state(transport, TRANSPORT_STATE_IDLE);
 	media_transport_remove_owner(transport);
 }
 
+static void a2dp_suspend_complete(struct avdtp *session,
+				struct avdtp_error *err, void *user_data)
+{
+	struct media_owner *owner = user_data;
+	struct media_transport *transport = owner->transport;
+	struct a2dp_transport *a2dp = transport->data;
+	struct a2dp_sep *sep = media_endpoint_get_sep(transport->endpoint);
+
+	a2dp_sep_unlock(sep, a2dp->session);
+	media_transport_suspend_complete(owner);
+}
+
 static guint suspend_a2dp(struct media_transport *transport,
 						struct media_owner *owner)
 {
diff --git a/profiles/audio/transport.h b/profiles/audio/transport.h
index c276428..be0fcea 100644
--- a/profiles/audio/transport.h
+++ b/profiles/audio/transport.h
@@ -59,3 +59,7 @@ void media_transport_update_device_volume(struct audio_device *dev,
 
 void media_transport_driver_register(struct media_transport_driver *driver);
 void media_transport_driver_unregister(struct media_transport_driver *driver);
+
+void media_transport_resume_complete(struct media_owner *owner, int fd,
+						uint16_t imtu, uint16_t omtu);
+void media_transport_suspend_complete(struct media_owner *owner);
-- 
1.8.1.4

