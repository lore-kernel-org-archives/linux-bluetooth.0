Return-Path: <cyrus@holtmann.org>
From: Forrest Zhao <forrest.zhao@intel.com>
To: linux-bluetooth@vger.kernel.org
Cc: forrest.zhao@gmail.com, Forrest Zhao <forrest.zhao@intel.com>
Subject: [PATCH] remove the serial storage stuff
Date: Mon, 27 Jul 2009 13:31:30 +0800
Message-Id: <1248672690-13907-1-git-send-email-forrest.zhao@intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 serial/Makefile.am |    2 +-
 serial/proxy.c     |  100 ++-----------------------------------
 serial/storage.c   |  138 ----------------------------------------------------
 serial/storage.h   |   29 -----------
 4 files changed, 7 insertions(+), 262 deletions(-)
 delete mode 100644 serial/storage.c
 delete mode 100644 serial/storage.h

diff --git a/serial/Makefile.am b/serial/Makefile.am
index c88a980..f8f26e2 100644
--- a/serial/Makefile.am
+++ b/serial/Makefile.am
@@ -6,7 +6,7 @@ plugin_LTLIBRARIES = serial.la
 
 serial_la_SOURCES = main.c \
 			manager.h manager.c port.h port.c \
-			storage.h storage.c proxy.h proxy.c
+			proxy.h proxy.c
 
 LDADD = $(top_builddir)/common/libhelper.a \
 		@GDBUS_LIBS@ @GLIB_LIBS@ @DBUS_LIBS@ @BLUEZ_LIBS@
diff --git a/serial/proxy.c b/serial/proxy.c
index 05687d8..6bc66cb 100644
--- a/serial/proxy.c
+++ b/serial/proxy.c
@@ -58,7 +58,6 @@
 #include "textfile.h"
 
 #include "error.h"
-#include "storage.h"
 #include "sdpd.h"
 #include "glib-helper.h"
 #include "btio.h"
@@ -776,9 +775,6 @@ static DBusMessage *proxy_set_serial_params(DBusConnection *conn,
 	cfsetispeed(&prx->proxy_ti, speed);
 	cfsetospeed(&prx->proxy_ti, speed);
 
-	proxy_store(&prx->src, prx->uuid128, prx->address, NULL,
-				prx->channel, 0, &prx->proxy_ti);
-
 	return dbus_message_new_method_return(msg);
 }
 
@@ -840,8 +836,7 @@ static int register_proxy_object(struct serial_proxy *prx, char *outpath, size_t
 
 static int proxy_tty_register(struct serial_adapter *adapter,
 				const char *uuid128, const char *address,
-				struct termios *ti, char *outpath, size_t size,
-				gboolean save)
+				struct termios *ti, char *outpath, size_t size)
 {
 	struct termios sys_ti;
 	struct serial_proxy *prx;
@@ -878,16 +873,12 @@ static int proxy_tty_register(struct serial_adapter *adapter,
 	if (ret < 0)
 		proxy_free(prx);
 
-	if (save)
-		proxy_store(&prx->src, uuid128, address, NULL,
-			prx->channel, 0, &prx->proxy_ti);
-
 	return ret;
 }
 
 static int proxy_socket_register(struct serial_adapter *adapter,
 				const char *uuid128, const char *address,
-				char *outpath, size_t size, gboolean save)
+				char *outpath, size_t size)
 {
 	struct serial_proxy *prx;
 	int ret;
@@ -903,16 +894,12 @@ static int proxy_socket_register(struct serial_adapter *adapter,
 	if (ret < 0)
 		proxy_free(prx);
 
-	if (save)
-		proxy_store(&prx->src, uuid128, address, NULL,
-				prx->channel, 0, NULL);
-
 	return ret;
 }
 
 static int proxy_tcp_register(struct serial_adapter *adapter,
 				const char *uuid128, const char *address,
-				char *outpath, size_t size, gboolean save)
+				char *outpath, size_t size)
 {
 	struct serial_proxy *prx;
 	int ret;
@@ -928,10 +915,6 @@ static int proxy_tcp_register(struct serial_adapter *adapter,
 	if (ret < 0)
 		proxy_free(prx);
 
-	if (save)
-		proxy_store(&prx->src, uuid128, address, NULL,
-				prx->channel, 0, NULL);
-
 	return ret;
 }
 
@@ -995,15 +978,15 @@ static int register_proxy(struct serial_adapter *adapter, const char *uuid_str,
 	switch (type) {
 	case UNIX_SOCKET_PROXY:
 		err = proxy_socket_register(adapter, uuid_str, address,
-							path, length, TRUE);
+							path, length);
 		break;
 	case TTY_PROXY:
 		err = proxy_tty_register(adapter, uuid_str, address, NULL,
-							path, length, TRUE);
+							path, length);
 		break;
 	case TCP_SOCKET_PROXY:
 		err = proxy_tcp_register(adapter, uuid_str, address,
-							path, length, TRUE);
+							path, length);
 		break;
 	default:
 		err = -EINVAL;
