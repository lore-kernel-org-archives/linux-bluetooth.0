Return-Path: <cyrus@holtmann.org>
From: Arman Uguray <armansito@chromium.org>
To: linux-bluetooth@vger.kernel.org
Cc: luiz.dentz@gmail.com, Arman Uguray <armansito@chromium.org>
Subject: [PATCH BlueZ 03/13] core: Introduce btd_gatt_server.
Date: Tue, 10 Feb 2015 20:54:16 -0800
Message-Id: <1423630466-26327-4-git-send-email-armansito@chromium.org>
In-Reply-To: <1423630466-26327-1-git-send-email-armansito@chromium.org>
References: <1423630466-26327-1-git-send-email-armansito@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch introduces src/gatt-server.* that handles incoming ATT
connections, manages per-adapter shared/gatt-db instances, and routes
connections to the corresponding device object. This is the layer that
will handle all the CCC management and Service Changed handling.
---
 Makefile.am       |   1 +
 src/adapter.c     |   8 ++-
 src/gatt-server.c | 203 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 src/gatt-server.h |  26 +++++++
 src/main.c        |   3 +
 5 files changed, 239 insertions(+), 2 deletions(-)
 create mode 100644 src/gatt-server.c
 create mode 100644 src/gatt-server.h

diff --git a/Makefile.am b/Makefile.am
index 60811f1..3c64426 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -167,6 +167,7 @@ src_bluetoothd_SOURCES = $(builtin_sources) \
 			src/sdpd-server.c src/sdpd-request.c \
 			src/sdpd-service.c src/sdpd-database.c \
 			src/attrib-server.h src/attrib-server.c \
+			src/gatt-server.h src/gatt-server.c \
 			src/sdp-xml.h src/sdp-xml.c \
 			src/sdp-client.h src/sdp-client.c \
 			src/textfile.h src/textfile.c \
diff --git a/src/adapter.c b/src/adapter.c
index 1839286..db359ad 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -68,6 +68,7 @@
 #include "attrib/att.h"
 #include "attrib/gatt.h"
 #include "attrib-server.h"
+#include "gatt-server.h"
 #include "eir.h"
 
 #define ADAPTER_INTERFACE	"org.bluez.Adapter1"
@@ -302,6 +303,7 @@ static void dev_class_changed_callback(uint16_t index, uint16_t length,
 	appearance[1] = rp->val[1] & 0x1f;	/* removes service class */
 	appearance[2] = rp->val[2];
 
+	/* TODO: Do this through btd_gatt_server instead */
 	attrib_gap_set(adapter, GATT_CHARAC_APPEARANCE, appearance, 2);
 }
 
@@ -4014,6 +4016,7 @@ static void convert_sdp_entry(char *key, char *value, void *user_data)
 	if (record_has_uuid(rec, att_uuid))
 		goto failed;
 
+	/* TODO: Do this through btd_gatt_server */
 	if (!gatt_parse_record(rec, &uuid, &psm, &start, &end))
 		goto failed;
 
@@ -4548,7 +4551,7 @@ static void adapter_remove(struct btd_adapter *adapter)
 	adapter->devices = NULL;
 
 	unload_drivers(adapter);
-	btd_adapter_gatt_server_stop(adapter);
+	btd_gatt_server_unregister_adapter(adapter);
 
 	g_slist_free(adapter->pin_callbacks);
 	adapter->pin_callbacks = NULL;
@@ -6590,7 +6593,8 @@ static int adapter_register(struct btd_adapter *adapter)
 		agent_unref(agent);
 	}
 
-	btd_adapter_gatt_server_start(adapter);
+	if (!btd_gatt_server_register_adapter(adapter))
+		error("Failed to register adapter with GATT server");
 
 	load_config(adapter);
 	fix_storage(adapter);
