Return-Path: <cyrus@holtmann.org>
From: Mikel Astiz <mikel.astiz.oss@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Mikel Astiz <mikel.astiz@bmw-carit.de>
Subject: [RFC BlueZ v0 01/16] core: Add btd_server
Date: Tue, 25 Jun 2013 18:24:34 +0200
Message-Id: <1372177489-6858-2-git-send-email-mikel.astiz.oss@gmail.com>
In-Reply-To: <1372177489-6858-1-git-send-email-mikel.astiz.oss@gmail.com>
References: <1372177489-6858-1-git-send-email-mikel.astiz.oss@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Mikel Astiz <mikel.astiz@bmw-carit.de>

Add a core object representing a (adapter, profile) pair in a similar
way that btd_service couples a (device, profile) pair. As opposed to
btd_service, which represents the *remote* support of a profile,
btd_server is introduced to represent a *locally* supported profile.

The new struct should allow removing a lot of boilerplate code in the
profile implementations, such as;
- Maintaining an internal list of probed adapters.
- The agent authorization procedure.
- IO channel handling (listen, shutdown, error-cases, etc.).

Eventually, btd_server is also a step towards supporting multiple local
instances of the same UUID, which could be probed/removed independently.
This extension is however not addressed yet.
---
 Makefile.am  |   1 +
 src/server.c | 109 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 src/server.h |  38 +++++++++++++++++++++
 3 files changed, 148 insertions(+)
 create mode 100644 src/server.c
 create mode 100644 src/server.h

diff --git a/Makefile.am b/Makefile.am
index 80edafd..9aa21c0 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -143,6 +143,7 @@ src_bluetoothd_SOURCES = $(gdbus_sources) $(builtin_sources) \
 			src/adapter.h src/adapter.c \
 			src/profile.h src/profile.c \
 			src/service.h src/service.c \
+			src/server.h src/server.c \
 			src/device.h src/device.c src/attio.h \
 			src/dbus-common.c src/dbus-common.h \
 			src/eir.h src/eir.c \
diff --git a/src/server.c b/src/server.c
new file mode 100644
index 0000000..9337ff6
--- /dev/null
+++ b/src/server.c
@@ -0,0 +1,109 @@
+/*
+ *
+ *  BlueZ - Bluetooth protocol stack for Linux
+ *
+ *  Copyright (C) 2012-2013  BMW Car IT GmbH. All rights reserved.
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
+#include <stdio.h>
+#include <stdlib.h>
+#include <assert.h>
+#include <unistd.h>
+#include <fcntl.h>
+#include <stdbool.h>
+#include <sys/stat.h>
+#include <sys/ioctl.h>
+#include <errno.h>
+
+#include <bluetooth/bluetooth.h>
+
+#include <glib.h>
+
+#include "log.h"
+
+#include "adapter.h"
+#include "profile.h"
+#include "server.h"
+
+struct btd_server {
+	struct btd_adapter	*adapter;
+	struct btd_profile	*profile;
+	void			*user_data;
+};
+
+struct btd_server *server_create(struct btd_adapter *adapter,
+						struct btd_profile *profile)
+{
+	struct btd_server *server;
+	char addr[18];
+	int err;
+
+	server = g_try_new0(struct btd_server, 1);
+	if (!server) {
+		error("server_create: failed to alloc memory");
+		return NULL;
+	}
+
+	server->adapter = adapter; /* Weak ref */
+	server->profile = profile;
+
+	err = profile->adapter_probe(server->profile, server->adapter);
+	if (err == 0)
+		return server;
+
+	ba2str(adapter_get_address(server->adapter), addr);
+	error("%s profile probe failed for %s (%d)", profile->name, addr, err);
+
+	g_free(server);
+
+	return NULL;
+}
+
+void server_destroy(struct btd_server *server)
+{
+	if (server->profile->adapter_remove != NULL)
+		server->profile->adapter_remove(server->profile,
+							server->adapter);
+
+	g_free(server);
+}
+
+struct btd_adapter *btd_server_get_adapter(const struct btd_server *server)
+{
+	return server->adapter;
+}
+
+struct btd_profile *btd_server_get_profile(const struct btd_server *server)
+{
+	return server->profile;
+}
+
+void btd_server_set_user_data(struct btd_server *server, void *user_data)
+{
+	server->user_data = user_data;
+}
+
+void *btd_server_get_user_data(const struct btd_server *server)
+{
+	return server->user_data;
+}
diff --git a/src/server.h b/src/server.h
new file mode 100644
index 0000000..9fd4891
--- /dev/null
+++ b/src/server.h
@@ -0,0 +1,38 @@
+/*
+ *
+ *  BlueZ - Bluetooth protocol stack for Linux
+ *
+ *  Copyright (C) 2012-2013  BMW Car IT GmbH. All rights reserved.
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
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program; if not, write to the Free Software
+ *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
+ *
+ */
+
+struct btd_adapter;
+struct btd_profile;
+
+/* Server management functions used by the core */
+struct btd_server *server_create(struct btd_adapter *adapter,
+						struct btd_profile *profile);
+void server_destroy(struct btd_server *server);
+
+/* Public member access */
+struct btd_adapter *btd_server_get_adapter(const struct btd_server *server);
+struct btd_profile *btd_server_get_profile(const struct btd_server *server);
+
+/* Functions used by profile implementation */
+void btd_server_set_user_data(struct btd_server *server, void *user_data);
+void *btd_server_get_user_data(const struct btd_server *server);
-- 
1.8.1.4

