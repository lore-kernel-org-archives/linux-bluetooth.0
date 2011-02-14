Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 3/3] Fix not updating call indicator when parsing call info reply
Date: Mon, 14 Feb 2011 12:21:22 +0200
Message-Id: <1297678882-26893-3-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1297678882-26893-1-git-send-email-luiz.dentz@gmail.com>
References: <1297678882-26893-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.dentz-von@nokia.com>

This can happen if there is a call with a status different than idle when
adaptor is turned on the call indicators weren't updated.
---
 audio/telephony-maemo6.c |   63 ++++++++++++++++++++++++++-------------------
 1 files changed, 36 insertions(+), 27 deletions(-)

diff --git a/audio/telephony-maemo6.c b/audio/telephony-maemo6.c
index 0ab1a77..0ba21b8 100644
--- a/audio/telephony-maemo6.c
+++ b/audio/telephony-maemo6.c
@@ -973,35 +973,13 @@ static void handle_create_requested(DBusMessage *msg)
 					EV_CALLSETUP_OUTGOING);
 }
 
-static void handle_call_status(DBusMessage *msg, const char *call_path)
+static void call_set_status(struct csd_call *call, dbus_uint32_t status)
 {
-	struct csd_call *call;
-	dbus_uint32_t status, cause_type, cause, prev_status;
+	dbus_uint32_t prev_status;
 	int callheld = telephony_get_indicator(maemo_indicators, "callheld");
 
-	if (!dbus_message_get_args(msg, NULL,
-					DBUS_TYPE_UINT32, &status,
-					DBUS_TYPE_UINT32, &cause_type,
-					DBUS_TYPE_UINT32, &cause,
-					DBUS_TYPE_INVALID)) {
-		error("Unexpected paramters in Instance.CallStatus() signal");
-		return;
-	}
-
-	call = find_call(call_path);
-	if (!call) {
-		error("Didn't find any matching call object for %s",
-				call_path);
-		return;
-	}
-
-	if (status > 16) {
-		error("Invalid call status %u", status);
-		return;
-	}
-
 	prev_status = call->status;
-	DBG("Call %s changed from %s to %s", call_path,
+	DBG("Call %s changed from %s to %s", call->object_path,
 		call_status_str[prev_status], call_status_str[status]);
 
 	if (prev_status == status) {
@@ -1132,6 +1110,35 @@ static void handle_call_status(DBusMessage *msg, const char *call_path)
 	}
 }
 
+static void handle_call_status(DBusMessage *msg, const char *call_path)
+{
+	struct csd_call *call;
+	dbus_uint32_t status, cause_type, cause;
+
+	if (!dbus_message_get_args(msg, NULL,
+					DBUS_TYPE_UINT32, &status,
+					DBUS_TYPE_UINT32, &cause_type,
+					DBUS_TYPE_UINT32, &cause,
+					DBUS_TYPE_INVALID)) {
+		error("Unexpected paramters in Instance.CallStatus() signal");
+		return;
+	}
+
+	call = find_call(call_path);
+	if (!call) {
+		error("Didn't find any matching call object for %s",
+				call_path);
+		return;
+	}
+
+	if (status > 16) {
+		error("Invalid call status %u", status);
+		return;
+	}
+
+	call_set_status(call, status);
+}
+
 static void handle_conference(DBusMessage *msg, gboolean joined)
 {
 	const char *path;
@@ -1470,13 +1477,12 @@ static void parse_call_list(DBusMessageIter *iter)
 		if (!call) {
 			call = g_new0(struct csd_call, 1);
 			call->object_path = g_strdup(object_path);
-			call->status = (int) status;
 			calls = g_slist_append(calls, call);
 			DBG("telephony-maemo6: new csd call instance at %s",
 								object_path);
 		}
 
-		if (call->status == CSD_CALL_STATUS_IDLE)
+		if (status == CSD_CALL_STATUS_IDLE)
 			continue;
 
 		/* CSD gives incorrect call_hold property sometimes */
@@ -1493,6 +1499,9 @@ static void parse_call_list(DBusMessageIter *iter)
 		g_free(call->number);
 		call->number = g_strdup(number);
 
+		/* Update indicators */
+		call_set_status(call, status);
+
 	} while (dbus_message_iter_next(iter));
 }
 
-- 
1.7.1

