Return-Path: <cyrus@holtmann.org>
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Anderson Lizardo <anderson.lizardo@openbossa.org>
Subject: [PATCH BlueZ 02/17] AVDTP: Fix errno handling convention
Date: Wed, 16 Nov 2011 09:19:49 -0400
Message-Id: <1321449604-4188-3-git-send-email-anderson.lizardo@openbossa.org>
In-Reply-To: <1321449604-4188-1-git-send-email-anderson.lizardo@openbossa.org>
References: <1321449604-4188-1-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Variables which are assigned to the errno variable (usually called
"err") should be negative, and "-err" should be used where a positive
value is needed.
---
 audio/gstavdtpsink.c |   22 ++++++++++++----------
 1 files changed, 12 insertions(+), 10 deletions(-)

diff --git a/audio/gstavdtpsink.c b/audio/gstavdtpsink.c
index 0f3abf3..f379469 100644
--- a/audio/gstavdtpsink.c
+++ b/audio/gstavdtpsink.c
@@ -279,10 +279,10 @@ static gint gst_avdtp_sink_bluetooth_recvmsg_fd(GstAvdtpSink *sink)
 			g_io_channel_unix_get_fd(sink->server));
 
 	if (ret < 0) {
-		err = errno;
+		err = -errno;
 		GST_ERROR_OBJECT(sink, "Unable to receive fd: %s (%d)",
-				strerror(err), err);
-		return -err;
+				strerror(-err), -err);
+		return err;
 	}
 
 	sink->stream = g_io_channel_unix_new(ret);
@@ -1449,9 +1449,9 @@ static gboolean gst_avdtp_sink_start(GstBaseSink *basesink)
 
 	sk = bt_audio_service_open();
 	if (sk <= 0) {
-		err = errno;
+		err = -errno;
 		GST_ERROR_OBJECT(self, "Cannot open connection to bt "
-			"audio service: %s %d", strerror(err), err);
+			"audio service: %s %d", strerror(-err), -err);
 		goto failed;
 	}
 
@@ -1841,7 +1841,7 @@ static int gst_avdtp_sink_audioservice_send(GstAvdtpSink *self,
 	ssize_t written;
 	const char *type, *name;
 	uint16_t length;
-	int fd;
+	int fd, err;
 
 	length = msg->length ? msg->length : BT_SUGGESTED_BUFFER_SIZE;
 
@@ -1849,9 +1849,10 @@ static int gst_avdtp_sink_audioservice_send(GstAvdtpSink *self,
 
 	written = write(fd, msg, length);
 	if (written < 0) {
+		err = -errno;
 		GST_ERROR_OBJECT(self, "Error sending data to audio service:"
-			" %s", strerror(errno));
-		return -errno;
+			" %s", strerror(-err));
+		return err;
 	}
 
 	type = bt_audio_strtype(msg->type);
@@ -1876,9 +1877,10 @@ static int gst_avdtp_sink_audioservice_recv(GstAvdtpSink *self,
 
 	bytes_read = read(fd, inmsg, length);
 	if (bytes_read < 0) {
+		err = -errno;
 		GST_ERROR_OBJECT(self, "Error receiving data from "
-				"audio service: %s", strerror(errno));
-		return -errno;
+				"audio service: %s", strerror(-err));
+		return err;
 	}
 
 	type = bt_audio_strtype(inmsg->type);
-- 
1.7.0.4

