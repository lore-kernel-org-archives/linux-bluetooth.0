Return-Path: <cyrus@holtmann.org>
From: Waldemar Rymarkiewicz <waldemar.rymarkiewicz@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: <suraj@atheros.com>, Johan Hedberg <johan.hedberg@gmail.com>,
	<joakim.xj.ceder@stericsson.com>,
	Waldemar Rymarkiewicz <waldemar.rymarkiewicz@tieto.com>
Subject: [PATCH 2/4] Sim Access Profile Manager
Date: Wed, 3 Nov 2010 14:34:29 +0100
Message-ID: <1288791271-13857-3-git-send-email-waldemar.rymarkiewicz@tieto.com>
In-Reply-To: <1288791271-13857-1-git-send-email-waldemar.rymarkiewicz@tieto.com>
References: <1288791271-13857-1-git-send-email-waldemar.rymarkiewicz@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Add a SAP plugin main file and the plugin manager. Also include the SAP
plugin in the Makefile.
---
 Makefile.am   |    7 ++++
 acinclude.m4  |    6 ++++
 sap/main.c    |   54 ++++++++++++++++++++++++++++++++
 sap/manager.c |   94 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 sap/manager.h |   21 +++++++++++++
 sap/server.c  |   48 +++++++++++++++++++++++++++++
 sap/server.h  |   25 +++++++++++++++
 7 files changed, 255 insertions(+), 0 deletions(-)
 create mode 100644 sap/main.c
 create mode 100644 sap/manager.c
 create mode 100644 sap/manager.h
 create mode 100644 sap/server.c
 create mode 100644 sap/server.h

diff --git a/Makefile.am b/Makefile.am
index e1183de..c767b4c 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -142,6 +142,13 @@ audio_libtelephony_a_SOURCES = audio/telephony.h audio/telephony-dummy.c \
 				audio/telephony-maemo6.c
 endif
 
+if SAPPLUGIN
+builtin_modules += sap
+builtin_sources += sap/main.c \
+			sap/manager.h sap/manager.c \
+			sap/server.h sap/server.c
+endif
+
 if INPUTPLUGIN
 builtin_modules += input
 builtin_sources += input/main.c \
