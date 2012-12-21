Return-Path: <cyrus@holtmann.org>
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Anderson Lizardo <anderson.lizardo@openbossa.org>
Subject: [PATCH BlueZ 1/4] core: Use ERROR_INTERFACE instead of org.bluez.Error
Date: Fri, 21 Dec 2012 12:25:00 -0400
Message-Id: <1356107103-18039-1-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This will simplify changing interface name later (e.g. adding
versioning).
---
 src/adapter.c |    4 ++--
 src/agent.c   |    5 +++--
 src/device.c  |    2 +-
 3 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/src/adapter.c b/src/adapter.c
index 6ff20e1..c1cb763 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -736,7 +736,7 @@ static void service_auth_cancel(struct service_auth *auth)
 	DBusError derr;
 
 	dbus_error_init(&derr);
-	dbus_set_error_const(&derr, "org.bluez.Error.Canceled", NULL);
+	dbus_set_error_const(&derr, ERROR_INTERFACE ".Canceled", NULL);
 
 	auth->cb(&derr, auth->user_data);
 
@@ -3105,7 +3105,7 @@ static gboolean process_auth_queue(gpointer user_data)
 	adapter->auth_idle_id = 0;
 
 	dbus_error_init(&err);
-	dbus_set_error_const(&err, "org.bluez.Error.Rejected", NULL);
+	dbus_set_error_const(&err, ERROR_INTERFACE ".Rejected", NULL);
 
 	while (!g_queue_is_empty(adapter->auths)) {
 		struct service_auth *auth = adapter->auths->head->data;
diff --git a/src/agent.c b/src/agent.c
index 71e13c2..9b3fd28 100644
--- a/src/agent.c
+++ b/src/agent.c
@@ -206,7 +206,8 @@ void agent_unref(struct agent *agent)
 		agent_cb cb;
 
 		dbus_error_init(&err);
-		dbus_set_error_const(&err, "org.bluez.Error.Failed", "Canceled");
+		dbus_set_error_const(&err, ERROR_INTERFACE ".Failed",
+								"Canceled");
 
 		switch (agent->request->type) {
 		case AGENT_REQUEST_PINCODE:
@@ -439,7 +440,7 @@ static void pincode_reply(DBusPendingCall *call, void *user_data)
 
 	if (len > 16 || len < 1) {
 		error("Invalid PIN length (%zu) from agent", len);
-		dbus_set_error_const(&err, "org.bluez.Error.InvalidArgs",
+		dbus_set_error_const(&err, ERROR_INTERFACE ".InvalidArgs",
 					"Invalid passkey length");
 		cb(agent, &err, NULL, req->user_data);
 		dbus_error_free(&err);
diff --git a/src/device.c b/src/device.c
index 3cfb816..17c6cf7 100644
--- a/src/device.c
+++ b/src/device.c
@@ -3908,7 +3908,7 @@ static void cancel_authentication(struct authentication_req *auth)
 	auth->agent = NULL;
 
 	dbus_error_init(&err);
-	dbus_set_error_const(&err, "org.bluez.Error.Canceled", NULL);
+	dbus_set_error_const(&err, ERROR_INTERFACE ".Canceled", NULL);
 
 	switch (auth->type) {
 	case AUTH_TYPE_PINCODE:
-- 
1.7.9.5

