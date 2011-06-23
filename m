Return-Path: <cyrus@holtmann.org>
From: Bastien Nocera <hadess@hadess.net>
To: linux-bluetooth@vger.kernel.org
Cc: Bastien Nocera <hadess@hadess.net>
Subject: [PATCH] Add adaptername plugin
Date: Thu, 23 Jun 2011 14:42:33 +0100
Message-Id: <1308836553-12460-1-git-send-email-hadess@hadess.net>
In-Reply-To: <1308742198-6024-3-git-send-email-hadess@hadess.net>
References: <1308742198-6024-3-git-send-email-hadess@hadess.net>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Replacing the name setting code in src/adapter.c.

Moving the adapter naming allows us to use the /etc/machine-info [1]
pretty hostname, as implemented by hostnamed [2] in systemd.

If /etc/machine-info is not present, the adapter name stored
on disk in /var/lib/bluetooth will be used. If no adapter name
has been set yet, the default from the main.conf will be used.

We don't currently number the name of hci0 if a pretty name is
available, but we should instead number it if it happens not
to be the default adapter. As we cannot be told when the default
adapter changes, we'll behave this way for now.

Note that when an adapter name is set automatically from
the pretty hostname, changing it through the D-Bus interface
will fail.

[1]: http://0pointer.de/public/systemd-man/machine-info.html
[2]: http://www.freedesktop.org/wiki/Software/systemd/hostnamed
---
 Makefile.am           |    3 +
 configure.ac          |    4 +
 plugins/adaptername.c |  306 +++++++++++++++++++++++++++++++++++++++++++++++++
 src/adapter.c         |   66 -----------
 4 files changed, 313 insertions(+), 66 deletions(-)
 create mode 100644 plugins/adaptername.c

diff --git a/Makefile.am b/Makefile.am
index c2a6976..ba9a89d 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -218,6 +218,9 @@ EXTRA_DIST += plugins/hal.c plugins/formfactor.c
 builtin_modules += storage
 builtin_sources += plugins/storage.c
 
+builtin_modules += adaptername
+builtin_sources += plugins/adaptername.c
+
 if MAEMO6PLUGIN
 builtin_modules += maemo6
 builtin_sources += plugins/maemo6.c
diff --git a/configure.ac b/configure.ac
index 07b9e55..084ece5 100644
--- a/configure.ac
+++ b/configure.ac
@@ -35,6 +35,10 @@ AC_FUNC_PPOLL
 AC_CHECK_LIB(dl, dlopen, dummy=yes,
 			AC_MSG_ERROR(dynamic linking loader is required))
 
+AC_CHECK_HEADER([sys/inotify.h],
+		[AC_DEFINE([HAVE_SYS_INOTIFY_H], 1,
+			   [Define to 1 if you have <sys/inotify.h>.])],
+			   [AC_MSG_ERROR(inotify headers are required and missing)])
 AC_PATH_DBUS
 AC_PATH_GLIB
 AC_PATH_ALSA
