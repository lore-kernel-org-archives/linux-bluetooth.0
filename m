Return-Path: <cyrus@holtmann.org>
From: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
Subject: [PATCH 06/17] agent: Simplify DBusConnection object handling
Date: Wed, 19 Sep 2012 12:22:08 +0200
Message-ID: <1348050139-27883-7-git-send-email-andrzej.kaczmarek@tieto.com>
In-Reply-To: <1348050139-27883-1-git-send-email-andrzej.kaczmarek@tieto.com>
References: <1348050139-27883-1-git-send-email-andrzej.kaczmarek@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch removes local reference to DBusConnection object and uses
btd_get_dbus_connection() call wherever such object is needed instead.

Pointer returned by this call is guaranteed to be valid for entire
bluetoothd lifetime and thus do not need to be refcounted.
---
 src/agent.c | 44 +++++++++++++++++---------------------------
 src/agent.h |  3 ---
 src/main.c  |  4 ----
 3 files changed, 17 insertions(+), 34 deletions(-)

diff --git a/src/agent.c b/src/agent.c
index 36e96e9..8cf37b1 100644
--- a/src/agent.c
+++ b/src/agent.c
@@ -42,6 +42,7 @@
 
 #include "log.h"
 
+#include "dbus-common.h"
 #include "adapter.h"
 #include "device.h"
 #include "agent.h"
@@ -79,8 +80,6 @@ struct agent_request {
 	GDestroyNotify destroy;
 };
 
-static DBusConnection *connection = NULL;
-
 static void agent_release(struct agent *agent)
 {
 	DBusMessage *message;
@@ -97,7 +96,7 @@ static void agent_release(struct agent *agent)
 		return;
 	}
 
-	g_dbus_send_message(connection, message);
+	g_dbus_send_message(btd_get_dbus_connection(), message);
 }
 
 static int send_cancel_request(struct agent_request *req)
@@ -114,7 +113,7 @@ static int send_cancel_request(struct agent_request *req)
 		return -ENOMEM;
 	}
 
-	g_dbus_send_message(connection, message);
+	g_dbus_send_message(btd_get_dbus_connection(), message);
 
 	return 0;
 }
@@ -180,7 +179,8 @@ void agent_free(struct agent *agent)
 	}
 
 	if (!agent->exited) {
-		g_dbus_remove_watch(connection, agent->listener_id);
+		g_dbus_remove_watch(btd_get_dbus_connection(),
+							agent->listener_id);
 		agent_release(agent);
 	}
 
@@ -205,9 +205,9 @@ struct agent *agent_create(struct btd_adapter *adapter, const char *name,
 	agent->remove_cb = cb;
 	agent->remove_cb_data = remove_cb_data;
 
-	agent->listener_id = g_dbus_add_disconnect_watch(connection, name,
-							agent_exited, agent,
-							NULL);
+	agent->listener_id =
+		g_dbus_add_disconnect_watch(btd_get_dbus_connection(), name,
+						agent_exited, agent, NULL);
 
 	return agent;
 }
@@ -311,8 +311,9 @@ static int agent_call_authorize(struct agent_request *req,
 				DBUS_TYPE_STRING, &uuid,
 				DBUS_TYPE_INVALID);
 
