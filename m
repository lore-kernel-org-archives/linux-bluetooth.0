Return-Path: <cyrus@holtmann.org>
From: Forrest Zhao <forrest.zhao@intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: forrest.zhao@gmail.com, Forrest Zhao <forrest.zhao@intel.com>
Subject: [PATCH] add support for multi serial proxy configuration
Date: Wed, 22 Jul 2009 17:20:40 +0800
Message-Id: <1248254440-29598-1-git-send-email-forrest.zhao@intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 serial/Makefile.am |    2 +
 serial/proxy.c     |  157 ++++++++++++++++++++++++++++++++++++++++------------
 serial/serial.conf |   10 +++
 3 files changed, 134 insertions(+), 35 deletions(-)
 create mode 100644 serial/serial.conf

diff --git a/serial/Makefile.am b/serial/Makefile.am
index 4fa455f..c88a980 100644
--- a/serial/Makefile.am
+++ b/serial/Makefile.am
@@ -19,4 +19,6 @@ AM_CFLAGS = -fvisibility=hidden \
 
 INCLUDES = -I$(top_srcdir)/common -I$(top_srcdir)/src
 
+EXTRA_DIST = serial.conf
+
 MAINTAINERCLEANFILES = Makefile.in
diff --git a/serial/proxy.c b/serial/proxy.c
index 8c8a4b8..50ffee3 100644
--- a/serial/proxy.c
+++ b/serial/proxy.c
@@ -962,70 +962,86 @@ static int proxy_pathcmp(gconstpointer proxy, gconstpointer p)
 	return strcmp(prx->path, path);
 }
 
-static DBusMessage *create_proxy(DBusConnection *conn,
-				DBusMessage *msg, void *data)
+static int register_proxy(struct serial_adapter *adapter, const char *uuid_str,
+				const char *address, char *path, size_t length)
 {
-	struct serial_adapter *adapter = data;
-	char path[MAX_PATH_LENGTH + 1];
-	const char *pattern, *address, *ppath = path;
-	char *uuid_str;
 	proxy_type_t type;
-	uuid_t uuid;
 	int ret;
 
-	if (!dbus_message_get_args(msg, NULL,
-				DBUS_TYPE_STRING, &pattern,
-				DBUS_TYPE_STRING, &address,
-				DBUS_TYPE_INVALID))
-		return NULL;
-
-	uuid_str = bt_name2string(pattern);
-	if (!uuid_str)
-		return invalid_arguments(msg, "Invalid UUID");
-
-	bt_string2uuid(&uuid, uuid_str);
-
 	type = addr2type(address);
-	if (type == UNKNOWN_PROXY_TYPE) {
-		g_free(uuid_str);
-		return invalid_arguments(msg, "Invalid address");
-	}
+	if (type == UNKNOWN_PROXY_TYPE)
+		return -EINVAL;
 
 	/* Only one proxy per address(TTY or unix socket) is allowed */
-	if (g_slist_find_custom(adapter->proxies, address, proxy_addrcmp)) {
-		g_free(uuid_str);
-		return g_dbus_create_error(msg, ERROR_INTERFACE ".AlreadyExist",
-						"Proxy already exists");
-	}
+	if (g_slist_find_custom(adapter->proxies, address, proxy_addrcmp))
+		return -EALREADY;
 
 	switch (type) {
 	case UNIX_SOCKET_PROXY:
 		ret = proxy_socket_register(adapter, uuid_str, address,
-						path, sizeof(path), TRUE);
+						path, length, TRUE);
 		break;
 	case TTY_PROXY:
 		ret = proxy_tty_register(adapter, uuid_str, address,
-				NULL, path, sizeof(path), TRUE);
+					NULL, path, length, TRUE);
 		break;
 	case TCP_SOCKET_PROXY:
 		ret = proxy_tcp_register(adapter, uuid_str, address,
-					path, sizeof(path), TRUE);
+						path, length, TRUE);
 		break;
 	default:
 		ret = -1;
 	}
 
-	g_free(uuid_str);
-
 	if (ret < 0)
-		return failed(msg, "Create object path failed");
+		return -EIO;
 
 	g_dbus_emit_signal(adapter->conn,
 			adapter_get_path(adapter->btd_adapter),
 			SERIAL_MANAGER_INTERFACE, "ProxyCreated",
-			DBUS_TYPE_STRING, &ppath,
+			DBUS_TYPE_STRING, &path,
 			DBUS_TYPE_INVALID);
 