diff --git a/acinclude.m4 b/acinclude.m4
index 287f07d..1f76b4d 100644
--- a/acinclude.m4
+++ b/acinclude.m4
@@ -174,6 +174,7 @@ AC_DEFUN([AC_ARG_BLUEZ], [
 	input_enable=yes
 	serial_enable=yes
 	network_enable=yes
+	sap_enable=yes
 	service_enable=yes
 	health_enable=no
 	pnat_enable=no
@@ -210,6 +211,10 @@ AC_DEFUN([AC_ARG_BLUEZ], [
 		network_enable=${enableval}
 	])
 
+	AC_ARG_ENABLE(sap, AC_HELP_STRING([--disable-sap], [disable sap plugin]), [
+		sap_enable=${enableval}
+	])
+
 	AC_ARG_ENABLE(serial, AC_HELP_STRING([--disable-serial], [disable serial plugin]), [
 		serial_enable=${enableval}
 	])
@@ -351,6 +356,7 @@ AC_DEFUN([AC_ARG_BLUEZ], [
 	AM_CONDITIONAL(INPUTPLUGIN, test "${input_enable}" = "yes")
 	AM_CONDITIONAL(SERIALPLUGIN, test "${serial_enable}" = "yes")
 	AM_CONDITIONAL(NETWORKPLUGIN, test "${network_enable}" = "yes")
+	AM_CONDITIONAL(SAPPLUGIN, test "${sap_enable}" = "yes")
 	AM_CONDITIONAL(SERVICEPLUGIN, test "${service_enable}" = "yes")
 	AM_CONDITIONAL(HEALTHPLUGIN, test "${health_enable}" = "yes")
 	AM_CONDITIONAL(MCAP, test "${health_enable}" = "yes")
diff --git a/sap/main.c b/sap/main.c
new file mode 100644
index 0000000..b3efcf8
--- /dev/null
+++ b/sap/main.c
@@ -0,0 +1,54 @@
+/*
+ *  BlueZ - Bluetooth protocol stack for Linux
+ *
+ *  Copyright (C) 2010 Claudio Takahasi<claudio.takahasi@openbossa.org>
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation; version 2 of the License.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program; if not, write to the Free Software
+ *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
+ */
+
+#ifdef HAVE_CONFIG_H
+#include <config.h>
+#endif
+
+#include <errno.h>
+#include <gdbus.h>
+#include "plugin.h"
+#include "manager.h"
+
+static DBusConnection *connection;
+
+static int sap_init(void)
+{
+	connection = dbus_bus_get(DBUS_BUS_SYSTEM, NULL);
+
+	if (!connection)
+		return -EIO;
+
+	if (sap_manager_init(connection) < 0) {
+		dbus_connection_unref(connection);
+		return -EIO;
+	}
+
+	return 0;
+}
+
+static void sap_exit(void)
+{
+	sap_manager_exit();
+
+	dbus_connection_unref(connection);
+}
+
+BLUETOOTH_PLUGIN_DEFINE(sap, VERSION,
+		BLUETOOTH_PLUGIN_PRIORITY_DEFAULT, sap_init, sap_exit)
diff --git a/sap/manager.c b/sap/manager.c
new file mode 100644
index 0000000..972a46b
--- /dev/null
+++ b/sap/manager.c
@@ -0,0 +1,94 @@
+/*
+ *  BlueZ - Bluetooth protocol stack for Linux
+ *
+ *  Copyright (C) 2010 Claudio Takahasi<claudio.takahasi@openbossa.org>
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation; version 2 of the License.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program; if not, write to the Free Software
+ *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
+ */
+
+#ifdef HAVE_CONFIG_H
+#include <config.h>
+#endif
+
+#include <errno.h>
+
+#include <bluetooth/bluetooth.h>
+#include <bluetooth/hci.h>
+#include <bluetooth/sdp.h>
+#include <bluetooth/sdp_lib.h>
+
+#include <gdbus.h>
+
+#include "log.h"
+#include "adapter.h"
+#include "device.h"
+
+#include "manager.h"
+
+#include "server.h"
+
+static DBusConnection *connection = NULL;
+
+
+static int sap_server_probe(struct btd_adapter *adapter)
+{
+	const gchar *path = adapter_get_path(adapter);
+	bdaddr_t src;
+
+	DBG("path %s", path);
+
+	adapter_get_address(adapter, &src);
+
+	return sap_server_register(path, &src);
+}
+
+static void sap_server_remove(struct btd_adapter *adapter)
+{
+	const gchar *path = adapter_get_path(adapter);
+
+	DBG("path %s", path);
+
+	sap_server_unregister(path);
+}
+
+static struct btd_adapter_driver sap_server_driver = {
+	.name	= "sap-server",
+	.probe	= sap_server_probe,
+	.remove	= sap_server_remove,
+};
+
+int sap_manager_init(DBusConnection *conn)
+{
+	connection = dbus_connection_ref(conn);
+
+	if (sap_server_init(connection) < 0) {
+		error("Can't init SAP server");
+		dbus_connection_unref(conn);
+		return -1;
+	}
+
+	btd_register_adapter_driver(&sap_server_driver);
+
+	return 0;
+}
+
+void sap_manager_exit(void)
+{
+	btd_unregister_adapter_driver(&sap_server_driver);
+
+	dbus_connection_unref(connection);
+	connection = NULL;
+
+	sap_server_exit();
+}
diff --git a/sap/manager.h b/sap/manager.h
new file mode 100644
index 0000000..5a779df
--- /dev/null
+++ b/sap/manager.h
@@ -0,0 +1,21 @@
+/*
+ *  BlueZ - Bluetooth protocol stack for Linux
+ *
+ *  Copyright (C) 2010 Claudio Takahasi<claudio.takahasi@openbossa.org>
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation; version 2 of the License.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program; if not, write to the Free Software
+ *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
+ */
+
+int sap_manager_init(DBusConnection *conn);
+void sap_manager_exit(void);
diff --git a/sap/server.c b/sap/server.c
new file mode 100644
index 0000000..2728778
--- /dev/null
+++ b/sap/server.c
@@ -0,0 +1,48 @@
+/*
+ *  BlueZ - Bluetooth protocol stack for Linux
+ *
+ *  Copyright (C) 2010 ST-Ericsson SA
+ *
+ *  Author: Waldemar Rymarkiewicz <waldemar.rymarkiewicz@tieto.com> for ST-Ericsson.
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation; version 2 of the License.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program; if not, write to the Free Software
+ *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
+ */
+
+#include "bluetooth.h"
+#include "log.h"
+
+#include "server.h"
+
+int sap_server_register(const char *path, bdaddr_t *src)
+{
+	DBG("Register SAP server.");
+	return 0;
+}
+
+int sap_server_unregister(const char *path)
+{
+	DBG("Unregister SAP server.");
+	return 0;
+}
+
+int sap_server_init(DBusConnection *conn)
+{
+	DBG("Init SAP server.");
+	return 0;
+}
+
+void sap_server_exit(void)
+{
+	DBG("Exit SAP server.");
+}
diff --git a/sap/server.h b/sap/server.h
new file mode 100644
index 0000000..cb77828
--- /dev/null
+++ b/sap/server.h
@@ -0,0 +1,25 @@
+/*
+ *  BlueZ - Bluetooth protocol stack for Linux
+ *
+ *  Copyright (C) 2010 Claudio Takahasi<claudio.takahasi@openbossa.org>
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation; version 2 of the License.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program; if not, write to the Free Software
+ *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
+ */
+
+#include <gdbus.h>
+
+int sap_server_init(DBusConnection *conn);
+void sap_server_exit(void);
+int sap_server_register(const char *path, bdaddr_t *src);
+int sap_server_unregister(const char *path);
-- 
1.7.0.4

