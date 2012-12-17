Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 3/5] obexd: Remove SessionCreated and SessionRemoved signals
Date: Mon, 17 Dec 2012 13:50:05 +0200
Message-Id: <1355745007-1493-3-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1355745007-1493-1-git-send-email-luiz.dentz@gmail.com>
References: <1355745007-1493-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

With ObjectManager these signals no longer are necessary.
---
 doc/obexd-api.txt   | 12 +-----------
 obexd/src/manager.c | 12 ------------
 2 files changed, 1 insertion(+), 23 deletions(-)

diff --git a/doc/obexd-api.txt b/doc/obexd-api.txt
index 53e61f5..822157d 100644
--- a/doc/obexd-api.txt
+++ b/doc/obexd-api.txt
@@ -29,17 +29,7 @@ Methods
 
 			Possible errors: org.bluez.obex.Error.DoesNotExist
 
-Signals		SessionCreated(object session)
-
-			Signal sent when OBEX connection has been accepted.
-			(FTP only)
-
-		SessionRemoved(object session)
-
-			Sent when the transport is disconnected
-			(FTP only)
-
-		TransferStarted(object transfer)
+Signals		TransferStarted(object transfer)
 
 			Signal sent when an object push operation starts.
 			(OPP only)
diff --git a/obexd/src/manager.c b/obexd/src/manager.c
index 034f6ab..c585aa1 100644
--- a/obexd/src/manager.c
+++ b/obexd/src/manager.c
@@ -310,8 +310,6 @@ static const GDBusSignalTable manager_signals[] = {
 	{ GDBUS_SIGNAL("TransferStarted", GDBUS_ARGS({ "transfer", "o"})) },
 	{ GDBUS_SIGNAL("TransferCompleted", GDBUS_ARGS({ "transfer", "o" },
 							{ "success", "b" })) },
-	{ GDBUS_SIGNAL("SessionCreated", GDBUS_ARGS({ "session", "o" })) },
-	{ GDBUS_SIGNAL("SessionRemoved", GDBUS_ARGS({ "session", "o" })) },
 	{ }
 };
 
@@ -606,11 +604,6 @@ void manager_register_session(struct obex_session *os)
 		goto done;
 	}
 
-	g_dbus_emit_signal(connection, OBEX_MANAGER_PATH,
-			OBEX_MANAGER_INTERFACE, "SessionCreated",
-			DBUS_TYPE_OBJECT_PATH, &path,
-			DBUS_TYPE_INVALID);
-
 done:
 	g_free(path);
 }
@@ -619,11 +612,6 @@ void manager_unregister_session(struct obex_session *os)
 {
 	char *path = g_strdup_printf("/session%u", GPOINTER_TO_UINT(os));
 
-	g_dbus_emit_signal(connection, OBEX_MANAGER_PATH,
-			OBEX_MANAGER_INTERFACE, "SessionRemoved",
-			DBUS_TYPE_OBJECT_PATH, &path,
-			DBUS_TYPE_INVALID);
-
 	g_dbus_unregister_interface(connection, path,
 				SESSION_INTERFACE);
 
-- 
1.7.11.7

