Return-Path: <cyrus@holtmann.org>
From: Gustavo Padovan <gustavo@padovan.org>
To: linux-bluetooth@vger.kernel.org
Cc: Gustavo Padovan <gustavo.padovan@collabora.co.uk>
Subject: [PATCH -v2 1/6] bt tool: initial tool handling
Date: Mon,  8 Oct 2012 06:49:52 +0800
Message-Id: <1349650197-18751-1-git-send-email-gustavo@padovan.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Gustavo Padovan <gustavo.padovan@collabora.co.uk>

All core code to using this tool is here, the nexts steps will add
commands like 'discover' 'pair' 'agent', etc.
---
 Makefile.am   |   8 ++
 acinclude.m4  |   6 +
 client/main.c | 421 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 435 insertions(+)
 create mode 100644 client/main.c

diff --git a/Makefile.am b/Makefile.am
index 3b08f9a..2b0bdc5 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -431,6 +431,14 @@ else
 unit_tests =
 endif
 
+if CLIENT
+client_bt_SOURCES = $(gdbus_sources) client/main.c
+
+client_bt_LDADD = lib/libbluetooth-private.la @DBUS_LIBS@ @GLIB_LIBS@
+
+bin_PROGRAMS += client/bt
+endif
+
 TESTS = $(unit_tests)
 
 pkgconfigdir = $(libdir)/pkgconfig
