Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH obexd 3/7] client: add opp target
Date: Thu, 11 Aug 2011 16:49:50 +0300
Message-Id: <1313070594-31068-3-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1313070594-31068-1-git-send-email-luiz.dentz@gmail.com>
References: <1313070594-31068-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

opp target implements object push driver
---
 Makefile.am      |    1 +
 client/manager.c |   23 +++++++++++++++++
 client/opp.c     |   71 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 client/opp.h     |   25 +++++++++++++++++++
 4 files changed, 120 insertions(+), 0 deletions(-)
 create mode 100644 client/opp.c
 create mode 100644 client/opp.h

diff --git a/Makefile.am b/Makefile.am
index 314afc4..8888401 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -130,6 +130,7 @@ client_obex_client_SOURCES = $(gdbus_sources) $(gobex_sources) \
 				client/pbap.h client/pbap.c \
 				client/sync.h client/sync.c \
 				client/ftp.h client/ftp.c \
+				client/opp.h client/opp.c \
 				client/transfer.h client/transfer.c \
 				client/agent.h client/agent.c \
 				client/driver.h client/driver.c
diff --git a/client/manager.c b/client/manager.c
index 71e3780..81d091b 100644
--- a/client/manager.c
+++ b/client/manager.c
@@ -38,6 +38,7 @@
 #include "transfer.h"
 #include "session.h"
 #include "manager.h"
+#include "opp.h"
 
 #define CLIENT_SERVICE  "org.openobex.client"
 
@@ -554,9 +555,19 @@ static GDBusMethodTable client_methods[] = {
 
 static DBusConnection *conn = NULL;
 
+static struct vtable {
+	const char *name;
+	int (*init) (void);
+	void (*exit) (void);
+} targets[] = {
+	{ "opp", opp_init, opp_exit },
+	{ }
+};
+
 int manager_init(void)
 {
 	DBusError derr;
+	struct vtable *target;
 
 	dbus_error_init(&derr);
 
@@ -576,14 +587,26 @@ int manager_init(void)
 		return -1;
 	}
 
+	for (target = targets; target && target->init; target++) {
+		if (target->init() < 0)
+			continue;
+
+		DBG("Target %s loaded", target->name);
+	}
+
 	return 0;
 }
 
 void manager_exit(void)
 {
+	struct vtable *target;
+
 	if (conn == NULL)
 		return;
 
+	for (target = targets; target && target->exit; target++)
+		target->exit();
+
 	g_dbus_unregister_interface(conn, CLIENT_PATH, CLIENT_INTERFACE);
 	dbus_connection_unref(conn);
 }
diff --git a/client/opp.c b/client/opp.c
new file mode 100644
index 0000000..c9d1d60
--- /dev/null
+++ b/client/opp.c
@@ -0,0 +1,71 @@
+/*
+ *
+ *  OBEX Client
+ *
+ *  Copyright (C) 2011 Intel Corporation
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
+#include "log.h"
+
+#include "client/session.h"
+#include "client/driver.h"
+#include "client/opp.h"
+
+#define OPP_UUID "00001105-0000-1000-8000-00805f9b34fb"
+
+static int opp_probe(struct obc_session *session)
+{
+	const char *path = obc_session_get_path(session);
+
+	DBG("%s", path);
+
+	return 0;
+}
+
+static void opp_remove(struct obc_session *session)
+{
+	const char *path = obc_session_get_path(session);
+
+	DBG("%s", path);
+}
+
+static struct obc_driver opp = {
+	.service = "OPP",
+	.uuid = OPP_UUID,
+	.probe = opp_probe,
+	.remove = opp_remove
+};
+
+int opp_init(void)
+{
+	DBG("");
+
+	return obc_driver_register(&opp);
+}
+
+void opp_exit(void)
+{
+	DBG("");
+
+	obc_driver_unregister(&opp);
+}
diff --git a/client/opp.h b/client/opp.h
new file mode 100644
index 0000000..a23e94e
--- /dev/null
+++ b/client/opp.h
@@ -0,0 +1,25 @@
+/*
+ *
+ *  OBEX Client
+ *
+ *  Copyright (C) 2011 Intel Corporation
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
+int opp_init(void);
+void opp_exit(void);
-- 
1.7.6

