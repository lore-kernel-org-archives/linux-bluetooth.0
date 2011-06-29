Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH BlueZ 5/6] Make use of g_slist_free_full on serial plugin
Date: Wed, 29 Jun 2011 11:52:52 +0300
Message-Id: <1309337573-8295-5-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1309337573-8295-1-git-send-email-luiz.dentz@gmail.com>
References: <1309337573-8295-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

---
 serial/port.c |   13 +++++++------
 1 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/serial/port.c b/serial/port.c
index 7d56faa..d011084 100644
--- a/serial/port.c
+++ b/serial/port.c
@@ -189,8 +189,9 @@ static int port_release(struct serial_port *port)
 	return -err;
 }
 
-static void serial_port_free(struct serial_port *port)
+static void serial_port_free(void *data)
 {
+	struct serial_port *port = data;
 	struct serial_device *device = port->device;
 
 	if (device && port->listener_id > 0)
@@ -202,8 +203,10 @@ static void serial_port_free(struct serial_port *port)
 	g_free(port);
 }
 
-static void serial_device_free(struct serial_device *device)
+static void serial_device_free(void *data)
 {
+	struct serial_device *device = data;
+
 	g_free(device->path);
 	if (device->conn)
 		dbus_connection_unref(device->conn);
@@ -232,8 +235,7 @@ static void path_unregister(void *data)
 
 void port_release_all(void)
 {
-	g_slist_foreach(devices, (GFunc) serial_device_free, NULL);
-	g_slist_free(devices);
+	g_slist_free_full(devices, serial_device_free);
 }
 
 static void open_notify(int fd, int err, struct serial_port *port)
@@ -613,8 +615,7 @@ int port_unregister(const char *path)
 	if (!device)
 		return -ENOENT;
 
-	g_slist_foreach(device->ports, (GFunc) serial_port_free, NULL);
-	g_slist_free(device->ports);
+	g_slist_free_full(device->ports, serial_port_free);
 
 	g_dbus_unregister_interface(device->conn, path, SERIAL_PORT_INTERFACE);
 
-- 
1.7.5.4