+	return 0;
+}
+
+static DBusMessage *create_proxy(DBusConnection *conn,
+				DBusMessage *msg, void *data)
+{
+	struct serial_adapter *adapter = data;
+	char path[MAX_PATH_LENGTH + 1];
+	const char *pattern, *address;
+	char *uuid_str, *ppath = path;
+	uuid_t uuid;
+	int ret;
+
+	if (!dbus_message_get_args(msg, NULL,
+				DBUS_TYPE_STRING, &pattern,
+				DBUS_TYPE_STRING, &address,
+				DBUS_TYPE_INVALID))
+		return NULL;
+
+	uuid_str = bt_name2string(pattern);
+	if (!uuid_str)
+		return invalid_arguments(msg, "Invalid UUID");
+
+	bt_string2uuid(&uuid, uuid_str);
+
+	ret = register_proxy(adapter, uuid_str, address, ppath,
+						sizeof(path));
+	g_free(uuid_str);
+
+	if (ret == -EINVAL)
+		return invalid_arguments(msg, "Invalid address");
+	else if (ret == -EALREADY)
+		return g_dbus_create_error(msg, ERROR_INTERFACE ".AlreadyExist",
+						"Proxy already exists");
+	else if (ret == -EIO)
+		return failed(msg, "Create object path failed");
+	else if (ret < 0)
+		return g_dbus_create_error(msg, ERROR_INTERFACE "Failed",
+				"Proxy creation failed (%s)", strerror(-ret));
+
 	return g_dbus_create_reply(msg, DBUS_TYPE_STRING, &ppath,
 					DBUS_TYPE_INVALID);
 }
@@ -1210,6 +1226,76 @@ static struct serial_adapter *find_adapter(GSList *list,
 	return NULL;
 }
 
+static void serial_proxy_init(struct serial_adapter *adapter)
+{
+	GKeyFile *config;
+	GError *err = NULL;
+	const char *file = CONFIGDIR "/serial.conf";
+	char **group_list;
+	int i;
+
+	config = g_key_file_new();
+
+	if (!g_key_file_load_from_file(config, file, 0, &err)) {
+		error("Parsing %s failed: %s", file, err->message);
+		g_error_free(err);
+		g_key_file_free(config);
+		return;
+	}
+
+	group_list = g_key_file_get_groups(config, NULL);
+
+	for (i = 0; group_list[i] != NULL; i++) {
+		char *group_str = group_list[i], *uuid_str, *address;
+		uuid_t uuid;
+		char path[MAX_PATH_LENGTH + 1];
+		char *ppath = path;
+		int ret;
+
+		/* string length of "Proxy" is 5 */
+		if (strlen(group_str) < 5 || strncmp(group_str, "Proxy", 5))
+			continue;
+
+		uuid_str = g_key_file_get_string(config, group_str, "UUID",
+							&err);
+		if (err) {
+			debug("%s: %s", file, err->message);
+			g_error_free(err);
+			g_key_file_free(config);
+			return;
+		}
+		address = g_key_file_get_string(config, group_str, "Address",
+							&err);
+		if (err) {
+			debug("%s: %s", file, err->message);
+			g_error_free(err);
+			g_key_file_free(config);
+			g_free(uuid_str);
+			return;
+		}
+
+		bt_string2uuid(&uuid, uuid_str);
+
+		ret = register_proxy(adapter, uuid_str, address, ppath,
+							sizeof(path));
+		if (ret == -EINVAL)
+			error("Invalid address.");
+		else if (ret == -EALREADY)
+			debug("Proxy already exists.");
+		else if (ret == -EIO)
+			error("Proxy register failed.");
+		else if (ret < 0)
+			error("Proxy creation failed (%s)", strerror(-ret));
+
+		g_free(uuid_str);
+		g_free(address);
+	}
+
+	g_strfreev(group_list);
+	g_key_file_free(config);
+	return;
+}
+
 int proxy_register(DBusConnection *conn, struct btd_adapter *btd_adapter)
 {
 	struct serial_adapter *adapter;
@@ -1241,6 +1327,7 @@ int proxy_register(DBusConnection *conn, struct btd_adapter *btd_adapter)
 	debug("Registered interface %s on path %s",
 		SERIAL_MANAGER_INTERFACE, path);
 
+	serial_proxy_init(adapter);
 	return 0;
 }
 
diff --git a/serial/serial.conf b/serial/serial.conf
new file mode 100644
index 0000000..982dcdd
--- /dev/null
+++ b/serial/serial.conf
@@ -0,0 +1,10 @@
+# Configuration file for serial
+
+# There could be multiple proxy sections, the format is [Proxy <user chosen name>]
+[Proxy DUN]
+
+# UUID for DUN proxy service
+#UUID=00001103-0000-1000-8000-00805F9B34FB
+
+# Address for device node
+#Address=/dev/ttyx
-- 
1.5.4.5

