Return-Path: <cyrus@holtmann.org>
From: Steven Walter <stevenrwalter@gmail.com>
To: linux-bluetooth@vger.kernel.org, armansito@chromium.org
Cc: Steven Walter <stevenrwalter@gmail.com>
Subject: [PATCH BlueZ 4/5] tools/btgatt-server.c: publish the GattManager D-Bus services
Date: Wed,  3 Dec 2014 10:54:33 -0500
Message-Id: <1417622074-20023-4-git-send-email-stevenrwalter@gmail.com>
In-Reply-To: <1417622074-20023-1-git-send-email-stevenrwalter@gmail.com>
References: <CAK8d-aLtkB1RKm+HP92x45D7csVpPNHj--4SsOPG3aAcx9sj0Q@mail.gmail.com>
 <1417622074-20023-1-git-send-email-stevenrwalter@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 Makefile.tools        |  5 +++--
 tools/btgatt-server.c | 43 +++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 46 insertions(+), 2 deletions(-)

diff --git a/Makefile.tools b/Makefile.tools
index 7520ab5..f7335df 100644
--- a/Makefile.tools
+++ b/Makefile.tools
@@ -276,9 +276,10 @@ tools_btgatt_client_SOURCES = tools/btgatt-client.c src/uuid-helper.c
 tools_btgatt_client_LDADD = src/libshared-mainloop.la \
 						lib/libbluetooth-internal.la
 
-tools_btgatt_server_SOURCES = tools/btgatt-server.c src/uuid-helper.c
+tools_btgatt_server_SOURCES = tools/btgatt-server.c src/uuid-helper.c src/gatt-dbus.c src/gatt-dbus.h \
+			      src/error.c src/dbus-common.c src/log.c src/log.h
 tools_btgatt_server_LDADD = lib/libbluetooth-internal.la src/libshared-glib.la \
-						@GLIB_LIBS@
+						gdbus/libgdbus-internal.la @GLIB_LIBS@ @DBUS_LIBS@
 
 EXTRA_DIST += tools/bdaddr.1
 endif
diff --git a/tools/btgatt-server.c b/tools/btgatt-server.c
index fa07cfb..a0c87cf 100644
--- a/tools/btgatt-server.c
+++ b/tools/btgatt-server.c
@@ -31,6 +31,8 @@
 #include <unistd.h>
 #include <errno.h>
 #include <glib.h>
+#include <dbus/dbus.h>
+#include <dbus/dbus-glib.h>
 
 #include <bluetooth/bluetooth.h>
 #include <bluetooth/hci.h>
@@ -38,6 +40,9 @@
 #include <bluetooth/l2cap.h>
 #include "lib/uuid.h"
 
+#include "gdbus/gdbus.h"
+#include "src/log.h"
+#include "src/dbus-common.h"
 #include "src/shared/util.h"
 #include "src/shared/att.h"
 #include "src/shared/queue.h"
@@ -45,6 +50,8 @@
 #include "src/shared/gatt-db.h"
 #include "src/shared/gatt-server.h"
 
+#define BLUEZ_NAME "org.bluez"
+
 #define UUID_GAP			0x1800
 #define UUID_GATT			0x1801
 #define UUID_HEART_RATE			0x180d
@@ -942,6 +949,37 @@ static gboolean signal_cb(void *user_data)
 	return FALSE;
 }
 
+static void disconnected_dbus(DBusConnection *conn, void *data)
+{
+	info("Disconnected from D-Bus. Exiting.");
+	g_main_loop_quit(event_loop);
+}
+
+static int connect_dbus(void)
+{
+	DBusConnection *conn;
+	DBusError err;
+
+	dbus_error_init(&err);
+
+	conn = g_dbus_setup_bus(DBUS_BUS_SYSTEM, BLUEZ_NAME, &err);
+	if (!conn) {
+		if (dbus_error_is_set(&err)) {
+			g_printerr("D-Bus setup failed: %s\n", err.message);
+			dbus_error_free(&err);
+			return -EIO;
+		}
+		return -EALREADY;
+	}
+
+	set_dbus_connection(conn);
+
+	g_dbus_set_disconnect_function(conn, disconnected_dbus, NULL, NULL);
+	g_dbus_attach_object_manager(conn);
+
+	return 0;
+}
+
 static struct server *server;
 static uint16_t mtu = 0;
 static bool hr_visible = false;
@@ -1062,6 +1100,7 @@ int main(int argc, char *argv[])
 	GIOChannel *channel = g_io_channel_unix_new(fd);
 	g_io_add_watch(channel, G_IO_IN, new_connection_cb, NULL);
 
+	g_dbus_set_flags(G_DBUS_FLAG_ENABLE_EXPERIMENTAL);
 	event_loop = g_main_loop_new(NULL, FALSE);
 
 	server = new0(struct server, 1);
@@ -1077,6 +1116,10 @@ int main(int argc, char *argv[])
 		return EXIT_FAILURE;
 	}
 
+	connect_dbus();
+	gboolean result = gatt_dbus_manager_register(server->db);
+	assert(result);
+
 	channel = g_io_channel_unix_new(fileno(stdin));
 	int source = g_io_add_watch(channel, G_IO_IN | G_IO_ERR | G_IO_HUP,
 				prompt_read_cb, server);
-- 
1.9.1

