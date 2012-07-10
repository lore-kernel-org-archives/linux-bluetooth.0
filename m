Return-Path: <cyrus@holtmann.org>
From: Gustavo Padovan <gustavo@padovan.org>
To: linux-bluetooth@vger.kernel.org
Cc: Gustavo Padovan <gustavo.padovan@collabora.co.uk>
Subject: [PATCH -v3 8/9] plugins: remove unmaintained plugins
Date: Tue, 10 Jul 2012 11:03:07 -0300
Message-Id: <1341928988-5116-8-git-send-email-gustavo@padovan.org>
In-Reply-To: <1341928988-5116-1-git-send-email-gustavo@padovan.org>
References: <1341928988-5116-1-git-send-email-gustavo@padovan.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Gustavo Padovan <gustavo.padovan@collabora.co.uk>

---
 Makefile.am         |   15 --
 acinclude.m4        |   18 --
 bootstrap-configure |    2 -
 plugins/hal.c       |  144 --------------
 plugins/maemo6.c    |  283 ---------------------------
 plugins/pnat.c      |  526 ---------------------------------------------------
 6 files changed, 988 deletions(-)
 delete mode 100644 plugins/hal.c
 delete mode 100644 plugins/maemo6.c
 delete mode 100644 plugins/pnat.c

diff --git a/Makefile.am b/Makefile.am
index b445160..d093a7f 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -132,11 +132,6 @@ mcap_sources += profiles/health/mcap_lib.h profiles/health/mcap_internal.h \
 		profiles/health/mcap_sync.c
 endif
 
-if PNATPLUGIN
-builtin_modules += pnat
-builtin_sources += plugins/pnat.c
-endif
-
 if AUDIOPLUGIN
 builtin_modules += audio
 builtin_sources += audio/main.c \
@@ -244,13 +239,8 @@ builtin_sources += profiles/thermometer/main.c \
 			profiles/deviceinfo/deviceinfo.c
 endif
 
-if HAL
-builtin_modules += hal
-builtin_sources += plugins/hal.c
-else
 builtin_modules += formfactor
 builtin_sources += plugins/formfactor.c
-endif
 
 EXTRA_DIST += plugins/hal.c plugins/formfactor.c
 
@@ -265,11 +255,6 @@ builtin_modules += wiimote
 builtin_sources += plugins/wiimote.c
 endif
 
-if MAEMO6PLUGIN
-builtin_modules += maemo6
-builtin_sources += plugins/maemo6.c
-endif
-
 if DBUSOOBPLUGIN
 builtin_modules += dbusoob
 builtin_sources += plugins/dbusoob.c
