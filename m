Return-Path: <cyrus@holtmann.org>
From: Gowtham Anandha Babu <gowtham.ab@samsung.com>
To: linux-bluetooth@vger.kernel.org
Cc: bharat.panda@samsung.com,
	Gowtham Anandha Babu <gowtham.ab@samsung.com>
Subject: [RFC 3/3] obexd/opp: Add support for authorizing GET request
Date: Fri, 10 Jul 2015 20:41:52 +0530
Message-id: <1436541112-21844-4-git-send-email-gowtham.ab@samsung.com>
In-reply-to: <1436541112-21844-1-git-send-email-gowtham.ab@samsung.com>
References: <1436541112-21844-1-git-send-email-gowtham.ab@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Add method call to authorize incoming GET request to
opp server.
---
 obexd/plugins/opp.c | 23 +++++++++++++++++++----
 obexd/src/manager.c | 18 ++++++++++++------
 obexd/src/manager.h |  2 +-
 3 files changed, 32 insertions(+), 11 deletions(-)

diff --git a/obexd/plugins/opp.c b/obexd/plugins/opp.c
index 5bb7667..5683776 100644
--- a/obexd/plugins/opp.c
+++ b/obexd/plugins/opp.c
@@ -77,7 +77,7 @@ static int opp_chkput(struct obex_session *os, void *user_data)
 		goto skip_auth;
 	}
 
-	err = manager_request_authorization(user_data, &folder, &name);
+	err = manager_request_authorization(user_data, &folder, &name, "Push");
 	if (err < 0)
 		return -EPERM;
 
@@ -131,7 +131,7 @@ static int opp_put(struct obex_session *os, void *user_data)
 static int opp_get(struct obex_session *os, void *user_data)
 {
 	const char *type;
-	char *folder, *path;
+	char *folder, *path, *name;
 	int err = 0;
 
 	if (obex_get_name(os))
@@ -142,8 +142,19 @@ static int opp_get(struct obex_session *os, void *user_data)
 	if (type == NULL)
 		return -EPERM;
 
-	folder = g_strdup(obex_option_root_folder());
-	path = g_build_filename(folder, "/vcard.vcf", NULL);
+	err = manager_request_authorization(user_data, &folder, &name, "Get");
+	if (err < 0)
+		return -EPERM;
+
+	if(folder == NULL)
+		folder = g_strdup(obex_option_root_folder());
+
+	if(name == NULL)
+		name = g_strdup("vcard.vcf");
+
+	path = g_build_filename(folder, name, NULL);
+
+	DBG("Filename: %s, Path: %s", name, path);
 
 	if (g_ascii_strcasecmp(type, VCARD_TYPE) == 0) {
 		if (obex_get_stream_start(os, path) < 0)
@@ -152,8 +163,12 @@ static int opp_get(struct obex_session *os, void *user_data)
 	} else
 		err = -EPERM;
 
+	manager_emit_transfer_started(user_data);
+
 	g_free(folder);
+	g_free(name);
 	g_free(path);
+
 	return err;
 }
 
diff --git a/obexd/src/manager.c b/obexd/src/manager.c
index f84384a..be22ffd 100644
--- a/obexd/src/manager.c
+++ b/obexd/src/manager.c
@@ -51,6 +51,7 @@
 #define TRANSFER_INTERFACE OBEXD_SERVICE ".Transfer1"
 #define SESSION_INTERFACE OBEXD_SERVICE ".Session1"
 #define AGENT_INTERFACE OBEXD_SERVICE ".Agent1"
+#define AGENT_INTERFACE_2 OBEXD_SERVICE ".Agent2"
 
 #define TIMEOUT 60*1000 /* Timeout for user response (miliseconds) */
 
@@ -672,7 +673,7 @@ static gboolean auth_error(GIOChannel *io, GIOCondition cond, void *user_data)
 }
 
 int manager_request_authorization(struct obex_transfer *transfer,
-					char **new_folder, char **new_name)
+				char **new_folder, char **new_name, char *request)
 {
 	struct obex_session *os = transfer->session;
 	DBusMessage *msg;
@@ -689,12 +690,17 @@ int manager_request_authorization(struct obex_transfer *transfer,
 	if (!new_folder || !new_name)
 		return -EINVAL;
 
-	msg = dbus_message_new_method_call(agent->bus_name, agent->path,
-							AGENT_INTERFACE,
-							"AuthorizePush");
-
-	dbus_message_append_args(msg, DBUS_TYPE_OBJECT_PATH, &transfer->path,
+	if (strcmp(request,"Push") == 0) {
+		msg = dbus_message_new_method_call(agent->bus_name, agent->path,
+								AGENT_INTERFACE,
+								"AuthorizePush");
+		dbus_message_append_args(msg, DBUS_TYPE_OBJECT_PATH, &transfer->path,
 							DBUS_TYPE_INVALID);
+	}
+	else
+		msg = dbus_message_new_method_call(agent->bus_name, agent->path,
+								AGENT_INTERFACE_2,
+								"AuthorizeGet");
 
 	if (!g_dbus_send_message_with_reply(connection, msg, &call, TIMEOUT)) {
 		dbus_message_unref(msg);
diff --git a/obexd/src/manager.h b/obexd/src/manager.h
index d9781b2..5a265f1 100644
--- a/obexd/src/manager.h
+++ b/obexd/src/manager.h
@@ -37,6 +37,6 @@ void manager_emit_transfer_started(struct obex_transfer *transfer);
 void manager_emit_transfer_progress(struct obex_transfer *transfer);
 void manager_emit_transfer_completed(struct obex_transfer *transfer);
 int manager_request_authorization(struct obex_transfer *transfer,
-					char **new_folder, char **new_name);
+					char **new_folder, char **new_name, char *request);
 
 DBusConnection *manager_dbus_get_connection(void);
-- 
1.9.1

