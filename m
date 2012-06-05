Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH obexd 02/23] core: Change D-Bus namespace to org.bluez.obex
Date: Tue,  5 Jun 2012 13:57:00 +0300
Message-Id: <1338893841-14234-3-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1338893841-14234-1-git-send-email-luiz.dentz@gmail.com>
References: <1338893841-14234-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This changes the namespace from org.openobex to org.bluez.obex
---
 src/manager.c |   37 ++++++++++++++++++-------------------
 src/manager.h |    2 +-
 2 files changed, 19 insertions(+), 20 deletions(-)

diff --git a/src/manager.c b/src/manager.c
index f649035..5033881 100644
--- a/src/manager.c
+++ b/src/manager.c
@@ -44,11 +44,11 @@
 #include "btio.h"
 #include "service.h"
 
-#define OPENOBEX_MANAGER_PATH "/"
-#define OPENOBEX_MANAGER_INTERFACE OPENOBEX_SERVICE ".Manager"
-#define ERROR_INTERFACE OPENOBEX_SERVICE ".Error"
-#define TRANSFER_INTERFACE OPENOBEX_SERVICE ".Transfer"
-#define SESSION_INTERFACE OPENOBEX_SERVICE ".Session"
+#define OBEX_MANAGER_PATH "/"
+#define OBEX_MANAGER_INTERFACE OBEXD_SERVICE ".Manager"
+#define ERROR_INTERFACE OBEXD_SERVICE ".Error"
+#define TRANSFER_INTERFACE OBEXD_SERVICE ".Transfer"
+#define SESSION_INTERFACE OBEXD_SERVICE ".Session"
 
 #define TIMEOUT 60*1000 /* Timeout for user response (miliseconds) */
 
@@ -353,8 +353,7 @@ gboolean manager_init(void)
 
 	dbus_error_init(&err);
 
-	connection = g_dbus_setup_bus(DBUS_BUS_SESSION, OPENOBEX_SERVICE,
-									&err);
+	connection = g_dbus_setup_bus(DBUS_BUS_SESSION, OBEXD_SERVICE, &err);
 	if (connection == NULL) {
 		if (dbus_error_is_set(&err) == TRUE) {
 			fprintf(stderr, "%s\n", err.message);
@@ -364,8 +363,8 @@ gboolean manager_init(void)
 		return FALSE;
 	}
 
-	return g_dbus_register_interface(connection, OPENOBEX_MANAGER_PATH,
-					OPENOBEX_MANAGER_INTERFACE,
+	return g_dbus_register_interface(connection, OBEX_MANAGER_PATH,
+					OBEX_MANAGER_INTERFACE,
 					manager_methods, manager_signals, NULL,
 					NULL, NULL);
 }
@@ -374,8 +373,8 @@ void manager_cleanup(void)
 {
 	DBG("");
 
-	g_dbus_unregister_interface(connection, OPENOBEX_MANAGER_PATH,
-						OPENOBEX_MANAGER_INTERFACE);
+	g_dbus_unregister_interface(connection, OBEX_MANAGER_PATH,
+						OBEX_MANAGER_INTERFACE);
 
 	/* FIXME: Release agent? */
 
@@ -389,8 +388,8 @@ void manager_emit_transfer_started(struct obex_session *os)
 {
 	char *path = g_strdup_printf("/transfer%u", os->id);
 
-	g_dbus_emit_signal(connection, OPENOBEX_MANAGER_PATH,
-			OPENOBEX_MANAGER_INTERFACE, "TransferStarted",
+	g_dbus_emit_signal(connection, OBEX_MANAGER_PATH,
+			OBEX_MANAGER_INTERFACE, "TransferStarted",
 			DBUS_TYPE_OBJECT_PATH, &path,
 			DBUS_TYPE_INVALID);
 
@@ -401,8 +400,8 @@ static void emit_transfer_completed(struct obex_session *os, gboolean success)
 {
 	char *path = g_strdup_printf("/transfer%u", os->id);
 
-	g_dbus_emit_signal(connection, OPENOBEX_MANAGER_PATH,
-			OPENOBEX_MANAGER_INTERFACE, "TransferCompleted",
+	g_dbus_emit_signal(connection, OBEX_MANAGER_PATH,
+			OBEX_MANAGER_INTERFACE, "TransferCompleted",
 			DBUS_TYPE_OBJECT_PATH, &path,
 			DBUS_TYPE_BOOLEAN, &success,
 			DBUS_TYPE_INVALID);
@@ -616,8 +615,8 @@ void manager_register_session(struct obex_session *os)
 		goto done;
 	}
 
-	g_dbus_emit_signal(connection, OPENOBEX_MANAGER_PATH,
-			OPENOBEX_MANAGER_INTERFACE, "SessionCreated",
+	g_dbus_emit_signal(connection, OBEX_MANAGER_PATH,
+			OBEX_MANAGER_INTERFACE, "SessionCreated",
 			DBUS_TYPE_OBJECT_PATH, &path,
 			DBUS_TYPE_INVALID);
 
@@ -629,8 +628,8 @@ void manager_unregister_session(struct obex_session *os)
 {
 	char *path = g_strdup_printf("/session%u", GPOINTER_TO_UINT(os));
 
-	g_dbus_emit_signal(connection, OPENOBEX_MANAGER_PATH,
-			OPENOBEX_MANAGER_INTERFACE, "SessionRemoved",
+	g_dbus_emit_signal(connection, OBEX_MANAGER_PATH,
+			OBEX_MANAGER_INTERFACE, "SessionRemoved",
 			DBUS_TYPE_OBJECT_PATH, &path,
 			DBUS_TYPE_INVALID);
 
diff --git a/src/manager.h b/src/manager.h
index 47aecb8..99303a2 100644
--- a/src/manager.h
+++ b/src/manager.h
@@ -23,7 +23,7 @@
 
 #include <dbus/dbus.h>
 
-#define OPENOBEX_SERVICE  "org.openobex"
+#define OBEXD_SERVICE  "org.bluez.obex"
 
 void manager_register_session(struct obex_session *os);
 void manager_unregister_session(struct obex_session *os);
-- 
1.7.10.2

