Return-Path: <cyrus@holtmann.org>
From: Marcin Kraglak <marcin.kraglak@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/4] audio/avctp: Pass error argument to avctp_state_changed callback
Date: Wed, 11 Mar 2015 19:11:00 +0100
Message-Id: <1426097463-5288-2-git-send-email-marcin.kraglak@tieto.com>
In-Reply-To: <1426097463-5288-1-git-send-email-marcin.kraglak@tieto.com>
References: <1426097463-5288-1-git-send-email-marcin.kraglak@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This additional argument will help higher layer to recognize what action should be
taken in error condition.
---
 profiles/audio/avctp.c   | 38 ++++++++++++++++++++------------------
 profiles/audio/avctp.h   |  2 +-
 profiles/audio/avrcp.c   |  3 ++-
 profiles/audio/control.c |  3 ++-
 4 files changed, 25 insertions(+), 21 deletions(-)

diff --git a/profiles/audio/avctp.c b/profiles/audio/avctp.c
index 9f9f1c9..14b0266 100644
--- a/profiles/audio/avctp.c
+++ b/profiles/audio/avctp.c
@@ -573,7 +573,8 @@ static void avctp_disconnected(struct avctp *session)
 	g_free(session);
 }
 
-static void avctp_set_state(struct avctp *session, avctp_state_t new_state)
+static void avctp_set_state(struct avctp *session, avctp_state_t new_state,
+									int err)
 {
 	GSList *l;
 	avctp_state_t old_state = session->state;
@@ -586,7 +587,8 @@ static void avctp_set_state(struct avctp *session, avctp_state_t new_state)
 		if (cb->dev && cb->dev != session->device)
 			continue;
 
-		cb->cb(session->device, old_state, new_state, cb->user_data);
+		cb->cb(session->device, old_state, new_state, err,
+								cb->user_data);
 	}
 
 	switch (new_state) {
@@ -940,7 +942,7 @@ send:
 
 failed:
 	DBG("AVCTP Browsing: disconnected");
-	avctp_set_state(session, AVCTP_STATE_CONNECTED);
+	avctp_set_state(session, AVCTP_STATE_CONNECTED, 0);
 
 	if (session->browsing) {
 		avctp_channel_destroy(session->browsing);
@@ -1036,7 +1038,7 @@ done:
 
 failed:
 	DBG("AVCTP session %p got disconnected", session);
-	avctp_set_state(session, AVCTP_STATE_DISCONNECTED);
+	avctp_set_state(session, AVCTP_STATE_DISCONNECTED, -EIO);
 	return FALSE;
 }
 
@@ -1193,7 +1195,7 @@ static void avctp_connect_browsing_cb(GIOChannel *chan, GError *err,
 				G_IO_IN | G_IO_ERR | G_IO_HUP | G_IO_NVAL,
 				(GIOFunc) session_browsing_cb, session);
 
-	avctp_set_state(session, AVCTP_STATE_BROWSING_CONNECTED);
+	avctp_set_state(session, AVCTP_STATE_BROWSING_CONNECTED, 0);
 
 	/* Process any request that was pending the connection to complete */
 	if (browsing->process_id == 0 && !g_queue_is_empty(browsing->queue))
@@ -1202,7 +1204,7 @@ static void avctp_connect_browsing_cb(GIOChannel *chan, GError *err,
 	return;
 
 fail:
-	avctp_set_state(session, AVCTP_STATE_CONNECTED);
+	avctp_set_state(session, AVCTP_STATE_CONNECTED, 0);
 
 	if (session->browsing) {
 		avctp_channel_destroy(session->browsing);
@@ -1218,7 +1220,7 @@ static void avctp_connect_cb(GIOChannel *chan, GError *err, gpointer data)
 	GError *gerr = NULL;
 
 	if (err) {
-		avctp_set_state(session, AVCTP_STATE_DISCONNECTED);
+		avctp_set_state(session, AVCTP_STATE_DISCONNECTED, -EIO);
 		error("%s", err->message);
 		return;
 	}
@@ -1229,7 +1231,7 @@ static void avctp_connect_cb(GIOChannel *chan, GError *err, gpointer data)
 			BT_IO_OPT_IMTU, &omtu,
 			BT_IO_OPT_INVALID);
 	if (gerr) {
-		avctp_set_state(session, AVCTP_STATE_DISCONNECTED);
+		avctp_set_state(session, AVCTP_STATE_DISCONNECTED, -EIO);
 		error("%s", gerr->message);
 		g_error_free(gerr);
 		return;
@@ -1262,7 +1264,7 @@ static void avctp_connect_cb(GIOChannel *chan, GError *err, gpointer data)
 
 	init_uinput(session);
 
-	avctp_set_state(session, AVCTP_STATE_CONNECTED);
+	avctp_set_state(session, AVCTP_STATE_CONNECTED, 0);
 }
 
 static void auth_cb(DBusError *derr, void *user_data)
@@ -1279,7 +1281,7 @@ static void auth_cb(DBusError *derr, void *user_data)
 
 	if (derr && dbus_error_is_set(derr)) {
 		error("Access denied: %s", derr->message);
-		avctp_set_state(session, AVCTP_STATE_DISCONNECTED);
+		avctp_set_state(session, AVCTP_STATE_DISCONNECTED, -EIO);
 		return;
 	}
 
@@ -1287,7 +1289,7 @@ static void auth_cb(DBusError *derr, void *user_data)
 								NULL, &err)) {
 		error("bt_io_accept: %s", err->message);
 		g_error_free(err);
-		avctp_set_state(session, AVCTP_STATE_DISCONNECTED);
+		avctp_set_state(session, AVCTP_STATE_DISCONNECTED, -EIO);
 	}
 }
 
