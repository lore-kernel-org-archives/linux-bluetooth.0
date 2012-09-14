Return-Path: <cyrus@holtmann.org>
From: Syam Sidhardhan <s.syam@samsung.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v0 3/4] gstavdtpsink: Free the D-Bus error on reply
 failure
Date: Fri, 14 Sep 2012 21:40:10 +0530
Message-id: <1347639011-22924-3-git-send-email-s.syam@samsung.com>
In-reply-to: <1347639011-22924-1-git-send-email-s.syam@samsung.com>
References: <1347639011-22924-1-git-send-email-s.syam@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

If D-Bus error is set we should free it.
---
I'm not sure whether we can split the error message or not.

 audio/gstavdtpsink.c |   18 +++++++++++++-----
 1 files changed, 13 insertions(+), 5 deletions(-)

diff --git a/audio/gstavdtpsink.c b/audio/gstavdtpsink.c
index ffaed7f..3427043 100644
--- a/audio/gstavdtpsink.c
+++ b/audio/gstavdtpsink.c
@@ -786,13 +786,22 @@ static gboolean gst_avdtp_sink_transport_get_properties(GstAvdtpSink *self)
 	msg = dbus_message_new_method_call("org.bluez", self->transport,
 						"org.bluez.MediaTransport",
 						"GetProperties");
+	if (!msg) {
+		GST_ERROR_OBJECT(self, "D-Bus Memory allocation failed");
+		return FALSE;
+	}
+
 	reply = dbus_connection_send_with_reply_and_block(self->data->conn,
 							msg, -1, &err);
+	dbus_message_unref(msg);
 
-	if (dbus_error_is_set(&err) || reply == NULL) {
-		GST_ERROR_OBJECT(self, "Failed to get transport properties: %s",
-					err.message);
-		goto fail;
+	if (!reply) {
+		if (dbus_error_is_set(&err)) {
+			GST_ERROR_OBJECT(self, "Failed to get transport "
+						"properties: %s", err.message);
+			dbus_error_free(&err);
+		}
+		return FALSE;
 	}
 
 	if (!dbus_message_iter_init(reply, &arg_i)) {
@@ -824,7 +833,6 @@ static gboolean gst_avdtp_sink_transport_get_properties(GstAvdtpSink *self)
 	return gst_avdtp_sink_update_caps(self);
 
 fail:
-	dbus_message_unref(msg);
 	dbus_message_unref(reply);
 	return FALSE;
 
-- 
1.7.4.1