diff --git a/src/gatt-server.c b/src/gatt-server.c
new file mode 100644
index 0000000..977a057
--- /dev/null
+++ b/src/gatt-server.c
@@ -0,0 +1,203 @@
+/*
+ *
+ *  BlueZ - Bluetooth protocol stack for Linux
+ *
+ *  Copyright (C) 2015  Google Inc.
+ *
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
+ */
+
+#ifdef HAVE_CONFIG_H
+#include <config.h>
+#endif
+
+#include <stdint.h>
+#include <stdlib.h>
+
+#include "lib/uuid.h"
+#include "btio/btio.h"
+#include "src/shared/util.h"
+#include "src/shared/queue.h"
+#include "src/shared/gatt-db.h"
+#include "log.h"
+#include "adapter.h"
+#include "device.h"
+#include "gatt-server.h"
+
+#ifndef ATT_CID
+#define ATT_CID 4
+#endif
+
+static struct queue *servers = NULL;
+
+struct btd_gatt_server {
+	struct btd_adapter *adapter;
+	struct gatt_db *db;
+	GIOChannel *le_io;
+};
+
+static void gatt_server_free(void *data)
+{
+	struct btd_gatt_server *server = data;
+
+	if (server->le_io) {
+		g_io_channel_shutdown(server->le_io, FALSE, NULL);
+		g_io_channel_unref(server->le_io);
+	}
+
+	gatt_db_unref(server->db);
+	btd_adapter_unref(server->adapter);
+	free(server);
+}
+
+bool btd_gatt_server_init(void)
+{
+
+	info("Initializing GATT server");
+
+	servers = queue_new();
+	if (!servers) {
+		error("Failed to set up local GATT server");
+		return false;
+	}
+
+	return true;
+}
+
+void btd_gatt_server_cleanup(void)
+{
+	info("Cleaning up GATT server");
+
+	queue_destroy(servers, gatt_server_free);
+	servers = NULL;
+}
+
+static void connect_cb(GIOChannel *io, GError *gerr, gpointer user_data)
+{
+	struct btd_adapter *adapter;
+	struct btd_device *device;
+	uint8_t dst_type;
+	bdaddr_t src, dst;
+
+	DBG("New incoming LE ATT connection");
+
+	if (gerr) {
+		error("%s", gerr->message);
+		return;
+	}
+
+	bt_io_get(io, &gerr, BT_IO_OPT_SOURCE_BDADDR, &src,
+						BT_IO_OPT_DEST_BDADDR, &dst,
+						BT_IO_OPT_DEST_TYPE, &dst_type,
+						BT_IO_OPT_INVALID);
+	if (gerr) {
+		error("bt_io_get: %s", gerr->message);
+		g_error_free(gerr);
+		return;
+	}
+
+	adapter = adapter_find(&src);
+	if (!adapter)
+		return;
+
+	device = btd_adapter_get_device(adapter, &dst, dst_type);
+	if (!device)
+		return;
+
+	device_attach_att(device, io);
+}
+
+static bool match_adapter(const void *a, const void *b)
+{
+	const struct btd_gatt_server *server = a;
+	const struct btd_adapter *adapter = b;
+
+	return server->adapter == adapter;
+}
+
+bool btd_gatt_server_register_adapter(struct btd_adapter *adapter)
+{
+	struct btd_gatt_server *server;
+	GError *gerr = NULL;
+	const bdaddr_t *addr;
+
+	if (!adapter)
+		return false;
+
+	if (!servers) {
+		error("GATT server not initialized");
+		return false;
+	}
+
+	if (queue_find(servers, match_adapter, adapter)) {
+		error("Adapter already registered with GATT server");
+		return false;
+	}
+
+	server = new0(struct btd_gatt_server, 1);
+	if (!server)
+		return false;
+
+	server->adapter = btd_adapter_ref(adapter);
+	server->db = gatt_db_new();
+	if (!server->db)
+		goto fail;
+
+	addr = btd_adapter_get_address(adapter);
+	server->le_io = bt_io_listen(connect_cb, NULL, NULL, NULL, &gerr,
+					BT_IO_OPT_SOURCE_BDADDR, addr,
+					BT_IO_OPT_SOURCE_TYPE, BDADDR_LE_PUBLIC,
+					BT_IO_OPT_CID, ATT_CID,
+					BT_IO_OPT_SEC_LEVEL, BT_IO_SEC_LOW,
+					BT_IO_OPT_INVALID);
+	if (!server->le_io) {
+		error("Failed to start listening: %s", gerr->message);
+		g_error_free(gerr);
+		goto fail;
+	}
+
+	queue_push_tail(servers, server);
+
+	/* TODO: Set up GAP/GATT services */
+
+	return true;
+
+fail:
+	gatt_server_free(server);
+
+	return false;
+}
+
+void btd_gatt_server_unregister_adapter(struct btd_adapter *adapter)
+{
+	if (!adapter || !servers)
+		return;
+
+	queue_remove_all(servers, match_adapter, adapter, gatt_server_free);
+}
+
+struct gatt_db *btd_gatt_server_get_db(struct btd_adapter *adapter)
+{
+	struct btd_gatt_server *server;
+
+	if (!servers) {
+		error("GATT server not initialized");
+		return false;
+	}
+
+	server = queue_find(servers, match_adapter, adapter);
+	if (!server)
+		return false;
+
+	return server->db;
+}
diff --git a/src/gatt-server.h b/src/gatt-server.h
new file mode 100644
index 0000000..f97ad05
--- /dev/null
+++ b/src/gatt-server.h
@@ -0,0 +1,26 @@
+/*
+ *
+ *  BlueZ - Bluetooth protocol stack for Linux
+ *
+ *  Copyright (C) 2015  Google Inc.
+ *
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
+ */
+
+bool btd_gatt_server_init(void);
+void btd_gatt_server_cleanup(void);
+
+bool btd_gatt_server_register_adapter(struct btd_adapter *adapter);
+void btd_gatt_server_unregister_adapter(struct btd_adapter *adapter);
+
+struct gatt_db *btd_gatt_server_get_db(struct btd_adapter *adapter);
diff --git a/src/main.c b/src/main.c
index 061060d..510388a 100644
--- a/src/main.c
+++ b/src/main.c
@@ -56,6 +56,7 @@
 #include "agent.h"
 #include "profile.h"
 #include "gatt.h"
+#include "gatt-server.h"
 #include "systemd.h"
 
 #define BLUEZ_NAME "org.bluez"
@@ -579,6 +580,7 @@ int main(int argc, char *argv[])
 	g_dbus_set_flags(gdbus_flags);
 
 	gatt_init();
+	btd_gatt_server_init();
 
 	if (adapter_init() < 0) {
 		error("Adapter handling initialization failed");
@@ -642,6 +644,7 @@ int main(int argc, char *argv[])
 
 	adapter_cleanup();
 
+	btd_gatt_server_cleanup();
 	gatt_cleanup();
 
 	rfkill_exit();
-- 
2.2.0.rc0.207.ga3a616c

