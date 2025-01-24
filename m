Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E6BB15853A
	for <linux-bluetooth@vger.kernel.org>; Fri, 24 Jan 2025 16:46:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737737182; cv=none; b=GEFGb6s1C+AvfJgZO6qcsJufyb/wixkrHj9SGFeDX79zKxGDJ46p2DN5Jee0ZwLA0qu9W6wEq4IM6lznW/1r4VX0g8v1+pxt7XlMKIPlsMgjyFlcdIflWEMGVv4dqElpuOA8VlIFBIUxGNicQp3E/CtlcxeD1yFlzQhgrYSSQdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737737182; c=relaxed/simple;
	bh=U541woq3XNmKv/+OAxSiPnVEQ8S+z6az2LKCn+ExIpg=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=FXrJArcRidJDc8++VsLmTV1FdygfP9uZm6LK9Yb1oT6FfGRXLCu3bpcOYQ3vJq8teadxLYscwTL0pK2DESlOm6U3HGTb2MKz97jUM755CZXTrs/b6zgAzKECtmd5zEvToxtUEgaRTRTGuv8WCwMaF4V+sryliBagyCI+tWH9QwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=mCv4TIRp; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="mCv4TIRp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1737737177;
	bh=U541woq3XNmKv/+OAxSiPnVEQ8S+z6az2LKCn+ExIpg=;
	h=From:To:Subject:Date:From;
	b=mCv4TIRpEE14zLOtEEnsW02RRbDoAdTSu3oiKDECpeRxBH6t9vTOPTpn4AWv47912
	 lEhhavAm24ZYXcJK2qsCsJ/ElDK+/TcOVezI2xFurie9JlsT/kGnnGQoXKIU6GO2zV
	 o38GoTd95IDGAXZHd49ld2mwpfZBkvSYbsJAnJrpIUWJ9sQNtzf96qr7sTKHogju0m
	 t9dS+CZW5BTmGmIdqrlJXlUvlkxyob6cvlaMa56hG7KckMaCqMOIgqeaNfZX0kAglI
	 V5QkzkMGdB59BPyTbN0R+rIkuIGlnL6wI36AII9Q7eqow+f4NChKpl1DZxyM5i2Ors
	 D3lkn4O7nzyFw==
Received: from fdanis-XPS-13-9370.. (67.227.121.78.rev.sfr.net [78.121.227.67])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: fdanis)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 0C89417E0237
	for <linux-bluetooth@vger.kernel.org>; Fri, 24 Jan 2025 17:46:17 +0100 (CET)
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?= <frederic.danis@collabora.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 1/2] mpris-proxy: Add mpris:artUrl support
Date: Fri, 24 Jan 2025 17:46:10 +0100
Message-ID: <20250124164611.1175429-1-frederic.danis@collabora.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

This commit connects to the bip-avrcp Obex service if the
org.bluez.MediaPlayer ObexPort property exists.
Once connected, the Track properties update may contain an
ImgHandle which is automatically downloaded, then a Metadata
property updated signal is sent on org.mpris.MediaPlayer2.Player
interface.

Some devices share the Obex session between multiple players. So
the Obex session is created by device.
---
 tools/mpris-proxy.c | 435 +++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 425 insertions(+), 10 deletions(-)

diff --git a/tools/mpris-proxy.c b/tools/mpris-proxy.c
index e5fc91fdb..1f6c86777 100644
--- a/tools/mpris-proxy.c
+++ b/tools/mpris-proxy.c
@@ -30,11 +30,18 @@
 #define BLUEZ_BUS_NAME "org.bluez"
 #define BLUEZ_PATH "/org/bluez"
 #define BLUEZ_ADAPTER_INTERFACE "org.bluez.Adapter1"
+#define BLUEZ_DEVICE_INTERFACE "org.bluez.Device1"
 #define BLUEZ_MEDIA_INTERFACE "org.bluez.Media1"
 #define BLUEZ_MEDIA_PLAYER_INTERFACE "org.bluez.MediaPlayer1"
 #define BLUEZ_MEDIA_FOLDER_INTERFACE "org.bluez.MediaFolder1"
 #define BLUEZ_MEDIA_ITEM_INTERFACE "org.bluez.MediaItem1"
 #define BLUEZ_MEDIA_TRANSPORT_INTERFACE "org.bluez.MediaTransport1"
