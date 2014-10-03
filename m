Return-Path: <cyrus@holtmann.org>
From: Arman Uguray <armansito@chromium.org>
To: linux-bluetooth@vger.kernel.org
Cc: Arman Uguray <armansito@chromium.org>
Subject: [PATCH BlueZ 2/3] shared/gatt-server: Introduce shared/gatt-server.
Date: Fri,  3 Oct 2014 15:39:10 -0700
Message-Id: <1412375951-13940-3-git-send-email-armansito@chromium.org>
In-Reply-To: <1412375951-13940-1-git-send-email-armansito@chromium.org>
References: <1412375951-13940-1-git-send-email-armansito@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch introduces bt_gatt_server which will implement the server-side of the
ATT protocol over a bt_att structure and construct responses based on a gatt_db
structure.
---
 Makefile.am              |   1 +
 src/shared/gatt-server.c | 155 +++++++++++++++++++++++++++++++++++++++++++++++
 src/shared/gatt-server.h |  47 ++++++++++++++
 3 files changed, 203 insertions(+)
 create mode 100644 src/shared/gatt-server.c
 create mode 100644 src/shared/gatt-server.h

diff --git a/Makefile.am b/Makefile.am
index 1a1a43f..2dfea28 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -114,6 +114,7 @@ shared_sources = src/shared/io.h src/shared/timeout.h \
 			src/shared/att.h src/shared/att.c \
 			src/shared/gatt-helpers.h src/shared/gatt-helpers.c \
 			src/shared/gatt-client.h src/shared/gatt-client.c \
+			src/shared/gatt-server.h src/shared/gatt-server.c \
 			src/shared/gatt-db.h src/shared/gatt-db.c \
 			src/shared/gap.h src/shared/gap.c
 
