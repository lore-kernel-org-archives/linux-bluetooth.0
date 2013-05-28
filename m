Return-Path: <cyrus@holtmann.org>
From: Gustavo Padovan <gustavo@padovan.org>
To: linux-bluetooth@vger.kernel.org
Cc: emilio.pozuelo@collabora.co.uk,
	Gustavo Padovan <gustavo.padovan@collabora.co.uk>
Subject: [PATCH 6/6] manager: remove unused call to obex_getpeername()
Date: Tue, 28 May 2013 14:45:23 -0300
Message-Id: <1369763123-17949-6-git-send-email-gustavo@padovan.org>
In-Reply-To: <1369763123-17949-1-git-send-email-gustavo@padovan.org>
References: <1369763123-17949-1-git-send-email-gustavo@padovan.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Gustavo Padovan <gustavo.padovan@collabora.co.uk>

---
 obexd/src/manager.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/obexd/src/manager.c b/obexd/src/manager.c
index a116a3e..d0991e9 100644
--- a/obexd/src/manager.c
+++ b/obexd/src/manager.c
@@ -751,10 +751,8 @@ int manager_request_authorization(struct obex_transfer *transfer, int32_t time,
 	DBusPendingCall *call;
 	const char *filename = os->name ? os->name : "";
 	const char *type = os->type ? os->type : "";
-	char *address;
 	unsigned int watch;
 	gboolean got_reply;
-	int err;
 
 	if (!agent)
 		return -1;
@@ -765,10 +763,6 @@ int manager_request_authorization(struct obex_transfer *transfer, int32_t time,
 	if (!new_folder || !new_name)
 		return -EINVAL;
 
-	err = obex_getpeername(os, &address);
-	if (err < 0)
-		return err;
-
 	msg = dbus_message_new_method_call(agent->bus_name, agent->path,
 							AGENT_INTERFACE,
 							"AuthorizePush");
@@ -776,8 +770,6 @@ int manager_request_authorization(struct obex_transfer *transfer, int32_t time,
 	dbus_message_append_args(msg, DBUS_TYPE_OBJECT_PATH, &transfer->path,
 							DBUS_TYPE_INVALID);
 
-	g_free(address);
-
 	if (!dbus_connection_send_with_reply(connection,
 					msg, &call, TIMEOUT)) {
 		dbus_message_unref(msg);
-- 
1.8.1.4

