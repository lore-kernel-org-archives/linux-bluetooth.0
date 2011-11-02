Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH obexd 3/8] Remove options per server
Date: Wed,  2 Nov 2011 15:09:50 +0200
Message-Id: <1320239395-29819-3-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1320239395-29819-1-git-send-email-luiz.dentz@gmail.com>
References: <1320239395-29819-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

Options are general so it is pointless to copy them to each server.
---
 plugins/ftp.c |   10 +++++-----
 plugins/opp.c |    8 ++++----
 src/main.c    |   32 +++++++++++++++++---------------
 src/manager.c |    4 +++-
 src/obex.c    |   25 -------------------------
 src/obex.h    |    3 ---
 src/obexd.h   |    2 ++
 src/server.c  |   19 +++----------------
 src/server.h  |    8 +-------
 9 files changed, 35 insertions(+), 76 deletions(-)

diff --git a/plugins/ftp.c b/plugins/ftp.c
index d5820b2..3f32563 100644
--- a/plugins/ftp.c
+++ b/plugins/ftp.c
@@ -171,7 +171,7 @@ static void set_folder(struct ftp_session *ftp, const char *new_folder)
 static int get_by_type(struct ftp_session *ftp, const char *type)
 {
 	struct obex_session *os = ftp->os;
-	const char *capability = obex_get_capability_path(os);
+	const char *capability = obex_option_capability();
 	const char *name = obex_get_name(os);
 	char *path;
 	int err;
@@ -202,7 +202,7 @@ void *ftp_connect(struct obex_session *os, int *err)
 
 	DBG("");
 
-	root_folder = obex_get_root_folder(os);
+	root_folder = obex_option_root_folder();
 
 	manager_register_session(os);
 
@@ -322,7 +322,7 @@ int ftp_setpath(struct obex_session *os, obex_object_t *obj, void *user_data)
 	}
 
 	name = obex_get_name(os);
-	root_folder = obex_get_root_folder(os);
+	root_folder = obex_option_root_folder();
 	root = g_str_equal(root_folder, ftp->folder);
 
 	DBG("%p name %s", ftp, name);
@@ -446,12 +446,12 @@ static char *ftp_build_filename(struct ftp_session *ftp, const char *destname)
 
 	/* DestName can either be relative or absolute (FTP style) */
 	if (destname[0] == '/')
