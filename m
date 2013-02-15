Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH v2 1/6] neard: Use service name and not boolean to track if registered to neard
Date: Fri, 15 Feb 2013 13:09:14 +0100
Message-ID: <1360930159-25658-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 plugins/neard.c | 23 ++++++++++++++---------
 1 file changed, 14 insertions(+), 9 deletions(-)

diff --git a/plugins/neard.c b/plugins/neard.c
index a1b385e..650ee3e 100644
--- a/plugins/neard.c
+++ b/plugins/neard.c
@@ -49,7 +49,7 @@
 #define ERROR_INTERFACE "org.neard.HandoverAgent.Error"
 
 static guint watcher_id = 0;
-static gboolean agent_registered = FALSE;
+static char *neard_service = NULL;
 static gboolean agent_register_postpone = FALSE;
 
 /* For NFC mimetype limits max OOB EIR size */
@@ -115,7 +115,7 @@ static void register_agent_cb(DBusPendingCall *call, void *user_data)
 	}
 
 	dbus_message_unref(reply);
-	agent_registered = TRUE;
+	neard_service = g_strdup(dbus_message_get_sender(reply));
 }
 
 static void register_agent(void)
@@ -152,7 +152,8 @@ static void unregister_agent(void)
 	DBusMessage *message;
 	const char *path = AGENT_PATH;
 
-	agent_registered = FALSE;
+	g_free(neard_service);
+	neard_service = NULL;
 
 	message = dbus_message_new_method_call(NEARD_NAME, NEARD_PATH,
 			NEARD_MANAGER_INTERFACE, "UnregisterHandoverAgent");
@@ -237,7 +238,7 @@ static void read_local_complete(struct btd_adapter *adapter,
 
 	DBG("");
 
-	if (!agent_registered) {
+	if (neard_service == NULL) {
 		dbus_message_unref(msg);
 
 		if (agent_register_postpone) {
@@ -269,7 +270,7 @@ static void bonding_complete(struct btd_adapter *adapter,
 
 	DBG("");
 
-	if (!agent_registered) {
+	if (neard_service == NULL) {
 		dbus_message_unref(msg);
 
 		if (agent_register_postpone) {
@@ -777,7 +778,9 @@ static DBusMessage *release(DBusConnection *conn, DBusMessage *msg,
 {
 	DBG("");
 
-	agent_registered = FALSE;
+	g_free(neard_service);
+	neard_service = NULL;
+
 	g_dbus_unregister_interface(conn, AGENT_PATH, AGENT_INTERFACE);
 
 	return g_dbus_create_reply(msg, DBUS_TYPE_INVALID);
@@ -824,8 +827,10 @@ static void neard_vanished(DBusConnection *conn, void *user_data)
 	DBG("");
 
 	/* neard existed without unregistering agent */
-	if (agent_registered) {
-		agent_registered = FALSE;
+	if (neard_service != NULL) {
+		g_free(neard_service);
+		neard_service = NULL;
+
 		g_dbus_unregister_interface(conn, AGENT_PATH, AGENT_INTERFACE);
 	}
 }
@@ -850,7 +855,7 @@ static void neard_exit(void)
 	g_dbus_remove_watch(btd_get_dbus_connection(), watcher_id);
 	watcher_id = 0;
 
-	if (agent_registered)
+	if (neard_service != NULL)
 		unregister_agent();
 }
 
-- 
1.8.1.1