diff --git a/acinclude.m4 b/acinclude.m4
index 842eea3..39b0a18 100644
--- a/acinclude.m4
+++ b/acinclude.m4
@@ -167,7 +167,6 @@ AC_DEFUN([AC_ARG_BLUEZ], [
 	fortify_enable=yes
 	pie_enable=yes
 	sndfile_enable=${sndfile_found}
-	hal_enable=no
 	usb_enable=${usb_found}
 	gstreamer_enable=${gstreamer_found}
 	audio_enable=yes
@@ -176,7 +175,6 @@ AC_DEFUN([AC_ARG_BLUEZ], [
 	sap_enable=no
 	service_enable=yes
 	health_enable=no
-	pnat_enable=no
 	tools_enable=yes
 	cups_enable=no
 	test_enable=no
@@ -186,7 +184,6 @@ AC_DEFUN([AC_ARG_BLUEZ], [
 	dfutool_enable=no
 	datafiles_enable=yes
 	telephony_driver=dummy
-	maemo6_enable=no
 	sap_driver=dummy
 	dbusoob_enable=no
 	wiimote_enable=no
@@ -233,10 +230,6 @@ AC_DEFUN([AC_ARG_BLUEZ], [
 		health_enable=${enableval}
 	])
 
-	AC_ARG_ENABLE(pnat, AC_HELP_STRING([--enable-pnat], [enable pnat plugin]), [
-		pnat_enable=${enableval}
-	])
-
 	AC_ARG_ENABLE(gstreamer, AC_HELP_STRING([--enable-gstreamer], [enable GStreamer support]), [
 		gstreamer_enable=${enableval}
 	])
@@ -287,10 +280,6 @@ AC_DEFUN([AC_ARG_BLUEZ], [
 
 	AC_SUBST([TELEPHONY_DRIVER], [telephony-${telephony_driver}.c])
 
-	AC_ARG_ENABLE(maemo6, AC_HELP_STRING([--enable-maemo6], [compile with maemo6 plugin]), [
-		maemo6_enable=${enableval}
-	])
-
 	AC_ARG_ENABLE(dbusoob, AC_HELP_STRING([--enable-dbusoob], [compile with D-Bus OOB plugin]), [
 		dbusoob_enable=${enableval}
 	])
@@ -299,10 +288,6 @@ AC_DEFUN([AC_ARG_BLUEZ], [
 		wiimote_enable=${enableval}
 	])
 
-	AC_ARG_ENABLE(hal, AC_HELP_STRING([--enable-hal], [Use HAL to determine adapter class]), [
-		hal_enable=${enableval}
-	])
-
 	AC_ARG_ENABLE(gatt, AC_HELP_STRING([--enable-gatt], [enable gatt module]), [
 		gatt_enable=${enableval}
 	])
@@ -345,9 +330,7 @@ AC_DEFUN([AC_ARG_BLUEZ], [
 	AM_CONDITIONAL(SERVICEPLUGIN, test "${service_enable}" = "yes")
 	AM_CONDITIONAL(HEALTHPLUGIN, test "${health_enable}" = "yes")
 	AM_CONDITIONAL(MCAP, test "${health_enable}" = "yes")
-	AM_CONDITIONAL(HAL, test "${hal_enable}" = "yes")
 	AM_CONDITIONAL(READLINE, test "${readline_found}" = "yes")
-	AM_CONDITIONAL(PNATPLUGIN, test "${pnat_enable}" = "yes")
 	AM_CONDITIONAL(CUPS, test "${cups_enable}" = "yes")
 	AM_CONDITIONAL(TEST, test "${test_enable}" = "yes" && test "${check_found}" = "yes")
 	AM_CONDITIONAL(TOOLS, test "${tools_enable}" = "yes")
@@ -356,7 +339,6 @@ AC_DEFUN([AC_ARG_BLUEZ], [
 	AM_CONDITIONAL(HID2HCI, test "${hid2hci_enable}" = "yes" && test "${usb_found}" = "yes" && test "${udev_found}" = "yes")
 	AM_CONDITIONAL(DFUTOOL, test "${dfutool_enable}" = "yes" && test "${usb_found}" = "yes")
 	AM_CONDITIONAL(DATAFILES, test "${datafiles_enable}" = "yes")
-	AM_CONDITIONAL(MAEMO6PLUGIN, test "${maemo6_enable}" = "yes")
 	AM_CONDITIONAL(DBUSOOBPLUGIN, test "${dbusoob_enable}" = "yes")
 	AM_CONDITIONAL(WIIMOTEPLUGIN, test "${wiimote_enable}" = "yes")
 	AM_CONDITIONAL(GATTMODULES, test "${gatt_enable}" = "yes")
diff --git a/bootstrap-configure b/bootstrap-configure
index ff63c58..7177c65 100755
--- a/bootstrap-configure
+++ b/bootstrap-configure
@@ -24,8 +24,6 @@ fi
 		--enable-test \
 		--enable-cups \
 		--enable-dbusoob \
-		--enable-maemo6 \
-		--enable-pnat \
 		--enable-sap \
 		--enable-wiimote \
 		--disable-pcmcia \
diff --git a/plugins/hal.c b/plugins/hal.c
deleted file mode 100644
index 21d7688..0000000
--- a/plugins/hal.c
+++ /dev/null
@@ -1,144 +0,0 @@
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
-#include <dbus/dbus.h>
-
-#include <bluetooth/bluetooth.h>
-
-#include "plugin.h"
-#include "adapter.h"
-#include "log.h"
-
-static void formfactor_reply(DBusPendingCall *call, void *user_data)
-{
-	struct btd_adapter *adapter = user_data;
-	const char *formfactor = NULL;
-	DBusMessage *reply;
-	uint8_t minor = 0;
-
-	reply = dbus_pending_call_steal_reply(call);
-
-	if (dbus_set_error_from_message(NULL, reply) == TRUE) {
-		error("Failed to access HAL");
-		dbus_message_unref(reply);
-		return;
-	}
-
-	if (dbus_message_get_args(reply, NULL, DBUS_TYPE_STRING, &formfactor,
-						DBUS_TYPE_INVALID) == FALSE) {
-		error("Wrong formfactor arguments");
-		dbus_message_unref(reply);
-		return;
-	}
-
-	DBG("Computer is classified as %s", formfactor);
-
-	if (formfactor != NULL) {
-		if (g_str_equal(formfactor, "laptop") == TRUE)
-			minor |= (1 << 2) | (1 << 3);
-		else if (g_str_equal(formfactor, "desktop") == TRUE)
-			minor |= 1 << 2;
-		else if (g_str_equal(formfactor, "server") == TRUE)
-			minor |= 1 << 3;
-		else if (g_str_equal(formfactor, "handheld") == TRUE)
-			minor += 1 << 4;
-	}
-
-	dbus_message_unref(reply);
-
-	/* Computer major class */
-	DBG("Setting 0x%06x for major/minor device class", (1 << 8) | minor);
-
-	btd_adapter_set_class(adapter, 0x01, minor);
-}
-
-static DBusConnection *connection;
-
-static int hal_probe(struct btd_adapter *adapter)
-{
-	const char *property = "system.formfactor";
-	DBusMessage *message;
-	DBusPendingCall *call;
-
-	connection = dbus_bus_get(DBUS_BUS_SYSTEM, NULL);
-	if (connection == NULL)
-		return -ENOMEM;
-
-	message = dbus_message_new_method_call("org.freedesktop.Hal",
-				"/org/freedesktop/Hal/devices/computer",
-						"org.freedesktop.Hal.Device",
-							"GetPropertyString");
-	if (message == NULL) {
-		error("Failed to create formfactor request");
-		dbus_connection_unref(connection);
-		return -ENOMEM;
-	}
-
-	dbus_message_append_args(message, DBUS_TYPE_STRING, &property,
-							DBUS_TYPE_INVALID);
-
-	if (dbus_connection_send_with_reply(connection, message,
-						&call, -1) == FALSE) {
-		error("Failed to send formfactor request");
-		dbus_message_unref(message);
-		dbus_connection_unref(connection);
-		return -EIO;
-	}
-
-	dbus_pending_call_set_notify(call, formfactor_reply, adapter, NULL);
-
-	dbus_pending_call_unref(call);
-
-	dbus_message_unref(message);
-
-	return 0;
-}
-
-static void hal_remove(struct btd_adapter *adapter)
-{
-	dbus_connection_unref(connection);
-}
-
-static struct btd_adapter_driver hal_driver = {
-	.name	= "hal",
-	.probe	= hal_probe,
-	.remove	= hal_remove,
-};
-
-static int hal_init(void)
-{
-	return btd_register_adapter_driver(&hal_driver);
-}
-
-static void hal_exit(void)
-{
-	btd_unregister_adapter_driver(&hal_driver);
-}
-
-BLUETOOTH_PLUGIN_DEFINE(hal, VERSION,
-		BLUETOOTH_PLUGIN_PRIORITY_LOW, hal_init, hal_exit)
diff --git a/plugins/maemo6.c b/plugins/maemo6.c
deleted file mode 100644
index 4819af4..0000000
--- a/plugins/maemo6.c
+++ /dev/null
@@ -1,283 +0,0 @@
-/*
- *
- *  BlueZ - Bluetooth protocol stack for Linux
- *
- *  Copyright (C) 2006-2010  Nokia Corporation
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
-#include <glib.h>
-#include <dbus/dbus.h>
-
-#include "adapter.h"
-#include "plugin.h"
-#include "log.h"
-#include "gdbus.h"
-
-/* from mce/mode-names.h */
-#define MCE_RADIO_STATE_BLUETOOTH	(1 << 3)
-
-/* from mce/dbus-names.h */
-#define MCE_SERVICE			"com.nokia.mce"
-#define MCE_REQUEST_IF			"com.nokia.mce.request"
-#define MCE_SIGNAL_IF			"com.nokia.mce.signal"
-#define MCE_REQUEST_PATH		"/com/nokia/mce/request"
-#define MCE_SIGNAL_PATH			"/com/nokia/mce/signal"
-#define MCE_RADIO_STATES_CHANGE_REQ	"req_radio_states_change"
-#define MCE_RADIO_STATES_GET		"get_radio_states"
-#define MCE_RADIO_STATES_SIG		"radio_states_ind"
-#define MCE_TKLOCK_MODE_SIG		"tklock_mode_ind"
-
-static guint watch_id;
-static guint tklock_watch_id;
-static DBusConnection *conn = NULL;
-static gboolean mce_bt_set = FALSE;
-static gboolean mce_bt_on = FALSE;
-
-static gboolean mce_tklock_mode_cb(DBusConnection *connection,
-					DBusMessage *message, void *user_data)
-{
-	struct btd_adapter *adapter = user_data;
-	DBusMessageIter args;
-	const char *sigvalue;
-
-	if (!dbus_message_iter_init(message, &args)) {
-		error("message has no arguments");
-	} else if (dbus_message_iter_get_arg_type(&args) != DBUS_TYPE_STRING) {
-		error("argument is not string");
-	} else {
-
-		dbus_message_iter_get_basic(&args, &sigvalue);
-		DBG("got signal with value %s", sigvalue);
-
-		if (g_strcmp0("unlocked", sigvalue) == 0 && mce_bt_on)
-			btd_adapter_enable_auto_connect(adapter);
-	}
-
-	return TRUE;
-}
-
-static gboolean mce_signal_callback(DBusConnection *connection,
-					DBusMessage *message, void *user_data)
-{
-	DBusMessageIter args;
-	uint32_t sigvalue;
-	struct btd_adapter *adapter = user_data;
-	int err;
-
-	DBG("received mce signal");
-
-	if (!dbus_message_iter_init(message, &args))
-		error("message has no arguments");
-	else if (DBUS_TYPE_UINT32 != dbus_message_iter_get_arg_type(&args))
-		error("argument is not uint32");
-	else {
-		dbus_message_iter_get_basic(&args, &sigvalue);
-		DBG("got signal with value %u", sigvalue);
-
-		/* set the adapter according to the mce signal
-		   and remember the value */
-		mce_bt_on = sigvalue & MCE_RADIO_STATE_BLUETOOTH ? TRUE : FALSE;
-
-		if (mce_bt_on)
-			err = btd_adapter_switch_online(adapter);
-		else
-			err = btd_adapter_switch_offline(adapter);
-
-		if (err == 0)
-			mce_bt_set = TRUE;
-
-	}
-
-	return TRUE;
-}
-
-static void read_radio_states_cb(DBusPendingCall *call, void *user_data)
-{
-	DBusError derr;
-	DBusMessage *reply;
-	dbus_uint32_t radio_states;
-	struct btd_adapter *adapter = user_data;
-	int err;
-
-	reply = dbus_pending_call_steal_reply(call);
-
-	dbus_error_init(&derr);
-	if (dbus_set_error_from_message(&derr, reply)) {
-		error("mce replied with an error: %s, %s",
-				derr.name, derr.message);
-		dbus_error_free(&derr);
-		goto done;
-	}
-
-	if (dbus_message_get_args(reply, &derr,
-				DBUS_TYPE_UINT32, &radio_states,
-				DBUS_TYPE_INVALID) == FALSE) {
-		error("unable to parse get_radio_states reply: %s, %s",
-							derr.name, derr.message);
-		dbus_error_free(&derr);
-		goto done;
-	}
-
-	DBG("radio_states: %d", radio_states);
-
-	mce_bt_on = radio_states & MCE_RADIO_STATE_BLUETOOTH ? TRUE : FALSE;
-
-	if (mce_bt_on)
-		err = btd_adapter_switch_online(adapter);
-	else
-		err = btd_adapter_switch_offline(adapter);
-
-	if (err == 0)
-		mce_bt_set = TRUE;
-
-done:
-	dbus_message_unref(reply);
-}
-
-static void adapter_powered(struct btd_adapter *adapter, gboolean powered)
-{
-	DBusMessage *msg;
-	static gboolean startup = TRUE;
-
-	DBG("adapter_powered called with %d", powered);
-
-	if (startup) {
-		DBusPendingCall *call;
-
-		/* Initialization: sync adapter state and MCE radio state */
-
-		DBG("Startup: reading MCE Bluetooth radio state...");
-		startup = FALSE;
-
-		msg = dbus_message_new_method_call(MCE_SERVICE,
-					MCE_REQUEST_PATH, MCE_REQUEST_IF,
-					MCE_RADIO_STATES_GET);
-
-		if (!dbus_connection_send_with_reply(conn, msg, &call, -1)) {
-			error("calling %s failed", MCE_RADIO_STATES_GET);
-			dbus_message_unref(msg);
-			return;
-		}
-
-		dbus_pending_call_set_notify(call, read_radio_states_cb,
-								adapter, NULL);
-		dbus_pending_call_unref(call);
-		dbus_message_unref(msg);
-		return;
-	}
-
-	/* MCE initiated operation */
-	if (mce_bt_set == TRUE) {
-		mce_bt_set = FALSE;
-		return;
-	}
-
-	/* Non MCE operation: set MCE according to adapter state */
-	if (mce_bt_on != powered) {
-		dbus_uint32_t radio_states;
-		dbus_uint32_t radio_mask = MCE_RADIO_STATE_BLUETOOTH;
-
-		msg = dbus_message_new_method_call(MCE_SERVICE,
-					MCE_REQUEST_PATH, MCE_REQUEST_IF,
-					MCE_RADIO_STATES_CHANGE_REQ);
-
-		radio_states = (powered ? MCE_RADIO_STATE_BLUETOOTH : 0);
-
-		DBG("Changing MCE Bluetooth radio state to: %d", radio_states);
-
-		dbus_message_append_args(msg, DBUS_TYPE_UINT32, &radio_states,
-					DBUS_TYPE_UINT32, &radio_mask,
-					DBUS_TYPE_INVALID);
-
-		if (dbus_connection_send(conn, msg, NULL))
-			mce_bt_on = powered;
-		else
-			error("calling %s failed", MCE_RADIO_STATES_CHANGE_REQ);
-
-		dbus_message_unref(msg);
-	}
-}
-
-static int mce_probe(struct btd_adapter *adapter)
-{
-
-	DBG("path %s", adapter_get_path(adapter));
-
-	watch_id = g_dbus_add_signal_watch(conn, NULL, MCE_SIGNAL_PATH,
-					MCE_SIGNAL_IF, MCE_RADIO_STATES_SIG,
-					mce_signal_callback, adapter, NULL);
-
-	tklock_watch_id = g_dbus_add_signal_watch(conn, NULL, MCE_SIGNAL_PATH,
-					MCE_SIGNAL_IF, MCE_TKLOCK_MODE_SIG,
-					mce_tklock_mode_cb, adapter, NULL);
-
-	btd_adapter_register_powered_callback(adapter, adapter_powered);
-
-	return 0;
-}
-
-static void mce_remove(struct btd_adapter *adapter)
-{
-	DBG("path %s", adapter_get_path(adapter));
-
-	if (watch_id > 0)
-		g_dbus_remove_watch(conn, watch_id);
-
-	if (tklock_watch_id > 0)
-		g_dbus_remove_watch(conn, tklock_watch_id);
-
-	btd_adapter_unregister_powered_callback(adapter, adapter_powered);
-}
-
-static struct btd_adapter_driver mce_driver = {
-	.name	= "mce",
-	.probe	= mce_probe,
-	.remove	= mce_remove,
-};
-
-static int maemo6_init(void)
-{
-	DBG("init maemo6 plugin");
-
-	conn = dbus_bus_get(DBUS_BUS_SYSTEM, NULL);
-	if (conn == NULL) {
-		error("Unable to connect to D-Bus");
-		return -1;
-	}
-
-	return btd_register_adapter_driver(&mce_driver);
-}
-
-static void maemo6_exit(void)
-{
-	DBG("exit maemo6 plugin");
-
-	if (conn != NULL)
-		dbus_connection_unref(conn);
-
-	btd_unregister_adapter_driver(&mce_driver);
-}
-
-BLUETOOTH_PLUGIN_DEFINE(maemo6, VERSION,
-		BLUETOOTH_PLUGIN_PRIORITY_DEFAULT, maemo6_init, maemo6_exit)
diff --git a/plugins/pnat.c b/plugins/pnat.c
deleted file mode 100644
index 3c611a9..0000000
--- a/plugins/pnat.c
+++ /dev/null
@@ -1,526 +0,0 @@
-/*
- *
- *  BlueZ - Bluetooth protocol stack for Linux
- *
- *  Copyright (C) 2010  Nokia Corporation
- *  Copyright (C) 2010  Marcel Holtmann <marcel@holtmann.org>
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
-#include <sys/ioctl.h>
-#include <sys/types.h>
-#include <sys/stat.h>
-#include <sys/wait.h>
-#include <fcntl.h>
-
-#include <bluetooth/bluetooth.h>
-#include <bluetooth/rfcomm.h>
-#include <bluetooth/sdp.h>
-#include <bluetooth/sdp_lib.h>
-#include <bluetooth/uuid.h>
-
-#include <glib.h>
-
-#include <gdbus.h>
-
-#include "plugin.h"
-#include "sdpd.h"
-#include "btio.h"
-#include "adapter.h"
-#include "log.h"
-
-/* FIXME: This location should be build-time configurable */
-#define PNATD "/usr/bin/phonet-at"
-
-#define DUN_CHANNEL 1
-
-#define TTY_TIMEOUT 100
-#define TTY_TRIES 10
-
-struct dun_client {
-	bdaddr_t bda;
-
-	GIOChannel *io;	/* Client socket */
-	guint io_watch;	/* Client IO watch id */
-
-	guint tty_timer;
-	int tty_tries;
-	gboolean tty_open;
-	int tty_id;
-	char tty_name[PATH_MAX];
-
-	GPid pnatd_pid;
-};
-
-struct dun_server {
-	bdaddr_t bda;		/* Local adapter address */
-
-	uint32_t record_handle; /* Local SDP record handle */
-	GIOChannel *server;	/* Server socket */
-
-	int rfcomm_ctl;
-
-	struct dun_client client;
-};
-
-static GSList *servers = NULL;
-
-static void disconnect(struct dun_server *server)
-{
-	struct dun_client *client = &server->client;
-
-	if (!client->io)
-		return;
-
-	if (client->io_watch > 0) {
-		g_source_remove(client->io_watch);
-		client->io_watch = 0;
-	}
-
-	g_io_channel_shutdown(client->io, TRUE, NULL);
-	g_io_channel_unref(client->io);
-	client->io = NULL;
-
-	if (client->pnatd_pid > 0) {
-		kill(client->pnatd_pid, SIGTERM);
-		client->pnatd_pid = 0;
-	}
-
-	if (client->tty_timer > 0) {
-		g_source_remove(client->tty_timer);
-		client->tty_timer = 0;
-	}
-
-	if (client->tty_id >= 0) {
-		struct rfcomm_dev_req req;
-
-		memset(&req, 0, sizeof(req));
-		req.dev_id = client->tty_id;
-		req.flags = (1 << RFCOMM_HANGUP_NOW);
-		ioctl(server->rfcomm_ctl, RFCOMMRELEASEDEV, &req);
-
-		client->tty_name[0] = '\0';
-		client->tty_open = FALSE;
-		client->tty_id = -1;
-	}
-}
-
-static gboolean client_event(GIOChannel *chan,
-					GIOCondition cond, gpointer data)
-{
-	struct dun_server *server = data;
-	struct dun_client *client = &server->client;
-	char addr[18];
-
-	ba2str(&client->bda, addr);
-
-	DBG("Disconnected DUN from %s (%s)", addr, client->tty_name);
-
-	client->io_watch = 0;
-	disconnect(server);
-
-	return FALSE;
-}
-
-static void pnatd_exit(GPid pid, gint status, gpointer user_data)
-{
-	struct dun_server *server = user_data;
-	struct dun_client *client = &server->client;
-
-        if (WIFEXITED(status))
-                DBG("pnatd (%d) exited with status %d", pid,
-							WEXITSTATUS(status));
-        else
-                DBG("pnatd (%d) was killed by signal %d", pid,
-							WTERMSIG(status));
-	g_spawn_close_pid(pid);
-
-	if (pid != client->pnatd_pid)
-		return;
-
-	/* So disconnect() doesn't send SIGTERM to a non-existing process */
-	client->pnatd_pid = 0;
-
-	disconnect(server);
-}
-
-static gboolean start_pnatd(struct dun_server *server)
-{
-	struct dun_client *client = &server->client;
-	GSpawnFlags flags = G_SPAWN_DO_NOT_REAP_CHILD | G_SPAWN_SEARCH_PATH;
-	char *argv[] = { PNATD, client->tty_name, NULL };
-	GError *err = NULL;
-	GPid pid;
-
-	g_spawn_async(NULL, argv, NULL, flags, NULL, NULL, &pid, &err);
-	if (err != NULL) {
-		error("Unable to spawn pnatd: %s", err->message);
-		g_error_free(err);
-		return FALSE;
-	}
-
-	DBG("pnatd started for %s with pid %d", client->tty_name, pid);
-
-	client->pnatd_pid = pid;
-
-	/* We do not store the GSource id since g_remove_source doesn't
-	 * make sense for a child watch. If the callback gets removed
-	 * waitpid won't be called and the child remains as a zombie)
-	 */
-	g_child_watch_add(pid, pnatd_exit, server);
-
-	return TRUE;
-}
-
-static gboolean tty_try_open(gpointer user_data)
-{
-	struct dun_server *server = user_data;
-	struct dun_client *client = &server->client;
-	int tty_fd;
-
-	tty_fd = open(client->tty_name, O_RDONLY | O_NOCTTY);
-	if (tty_fd < 0) {
-		if (errno == EACCES)
-			goto disconnect;
-
-		client->tty_tries--;
-
-		if (client->tty_tries <= 0)
-			goto disconnect;
-
-		return TRUE;
-	}
-
-	DBG("%s created for DUN", client->tty_name);
-
-	client->tty_open = TRUE;
-	client->tty_timer = 0;
-
-	g_io_channel_unref(client->io);
-	g_source_remove(client->io_watch);
-
-	client->io = g_io_channel_unix_new(tty_fd);
-	client->io_watch = g_io_add_watch(client->io,
-					G_IO_HUP | G_IO_ERR | G_IO_NVAL,
-					client_event, server);
-
-	if (!start_pnatd(server))
-		goto disconnect;
-
-	return FALSE;
-
-disconnect:
-	client->tty_timer = 0;
-	disconnect(server);
-	return FALSE;
-}
-
-static gboolean create_tty(struct dun_server *server)
-{
-	struct dun_client *client = &server->client;
-	struct rfcomm_dev_req req;
-	int sk = g_io_channel_unix_get_fd(client->io);
-
-	memset(&req, 0, sizeof(req));
-	req.dev_id = -1;
-	req.flags = (1 << RFCOMM_REUSE_DLC) | (1 << RFCOMM_RELEASE_ONHUP);
-
-	bacpy(&req.src, &server->bda);
-	bacpy(&req.dst, &client->bda);
-
-	bt_io_get(client->io, BT_IO_RFCOMM, NULL,
-			BT_IO_OPT_DEST_CHANNEL, &req.channel,
-			BT_IO_OPT_INVALID);
-
-	client->tty_id = ioctl(sk, RFCOMMCREATEDEV, &req);
-	if (client->tty_id < 0) {
-		error("Can't create RFCOMM TTY: %s", strerror(errno));
-		return FALSE;
-	}
-
-	snprintf(client->tty_name, PATH_MAX - 1, "/dev/rfcomm%d",
-							client->tty_id);
-
-	client->tty_tries = TTY_TRIES;
-
-	tty_try_open(server);
-	if (!client->tty_open && client->tty_tries > 0)
-		client->tty_timer = g_timeout_add(TTY_TIMEOUT,
-							tty_try_open, server);
-
-	return TRUE;
-}
-
-static void connect_cb(GIOChannel *io, GError *err, gpointer user_data)
-{
-	struct dun_server *server = user_data;
-
-	if (err) {
-		error("Accepting DUN connection failed: %s", err->message);
-		disconnect(server);
-		return;
-	}
-
-	if (!create_tty(server)) {
-		error("Device creation failed");
-		disconnect(server);
-	}
-}
-
-static void auth_cb(DBusError *derr, void *user_data)
-{
-	struct dun_server *server = user_data;
-	struct dun_client *client = &server->client;
-	GError *err = NULL;
-
-	if (derr && dbus_error_is_set(derr)) {
-		error("DUN access denied: %s", derr->message);
-		goto drop;
-	}
-
-	if (!bt_io_accept(client->io, connect_cb, server, NULL, &err)) {
-		error("bt_io_accept: %s", err->message);
-		g_error_free(err);
-		goto drop;
-	}
-
-	return;
-
-drop:
-	disconnect(server);
-}
-
-static gboolean auth_watch(GIOChannel *chan, GIOCondition cond, gpointer data)
-{
-	struct dun_server *server = data;
-	struct dun_client *client = &server->client;
-
-	error("DUN client disconnected while waiting for authorization");
-
-	btd_cancel_authorization(&server->bda, &client->bda);
-
-	disconnect(server);
-
-	return FALSE;
-}
-
-static void confirm_cb(GIOChannel *io, gpointer user_data)
-{
-	struct dun_server *server = user_data;
-	struct dun_client *client = &server->client;
-	GError *err = NULL;
-
-	if (client->io) {
-		error("Rejecting DUN connection since one already exists");
-		return;
-	}
-
-	bt_io_get(io, BT_IO_RFCOMM, &err,
-			BT_IO_OPT_DEST_BDADDR, &client->bda,
-			BT_IO_OPT_INVALID);
-	if (err != NULL) {
-		error("Unable to get DUN source and dest address: %s",
-								err->message);
-		g_error_free(err);
-		return;
-	}
-
-	if (btd_request_authorization(&server->bda, &client->bda, DUN_GW_UUID,
-						auth_cb, user_data) < 0) {
-		error("Requesting DUN authorization failed");
-		return;
-	}
-
-	client->io_watch = g_io_add_watch(io, G_IO_ERR | G_IO_HUP | G_IO_NVAL,
-						(GIOFunc) auth_watch, server);
-	client->io = g_io_channel_ref(io);
-}
-
-static sdp_record_t *dun_record(uint8_t ch)
-{
-	sdp_list_t *svclass_id, *pfseq, *apseq, *root, *aproto;
-	uuid_t root_uuid, dun, gn, l2cap, rfcomm;
-	sdp_profile_desc_t profile;
-	sdp_list_t *proto[2];
-	sdp_record_t *record;
-	sdp_data_t *channel;
-
-	record = sdp_record_alloc();
-	if (!record)
-		return NULL;
-
-	sdp_uuid16_create(&root_uuid, PUBLIC_BROWSE_GROUP);
-	root = sdp_list_append(NULL, &root_uuid);
-	sdp_set_browse_groups(record, root);
-
-	sdp_uuid16_create(&dun, DIALUP_NET_SVCLASS_ID);
-	svclass_id = sdp_list_append(NULL, &dun);
-	sdp_uuid16_create(&gn,  GENERIC_NETWORKING_SVCLASS_ID);
-	svclass_id = sdp_list_append(svclass_id, &gn);
-	sdp_set_service_classes(record, svclass_id);
-
-	sdp_uuid16_create(&profile.uuid, DIALUP_NET_PROFILE_ID);
-	profile.version = 0x0100;
-	pfseq = sdp_list_append(NULL, &profile);
-	sdp_set_profile_descs(record, pfseq);
-
-	sdp_uuid16_create(&l2cap, L2CAP_UUID);
-	proto[0] = sdp_list_append(NULL, &l2cap);
-	apseq = sdp_list_append(NULL, proto[0]);
-
-	sdp_uuid16_create(&rfcomm, RFCOMM_UUID);
-	proto[1] = sdp_list_append(NULL, &rfcomm);
-	channel = sdp_data_alloc(SDP_UINT8, &ch);
-	proto[1] = sdp_list_append(proto[1], channel);
-	apseq = sdp_list_append(apseq, proto[1]);
-
-	aproto = sdp_list_append(0, apseq);
-	sdp_set_access_protos(record, aproto);
-
-	sdp_set_info_attr(record, "Dial-Up Networking", 0, 0);
-
-	sdp_data_free(channel);
-	sdp_list_free(root, NULL);
-	sdp_list_free(svclass_id, NULL);
-	sdp_list_free(proto[0], NULL);
-	sdp_list_free(proto[1], NULL);
-	sdp_list_free(pfseq, NULL);
-	sdp_list_free(apseq, NULL);
-	sdp_list_free(aproto, NULL);
-
-	return record;
-}
-
-static gint server_cmp(gconstpointer a, gconstpointer b)
-{
-	const struct dun_server *server = a;
-	const bdaddr_t *src = b;
-
-	return bacmp(src, &server->bda);
-}
-
-static int pnat_probe(struct btd_adapter *adapter)
-{
-	struct dun_server *server;
-	GIOChannel *io;
-	GError *err = NULL;
-	sdp_record_t *record;
-	bdaddr_t src;
-
-	adapter_get_address(adapter, &src);
-
-	server = g_new0(struct dun_server, 1);
-
-	io = bt_io_listen(BT_IO_RFCOMM, NULL, confirm_cb, server, NULL, &err,
-				BT_IO_OPT_SOURCE_BDADDR, &src,
-				BT_IO_OPT_CHANNEL, DUN_CHANNEL,
-				BT_IO_OPT_INVALID);
-	if (err != NULL) {
-		error("Failed to start DUN server: %s", err->message);
-		g_error_free(err);
-		goto fail;
-	}
-
-	record = dun_record(DUN_CHANNEL);
-	if (!record) {
-		error("Unable to allocate new service record");
-		goto fail;
-	}
-
-	if (add_record_to_server(&src, record) < 0) {
-		error("Unable to register DUN service record");
-		goto fail;
-	}
-
-	server->rfcomm_ctl = socket(AF_BLUETOOTH, SOCK_RAW, BTPROTO_RFCOMM);
-	if (server->rfcomm_ctl < 0) {
-		error("Unable to create RFCOMM control socket: %s (%d)",
-						strerror(errno), errno);
-		goto fail;
-	}
-
-	server->server = io;
-	server->record_handle = record->handle;
-	bacpy(&server->bda, &src);
-
-	servers = g_slist_append(servers, server);
-
-	return 0;
-
-fail:
-	if (io != NULL)
-		g_io_channel_unref(io);
-	g_free(server);
-	return -EIO;
-}
-
-static void pnat_remove(struct btd_adapter *adapter)
-{
-	struct dun_server *server;
-	GSList *match;
-	bdaddr_t src;
-
-	adapter_get_address(adapter, &src);
-
-	match = g_slist_find_custom(servers, &src, server_cmp);
-	if (match == NULL)
-		return;
-
-	server = match->data;
-
-	servers = g_slist_delete_link(servers, match);
-
-	disconnect(server);
-
-	remove_record_from_server(server->record_handle);
-	close(server->rfcomm_ctl);
-	g_io_channel_shutdown(server->server, TRUE, NULL);
-	g_io_channel_unref(server->server);
-	g_free(server);
-}
-
-static struct btd_adapter_driver pnat_server = {
-	.name	= "pnat-server",
-	.probe	= pnat_probe,
-	.remove	= pnat_remove,
-};
-
-static int pnat_init(void)
-{
-	DBG("Setup Phonet AT (DUN) plugin");
-
-	return btd_register_adapter_driver(&pnat_server);
-}
-
-static void pnat_exit(void)
-{
-	DBG("Cleanup Phonet AT (DUN) plugin");
-
-	btd_unregister_adapter_driver(&pnat_server);
-}
-
-BLUETOOTH_PLUGIN_DEFINE(pnat, VERSION,
-			BLUETOOTH_PLUGIN_PRIORITY_DEFAULT,
-			pnat_init, pnat_exit)
-- 
1.7.10.2

