Return-Path: <cyrus@holtmann.org>
From: Forrest Zhao <forrest.zhao@intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: forrest.zhao@gmail.com, Forrest Zhao <forrest.zhao@intel.com>
Subject: [PATCH] add serial proxy configuration support
Date: Thu, 16 Jul 2009 14:16:01 +0800
Message-Id: <1247724961-4049-1-git-send-email-forrest.zhao@intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 serial/Makefile.am |    2 +
 serial/proxy.c     |   86 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 serial/serial.conf |    9 +++++
 3 files changed, 97 insertions(+), 0 deletions(-)
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
index 8c8a4b8..0ed159d 100644
--- a/serial/proxy.c
+++ b/serial/proxy.c
@@ -1210,6 +1210,90 @@ static struct serial_adapter *find_adapter(GSList *list,
 	return NULL;
 }
 
+static void serial_proxy_init(struct serial_adapter *adapter)
+{
+	GKeyFile *config;
+	GError *err = NULL;
+	const char *file = CONFIGDIR "/serial.conf";
+	char *uuid_str = NULL, *address = NULL;
+	uuid_t uuid;
+	proxy_type_t type;
+	char path[MAX_PATH_LENGTH + 1];
+	const char *ppath = path;
+	int ret;
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
+	uuid_str = g_key_file_get_string(config, "Serial Proxy", "UUID", &err);
+	if (err) {
+		debug("%s: %s", file, err->message);
+		g_error_free(err);
+		g_key_file_free(config);
+		return;
+	}
+
+	address = g_key_file_get_string(config, "Serial Proxy", "Address",
+								&err);
+	if (err) {
+		debug("%s: %s", file, err->message);
+		g_error_free(err);
+		g_key_file_free(config);
+		g_free(uuid_str);
+		return;
+	}
+
+	g_key_file_free(config);
+
+	bt_string2uuid(&uuid, uuid_str);
+	type = addr2type(address);
+
+	if (g_slist_find_custom(adapter->proxies, address, proxy_addrcmp)) {
+		debug("Proxy already exists.");
+		g_free(uuid_str);
+		g_free(address);
+		return;
+	}
+	switch (type) {
+	case UNIX_SOCKET_PROXY:
+		ret = proxy_socket_register(adapter, uuid_str, address,
+						path, sizeof(path), TRUE);
+		break;
+	case TTY_PROXY:
+		ret = proxy_tty_register(adapter, uuid_str, address,
+					NULL, path, sizeof(path), TRUE);
+		break;
+	case TCP_SOCKET_PROXY:
+		ret = proxy_tcp_register(adapter, uuid_str, address,
+					path, sizeof(path), TRUE);
+		break;
+	default:
+		ret = -1;
+	}
+
+	g_free(uuid_str);
+	g_free(address);
+
+	if (ret < 0) {
+		error("proxy register failed.");
+		return;
+	}
+
+	g_dbus_emit_signal(adapter->conn,
+			adapter_get_path(adapter->btd_adapter),
+			SERIAL_MANAGER_INTERFACE, "ProxyCreated",
+			DBUS_TYPE_STRING, &ppath,
+			DBUS_TYPE_INVALID);
+
+	return;
+}
+
 int proxy_register(DBusConnection *conn, struct btd_adapter *btd_adapter)
 {
 	struct serial_adapter *adapter;
@@ -1241,6 +1325,8 @@ int proxy_register(DBusConnection *conn, struct btd_adapter *btd_adapter)
 	debug("Registered interface %s on path %s",
 		SERIAL_MANAGER_INTERFACE, path);
 
+	serial_proxy_init(adapter);
+
 	return 0;
 }
 
diff --git a/serial/serial.conf b/serial/serial.conf
new file mode 100644
index 0000000..656de89
--- /dev/null
+++ b/serial/serial.conf
@@ -0,0 +1,9 @@
+# Configuration file for serial
+
+[Serial Proxy]
+
+# UUID for serial proxy service
+#UUID=00001103-0000-1000-8000-00805F9B34FB
+
+# Address for device node
+#Address=/dev/ttyx
-- 
1.5.4.5