-	if (dbus_connection_send_with_reply(connection, req->msg,
-					&req->call, REQUEST_TIMEOUT) == FALSE) {
+	if (dbus_connection_send_with_reply(btd_get_dbus_connection(),
+						req->msg, &req->call,
+						REQUEST_TIMEOUT) == FALSE) {
 		error("D-Bus send failed");
 		return -EIO;
 	}
@@ -427,7 +428,7 @@ static int pincode_request_new(struct agent_request *req, const char *device_pat
 	dbus_message_append_args(req->msg, DBUS_TYPE_OBJECT_PATH, &device_path,
 					DBUS_TYPE_INVALID);
 
-	if (dbus_connection_send_with_reply(connection, req->msg,
+	if (dbus_connection_send_with_reply(btd_get_dbus_connection(), req->msg,
 					&req->call, REQUEST_TIMEOUT) == FALSE) {
 		error("D-Bus send failed");
 		return -EIO;
@@ -480,7 +481,7 @@ static int confirm_mode_change_request_new(struct agent_request *req,
 				DBUS_TYPE_STRING, &mode,
 				DBUS_TYPE_INVALID);
 
-	if (dbus_connection_send_with_reply(connection, req->msg,
+	if (dbus_connection_send_with_reply(btd_get_dbus_connection(), req->msg,
 					&req->call, REQUEST_TIMEOUT) == FALSE) {
 		error("D-Bus send failed");
 		return -EIO;
@@ -576,7 +577,7 @@ static int passkey_request_new(struct agent_request *req,
 	dbus_message_append_args(req->msg, DBUS_TYPE_OBJECT_PATH, &device_path,
 					DBUS_TYPE_INVALID);
 
-	if (dbus_connection_send_with_reply(connection, req->msg,
+	if (dbus_connection_send_with_reply(btd_get_dbus_connection(), req->msg,
 					&req->call, REQUEST_TIMEOUT) == FALSE) {
 		error("D-Bus send failed");
 		return -EIO;
@@ -634,7 +635,7 @@ static int confirmation_request_new(struct agent_request *req,
 				DBUS_TYPE_UINT32, &passkey,
 				DBUS_TYPE_INVALID);
 
-	if (dbus_connection_send_with_reply(connection, req->msg,
+	if (dbus_connection_send_with_reply(btd_get_dbus_connection(), req->msg,
 				&req->call, REQUEST_TIMEOUT) == FALSE) {
 		error("D-Bus send failed");
 		return -EIO;
@@ -694,7 +695,7 @@ int agent_display_passkey(struct agent *agent, struct btd_device *device,
 				DBUS_TYPE_UINT16, &entered,
 				DBUS_TYPE_INVALID);
 
-	if (!g_dbus_send_message(connection, message)) {
+	if (!g_dbus_send_message(btd_get_dbus_connection(), message)) {
 		error("D-Bus send failed");
 		return -1;
 	}
@@ -768,7 +769,7 @@ static int display_pincode_request_new(struct agent_request *req,
 					DBUS_TYPE_STRING, &pincode,
 					DBUS_TYPE_INVALID);
 
-	if (dbus_connection_send_with_reply(connection, req->msg,
+	if (dbus_connection_send_with_reply(btd_get_dbus_connection(), req->msg,
 				&req->call, REQUEST_TIMEOUT) == FALSE) {
 		error("D-Bus send failed");
 		return -EIO;
@@ -833,14 +834,3 @@ gboolean agent_is_busy(struct agent *agent, void *user_data)
 
 	return TRUE;
 }
-
-void agent_exit(void)
-{
-	dbus_connection_unref(connection);
-	connection = NULL;
-}
-
-void agent_init(void)
-{
-	connection = dbus_bus_get(DBUS_BUS_SYSTEM, NULL);
-}
diff --git a/src/agent.h b/src/agent.h
index a729633..8fb4758 100644
--- a/src/agent.h
+++ b/src/agent.h
@@ -75,6 +75,3 @@ gboolean agent_is_busy(struct agent *agent, void *user_data);
 uint8_t agent_get_io_capability(struct agent *agent);
 
 gboolean agent_matches(struct agent *agent, const char *name, const char *path);
-
-void agent_init(void);
-void agent_exit(void);
diff --git a/src/main.c b/src/main.c
index 7593b15..f8c9369 100644
--- a/src/main.c
+++ b/src/main.c
@@ -513,8 +513,6 @@ int main(int argc, char *argv[])
 
 	parse_config(config);
 
-	agent_init();
-
 	if (option_udev == FALSE) {
 		if (connect_dbus() < 0) {
 			error("Unable to get on D-Bus");
@@ -562,8 +560,6 @@ int main(int argc, char *argv[])
 
 	stop_sdp_server();
 
-	agent_exit();
-
 	g_main_loop_unref(event_loop);
 
 	if (config)
-- 
1.7.11.3

