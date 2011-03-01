Return-Path: <cyrus@holtmann.org>
From: Dmitriy Paliy <dmitriy.paliy@nokia.com>
To: linux-bluetooth@vger.kernel.org, luiz.dentz@gmail.com
Cc: Dmitriy Paliy <dmitriy.paliy@nokia.com>
Subject: [PATCH] Fix response on adapter RequestSession method
Date: Tue,  1 Mar 2011 16:25:35 +0200
Message-Id: <1298989535-403-2-git-send-email-dmitriy.paliy@nokia.com>
In-Reply-To: <1298989535-403-1-git-send-email-dmitriy.paliy@nokia.com>
References: <1298989535-403-1-git-send-email-dmitriy.paliy@nokia.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Fixes response on adapter RequestSession method to be sent after mode is
changed, if such is necessary. More specifically change of power off mode
to power on is in question.

Currenty, response is sent when mode change is confirmed by agent, not by
response from controller. Such may lead to failed CreateDevice method if
it is called quickly enough after RequestSession when controller is in
powered off state.

New session is not created if there is already a session for such D-Bus
message.
---
 src/adapter.c |   51 +++++++++++++++++++++++++++++++++++++++++++--------
 1 files changed, 43 insertions(+), 8 deletions(-)

diff --git a/src/adapter.c b/src/adapter.c
index 2e11832..e973aa3 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -452,6 +452,20 @@ static int adapter_set_mode(struct btd_adapter *adapter, uint8_t mode)
 	return 0;
 }
 
+static struct session_req *find_session_by_msg(GSList *list, const DBusMessage *msg)
+{
+	GSList *l;
+
+	for (l = list; l; l = l->next) {
+		struct session_req *req = l->data;
+
+		if (req->msg == msg)
+			return req;
+	}
+
+	return NULL;
+}
+
 static int set_mode(struct btd_adapter *adapter, uint8_t new_mode,
 			DBusMessage *msg)
 {
@@ -496,11 +510,18 @@ done:
 
 	DBG("%s", modestr);
 
-	if (msg != NULL)
-		/* Wait for mode change to reply */
-		adapter->pending_mode = create_session(adapter, connection,
-							msg, new_mode, NULL);
-	else
+	if (msg != NULL) {
+		struct session_req *req;
+
+		req = find_session_by_msg(adapter->mode_sessions, msg);
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
 
@@ -795,17 +816,31 @@ static void confirm_mode_cb(struct agent *agent, DBusError *derr, void *data)
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
-- 
1.7.1

