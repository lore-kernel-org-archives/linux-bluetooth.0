Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Update a2dpsink to use new Acquire API
Date: Thu, 20 Jan 2011 11:29:41 +0200
Message-Id: <1295515781-16658-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.dentz-von@nokia.com>

---
 audio/gstavdtpsink.c |   19 +++++++------------
 1 files changed, 7 insertions(+), 12 deletions(-)

diff --git a/audio/gstavdtpsink.c b/audio/gstavdtpsink.c
index 48fa24d..ce1365a 100644
--- a/audio/gstavdtpsink.c
+++ b/audio/gstavdtpsink.c
@@ -1280,16 +1280,7 @@ static gboolean gst_avdtp_sink_transport_parse_property(GstAvdtpSink *self,
 
 		break;
 	}
-	case DBUS_TYPE_UINT16: {
-		uint16_t value;
-		dbus_message_iter_get_basic(&variant_i, &value);
-
-		if (g_str_equal(key, "OMTU") == TRUE)
-			self->data->link_mtu = value;
-
-		break;
-	}
-        case DBUS_TYPE_STRING: {
+	case DBUS_TYPE_STRING: {
 		const char *value;
 		dbus_message_iter_get_basic(&variant_i, &value);
 
@@ -1328,6 +1319,7 @@ static gboolean gst_avdtp_sink_transport_acquire(GstAvdtpSink *self)
 	DBusError err;
 	const char *access_type = "w";
 	int fd;
+	uint16_t imtu, omtu;
 
 	dbus_error_init(&err);
 
@@ -1348,7 +1340,9 @@ static gboolean gst_avdtp_sink_transport_acquire(GstAvdtpSink *self)
 		goto fail;
 
 	if (dbus_message_get_args(reply, &err, DBUS_TYPE_UNIX_FD, &fd,
-					DBUS_TYPE_INVALID) == FALSE)
+						DBUS_TYPE_UINT16, &imtu,
+						DBUS_TYPE_UINT16, &omtu,
+						DBUS_TYPE_INVALID) == FALSE)
 		goto fail;
 
 	dbus_message_unref(reply);
@@ -1356,7 +1350,8 @@ static gboolean gst_avdtp_sink_transport_acquire(GstAvdtpSink *self)
 	self->stream = g_io_channel_unix_new(fd);
 	g_io_channel_set_encoding(self->stream, NULL, NULL);
 	g_io_channel_set_close_on_unref(self->stream, TRUE);
-	GST_DEBUG_OBJECT(self, "stream_fd=%d", fd);
+	self->data->link_mtu = omtu;
+	GST_DEBUG_OBJECT(self, "stream_fd=%d mtu=%d", fd, omtu);
 
 	return TRUE;
 
-- 
1.7.1

