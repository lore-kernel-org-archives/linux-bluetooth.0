Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH v2 6/6] neard: Add fallback to legacy register if register failed
Date: Fri, 15 Feb 2013 13:09:19 +0100
Message-ID: <1360930159-25658-6-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1360930159-25658-1-git-send-email-szymon.janc@tieto.com>
References: <1360930159-25658-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This will allow to work with neard 0.9 which doesn't support handover
agent register with carrier type.
---
 plugins/neard.c | 37 ++++++++++++++++++++++++++++---------
 1 file changed, 28 insertions(+), 9 deletions(-)

diff --git a/plugins/neard.c b/plugins/neard.c
index 697967a..4075f73 100644
--- a/plugins/neard.c
+++ b/plugins/neard.c
@@ -96,30 +96,48 @@ static DBusMessage *error_reply(DBusMessage *msg, int error)
 	return g_dbus_create_error(msg, name , "%s", strerror(error));
 }
 
+static void register_agent(bool append_carrier);
+
 static void register_agent_cb(DBusPendingCall *call, void *user_data)
 {
 	DBusMessage *reply;
 	DBusError err;
+	static bool try_fallback = true;
 
 	reply = dbus_pending_call_steal_reply(call);
 
 	dbus_error_init(&err);
 	if (dbus_set_error_from_message(&err, reply)) {
-		error("neard manager replied with an error: %s, %s",
-						err.name, err.message);
+		if (g_str_equal(DBUS_ERROR_UNKNOWN_METHOD, err.name) &&
+				try_fallback) {
+			info("Register to neard failed, trying legacy way");
+
+			register_agent(false);
+			try_fallback = false;
+		} else {
+			error("neard manager replied with an error: %s, %s",
+							err.name, err.message);
+
+			g_dbus_unregister_interface(btd_get_dbus_connection(),
+						AGENT_PATH, AGENT_INTERFACE);
+			try_fallback = true;
+		}
+
 		dbus_error_free(&err);
 		dbus_message_unref(reply);
 
-		g_dbus_unregister_interface(btd_get_dbus_connection(),
-						AGENT_PATH, AGENT_INTERFACE);
 		return;
 	}
 
 	dbus_message_unref(reply);
 	neard_service = g_strdup(dbus_message_get_sender(reply));
+
+	try_fallback = true;
+
+	info("Registered as neard handover agent");
 }
 
-static void register_agent(void)
+static void register_agent(bool append_carrier)
 {
 	DBusMessage *message;
 	DBusPendingCall *call;
@@ -136,7 +154,8 @@ static void register_agent(void)
 	dbus_message_append_args(message, DBUS_TYPE_OBJECT_PATH, &path,
 							DBUS_TYPE_INVALID);
 
-	dbus_message_append_args(message, DBUS_TYPE_STRING, &carrier,
+	if (append_carrier)
+		dbus_message_append_args(message, DBUS_TYPE_STRING, &carrier,
 							DBUS_TYPE_INVALID);
 
 	if (!dbus_connection_send_with_reply(btd_get_dbus_connection(),
@@ -252,7 +271,7 @@ static void read_local_complete(struct btd_adapter *adapter,
 
 		if (agent_register_postpone) {
 			agent_register_postpone = false;
-			register_agent();
+			register_agent(true);
 		}
 
 		return;
@@ -284,7 +303,7 @@ static void bonding_complete(struct btd_adapter *adapter,
 
 		if (agent_register_postpone) {
 			agent_register_postpone = false;
-			register_agent();
+			register_agent(true);
 		}
 
 		return;
@@ -840,7 +859,7 @@ static void neard_appeared(DBusConnection *conn, void *user_data)
 	if (adapter && btd_adapter_check_oob_handler(adapter))
 		agent_register_postpone = true;
 	else
-		register_agent();
+		register_agent(true);
 }
 
 static void neard_vanished(DBusConnection *conn, void *user_data)
-- 
1.8.1.1