@@ -1108,7 +1091,6 @@ static DBusMessage *remove_proxy(DBusConnection *conn,
 			DBUS_TYPE_INVALID);
 
 	prx = l->data;
-	proxy_delete(&prx->src, prx->address);
 	adapter->proxies = g_slist_remove(adapter->proxies, prx);
 
 	g_dbus_unregister_interface(conn, path, SERIAL_PROXY_INTERFACE);
@@ -1153,74 +1135,6 @@ static GDBusSignalTable manager_signals[] = {
 	{ }
 };
 
-static void parse_proxy(char *key, char *value, void *data)
-{
-	struct serial_adapter *adapter = data;
-	char uuid128[MAX_LEN_UUID_STR], tmp[3];
-	char *pvalue;
-	proxy_type_t type;
-	unsigned int pos;
-	int ch, opts;
-	struct termios ti;
-	uint8_t *pti;
-
-	memset(uuid128, 0, sizeof(uuid128));
-	ch = opts = pos = 0;
-	if (sscanf(value,"%s %d 0x%04X %n", uuid128, &ch, &opts, &pos) != 3)
-		return;
-
-	/* Extracting name */
-	value += pos;
-	pvalue = strchr(value, ':');
-	if (!pvalue)
-		return;
-
-	/* FIXME: currently name is not used */
-	*pvalue = '\0';
-
-	type = addr2type(key);
-	switch (type) {
-	case TTY_PROXY:
-		/* Extracting termios */
-		pvalue++;
-		if (!pvalue || strlen(pvalue) != (2 * sizeof(ti)))
-			return;
-
-		memset(&ti, 0, sizeof(ti));
-		memset(tmp, 0, sizeof(tmp));
-
-		/* Converting to termios struct */
-		pti = (uint8_t *) &ti;
-		for (pos = 0; pos < sizeof(ti); pos++, pvalue += 2, pti++) {
-			memcpy(tmp, pvalue, 2);
-			*pti = (uint8_t) strtol(tmp, NULL, 16);
-		}
-
-		proxy_tty_register(adapter, uuid128, key, &ti, NULL, 0, FALSE);
-		break;
-	case UNIX_SOCKET_PROXY:
-		proxy_socket_register(adapter, uuid128, key, NULL, 0, FALSE);
-		break;
-	case TCP_SOCKET_PROXY:
-		proxy_tcp_register(adapter, uuid128, key, NULL, 0, FALSE);
-		break;
-	default:
-		return;
-	}
-}
-
-static void register_stored(struct serial_adapter *adapter)
-{
-	char filename[PATH_MAX + 1];
-	char address[18];
-	bdaddr_t src;
-
-	adapter_get_address(adapter->btd_adapter, &src);
-	ba2str(&src, address);
-	snprintf(filename, PATH_MAX, "%s/%s/proxy", STORAGEDIR, address);
-	textfile_foreach(filename, parse_proxy, adapter);
-}
-
 static struct serial_adapter *find_adapter(GSList *list,
 					struct btd_adapter *btd_adapter)
 {
@@ -1340,8 +1254,6 @@ int proxy_register(DBusConnection *conn, struct btd_adapter *btd_adapter)
 		return -1;
 	}
 
