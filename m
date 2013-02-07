Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>
Subject: [PATCH 13/14] neard: Updated neard handover registration agent api calls.
Date: Thu, 7 Feb 2013 09:14:03 +0100
Message-ID: <1360224844-12280-14-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1360224844-12280-1-git-send-email-szymon.janc@tieto.com>
References: <1360224844-12280-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Ravi kumar Veeramally <ravikumar.veeramally@linux.intel.com>

neard RegisterHandoverAgent and UnregisterHandoverAgent apis
need an extra parameter of carrier type(e.g. bluetooth).
---
 plugins/neard.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/plugins/neard.c b/plugins/neard.c
index ab51057..9a4a924 100644
--- a/plugins/neard.c
+++ b/plugins/neard.c
@@ -46,6 +46,7 @@
 #define NEARD_MANAGER_INTERFACE "org.neard.Manager"
 #define AGENT_INTERFACE "org.neard.HandoverAgent"
 #define AGENT_PATH "/org/bluez/neard_handover_agent"
+#define AGENT_CARRIER_TYPE "bluetooth"
 #define ERROR_INTERFACE "org.neard.HandoverAgent.Error"
 
 static guint watcher_id = 0;
@@ -123,6 +124,7 @@ static void register_agent(void)
 	DBusMessage *message;
 	DBusPendingCall *call;
 	const char *path = AGENT_PATH;
+	const char *carrier = AGENT_CARRIER_TYPE;
 
 	message = dbus_message_new_method_call(NEARD_NAME, NEARD_PATH,
 			NEARD_MANAGER_INTERFACE, "RegisterHandoverAgent");
@@ -134,6 +136,9 @@ static void register_agent(void)
 	dbus_message_append_args(message, DBUS_TYPE_OBJECT_PATH, &path,
 							DBUS_TYPE_INVALID);
 
+	dbus_message_append_args(message, DBUS_TYPE_STRING, &carrier,
+							DBUS_TYPE_INVALID);
+
 	if (!dbus_connection_send_with_reply(btd_get_dbus_connection(),
 							message, &call, -1)) {
 		dbus_message_unref(message);
@@ -151,6 +156,7 @@ static void unregister_agent(void)
 {
 	DBusMessage *message;
 	const char *path = AGENT_PATH;
+	const char *carrier = AGENT_CARRIER_TYPE;
 
 	g_free(neard_path);
 	neard_path = NULL;
@@ -166,6 +172,9 @@ static void unregister_agent(void)
 	dbus_message_append_args(message, DBUS_TYPE_OBJECT_PATH, &path,
 						DBUS_TYPE_INVALID);
 
+	dbus_message_append_args(message, DBUS_TYPE_STRING, &carrier,
+							DBUS_TYPE_INVALID);
+
 	if (!g_dbus_send_message(btd_get_dbus_connection(), message))
 		error("D-Bus send failed");
 
-- 
1.8.1.1