+#define BLUEZ_OBEX_BUS_NAME "org.bluez.obex"
+#define BLUEZ_OBEX_PATH "/org/bluez/obex"
+#define BLUEZ_OBEX_CLIENT_PATH BLUEZ_OBEX_PATH "/client"
+#define BLUEZ_OBEX_CLIENT_INTERFACE "org.bluez.obex.Client1"
+#define BLUEZ_OBEX_IMAGE_INTERFACE "org.bluez.obex.Image1"
+#define BLUEZ_OBEX_TRANSFER_INTERFACE "org.bluez.obex.Transfer1"
 #define MPRIS_BUS_NAME "org.mpris.MediaPlayer2."
 #define MPRIS_INTERFACE "org.mpris.MediaPlayer2"
 #define MPRIS_PLAYER_INTERFACE "org.mpris.MediaPlayer2.Player"
@@ -48,8 +55,10 @@ static GDBusProxy *adapter = NULL;
 static DBusConnection *sys = NULL;
 static DBusConnection *session = NULL;
 static GDBusClient *client = NULL;
+static GDBusClient *obex_client;
 static GSList *players = NULL;
 static GSList *transports = NULL;
+static GSList *obex_sessions;
 
 static gboolean option_version = FALSE;
 static gboolean option_export = FALSE;
@@ -59,6 +68,12 @@ struct tracklist {
 	GSList *items;
 };
 
+struct obex_session {
+	GDBusProxy *device;
+	GDBusProxy *obex;
+	uint16_t port;
+};
+
 struct player {
 	char *bus_name;
 	DBusConnection *conn;
@@ -67,11 +82,14 @@ struct player {
 	GDBusProxy *device;
 	GDBusProxy *transport;
 	GDBusProxy *playlist;
+	struct obex_session *obex;
 	struct tracklist *tracklist;
+	char *filename;
 };
 
 typedef int (* parse_metadata_func) (DBusMessageIter *iter, const char *key,
-						DBusMessageIter *metadata);
+						DBusMessageIter *metadata,
+						void *userdata);
 
 static void dict_append_entry(DBusMessageIter *dict, const char *key, int type,
 								void *val);
@@ -240,7 +258,8 @@ static void dict_append_iter(DBusMessageIter *dict, const char *key,
 }
 
 static int parse_metadata_entry(DBusMessageIter *entry, const char *key,
-						DBusMessageIter *metadata)
+						DBusMessageIter *metadata,
+						void *userdata)
 {
 	if (dbus_message_iter_get_arg_type(entry) != DBUS_TYPE_VARIANT)
 		return -EINVAL;
@@ -251,7 +270,8 @@ static int parse_metadata_entry(DBusMessageIter *entry, const char *key,
 }
 
 static int parse_metadata(DBusMessageIter *args, DBusMessageIter *metadata,
-						parse_metadata_func func)
+						parse_metadata_func func,
+						void *userdata)
 {
 	DBusMessageIter dict;
 	int ctype;
@@ -277,7 +297,7 @@ static int parse_metadata(DBusMessageIter *args, DBusMessageIter *metadata,
 		dbus_message_iter_get_basic(&entry, &key);
 		dbus_message_iter_next(&entry);
 
-		if (func(&entry, key, metadata) < 0)
+		if (func(&entry, key, metadata, userdata) < 0)
 			return -EINVAL;
 
 		dbus_message_iter_next(&dict);
@@ -299,7 +319,7 @@ static void append_metadata(DBusMessageIter *iter, DBusMessageIter *dict,
 			DBUS_TYPE_STRING_AS_STRING DBUS_TYPE_VARIANT_AS_STRING
 			DBUS_DICT_ENTRY_END_CHAR_AS_STRING, &metadata);
 
-	parse_metadata(dict, &metadata, func);
+	parse_metadata(dict, &metadata, func, NULL);
 
 	dbus_message_iter_close_container(&value, &metadata);
 	dbus_message_iter_close_container(iter, &value);
@@ -1223,7 +1243,8 @@ static gboolean parse_path_metadata(DBusMessageIter *iter, const char *key,
 }
 
 static int parse_track_entry(DBusMessageIter *entry, const char *key,
-						DBusMessageIter *metadata)
+						DBusMessageIter *metadata,
+						void *userdata)
 {
 	DBusMessageIter var;
 
@@ -1253,6 +1274,30 @@ static int parse_track_entry(DBusMessageIter *entry, const char *key,
 	} else if (strcasecmp(key, "Item") == 0) {
 		if (!parse_path_metadata(&var, "mpris:trackid", metadata))
 			return -EINVAL;
+	} else if (strcasecmp(key, "ImgHandle") == 0) {
+		struct player *player = userdata;
+		const char *handle, *path;
+		char *filename, *uri;
+
+		if (!player || !player->obex)
+			return -EINVAL;
+
+		path = g_dbus_proxy_get_path(player->obex->obex);
+
+		if (dbus_message_iter_get_arg_type(&var) != DBUS_TYPE_STRING)
+			return -EINVAL;
+		dbus_message_iter_get_basic(&var, &handle);
+
+		filename = g_strconcat(g_get_tmp_dir(), "/",
+				path + strlen(BLUEZ_OBEX_CLIENT_PATH "/"),
+				"-", handle, NULL);
+		if (access(filename, F_OK) == 0) {
+			uri = g_strconcat("file://", filename, NULL);
+			dict_append_entry(metadata, "mpris:artUrl",
+						DBUS_TYPE_STRING, &uri);
+			g_free(uri);
+		}
+		g_free(filename);
 	}
 
 	return 0;
@@ -1272,7 +1317,7 @@ static gboolean get_track(const GDBusPropertyTable *property,
 			DBUS_TYPE_STRING_AS_STRING DBUS_TYPE_VARIANT_AS_STRING
 			DBUS_DICT_ENTRY_END_CHAR_AS_STRING, &metadata);
 
-	parse_metadata(&var, &metadata, parse_track_entry);
+	parse_metadata(&var, &metadata, parse_track_entry, player);
 
 	dbus_message_iter_close_container(iter, &metadata);
 
@@ -1443,7 +1488,7 @@ static void append_item_metadata(void *data, void *user_data)
 									&path);
 
 	if (g_dbus_proxy_get_property(item, "Metadata", &var))
-		parse_metadata(&var, &metadata, parse_track_entry);
+		parse_metadata(&var, &metadata, parse_track_entry, NULL);
 
 	dbus_message_iter_close_container(iter, &metadata);
 
@@ -1938,11 +1983,72 @@ static void register_tracklist(GDBusProxy *proxy)
 				player, NULL);
 }
 
