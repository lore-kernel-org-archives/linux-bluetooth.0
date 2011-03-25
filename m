Return-Path: <cyrus@holtmann.org>
From: Dmitriy Paliy <dmitriy.paliy@nokia.com>
To: linux-bluetooth@vger.kernel.org
Cc: Dmitriy Paliy <dmitriy.paliy@nokia.com>
Subject: [PATCH 2/2] Add ERROR response on AT+BLDN command for maemo6
Date: Fri, 25 Mar 2011 18:44:09 +0200
Message-Id: <1301071449-22230-3-git-send-email-dmitriy.paliy@nokia.com>
In-Reply-To: <1301071449-22230-1-git-send-email-dmitriy.paliy@nokia.com>
References: <1301071449-22230-1-git-send-email-dmitriy.paliy@nokia.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Response on AT+BLDN command in maemo6 telephony driver is added to be
sent after confirmation from csd back-end. Both ERROR or OK codes are
sent only after asynchronous response on D-Bus call is available.
---
 audio/telephony-maemo6.c |   26 +++++++++++++++++++++++---
 1 files changed, 23 insertions(+), 3 deletions(-)

diff --git a/audio/telephony-maemo6.c b/audio/telephony-maemo6.c
index 9650cba..0cef7dd 100644
--- a/audio/telephony-maemo6.c
+++ b/audio/telephony-maemo6.c
@@ -618,6 +618,28 @@ static void remove_pending(DBusPendingCall *call)
 	pending_req_finalize(req);
 }
 
+static void last_number_call_reply(DBusPendingCall *call, void *user_data)
+{
+	DBusError err;
+	DBusMessage *reply;
+	void *telephony_device = user_data;
+
+	reply = dbus_pending_call_steal_reply(call);
+
+	dbus_error_init(&err);
+	if (dbus_set_error_from_message(&err, reply)) {
+		error("csd replied with an error: %s, %s",
+				err.name, err.message);
+		dbus_error_free(&err);
+		telephony_dial_number_rsp(telephony_device,
+							CME_ERROR_AG_FAILURE);
+	} else
+		telephony_dial_number_rsp(telephony_device, CME_ERROR_NONE);
+
+	dbus_message_unref(reply);
+	remove_pending(call);
+}
+
 void telephony_last_dialed_number_req(void *telephony_device)
 {
 	int ret;
@@ -626,13 +648,11 @@ void telephony_last_dialed_number_req(void *telephony_device)
 
 	ret = send_method_call(CSD_CALL_BUS_NAME, CSD_CALL_PATH,
 				CSD_CALL_INTERFACE, "CreateFromLast",
-				NULL, NULL,
+				last_number_call_reply, telephony_device,
 				DBUS_TYPE_INVALID);
 	if (ret < 0)
 		telephony_dial_number_rsp(telephony_device,
 						CME_ERROR_AG_FAILURE);
-	else
-		telephony_dial_number_rsp(telephony_device, CME_ERROR_NONE);
 }
 
 static const char *memory_dial_lookup(int location)
-- 
1.7.1