-		filename = g_build_filename(obex_get_root_folder(ftp->os),
+		filename = g_build_filename(obex_option_root_folder(),
                                                                 destname, NULL);
 	else
 		filename = g_build_filename(ftp->folder, destname, NULL);
 
-	if (is_valid_path(filename + strlen(obex_get_root_folder(ftp->os))))
+	if (is_valid_path(filename + strlen(obex_option_root_folder())))
 		return filename;
 
 	g_free(filename);
diff --git a/plugins/opp.c b/plugins/opp.c
index 20ac5d1..ee4fecb 100644
--- a/plugins/opp.c
+++ b/plugins/opp.c
@@ -124,8 +124,8 @@ static int opp_chkput(struct obex_session *os, void *user_data)
 	if (t != NULL && !is_filename(t))
 		return -EBADR;
 
-	if (obex_get_auto_accept(os)) {
-		folder = g_strdup(obex_get_root_folder(os));
+	if (obex_option_auto_accept()) {
+		folder = g_strdup(obex_option_root_folder());
 		name = g_strdup(obex_get_name(os));
 		goto skip_auth;
 	}
@@ -136,7 +136,7 @@ static int opp_chkput(struct obex_session *os, void *user_data)
 		return -EPERM;
 
 	if (folder == NULL)
-		folder = g_strdup(obex_get_root_folder(os));
+		folder = g_strdup(obex_option_root_folder());
 
 	if (name == NULL)
 		name = g_strdup(obex_get_name(os));
@@ -169,7 +169,7 @@ static int opp_put(struct obex_session *os, obex_object_t *obj,
 						void *user_data)
 {
 	const char *name = obex_get_name(os);
-	const char *folder = obex_get_root_folder(os);
+	const char *folder = obex_option_root_folder();
 
 	if (folder == NULL)
 		return -EPERM;
diff --git a/src/main.c b/src/main.c
index 7cfced7..73c1db5 100644
--- a/src/main.c
+++ b/src/main.c
@@ -116,6 +116,11 @@ static GOptionEntry options[] = {
 	{ NULL },
 };
 
+gboolean obex_option_auto_accept(void)
+{
+	return option_autoaccept;
+}
+
 const char *obex_option_root_folder(void)
 {
 	return option_root;
@@ -126,6 +131,11 @@ gboolean obex_option_symlinks(void)
 	return option_symlinks;
 }
 
+const char *obex_option_capability(void)
+{
+	return option_capability;
+}
+
 static gboolean is_dir(const char *dir) {
 	struct stat st;
 
@@ -231,27 +241,19 @@ int main(int argc, char *argv[])
 
 	plugin_init(option_plugin, option_noplugin);
 
-	obex_server_init(OBEX_OPP, option_root, FALSE,
-				option_autoaccept, option_symlinks,
-				NULL);
+	obex_server_init(OBEX_OPP, FALSE);
 
-	obex_server_init(OBEX_FTP, option_root, TRUE,
-				option_autoaccept, option_symlinks,
-				option_capability);
+	obex_server_init(OBEX_FTP, TRUE);
 
-	obex_server_init(OBEX_PCSUITE, option_root, TRUE,
-				option_autoaccept, option_symlinks,
-				option_capability);
+	obex_server_init(OBEX_PCSUITE, TRUE);
 
-	obex_server_init(OBEX_PBAP, NULL, TRUE, FALSE, FALSE,
-							option_capability);
+	obex_server_init(OBEX_PBAP, TRUE);
 
-	obex_server_init(OBEX_IRMC, NULL, TRUE, FALSE, FALSE,
-							option_capability);
+	obex_server_init(OBEX_IRMC, TRUE);
 
-	obex_server_init(OBEX_SYNCEVOLUTION, NULL, TRUE, FALSE, FALSE, NULL);
+	obex_server_init(OBEX_SYNCEVOLUTION, TRUE);
 
-	obex_server_init(OBEX_MAS, NULL, TRUE, FALSE, FALSE, NULL);
+	obex_server_init(OBEX_MAS, TRUE);
 
 	if (!root_folder_setup(option_root, option_root_setup)) {
 		error("Unable to setup root folder %s", option_root);
diff --git a/src/manager.c b/src/manager.c
index dc6608b..db5d67d 100644
--- a/src/manager.c
+++ b/src/manager.c
@@ -264,6 +264,7 @@ static DBusMessage *get_properties(DBusConnection *conn,
 	DBusMessageIter iter;
 	DBusMessageIter dict;
 	char *uuid;
+	const char *root;
 
 	reply = dbus_message_new_method_return(msg);
 	if (!reply)
@@ -282,8 +283,9 @@ static DBusMessage *get_properties(DBusConnection *conn,
 	g_free(uuid);
 
 	/* Root folder */
+	root = obex_option_root_folder();
 	dbus_message_iter_append_dict_entry(&dict, "Root",
-					DBUS_TYPE_STRING, &os->server->folder);
+					DBUS_TYPE_STRING, &root);
 
 	/* FIXME: Added Remote Address or USB */
 
diff --git a/src/obex.c b/src/obex.c
index a0c17c1..0d00f7f 100644
--- a/src/obex.c
+++ b/src/obex.c
@@ -1477,31 +1477,6 @@ const char *obex_get_type(struct obex_session *os)
 	return os->type;
 }
 
-const char *obex_get_root_folder(struct obex_session *os)
-{
-	return os->server->folder;
-}
-
-uint16_t obex_get_service(struct obex_session *os)
-{
-	return os->service->service;
-}
-
-gboolean obex_get_symlinks(struct obex_session *os)
-{
-	return os->server->symlinks;
-}
-
-const char *obex_get_capability_path(struct obex_session *os)
-{
-	return os->server->capability;
-}
-
-gboolean obex_get_auto_accept(struct obex_session *os)
-{
-	return os->server->auto_accept;
-}
-
 int obex_remove(struct obex_session *os, const char *path)
 {
 	if (os->driver == NULL)
diff --git a/src/obex.h b/src/obex.h
index f4fd159..0f3360b 100644
--- a/src/obex.h
+++ b/src/obex.h
@@ -38,10 +38,7 @@ const char *obex_get_destname(struct obex_session *os);
 void obex_set_name(struct obex_session *os, const char *name);
 ssize_t obex_get_size(struct obex_session *os);
 const char *obex_get_type(struct obex_session *os);
-const char *obex_get_root_folder(struct obex_session *os);
 uint16_t obex_get_service(struct obex_session *os);
-gboolean obex_get_symlinks(struct obex_session *os);
-const char *obex_get_capability_path(struct obex_session *os);
 gboolean obex_get_auto_accept(struct obex_session *os);
 int obex_remove(struct obex_session *os, const char *path);
 int obex_copy(struct obex_session *os, const char *source,
diff --git a/src/obexd.h b/src/obexd.h
index d18df5b..1c9b2b3 100644
--- a/src/obexd.h
+++ b/src/obexd.h
@@ -36,5 +36,7 @@ void plugin_cleanup(void);
 gboolean manager_init(void);
 void manager_cleanup(void);
 
+gboolean obex_option_auto_accept(void);
 const char *obex_option_root_folder(void);
 gboolean obex_option_symlinks(void);
+const char *obex_option_capability(void);
diff --git a/src/server.c b/src/server.c
index 44a501c..dc1ad6d 100644
--- a/src/server.c
+++ b/src/server.c
@@ -47,16 +47,7 @@
 
 static GSList *servers = NULL;
 
-static void obex_server_free(struct obex_server *server)
-{
-	g_free(server->folder);
-	g_free(server->capability);
-	g_free(server);
-}
-
-int obex_server_init(uint16_t service, const char *folder,
-				gboolean secure, gboolean auto_accept,
-				gboolean symlinks, const char *capability)
+int obex_server_init(uint16_t service, gboolean secure)
 {
 	GSList *drivers;
 	GSList *transports;
@@ -86,17 +77,13 @@ int obex_server_init(uint16_t service, const char *folder,
 		server = g_new0(struct obex_server, 1);
 		server->transport = transport;
 		server->drivers = drivers;
-		server->folder = g_strdup(folder);
-		server->auto_accept = auto_accept;
-		server->symlinks = symlinks;
-		server->capability = g_strdup(capability);
 		server->secure = secure;
 
 		server->transport_data = transport->start(server, &err);
 		if (server->transport_data == NULL) {
 			DBG("Unable to start %s transport: %s (%d)",
 					transport->name, strerror(err), err);
-			obex_server_free(server);
+			g_free(server);
 			continue;
 		}
 
@@ -114,7 +101,7 @@ void obex_server_exit(void)
 		struct obex_server *server = l->data;
 
 		server->transport->stop(server->transport_data);
-		obex_server_free(server);
+		g_free(server);
 	}
 
 	g_slist_free(servers);
diff --git a/src/server.h b/src/server.h
index f82ad2b..beb8a9c 100644
--- a/src/server.h
+++ b/src/server.h
@@ -25,17 +25,11 @@
 struct obex_server {
 	struct obex_transport_driver *transport;
 	void *transport_data;
-	gboolean auto_accept;
-	char *folder;
-	gboolean symlinks;
-	char *capability;
 	gboolean secure;
 	GSList *drivers;
 };
 
-int obex_server_init(uint16_t service, const char *folder, gboolean secure,
-		gboolean auto_accept, gboolean symlinks,
-		const char *capability);
+int obex_server_init(uint16_t service, gboolean secure);
 
 void obex_server_exit(void);
 
-- 
1.7.6.4

