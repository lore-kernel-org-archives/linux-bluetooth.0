Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Subject: [PATCH BlueZ v2 4/8] tools/obexctl: Use g_dbus_proxy_lookup() instead
 of find_*
From: ERAMOTO Masaya <eramoto.masaya@jp.fujitsu.com>
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
References: <2003783a-cdd8-597a-6438-967ffafe67c8@jp.fujitsu.com>
Message-ID: <0c339358-d198-6d90-3e5c-0d0358ba674e@jp.fujitsu.com>
Date: Thu, 28 Dec 2017 14:44:10 +0900
MIME-Version: 1.0
In-Reply-To: <2003783a-cdd8-597a-6438-967ffafe67c8@jp.fujitsu.com>
Content-Type: text/plain; charset="utf-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Uses g_dbus_proxy_lookup() instead of find_{session,transfer,message,opp,
map,ftp,pbap}
---
 tools/obexctl.c | 212 +++++++++++++++++---------------------------------------
 1 file changed, 64 insertions(+), 148 deletions(-)

diff --git a/tools/obexctl.c b/tools/obexctl.c
index c4c7686c1..3236616d0 100644
--- a/tools/obexctl.c
+++ b/tools/obexctl.c
@@ -59,13 +59,13 @@
 
 static DBusConnection *dbus_conn;
 static GDBusProxy *default_session;
-static GSList *sessions = NULL;
-static GSList *opps = NULL;
-static GSList *ftps = NULL;
-static GSList *pbaps = NULL;
-static GSList *maps = NULL;
-static GSList *msgs = NULL;
-static GSList *transfers = NULL;
+static GList *sessions = NULL;
+static GList *opps = NULL;
+static GList *ftps = NULL;
+static GList *pbaps = NULL;
+static GList *maps = NULL;
+static GList *msgs = NULL;
+static GList *transfers = NULL;
 static GDBusProxy *client = NULL;
 
 struct transfer_data {
@@ -219,26 +219,13 @@ static void disconnect_setup(DBusMessageIter *iter, void *user_data)
 	dbus_message_iter_append_basic(iter, DBUS_TYPE_OBJECT_PATH, &path);
 }
 
