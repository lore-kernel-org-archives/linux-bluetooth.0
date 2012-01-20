Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH obexd 4/6] client: add bluetooth transport driver
Date: Fri, 20 Jan 2012 11:49:59 +0200
Message-Id: <1327053001-9506-4-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1327053001-9506-1-git-send-email-luiz.dentz@gmail.com>
References: <1327053001-9506-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

---
 Makefile.am        |    1 +
 client/bluetooth.c |   69 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 client/bluetooth.h |   25 +++++++++++++++++++
 client/manager.c   |   20 ++++++++-------
 4 files changed, 106 insertions(+), 9 deletions(-)
 create mode 100644 client/bluetooth.c
 create mode 100644 client/bluetooth.h

diff --git a/Makefile.am b/Makefile.am
index 32ccc89..6697fa1 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -117,6 +117,7 @@ client_obex_client_SOURCES = $(gdbus_sources) $(gobex_sources) \
 				client/main.c src/log.h src/log.c \
 				client/manager.h client/manager.c \
 				client/session.h client/session.c \
+				client/bluetooth.h client/bluetooth.c \
 				client/sync.h client/sync.c \
 				client/pbap.h client/pbap.c \
 				client/ftp.h client/ftp.c \
diff --git a/client/bluetooth.c b/client/bluetooth.c
new file mode 100644
index 0000000..5bde9be
--- /dev/null
+++ b/client/bluetooth.c
@@ -0,0 +1,69 @@
+/*
+ *
+ *  OBEX Client
+ *
+ *  Copyright (C) 2012 Intel Corporation
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
+#include <errno.h>
+#include <inttypes.h>
+
+#include <glib.h>
+
+#include "log.h"
+#include "transport.h"
+#include "bluetooth.h"
+
+static guint bluetooth_connect(const char *source, const char *destination,
+				const char *service, uint16_t port,
+				obc_transport_func func, void *user_data)
+{
+	DBG("");
+
+	return 0;
+}
+
+static void bluetooth_disconnect(guint id)
+{
+	DBG("");
+}
+
+static struct obc_transport bluetooth = {
+	.name = "Bluetooth",
+	.connect = bluetooth_connect,
+	.disconnect = bluetooth_disconnect,
+};
+
+int bluetooth_init(void)
+{
+	DBG("");
+
+	return obc_transport_register(&bluetooth);
+}
+
+void bluetooth_exit(void)
+{
+	DBG("");
+
+	obc_transport_unregister(&bluetooth);
+}
diff --git a/client/bluetooth.h b/client/bluetooth.h
new file mode 100644
index 0000000..968e131
--- /dev/null
+++ b/client/bluetooth.h
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
+int bluetooth_init(void);
+void bluetooth_exit(void);
diff --git a/client/manager.c b/client/manager.c
index 7841753..2e01e54 100644
--- a/client/manager.c
+++ b/client/manager.c
@@ -37,6 +37,7 @@
 #include "log.h"
 #include "session.h"
 #include "manager.h"
+#include "bluetooth.h"
 #include "opp.h"
 #include "ftp.h"
 #include "pbap.h"
@@ -557,11 +558,12 @@ static GDBusMethodTable client_methods[] = {
 
 static DBusConnection *conn = NULL;
 
-static struct target_module {
+static struct obc_module {
 	const char *name;
 	int (*init) (void);
 	void (*exit) (void);
-} targets[] = {
+} modules[] = {
+	{ "bluetooth", bluetooth_init, bluetooth_exit },
 	{ "opp", opp_init, opp_exit },
 	{ "ftp", ftp_init, ftp_exit },
 	{ "pbap", pbap_init, pbap_exit },
@@ -573,7 +575,7 @@ static struct target_module {
 int manager_init(void)
 {
 	DBusError derr;
-	struct target_module *target;
+	struct obc_module *module;
 
 	dbus_error_init(&derr);
 
@@ -593,11 +595,11 @@ int manager_init(void)
 		return -1;
 	}
 
-	for (target = targets; target && target->init; target++) {
-		if (target->init() < 0)
+	for (module = modules; module && module->init; module++) {
+		if (module->init() < 0)
 			continue;
 
-		DBG("Target %s loaded", target->name);
+		DBG("Module %s loaded", module->name);
 	}
 
 	return 0;
@@ -605,13 +607,13 @@ int manager_init(void)
 
 void manager_exit(void)
 {
-	struct target_module *target;
+	struct obc_module *module;
 
 	if (conn == NULL)
 		return;
 
-	for (target = targets; target && target->exit; target++)
-		target->exit();
+	for (module = modules; module && module->exit; module++)
+		module->exit();
 
 	g_dbus_unregister_interface(conn, CLIENT_PATH, CLIENT_INTERFACE);
 	dbus_connection_unref(conn);
-- 
1.7.7.5

