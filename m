Return-Path: <cyrus@holtmann.org>
From: Gustavo Padovan <gustavo@padovan.org>
To: linux-bluetooth@vger.kernel.org
Cc: Gustavo Padovan <gustavo.padovan@collabora.co.uk>
Subject: [PATCH -v3 1/9] serial: remove the whole serial code
Date: Tue, 10 Jul 2012 11:03:00 -0300
Message-Id: <1341928988-5116-1-git-send-email-gustavo@padovan.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Gustavo Padovan <gustavo.padovan@collabora.co.uk>

---
 Makefile.am        |   19 +-
 acinclude.m4       |    6 -
 doc/serial-api.txt |   57 -----
 serial/main.c      |   59 -----
 serial/manager.c   |  127 -----------
 serial/manager.h   |   25 --
 serial/port.c      |  638 ----------------------------------------------------
 serial/port.h      |   29 ---
 serial/serial.conf |   10 -
 9 files changed, 5 insertions(+), 965 deletions(-)
 delete mode 100644 doc/serial-api.txt
 delete mode 100644 serial/main.c
 delete mode 100644 serial/manager.c
 delete mode 100644 serial/manager.h
 delete mode 100644 serial/port.c
 delete mode 100644 serial/port.h
 delete mode 100644 serial/serial.conf

diff --git a/Makefile.am b/Makefile.am
index 009762d..bd36248 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -191,13 +191,6 @@ builtin_modules += hog
 builtin_sources += input/hog_device.h input/hog_device.c
 endif
 
-if SERIALPLUGIN
-builtin_modules += serial
-builtin_sources += serial/main.c \
-			serial/manager.h serial/manager.c \
-			serial/port.h serial/port.c
-endif
-
 if NETWORKPLUGIN
 builtin_modules += network
 builtin_sources += network/main.c \
@@ -334,11 +327,10 @@ endif
 
 EXTRA_DIST += src/genbuiltin src/bluetooth.conf src/org.bluez.service \
 			src/main.conf network/network.conf \
-			input/input.conf serial/serial.conf \
+			input/input.conf proximity/proximity.conf \
 			audio/audio.conf audio/telephony-dummy.c \
 			audio/telephony-maemo5.c audio/telephony-ofono.c \
-			audio/telephony-maemo6.c sap/sap-dummy.c sap/sap-u8500.c \
-			proximity/proximity.conf
+			audio/telephony-maemo6.c sap/sap-dummy.c sap/sap-u8500.c
 
 if AUDIOPLUGIN
 if GSTREAMER
@@ -392,10 +384,9 @@ EXTRA_DIST += scripts/bluetooth-hid2hci.rules scripts/bluetooth-serial.rules
 EXTRA_DIST += doc/manager-api.txt \
 		doc/adapter-api.txt doc/device-api.txt \
 		doc/service-api.txt doc/agent-api.txt doc/attribute-api.txt \
-		doc/serial-api.txt doc/network-api.txt \
-		doc/input-api.txt doc/audio-api.txt doc/control-api.txt \
-		doc/hfp-api.txt doc/health-api.txt doc/sap-api.txt \
-		doc/media-api.txt doc/assigned-numbers.txt
+		doc/network-api.txt doc/input-api.txt doc/audio-api.txt \
+		doc/control-api.txt doc/hfp-api.txt doc/health-api.txt \
+		doc/sap-api.txt doc/media-api.txt doc/assigned-numbers.txt
 
 AM_YFLAGS = -d
 
