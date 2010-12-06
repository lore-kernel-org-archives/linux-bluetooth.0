Return-Path: <cyrus@holtmann.org>
From: "Gustavo F. Padovan" <padovan@profusion.mobi>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 2/9] Add btd_error_already_exists()
Date: Mon,  6 Dec 2010 17:10:41 -0200
Message-Id: <1291662648-10651-2-git-send-email-padovan@profusion.mobi>
In-Reply-To: <1291662648-10651-1-git-send-email-padovan@profusion.mobi>
References: <1291662648-10651-1-git-send-email-padovan@profusion.mobi>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 audio/gateway.c  |    4 +---
 audio/media.c    |    3 +--
 network/server.c |    2 +-
 serial/proxy.c   |    3 +--
 src/adapter.c    |    8 ++------
 src/device.c     |    4 +---
 src/error.c      |    7 +++++++
 src/error.h      |    1 +
 8 files changed, 15 insertions(+), 17 deletions(-)

diff --git a/audio/gateway.c b/audio/gateway.c
index 450772b..79847b7 100644
--- a/audio/gateway.c
+++ b/audio/gateway.c
@@ -485,9 +485,7 @@ static DBusMessage *register_agent(DBusConnection *conn,
 	const char *path, *name;
 
 	if (gw->agent)
-		return g_dbus_create_error(msg,
-					ERROR_INTERFACE ".AlreadyExists",
-					"Agent already exists");
+		return btd_error_already_exists(msg);
 
 	if (!dbus_message_get_args(msg, NULL, DBUS_TYPE_OBJECT_PATH, &path,
 						DBUS_TYPE_INVALID))
diff --git a/audio/media.c b/audio/media.c
index bf42bdf..b893231 100644
--- a/audio/media.c
+++ b/audio/media.c
@@ -318,8 +318,7 @@ static DBusMessage *register_endpoint(DBusConnection *conn, DBusMessage *msg,
 	dbus_message_iter_next(&args);
 
 	if (media_adapter_find_endpoint(adapter, sender, path, NULL) != NULL)
-		return g_dbus_create_error(msg, ERROR_INTERFACE ".Failed",
-				"Endpoint already registered");
+		return btd_error_already_exists(msg);
 
 	dbus_message_iter_recurse(&args, &props);
 	if (dbus_message_iter_get_arg_type(&props) != DBUS_TYPE_DICT_ENTRY)
diff --git a/network/server.c b/network/server.c
index 33da06d..60e1a81 100644
--- a/network/server.c
+++ b/network/server.c
@@ -603,7 +603,7 @@ static DBusMessage *register_server(DBusConnection *conn,
 		return failed(msg, "Invalid UUID");
 
 	if (ns->record_id)
-		return failed(msg, "Already registered");
+		return btd_error_already_exists(msg);
 
 	reply = dbus_message_new_method_return(msg);
 	if (!reply)
diff --git a/serial/proxy.c b/serial/proxy.c
index b5f5578..b2ced98 100644
--- a/serial/proxy.c
+++ b/serial/proxy.c
@@ -1056,8 +1056,7 @@ static DBusMessage *create_proxy(DBusConnection *conn,
 	if (err == -EINVAL)
 		return btd_error_invalid_args(msg);
 	else if (err == -EALREADY)
-		return g_dbus_create_error(msg, ERROR_INTERFACE ".AlreadyExist",
-						"Proxy already exists");
+		return btd_error_already_exists(msg);
 	else if (err < 0)
 		return g_dbus_create_error(msg, ERROR_INTERFACE "Failed",
 				"Proxy creation failed (%s)", strerror(-err));
diff --git a/src/adapter.c b/src/adapter.c
index 428de66..2aa9977 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -1698,9 +1698,7 @@ static DBusMessage *create_device(DBusConnection *conn,
 		return btd_error_invalid_args(msg);
 
 	if (adapter_find_device(adapter, address))
-		return g_dbus_create_error(msg,
-				ERROR_INTERFACE ".AlreadyExists",
-				"Device already exists");
+		return btd_error_already_exists(msg);
 
 	DBG("%s", address);
 
@@ -1871,9 +1869,7 @@ static DBusMessage *register_agent(DBusConnection *conn, DBusMessage *msg,
 		return NULL;
 
 	if (adapter->agent)
-		return g_dbus_create_error(msg,
-				ERROR_INTERFACE ".AlreadyExists",
-				"Agent already exists");
+		return btd_error_already_exists(msg);
 
 	cap = parse_io_capability(capability);
 	if (cap == IO_CAPABILITY_INVALID)
diff --git a/src/device.c b/src/device.c
index ab7ef93..3a9cc76 100644
--- a/src/device.c
+++ b/src/device.c
@@ -2002,9 +2002,7 @@ DBusMessage *device_create_bonding(struct btd_device *device,
 	str = textfile_caseget(filename, dstaddr);
 	if (str) {
 		free(str);
-		return g_dbus_create_error(msg,
-				ERROR_INTERFACE ".AlreadyExists",
-				"Bonding already exists");
+		return btd_error_already_exists(msg);
 	}
 
 	/* If our IO capability is NoInputNoOutput use medium security
diff --git a/src/error.c b/src/error.c
index 0807965..415511d 100644
--- a/src/error.c
+++ b/src/error.c
@@ -55,3 +55,10 @@ DBusMessage *btd_error_invalid_args(DBusMessage *msg)
 					".InvalidArguments",
 					"Invalid arguments in method call");
 }
+
+DBusMessage *btd_error_already_exists(DBusMessage *msg)
+{
+	return g_dbus_create_error(msg,
+				ERROR_INTERFACE ".AlreadyExists",
+				"Already Exists");
+}
diff --git a/src/error.h b/src/error.h
index 3a01114..de40f57 100644
--- a/src/error.h
+++ b/src/error.h
@@ -31,3 +31,4 @@ DBusHandlerResult error_common_reply(DBusConnection *conn, DBusMessage *msg,
 					const char *name, const char *descr);
 
 DBusMessage *btd_error_invalid_args(DBusMessage *msg);
+DBusMessage *btd_error_already_exists(DBusMessage *msg);
-- 
1.7.3.2