+static GDBusProxy *connect_obex_session(const char *address, uint16_t port)
+{
+	static const char *target_str = "bip-avrcp";
+	DBusMessage *msg, *reply;
+	DBusMessageIter iter, array;
+	const char *path;
+	DBusError err;
+
+	msg = dbus_message_new_method_call(BLUEZ_OBEX_BUS_NAME,
+					BLUEZ_OBEX_PATH,
+					BLUEZ_OBEX_CLIENT_INTERFACE,
+					"CreateSession");
+	dbus_message_iter_init_append(msg, &iter);
+	dbus_message_iter_append_basic(&iter, DBUS_TYPE_STRING, &address);
+	dbus_message_iter_open_container(&iter, DBUS_TYPE_ARRAY,
+					DBUS_DICT_ENTRY_BEGIN_CHAR_AS_STRING
+					DBUS_TYPE_STRING_AS_STRING
+					DBUS_TYPE_VARIANT_AS_STRING
+					DBUS_DICT_ENTRY_END_CHAR_AS_STRING,
+					&array);
+	dict_append_entry(&array, "Target", DBUS_TYPE_STRING, &target_str);
+	dict_append_entry(&array, "PSM", DBUS_TYPE_UINT16, &port);
+	dbus_message_iter_close_container(&iter, &array);
+
+	dbus_error_init(&err);
+	reply = dbus_connection_send_with_reply_and_block(session, msg, -1,
+								&err);
+	dbus_message_unref(msg);
+	if (!reply) {
+		if (dbus_error_is_set(&err)) {
+			fprintf(stderr, "%s\n", err.message);
+			dbus_error_free(&err);
+		}
+		return NULL;
+	}
+
+	if (!dbus_message_get_args(reply, NULL,
+					DBUS_TYPE_OBJECT_PATH, &path,
+					DBUS_TYPE_INVALID)) {
+		dbus_message_unref(reply);
+		return NULL;
+	}
+
+	return g_dbus_proxy_new(obex_client, path, BLUEZ_OBEX_IMAGE_INTERFACE);
+}
+
+static struct obex_session *find_obex_session_by_device(const char *device)
+{
+	GSList *l;
+
+	for (l = obex_sessions; l; l = l->next) {
+		struct obex_session *session = l->data;
+		const char *path = g_dbus_proxy_get_path(session->device);
+
+		if (g_strcmp0(device, path) == 0)
+			return session;
+	}
+
+	return NULL;
+}
+
 static void register_player(GDBusProxy *proxy)
 {
 	struct player *player;
 	DBusMessageIter iter;
-	const char *path, *alias, *name;
+	const char *path, *alias, *name, *address;
 	char *busname;
 	GDBusProxy *device, *transport;
 
@@ -1960,6 +2066,11 @@ static void register_player(GDBusProxy *proxy)
 
 	dbus_message_iter_get_basic(&iter, &alias);
 
+	if (!g_dbus_proxy_get_property(device, "Address", &iter))
+		return;
+
+	dbus_message_iter_get_basic(&iter, &address);
+
 	if (g_dbus_proxy_get_property(proxy, "Name", &iter)) {
 		dbus_message_iter_get_basic(&iter, &name);
 		busname = g_strconcat(alias, " ", name, NULL);
@@ -1971,6 +2082,27 @@ static void register_player(GDBusProxy *proxy)
 	player->proxy = g_dbus_proxy_ref(proxy);
 	player->device = device;
 
+	if (g_dbus_proxy_get_property(proxy, "ObexPort", &iter)) {
+		uint16_t port;
+		struct obex_session *session;
+
+		dbus_message_iter_get_basic(&iter, &port);
+
+		session = find_obex_session_by_device(path);
+		if (session == NULL || session->port != port) {
+			printf("Create new session\n");
+			session = g_new0(struct obex_session, 1);
+			session->obex = connect_obex_session(address, port);
+			session->device = g_dbus_proxy_ref(device);
+			session->port = port;
+
+			obex_sessions = g_slist_prepend(obex_sessions, session);
+		}
+		player->obex = session;
+	} else {
+		player->obex = NULL;
+	}
+
 	g_free(busname);
 
 	players = g_slist_prepend(players, player);
@@ -2177,7 +2309,7 @@ static void register_item(struct player *player, GDBusProxy *proxy)
 			DBUS_TYPE_STRING_AS_STRING DBUS_TYPE_VARIANT_AS_STRING
 			DBUS_DICT_ENTRY_END_CHAR_AS_STRING, &metadata);
 
-	parse_metadata(&iter, &metadata, parse_track_entry);
+	parse_metadata(&iter, &metadata, parse_track_entry, player);
 
 	dbus_message_iter_close_container(&args, &metadata);
 
@@ -2377,6 +2509,121 @@ static const char *property_to_mpris(const char *property)
 	return NULL;
 }
 
