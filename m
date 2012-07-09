Return-Path: <cyrus@holtmann.org>
From: Mikel Astiz <mikel.astiz.oss@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Mikel Astiz <mikel.astiz@bmw-carit.de>
Subject: [RFC v0] media: Extend media API with optional acquire
Date: Mon,  9 Jul 2012 17:21:51 -0300
Message-Id: <1341865311-21266-1-git-send-email-mikel.astiz.oss@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Mikel Astiz <mikel.astiz@bmw-carit.de>

Acquiring a transport is needed in two different situations: either
we are initiating the audio stream locally, or the remote side initiated
it and thus we are just reacting. In the second case, we would expect
the stream is already available, and otherwise the operation should
fail. This means the media API needs to be extended in order to make
this difference.

This issue is specially relevant in the case of SCO, because the current
approach is racy. With HFP, for example (say BlueZ has the HS role), the
following race condition could be met:

1. Phone has an incoming call and thus starts in-band ringing.
2. SCO connection is accepted and stablished by BlueZ.
3. Gateway interface state is changed to Playing.
4. Exactly afterwards, the user routes the audio to the phone, to have
   a private conversation. So the SCO link is closed.
5. In parallel, PulseAudio sees the transition to Playing, and acquires
   the transport.
6. BlueZ receives an Acquire() request, but SCO is down. So it tries to
   reconnect the SCO link.

The last step is an undesired behavior (the audio is routed back to the
car). BlueZ should be smart enough to know that the SCO connection
shouldn't be reestablished, but this is only possible if the endpoint
provides additional information in the media API.
---

This patch reopens the discussion started by the thread "when is acquire
ok to call". The race condition seems to be real (even thought difficult
to reproduce), and I couldn't think of any approach to solve this
without altering the Media API.

 audio/gateway.c   |    4 ++++
 audio/gateway.h   |    3 ++-
 audio/transport.c |   12 ++++++++++--
 doc/media-api.txt |    7 +++++++
 4 files changed, 23 insertions(+), 3 deletions(-)

diff --git a/audio/gateway.c b/audio/gateway.c
index 6162948..9784e8e 100644
--- a/audio/gateway.c
+++ b/audio/gateway.c
@@ -833,12 +833,16 @@ static gboolean request_stream_cb(gpointer data)
 /* These are functions to be called from unix.c for audio system
  * ifaces (alsa, gstreamer, etc.) */
 unsigned int gateway_request_stream(struct audio_device *dev,
+				gboolean try_only,
 				gateway_stream_cb_t cb, void *user_data)
 {
 	struct gateway *gw = dev->gateway;
 	GError *err = NULL;
 	GIOChannel *io;
 
+	if (try_only && !gw->sco)
+		return 0;
+
 	if (!gw->rfcomm)
 		get_records(dev);
 	else if (!gw->sco) {
diff --git a/audio/gateway.h b/audio/gateway.h
index 77f5787..f44e26d 100644
--- a/audio/gateway.h
+++ b/audio/gateway.h
@@ -63,7 +63,8 @@ int gateway_connect_rfcomm(struct audio_device *dev, GIOChannel *io);
 int gateway_connect_sco(struct audio_device *dev, GIOChannel *chan);
 void gateway_start_service(struct audio_device *device);
 unsigned int gateway_request_stream(struct audio_device *dev,
-			gateway_stream_cb_t cb, void *user_data);
+			gboolean try_only, gateway_stream_cb_t cb,
+			void *user_data);
 int gateway_config_stream(struct audio_device *dev, gateway_stream_cb_t cb,
 			void *user_data);
 gboolean gateway_cancel_stream(struct audio_device *dev, unsigned int id);
diff --git a/audio/transport.c b/audio/transport.c
index 832ad2a..212ddde 100644
--- a/audio/transport.c
+++ b/audio/transport.c
@@ -88,6 +88,7 @@ struct media_transport {
 	gboolean		write_lock;
 	gboolean		in_use;
 	guint			(*resume) (struct media_transport *transport,
+					gboolean try_only,
 					struct media_owner *owner);
 	guint			(*suspend) (struct media_transport *transport,
 					struct media_owner *owner);
@@ -283,6 +284,7 @@ fail:
 }
 
 static guint resume_a2dp(struct media_transport *transport,
+				gboolean try_only,
 				struct media_owner *owner)
 {
 	struct a2dp_transport *a2dp = transport->data;
@@ -394,6 +396,7 @@ fail:
 }
 
 static guint resume_headset(struct media_transport *transport,
+				gboolean try_only,
 				struct media_owner *owner)
 {
 	struct audio_device *device = transport->device;
@@ -499,6 +502,7 @@ fail:
 }
 
 static guint resume_gateway(struct media_transport *transport,
+				gboolean try_only,
 				struct media_owner *owner)
 {
 	struct audio_device *device = transport->device;
@@ -512,7 +516,7 @@ static guint resume_gateway(struct media_transport *transport,
 		return 0;
 
 done:
-	return gateway_request_stream(device, gateway_resume_complete,
+	return gateway_request_stream(device, try_only, gateway_resume_complete,
 					owner);
 }
 
@@ -663,6 +667,7 @@ static DBusMessage *acquire(DBusConnection *conn, DBusMessage *msg,
 	struct media_request *req;
 	const char *accesstype, *sender;
 	guint id;
+	gboolean try_only = FALSE;
 
 	if (!dbus_message_get_args(msg, NULL,
 				DBUS_TYPE_STRING, &accesstype,
@@ -678,8 +683,11 @@ static DBusMessage *acquire(DBusConnection *conn, DBusMessage *msg,
 	if (media_transport_acquire(transport, accesstype) == FALSE)
 		return btd_error_not_authorized(msg);
 
+	if (g_strstr_len(accesstype, -1, "?") != NULL)
+		try_only = TRUE;
+
 	owner = media_owner_create(conn, msg, accesstype);
-	id = transport->resume(transport, owner);
+	id = transport->resume(transport, try_only, owner);
 	if (id == 0) {
 		media_transport_release(transport, accesstype);
 		media_owner_free(owner);
diff --git a/doc/media-api.txt b/doc/media-api.txt
index e5eeaa0..4853196 100644
--- a/doc/media-api.txt
+++ b/doc/media-api.txt
@@ -282,6 +282,13 @@ Methods		dict GetProperties()
 
 				"rw": Read and write access
 
+			The accesstype string can also be combined with a "?"
+			suffix, which will make the request optional. This
+			typically means the transport will only be acquired if
+			it is already available (remote-initiated), but
+			otherwise no request will be sent to the remote side.
+			In this last case the function will fail.
+
 		void Release(string accesstype)
 
 			Releases file descriptor.
-- 
1.7.7.6