diff --git a/acinclude.m4 b/acinclude.m4
index 3a2a50a..842eea3 100644
--- a/acinclude.m4
+++ b/acinclude.m4
@@ -172,7 +172,6 @@ AC_DEFUN([AC_ARG_BLUEZ], [
 	gstreamer_enable=${gstreamer_found}
 	audio_enable=yes
 	input_enable=yes
-	serial_enable=yes
 	network_enable=yes
 	sap_enable=no
 	service_enable=yes
@@ -218,10 +217,6 @@ AC_DEFUN([AC_ARG_BLUEZ], [
 	])
 	AC_SUBST([SAP_DRIVER], [sap-${sap_driver}.c])
 
-	AC_ARG_ENABLE(serial, AC_HELP_STRING([--disable-serial], [disable serial plugin]), [
-		serial_enable=${enableval}
-	])
-
 	AC_ARG_ENABLE(input, AC_HELP_STRING([--disable-input], [disable input plugin]), [
 		input_enable=${enableval}
 	])
@@ -345,7 +340,6 @@ AC_DEFUN([AC_ARG_BLUEZ], [
 	AM_CONDITIONAL(GSTREAMER, test "${gstreamer_enable}" = "yes" && test "${gstreamer_found}" = "yes")
 	AM_CONDITIONAL(AUDIOPLUGIN, test "${audio_enable}" = "yes")
 	AM_CONDITIONAL(INPUTPLUGIN, test "${input_enable}" = "yes")
-	AM_CONDITIONAL(SERIALPLUGIN, test "${serial_enable}" = "yes")
 	AM_CONDITIONAL(NETWORKPLUGIN, test "${network_enable}" = "yes")
 	AM_CONDITIONAL(SAPPLUGIN, test "${sap_enable}" = "yes")
 	AM_CONDITIONAL(SERVICEPLUGIN, test "${service_enable}" = "yes")
diff --git a/doc/serial-api.txt b/doc/serial-api.txt
deleted file mode 100644
index 42afe3d..0000000
--- a/doc/serial-api.txt
+++ /dev/null
@@ -1,57 +0,0 @@
-BlueZ D-Bus Serial API description
-**********************************
-
-Copyright (C) 2004-2010  Marcel Holtmann <marcel@holtmann.org>
-
-
-Serial hierarchy
-================
-
-Service		org.bluez
-Interface	org.bluez.Serial
-Object path	[variable prefix]/{hci0,hci1,...}/dev_XX_XX_XX_XX_XX_XX
-
-Methods		string Connect(string pattern)
-
-			Connects to a specific RFCOMM based service on a
-			remote device and then creates a RFCOMM TTY
-			device for it. The RFCOMM TTY device is returned.
-
-			Possible patterns: UUID 128 bit as string
-					   Profile short names, e.g: spp, dun
-					   RFCOMM channel as string, 1-30
-
-			Possible errors: org.bluez.Error.InvalidArguments
-					 org.bluez.Error.InProgress
-					 org.bluez.Error.ConnectionAttemptFailed
-					 org.bluez.Error.NotSupported
-
-Methods		fd ConnectFD(string pattern) [experimental]
-
-			Connects to a specific RFCOMM based service on a
-			remote device and returns a file descriptor to talk
-			 with this device.
-
-			Possible patterns: UUID 128 bit as string
-					   Profile short names, e.g: spp, dun
-					   RFCOMM channel as string, 1-30
-
-			Possible errors: org.bluez.Error.InvalidArguments
-					 org.bluez.Error.InProgress
-					 org.bluez.Error.ConnectionAttemptFailed
-					 org.bluez.Error.NotSupported
-
-
-		void Disconnect(string device)
-
-			Disconnect a RFCOMM TTY device that has been
-			created by Connect method.
-
-			To abort a connection attempt in case of errors or
-			timeouts in the client it is fine to call this method.
-
-			In that case one of patterns of the Connect method should
-			be supplied instead of the TTY device.
-
-			Possible errors: org.bluez.Error.InvalidArguments
-					 org.bluez.Error.DoesNotExist
diff --git a/serial/main.c b/serial/main.c
deleted file mode 100644
index 38ded03..0000000
--- a/serial/main.c
+++ /dev/null
@@ -1,59 +0,0 @@
-/*
- *
- *  BlueZ - Bluetooth protocol stack for Linux
- *
- *  Copyright (C) 2004-2010  Marcel Holtmann <marcel@holtmann.org>
- *
- *
- *  This program is free software; you can redistribute it and/or modify
- *  it under the terms of the GNU General Public License as published by
- *  the Free Software Foundation; either version 2 of the License, or
- *  (at your option) any later version.
- *
- *  This program is distributed in the hope that it will be useful,
- *  but WITHOUT ANY WARRANTY; without even the implied warranty of
- *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- *  GNU General Public License for more details.
- *
- *  You should have received a copy of the GNU General Public License
- *  along with this program; if not, write to the Free Software
- *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
- *
- */
-
-#ifdef HAVE_CONFIG_H
-#include <config.h>
-#endif
-
-#include <errno.h>
-
-#include <gdbus.h>
-
-#include "plugin.h"
-#include "manager.h"
-
-static DBusConnection *connection;
-
-static int serial_init(void)
-{
-	connection = dbus_bus_get(DBUS_BUS_SYSTEM, NULL);
-	if (connection == NULL)
-		return -EIO;
-
-	if (serial_manager_init(connection) < 0) {
-		dbus_connection_unref(connection);
-		return -EIO;
-	}
-
-	return 0;
-}
-
-static void serial_exit(void)
-{
-	serial_manager_exit();
-
-	dbus_connection_unref(connection);
-}
-
-BLUETOOTH_PLUGIN_DEFINE(serial, VERSION,
-			BLUETOOTH_PLUGIN_PRIORITY_DEFAULT, serial_init, serial_exit)
diff --git a/serial/manager.c b/serial/manager.c
deleted file mode 100644
index 6f3fc1f..0000000
--- a/serial/manager.c
+++ /dev/null
@@ -1,127 +0,0 @@
-/*
- *
- *  BlueZ - Bluetooth protocol stack for Linux
- *
- *  Copyright (C) 2004-2010  Marcel Holtmann <marcel@holtmann.org>
- *
- *
- *  This program is free software; you can redistribute it and/or modify
- *  it under the terms of the GNU General Public License as published by
- *  the Free Software Foundation; either version 2 of the License, or
- *  (at your option) any later version.
- *
- *  This program is distributed in the hope that it will be useful,
- *  but WITHOUT ANY WARRANTY; without even the implied warranty of
- *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- *  GNU General Public License for more details.
- *
- *  You should have received a copy of the GNU General Public License
- *  along with this program; if not, write to the Free Software
- *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
- *
- */
-
-#ifdef HAVE_CONFIG_H
-#include <config.h>
-#endif
-
-#include <errno.h>
-
-#include <bluetooth/bluetooth.h>
-#include <bluetooth/sdp.h>
-#include <bluetooth/sdp_lib.h>
-#include <bluetooth/uuid.h>
-
-#include <gdbus.h>
-
-#include "adapter.h"
-#include "device.h"
-
-#include "log.h"
-
-#include "port.h"
-#include "manager.h"
-
-static DBusConnection *connection = NULL;
-
-static int serial_probe(struct btd_device *device, const char *uuid)
-{
-	struct btd_adapter *adapter = device_get_adapter(device);
-	const gchar *path = device_get_path(device);
-	sdp_list_t *protos;
-	int ch;
-	bdaddr_t src, dst;
-	const sdp_record_t *rec;
-
-	DBG("path %s: %s", path, uuid);
-
-	rec = btd_device_get_record(device, uuid);
-	if (!rec)
-		return -EINVAL;
-
-	if (sdp_get_access_protos(rec, &protos) < 0)
-		return -EINVAL;
-
-	ch = sdp_get_proto_port(protos, RFCOMM_UUID);
-	sdp_list_foreach(protos, (sdp_list_func_t) sdp_list_free, NULL);
-	sdp_list_free(protos, NULL);
-
-	if (ch < 1 || ch > 30) {
-		error("Channel out of range: %d", ch);
-		return -EINVAL;
-	}
-
-	adapter_get_address(adapter, &src);
-	device_get_address(device, &dst, NULL);
-
-	return port_register(connection, path, &src, &dst, uuid, ch);
-}
-
-static void serial_remove(struct btd_device *device)
-{
-	const gchar *path = device_get_path(device);
-
-	DBG("path %s", path);
-
-	port_unregister(path);
-}
-
-
-static int port_probe(struct btd_device *device, GSList *uuids)
-{
-	while (uuids) {
-		serial_probe(device, uuids->data);
-		uuids = uuids->next;
-	}
-
-	return 0;
-}
-
-static void port_remove(struct btd_device *device)
-{
-	return serial_remove(device);
-}
-
-static struct btd_device_driver serial_port_driver = {
-	.name	= "serial-port",
-	.uuids	= BTD_UUIDS(RFCOMM_UUID_STR),
-	.probe	= port_probe,
-	.remove	= port_remove,
-};
-
-int serial_manager_init(DBusConnection *conn)
-{
-	connection = dbus_connection_ref(conn);
-
-	btd_register_device_driver(&serial_port_driver);
-
-	return 0;
-}
-
-void serial_manager_exit(void)
-{
-	btd_unregister_device_driver(&serial_port_driver);
-
-	dbus_connection_unref(connection);
-	connection = NULL;
-}
diff --git a/serial/manager.h b/serial/manager.h
deleted file mode 100644
index c8b96e8..0000000
--- a/serial/manager.h
+++ /dev/null
@@ -1,25 +0,0 @@
-/*
- *
- *  BlueZ - Bluetooth protocol stack for Linux
- *
- *  Copyright (C) 2004-2010  Marcel Holtmann <marcel@holtmann.org>
- *
- *
- *  This program is free software; you can redistribute it and/or modify
- *  it under the terms of the GNU General Public License as published by
- *  the Free Software Foundation; either version 2 of the License, or
- *  (at your option) any later version.
- *
- *  This program is distributed in the hope that it will be useful,
- *  but WITHOUT ANY WARRANTY; without even the implied warranty of
- *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- *  GNU General Public License for more details.
- *
- *  You should have received a copy of the GNU General Public License
- *  along with this program; if not, write to the Free Software
- *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
- *
- */
-
-int serial_manager_init(DBusConnection *conn);
-void serial_manager_exit(void);
diff --git a/serial/port.c b/serial/port.c
deleted file mode 100644
index 2422cfe..0000000
--- a/serial/port.c
+++ /dev/null
@@ -1,638 +0,0 @@
-/*
- *
- *  BlueZ - Bluetooth protocol stack for Linux
- *
- *  Copyright (C) 2004-2010  Marcel Holtmann <marcel@holtmann.org>
- *
- *
- *  This program is free software; you can redistribute it and/or modify
- *  it under the terms of the GNU General Public License as published by
- *  the Free Software Foundation; either version 2 of the License, or
- *  (at your option) any later version.
- *
- *  This program is distributed in the hope that it will be useful,
- *  but WITHOUT ANY WARRANTY; without even the implied warranty of
- *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- *  GNU General Public License for more details.
- *
- *  You should have received a copy of the GNU General Public License
- *  along with this program; if not, write to the Free Software
- *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
- *
- */
-
-#ifdef HAVE_CONFIG_H
-#include <config.h>
-#endif
-
-#include <errno.h>
-#include <stdlib.h>
-#include <unistd.h>
-#include <sys/ioctl.h>
-#include <fcntl.h>
-
-#include <bluetooth/bluetooth.h>
-#include <bluetooth/rfcomm.h>
-#include <bluetooth/sdp.h>
-#include <bluetooth/sdp_lib.h>
-
-#include <glib.h>
-#include <gdbus.h>
-
-#include "log.h"
-#include "glib-helper.h"
-#include "sdp-client.h"
-#include "btio.h"
-
-#include "error.h"
-#include "manager.h"
-#include "adapter.h"
-#include "device.h"
-#include "storage.h"
-#include "port.h"
-
-#define SERIAL_PORT_INTERFACE	"org.bluez.Serial"
-
-#define MAX_OPEN_TRIES		5
-#define OPEN_WAIT		300	/* ms. udev node creation retry wait */
-
-struct serial_device {
-	DBusConnection	*conn;		/* for name listener handling */
-	bdaddr_t	src;		/* Source (local) address */
-	bdaddr_t	dst;		/* Destination address */
-	char		*path;		/* Device path */
-	GSList		*ports;		/* Available ports */
-};
-
-struct serial_port {
-	DBusMessage	*msg;		/* for name listener handling */
-	int16_t		id;		/* RFCOMM device id */
-	uint8_t		channel;	/* RFCOMM channel */
-	char		*uuid;		/* service identification */
-	char		*dev;		/* RFCOMM device name */
-	int		fd;		/* Opened file descriptor */
-	GIOChannel	*io;		/* BtIO channel */
-	guint		listener_id;
-	struct serial_device *device;
-};
-
-static GSList *devices = NULL;
-
-static struct serial_device *find_device(GSList *devices, const char *path)
-{
-	GSList *l;
-
-	for (l = devices; l != NULL; l = l->next) {
-		struct serial_device *device = l->data;
-
-		if (!strcmp(device->path, path))
-			return device;
-	}
-
-	return NULL;
-}
-
-static struct serial_port *find_port(GSList *ports, const char *pattern)
-{
-	GSList *l;
-	int channel;
-	char *endptr = NULL;
-
-	channel = strtol(pattern, &endptr, 10);
-
-	for (l = ports; l != NULL; l = l->next) {
-		struct serial_port *port = l->data;
-		char *uuid_str;
-		int ret;
-
-		if (port->uuid && !strcasecmp(port->uuid, pattern))
-			return port;
-
-		if (endptr && *endptr == '\0' && port->channel == channel)
-			return port;
-
-		if (port->dev && !strcmp(port->dev, pattern))
-			return port;
-
-		if (!port->uuid)
-			continue;
-
-		uuid_str = bt_name2string(pattern);
-		if (!uuid_str)
-			continue;
-
-		ret = strcasecmp(port->uuid, uuid_str);
-		g_free(uuid_str);
-		if (ret == 0)
-			return port;
-	}
-
-	return NULL;
-}
-
-static int port_release(struct serial_port *port)
-{
-	struct rfcomm_dev_req req;
-	int rfcomm_ctl;
-	int err = 0;
-
-	if (port->id < 0) {
-		if (port->io) {
-			g_io_channel_shutdown(port->io, TRUE, NULL);
-			g_io_channel_unref(port->io);
-			port->io = NULL;
-		} else
-			bt_cancel_discovery(&port->device->src,
-						&port->device->dst);
-
-		return 0;
-	}
-
-	DBG("Serial port %s released", port->dev);
-
-	rfcomm_ctl = socket(AF_BLUETOOTH, SOCK_RAW, BTPROTO_RFCOMM);
-	if (rfcomm_ctl < 0)
-		return -errno;
-
-	if (port->fd >= 0) {
-		close(port->fd);
-		port->fd = -1;
-	}
-
-	memset(&req, 0, sizeof(req));
-	req.dev_id = port->id;
-
-	/*
-	 * We are hitting a kernel bug inside RFCOMM code when
-	 * RFCOMM_HANGUP_NOW bit is set on request's flags passed to
-	 * ioctl(RFCOMMRELEASEDEV)!
-	 */
-	req.flags = (1 << RFCOMM_HANGUP_NOW);
-
-	if (ioctl(rfcomm_ctl, RFCOMMRELEASEDEV, &req) < 0) {
-		err = -errno;
-		error("Can't release device %s: %s (%d)",
-				port->dev, strerror(-err), -err);
-	}
-
-	g_free(port->dev);
-	port->dev = NULL;
-	port->id = -1;
-	close(rfcomm_ctl);
-	return err;
-}
-
-static void serial_port_free(void *data)
-{
-	struct serial_port *port = data;
-	struct serial_device *device = port->device;
-
-	if (device && port->listener_id > 0)
-		g_dbus_remove_watch(device->conn, port->listener_id);
-
-	port_release(port);
-
-	g_free(port->uuid);
-	g_free(port);
-}
-
-static void serial_device_free(void *data)
-{
-	struct serial_device *device = data;
-
-	g_free(device->path);
-	if (device->conn)
-		dbus_connection_unref(device->conn);
-	g_free(device);
-}
-
-static void port_owner_exited(DBusConnection *conn, void *user_data)
-{
-	struct serial_port *port = user_data;
-
-	port_release(port);
-
-	port->listener_id = 0;
-}
-
-static void path_unregister(void *data)
-{
-	struct serial_device *device = data;
-
-	DBG("Unregistered interface %s on path %s", SERIAL_PORT_INTERFACE,
-		device->path);
-
-	devices = g_slist_remove(devices, device);
-	serial_device_free(device);
-}
-
-void port_release_all(void)
-{
-	g_slist_free_full(devices, serial_device_free);
-}
-
-static void open_notify(int fd, int err, struct serial_port *port)
-{
-	struct serial_device *device = port->device;
-	DBusMessage *reply;
-
-	if (err < 0) {
-		/* Max tries exceeded */
-		port_release(port);
-		reply = btd_error_failed(port->msg, strerror(-err));
-	} else {
-		port->fd = fd;
-		reply = g_dbus_create_reply(port->msg,
-				DBUS_TYPE_STRING, &port->dev,
-				DBUS_TYPE_INVALID);
-	}
-
-	/* Reply to the requestor */
-	g_dbus_send_message(device->conn, reply);
-}
-
-static gboolean open_continue(gpointer user_data)
-{
-	struct serial_port *port = user_data;
-	int fd;
-	static int ntries = MAX_OPEN_TRIES;
-
-	if (!port->listener_id)
-		return FALSE; /* Owner exited */
-
-	fd = open(port->dev, O_RDONLY | O_NOCTTY);
-	if (fd < 0) {
-		int err = -errno;
-		error("Could not open %s: %s (%d)",
-				port->dev, strerror(-err), -err);
-		if (!--ntries) {
-			/* Reporting error */
-			open_notify(fd, err, port);
-			ntries = MAX_OPEN_TRIES;
-			return FALSE;
-		}
-		return TRUE;
-	}
-
-	/* Connection succeeded */
-	open_notify(fd, 0, port);
-	return FALSE;
-}
-
-static int port_open(struct serial_port *port)
-{
-	int fd;
-
-	fd = open(port->dev, O_RDONLY | O_NOCTTY);
-	if (fd < 0) {
-		g_timeout_add(OPEN_WAIT, open_continue, port);
-		return -EINPROGRESS;
-	}
-
-	return fd;
-}
-
-static void rfcomm_connect_cb(GIOChannel *chan, GError *conn_err,
-							gpointer user_data)
-{
-	struct serial_port *port = user_data;
-	struct serial_device *device = port->device;
-	struct rfcomm_dev_req req;
-	int sk, fd;
-	DBusMessage *reply;
-
-	/* Owner exited? */
-	if (!port->listener_id)
-		return;
-
-	if (conn_err) {
-		error("%s", conn_err->message);
-		reply = btd_error_failed(port->msg, conn_err->message);
-		goto fail;
-	}
-
-	sk = g_io_channel_unix_get_fd(chan);
-
-	if (dbus_message_has_member(port->msg, "ConnectFD")) {
-		reply = g_dbus_create_reply(port->msg, DBUS_TYPE_UNIX_FD, &sk,
-							DBUS_TYPE_INVALID);
-		g_dbus_send_message(device->conn, reply);
-
-		close(sk);
-
-		g_dbus_remove_watch(device->conn, port->listener_id);
-		port->listener_id = 0;
-
-		return;
-	}
-
-	memset(&req, 0, sizeof(req));
-	req.dev_id = -1;
-	req.flags = (1 << RFCOMM_REUSE_DLC);
-	bacpy(&req.src, &device->src);
-	bacpy(&req.dst, &device->dst);
-	req.channel = port->channel;
-
-	g_io_channel_unref(port->io);
-	port->io = NULL;
-
-	port->id = ioctl(sk, RFCOMMCREATEDEV, &req);
-	if (port->id < 0) {
-		int err = -errno;
-		error("ioctl(RFCOMMCREATEDEV): %s (%d)", strerror(-err), -err);
-		reply = btd_error_failed(port->msg, strerror(-err));
-		g_io_channel_shutdown(chan, TRUE, NULL);
-		goto fail;
-	}
-
-	port->dev = g_strdup_printf("/dev/rfcomm%d", port->id);
-
-	DBG("Serial port %s created", port->dev);
-
-	g_io_channel_shutdown(chan, TRUE, NULL);
-
-	/* Addressing connect port */
-	fd = port_open(port);
-	if (fd < 0)
-		/* Open in progress: Wait the callback */
-		return;
-
-	open_notify(fd, 0, port);
-	return;
-
-fail:
-	g_dbus_send_message(device->conn, reply);
-	g_dbus_remove_watch(device->conn, port->listener_id);
-	port->listener_id = 0;
-}
-
-static void get_record_cb(sdp_list_t *recs, int err, gpointer user_data)
-{
-	struct serial_port *port = user_data;
-	struct serial_device *device = port->device;
-	sdp_record_t *record = NULL;
-	sdp_list_t *protos;
-	DBusMessage *reply;
-	GError *gerr = NULL;
-
-	if (!port->listener_id)
-		return;
-
-	if (err < 0) {
-		error("Unable to get service record: %s (%d)", strerror(-err),
-			-err);
-		reply = btd_error_failed(port->msg, strerror(-err));
-		goto failed;
-	}
-
-	if (!recs || !recs->data) {
-		error("No record found");
-		reply = btd_error_failed(port->msg, "No record found");
-		goto failed;
-	}
-
-	record = recs->data;
-
-	if (sdp_get_access_protos(record, &protos) < 0) {
-		error("Unable to get access protos from port record");
-		reply = btd_error_failed(port->msg, "Invalid channel");
-		goto failed;
-	}
-
-	port->channel = sdp_get_proto_port(protos, RFCOMM_UUID);
-
-	sdp_list_foreach(protos, (sdp_list_func_t) sdp_list_free, NULL);
-	sdp_list_free(protos, NULL);
-
-	port->io = bt_io_connect(BT_IO_RFCOMM, rfcomm_connect_cb, port,
-				NULL, &gerr,
-				BT_IO_OPT_SOURCE_BDADDR, &device->src,
-				BT_IO_OPT_DEST_BDADDR, &device->dst,
-				BT_IO_OPT_CHANNEL, port->channel,
-				BT_IO_OPT_SEC_LEVEL, BT_IO_SEC_MEDIUM,
-				BT_IO_OPT_INVALID);
-	if (!port->io) {
-		error("%s", gerr->message);
-		reply = btd_error_failed(port->msg, gerr->message);
-		g_error_free(gerr);
-		goto failed;
-	}
-
-	return;
-
-failed:
-	g_dbus_remove_watch(device->conn, port->listener_id);
-	port->listener_id = 0;
-	g_dbus_send_message(device->conn, reply);
-}
-
-static int connect_port(struct serial_port *port)
-{
-	struct serial_device *device = port->device;
-	uuid_t uuid;
-	int err;
-
-	if (!port->uuid)
-		goto connect;
-
-	err = bt_string2uuid(&uuid, port->uuid);
-	if (err < 0)
-		return err;
-
-	sdp_uuid128_to_uuid(&uuid);
-
-	return bt_search_service(&device->src, &device->dst, &uuid,
-				get_record_cb, port, NULL);
-
-connect:
-	port->io = bt_io_connect(BT_IO_RFCOMM, rfcomm_connect_cb, port,
-				NULL, NULL,
-				BT_IO_OPT_SOURCE_BDADDR, &device->src,
-				BT_IO_OPT_DEST_BDADDR, &device->dst,
-				BT_IO_OPT_CHANNEL, port->channel,
-				BT_IO_OPT_SEC_LEVEL, BT_IO_SEC_MEDIUM,
-				BT_IO_OPT_INVALID);
-	if (port->io == NULL)
-		return -EIO;
-
-	return 0;
-}
-
-static struct serial_port *create_port(struct serial_device *device,
-					const char *uuid, uint8_t channel)
-{
-	struct serial_port *port;
-
-	port = g_new0(struct serial_port, 1);
-	port->uuid = g_strdup(uuid);
-	port->channel = channel;
-	port->device = device;
-	port->id = -1;
-	port->fd = -1;
-
-	device->ports = g_slist_append(device->ports, port);
-
-	return port;
-}
-
-static DBusMessage *port_connect(DBusConnection *conn,
-					DBusMessage *msg, void *user_data)
-{
-	struct serial_device *device = user_data;
-	struct serial_port *port;
-	const char *pattern;
-	int err;
-
-	if (dbus_message_get_args(msg, NULL, DBUS_TYPE_STRING, &pattern,
-						DBUS_TYPE_INVALID) == FALSE)
-		return NULL;
-
-	port = find_port(device->ports, pattern);
-	if (!port) {
-		char *endptr = NULL;
-		int channel;
-
-		channel = strtol(pattern, &endptr, 10);
-		if ((endptr && *endptr != '\0') || channel < 1 || channel > 30)
-			return btd_error_does_not_exist(msg);
-
-		port = create_port(device, NULL, channel);
-	}
-
-	if (port->listener_id)
-		return btd_error_failed(msg, "Port already in use");
-
-	port->listener_id = g_dbus_add_disconnect_watch(conn,
-						dbus_message_get_sender(msg),
-						port_owner_exited, port,
-						NULL);
-
-	port->msg = dbus_message_ref(msg);
-
-	err = connect_port(port);
-	if (err < 0) {
-		error("%s", strerror(-err));
-		g_dbus_remove_watch(conn, port->listener_id);
-		port->listener_id = 0;
-
-		return btd_error_failed(msg, strerror(-err));
-	}
-
-	return NULL;
-}
-
-static DBusMessage *port_disconnect(DBusConnection *conn,
-					DBusMessage *msg, void *user_data)
-{
-	struct serial_device *device = user_data;
-	struct serial_port *port;
-	const char *dev, *owner, *caller;
-
-	if (dbus_message_get_args(msg, NULL, DBUS_TYPE_STRING, &dev,
-						DBUS_TYPE_INVALID) == FALSE)
-		return NULL;
-
-	port = find_port(device->ports, dev);
-	if (!port)
-		return btd_error_does_not_exist(msg);
-
-	if (!port->listener_id)
-		return btd_error_not_connected(msg);
-
-	owner = dbus_message_get_sender(port->msg);
-	caller = dbus_message_get_sender(msg);
-	if (!g_str_equal(owner, caller))
-		return btd_error_not_authorized(msg);
-
-	port_release(port);
-
-	g_dbus_remove_watch(conn, port->listener_id);
-	port->listener_id = 0;
-
-	return g_dbus_create_reply(msg, DBUS_TYPE_INVALID);
-}
-
-static const GDBusMethodTable port_methods[] = {
-	{ GDBUS_ASYNC_METHOD("Connect",
-		GDBUS_ARGS({ "pattern", "s" }),	GDBUS_ARGS({ "tty", "s" }),
-		port_connect) },
-	{ GDBUS_ASYNC_METHOD("ConnectFD",
-		GDBUS_ARGS({ "pattern", "s" }), GDBUS_ARGS({ "fd", "s" }),
-		port_connect) },
-	{ GDBUS_METHOD("Disconnect",
-		GDBUS_ARGS({ "device", "s" }), NULL,
-		port_disconnect) },
-	{ }
-};
-
-static struct serial_device *create_serial_device(DBusConnection *conn,
-					const char *path, bdaddr_t *src,
-					bdaddr_t *dst)
-{
-	struct serial_device *device;
-
-	device = g_new0(struct serial_device, 1);
-	device->conn = dbus_connection_ref(conn);
-	bacpy(&device->dst, dst);
-	bacpy(&device->src, src);
-	device->path = g_strdup(path);
-
-	if (!g_dbus_register_interface(conn, path,
-				SERIAL_PORT_INTERFACE,
-				port_methods, NULL, NULL,
-				device, path_unregister)) {
-		error("D-Bus failed to register %s interface",
-				SERIAL_PORT_INTERFACE);
-		serial_device_free(device);
-		return NULL;
-	}
-
-	DBG("Registered interface %s on path %s",
-		SERIAL_PORT_INTERFACE, path);
-
-	return device;
-}
-
-int port_register(DBusConnection *conn, const char *path, bdaddr_t *src,
-			bdaddr_t *dst, const char *uuid, uint8_t channel)
-{
-	struct serial_device *device;
-	struct serial_port *port;
-
-	device = find_device(devices, path);
-	if (!device) {
-		device = create_serial_device(conn, path, src, dst);
-		if (!device)
-			return -1;
-		devices = g_slist_append(devices, device);
-	}
-
-	if (find_port(device->ports, uuid))
-		return 0;
-
-	port = g_new0(struct serial_port, 1);
-	port->uuid = g_strdup(uuid);
-	port->channel = channel;
-	port->device = device;
-	port->id = -1;
-	port->fd = -1;
-
-	device->ports = g_slist_append(device->ports, port);
-
-	return 0;
-}
-
-int port_unregister(const char *path)
-{
-	struct serial_device *device;
-
-	device = find_device(devices, path);
-	if (!device)
-		return -ENOENT;
-
-	g_slist_free_full(device->ports, serial_port_free);
-
-	g_dbus_unregister_interface(device->conn, path, SERIAL_PORT_INTERFACE);
-
-	return 0;
-}
diff --git a/serial/port.h b/serial/port.h
deleted file mode 100644
index 74ac9f0..0000000
--- a/serial/port.h
+++ /dev/null
@@ -1,29 +0,0 @@
-/*
- *
- *  BlueZ - Bluetooth protocol stack for Linux
- *
- *  Copyright (C) 2004-2010  Marcel Holtmann <marcel@holtmann.org>
- *
- *
- *  This program is free software; you can redistribute it and/or modify
- *  it under the terms of the GNU General Public License as published by
- *  the Free Software Foundation; either version 2 of the License, or
- *  (at your option) any later version.
- *
- *  This program is distributed in the hope that it will be useful,
- *  but WITHOUT ANY WARRANTY; without even the implied warranty of
- *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- *  GNU General Public License for more details.
- *
- *  You should have received a copy of the GNU General Public License
- *  along with this program; if not, write to the Free Software
- *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
- *
- */
-
-void port_release_all(void);
-
-int port_register(DBusConnection *conn, const char *path, bdaddr_t *src,
-		  bdaddr_t *dst, const char *name, uint8_t channel);
-
-int port_unregister(const char *path);
diff --git a/serial/serial.conf b/serial/serial.conf
deleted file mode 100644
index 43ee6af..0000000
--- a/serial/serial.conf
+++ /dev/null
@@ -1,10 +0,0 @@
-# Configuration file for serial
-
-# There could be multiple proxy sections, the format is [Proxy <user chosen name>]
-#[Proxy DUN]
-
-# UUID for DUN proxy service
-#UUID=00001103-0000-1000-8000-00805F9B34FB
-
-# Address for device node
-#Address=/dev/ttyx
-- 
1.7.10.2

