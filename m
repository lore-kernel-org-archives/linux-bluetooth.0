Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 072FB2144B1
	for <linux-bluetooth@vger.kernel.org>; Tue,  4 Feb 2025 15:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738683629; cv=none; b=DACd5lq8v3Xq7SgKFdQy9POXtJ/YDZli+1o0ieu/+VUbOyge8QtJdfWvbXuA4DTY1g0KqTrWMPlqnPTfSLBM3enFqiV0nW29J+7eM0WwhJnmD8lQE31DiZvGRLUxp7VrXXOrH5wnk3duJaiJkfjaxouuWn9Swhqm19LAMhzrRYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738683629; c=relaxed/simple;
	bh=fLmBSqxbn24FjUGV8S+/cNZnvV3pe3uVLI72S1otS28=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=B3nSP3a56P862fvK51iEIS1WxIxcNezJ+gouotdV+dyzXLIMNQqxCGwhet+FEH7LdG6piSXWFYp8kLcgjI3iaxkqSWqr/nggwnGbGgyuG/q6gjR3hZz1yJpaeo4eyQ2A8vZ3RxNBYooMnDfuI+budZiHaiYAG/Xqcepig7XXrf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=AC6MpbhI; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="AC6MpbhI"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1738683624;
	bh=fLmBSqxbn24FjUGV8S+/cNZnvV3pe3uVLI72S1otS28=;
	h=From:To:Subject:Date:From;
	b=AC6MpbhIP8vfAwADbczpBcX58dSWcFFuXYzFo9+M7/jqIZ9hWV1rW9866eDY544Ij
	 RvZcWfgS8+qBGr6U7KJrmrRqPzysmsW/YFqwquiAdeSQjUUoMIAXzlwi9CAiEzHo2z
	 djOV8qRxItF0uypraic6PC1kqvqf95f7cYrComHSEbKjb6cJ+FcAxXh2GxUHb7I2vj
	 oUhWDcEwrTDwpRxxcKN2Pgs+EpLIoKxxPRLnRch9nLvZBDdpDc4z6v0pwBtQ2+MhlJ
	 0/KZSMeTWqkybLq3viGa9bLZNuUjlNFxRDCkuzpgewI9OZ1KBzT+k3oa8XxjVk2Yvh
	 EopR3q+2JcYuA==
Received: from fdanis-XPS-13-9370.. (2A02-8428-Af44-1001-Aa7E-9220-7620-339E.rev.sfr.net [IPv6:2a02:8428:af44:1001:aa7e:9220:7620:339e])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: fdanis)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id B749817E0FDF
	for <linux-bluetooth@vger.kernel.org>; Tue,  4 Feb 2025 16:40:24 +0100 (CET)
From: =?UTF-8?q?Fr=C3=A9d=C3=A9ric=20Danis?= <frederic.danis@collabora.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ v2 1/2] mpris-proxy: Add mpris:artUrl support
Date: Tue,  4 Feb 2025 16:40:18 +0100
Message-ID: <20250204154020.95539-1-frederic.danis@collabora.com>
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

mpris-proxy logs with cover art download and player switch:

$ tools/mpris-proxy
org.bluez appeared
org.bluez.obex appeared
Bluetooth Obex Client /org/bluez/obex found
Bluetooth Adapter /org/bluez/hci0 found
player org.mpris.MediaPlayer2.rhythmbox at :1.159 found
Bluetooth Transport /org/bluez/hci0/dev_24_24_B7_11_82_6C/fd8 found
Bluetooth Player /org/bluez/hci0/dev_24_24_B7_11_82_6C/player0 found
Bluetooth Obex Create new session
Player org.mpris.MediaPlayer2.Fr__d__ric_s_S23 created
Bluetooth Item /org/bluez/hci0/dev_24_24_B7_11_82_6C/player0/Filesystem found
Bluetooth Item /org/bluez/hci0/dev_24_24_B7_11_82_6C/player0/NowPlaying found
Bluetooth Folder /org/bluez/hci0/dev_24_24_B7_11_82_6C/player0 found
Bluetooth Obex ImgHandle: 0000007
Bluetooth Item /org/bluez/hci0/dev_24_24_B7_11_82_6C/player0/NowPlaying/item2 found
Bluetooth Obex cover art available at: /tmp/session9-0000007
Bluetooth Player /org/bluez/hci0/dev_24_24_B7_11_82_6C/player0 removed
Bluetooth Player /org/bluez/hci0/dev_24_24_B7_11_82_6C/player127 found
Bluetooth Obex reuse existing session
Player org.mpris.MediaPlayer2.Fr__d__ric_s_S23_Media_Player created
player org.mpris.MediaPlayer2.Fr__d__ric_s_S23 at :1.1035 disappear
Bluetooth Obex ImgHandle: 0000008
Bluetooth Obex cover art available at: /tmp/session9-0000008
---
v2: Add logs
    Update commit message with sample output
    Fix memory leaks
    Add create_obex_session() to factorize code

 tools/mpris-proxy.c | 442 +++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 432 insertions(+), 10 deletions(-)

