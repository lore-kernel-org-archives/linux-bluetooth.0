Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/5] Fix not waiting mode change when setting powered property
Date: Thu, 28 Oct 2010 11:00:56 +0300
Message-Id: <1288252859-10337-2-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1288252859-10337-1-git-send-email-luiz.dentz@gmail.com>
References: <1288252859-10337-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.dentz-von@nokia.com>

This may cause errors if the user application immediately set another
mode.
---
 src/adapter.c |   84 +++++++++++++++++++++++++++++---------------------------
 1 files changed, 43 insertions(+), 41 deletions(-)

diff --git a/src/adapter.c b/src/adapter.c
index 98d96e2..f4fc3c1 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -604,11 +604,11 @@ static DBusMessage *set_powered(DBusConnection *conn, DBusMessage *msg,
 	if (mode == adapter->mode)
 		return dbus_message_new_method_return(msg);
 
-	err = set_mode(adapter, mode, NULL);
+	err = set_mode(adapter, mode, msg);
 	if (err < 0)
 		return failed_strerror(msg, -err);
 
-	return dbus_message_new_method_return(msg);
+	return NULL;
 }
 
 static DBusMessage *set_discoverable(DBusConnection *conn, DBusMessage *msg,
@@ -2570,6 +2570,45 @@ static void unload_drivers(struct btd_adapter *adapter)
 	}
 }
 
+static void set_mode_complete(struct btd_adapter *adapter)
+{
+	struct session_req *pending;
+	const char *modestr;
+	int err;
+
+	if (adapter->pending_mode == NULL)
+		return;
+
+	pending = adapter->pending_mode;
+	adapter->pending_mode = NULL;
+
+	err = (pending->mode != adapter->mode) ? -EINVAL : 0;
+
+	if (pending->msg != NULL) {
+		DBusMessage *msg = pending->msg;
+		DBusMessage *reply;
+
+		if (err < 0)
+			reply = failed_strerror(msg, -err);
+		else
+			reply = g_dbus_create_reply(msg, DBUS_TYPE_INVALID);
+
+		g_dbus_send_message(connection, reply);
+	}
+
+	modestr = mode2str(adapter->mode);
+
+	DBG("%s", modestr);
+
+	/* Only store if the mode matches the pending */
+	if (err == 0)
+		write_device_mode(&adapter->bdaddr, modestr);
+	else
+		error("unable to set mode: %s", mode2str(pending->mode));
+
+	session_unref(pending);
+}
+
 int adapter_stop(struct btd_adapter *adapter)
 {
 	gboolean powered, discoverable, pairable;
@@ -2628,6 +2667,8 @@ int adapter_stop(struct btd_adapter *adapter)
 
 	info("Adapter %s has been disabled", adapter->path);
 
+	set_mode_complete(adapter);
+
 	return 0;
 }
 
@@ -3137,45 +3178,6 @@ int adapter_remove_found_device(struct btd_adapter *adapter, bdaddr_t *bdaddr)
 	return 0;
 }
 
-static void set_mode_complete(struct btd_adapter *adapter)
-{
-	struct session_req *pending;
-	const char *modestr;
-	int err;
-
-	if (adapter->pending_mode == NULL)
-		return;
-
-	pending = adapter->pending_mode;
-	adapter->pending_mode = NULL;
-
-	err = (pending->mode != adapter->mode) ? -EINVAL : 0;
-
-	if (pending->msg != NULL) {
-		DBusMessage *msg = pending->msg;
-		DBusMessage *reply;
-
-		if (err < 0)
-			reply = failed_strerror(msg, -err);
-		else
-			reply = g_dbus_create_reply(msg, DBUS_TYPE_INVALID);
-
-		g_dbus_send_message(connection, reply);
-	}
-
-	modestr = mode2str(adapter->mode);
-
-	DBG("%s", modestr);
-
-	/* Only store if the mode matches the pending */
-	if (err == 0)
-		write_device_mode(&adapter->bdaddr, modestr);
-	else
-		error("unable to set mode: %s", mode2str(pending->mode));
-
-	session_unref(pending);
-}
-
 void adapter_mode_changed(struct btd_adapter *adapter, uint8_t scan_mode)
 {
 	const gchar *path = adapter_get_path(adapter);
-- 
1.7.1

