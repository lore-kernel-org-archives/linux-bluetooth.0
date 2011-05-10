Return-Path: <cyrus@holtmann.org>
Subject: Re: RFC: First pass at pretty hostname support
From: Bastien Nocera <hadess@hadess.net>
To: BlueZ development <linux-bluetooth@vger.kernel.org>
Date: Tue, 10 May 2011 18:10:01 +0100
In-Reply-To: <1304751384.2427.5.camel@novo.hadess.net>
References: <1304701117.16101.40.camel@novo.hadess.net>
	 <1304751384.2427.5.camel@novo.hadess.net>
Content-Type: multipart/mixed; boundary="=-n3v/m0TH6z/fJIxC0kK8"
Message-ID: <1305047402.2427.77.camel@novo.hadess.net>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>


--=-n3v/m0TH6z/fJIxC0kK8
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit

On Sat, 2011-05-07 at 07:56 +0100, Bastien Nocera wrote:
> On Fri, 2011-05-06 at 17:58 +0100, Bastien Nocera wrote:
> > Most of the details are in the patch.
> > 
> > I just wanted to mention that:
> > "Bastien's desktop": good
> > "novo-0": bad
> > 
> > Ideas on how to implement the TODO items would be appreciated. I'm
> > currently thinking that a plugin to monitor the pretty hostname would be
> > the cleaner way. It would even allow us to change the adapter name on
> > the fly if the hostname (rather than the pretty hostname) changed.
> > 
> > Cheers
> 
> And with the correct patch...

Another pass at it, moving all that code into a plugin (untested).

Things that still need working on:
- some sort of callback when the default adapter changes (I'd like the
unmodified pretty hostname to always be attached to the default adapter)
- updating the hostname when /etc/machine-info changes (or is removed,
etc.). Having to use raw inotify for this would be a pain though.

Comments?

Cheers

--=-n3v/m0TH6z/fJIxC0kK8
Content-Disposition: attachment;
	filename="0001-adaptername-Move-adapter-naming-into-a-plugin.patch"
Content-Type: text/x-patch;
	name="0001-adaptername-Move-adapter-naming-into-a-plugin.patch";
	charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit

>From a23592fed14430483cccf6eca644da4486dffb0a Mon Sep 17 00:00:00 2001
From: Bastien Nocera <hadess@hadess.net>
Date: Tue, 10 May 2011 18:02:14 +0100
Subject: [PATCH] adaptername: Move adapter naming into a plugin

Moving the adapter naming allows us to use the /etc/machine-info [1]
pretty hostname, as implemented by hostnamed [2] in systemd.

If /etc/machine-info is not present, the adapter name stored
on disk in /var/lib/bluetooth will be used. If no adapter name
has been set yet, the default from the main.conf will be used.

[1]: http://0pointer.de/public/systemd-man/machine-info.html
[2]: http://www.freedesktop.org/wiki/Software/systemd/hostnamed

TODO:
* Changing the adapter name when the default changes
* Monitoring /etc/machine-info to change an existing name
---
 Makefile.am           |    3 +
 plugins/adaptername.c |  200 +++++++++++++++++++++++++++++++++++++++++++++++++
 src/adapter.c         |   66 ----------------
 src/manager.c         |    5 +
 src/manager.h         |    1 +
 5 files changed, 209 insertions(+), 66 deletions(-)
 create mode 100644 plugins/adaptername.c