diff --git a/plugins/adaptername.c b/plugins/adaptername.c
new file mode 100644
index 0000000..af4dac8
--- /dev/null
+++ b/plugins/adaptername.c
@@ -0,0 +1,306 @@
+/*
+ *
+ *  BlueZ - Bluetooth protocol stack for Linux
+ *
+ *  Copyright (C) 2011  Red Hat, Inc.
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
+ *  Author: Bastien Nocera <hadess@hadess.net>
+ *
+ */
+
+#ifdef HAVE_CONFIG_H
+#include <config.h>
+#endif
+
+#include <stdlib.h>
+#include <unistd.h>
+#include <errno.h>
+
+#include <glib.h>
+#include <bluetooth/bluetooth.h>
+
+#include "plugin.h"
+#include "hcid.h" /* For main_opts */
+#include "adapter.h"
+#include "manager.h"
+#include "device.h" /* Needed for storage.h */
+#include "storage.h"
+#include "log.h"
+
+#include <sys/inotify.h>
+#define EVENT_SIZE  (sizeof (struct inotify_event))
+#define EVENT_BUF_LEN (1024 * (EVENT_SIZE + 16))
+
+#define MACHINE_INFO_DIR "/etc/"
+#define MACHINE_INFO_FILE "machine-info"
+
+static GIOChannel *inotify = NULL;
+static int watch_fd = -1;
+
+/* This file is part of systemd's hostnamed functionality:
+ * http://0pointer.de/public/systemd-man/machine-info.html
+ * http://www.freedesktop.org/wiki/Software/systemd/hostnamed
+ */
+static char *read_pretty_host_name(void)
+{
+	char *contents, *ret;
+	char **lines;
+	guint i;
+
+	if (g_file_get_contents(MACHINE_INFO_DIR MACHINE_INFO_FILE,
+			&contents, NULL, NULL) == FALSE) {
+		return NULL;
+	}
+	lines = g_strsplit_set(contents, "\r\n", 0);
+	g_free(contents);
+
+	if (lines == NULL)
+		return NULL;
+
+	ret = NULL;
+	for (i = 0; lines[i] != NULL; i++) {
+		if (g_str_has_prefix(lines[i], "PRETTY_HOSTNAME=")) {
+			ret = g_strdup(lines[i] + strlen("PRETTY_HOSTNAME="));
+			break;
+		}
+	}
+
+	g_strfreev(lines);
+
+	return ret;
+}
+
+/*
+ * Device name expansion
+ *   %d - device id
+ *   %h - hostname
+ */
+static char *expand_name(char *dst, int size, char *str, int dev_id)
+{
+	register int sp, np, olen;
+	char *opt, buf[10];
+
+	if (!str || !dst)
+		return NULL;
+
+	sp = np = 0;
+	while (np < size - 1 && str[sp]) {
+		switch (str[sp]) {
+		case '%':
+			opt = NULL;
+
+			switch (str[sp+1]) {
+			case 'd':
+				sprintf(buf, "%d", dev_id);
+				opt = buf;
+				break;
+
+			case 'h':
+				opt = main_opts.host_name;
+				break;
+
+			case '%':
+				dst[np++] = str[sp++];
+				/* fall through */
+			default:
+				sp++;
+				continue;
+			}
+
+			if (opt) {
+				/* substitute */
+				olen = strlen(opt);
+				if (np + olen < size - 1)
+					memcpy(dst + np, opt, olen);
+				np += olen;
+			}
+			sp += 2;
+			continue;
+
+		case '\\':
+			sp++;
+			/* fall through */
+		default:
+			dst[np++] = str[sp++];
+			break;
+		}
+	}
+	dst[np] = '\0';
+	return dst;
+}
+
+static int
+get_default_adapter_id(void)
+{
+	struct btd_adapter *default_adapter;
+	default_adapter = manager_get_default_adapter();
+	if (default_adapter == NULL)
+		return -1;
+	return adapter_get_dev_id(default_adapter);
+}
+
+static int adaptername_probe(struct btd_adapter *adapter)
+{
+	int current_id;
+	char name[MAX_NAME_LENGTH + 1];
+	char *pretty_hostname;
+	bdaddr_t bdaddr;
+
+	current_id = adapter_get_dev_id(adapter);
+
+	pretty_hostname = read_pretty_host_name();
+	if (pretty_hostname != NULL) {
+		int default_adapter;
+
+		default_adapter = get_default_adapter_id();
+
+		/* Allow us to change the name */
+		adapter_set_allow_name_changes(adapter, TRUE);
+
+		/* If it's the first device, let's assume it will
+		 * be the default one, as we're not told when
+		 * the default adapter changes */
+		if (default_adapter < 0)
+			default_adapter = current_id;
+
+		if (default_adapter != current_id) {
+			char *str;
+
+			/* +1 because we don't want an adapter called "Foobar's laptop #0" */
+			str = g_strdup_printf("%s #%d", pretty_hostname, current_id + 1);
+			DBG("Setting name '%s' for device 'hci%d'", str, current_id);
+
+			adapter_update_local_name(adapter, str);
+			g_free(str);
+		} else {
+			DBG("Setting name '%s' for device 'hci%d'", pretty_hostname, current_id);
+			adapter_update_local_name(adapter, pretty_hostname);
+		}
+		g_free(pretty_hostname);
+
+		/* And disable the name change now */
+		adapter_set_allow_name_changes(adapter, FALSE);
+
+		return 0;
+	}
+
+	adapter_set_allow_name_changes(adapter, TRUE);
+	adapter_get_address(adapter, &bdaddr);
+
+	if (read_local_name(&bdaddr, name) < 0)
+		expand_name(name, MAX_NAME_LENGTH, main_opts.name,
+							current_id);
+	DBG("Setting name '%s' for device 'hci%d'", name, current_id);
+	adapter_update_local_name(adapter, name);
+
+	return 0;
+}
+
+static gboolean handle_inotify_cb(GIOChannel *channel,
+		GIOCondition condition, gpointer data)
+{
+	char buf[EVENT_BUF_LEN];
+	GIOStatus err;
+	gsize len, i;
+	gboolean changed;
+
+	changed = FALSE;
+
+	err = g_io_channel_read_chars(channel, buf, EVENT_BUF_LEN, &len, NULL);
+	if (err != G_IO_STATUS_NORMAL) {
+		error("Error reading inotify event: %d\n", err);
+		return FALSE;
+	}
+
+	i = 0;
+	while (i < len) {
+		struct inotify_event *pevent = (struct inotify_event *) &buf[i];
+
+		/* check that it's ours */
+		if (pevent->len &&
+		    pevent->name != NULL &&
+		    strcmp(pevent->name, MACHINE_INFO_FILE) == 0) {
+			changed = TRUE;
+		}
+		i += EVENT_SIZE + pevent->len;
+	}
+
+	if (changed != FALSE) {
+		DBG(MACHINE_INFO_DIR MACHINE_INFO_FILE
+				" changed, changing names for adapters");
+		manager_foreach_adapter((adapter_cb) adaptername_probe, NULL);
+	}
+
+	return TRUE;
+}
+
+static void adaptername_remove(struct btd_adapter *adapter)
+{
+	if (watch_fd >= 0)
+		close(watch_fd);
+	if (inotify != NULL)
+		g_io_channel_shutdown(inotify, FALSE, NULL);
+}
+
+static struct btd_adapter_driver adaptername_driver = {
+	.name	= "adaptername",
+	.probe	= adaptername_probe,
+	.remove	= adaptername_remove,
+};
+
+static int adaptername_init(void)
+{
+	int ret;
+	int inot_fd;
+
+	ret = btd_register_adapter_driver(&adaptername_driver);
+
+	if (ret != 0)
+		return ret;
+
+	inot_fd = inotify_init();
+	if (inot_fd < 0) {
+		error("Failed to setup inotify");
+		return 0;
+	}
+	watch_fd = inotify_add_watch(inot_fd,
+				     MACHINE_INFO_DIR,
+				     IN_CLOSE_WRITE | IN_DELETE | IN_CREATE |
+				     IN_MOVED_FROM | IN_MOVED_TO);
+	if (watch_fd < 0) {
+		error("Failed to setup watch for '%s'",
+		      MACHINE_INFO_DIR);
+		return 0;
+	}
+
+	inotify = g_io_channel_unix_new(inot_fd);
+	g_io_channel_set_close_on_unref(inotify, TRUE);
+	g_io_channel_set_encoding(inotify, NULL, NULL);
+	g_io_channel_set_flags(inotify, G_IO_FLAG_NONBLOCK, NULL);
+	g_io_add_watch(inotify, G_IO_IN, handle_inotify_cb, NULL);
+
+	return 0;
+}
+
+static void adaptername_exit(void)
+{
+	btd_unregister_adapter_driver(&adaptername_driver);
+}
+
+BLUETOOTH_PLUGIN_DEFINE(adaptername, VERSION,
+		BLUETOOTH_PLUGIN_PRIORITY_LOW, adaptername_init, adaptername_exit)
diff --git a/src/adapter.c b/src/adapter.c
index 5420acd..156d534 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -183,64 +183,6 @@ static void dev_info_free(struct remote_dev_info *dev)
 	g_free(dev);
 }
 
