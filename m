Return-Path: <cyrus@holtmann.org>
From: Forrest Zhao <forrest.zhao@intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: forrest.zhao@gmail.com, Forrest Zhao <forrest.zhao@intel.com>
Subject: [PATCH] add support for multiple serial proxies configuration
Date: Mon, 20 Jul 2009 17:20:19 +0800
Message-Id: <1248081619-5715-1-git-send-email-forrest.zhao@intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 serial/Makefile.am |    2 +
 serial/proxy.c     |   94 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 serial/serial.conf |   10 +++++
 3 files changed, 106 insertions(+), 0 deletions(-)
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
index 8c8a4b8..a68d342 100644
--- a/serial/proxy.c
+++ b/serial/proxy.c
@@ -1210,6 +1210,98 @@ static struct serial_adapter *find_adapter(GSList *list,
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
+		proxy_type_t type;
+		char path[MAX_PATH_LENGTH + 1];
+		const char *ppath = path;
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
+		type = addr2type(address);
+
+		if (g_slist_find_custom(adapter->proxies, address,
+							proxy_addrcmp)) {
+			debug("Proxy already exists.");
+			goto fail;
+		}
+		switch (type) {
+		case UNIX_SOCKET_PROXY:
+			ret = proxy_socket_register(adapter, uuid_str, address,
+						path, sizeof(path), TRUE);
+			break;
+		case TTY_PROXY:
+			ret = proxy_tty_register(adapter, uuid_str, address,
+						NULL, path, sizeof(path), TRUE);
+			break;
+		case TCP_SOCKET_PROXY:
+			ret = proxy_tcp_register(adapter, uuid_str, address,
+						path, sizeof(path), TRUE);
+			break;
+		default:
+			 ret = -1;
+		}
+		if (ret < 0) {
+			error("proxy register failed.");
+			goto fail;
+		}
+		g_dbus_emit_signal(adapter->conn,
+				adapter_get_path(adapter->btd_adapter),
+				SERIAL_MANAGER_INTERFACE, "ProxyCreated",
+				DBUS_TYPE_STRING, &ppath,
+				DBUS_TYPE_INVALID);
+fail:
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
@@ -1241,6 +1333,8 @@ int proxy_register(DBusConnection *conn, struct btd_adapter *btd_adapter)
 	debug("Registered interface %s on path %s",
 		SERIAL_MANAGER_INTERFACE, path);
 
+	serial_proxy_init(adapter);
+
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