diff --git a/Makefile.am b/Makefile.am
index caffbe2..fe24883 100644
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
diff --git a/plugins/adaptername.c b/plugins/adaptername.c
new file mode 100644
index 0000000..8696c5a
--- /dev/null
+++ b/plugins/adaptername.c
@@ -0,0 +1,200 @@
+/*
+ *
+ *  BlueZ - Bluetooth protocol stack for Linux
+ *
+ *  Copyright (C) 2004-2010  Marcel Holtmann <marcel@holtmann.org>
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
+#include <stdlib.h>
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
+/* This file is part of systemd's hostnamed functionality:
+ * http://0pointer.de/public/systemd-man/machine-info.html
+ * http://www.freedesktop.org/wiki/Software/systemd/hostnamed
+ */
+static char *read_pretty_host_name (void)
+{
+	char *contents, *ret;
+	char **lines;
+	guint i;
+
+	ret = NULL;
+
+	if (g_file_get_contents("/etc/machine-info",
+			&contents, NULL, NULL) == FALSE) {
+		return NULL;
+	}
+	lines = g_strsplit_set(contents, "\r\n", 0);
+	g_free(contents);
+
+	if (lines == NULL)
+		return NULL;
+
+	for (i = 0; lines[i] != NULL; i++) {
+		if (g_str_has_prefix(lines[i], "PRETTY_HOSTNAME=")) {
+			ret = g_strdup(lines[i] + strlen("PRETTY_HOSTNAME="));
+			break;
+		}
+	}
+
+	g_strfreev(lines);
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
+static int adaptername_probe(struct btd_adapter *adapter)
+{
+	int current_id;
+	char name[MAX_NAME_LENGTH + 1];
+	char *pretty_hostname;
+	bdaddr_t bdaddr;
+
+	current_id = adapter_get_dev_id (adapter);
+
+	pretty_hostname = read_pretty_host_name ();
+	if (pretty_hostname != NULL) {
+		int default_adapter;
+
+		default_adapter = manager_get_default_adapter ();
+
+		if (default_adapter != current_id) {
+			char *str;
+
+			/* +1 because we don't want an adapter called "Foobar's laptop #0" */
+			str = g_strdup_printf ("%s #%d", pretty_hostname, current_id + 1);
+			DBG("Setting '%s' for device name", str);
+
+			adapter_update_local_name (adapter, str);
+			g_free (str);
+		} else {
+			DBG("Setting '%s' for device name", pretty_hostname);
+			adapter_update_local_name (adapter, pretty_hostname);
+		}
+		g_free (pretty_hostname);
+
+		return 0;
+	}
+
+	adapter_get_address (adapter, &bdaddr);
+
+	if (read_local_name(&bdaddr, name) < 0) {
+		expand_name(name, MAX_NAME_LENGTH, main_opts.name,
+							current_id);
+	}
+	DBG("Setting '%s' for device name", name);
+	adapter_update_local_name (adapter, name);
+
+	return 0;
+}
+
+static void adaptername_remove(struct btd_adapter *adapter)
+{
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
+	return btd_register_adapter_driver(&adaptername_driver);
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
index 76fc01b..a40d104 100644
--- a/src/adapter.c
+++ b/src/adapter.c
@@ -181,64 +181,6 @@ static void dev_info_free(struct remote_dev_info *dev)
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
@@ -2580,14 +2522,6 @@ gboolean adapter_init(struct btd_adapter *adapter)
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
diff --git a/src/manager.c b/src/manager.c
index e805e0c..dedec8b 100644
--- a/src/manager.c
+++ b/src/manager.c
@@ -288,6 +288,11 @@ static void manager_remove_adapter(struct btd_adapter *adapter)
 		btd_start_exit_timer();
 }
 
+int manager_get_default_adapter (void)
+{
+	return default_adapter_id;
+}
+
 void manager_cleanup(DBusConnection *conn, const char *path)
 {
 	g_slist_foreach(adapters, (GFunc) manager_remove_adapter, NULL);
diff --git a/src/manager.h b/src/manager.h
index 05c38b3..90d3690 100644
--- a/src/manager.h
+++ b/src/manager.h
@@ -41,3 +41,4 @@ struct btd_adapter *btd_manager_register_adapter(int id);
 int btd_manager_unregister_adapter(int id);
 void manager_add_adapter(const char *path);
 void btd_manager_set_did(uint16_t vendor, uint16_t product, uint16_t version);
+int manager_get_default_adapter (void);
-- 
1.7.5.1


--=-n3v/m0TH6z/fJIxC0kK8--