-	register_stored(adapter);
-
 	adapters = g_slist_append(adapters, adapter);
 
 	debug("Registered interface %s on path %s",
diff --git a/serial/storage.c b/serial/storage.c
deleted file mode 100644
index 39b1e6f..0000000
--- a/serial/storage.c
+++ /dev/null
@@ -1,138 +0,0 @@
-/*
- *
- *  BlueZ - Bluetooth protocol stack for Linux
- *
- *  Copyright (C) 2004-2009  Marcel Holtmann <marcel@holtmann.org>
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
-#include <termios.h>
-#include <unistd.h>
-#include <sys/stat.h>
-#include <sys/param.h>
-
-#include <bluetooth/bluetooth.h>
-#include <bluetooth/sdp.h>
-#include <bluetooth/sdp_lib.h>
-
-#include <glib.h>
-
-#include "logging.h"
-#include "textfile.h"
-
-#include "storage.h"
-
-int port_delete(bdaddr_t *src, bdaddr_t *dst, int16_t id)
-{
-	char filename[PATH_MAX + 1];
-	char src_addr[18], dst_addr[18];
-	char key[32];
-
-	ba2str(src, src_addr);
-	ba2str(dst, dst_addr);
-
-	create_name(filename, PATH_MAX, STORAGEDIR, src_addr, "serial");
-	snprintf(key, sizeof(key), "%s#%hd", dst_addr, id);
-
-	return textfile_del(filename, key);
-}
-
-int port_store(bdaddr_t *src, bdaddr_t *dst, int16_t id,
-			uint8_t ch, const char *svcname)
-{
-	char filename[PATH_MAX + 1];
-	char src_addr[18], dst_addr[18];
-	char key[32];
-	char *value;
-	int size, err;
-
-	if (!svcname)
-		svcname = "Bluetooth RFCOMM port";
-
-	ba2str(src, src_addr);
-	ba2str(dst, dst_addr);
-
-	create_name(filename, PATH_MAX, STORAGEDIR, src_addr, "serial");
-	create_file(filename, S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH);
-
-	size = strlen(svcname) + 5;
-	value = g_malloc0(size);
-
-	snprintf(key, 32, "%s#%hd", dst_addr, id);
-	snprintf(value, size, "%d:%s", ch, svcname);
-
-	err = textfile_put(filename, key, value);
-	g_free(value);
-
-	return err;
-}
-
-int proxy_delete(bdaddr_t *src, const char *tty)
-{
-	char filename[PATH_MAX + 1], src_addr[18];
-
-	ba2str(src, src_addr);
-
-	create_name(filename, PATH_MAX, STORAGEDIR, src_addr, "proxy");
-
-	return textfile_del(filename, tty);
-}
-
-int proxy_store(bdaddr_t *src, const char *uuid, const char *tty,
-		const char *name, uint8_t ch, int opts, struct termios *ti)
-{
-	char filename[PATH_MAX + 1], key[32], src_addr[18], *value;
-	unsigned int i;
-	int pos, size, err;
-	uint8_t *pti;
-
-	ba2str(src, src_addr);
-
-	create_name(filename, PATH_MAX, STORAGEDIR, src_addr, "proxy");
-	create_file(filename, S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH);
-
-	if (!name)
-		name = "Port Proxy Entity";
-
-	size = MAX_LEN_UUID_STR + 16 + strlen(name) + sizeof(struct termios) * 2;
-	value = g_malloc0(size);
-
-	snprintf(key, 32, "%s", tty);
-
-	/* tty uuid 00 0x0000 name:termios */
-	pos = snprintf(value, size, "%s %d 0x%04X %s:", uuid, ch, opts, name);
-
-	if (!ti)
-		goto done;
-
-	for (i = 0, pti = (uint8_t *) ti; i < sizeof(struct termios); i++, pti++)
-		sprintf(value + pos + (i * 2), "%2.2X", *pti);
-
-done:
-	err = textfile_put(filename, key, value);
-	g_free(value);
-
-	return err;
-}
-
diff --git a/serial/storage.h b/serial/storage.h
deleted file mode 100644
index 6d7007f..0000000
--- a/serial/storage.h
+++ /dev/null
@@ -1,29 +0,0 @@
-/*
- *
- *  BlueZ - Bluetooth protocol stack for Linux
- *
- *  Copyright (C) 2004-2009  Marcel Holtmann <marcel@holtmann.org>
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
-int port_delete(bdaddr_t *src, bdaddr_t *dst, int16_t id);
-int port_store(bdaddr_t *src, bdaddr_t *dst, int16_t id,
-			uint8_t ch, const char *svcname);
-int proxy_delete(bdaddr_t *src, const char *tty);
-int proxy_store(bdaddr_t *src, const char *uuid, const char *tty,
-		const char *name, uint8_t ch, int opts, struct termios *ti);
-- 
1.5.4.5

