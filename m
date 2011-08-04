Return-Path: <cyrus@holtmann.org>
From: "Gustavo F. Padovan" <padovan@profusion.mobi>
To: linux-bluetooth@vger.kernel.org
Cc: Claudio Takahasi <claudio.takahasi@openbossa.org>
Subject: [PATCH 1/7] sap: initial SIM access client support
Date: Thu,  4 Aug 2011 16:39:28 -0300
Message-Id: <1312486774-20350-2-git-send-email-padovan@profusion.mobi>
In-Reply-To: <1312486774-20350-1-git-send-email-padovan@profusion.mobi>
References: <1312486774-20350-1-git-send-email-padovan@profusion.mobi>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Claudio Takahasi <claudio.takahasi@openbossa.org>

Add Makefile changes to support SAP client plugin and initial skeleton
for D-Bus methods.
---
 Makefile.am   |    1 +
 sap/client.c  |  198 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 sap/client.h  |   29 ++++++++
 sap/manager.c |   76 ++++++++++++++++++++--
 sap/sap.h     |    2 +
 sap/server.c  |    1 -
 6 files changed, 300 insertions(+), 7 deletions(-)
 create mode 100644 sap/client.c
 create mode 100644 sap/client.h

diff --git a/Makefile.am b/Makefile.am
index 68380d9..95bd9eb 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -156,6 +156,7 @@ builtin_modules += sap
 builtin_sources += sap/main.c \
 			sap/manager.h sap/manager.c \
 			sap/server.h sap/server.c \
+			sap/client.h sap/client.c \
 			sap/sap.h
 
 builtin_nodist += sap/sap.c
