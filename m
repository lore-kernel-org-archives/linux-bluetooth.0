Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 07/10 v2] core: Make use of g_dbus_send_message_with_reply
Date: Tue, 20 Aug 2013 16:07:12 +0300
Message-Id: <1377004035-16936-8-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1377004035-16936-1-git-send-email-luiz.dentz@gmail.com>
References: <1377004035-16936-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This replaces dbus_connection_send_with_reply with
g_dbus_send_message_with_reply which does not alter message order.
---
 src/agent.c   | 12 ++++++------
 src/profile.c |  4 ++--
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/src/agent.c b/src/agent.c
index b9e6e8c..7880ba6 100644
--- a/src/agent.c
+++ b/src/agent.c
@@ -370,7 +370,7 @@ static int agent_call_authorize_service(struct agent_request *req,
 				DBUS_TYPE_STRING, &uuid,
 				DBUS_TYPE_INVALID);
 
-	if (dbus_connection_send_with_reply(btd_get_dbus_connection(),
+	if (g_dbus_send_message_with_reply(btd_get_dbus_connection(),
 						req->msg, &req->call,
 						REQUEST_TIMEOUT) == FALSE) {
 		error("D-Bus send failed");
@@ -480,7 +480,7 @@ static int pincode_request_new(struct agent_request *req, const char *device_pat
 	dbus_message_append_args(req->msg, DBUS_TYPE_OBJECT_PATH, &device_path,
 					DBUS_TYPE_INVALID);
 
-	if (dbus_connection_send_with_reply(btd_get_dbus_connection(), req->msg,
+	if (g_dbus_send_message_with_reply(btd_get_dbus_connection(), req->msg,
 					&req->call, REQUEST_TIMEOUT) == FALSE) {
 		error("D-Bus send failed");
 		return -EIO;
@@ -574,7 +574,7 @@ static int passkey_request_new(struct agent_request *req,
 	dbus_message_append_args(req->msg, DBUS_TYPE_OBJECT_PATH, &device_path,
 					DBUS_TYPE_INVALID);
 
-	if (dbus_connection_send_with_reply(btd_get_dbus_connection(), req->msg,
+	if (g_dbus_send_message_with_reply(btd_get_dbus_connection(), req->msg,
 					&req->call, REQUEST_TIMEOUT) == FALSE) {
 		error("D-Bus send failed");
 		return -EIO;
@@ -632,7 +632,7 @@ static int confirmation_request_new(struct agent_request *req,
 				DBUS_TYPE_UINT32, &passkey,
 				DBUS_TYPE_INVALID);
 
-	if (dbus_connection_send_with_reply(btd_get_dbus_connection(), req->msg,
+	if (g_dbus_send_message_with_reply(btd_get_dbus_connection(), req->msg,
 				&req->call, REQUEST_TIMEOUT) == FALSE) {
 		error("D-Bus send failed");
 		return -EIO;
@@ -689,7 +689,7 @@ static int authorization_request_new(struct agent_request *req,
 				DBUS_TYPE_OBJECT_PATH, &device_path,
 				DBUS_TYPE_INVALID);
 
-	if (dbus_connection_send_with_reply(btd_get_dbus_connection(), req->msg,
+	if (g_dbus_send_message_with_reply(btd_get_dbus_connection(), req->msg,
 				&req->call, REQUEST_TIMEOUT) == FALSE) {
 		error("D-Bus send failed");
 		return -EIO;
@@ -823,7 +823,7 @@ static int display_pincode_request_new(struct agent_request *req,
 					DBUS_TYPE_STRING, &pincode,
 					DBUS_TYPE_INVALID);
 
-	if (dbus_connection_send_with_reply(btd_get_dbus_connection(), req->msg,
+	if (g_dbus_send_message_with_reply(btd_get_dbus_connection(), req->msg,
 				&req->call, REQUEST_TIMEOUT) == FALSE) {
 		error("D-Bus send failed");
 		return -EIO;
diff --git a/src/profile.c b/src/profile.c
index 90c3535..57aead7 100644
--- a/src/profile.c
+++ b/src/profile.c
@@ -938,7 +938,7 @@ static bool send_new_connection(struct ext_profile *ext, struct ext_io *conn)
 
 	dbus_message_iter_close_container(&iter, &dict);
 
-	if (!dbus_connection_send_with_reply(btd_get_dbus_connection(),
+	if (!g_dbus_send_message_with_reply(btd_get_dbus_connection(),
 						msg, &conn->pending, -1)) {
 		error("%s: sending NewConnection failed", ext->name);
 		dbus_message_unref(msg);
@@ -1682,7 +1682,7 @@ static int send_disconn_req(struct ext_profile *ext, struct ext_io *conn)
 	dbus_message_append_args(msg, DBUS_TYPE_OBJECT_PATH, &path,
 							DBUS_TYPE_INVALID);
 
-	if (!dbus_connection_send_with_reply(btd_get_dbus_connection(),
+	if (!g_dbus_send_message_with_reply(btd_get_dbus_connection(),
 						msg, &conn->pending, -1)) {
 		error("%s: sending RequestDisconnection failed", ext->name);
 		dbus_message_unref(msg);
-- 
1.8.3.1

