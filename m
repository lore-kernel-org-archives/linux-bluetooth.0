Return-Path: <cyrus@holtmann.org>
From: Dmitriy Paliy <dmitriy.paliy@nokia.com>
To: linux-bluetooth@vger.kernel.org
Cc: Dmitriy Paliy <dmitriy.paliy@nokia.com>
Subject: [PATCH BlueZ v2 2/5] Fix error handling in start_dtmf_reply
Date: Tue, 27 Sep 2011 13:22:44 +0300
Message-Id: <1317118967-18469-3-git-send-email-dmitriy.paliy@nokia.com>
In-Reply-To: <1317118967-18469-1-git-send-email-dmitriy.paliy@nokia.com>
References: <1317118967-18469-1-git-send-email-dmitriy.paliy@nokia.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

If csd replyed with error to StartDTMF, then StopDTMF method call
is not sent.
---
 audio/telephony-maemo6.c |   17 ++++++++++++++++-
 1 files changed, 16 insertions(+), 1 deletions(-)

diff --git a/audio/telephony-maemo6.c b/audio/telephony-maemo6.c
index ad5d06f..1f3cdef 100644
--- a/audio/telephony-maemo6.c
+++ b/audio/telephony-maemo6.c
@@ -734,10 +734,25 @@ void telephony_dial_number_req(void *telephony_device, const char *number)
 
 static void start_dtmf_reply(DBusPendingCall *call, void *user_data)
 {
-	send_method_call(CSD_CALL_BUS_NAME, CSD_CALL_PATH,
+	DBusError err;
+	DBusMessage *reply;
+
+	reply = dbus_pending_call_steal_reply(call);
+
+	dbus_error_init(&err);
+	if (dbus_set_error_from_message(&err, reply)) {
+		error("csd replied with an error: %s, %s",
+				err.name, err.message);
+
+		dbus_error_free(&err);
+	} else
+		send_method_call(CSD_CALL_BUS_NAME, CSD_CALL_PATH,
 				CSD_CALL_INTERFACE, "StopDTMF",
 				NULL, NULL,
 				DBUS_TYPE_INVALID);
+
+	dbus_message_unref(reply);
+	dbus_pending_call_unref(call);
 }
 
 static void start_dtmf(void *telephony_device, char tone)
-- 
1.7.4.1

