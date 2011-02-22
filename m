Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH] Fix not setting global mode when SetProperty is used
Date: Tue, 22 Feb 2011 11:26:13 +0200
Message-Id: <1298366773-5781-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.dentz-von@nokia.com>

Global mode should be overwrite if user application change the adapter
mode by using SetProperty while there are sessions active, otherwise when
this sessions are released the mode restored will be the global mode from
before the sessions were created and not the mode set with SetProperty.
---
 src/adapter.c |   14 +++++++++++---
 1 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/src/adapter.c b/src/adapter.c
index dbae219..2e11832 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -516,8 +516,10 @@ static DBusMessage *set_discoverable(DBusConnection *conn, DBusMessage *msg,
 
 	mode = discoverable ? MODE_DISCOVERABLE : MODE_CONNECTABLE;
 
-	if (mode == adapter->mode)
+	if (mode == adapter->mode) {
+		adapter->global_mode = mode;
 		return dbus_message_new_method_return(msg);
+	}
 
 	err = set_mode(adapter, mode, msg);
 	if (err < 0)
@@ -541,8 +543,10 @@ static DBusMessage *set_powered(DBusConnection *conn, DBusMessage *msg,
 
 	mode = MODE_OFF;
 
-	if (mode == adapter->mode)
+	if (mode == adapter->mode) {
+		adapter->global_mode = mode;
 		return dbus_message_new_method_return(msg);
+	}
 
 	err = set_mode(adapter, mode, msg);
 	if (err < 0)
@@ -2477,8 +2481,12 @@ static void set_mode_complete(struct btd_adapter *adapter)
 
 		if (err < 0)
 			reply = btd_error_failed(msg, strerror(-err));
-		else
+		else {
+			if (strcmp(dbus_message_get_member(msg),
+						"SetProperty") == 0)
+				adapter->global_mode = adapter->mode;
 			reply = g_dbus_create_reply(msg, DBUS_TYPE_INVALID);
+		}
 
 		g_dbus_send_message(connection, reply);
 	}
-- 
1.7.1

