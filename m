Return-Path: <cyrus@holtmann.org>
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Anderson Lizardo <anderson.lizardo@openbossa.org>
Subject: [PATCH BlueZ 2/4] Remove unused/broken "echo" RFCOMM plugin
Date: Fri, 30 Dec 2011 15:26:09 -0400
Message-Id: <1325273171-24698-2-git-send-email-anderson.lizardo@openbossa.org>
In-Reply-To: <1325273171-24698-1-git-send-email-anderson.lizardo@openbossa.org>
References: <1325273171-24698-1-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

It was disabled for quite some time (since 2009), and does not even
compile anymore if enabled:

plugins/echo.c: In function 'session_event':
plugins/echo.c:53: error: implicit declaration of function
'g_io_channel_read'
plugins/echo.c:57: error: implicit declaration of function
'g_io_channel_write'
---
 Makefile.am    |    5 --
 acinclude.m4   |    1 -
 plugins/echo.c |  167 --------------------------------------------------------
 3 files changed, 0 insertions(+), 173 deletions(-)
 delete mode 100644 plugins/echo.c

diff --git a/Makefile.am b/Makefile.am
index 8bc6cfe..102ee62 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -131,11 +131,6 @@ builtin_modules += pnat
 builtin_sources += plugins/pnat.c
 endif
 
-if ECHOPLUGIN
-builtin_modules += echo
-builtin_sources += plugins/echo.c
-endif
-
 if AUDIOPLUGIN
 builtin_modules += audio
 builtin_sources += audio/main.c \
diff --git a/acinclude.m4 b/acinclude.m4
index e86823a..4c72fee 100644
--- a/acinclude.m4
+++ b/acinclude.m4
@@ -415,7 +415,6 @@ AC_DEFUN([AC_ARG_BLUEZ], [
 	AM_CONDITIONAL(HAL, test "${hal_enable}" = "yes")
 	AM_CONDITIONAL(READLINE, test "${readline_found}" = "yes")
 	AM_CONDITIONAL(GATT_EXAMPLE_PLUGIN, test "${gatt_example_enable}" = "yes")
-	AM_CONDITIONAL(ECHOPLUGIN, test "no" = "yes")
 	AM_CONDITIONAL(PNATPLUGIN, test "${pnat_enable}" = "yes")
 	AM_CONDITIONAL(TRACER, test "${tracer_enable}" = "yes")
 	AM_CONDITIONAL(HIDD, test "${hidd_enable}" = "yes")
diff --git a/plugins/echo.c b/plugins/echo.c
deleted file mode 100644
index 23f6e49..0000000
--- a/plugins/echo.c
+++ /dev/null
@@ -1,167 +0,0 @@
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
-#include <unistd.h>
-#include <sys/socket.h>
-
-#include <bluetooth/bluetooth.h>
-#include <bluetooth/rfcomm.h>
-
-#include <glib.h>
-
-#include <gdbus.h>
-
-#include "plugin.h"
-#include "adapter.h"
-#include "log.h"
-
-static gboolean session_event(GIOChannel *chan,
-					GIOCondition cond, gpointer data)
-{
-	unsigned char buf[672];
-	gsize len, written;
-	GIOError err;
-
-	if (cond & (G_IO_HUP | G_IO_ERR | G_IO_NVAL))
-		return FALSE;
-
-	err = g_io_channel_read(chan, (gchar *) buf, sizeof(buf), &len);
-	if (err == G_IO_ERROR_AGAIN)
-		return TRUE;
-
-	g_io_channel_write(chan, (const gchar *) buf, len, &written);
-
-	return TRUE;
-}
-
-static gboolean connect_event(GIOChannel *chan,
-					GIOCondition cond, gpointer data)
-{
-	GIOChannel *io;
-	struct sockaddr_rc addr;
-	socklen_t optlen;
-	char address[18];
-	int sk, nsk;
-
-	sk = g_io_channel_unix_get_fd(chan);
-
-	memset(&addr, 0, sizeof(addr));
-	optlen = sizeof(addr);
-
-	nsk = accept(sk, (struct sockaddr *) &addr, &optlen);
-	if (nsk < 0)
-		return TRUE;
-
-	io = g_io_channel_unix_new(nsk);
-	g_io_channel_set_close_on_unref(io, TRUE);
-
-	ba2str(&addr.rc_bdaddr, address);
-
-	g_io_add_watch(io, G_IO_IN | G_IO_HUP | G_IO_ERR | G_IO_NVAL,
-							session_event, NULL);
-
-	return TRUE;
-}
-
-static GIOChannel *setup_rfcomm(uint8_t channel)
-{
-	GIOChannel *io;
-	struct sockaddr_rc addr;
-	int sk;
-
-	sk = socket(PF_BLUETOOTH, SOCK_STREAM, BTPROTO_RFCOMM);
-	if (sk < 0)
-		return NULL;
-
-	memset(&addr, 0, sizeof(addr));
-	addr.rc_family = AF_BLUETOOTH;
-	bacpy(&addr.rc_bdaddr, BDADDR_ANY);
-	addr.rc_channel = channel;
-
-	if (bind(sk, (struct sockaddr *) &addr, sizeof(addr)) < 0) {
-		close(sk);
-		return NULL;
-	}
-
-	if (listen(sk, 10) < 0) {
-		close(sk);
-		return NULL;
-	}
-
-	io = g_io_channel_unix_new(sk);
-	g_io_channel_set_close_on_unref(io, TRUE);
-
-	g_io_add_watch(io, G_IO_IN, connect_event, NULL);
-
-	return io;
-}
-
-static GIOChannel *chan = NULL;
-
-static int echo_probe(struct btd_adapter *adapter)
-{
-	const char *path = adapter_get_path(adapter);
-
-	DBG("path %s", path);
-
-	chan = setup_rfcomm(23);
-
-	return 0;
-}
-
-static void echo_remove(struct btd_adapter *adapter)
-{
-	const char *path = adapter_get_path(adapter);
-
-	DBG("path %s", path);
-
-	g_io_channel_unref(chan);
-}
-
-static struct btd_adapter_driver echo_server = {
-	.name	= "echo-server",
-	.probe	= echo_probe,
-	.remove	= echo_remove,
-};
-
-static int echo_init(void)
-{
-	DBG("Setup echo plugin");
-
-	return btd_register_adapter_driver(&echo_server);
-}
-
-static void echo_exit(void)
-{
-	DBG("Cleanup echo plugin");
-
-	btd_unregister_adapter_driver(&echo_server);
-}
-
-BLUETOOTH_PLUGIN_DEFINE(echo, VERSION,
-		BLUETOOTH_PLUGIN_PRIORITY_DEFAULT, echo_init, echo_exit)
-- 
1.7.0.4

