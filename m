Return-Path: <cyrus@holtmann.org>
From: Dmitriy Paliy <dmitriy.paliy@nokia.com>
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Cc: Dmitriy Paliy <dmitriy.paliy@nokia.com>
Subject: [PATCH 2/2] Fix response on adapter RequestSession method
Date: Mon, 28 Feb 2011 13:34:25 +0200
Message-Id: <1298892865-14930-3-git-send-email-dmitriy.paliy@nokia.com>
In-Reply-To: <1298892865-14930-1-git-send-email-dmitriy.paliy@nokia.com>
References: <1298892865-14930-1-git-send-email-dmitriy.paliy@nokia.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Fixes response on adapter RequestSession method to be sent after mode is
changed. More specifically change of power off mode to power on is in
question.

Currenty, response is sent when mode change is confirmed by agent, not by
response from controller. Such may lead to failed CreateDevice method if
it is called quickly enough after RequestSession when controller is
powered off.
---
 src/adapter.c |   45 ++++++++++++++++++++++++++++++++++++---------
 1 files changed, 36 insertions(+), 9 deletions(-)

diff --git a/src/adapter.c b/src/adapter.c
index 49a23ec..5cdb371 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -510,11 +510,19 @@ done:
 
 	DBG("%s", modestr);
 
-	if (msg != NULL)
-		/* Wait for mode change to reply */
-		adapter->pending_mode = create_session(adapter, connection,
-							msg, new_mode, NULL);
-	else
+	if (msg != NULL) {
+		const char *sender = dbus_message_get_sender(msg);
+		struct session_req *req;
+
+		req = find_session(adapter->mode_sessions, sender);
+		if (req) {
+			adapter->pending_mode = req;
+			session_ref(req);
+		} else
+			/* Wait for mode change to reply */
+			adapter->pending_mode = create_session(adapter,
+					connection, msg, new_mode, NULL);
+	} else
 		/* Nothing to reply just write the new mode */
 		adapter->mode = new_mode;
 
@@ -795,17 +803,31 @@ static void confirm_mode_cb(struct agent *agent, DBusError *derr, void *data)
 		return;
 	}
 
-	err = set_mode(req->adapter, req->mode, NULL);
-	if (err < 0)
+	err = set_mode(req->adapter, req->mode, req->msg);
+	if (err < 0) {
 		reply = btd_error_failed(req->msg, strerror(-err));
-	else
+		goto proceed;
+	}
+
+	if (!req->adapter->pending_mode) {
 		reply = dbus_message_new_method_return(req->msg);
+		goto proceed;
+	}
+
+	goto done;
 
+proceed:
+	/*
+	 * Send reply immidiately only if there was an error changing
+	 * mode, or change is not needed. Otherwise, reply is sent in
+	 * set_mode_complete.
+	 */
 	g_dbus_send_message(req->conn, reply);
 
 	dbus_message_unref(req->msg);
 	req->msg = NULL;
 
+done:
 	if (!find_session(req->adapter->mode_sessions, req->owner))
 		session_unref(req);
 }
@@ -2485,7 +2507,12 @@ static void set_mode_complete(struct btd_adapter *adapter)
 			if (strcmp(dbus_message_get_member(msg),
 						"SetProperty") == 0)
 				adapter->global_mode = adapter->mode;
-			reply = g_dbus_create_reply(msg, DBUS_TYPE_INVALID);
+
+			if (strcmp(dbus_message_get_member(msg),
+						"RequestSession") == 0)
+				reply = dbus_message_new_method_return(msg);
+			else
+				reply = g_dbus_create_reply(msg, DBUS_TYPE_INVALID);
 		}
 
 		g_dbus_send_message(connection, reply);
-- 
1.7.1

