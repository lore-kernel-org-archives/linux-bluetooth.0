Return-Path: <cyrus@holtmann.org>
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
To: linux-bluetooth@vger.kernel.org
Cc: Lucas De Marchi <lucas.de.marchi@gmail.com>
Subject: [PATCH BlueZ 4/8] adapter: Refactor set_mode() in 2 functions
Date: Tue,  9 Oct 2012 04:59:52 -0300
Message-Id: <1349769596-6050-4-git-send-email-lucas.demarchi@profusion.mobi>
In-Reply-To: <1349769596-6050-1-git-send-email-lucas.demarchi@profusion.mobi>
References: <1349769596-6050-1-git-send-email-lucas.demarchi@profusion.mobi>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Lucas De Marchi <lucas.de.marchi@gmail.com>

Separate the handling of pending_mode from setting mode. This way it's
simpler to set the pending_mode only when needed. Half of callers were
passing NULL to this parameter.
---
 src/adapter.c | 78 +++++++++++++++++++++++++++++++----------------------------
 1 file changed, 41 insertions(+), 37 deletions(-)

diff --git a/src/adapter.c b/src/adapter.c
index cc0ec3b..c9ae8ca 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -278,8 +278,7 @@ static struct session_req *find_session_by_msg(GSList *list, const DBusMessage *
 	return NULL;
 }
 
-static int set_mode(struct btd_adapter *adapter, uint8_t new_mode,
-			DBusMessage *msg)
+static int set_mode(struct btd_adapter *adapter, uint8_t new_mode)
 {
 	int err;
 	const char *modestr;
@@ -319,22 +318,25 @@ done:
 
 	DBG("%s", modestr);
 
-	if (msg != NULL) {
-		struct session_req *req;
+	return 0;
+}
 
-		req = find_session_by_msg(adapter->mode_sessions, msg);
-		if (req) {
-			adapter->pending_mode = req;
-			session_ref(req);
-		} else
-			/* Wait for mode change to reply */
-			adapter->pending_mode = create_session(adapter, msg,
-								new_mode, NULL);
-	} else
-		/* Nothing to reply just write the new mode */
-		adapter->mode = new_mode;
+static void set_pending_mode(struct btd_adapter *adapter, uint8_t new_mode,
+							DBusMessage *msg)
+{
+	struct session_req *req;
 
-	return 0;
+	/*
+	 * Schedule the reply to be sent when a mode-change notification
+	 * arrives. The reply will be sent by set_mode_complete().
+	 */
+	req = find_session_by_msg(adapter->mode_sessions, msg);
+	if (req) {
+		adapter->pending_mode = req;
+		session_ref(req);
+	} else
+		adapter->pending_mode = create_session(adapter, msg, new_mode,
+									NULL);
 }
 
 static DBusMessage *set_discoverable(DBusMessage *msg,
@@ -351,10 +353,12 @@ static DBusMessage *set_discoverable(DBusMessage *msg,
 		return dbus_message_new_method_return(msg);
 	}
 
-	err = set_mode(adapter, mode, msg);
+	err = set_mode(adapter, mode);
 	if (err < 0)
 		return btd_error_failed(msg, strerror(-err));
 
+	set_pending_mode(adapter, mode, msg);
+
 	return NULL;
 }
 
@@ -376,10 +380,12 @@ static DBusMessage *set_powered(DBusMessage *msg, gboolean powered, void *data)
 		return dbus_message_new_method_return(msg);
 	}
 
-	err = set_mode(adapter, mode, msg);
+	err = set_mode(adapter, mode);
 	if (err < 0)
 		return btd_error_failed(msg, strerror(-err));
 
+	set_pending_mode(adapter, mode, msg);
+
 	return NULL;
 }
 
@@ -398,7 +404,7 @@ static DBusMessage *set_pairable(DBusMessage *msg,
 	if (!(adapter->scan_mode & SCAN_INQUIRY))
 		goto store;
 
-	err = set_mode(adapter, MODE_DISCOVERABLE, NULL);
+	err = set_mode(adapter, MODE_DISCOVERABLE);
 	if (err < 0 && msg)
 		return btd_error_failed(msg, strerror(-err));
 
@@ -549,7 +555,7 @@ static void session_remove(struct session_req *req)
 
 		DBG("Switching to '%s' mode", mode2str(mode));
 
-		set_mode(adapter, mode, NULL);
+		set_mode(adapter, mode);
 	} else {
 		adapter->disc_sessions = g_slist_remove(adapter->disc_sessions,
 							req);
@@ -620,28 +626,26 @@ static void confirm_mode_cb(struct agent *agent, DBusError *derr, void *data)
 		return;
 	}
 
-	err = set_mode(req->adapter, req->mode, req->msg);
+	err = set_mode(req->adapter, req->mode);
+	if (err >= 0 && req->adapter->mode != req->mode) {
+		set_pending_mode(req->adapter, req->mode, req->msg);
+		goto done;
+	}
+
 	if (err < 0)
 		reply = btd_error_failed(req->msg, strerror(-err));
-	else if (!req->adapter->pending_mode)
-		reply = dbus_message_new_method_return(req->msg);
 	else
-		reply = NULL;
-
-	if (reply) {
-		/*
-		 * Send reply immediately only if there was an error changing
-		 * mode, or change is not needed. Otherwise, reply is sent in
-		 * set_mode_complete.
-		 */
-		g_dbus_send_message(conn, reply);
+		reply = dbus_message_new_method_return(req->msg);
 
-		dbus_message_unref(req->msg);
-		req->msg = NULL;
-	}
+	/*
+	 * Send reply immediately only if there was an error changing mode, or
+	 * change is not needed. Otherwise, reply is sent in
+	 * set_mode_complete.
+	 */
+	g_dbus_send_message(conn, reply);
 
-	if (!find_session(req->adapter->mode_sessions, req->owner))
-		session_unref(req);
+done:
+	session_unref(req);
 }
 
 static void set_discoverable_timeout(struct btd_adapter *adapter,
-- 
1.7.12.2