diff --git a/tools/mpris-proxy.c b/tools/mpris-proxy.c
index e5fc91fdb..9edd42e99 100644
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
 
@@ -1938,11 +1983,96 @@ static void register_tracklist(GDBusProxy *proxy)
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
+	dbus_message_unref(reply);
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
+static struct obex_session *create_obex_session(GDBusProxy *device,
+						const char *path,
+						const char *address,
+						uint16_t port)
+{
+	struct obex_session *session;
+
+	session = find_obex_session_by_device(path);
+	if (session == NULL || session->port != port) {
+		printf("Bluetooth Obex Create new session\n");
+		session = g_new0(struct obex_session, 1);
+		session->obex = connect_obex_session(address, port);
+		session->device = g_dbus_proxy_ref(device);
+		session->port = port;
+
+		obex_sessions = g_slist_prepend(obex_sessions, session);
+	} else {
+		printf("Bluetooth Obex reuse existing session\n");
+	}
+
+	return session;
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
 
@@ -1960,6 +2090,11 @@ static void register_player(GDBusProxy *proxy)
 
 	dbus_message_iter_get_basic(&iter, &alias);
 
+	if (!g_dbus_proxy_get_property(device, "Address", &iter))
+		return;
+
+	dbus_message_iter_get_basic(&iter, &address);
+
 	if (g_dbus_proxy_get_property(proxy, "Name", &iter)) {
 		dbus_message_iter_get_basic(&iter, &name);
 		busname = g_strconcat(alias, " ", name, NULL);
@@ -1971,6 +2106,16 @@ static void register_player(GDBusProxy *proxy)
 	player->proxy = g_dbus_proxy_ref(proxy);
 	player->device = device;
 
+	if (g_dbus_proxy_get_property(proxy, "ObexPort", &iter)) {
+		uint16_t port;
+
+		dbus_message_iter_get_basic(&iter, &port);
+
+		player->obex = create_obex_session(device, path, address, port);
+	} else {
+		player->obex = NULL;
+	}
+
 	g_free(busname);
 
 	players = g_slist_prepend(players, player);
@@ -2177,7 +2322,7 @@ static void register_item(struct player *player, GDBusProxy *proxy)
 			DBUS_TYPE_STRING_AS_STRING DBUS_TYPE_VARIANT_AS_STRING
 			DBUS_DICT_ENTRY_END_CHAR_AS_STRING, &metadata);
 
-	parse_metadata(&iter, &metadata, parse_track_entry);
+	parse_metadata(&iter, &metadata, parse_track_entry, player);
 
 	dbus_message_iter_close_container(&args, &metadata);
 
@@ -2377,6 +2522,122 @@ static const char *property_to_mpris(const char *property)
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
+			printf("Bluetooth Obex ImgHandle: %s\n", handle);
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
@@ -2397,6 +2658,13 @@ static void player_property_changed(GDBusProxy *proxy, const char *name,
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
 
@@ -2485,6 +2753,9 @@ static void property_changed(GDBusProxy *proxy, const char *name,
 
 	interface = g_dbus_proxy_get_interface(proxy);
 
+	if (strcmp(interface, BLUEZ_DEVICE_INTERFACE) == 0)
+		return device_property_changed(proxy, name, iter, user_data);
+
 	if (strcmp(interface, BLUEZ_MEDIA_PLAYER_INTERFACE) == 0)
 		return player_property_changed(proxy, name, iter, user_data);
 
@@ -2496,6 +2767,144 @@ static void property_changed(GDBusProxy *proxy, const char *name,
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
+			player->obex = create_obex_session(player->device,
+								path,
+								address,
+								port);
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
+			printf("Bluetooth Obex cover art available at: %s\n",
+				player->filename);
+
+			filename = g_strconcat(player->filename, ".tmp", NULL);
+			rename(filename, player->filename);
+			g_free(filename);
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
@@ -2566,6 +2975,19 @@ int main(int argc, char *argv[])
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