@@ -1352,7 +1354,7 @@ static void avctp_control_confirm(struct avctp *session, GIOChannel *chan,
 		return;
 	}
 
-	avctp_set_state(session, AVCTP_STATE_CONNECTING);
+	avctp_set_state(session, AVCTP_STATE_CONNECTING, 0);
 	session->control = avctp_channel_create(session, chan, NULL);
 
 	src = btd_adapter_get_address(device_get_adapter(dev));
@@ -1369,7 +1371,7 @@ static void avctp_control_confirm(struct avctp *session, GIOChannel *chan,
 	return;
 
 drop:
-	avctp_set_state(session, AVCTP_STATE_DISCONNECTED);
+	avctp_set_state(session, AVCTP_STATE_DISCONNECTED, -EIO);
 }
 
 static void avctp_browsing_confirm(struct avctp *session, GIOChannel *chan,
@@ -1385,7 +1387,7 @@ static void avctp_browsing_confirm(struct avctp *session, GIOChannel *chan,
 
 	if (bt_io_accept(chan, avctp_connect_browsing_cb, session, NULL,
 								&err)) {
-		avctp_set_state(session, AVCTP_STATE_BROWSING_CONNECTING);
+		avctp_set_state(session, AVCTP_STATE_BROWSING_CONNECTING, 0);
 		return;
 	}
 
@@ -1975,7 +1977,7 @@ struct avctp *avctp_connect(struct btd_device *device)
 	if (session->state > AVCTP_STATE_DISCONNECTED)
 		return session;
 
-	avctp_set_state(session, AVCTP_STATE_CONNECTING);
+	avctp_set_state(session, AVCTP_STATE_CONNECTING, 0);
 
 	src = btd_adapter_get_address(session->server->adapter);
 
@@ -1987,7 +1989,7 @@ struct avctp *avctp_connect(struct btd_device *device)
 				BT_IO_OPT_PSM, AVCTP_CONTROL_PSM,
 				BT_IO_OPT_INVALID);
 	if (err) {
-		avctp_set_state(session, AVCTP_STATE_DISCONNECTED);
+		avctp_set_state(session, AVCTP_STATE_DISCONNECTED, -EIO);
 		error("%s", err->message);
 		g_error_free(err);
 		return NULL;
@@ -2012,7 +2014,7 @@ int avctp_connect_browsing(struct avctp *session)
 	if (session->browsing != NULL)
 		return 0;
 
-	avctp_set_state(session, AVCTP_STATE_BROWSING_CONNECTING);
+	avctp_set_state(session, AVCTP_STATE_BROWSING_CONNECTING, 0);
 
 	src = btd_adapter_get_address(session->server->adapter);
 
@@ -2042,7 +2044,7 @@ void avctp_disconnect(struct avctp *session)
 	if (session->state == AVCTP_STATE_DISCONNECTED)
 		return;
 
-	avctp_set_state(session, AVCTP_STATE_DISCONNECTED);
+	avctp_set_state(session, AVCTP_STATE_DISCONNECTED, -EIO);
 }
 
 struct avctp *avctp_get(struct btd_device *device)
diff --git a/profiles/audio/avctp.h b/profiles/audio/avctp.h
index 05fceb4..6c19ce4 100644
--- a/profiles/audio/avctp.h
+++ b/profiles/audio/avctp.h
@@ -122,7 +122,7 @@ typedef enum {
 typedef void (*avctp_state_cb) (struct btd_device *dev,
 				avctp_state_t old_state,
 				avctp_state_t new_state,
-				void *user_data);
+				int err, void *user_data);
 
 typedef bool (*avctp_passthrough_cb) (struct avctp *session,
 					uint8_t op, bool pressed,
diff --git a/profiles/audio/avrcp.c b/profiles/audio/avrcp.c
index a67b81e..dc57770 100644
--- a/profiles/audio/avrcp.c
+++ b/profiles/audio/avrcp.c
@@ -3569,7 +3569,8 @@ static struct avrcp *session_create(struct avrcp_server *server,
 }
 
 static void state_changed(struct btd_device *device, avctp_state_t old_state,
-				avctp_state_t new_state, void *user_data)
+					avctp_state_t new_state, int err,
+					void *user_data)
 {
 	struct avrcp_server *server;
 	struct avrcp *session;
diff --git a/profiles/audio/control.c b/profiles/audio/control.c
index 9110b0f..4db5b92 100644
--- a/profiles/audio/control.c
+++ b/profiles/audio/control.c
@@ -71,7 +71,8 @@ struct control {
 };
 
 static void state_changed(struct btd_device *dev, avctp_state_t old_state,
-				avctp_state_t new_state, void *user_data)
+					avctp_state_t new_state, int err,
+					void *user_data)
 {
 	struct control *control = user_data;
 	DBusConnection *conn = btd_get_dbus_connection();
-- 
2.1.0

