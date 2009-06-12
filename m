Return-Path: <cyrus@holtmann.org>
Subject: [PATCH] Draft of xdg-hostname support
From: Bastien Nocera <hadess@hadess.net>
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: multipart/mixed; boundary="=-kQyX0SCSPx2x4z4Pycst"
Date: Fri, 12 Jun 2009 15:47:23 +0100
Message-Id: <1244818043.3280.392.camel@snoogens.fab.redhat.com>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>


--=-kQyX0SCSPx2x4z4Pycst
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

Hey,

xdg-hostname[1] is a D-Bus service that offers notification on hostname
changes, and provides an additional "Display hostname" (think MacOS X'
and Windows' "computer name").

This would allow us to call adapters something like:
Bastien's laptop
rather than:
dhcp-1-124-1

The code is a first pass at the problem, and won't even run, but will
compile. I'm thinking about changing that code, and I'm looking for
hints on the direction (rather than comments on the dependencies or the
coding style).

I'm thinking:
- Make expand_name UTF-8 aware
- Factor the main_opts.hostname setting code, and make it pluggable
(hints?)
- Change the device name when the display name or hostname changes
(would need to get added to the hciops plugin)

Comments? Ideas?

[1]: See
https://fedoraproject.org/wiki/Desktop/Whiteboards/BetterHostname
http://people.freedesktop.org/~david/xdg-hostname.png
http://cgit.freedesktop.org/~david/xdg-hostname/

--=-kQyX0SCSPx2x4z4Pycst
Content-Disposition: attachment; filename="0001-Add-draft-xdg-hostname-plugin.patch"
Content-Type: text/x-patch; name="0001-Add-draft-xdg-hostname-plugin.patch"; charset="UTF-8"
Content-Transfer-Encoding: 7bit

>From ac801a01e01e50eb182ffb6bc33c09e0438bfae1 Mon Sep 17 00:00:00 2001
From: Bastien Nocera <hadess@hadess.net>
Date: Fri, 12 Jun 2009 15:19:17 +0100
Subject: [PATCH] Add draft xdg-hostname plugin

Use xdg-hostname's "display name" as the default name for the
adapters.
---
 acinclude.m4        |   12 +++++
 configure.ac        |    1 +
 plugins/Makefile.am |    8 +++
 plugins/hostname.c  |  128 +++++++++++++++++++++++++++++++++++++++++++++++++++
 src/plugin.c        |    8 ++--
 5 files changed, 153 insertions(+), 4 deletions(-)
 create mode 100644 plugins/hostname.c

diff --git a/acinclude.m4 b/acinclude.m4
index eb7cdeb..34a62ca 100644
--- a/acinclude.m4
+++ b/acinclude.m4
@@ -171,6 +171,12 @@ AC_DEFUN([AC_PATH_SNDFILE], [
 	AC_SUBST(SNDFILE_LIBS)
 ])
 
+AC_DEFUN([AC_PATH_XDG_HOSTNAME], [
+	PKG_CHECK_MODULES(XDG_HOSTNAME, xdg-hostname-gobject-1, xdg_hostname_found=yes, xdg_hostname_found=no)
+	AC_SUBST(XDG_HOSTNAME_CFLAGS)
+	AC_SUBST(XDG_HOSTNAME_LIBS)
+])
+
 AC_DEFUN([AC_ARG_BLUEZ], [
 	debug_enable=no
 	fortify_enable=yes
@@ -181,6 +187,7 @@ AC_DEFUN([AC_ARG_BLUEZ], [
 	usb_enable=${usb_found}
 	alsa_enable=${alsa_found}
 	gstreamer_enable=${gstreamer_found}
+	xdg_hostname_enable=${xdg_hostname_found}
 	audio_enable=yes
 	input_enable=yes
 	serial_enable=yes
@@ -233,6 +240,10 @@ AC_DEFUN([AC_ARG_BLUEZ], [
 		gstreamer_enable=${enableval}
 	])
 
+	AC_ARG_ENABLE(xdg-hostname, AC_HELP_STRING([--enable-xdg-hostname], [enable xdg-hostname support]), [
+		xdg_hostname_enable=${enableval}
+	])
+
 	AC_ARG_ENABLE(alsa, AC_HELP_STRING([--enable-alsa], [enable ALSA support]), [
 		alsa_enable=${enableval}
 	])
@@ -339,6 +350,7 @@ AC_DEFUN([AC_ARG_BLUEZ], [
 	AM_CONDITIONAL(SBC, test "${alsa_enable}" = "yes" || test "${gstreamer_enable}" = "yes")
 	AM_CONDITIONAL(ALSA, test "${alsa_enable}" = "yes" && test "${alsa_found}" = "yes")
 	AM_CONDITIONAL(GSTREAMER, test "${gstreamer_enable}" = "yes" && test "${gstreamer_found}" = "yes")
+	AM_CONDITIONAL(XDG_HOSTNAME, test "${xdg_hostname_enable}" = "yes" && test "${xdg_hostname_found}" = "yes")
 	AM_CONDITIONAL(AUDIOPLUGIN, test "${audio_enable}" = "yes")
 	AM_CONDITIONAL(INPUTPLUGIN, test "${input_enable}" = "yes")
 	AM_CONDITIONAL(SERIALPLUGIN, test "${serial_enable}" = "yes")
diff --git a/configure.ac b/configure.ac
index da930e5..7f5faba 100644
--- a/configure.ac
+++ b/configure.ac
@@ -38,6 +38,7 @@ AC_PATH_GSTREAMER
 AC_PATH_USB
 AC_PATH_NETLINK
 AC_PATH_SNDFILE
+AC_PATH_XDG_HOSTNAME
 
 AC_ARG_BLUEZ
 
diff --git a/plugins/Makefile.am b/plugins/Makefile.am
index 9d9f970..1279116 100644
--- a/plugins/Makefile.am
+++ b/plugins/Makefile.am
@@ -20,6 +20,12 @@ plugin_LTLIBRARIES += netlink.la
 netlink_la_LIBADD = @NETLINK_LIBS@
 endif
 
+if XDG_HOSTNAME
+plugin_LTLIBRARIES += hostname.la
+hostname_la_LIBADD = @XDG_HOSTNAME_LIBS@
+hostname_la_CFLAGS = $(XDG_HOSTNAME_CFLAGS) $(DBUS_CFLAGS)
+endif
+
 builtin_modules += hal
 builtin_sources += hal.c
 
@@ -63,9 +69,11 @@ all-local:
 	@$(LN_S) -f $(top_srcdir)/audio/.libs/audio.so
 	@$(LN_S) -f $(top_srcdir)/serial/.libs/serial.so
 	@$(LN_S) -f $(top_srcdir)/network/.libs/network.so
+	@$(LN_S) -f $(top_srcdir)/plugins/.libs/hostname.so
 
 clean-local:
 	@rm -f network.so
 	@rm -f serial.so
 	@rm -f audio.so
 	@rm -f input.so
+	@rm -f hostname.so
diff --git a/plugins/hostname.c b/plugins/hostname.c
new file mode 100644
index 0000000..3b5b2cb
--- /dev/null
+++ b/plugins/hostname.c
@@ -0,0 +1,128 @@
+/*
+ *
+ *  BlueZ - Bluetooth protocol stack for Linux
+ *
+ *  Copyright (C) 2004-2009  Marcel Holtmann <marcel@holtmann.org>
+ *  Copyright (C) 2009       Bastien Nocera <hadess@hadess.net>
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
+#include <xdg-hostname/xdg-hostname.h>
+
+#include <dbus/dbus.h>
+#include <bluetooth/bluetooth.h>
+#include <bluetooth/hci.h>
+#include <bluetooth/hci_lib.h>
+
+#include "hcid.h"
+#include "plugin.h"
+#include "manager.h"
+#include "adapter.h"
+#include "logging.h"
+
+static XdgHostnameMonitor *monitor = NULL;
+static char *display_hostname = NULL;
+static char *hostname = NULL;
+
+static char *compute_hostname(guint index)
+{
+	if (index == 0)
+		return g_strdup (display_hostname ? display_hostname : hostname);
+	return g_strdup ("%s %d", display_hostname ? display_hostname : hostname, index);
+}
+
+static int hostname_probe(struct btd_adapter *adapter)
+{
+	if (display_hostname == NULL &&
+	    hostname == NULL)
+	    	return 0;
+
+	//FIXME get index for that adapter from somewhere
+	s = compute_hostname(0);
+	adapter_name_changed(adapter, s);
+	g_free(s);
+
+	return 0;
+}
+
+static struct btd_adapter_driver hostname_driver = {
+	.name	= "hostname",
+	.probe	= hostname_probe,
+};
+
+static void monitor_changed(XdgHostnameMonitor *monitor, gpointer user_data)
+{
+	GSList *list, *l;
+	guint i;
+	char *s;
+
+	g_free (display_hostname);
+	g_free (hostname);
+	g_object_get (G_OBJECT (monitor),
+		      "display-hostname", &display_hostname,
+		      "hostname", &hostname,
+		      NULL);
+
+	if (display_hostname == NULL &&
+	    hostname == NULL)
+	    	return;
+
+	list = manager_get_adapters();
+	for (l = list, i = 0; l != NULL; l = l->next, i++) {
+		struct btd_adapter *adapter = (struct btd_adapter *) l->data;
+		char *s = compute_hostname(i);
+
+		adapter_name_changed(adapter, i);
+		g_free (s);
+	}
+	g_slist_free(list);
+}
+
+static int hostname_init(void)
+{
+	XdgHostnameMonitor *monitor;
+
+	g_type_init();
+
+	monitor = xdg_hostname_monitor_get ();
+	g_signal_connect (G_OBJECT (monitor), "changed",
+			  G_CALLBACK (monitor_changed), NULL);
+	monitor_changed(monitor, NULL);
+
+	return btd_register_adapter_driver(&hostname_driver);
+}
+
+static void hostname_exit(void)
+{
+	if (monitor != NULL) {
+		g_object_unref (monitor);
+		monitor = NULL;
+	}
+	g_free (display_hostname);
+	g_free (hostname);
+
+	btd_unregister_adapter_driver(&hostname_driver);
+}
+
+BLUETOOTH_PLUGIN_DEFINE(hostname, VERSION,
+		BLUETOOTH_PLUGIN_PRIORITY_LOW, hostname_init, hostname_exit)
diff --git a/src/plugin.c b/src/plugin.c
index a57bf2c..4b752a8 100644
--- a/src/plugin.c
+++ b/src/plugin.c
@@ -116,7 +116,7 @@ gboolean plugin_init(GKeyFile *config)
 	gchar **disabled;
 	unsigned int i;
 
-	if (strlen(PLUGINDIR) == 0)
+	if (strlen("../plugins") == 0)
 		return FALSE;
 
 	/* Make a call to BtIO API so its symbols got resolved before the
@@ -140,9 +140,9 @@ gboolean plugin_init(GKeyFile *config)
 		add_plugin(NULL,  __bluetooth_builtin[i]);
 	}
 
-	debug("Loading plugins %s", PLUGINDIR);
+	debug("Loading plugins %s", "../plugins");
 
-	dir = g_dir_open(PLUGINDIR, 0, NULL);
+	dir = g_dir_open("../plugins", 0, NULL);
 	if (!dir) {
 		g_strfreev(disabled);
 		return FALSE;
@@ -161,7 +161,7 @@ gboolean plugin_init(GKeyFile *config)
 		if (disabled && is_disabled(file, disabled))
 			continue;
 
-		filename = g_build_filename(PLUGINDIR, file, NULL);
+		filename = g_build_filename("../plugins", file, NULL);
 
 		if (stat(filename, &st) < 0) {
 			error("Can't find plugin %s: %s", filename,
-- 
1.6.2.2


--=-kQyX0SCSPx2x4z4Pycst--