diff --git a/sap/client.c b/sap/client.c
new file mode 100644
index 0000000..231b4ef
--- /dev/null
+++ b/sap/client.c
@@ -0,0 +1,198 @@
+/*
+ *
+ *  BlueZ - Bluetooth protocol stack for Linux
+ *
+ *  Copyright (C) 2004-2009  Marcel Holtmann <marcel@holtmann.org>
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
+#include <bluetooth.h>
+
+#include <gdbus.h>
+
+#include "btio.h"
+#include "error.h"
+#include "dbus-common.h"
+#include "log.h"
+
+#include "client.h"
+
+#define SAP_INTERFACE	"org.bluez.SimAccessServer"
+
+static DBusConnection *connection;
+
+struct client {
+	bdaddr_t	sba;		/* Source Bluetooth address */
+	bdaddr_t	dba;		/* Destination Bluetooth address */
+	uint8_t		channel;	/* SAP RFCOMM channel */
+	char		*path;		/* Device path */
+	GIOChannel	*io;		/* BtIO Channel */
+	DBusMessage	*msg;
+};
+
+static void client_free(struct client *client)
+{
+	if (client->msg)
+		dbus_message_unref(client->msg);
+	if (client->io) {
+		g_io_channel_shutdown(client->io, TRUE, NULL);
+		g_io_channel_unref(client->io);
+	}
+
+	g_free(client->path);
+	g_free(client);
+}
+
+static void path_unregister(void *data)
+{
+	struct client *client = data;
+
+	info("Unregistered interface %s on path %s",
+			SAP_INTERFACE, client->path);
+
+	client_free(client);
+}
+
+static void rfcomm_connect_cb(GIOChannel *chan, GError *gerr, gpointer data)
+{
+	struct client *client = data;
+	DBusMessage *reply;
+
+	if (gerr) {
+		error("%s", gerr->message);
+		reply = btd_error_failed(client->msg, gerr->message);
+
+		g_io_channel_unref(client->io);
+		client->io = NULL;
+
+		goto failed;
+	}
+
+	g_io_channel_set_encoding(chan, NULL, NULL);
+
+	reply = dbus_message_new_method_return(client->msg);
+
+	/* TODO: Enable SAP messages forwarding */
+
+failed:
+	g_dbus_send_message(connection, reply);
+	dbus_message_unref(client->msg);
+	client->msg = NULL;
+}
+
+static DBusMessage *client_connect(DBusConnection *conn,
+		DBusMessage *msg, void *data)
+{
+	struct client *client = data;
+	DBusMessage *reply;
+	GError *gerr = NULL;
+
+	if (client->io)
+		return btd_error_already_connected(msg);
+
+	client->io = bt_io_connect(BT_IO_RFCOMM, rfcomm_connect_cb, client,
+			NULL, &gerr,
+			BT_IO_OPT_SOURCE_BDADDR, &client->sba,
+			BT_IO_OPT_DEST_BDADDR, &client->dba,
+			BT_IO_OPT_CHANNEL, client->channel,
+			BT_IO_OPT_SEC_LEVEL, BT_IO_SEC_HIGH,
+			BT_IO_OPT_INVALID);
+
+	if (!client->io) {
+		reply = btd_error_failed(msg, gerr->message);
+		g_error_free(gerr);
+		return reply;
+	}
+
+	client->msg = dbus_message_ref(msg);
+
+	return NULL;
+}
+
+static DBusMessage *client_disconnect(DBusConnection *conn,
+		DBusMessage *msg, void *data)
+{
+	struct client *client = data;
+
+	if (!client->io)
+		return btd_error_not_connected(msg);
+
+	if (client->msg)
+		return btd_error_in_progress(msg);
+
+	 /* TODO: exit from remote SIM mode */
+
+	return dbus_message_new_method_return(msg);
+}
+
+static GDBusMethodTable client_methods[] = {
+	{ "Connect",		"",	"",	client_connect,
+		G_DBUS_METHOD_FLAG_ASYNC },
+	{ "Disconnect",		"",	"",	client_disconnect,
+		G_DBUS_METHOD_FLAG_ASYNC },
+	{ NULL, NULL, NULL, NULL }
+};
+
+static GDBusSignalTable client_signals[] = {
+	{ "PropertyChanged",		"sv"		},
+	{ }
+};
+
+int sap_client_init(DBusConnection *conn)
+{
+	connection = dbus_connection_ref(conn);
+	return 0;
+}
+
+void sap_client_exit(void)
+{
+	dbus_connection_unref(connection);
+	connection = NULL;
+}
+
+int sap_client_register(const char *path,
+		const bdaddr_t *sba, const bdaddr_t *dba, uint8_t channel)
+{
+	struct client *client;
+
+	client = g_new0(struct client, 1);
+	bacpy(&client->sba, sba);
+	bacpy(&client->dba, dba);
+	client->channel = channel;
+	client->path = g_strdup(path);
+
+	if (!g_dbus_register_interface(connection, path,
+				SAP_INTERFACE, client_methods, client_signals, NULL,
+				client, path_unregister)) {
+		error("D-Bus failed to register %s interface",
+				SAP_INTERFACE);
+		client_free(client);
+		return -1;
+	}
+
+	return 0;
+}
+
+void sap_client_unregister(const char *path)
+{
+	g_dbus_unregister_interface(connection, path, SAP_INTERFACE);
+}
diff --git a/sap/client.h b/sap/client.h
new file mode 100644
index 0000000..2ef5668
--- /dev/null
+++ b/sap/client.h
@@ -0,0 +1,29 @@
+/*
+ *
+ *  BlueZ - Bluetooth protocol stack for Linux
+ *
+ *  Copyright (C) 2004-2009  Marcel Holtmann <marcel@holtmann.org>
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
+int sap_client_init(DBusConnection *conn);
+void sap_client_exit(void);
+
+int sap_client_register(const char *path,
+		const bdaddr_t *sba, const bdaddr_t *dba, uint8_t channel);
+void sap_client_unregister(const char *path);
diff --git a/sap/manager.c b/sap/manager.c
index a97f434..386bf54 100644
--- a/sap/manager.c
+++ b/sap/manager.c
@@ -35,11 +35,61 @@
 #include "adapter.h"
 #include "device.h"
 
+#include "sap.h"
 #include "manager.h"
 #include "server.h"
+#include "client.h"
 
 static DBusConnection *connection = NULL;
 
+static int sap_client_probe(struct btd_device *device, GSList *uuids)
+{
+	struct btd_adapter *adapter = device_get_adapter(device);
+	const gchar *path = device_get_path(device);
+	const sdp_record_t *rec;
+	sdp_list_t *protos;
+	bdaddr_t sba, dba;
+	const char *uuid;
+	uint8_t channel;
+
+	adapter_get_address(adapter, &sba);
+	device_get_address(device, &dba);
+
+
+	while (uuids) {
+		uuid = uuids->data;
+		DBG("UUID: %s", uuid);
+		rec = btd_device_get_record(device, uuid);
+		if (!rec)
+			return -EINVAL;
+
+		if (sdp_get_access_protos(rec, &protos) < 0)
+			return -EINVAL;
+
+		channel = sdp_get_proto_port(protos, RFCOMM_UUID);
+		sdp_list_foreach(protos, (sdp_list_func_t) sdp_list_free, NULL);
+		sdp_list_free(protos, NULL);
+
+		if (channel < 1 || channel > 30) {
+			error("Channel out of range: %d", channel);
+			return -EINVAL;
+		}
+
+		sap_client_register(path, &sba, &dba, channel);
+		uuids = uuids->next;
+	}
+
+	return 0;
+}
+
+static void sap_client_remove(struct btd_device *device)
+{
+	const gchar *path = device_get_path(device);
+
+	DBG("path %s", path);
+	sap_client_unregister(path);
+}
+
 static int sap_server_probe(struct btd_adapter *adapter)
 {
 	const char *path = adapter_get_path(adapter);
@@ -61,6 +111,13 @@ static void sap_server_remove(struct btd_adapter *adapter)
 	sap_server_unregister(path);
 }
 
+static struct btd_device_driver sap_client_driver = {
+	.name	= "sap-client",
+	.uuids	= BTD_UUIDS(SAP_UUID),
+	.probe	= sap_client_probe,
+	.remove	= sap_client_remove,
+};
+
 static struct btd_adapter_driver sap_server_driver = {
 	.name	= "sap-server",
 	.probe	= sap_server_probe,
@@ -69,25 +126,32 @@ static struct btd_adapter_driver sap_server_driver = {
 
 int sap_manager_init(DBusConnection *conn)
 {
-	connection = dbus_connection_ref(conn);
-
-	if (sap_server_init(connection) < 0) {
+	if (sap_server_init(conn) < 0) {
 		error("Can't init SAP server");
-		dbus_connection_unref(conn);
 		return -1;
 	}
 
 	btd_register_adapter_driver(&sap_server_driver);
 
+	sap_client_init(conn);
+
+	btd_register_device_driver(&sap_client_driver);
+
+	connection = dbus_connection_ref(conn);
+
 	return 0;
 }
 
 void sap_manager_exit(void)
 {
+	sap_server_exit();
+
+	btd_unregister_device_driver(&sap_client_driver);
+
+	sap_client_exit();
+
 	btd_unregister_adapter_driver(&sap_server_driver);
 
 	dbus_connection_unref(connection);
 	connection = NULL;
-
-	sap_server_exit();
 }
diff --git a/sap/sap.h b/sap/sap.h
index 1dbb235..99fde0a 100644
--- a/sap/sap.h
+++ b/sap/sap.h
@@ -28,6 +28,8 @@
 
 #define SAP_VERSION 0x0101
 
+#define SAP_UUID	"0000112D-0000-1000-8000-00805F9B34FB"
+
 /* Connection Status - SAP v1.1 section 5.2.2 */
 enum sap_status {
 	SAP_STATUS_OK				= 0x00,
diff --git a/sap/server.c b/sap/server.c
index 8bd8fe1..a44f7d7 100644
--- a/sap/server.c
+++ b/sap/server.c
@@ -46,7 +46,6 @@
 #include "server.h"
 
 #define SAP_SERVER_INTERFACE	"org.bluez.SimAccess"
-#define SAP_UUID		"0000112D-0000-1000-8000-00805F9B34FB"
 #define SAP_SERVER_CHANNEL	8
 
 #define PADDING4(x) ((4 - (x & 0x03)) & 0x03)
-- 
1.7.6