+static const char *obex_get_image_handle(DBusMessageIter *args)
+{
+	DBusMessageIter dict, var;
+	int ctype;
+
+	ctype = dbus_message_iter_get_arg_type(args);
+	if (ctype != DBUS_TYPE_ARRAY)
+		return NULL;
+
+	dbus_message_iter_recurse(args, &dict);
+
+	while ((ctype = dbus_message_iter_get_arg_type(&dict)) !=
+							DBUS_TYPE_INVALID) {
+		DBusMessageIter entry;
+		const char *key;
+
+		if (ctype != DBUS_TYPE_DICT_ENTRY)
+			return NULL;
+
+		dbus_message_iter_recurse(&dict, &entry);
+		if (dbus_message_iter_get_arg_type(&entry) != DBUS_TYPE_STRING)
+			return NULL;
+
+		dbus_message_iter_get_basic(&entry, &key);
+		dbus_message_iter_next(&entry);
+
+		if (dbus_message_iter_get_arg_type(&entry) != DBUS_TYPE_VARIANT)
+			return NULL;
+
+		dbus_message_iter_recurse(&entry, &var);
+
+		if (strcasecmp(key, "ImgHandle") == 0) {
+			const char *handle;
+
+			dbus_message_iter_get_basic(&var, &handle);
+			return handle;
+		}
+
+		dbus_message_iter_next(&dict);
+	}
+
+	return NULL;
+}
+
+static void obex_get_image(struct player *player, const char *handle)
+{
+	DBusMessage *msg;
+	DBusMessageIter iter, array;
+	struct obex_session *obex_session = player->obex;
+	const char *path = g_dbus_proxy_get_path(obex_session->obex);
+	char *filename;
+
+	player->filename = g_strconcat(g_get_tmp_dir(), "/",
+				path + strlen(BLUEZ_OBEX_CLIENT_PATH "/"),
+				"-", handle, NULL);
+	filename = g_strconcat(player->filename, ".tmp", NULL);
+
+	msg = dbus_message_new_method_call(BLUEZ_OBEX_BUS_NAME,
+					path,
+					BLUEZ_OBEX_IMAGE_INTERFACE,
+					"Get");
+	dbus_message_iter_init_append(msg, &iter);
+	dbus_message_iter_append_basic(&iter, DBUS_TYPE_STRING, &filename);
+	dbus_message_iter_append_basic(&iter, DBUS_TYPE_STRING, &handle);
+	dbus_message_iter_open_container(&iter, DBUS_TYPE_ARRAY,
+					DBUS_DICT_ENTRY_BEGIN_CHAR_AS_STRING
+					DBUS_TYPE_STRING_AS_STRING
+					DBUS_TYPE_VARIANT_AS_STRING
+					DBUS_DICT_ENTRY_END_CHAR_AS_STRING,
+					&array);
+	dbus_message_iter_close_container(&iter, &array);
+
+	if (!g_dbus_send_message(session, msg)) {
+		g_free(player->filename);
+		player->filename = NULL;
+	}
+	g_free(filename);
+}
+
+static void device_property_changed(GDBusProxy *proxy, const char *name,
+					DBusMessageIter *iter, void *user_data)
+{
+	const char *path;
+	struct obex_session *session;
+	gboolean connected;
+	GSList *l;
+
+	path = g_dbus_proxy_get_path(proxy);
+
+	if (strcasecmp(name, "Connected") != 0)
+		return;
+
+	dbus_message_iter_get_basic(iter, &connected);
+
+	if (connected)
+		return;
+
+	printf("Bluetooth Device %s disconnected\n", path);
+	session = find_obex_session_by_device(path);
+	if (session == NULL)
+		return;
+
+	for (l = players; l; l = l->next) {
+		struct player *player = l->data;
+
+		if (player->obex == session)
+			player->obex = NULL;
+	}
+
+	g_dbus_proxy_unref(session->obex);
+	g_dbus_proxy_unref(session->device);
+	obex_sessions = g_slist_remove(obex_sessions, session);
+	g_free(session);
+}
+
 static void player_property_changed(GDBusProxy *proxy, const char *name,
 					DBusMessageIter *iter, void *user_data)
 {
@@ -2397,6 +2644,13 @@ static void player_property_changed(GDBusProxy *proxy, const char *name,
 						MPRIS_PLAYER_INTERFACE,
 						property);
 
+	if (strcasecmp(name, "Track") == 0 && player->obex) {
+		const char *handle = obex_get_image_handle(iter);
+
+		if (handle)
+			obex_get_image(player, handle);
+	}
+
 	if (strcasecmp(name, "Position") != 0)
 		return;
 
@@ -2485,6 +2739,9 @@ static void property_changed(GDBusProxy *proxy, const char *name,
 
 	interface = g_dbus_proxy_get_interface(proxy);
 
+	if (strcmp(interface, BLUEZ_DEVICE_INTERFACE) == 0)
+		return device_property_changed(proxy, name, iter, user_data);
+
 	if (strcmp(interface, BLUEZ_MEDIA_PLAYER_INTERFACE) == 0)
 		return player_property_changed(proxy, name, iter, user_data);
 
@@ -2496,6 +2753,151 @@ static void property_changed(GDBusProxy *proxy, const char *name,
 		return item_property_changed(proxy, name, iter, user_data);
 }
 
+static struct player *find_player_by_obex(const char *path)
+{
+	GSList *l;
+
+	for (l = players; l; l = l->next) {
+		struct player *player = l->data;
+		struct obex_session *session = player->obex;
+		const char *obex_path = g_dbus_proxy_get_path(session->obex);
+
+		if (g_str_has_prefix(path, obex_path))
+			return player;
+	}
+
+	return NULL;
+}
+
+static void obex_connect_handler(DBusConnection *connection, void *user_data)
+{
+	printf("org.bluez.obex appeared\n");
+}
+
+static void obex_disconnect_handler(DBusConnection *connection,
+					void *user_data)
+{
+	printf("org.bluez.obex disappeared\n");
+}
+
+static void obex_proxy_added(GDBusProxy *proxy, void *user_data)
+{
+	const char *interface;
+	const char *path;
+
+	interface = g_dbus_proxy_get_interface(proxy);
+	path = g_dbus_proxy_get_path(proxy);
+
+	if (!strcmp(interface, BLUEZ_OBEX_CLIENT_INTERFACE)) {
+		GSList *l;
+
+		printf("Bluetooth Obex Client %s found\n", path);
+
+		for (l = players; l; l = l->next) {
+			struct player *player = l->data;
+			DBusMessageIter iter;
+			const char *address;
+			uint16_t port;
+			struct obex_session *session;
+
+			if (!g_dbus_proxy_get_property(player->proxy,
+					"ObexPort", &iter) ||
+					player->obex)
+				continue;
+
+			dbus_message_iter_get_basic(&iter, &port);
+
+			if (!g_dbus_proxy_get_property(player->device,
+					"Address", &iter))
+				continue;
+
+			dbus_message_iter_get_basic(&iter, &address);
+
+			session = find_obex_session_by_device(path);
+			if (session == NULL || session->port != port) {
+				printf("Bluetooth Obex Create new session\n");
+				session = g_new0(struct obex_session, 1);
+				session->obex = connect_obex_session(address,
+									port);
+				session->device = g_dbus_proxy_ref(
+							player->device);
+				session->port = port;
+
+				obex_sessions = g_slist_prepend(obex_sessions,
+								session);
+			}
+			player->obex = session;
+		}
+	}
+}
+
+static void obex_proxy_removed(GDBusProxy *proxy, void *user_data)
+{
+	const char *interface;
+	const char *path;
+
+	if (adapter == NULL)
+		return;
+
+	interface = g_dbus_proxy_get_interface(proxy);
+	path = g_dbus_proxy_get_path(proxy);
+
+	if (strcmp(interface, BLUEZ_OBEX_CLIENT_INTERFACE) == 0) {
+		GSList *l;
+
+		printf("Bluetooth Obex Client %s removed\n", path);
+
+		for (l = players; l; l = l->next) {
+			struct player *player = l->data;
+
+			player->obex = NULL;
+		}
+
+		while (obex_sessions) {
+			struct obex_session *session = obex_sessions->data;
+
+			g_dbus_proxy_unref(session->device);
+			g_dbus_proxy_unref(session->obex);
+			obex_sessions = g_slist_remove(obex_sessions, session);
+		}
+	}
+}
+
+static void obex_property_changed(GDBusProxy *proxy, const char *name,
+					DBusMessageIter *iter, void *user_data)
+{
+	const char *interface;
+	const char *path;
+
+	interface = g_dbus_proxy_get_interface(proxy);
+	path = g_dbus_proxy_get_path(proxy);
+
+	if (strcmp(interface, BLUEZ_OBEX_TRANSFER_INTERFACE) == 0) {
+		struct player *player;
+		const char *status;
+
+		if (strcasecmp(name, "Status") != 0)
+			return;
+
+		dbus_message_iter_get_basic(iter, &status);
+
+		player = find_player_by_obex(path);
+		if (player && strcasecmp(status, "complete") == 0) {
+			char *filename;
+
+			filename = g_strconcat(player->filename, ".tmp", NULL);
+			rename(filename, player->filename);
+			g_free(player->filename);
+			player->filename = NULL;
+
+			g_dbus_emit_property_changed(player->conn,
+							MPRIS_PLAYER_PATH,
+							MPRIS_PLAYER_INTERFACE,
+							"Metadata");
+		}
+	}
+}
+
 int main(int argc, char *argv[])
 {
 	GOptionContext *context;
@@ -2566,6 +2968,19 @@ int main(int argc, char *argv[])
 	g_dbus_client_set_proxy_handlers(client, proxy_added, proxy_removed,
 						property_changed, NULL);
 
+	obex_client = g_dbus_client_new(session, BLUEZ_OBEX_BUS_NAME,
+					BLUEZ_OBEX_PATH);
+
+	g_dbus_client_set_connect_watch(obex_client, obex_connect_handler,
+					NULL);
+	g_dbus_client_set_disconnect_watch(obex_client,
+						obex_disconnect_handler,
+						NULL);
+
+	g_dbus_client_set_proxy_handlers(obex_client, obex_proxy_added,
+						obex_proxy_removed,
+						obex_property_changed, NULL);
+
 	g_main_loop_run(main_loop);
 
 	g_dbus_remove_watch(session, owner_watch);
-- 
2.43.0

