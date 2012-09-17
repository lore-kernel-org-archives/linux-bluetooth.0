Return-Path: <cyrus@holtmann.org>
From: Sunil Kumar Behera <sunil.behera@samsung.com>
To: linux-bluetooth@vger.kernel.org
Cc: Sunil Kumar Behera <sunil.behera@samsung.com>
Subject: [PATCH obexd 1/2] client: Add skeleton for Message Notification
Date: Mon, 17 Sep 2012 20:21:15 +0530
Message-id: <1347893475-13166-1-git-send-email-sunil.behera@samsung.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 Makefile.am      |    1 +
 client/manager.c |    2 +
 client/mns.c     |  138 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 client/mns.h     |   24 ++++++++++
 4 files changed, 165 insertions(+)
 create mode 100644 client/mns.c
 create mode 100644 client/mns.h

diff --git a/Makefile.am b/Makefile.am
index 724dd5d..709f1bc 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -127,6 +127,7 @@ client_obex_client_SOURCES = $(gdbus_sources) $(gobex_sources) \
 				client/transport.h client/transport.c \
 				client/dbus.h client/dbus.c \
 				client/driver.h client/driver.c \
+				client/mns.h client/mns.c \
 				src/map_ap.h
 
 client_obex_client_LDADD = @GLIB_LIBS@ @DBUS_LIBS@ @BLUEZ_LIBS@
diff --git a/client/manager.c b/client/manager.c
index 7f2fede9..8ba1647 100644
--- a/client/manager.c
+++ b/client/manager.c
@@ -44,6 +44,7 @@
 #include "pbap.h"
 #include "sync.h"
 #include "map.h"
+#include "mns.h"
 
 #define CLIENT_SERVICE		"org.bluez.obex.client"
 
@@ -252,6 +253,7 @@ static struct obc_module {
 	{ "pbap", pbap_init, pbap_exit },
 	{ "sync", sync_init, sync_exit },
 	{ "map", map_init, map_exit },
+	{ "mns", mns_init, mns_exit },
 	{ }
 };
 
diff --git a/client/mns.c b/client/mns.c
new file mode 100644
index 0000000..f5a5905
--- /dev/null
+++ b/client/mns.c
@@ -0,0 +1,138 @@
+/*
+ *
+ *  OBEX Client
+ *
+ *  Copyright (C) 2012 Samsung Electronics Co., Ltd.
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
+#include <string.h>
+
+#include <gobex-apparam.h>
+
+#include "log.h"
+
+#include "transfer.h"
+#include "session.h"
+#include "driver.h"
+#include "mns.h"
+
+#define OBEX_MNS_UUID \
+	"\xBB\x58\x2B\x41\x42\x0C\x11\xDB\xB0\xDE\x08\x00\x20\x0C\x9A\x66"
+#define OBEX_MNS_UUID_LEN 16
+
+#define MNS_INTERFACE  "org.bluez.obex.MessageNotification"
+#define ERROR_INTERFACE "org.bluez.obex.Error"
+#define MNS_UUID "00001133-0000-1000-8000-00805f9b34fb"
+
+struct mns_data {
+	struct obc_session *session;
+	DBusMessage *msg;
+};
+
+static DBusConnection *conn = NULL;
+
+static GDBusMethodTable mns_methods[] = {
+	{ }
+};
+
+static void mns_free(void *data)
+{
+	struct mns_data *mns = data;
+
+	obc_session_unref(mns->session);
+	g_free(mns);
+}
+
+static int mns_probe(struct obc_session *session)
+{
+	struct mns_data *mns;
+	const char *path;
+
+	path = obc_session_get_path(session);
+
+	DBG("%s", path);
+
+	mns = g_try_new0(struct mns_data, 1);
+	if (!mns)
+		return -ENOMEM;
+
+	mns->session = obc_session_ref(session);
+
+	if (!g_dbus_register_interface(conn, path, MNS_INTERFACE, mns_methods,
+						NULL, NULL, mns, mns_free)) {
+		mns_free(mns);
+		return -ENOMEM;
+	}
+
+	return 0;
+}
+
+static void mns_remove(struct obc_session *session)
+{
+	const char *path = obc_session_get_path(session);
+
+	DBG("%s", path);
+
+	g_dbus_unregister_interface(conn, path, MNS_INTERFACE);
+}
+
+static struct obc_driver mns = {
+	.service = "MNS",
+	.uuid = MNS_UUID,
+	.target = OBEX_MNS_UUID,
+	.target_len = OBEX_MNS_UUID_LEN,
+	.probe = mns_probe,
+	.remove = mns_remove
+};
+
+int mns_init(void)
+{
+	int err;
+
+	DBG("");
+
+	conn = dbus_bus_get(DBUS_BUS_SESSION, NULL);
+	if (!conn)
+		return -EIO;
+
+	err = obc_driver_register(&mns);
+	if (err < 0) {
+		dbus_connection_unref(conn);
+		conn = NULL;
+		return err;
+	}
+
+	return 0;
+}
+
+void mns_exit(void)
+{
+	DBG("");
+
+	dbus_connection_unref(conn);
+	conn = NULL;
+
+	obc_driver_unregister(&mns);
+}
diff --git a/client/mns.h b/client/mns.h
new file mode 100644
index 0000000..e4ee5e5
--- /dev/null
+++ b/client/mns.h
@@ -0,0 +1,24 @@
+/*
+ *
+ *  OBEX Client
+ *
+ *  Copyright (C) 2012 Samsung Electronics Co., Ltd.
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
+int mns_init(void);
+void mns_exit(void);
-- 
1.7.9.5