-static GDBusProxy *find_session(const char *path)
-{
-	GSList *l;
-
-	for (l = sessions; l; l = g_slist_next(l)) {
-		GDBusProxy *proxy = l->data;
-
-		if (strcmp(path, g_dbus_proxy_get_path(proxy)) == 0)
-			return proxy;
-	}
-
-	return NULL;
-}
-
 static void cmd_disconnect(int argc, char *argv[])
 {
 	GDBusProxy *proxy;
 
 	if (argc > 1)
-		proxy = find_session(argv[1]);
+		proxy = g_dbus_proxy_lookup(sessions, NULL, argv[1],
+						OBEX_SESSION_INTERFACE);
 	else
 		proxy = default_session;
 
@@ -285,9 +272,9 @@ static void print_proxy(GDBusProxy *proxy, const char *title,
 
 static void cmd_list(int argc, char *arg[])
 {
-	GSList *l;
+	GList *l;
 
-	for (l = sessions; l; l = g_slist_next(l)) {
+	for (l = sessions; l; l = g_list_next(l)) {
 		GDBusProxy *proxy = l->data;
 		print_proxy(proxy, "Session", NULL);
 	}
@@ -393,7 +380,8 @@ static void cmd_show(int argc, char *argv[])
 
 		proxy = default_session;
 	} else {
-		proxy = find_session(argv[1]);
+		proxy = g_dbus_proxy_lookup(sessions, NULL, argv[1],
+						OBEX_SESSION_INTERFACE);
 		if (!proxy) {
 			bt_shell_printf("Session %s not available\n", argv[1]);
 			return;
@@ -430,7 +418,8 @@ static void cmd_select(int argc, char *argv[])
 {
 	GDBusProxy *proxy;
 
-	proxy = find_session(argv[1]);
+	proxy = g_dbus_proxy_lookup(sessions, NULL, argv[1],
+						OBEX_SESSION_INTERFACE);
 	if (proxy == NULL) {
 		bt_shell_printf("Session %s not available\n", argv[1]);
 		return;
@@ -444,34 +433,6 @@ static void cmd_select(int argc, char *argv[])
 	print_proxy(proxy, "Session", NULL);
 }
 
-static GDBusProxy *find_transfer(const char *path)
-{
-	GSList *l;
-
-	for (l = transfers; l; l = g_slist_next(l)) {
-		GDBusProxy *proxy = l->data;
-
-		if (strcmp(path, g_dbus_proxy_get_path(proxy)) == 0)
-			return proxy;
-	}
-
-	return NULL;
-}
-
-static GDBusProxy *find_message(const char *path)
-{
-	GSList *l;
-
-	for (l = msgs; l; l = g_slist_next(l)) {
-		GDBusProxy *proxy = l->data;
-
-		if (strcmp(path, g_dbus_proxy_get_path(proxy)) == 0)
-			return proxy;
-	}
-
-	return NULL;
-}
-
 static void transfer_info(GDBusProxy *proxy, int argc, char *argv[])
 {
 	bt_shell_printf("Transfer %s\n", g_dbus_proxy_get_path(proxy));
@@ -512,13 +473,14 @@ static void cmd_info(int argc, char *argv[])
 {
 	GDBusProxy *proxy;
 
-	proxy = find_transfer(argv[1]);
+	proxy = g_dbus_proxy_lookup(transfers, NULL, argv[1],
+						OBEX_TRANSFER_INTERFACE);
 	if (proxy) {
 		transfer_info(proxy, argc, argv);
 		return;
 	}
 
-	proxy = find_message(argv[1]);
+	proxy = g_dbus_proxy_lookup(msgs, NULL, argv[1], OBEX_MSG_INTERFACE);
 	if (proxy) {
 		message_info(proxy, argc, argv);
 		return;
@@ -546,7 +508,8 @@ static void cmd_cancel(int argc, char *argv[])
 {
 	GDBusProxy *proxy;
 
-	proxy = find_transfer(argv[1]);
+	proxy = g_dbus_proxy_lookup(transfers, NULL, argv[1],
+						OBEX_TRANSFER_INTERFACE);
 	if (!proxy) {
 		bt_shell_printf("Transfer %s not available\n", argv[1]);
 		return;
@@ -581,7 +544,8 @@ static void cmd_suspend(int argc, char *argv[])
 {
 	GDBusProxy *proxy;
 
-	proxy = find_transfer(argv[1]);
+	proxy = g_dbus_proxy_lookup(transfers, NULL, argv[1],
+						OBEX_TRANSFER_INTERFACE);
 	if (!proxy) {
 		bt_shell_printf("Transfer %s not available\n", argv[1]);
 		return;
@@ -616,7 +580,8 @@ static void cmd_resume(int argc, char *argv[])
 {
 	GDBusProxy *proxy;
 
-	proxy = find_transfer(argv[1]);
+	proxy = g_dbus_proxy_lookup(transfers, NULL, argv[1],
+						OBEX_TRANSFER_INTERFACE);
 	if (!proxy) {
 		bt_shell_printf("Transfer %s not available\n", argv[1]);
 		return;
@@ -632,34 +597,6 @@ static void cmd_resume(int argc, char *argv[])
 						g_dbus_proxy_get_path(proxy));
 }
 
-static GDBusProxy *find_opp(const char *path)
-{
-	GSList *l;
-
-	for (l = opps; l; l = g_slist_next(l)) {
-		GDBusProxy *proxy = l->data;
-
-		if (strcmp(path, g_dbus_proxy_get_path(proxy)) == 0)
-			return proxy;
-	}
-
-	return NULL;
-}
-
-static GDBusProxy *find_map(const char *path)
-{
-	GSList *l;
-
-	for (l = maps; l; l = g_slist_next(l)) {
-		GDBusProxy *proxy = l->data;
-
-		if (strcmp(path, g_dbus_proxy_get_path(proxy)) == 0)
-			return proxy;
-	}
-
-	return NULL;
-}
-
 static void print_dict_iter(DBusMessageIter *iter)
 {
 	DBusMessageIter dict;
@@ -806,18 +743,19 @@ static void map_send(GDBusProxy *proxy, int argc, char *argv[])
 
 static void cmd_send(int argc, char *argv[])
 {
+	const char *path = g_dbus_proxy_get_path(default_session);
 	GDBusProxy *proxy;
 
 	if (!check_default_session())
 		return;
 
-	proxy = find_opp(g_dbus_proxy_get_path(default_session));
+	proxy = g_dbus_proxy_lookup(opps, NULL, path, OBEX_OPP_INTERFACE);
 	if (proxy) {
 		opp_send(proxy, argc, argv);
 		return;
 	}
 
-	proxy = find_map(g_dbus_proxy_get_path(default_session));
+	proxy = g_dbus_proxy_lookup(maps, NULL, path, OBEX_MAP_INTERFACE);
 	if (proxy) {
 		map_send(proxy, argc, argv);
 		return;
@@ -828,12 +766,13 @@ static void cmd_send(int argc, char *argv[])
 
 static void cmd_pull(int argc, char *argv[])
 {
+	const char *path = g_dbus_proxy_get_path(default_session);
 	GDBusProxy *proxy;
 
 	if (!check_default_session())
 		return;
 
-	proxy = find_opp(g_dbus_proxy_get_path(default_session));
+	proxy = g_dbus_proxy_lookup(opps, NULL, path, OBEX_OPP_INTERFACE);
 	if (proxy) {
 		opp_pull(proxy, argc, argv);
 		return;
@@ -913,34 +852,6 @@ static void setfolder_setup(DBusMessageIter *iter, void *user_data)
 	dbus_message_iter_append_basic(iter, DBUS_TYPE_STRING, &folder);
 }
 
-static GDBusProxy *find_ftp(const char *path)
-{
-	GSList *l;
-
-	for (l = ftps; l; l = g_slist_next(l)) {
-		GDBusProxy *proxy = l->data;
-
-		if (strcmp(path, g_dbus_proxy_get_path(proxy)) == 0)
-			return proxy;
-	}
-
-	return NULL;
-}
-
-static GDBusProxy *find_pbap(const char *path)
-{
-	GSList *l;
-
-	for (l = pbaps; l; l = g_slist_next(l)) {
-		GDBusProxy *proxy = l->data;
-
-		if (strcmp(path, g_dbus_proxy_get_path(proxy)) == 0)
-			return proxy;
-	}
-
-	return NULL;
-}
-
 static void ftp_cd(GDBusProxy *proxy, int argc, char *argv[])
 {
 	if (g_dbus_proxy_method_call(proxy, "ChangeFolder", change_folder_setup,
@@ -979,24 +890,25 @@ static void map_cd(GDBusProxy *proxy, int argc, char *argv[])
 
 static void cmd_cd(int argc, char *argv[])
 {
+	const char *path = g_dbus_proxy_get_path(default_session);
 	GDBusProxy *proxy;
 
 	if (!check_default_session())
 		return;
 
-	proxy = find_ftp(g_dbus_proxy_get_path(default_session));
+	proxy = g_dbus_proxy_lookup(ftps, NULL, path, OBEX_FTP_INTERFACE);
 	if (proxy) {
 		ftp_cd(proxy, argc, argv);
 		return;
 	}
 
-	proxy = find_pbap(g_dbus_proxy_get_path(default_session));
+	proxy = g_dbus_proxy_lookup(pbaps, NULL, path, OBEX_PBAP_INTERFACE);
 	if (proxy) {
 		pbap_cd(proxy, argc, argv);
 		return;
 	}
 
-	proxy = find_map(g_dbus_proxy_get_path(default_session));
+	proxy = g_dbus_proxy_lookup(maps, NULL, path, OBEX_MAP_INTERFACE);
 	if (proxy) {
 		map_cd(proxy, argc, argv);
 		return;
@@ -1326,24 +1238,25 @@ static void map_ls(GDBusProxy *proxy, int argc, char *argv[])
 
 static void cmd_ls(int argc, char *argv[])
 {
+	const char *path = g_dbus_proxy_get_path(default_session);
 	GDBusProxy *proxy;
 
 	if (!check_default_session())
 		return;
 
-	proxy = find_ftp(g_dbus_proxy_get_path(default_session));
+	proxy = g_dbus_proxy_lookup(ftps, NULL, path, OBEX_FTP_INTERFACE);
 	if (proxy) {
 		ftp_ls(proxy, argc, argv);
 		return;
 	}
 
-	proxy = find_pbap(g_dbus_proxy_get_path(default_session));
+	proxy = g_dbus_proxy_lookup(pbaps, NULL, path, OBEX_PBAP_INTERFACE);
 	if (proxy) {
 		pbap_ls(proxy, argc, argv);
 		return;
 	}
 
-	proxy = find_map(g_dbus_proxy_get_path(default_session));
+	proxy = g_dbus_proxy_lookup(maps, NULL, path, OBEX_MAP_INTERFACE);
 	if (proxy) {
 		map_ls(proxy, argc, argv);
 		return;
@@ -1652,7 +1565,7 @@ static void map_cp(GDBusProxy *proxy, int argc, char *argv[])
 {
 	GDBusProxy *obj;
 
-	obj = find_message(argv[1]);
+	obj = g_dbus_proxy_lookup(msgs, NULL, argv[1], OBEX_MSG_INTERFACE);
 	if (obj == NULL) {
 		bt_shell_printf("Invalid message argument\n");
 		return;
@@ -1669,25 +1582,25 @@ static void map_cp(GDBusProxy *proxy, int argc, char *argv[])
 
 static void cmd_cp(int argc, char *argv[])
 {
-
+	const char *path = g_dbus_proxy_get_path(default_session);
 	GDBusProxy *proxy;
 
 	if (!check_default_session())
 		return;
 
-	proxy = find_ftp(g_dbus_proxy_get_path(default_session));
+	proxy = g_dbus_proxy_lookup(ftps, NULL, path, OBEX_FTP_INTERFACE);
 	if (proxy) {
 		ftp_cp(proxy, argc, argv);
 		return;
 	}
 
-	proxy = find_pbap(g_dbus_proxy_get_path(default_session));
+	proxy = g_dbus_proxy_lookup(pbaps, NULL, path, OBEX_PBAP_INTERFACE);
 	if (proxy) {
 		pbap_cp(proxy, argc, argv);
 		return;
 	}
 
-	proxy = find_map(g_dbus_proxy_get_path(default_session));
+	proxy = g_dbus_proxy_lookup(maps, NULL, path, OBEX_MAP_INTERFACE);
 	if (proxy) {
 		map_cp(proxy, argc, argv);
 		return;
@@ -1713,13 +1626,14 @@ static void move_file_reply(DBusMessage *message, void *user_data)
 
 static void cmd_mv(int argc, char *argv[])
 {
+	const char *path = g_dbus_proxy_get_path(default_session);
 	GDBusProxy *proxy;
 	struct cp_args *args;
 
 	if (!check_default_session())
 		return;
 
-	proxy = find_ftp(g_dbus_proxy_get_path(default_session));
+	proxy = g_dbus_proxy_lookup(ftps, NULL, path, OBEX_FTP_INTERFACE);
 	if (proxy == NULL) {
 		bt_shell_printf("Command not supported\n");
 		return;
@@ -1783,7 +1697,7 @@ static void map_rm(GDBusProxy *proxy, int argc, char *argv[])
 	GDBusProxy *msg;
 	dbus_bool_t value = TRUE;
 
-	msg = find_message(argv[1]);
+	msg = g_dbus_proxy_lookup(msgs, NULL, argv[1], OBEX_MSG_INTERFACE);
 	if (msg == NULL) {
 		bt_shell_printf("Invalid message argument\n");
 		return;
@@ -1801,18 +1715,19 @@ static void map_rm(GDBusProxy *proxy, int argc, char *argv[])
 
 static void cmd_rm(int argc, char *argv[])
 {
+	const char *path = g_dbus_proxy_get_path(default_session);
 	GDBusProxy *proxy;
 
 	if (!check_default_session())
 		return;
 
-	proxy = find_ftp(g_dbus_proxy_get_path(default_session));
+	proxy = g_dbus_proxy_lookup(ftps, NULL, path, OBEX_FTP_INTERFACE);
 	if (proxy) {
 		ftp_rm(proxy, argc, argv);
 		return;
 	}
 
-	proxy = find_map(g_dbus_proxy_get_path(default_session));
+	proxy = g_dbus_proxy_lookup(maps, NULL, path, OBEX_MAP_INTERFACE);
 	if (proxy) {
 		map_rm(proxy, argc, argv);
 		return;
@@ -1845,12 +1760,13 @@ static void create_folder_setup(DBusMessageIter *iter, void *user_data)
 
 static void cmd_mkdir(int argc, char *argv[])
 {
+	const char *path = g_dbus_proxy_get_path(default_session);
 	GDBusProxy *proxy;
 
 	if (!check_default_session())
 		return;
 
-	proxy = find_ftp(g_dbus_proxy_get_path(default_session));
+	proxy = g_dbus_proxy_lookup(ftps, NULL, path, OBEX_FTP_INTERFACE);
 	if (proxy == NULL) {
 		bt_shell_printf("Command not supported\n");
 		return;
@@ -1902,7 +1818,7 @@ static void client_added(GDBusProxy *proxy)
 
 static void session_added(GDBusProxy *proxy)
 {
-	sessions = g_slist_append(sessions, proxy);
+	sessions = g_list_append(sessions, proxy);
 
 	if (default_session == NULL)
 		set_default_session(proxy);
@@ -1969,7 +1885,7 @@ static void transfer_added(GDBusProxy *proxy)
 	struct transfer_data *data;
 	DBusMessageIter iter;
 
-	transfers = g_slist_append(transfers, proxy);
+	transfers = g_list_append(transfers, proxy);
 
 	print_proxy(proxy, "Transfer", COLORED_NEW);
 
@@ -1987,35 +1903,35 @@ static void transfer_added(GDBusProxy *proxy)
 
 static void opp_added(GDBusProxy *proxy)
 {
-	opps = g_slist_append(opps, proxy);
+	opps = g_list_append(opps, proxy);
 
 	print_proxy(proxy, "ObjectPush", COLORED_NEW);
 }
 
 static void ftp_added(GDBusProxy *proxy)
 {
-	ftps = g_slist_append(ftps, proxy);
+	ftps = g_list_append(ftps, proxy);
 
 	print_proxy(proxy, "FileTransfer", COLORED_NEW);
 }
 
 static void pbap_added(GDBusProxy *proxy)
 {
-	pbaps = g_slist_append(pbaps, proxy);
+	pbaps = g_list_append(pbaps, proxy);
 
 	print_proxy(proxy, "PhonebookAccess", COLORED_NEW);
 }
 
 static void map_added(GDBusProxy *proxy)
 {
-	maps = g_slist_append(maps, proxy);
+	maps = g_list_append(maps, proxy);
 
 	print_proxy(proxy, "MessageAccess", COLORED_NEW);
 }
 
 static void msg_added(GDBusProxy *proxy)
 {
-	msgs = g_slist_append(msgs, proxy);
+	msgs = g_list_append(msgs, proxy);
 
 	print_proxy(proxy, "Message", COLORED_NEW);
 }
@@ -2059,49 +1975,49 @@ static void session_removed(GDBusProxy *proxy)
 	if (default_session == proxy)
 		set_default_session(NULL);
 
-	sessions = g_slist_remove(sessions, proxy);
+	sessions = g_list_remove(sessions, proxy);
 }
 
 static void transfer_removed(GDBusProxy *proxy)
 {
 	print_proxy(proxy, "Transfer", COLORED_DEL);
 
-	transfers = g_slist_remove(transfers, proxy);
+	transfers = g_list_remove(transfers, proxy);
 }
 
 static void opp_removed(GDBusProxy *proxy)
 {
 	print_proxy(proxy, "ObjectPush", COLORED_DEL);
 
-	opps = g_slist_remove(opps, proxy);
+	opps = g_list_remove(opps, proxy);
 }
 
 static void ftp_removed(GDBusProxy *proxy)
 {
 	print_proxy(proxy, "FileTransfer", COLORED_DEL);
 
-	ftps = g_slist_remove(ftps, proxy);
+	ftps = g_list_remove(ftps, proxy);
 }
 
 static void pbap_removed(GDBusProxy *proxy)
 {
 	print_proxy(proxy, "PhonebookAccess", COLORED_DEL);
 
-	pbaps = g_slist_remove(pbaps, proxy);
+	pbaps = g_list_remove(pbaps, proxy);
 }
 
 static void map_removed(GDBusProxy *proxy)
 {
 	print_proxy(proxy, "MessageAccess", COLORED_DEL);
 
-	maps = g_slist_remove(maps, proxy);
+	maps = g_list_remove(maps, proxy);
 }
 
 static void msg_removed(GDBusProxy *proxy)
 {
 	print_proxy(proxy, "Message", COLORED_DEL);
 
-	msgs = g_slist_remove(msgs, proxy);
+	msgs = g_list_remove(msgs, proxy);
 }
 
 static void proxy_removed(GDBusProxy *proxy, void *user_data)
-- 
2.14.1