diff --git a/acinclude.m4 b/acinclude.m4
index 4bac3f0..d9fd6ce 100644
--- a/acinclude.m4
+++ b/acinclude.m4
@@ -190,6 +190,7 @@ AC_DEFUN([AC_ARG_BLUEZ], [
 	wiimote_enable=no
 	gatt_enable=no
 	neard_enable=no
+	client_enable=yes
 
 	AC_ARG_ENABLE(optimization, AC_HELP_STRING([--disable-optimization], [disable code optimization]), [
 		optimization_enable=${enableval}
@@ -303,6 +304,10 @@ AC_DEFUN([AC_ARG_BLUEZ], [
 	AC_ARG_ENABLE(neard, AC_HELP_STRING([--enable-neard], [compile with neard plugin]), [
 		neard_enable=${enableval}
 	])
+	AC_ARG_ENABLE(tools, AC_HELP_STRING([--enable-client], [install BlueZ client]), [
+		client_enable=${enableval}
+	])
+
 
 	misc_cflags=""
 	misc_ldflags=""
@@ -356,4 +361,5 @@ AC_DEFUN([AC_ARG_BLUEZ], [
 	AM_CONDITIONAL(GATTMODULES, test "${gatt_enable}" = "yes")
 	AM_CONDITIONAL(HOGPLUGIN, test "${gatt_enable}" = "yes" && test "${input_enable}" = "yes")
 	AM_CONDITIONAL(NEARDPLUGIN, test "${neard_enable}" = "yes")
+	AM_CONDITIONAL(CLIENT, test "${client_enable}" = "yes")
 ])
diff --git a/client/main.c b/client/main.c
new file mode 100644
index 0000000..4edc255
--- /dev/null
+++ b/client/main.c
@@ -0,0 +1,421 @@
+/*
+ *
+ *  BlueZ - Bluetooth protocol stack for Linux
+ *
+ *  Copyright (C) 2004-2010  Marcel Holtmann <marcel@holtmann.org>
+ *  Copyright (C) 2011 Bruno Dilly <bdilly@profusion.mobi>
+ *  Copyright (C) 2011 Gustavo Padovan <gustavo@padovan.org>
+ *  Copyright (C) 2012 Collabora Limited.
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
+/*
+ * This code is meant, in part, to be a working example of a BlueZ client
+ * written in C.
+ *
+ * If you are new to BlueZ, we recommend you read the code breadth-first,
+ * starting with main(). The function and variable names should be fairly
+ * self-explanatory, with comments filling in details along the way.
+ *
+ * You will also want to reference the BlueZ D-Bus API, which is documented in
+ * /doc of this soruce tree, and the libdbus API, documented here:
+ *
+ *   http://dbus.freedesktop.org/doc/api/html/index.html
+ */
+
+#include <config.h>
+#include <stdio.h>
+#include <string.h>
+#include <stdlib.h>
+#include <errno.h>
+
+#include <glib.h>
+
+#include <dbus/dbus.h>
+#include <gdbus.h>
+
+#include <bluetooth/bluetooth.h>
+#include <bluetooth/hci.h>
+#include <bluetooth/hci_lib.h>
+
+#define BLUEZ_SERVICE	"org.bluez"
+#define BLUEZ_MANAGER	"org.bluez.Manager"
+#define BLUEZ_ADAPTER	"org.bluez.Adapter"
+#define BLUEZ_AGENT	"org.bluez.Agent"
+#define BLUEZ_ERROR	"org.bluez.Error"
+
+#define ARRAY_SIZE(x) (int)(sizeof(x)/sizeof(x[0]))
+
+#define ERR(fmt, ...)	fprintf(stderr, fmt "\n", ##__VA_ARGS__)
+
+struct cmd_param {
+	char	*path;
+	int	argc;
+	char	**argv;
+};
+
+struct cmd_struct {
+	const char	*cmd;
+	GSourceFunc	fn;
+};
+
+struct find_adapter_cb_data {
+	GSourceFunc		fn;
+	struct cmd_param	*param;
+};
+
+static GMainLoop *mainloop = NULL;
+static gchar *program_name = NULL;
+
+static bdaddr_t bdaddr;
+static DBusConnection *conn;
+
+static void show_help()
+{
+	printf("usage: %s [-i interface] <command> [<args>]\n"
+	"\n"
+	"options:\n"
+	"	-i <hci dev>, --interface <hci dev>	HCI device\n"
+	"	--help					This help\n"
+	"	--version				Version\n"
+	"\n"
+	"commands:\n"
+	"	discover				Scan for devices\n"
+	"	pair <device address>			Start pairing\n"
+	"	agent					Run BlueZ agent\n"
+							"\n", program_name);
+
+	if(mainloop != NULL)
+		g_main_loop_quit(mainloop);
+}
+
+static struct find_adapter_cb_data *find_adapter_cb_data_new(GSourceFunc fn,
+							struct cmd_param *param)
+{
+	struct find_adapter_cb_data *cb_data;
+
+	cb_data = g_new0(struct find_adapter_cb_data, 1);
+	cb_data->fn = fn;
+	cb_data->param = param;
+
+	return cb_data;
+}
+
+static DBusMessage* create_method_call(const char *adapter_path,
+							const char *interface,
+							const char *method_name)
+{
+	DBusMessage *msg;
+
+	msg = dbus_message_new_method_call(BLUEZ_SERVICE, adapter_path,
+						interface, method_name);
+	if (msg == NULL)
+		ERR("Can't allocate new method call");
+
+	return msg;
+}
+
+/* Utility function to call a D-Bus method and register a notify function to
+ * handle the reply */
+static gboolean send_with_reply_and_set_notify(DBusMessage *msg,
+				DBusPendingCallNotifyFunction notify_func,
+				gpointer user_data,
+				DBusFreeFunction user_data_free)
+{
+	DBusPendingCall *pending;
+	dbus_bool_t success;
+
+	success = dbus_connection_send_with_reply(conn, msg, &pending, -1);
+	if (pending) {
+		dbus_pending_call_set_notify(pending, notify_func, user_data,
+								user_data_free);
+	} else {
+		ERR("D-Bus connection lost before message could be sent");
+		return FALSE;
+	}
+
+	if (!success) {
+		ERR("Not enough memory to send D-Bus message");
+		return FALSE;
+	}
+
+	return TRUE;
+}
+
+static void run_func(const char *adapter_path, GSourceFunc fn,
+							struct cmd_param *param)
+{
+	param->path = strdup(adapter_path);
+
+	/* track timeout source */
+	g_timeout_add(50, fn, param);
+}
+
+/* Handle the D-Bus method reply for FindAdapter or DefaultAdapter */
+static void get_adapter_reply(DBusPendingCall *pending, void *user_data)
+{
+	struct find_adapter_cb_data *cb_data = user_data;
+	DBusMessage *reply;
+	const char *adapter_path;
+
+	if (!pending)
+		return;
+
+	/* We must ensure that this object remains alive while we need it and
+	 * objects it references (such as the reply) */
+	dbus_pending_call_ref(pending);
+
+	/* By "stealing" the reply, we are accepting responsibility to
+	 * unreference it below. Otherwise, its memory will be leaked */
+	reply = dbus_pending_call_steal_reply(pending);
+	if (!reply) {
+		ERR("FindAdapter() failed.");
+		exit(1);
+	}
+
+	/* Ensure that the reply does not indicate an error */
+	if (dbus_message_get_type(reply) == DBUS_MESSAGE_TYPE_ERROR) {
+		ERR("FindAdapter() failed");
+		exit(1);
+	} else {
+		struct DBusError err;
+		dbus_error_init(&err);
+
+		if (!dbus_message_get_args(reply, &err,
+					DBUS_TYPE_OBJECT_PATH, &adapter_path,
+					DBUS_TYPE_INVALID)) {
+			/* Ensure that there was not an error retrieving the
+			 * reply arguments */
+			if (dbus_error_is_set(&err)) {
+				ERR("FindAdapter() failed: %s", err.message);
+				dbus_error_free(&err);
+			} else {
+				ERR("FindAdapter() failed.");
+			}
+			exit(1);
+		}
+	}
+
+	/* In case we successfully retrieved the adapter object, execute our
+	 * core command using its path */
+	if (adapter_path != NULL && strlen(adapter_path) > 0) {
+		run_func(adapter_path, cb_data->fn, cb_data->param);
+	} else {
+		ERR("No such adapter");
+		exit(1);
+	}
+
+	/* Drop our references to these objects to avoid memory leaks */
+	dbus_message_unref(reply);
+	dbus_pending_call_unref(pending);
+}
+
+/* Looks up the adapter D-Bus object which corresponds to the Bluetooth device
+ * we will use (whether the user specified one or we fall back to the default.
+ *
+ * Once we have that object, we execute the core command. */
+static void get_adapter_and_run_func(GSourceFunc fn, struct cmd_param *param)
+{
+	DBusMessage *msg;
+	char *bt_str = NULL;
+	const char *method_name = NULL;
+	gpointer user_data;
+
+	/* The bacmp(), ba2str(), and other Bluetooth address utilities are
+	 * defined in bluetooth.h, in this source tree */
+	if (!bacmp(&bdaddr, BDADDR_ANY)) {
+		method_name = "DefaultAdapter";
+	} else {
+		method_name = "FindAdapter";
+
+		/* Allocate a string large enough for the biggest BT address */
+		bt_str = g_new(char, 18);
+		ba2str(&bdaddr, bt_str);
+	}
+
+	/* Create a new D-Bus method call */
+	if (!(msg = create_method_call("/", BLUEZ_MANAGER, method_name)))
+		exit(1);
+
+	/* In case we're making the FindAdapter D-Bus method call, we need to
+	 * append a method argument */
+	if (bt_str != NULL)
+		dbus_message_append_args(msg, DBUS_TYPE_STRING, &bt_str,
+							DBUS_TYPE_INVALID);
+
+	/* Finally, we need to asynchronously send and receive a response for
+	 * the D-Bus method call. This function does not block at all. Instead,
+	 * the GMainLoop will continue iterating until we get a response, which
+	 * will be passed to the notify function we specify here.
+	 *
+	 * We use only async D-Bus messaging because some of these D-Bus methods
+	 * could potentially take several seconds to complete, In the meantime,
+	 * if we were blocking, our application would be unresponsive and look
+	 * as if it (or * even the entire system upon which it is running) had
+	 * frozen. */
+	user_data = find_adapter_cb_data_new(fn, param);
+	if (!send_with_reply_and_set_notify(msg,  get_adapter_reply, user_data,
+									g_free))
+		exit(1);
+
+	dbus_message_unref(msg);
+}
+
+static void bluetoothd_disconnect(DBusConnection *conn, void *user_data)
+{
+	g_main_loop_quit(mainloop);
+
+	printf("Bluetooth daemon exited.\n");
+
+}
+
+static struct cmd_struct commands[] = {
+	{ NULL, NULL},
+};
+
+/* Returns FALSE in case the command could not be parsed. Any failures during
+ * execution will be handled later */
+static gboolean run_argv(int argc, char **argv)
+{
+	const char *cmd = argv[0];
+	struct cmd_param *param;
+	int i;
+
+	if (argc > 1 && g_str_equal(argv[1], "--help"))
+		cmd = "help";
+
+	for (i = 0; i < ARRAY_SIZE(commands); i++) {
+		struct cmd_struct *p = commands+i;
+		if (cmd == NULL || !g_str_equal(p->cmd, cmd))
+			continue;
+
+		param = malloc(sizeof(*param));
+		if (!param)
+			exit(1);
+
+		/* skip over the name of this program itself */
+		argc--;
+		argv++;
+
+		param->argc = argc;
+		param->argv = argv;
+
+		get_adapter_and_run_func(p->fn, param);
+		return TRUE;
+	}
+
+	return FALSE;
+}
+
+static gboolean handle_options(int *argc, char ***argv)
+{
+	gboolean terminal_opt = FALSE;
+
+	bacpy(&bdaddr, BDADDR_ANY);
+
+	while (*argc > 0) {
+		const char *cmd = (*argv)[0];
+		if (cmd != NULL && cmd[0] != '-')
+			break;
+
+		if (g_str_equal(cmd, "--help") ||
+						g_str_equal(cmd, "--version")) {
+			terminal_opt = TRUE;
+			break;
+		}
+
+		/*
+		 * Check remaining flags.
+		 */
+		if(g_str_equal(cmd, "-i") || g_str_equal(cmd, "--interface")) {
+			const char *iface;
+			(*argv)++;
+			(*argc)--;
+			iface = (*argv)[0];
+			if (!strncasecmp(iface, "hci", 3))
+				hci_devba(atoi(iface + 3), &bdaddr);
+			else
+				str2ba(iface, &bdaddr);
+		}
+
+		(*argv)++;
+		(*argc)--;
+	}
+
+	return terminal_opt;
+}
+
+int main(int argc, char **argv)
+{
+	DBusError err;
+	gboolean terminal_opt;
+
+	program_name = g_strdup(argv[0]);
+
+	argv++;
+	argc--;
+	terminal_opt = handle_options(&argc, &argv);
+
+	if (terminal_opt) {
+		if (g_str_equal(argv[0], "--help"))
+			show_help();
+		else if (g_str_equal(argv[0], "--version"))
+			printf("%s\n", VERSION);
+
+		exit(0);
+	}
+
+	mainloop = g_main_loop_new(NULL, FALSE);
+
+	/* This structure must be initialized before it can be used */
+	dbus_error_init(&err);
+
+	/* Set up our connection to the D-Bus system bus, which we will use
+	 * throughout this code.
+	 *
+	 * NOTE: the "g_dbus" namespace used in this file is due to BlueZ's
+	 * internal "gdbus" D-Bus client library (included by gdbus.h), which is
+	 * not to be confused with libgio's D-Bus client functionality with the
+	 * same namespace (which would be included by gio.h) */
+	conn = g_dbus_setup_bus(DBUS_BUS_SYSTEM, NULL, &err);
+	if (!conn) {
+		if (dbus_error_is_set(&err)) {
+			ERR("Can't connect to system bus: %s", err.message);
+			dbus_error_free(&err);
+		} else {
+			ERR("Can't connect to system bus");
+		}
+
+		exit(1);
+	}
+
+	/* Run the command given in the command line */
+	if (!run_argv(argc, argv)) {
+		ERR("%s: command not understood.", program_name);
+		show_help();
+		exit(1);
+	}
+
+	/* Set up handler in case the bluetooth daemon exits and it disappears
+	 * from the bus */
+	g_dbus_add_service_watch(conn, BLUEZ_SERVICE, NULL,
+					bluetoothd_disconnect, NULL, NULL);
+
+	g_main_loop_run(mainloop);
+
+	return 0;
+}
-- 
1.7.11.4

