Return-Path: <cyrus@holtmann.org>
From: chanyeol.park@samsung.com
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 3/4] core: replace NULL by dbus invalid arguments
Date: Tue, 28 Aug 2012 19:24:54 +0900
Message-id: <1346149495-9363-3-git-send-email-chanyeol.park@samsung.com>
In-reply-to: <1346149495-9363-1-git-send-email-chanyeol.park@samsung.com>
References: <1346149495-9363-1-git-send-email-chanyeol.park@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Chan-yeol Park <chanyeol.park@samsung.com>

This patch replaces NULL with dbus invalid arguments return
if dbus method call gets invalid arguments from the peer.
This will avoid dbus peer coommander's infinite wait.
---
 audio/media.c                 |    4 ++--
 audio/transport.c             |    4 ++--
 plugins/service.c             |    8 ++++----
 profiles/network/connection.c |    2 +-
 profiles/network/server.c     |    4 ++--
 src/adapter.c                 |    4 ++--
 src/manager.c                 |    2 +-
 7 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/audio/media.c b/audio/media.c
index ea6d582..b0ea4e9 100644
--- a/audio/media.c
+++ b/audio/media.c
@@ -926,7 +926,7 @@ static DBusMessage *unregister_endpoint(DBusConnection *conn, DBusMessage *msg,
 	if (!dbus_message_get_args(msg, NULL,
 				DBUS_TYPE_OBJECT_PATH, &path,
 				DBUS_TYPE_INVALID))
-		return NULL;
+		return btd_error_invalid_args(msg);
 
 	sender = dbus_message_get_sender(msg);
 
@@ -1808,7 +1808,7 @@ static DBusMessage *unregister_player(DBusConnection *conn, DBusMessage *msg,
 	if (!dbus_message_get_args(msg, NULL,
 				DBUS_TYPE_OBJECT_PATH, &path,
 				DBUS_TYPE_INVALID))
-		return NULL;
+		return btd_error_invalid_args(msg);
 
 	sender = dbus_message_get_sender(msg);
 
diff --git a/audio/transport.c b/audio/transport.c
index 832ad2a..d40c92d 100644
--- a/audio/transport.c
+++ b/audio/transport.c
@@ -667,7 +667,7 @@ static DBusMessage *acquire(DBusConnection *conn, DBusMessage *msg,
 	if (!dbus_message_get_args(msg, NULL,
 				DBUS_TYPE_STRING, &accesstype,
 				DBUS_TYPE_INVALID))
-		return NULL;
+		return btd_error_invalid_args(msg);
 
 	sender = dbus_message_get_sender(msg);
 
@@ -704,7 +704,7 @@ static DBusMessage *release(DBusConnection *conn, DBusMessage *msg,
 	if (!dbus_message_get_args(msg, NULL,
 				DBUS_TYPE_STRING, &accesstype,
 				DBUS_TYPE_INVALID))
-		return NULL;
+		return btd_error_invalid_args(msg);
 
 	sender = dbus_message_get_sender(msg);
 
diff --git a/plugins/service.c b/plugins/service.c
index 9f7bdb7..f16abe7 100644
--- a/plugins/service.c
+++ b/plugins/service.c
@@ -422,7 +422,7 @@ static DBusMessage *update_xml_record(DBusConnection *conn,
 				DBUS_TYPE_UINT32, &handle,
 				DBUS_TYPE_STRING, &record,
 				DBUS_TYPE_INVALID) == FALSE)
-		return NULL;
+		return btd_error_invalid_args(msg);
 
 	len = (record ? strlen(record) : 0);
 	if (len == 0)
@@ -475,7 +475,7 @@ static DBusMessage *add_service_record(DBusConnection *conn,
 
 	if (dbus_message_get_args(msg, NULL,
 			DBUS_TYPE_STRING, &record, DBUS_TYPE_INVALID) == FALSE)
-		return NULL;
+		return btd_error_invalid_args(msg);
 
 	sender = dbus_message_get_sender(msg);
 	err = add_xml_record(conn, sender, serv_adapter, record, &handle);
@@ -509,7 +509,7 @@ static DBusMessage *remove_service_record(DBusConnection *conn,
 
 	if (dbus_message_get_args(msg, NULL, DBUS_TYPE_UINT32, &handle,
 						DBUS_TYPE_INVALID) == FALSE)
-		return NULL;
+		return btd_error_invalid_args(msg);
 
 	sender = dbus_message_get_sender(msg);
 
@@ -582,7 +582,7 @@ static DBusMessage *request_authorization(DBusConnection *conn,
 	if (dbus_message_get_args(msg, NULL, DBUS_TYPE_STRING, &address,
 					DBUS_TYPE_UINT32, &handle,
 					DBUS_TYPE_INVALID) == FALSE)
-		return NULL;
+		return btd_error_invalid_args(msg);
 
 	sender = dbus_message_get_sender(msg);
 	if (find_pending_by_sender(serv_adapter, sender))
diff --git a/profiles/network/connection.c b/profiles/network/connection.c
index e8ac643..c1ae3fa 100644
--- a/profiles/network/connection.c
+++ b/profiles/network/connection.c
@@ -402,7 +402,7 @@ static DBusMessage *connection_connect(DBusConnection *conn,
 
 	if (dbus_message_get_args(msg, NULL, DBUS_TYPE_STRING, &svc,
 						DBUS_TYPE_INVALID) == FALSE)
-		return NULL;
+		return btd_error_invalid_args(msg);
 
 	id = bnep_service_id(svc);
 	nc = find_connection(peer->connections, id);
diff --git a/profiles/network/server.c b/profiles/network/server.c
index cfad893..a3274d9 100644
--- a/profiles/network/server.c
+++ b/profiles/network/server.c
@@ -633,7 +633,7 @@ static DBusMessage *register_server(DBusConnection *conn,
 
 	if (!dbus_message_get_args(msg, NULL, DBUS_TYPE_STRING, &uuid,
 				DBUS_TYPE_STRING, &bridge, DBUS_TYPE_INVALID))
-		return NULL;
+		return btd_error_invalid_args(msg);
 
 	if (g_strcmp0(uuid, "nap"))
 		return btd_error_failed(msg, "Invalid UUID");
@@ -668,7 +668,7 @@ static DBusMessage *unregister_server(DBusConnection *conn,
 
 	if (!dbus_message_get_args(msg, NULL, DBUS_TYPE_STRING, &uuid,
 							DBUS_TYPE_INVALID))
-		return NULL;
+		return btd_error_invalid_args(msg);
 
 	if (g_strcmp0(uuid, "nap"))
 		return btd_error_failed(msg, "Invalid UUID");
diff --git a/src/adapter.c b/src/adapter.c
index 50779fd..4c70e2f 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -1574,7 +1574,7 @@ static DBusMessage *register_agent(DBusConnection *conn, DBusMessage *msg,
 
 	if (!dbus_message_get_args(msg, NULL, DBUS_TYPE_OBJECT_PATH, &path,
 			DBUS_TYPE_STRING, &capability, DBUS_TYPE_INVALID))
-		return NULL;
+		return btd_error_invalid_args(msg);
 
 	if (adapter->agent)
 		return btd_error_already_exists(msg);
@@ -1604,7 +1604,7 @@ static DBusMessage *unregister_agent(DBusConnection *conn, DBusMessage *msg,
 
 	if (!dbus_message_get_args(msg, NULL, DBUS_TYPE_OBJECT_PATH, &path,
 						DBUS_TYPE_INVALID))
-		return NULL;
+		return btd_error_invalid_args(msg);
 
 	name = dbus_message_get_sender(msg);
 
diff --git a/src/manager.c b/src/manager.c
index 4a39461..738bf0b 100644
--- a/src/manager.c
+++ b/src/manager.c
@@ -96,7 +96,7 @@ static DBusMessage *find_adapter(DBusConnection *conn,
 
 	if (!dbus_message_get_args(msg, NULL, DBUS_TYPE_STRING, &pattern,
 							DBUS_TYPE_INVALID))
-		return NULL;
+		return btd_error_invalid_args(msg);
 
 	/* hci_devid() would make sense to use here, except it is
 	 * restricted to devices which are up */
-- 
1.7.9.5