diff --git a/src/shared/gatt-server.c b/src/shared/gatt-server.c
new file mode 100644
index 0000000..8e32def
--- /dev/null
+++ b/src/shared/gatt-server.c
@@ -0,0 +1,155 @@
+/*
+ *
+ *  BlueZ - Bluetooth protocol stack for Linux
+ *
+ *  Copyright (C) 2014  Google Inc.
+ *
+ *
+ *  This library is free software; you can redistribute it and/or
+ *  modify it under the terms of the GNU Lesser General Public
+ *  License as published by the Free Software Foundation; either
+ *  version 2.1 of the License, or (at your option) any later version.
+ *
+ *  This library is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ *  Lesser General Public License for more details.
+ *
+ *  You should have received a copy of the GNU Lesser General Public
+ *  License along with this library; if not, write to the Free Software
+ *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
+ *
+ */
+
+#include "src/shared/att.h"
+#include "lib/uuid.h"
+#include "src/shared/queue.h"
+#include "src/shared/gatt-db.h"
+#include "src/shared/gatt-server.h"
+#include "src/shared/gatt-helpers.h"
+#include "src/shared/att-types.h"
+#include "src/shared/util.h"
+
+#ifndef MAX
+#define MAX(a, b) ((a) > (b) ? (a) : (b))
+#endif
+
+struct bt_gatt_server {
+	struct gatt_db *db;
+	struct bt_att *att;
+	int ref_count;
+	uint16_t mtu;
+};
+
+static bool gatt_server_register_att_handlers(struct bt_gatt_server *server)
+{
+	/* TODO */
+	return true;
+}
+
+struct bt_gatt_server *bt_gatt_server_new(struct bt_att *att,
+							uint16_t mtu)
+{
+	struct bt_gatt_server *server;
+
+	if (!att)
+		return NULL;
+
+	server = new0(struct bt_gatt_server, 1);
+	if (!server)
+		return NULL;
+
+	server->db = gatt_db_new();
+	if (!server->db) {
+		free(server);
+		return NULL;
+	}
+
+	server->att = bt_att_ref(att);
+	server->mtu = MAX(mtu, BT_ATT_DEFAULT_LE_MTU);
+
+	if (!gatt_server_register_att_handlers(server)) {
+		gatt_db_destroy(server->db);
+		bt_att_unref(att);
+		free(server);
+		return NULL;
+	}
+
+	return bt_gatt_server_ref(server);
+}
+
+struct bt_gatt_server *bt_gatt_server_ref(struct bt_gatt_server *server)
+{
+	if (!server)
+		return NULL;
+
+	__sync_fetch_and_add(&server->ref_count, 1);
+
+	return server;
+}
+
+void bt_gatt_server_unref(struct bt_gatt_server *server)
+{
+	if (__sync_sub_and_fetch(&server->ref_count, 1))
+		return;
+
+	if (server->debug_destroy)
+		server->debug_destroy(server->debug_data);
+
+	gatt_server_cleanup(server);
+	gatt_db_destroy(server->db);
+
+	free(server);
+}
+
+bool bt_gatt_server_set_debug(struct bt_gatt_server *server,
+					bt_gatt_server_debug_func_t callback,
+					void *user_data,
+					bt_gatt_server_destroy_func_t destroy)
+{
+	if (!server)
+		return false;
+
+	if (server->debug_destroy)
+		server->debug_destroy(server->debug_data);
+
+	server->debug_callback = callback;
+	server->debug_destroy = destroy;
+	server->debug_data = user_data;
+
+	return true;
+}
+
+uint16_t bt_gatt_server_add_service(struct bt_gatt_server *server,
+					const bt_uuid_t *uuid, bool primary,
+					uint16_t num_handles)
+{
+	if (!server)
+		return 0;
+
+	/* TODO: Send service changed signal here if necessary */
+
+	return gatt_db_add_service(server->db, uuid, primary, num_handles);
+}
+
+bool bt_gatt_server_remove_service(struct bt_gatt_server *server,
+							uint16_t handle)
+{
+	if (!server)
+		return false;
+
+	/* TODO: Send service changed signal here if necessary */
+
+	return gatt_db_remove_service(server->db, handle);
+}
+
+bool bt_gatt_server_service_set_active(struct bt_gatt_server *server,
+						uint16_t handle, bool active)
+{
+	if (!server)
+		return false;
+
+	/* TODO: Send service changed signal here if necessary */
+
+	return gatt_db_service_set_active(server->db, handle, active);
+}
diff --git a/src/shared/gatt-server.h b/src/shared/gatt-server.h
new file mode 100644
index 0000000..0027715
--- /dev/null
+++ b/src/shared/gatt-server.h
@@ -0,0 +1,47 @@
+/*
+ *
+ *  BlueZ - Bluetooth protocol stack for Linux
+ *
+ *  Copyright (C) 2014  Google Inc.
+ *
+ *
+ *  This library is free software; you can redistribute it and/or
+ *  modify it under the terms of the GNU Lesser General Public
+ *  License as published by the Free Software Foundation; either
+ *  version 2.1 of the License, or (at your option) any later version.
+ *
+ *  This library is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ *  Lesser General Public License for more details.
+ *
+ *  You should have received a copy of the GNU Lesser General Public
+ *  License along with this library; if not, write to the Free Software
+ *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
+ *
+ */
+
+#include <stdint.h>
+
+struct bt_gatt_server;
+
+struct bt_gatt_server *bt_gatt_server_new(struct bt_att *att, uint16_t mtu);
+
+struct bt_gatt_server *bt_gatt_server_ref(struct bt_gatt_server *server);
+void bt_gatt_server_unref(struct bt_gatt_server *server);
+
+typedef void (*bt_gatt_server_destroy_func_t)(void *user_data);
+typedef void (*bt_gatt_server_debug_func_t)(const char *str, void *user_data);
+
+bool bt_gatt_server_set_debug(struct bt_gatt_server *server,
+					bt_gatt_server_debug_func_t callback,
+					void *user_data,
+					bt_gatt_server_destroy_func_t destroy);
+
+uint16_t bt_gatt_server_add_service(struct bt_gatt_server *server,
+					const bt_uuid_t *uuid, bool primary,
+					uint16_t num_handles);
+bool bt_gatt_server_remove_service(struct bt_gatt_server *server,
+							uint16_t handle);
+bool bt_gatt_server_service_set_active(struct bt_gatt_server *server,
+						uint16_t handle, bool active);
-- 
2.1.0.rc2.206.gedb03e5

