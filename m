Return-Path: <cyrus@holtmann.org>
From: Bartosz Szatkowski <bulislaw@linux.com>
To: linux-bluetooth@vger.kernel.org
Cc: Bartosz Szatkowski <bulislaw@linux.com>
Subject: [PATCHv2 obexd 1/4] Add basic support for MAP client in obex-client
Date: Fri,  2 Dec 2011 13:32:19 +0100
Message-Id: <1322829142-7855-1-git-send-email-bulislaw@linux.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 Makefile.am        |    1 +
 client/manager.c   |    2 +
 client/map.c       |  135 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 client/map.h       |   24 +++++++++
 doc/client-api.txt |    9 ++++
 5 files changed, 171 insertions(+), 0 deletions(-)
 create mode 100644 client/map.c
 create mode 100644 client/map.h

diff --git a/Makefile.am b/Makefile.am
index 2582651..90fdd63 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -120,6 +120,7 @@ client_obex_client_SOURCES = $(gdbus_sources) $(gobex_sources) \
 				client/pbap.h client/pbap.c \
 				client/ftp.h client/ftp.c \
 				client/opp.h client/opp.c \
+				client/map.h client/map.c \
 				client/transfer.h client/transfer.c \
 				client/agent.h client/agent.c \
 				client/driver.h client/driver.c
diff --git a/client/manager.c b/client/manager.c
index dfb282b..f6628d7 100644
--- a/client/manager.c
+++ b/client/manager.c
@@ -42,6 +42,7 @@
 #include "ftp.h"
 #include "pbap.h"
 #include "sync.h"
+#include "map.h"
 
 #define CLIENT_SERVICE  "org.openobex.client"
 
@@ -567,6 +568,7 @@ static struct target_module {
 	{ "ftp", ftp_init, ftp_exit },
 	{ "pbap", pbap_init, pbap_exit },
 	{ "sync", sync_init, sync_exit },
+	{ "map", map_init, map_exit },
 	{ }
 };
 
diff --git a/client/map.c b/client/map.c
new file mode 100644
index 0000000..bee49c5
--- /dev/null
+++ b/client/map.c
@@ -0,0 +1,135 @@
+/*
+ *
+ *  OBEX Client
+ *
+ *  Copyright (C) 2011  Bartosz Szatkowski <bulislaw@linux.com> for Comarch
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation; either version 2 of the License, or
+ *  (at your option) any later version.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program; if not, write to the Free Software
+ *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
+ *
+ */
+
+#ifdef HAVE_CONFIG_H
+#include <config.h>
+#endif
+
+#include <errno.h>
+#include <glib.h>
+#include <gdbus.h>
+
+#include "log.h"
+
+#include "map.h"
+#include "transfer.h"
+#include "session.h"
+#include "driver.h"
+
+#define OBEX_MAS_UUID \
+	"\xBB\x58\x2B\x40\x42\x0C\x11\xDB\xB0\xDE\x08\x00\x20\x0C\x9A\x66"
+#define OBEX_MAS_UUID_LEN 16
+
+#define MAP_INTERFACE  "org.openobex.MessageAccess"
+#define MAS_UUID "00001132-0000-1000-8000-00805f9b34fb"
+
+struct map_data {
+	struct obc_session *session;
+	DBusMessage *msg;
+};
+
+static DBusConnection *conn = NULL;
+
+static GDBusMethodTable map_methods[] = {
+	{ }
+};
+
+static void map_free(void *data)
+{
+	struct map_data *map = data;
+
+	obc_session_unref(map->session);
+	g_free(map);
+}
+
+static int map_probe(struct obc_session *session)
+{
+	struct map_data *map;
+	const char *path;
+
+	path = obc_session_get_path(session);
+
+	DBG("%s", path);
+
+	map = g_try_new0(struct map_data, 1);
+	if (!map)
+		return -ENOMEM;
+
+	map->session = obc_session_ref(session);
+
+	if (!g_dbus_register_interface(conn, path, MAP_INTERFACE, map_methods,
+					NULL, NULL, map, map_free)) {
+		map_free(map);
+
+		return -ENOMEM;
+	}
+
+	return 0;
+}
+
+static void map_remove(struct obc_session *session)
+{
+	const char *path = obc_session_get_path(session);
+
+	DBG("%s", path);
+
+	g_dbus_unregister_interface(conn, path, MAP_INTERFACE);
+}
+
+static struct obc_driver map = {
+	.service = "MAP",
+	.uuid = MAS_UUID,
+	.target = OBEX_MAS_UUID,
+	.target_len = OBEX_MAS_UUID_LEN,
+	.probe = map_probe,
+	.remove = map_remove
+};
+
+int map_init(void)
+{
+	int err;
+
+	DBG("");
+
+	conn = dbus_bus_get(DBUS_BUS_SESSION, NULL);
+	if (!conn)
+		return -EIO;
+
+	err = obc_driver_register(&map);
+	if (err < 0) {
+		dbus_connection_unref(conn);
+		conn = NULL;
+		return err;
+	}
+
+	return 0;
+}
+
+void map_exit(void)
+{
+	DBG("");
+
+	dbus_connection_unref(conn);
+	conn = NULL;
+
+	obc_driver_unregister(&map);
+}
diff --git a/client/map.h b/client/map.h
new file mode 100644
index 0000000..86f6b95
--- /dev/null
+++ b/client/map.h
@@ -0,0 +1,24 @@
+/*
+ *
+ *  OBEX Client
+ *
+ *  Copyright (C) 2011  Bartosz Szatkowski <bulislaw@linux.com> for Comarch
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation; either version 2 of the License, or
+ *  (at your option) any later version.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program; if not, write to the Free Software
+ *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
+ *
+ */
+
+int map_init(void);
+void map_exit(void);
diff --git a/doc/client-api.txt b/doc/client-api.txt
index 3e61cf7..ee8951f 100644
--- a/doc/client-api.txt
+++ b/doc/client-api.txt
@@ -251,6 +251,15 @@ Methods		void SetLocation(string location)
 
 			Send an entire Phonebook Object store to remote device
 
+Message Access hierarchy
+=========================
+
+Service		org.openobex.client
+Interface	org.openobex.MessageAccess
+Object path	[variable prefix]/{session0,session1,...}
+
+Methods
+
 Transfer hierarchy
 ==================
 
-- 
1.7.4.1