-/*
- * Device name expansion
- *   %d - device id
- */
-static char *expand_name(char *dst, int size, char *str, int dev_id)
-{
-	register int sp, np, olen;
-	char *opt, buf[10];
-
-	if (!str || !dst)
-		return NULL;
-
-	sp = np = 0;
-	while (np < size - 1 && str[sp]) {
-		switch (str[sp]) {
-		case '%':
-			opt = NULL;
-
-			switch (str[sp+1]) {
-			case 'd':
-				sprintf(buf, "%d", dev_id);
-				opt = buf;
-				break;
-
-			case 'h':
-				opt = main_opts.host_name;
-				break;
-
-			case '%':
-				dst[np++] = str[sp++];
-				/* fall through */
-			default:
-				sp++;
-				continue;
-			}
-
-			if (opt) {
-				/* substitute */
-				olen = strlen(opt);
-				if (np + olen < size - 1)
-					memcpy(dst + np, opt, olen);
-				np += olen;
-			}
-			sp += 2;
-			continue;
-
-		case '\\':
-			sp++;
-			/* fall through */
-		default:
-			dst[np++] = str[sp++];
-			break;
-		}
-	}
-	dst[np] = '\0';
-	return dst;
-}
-
 int btd_adapter_set_class(struct btd_adapter *adapter, uint8_t major,
 								uint8_t minor)
 {
@@ -2576,14 +2518,6 @@ gboolean adapter_init(struct btd_adapter *adapter)
 		return FALSE;
 	}
 
-	if (read_local_name(&adapter->bdaddr, adapter->name) < 0)
-		expand_name(adapter->name, MAX_NAME_LENGTH, main_opts.name,
-							adapter->dev_id);
-
-	if (main_opts.attrib_server)
-		attrib_gap_set(GATT_CHARAC_DEVICE_NAME,
-			(const uint8_t *) adapter->name, strlen(adapter->name));
-
 	sdp_init_services_list(&adapter->bdaddr);
 	load_drivers(adapter);
 	clear_blocked(adapter);
-- 
1.7.5.4

