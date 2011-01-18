Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/4] Updade a2dpsink to use new Acquire API
Date: Tue, 18 Jan 2011 12:00:13 +0200
Message-Id: <1295344815-1404-2-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1295344815-1404-1-git-send-email-luiz.dentz@gmail.com>
References: <1295344815-1404-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.dentz-von@nokia.com>

---
 audio/gstavdtpsink.c |   19 +++++++------------
 1 files changed, 7 insertions(+), 12 deletions(-)

diff --git a/audio/gstavdtpsink.c b/audio/gstavdtpsink.c
index 95c4811..f3b15b3 100644
--- a/audio/gstavdtpsink.c
+++ b/audio/gstavdtpsink.c
@@ -1281,16 +1281,7 @@ static gboolean gst_avdtp_sink_transport_parse_property(GstAvdtpSink *self,
 
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
 
@@ -1329,6 +1320,7 @@ static gboolean gst_avdtp_sink_transport_acquire(GstAvdtpSink *self)
 	DBusError err;
 	const char *access_type = "w";
 	int fd;
+	uint16_t imtu, omtu;
 
 	dbus_error_init(&err);
 
@@ -1349,14 +1341,17 @@ static gboolean gst_avdtp_sink_transport_acquire(GstAvdtpSink *self)
 		goto fail;
 
 	if (dbus_message_get_args(reply, &err, DBUS_TYPE_UNIX_FD, &fd,
-					DBUS_TYPE_INVALID) == FALSE)
+						DBUS_TYPE_UINT16, &imtu,
+						DBUS_TYPE_UINT16, &omtu,
+						DBUS_TYPE_INVALID) == FALSE)
 		goto fail;
 
 	dbus_message_unref(reply);
 
 	self->stream = g_io_channel_unix_new(fd);
 	g_io_channel_set_close_on_unref(self->stream, TRUE);
-	GST_DEBUG_OBJECT(self, "stream_fd=%d", fd);
+	self->data->link_mtu = omtu;
+	GST_DEBUG_OBJECT(self, "stream_fd=%d mtu=%d", fd, omtu);
 
 	return TRUE;
 
-- 
1.7.1

