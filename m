Return-Path: <cyrus@holtmann.org>
From: Syam Sidhardhan <s.syam@samsung.com>
To: linux-bluetooth@vger.kernel.org
Cc: Syam Sidhardhan <s.syam@samsung.com>
Subject: [PATCH BlueZ 04/19] gstavdtpsink: Fix D-Bus memory leak in audio
Date: Thu, 12 Apr 2012 20:32:55 +0530
Message-id: <1334243001-17016-5-git-send-email-s.syam@samsung.com>
In-reply-to: <1334243001-17016-1-git-send-email-s.syam@samsung.com>
References: <1334243001-17016-1-git-send-email-s.syam@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 audio/gstavdtpsink.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/audio/gstavdtpsink.c b/audio/gstavdtpsink.c
index c5392c5..b448d57 100644
--- a/audio/gstavdtpsink.c
+++ b/audio/gstavdtpsink.c
@@ -1336,6 +1336,8 @@ static gboolean gst_avdtp_sink_transport_acquire(GstAvdtpSink *self)
 	reply = dbus_connection_send_with_reply_and_block(self->data->conn,
 							msg, -1, &err);
 
+	dbus_message_unref(msg);
+
 	if (dbus_error_is_set(&err))
 		goto fail;
 
@@ -1362,7 +1364,7 @@ fail:
 	dbus_error_free(&err);
 
 	if (reply)
-		dbus_message_unref(msg);
+		dbus_message_unref(reply);
 
 	return FALSE;
 }
-- 
1.7.4.1

