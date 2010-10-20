Return-Path: <cyrus@holtmann.org>
From: Waldemar Rymarkiewicz <waldemar.rymarkiewicz@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Marcel Holtmann <marcel@holtmann.org>, <suraj@atheros.com>, Johan Hedberg
	<johan.hedberg@gmail.com>, <joakim.xj.ceder@stericsson.com>,
	<arunkr.singh@stericsson.com>, Waldemar Rymarkiewicz
	<waldemar.rymarkiewicz@tieto.com>
Subject: [PATCH 1/1] Add Sim Access Plugin
Date: Wed, 20 Oct 2010 09:55:08 +0200
Message-ID: <1287561308-18611-2-git-send-email-waldemar.rymarkiewicz@tieto.com>
In-Reply-To: <1287561308-18611-1-git-send-email-waldemar.rymarkiewicz@tieto.com>
References: <1287561308-18611-1-git-send-email-waldemar.rymarkiewicz@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-bluetooth.vger.kernel.org>

Sim Access plugin implements Sim Access Profile server role
according to the Bluetooth Sim Access Profile v1.1 specification.
---
 .gitignore      |    1 +
 Makefile.am     |   25 +-
 acinclude.m4    |   14 +
 doc/sap-api.txt |   57 ++
 sap/main.c      |   54 ++
 sap/manager.c   |   94 ++++
 sap/manager.h   |   21 +
 sap/sap-dummy.c |  306 +++++++++++
 sap/sap-ste.c   | 1265 ++++++++++++++++++++++++++++++++++++++++++++++
 sap/sap.h       |  187 +++++++
 sap/server.c    | 1516 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 sap/server.h    |   23 +
 12 files changed, 3559 insertions(+), 4 deletions(-)
 create mode 100644 doc/sap-api.txt
 create mode 100644 sap/main.c
 create mode 100644 sap/manager.c
 create mode 100644 sap/manager.h
 create mode 100644 sap/sap-dummy.c
 create mode 100644 sap/sap-ste.c
 create mode 100644 sap/sap.h
 create mode 100644 sap/server.c
 create mode 100644 sap/server.h

diff --git a/.gitignore b/.gitignore
index 07e239f..3e36a59 100644
--- a/.gitignore
+++ b/.gitignore
@@ -35,6 +35,7 @@ lib/bluetooth
 src/builtin.h
 src/bluetoothd
 audio/telephony.c
+sap/sap.c
 scripts/bluetooth.rules
 scripts/97-bluetooth.rules
 scripts/97-bluetooth-hid2hci.rules
diff --git a/Makefile.am b/Makefile.am
index 6e8fc7d..015d84e 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -142,6 +142,20 @@ audio_libtelephony_a_SOURCES = audio/telephony.h audio/telephony-dummy.c \
 				audio/telephony-maemo6.c
 endif
 
+if SAPPLUGIN
+builtin_modules += sap
+builtin_sources += sap/main.c \
+			sap/manager.h sap/manager.c \
+			sap/server.h sap/server.c \
+			sap/sap.h
+builtin_nodist += sap/sap.c
+
+noinst_LIBRARIES = sap/libsap.a
+
+sap_libsap_a_SOURCES = sap/sap.h sap/sap-dummy.c \
+				sap/sap-ste.c
+endif
+
 if INPUTPLUGIN
 builtin_modules += input
 builtin_sources += input/main.c \
@@ -263,8 +277,8 @@ EXTRA_DIST += src/genbuiltin src/bluetooth.conf \
 			input/input.conf serial/serial.conf \
 			audio/audio.conf audio/telephony-dummy.c \
 			audio/telephony-maemo5.c audio/telephony-ofono.c \
-			audio/telephony-maemo6.c
-
+			audio/telephony-maemo6.c \
+			sap/sap-dummy.c sap/sap-ste.c
 
 if ALSA
 alsadir = $(libdir)/alsa-lib
@@ -352,7 +366,7 @@ EXTRA_DIST += doc/manager-api.txt \
 		doc/service-api.txt doc/agent-api.txt doc/attribute-api.txt \
 		doc/serial-api.txt doc/network-api.txt \
 		doc/input-api.txt doc/audio-api.txt doc/control-api.txt \
-		doc/hfp-api.txt doc/assigned-numbers.txt
+		doc/hfp-api.txt doc/assigned-numbers.txt doc/sap-api.txt
 
 AM_YFLAGS = -d
 
@@ -387,6 +401,9 @@ src/builtin.h: src/genbuiltin $(builtin_sources)
 audio/telephony.c: audio/@TELEPHONY_DRIVER@
 	$(AM_V_GEN)$(LN_S) $(abs_top_srcdir)/$< $@
 
+sap/sap.c: sap/@SAP_DRIVER@
+	$(AM_V_GEN)$(LN_S) $(abs_top_srcdir)/$< $@
+
 scripts/%.rules:
 	$(AM_V_GEN)cp $(subst 97-,,$@) $@
 
@@ -397,4 +414,4 @@ lib/bluetooth/%.h: lib/%.h
 	$(AM_V_GEN)$(LN_S) $(abs_top_srcdir)/$< $@
 
 clean-local:
-	$(RM) -r lib/bluetooth
+	$(RM) -r lib/bluetooth
\ No newline at end of file
diff --git a/acinclude.m4 b/acinclude.m4
index 287f07d..093e9a6 100644
--- a/acinclude.m4
+++ b/acinclude.m4
@@ -174,6 +174,7 @@ AC_DEFUN([AC_ARG_BLUEZ], [
 	input_enable=yes
 	serial_enable=yes
 	network_enable=yes
+	sap_enable=yes
 	service_enable=yes
 	health_enable=no
 	pnat_enable=no
@@ -193,6 +194,7 @@ AC_DEFUN([AC_ARG_BLUEZ], [
 	configfiles_enable=yes
 	telephony_driver=dummy
 	maemo6_enable=no
+	sap_driver=dummy
 
 	AC_ARG_ENABLE(optimization, AC_HELP_STRING([--disable-optimization], [disable code optimization]), [
 		optimization_enable=${enableval}
@@ -210,6 +212,10 @@ AC_DEFUN([AC_ARG_BLUEZ], [
 		network_enable=${enableval}
 	])
 
+	AC_ARG_ENABLE(sap, AC_HELP_STRING([--disable-sap], [disable sap plugin]), [
+		sap_enable=${enableval}
+	])
+
 	AC_ARG_ENABLE(serial, AC_HELP_STRING([--disable-serial], [disable serial plugin]), [
 		serial_enable=${enableval}
 	])
@@ -320,6 +326,13 @@ AC_DEFUN([AC_ARG_BLUEZ], [
 		hal_enable=${enableval}
 	])
 
+	AC_ARG_WITH(sap, AC_HELP_STRING([--with-sap=DRIVER], [select SAP driver]), [
+		sap_driver=${withval}
+	])
+
+
+	AC_SUBST([SAP_DRIVER], [sap-${sap_driver}.c])
+
 	if (test "${fortify_enable}" = "yes"); then
 		CFLAGS="$CFLAGS -D_FORTIFY_SOURCE=2"
 	fi
@@ -351,6 +364,7 @@ AC_DEFUN([AC_ARG_BLUEZ], [
 	AM_CONDITIONAL(INPUTPLUGIN, test "${input_enable}" = "yes")
 	AM_CONDITIONAL(SERIALPLUGIN, test "${serial_enable}" = "yes")
 	AM_CONDITIONAL(NETWORKPLUGIN, test "${network_enable}" = "yes")
+	AM_CONDITIONAL(SAPPLUGIN, test "${sap_enable}" = "yes")
 	AM_CONDITIONAL(SERVICEPLUGIN, test "${service_enable}" = "yes")
 	AM_CONDITIONAL(HEALTHPLUGIN, test "${health_enable}" = "yes")
 	AM_CONDITIONAL(MCAP, test "${health_enable}" = "yes")
diff --git a/doc/sap-api.txt b/doc/sap-api.txt
new file mode 100644
index 0000000..7951f56
--- /dev/null
+++ b/doc/sap-api.txt
@@ -0,0 +1,57 @@
+BlueZ D-Bus Sim Access Profile API description
+***********************************
+
+Copyright (C) 2010 ST-Ericsson SA
+
+
+Sim Access Profile hierarchy
+============================
+
+Service		org.bluez
+Interface	org.bluez.SimAccess
+Object path	[variable prefix]/{hci0,hci1,...}
+
+Methods		void Enable()
+
+			Start up SAP server and register SDP record for it.
+
+			Possible errors: org.bluez.Error.Failed
+
+		void Disable()
+
+			Shudown SAP server and remove the SDP record.
+
+			Possible errors: org.bluez.Error.Failed
+
+		void Disconnect(boolean type)
+
+			Disconnect SAP client from the server. The 'type'
+			parameter indicates disconnection type.
+
+			True  - gracefull disconnection
+			False - immediate disconnection
+
+			Possible errors: org.bluez.Error.Failed
+
+		dict GetProperties()
+
+			Return all properties for the interface. See the
+			properties section for available properties.
+
+			Possible Errors: org.bluez.Error.Failed
+
+Signals		PropertyChanged(string name, variant value)
+
+			This signal indicates a changed value of the given
+			property.
+
+
+Properties	boolean Enabled [readonly]
+
+				Indicates the state of the server. True if the server
+				is enabled and False otherwise.
+
+			boolean Connected [readonly]
+
+				Indicates if SAP client is connected to the server.
+
diff --git a/sap/main.c b/sap/main.c
new file mode 100644
index 0000000..b3efcf8
--- /dev/null
+++ b/sap/main.c
@@ -0,0 +1,54 @@
+/*
+ *  BlueZ - Bluetooth protocol stack for Linux
+ *
+ *  Copyright (C) 2010 Claudio Takahasi<claudio.takahasi@openbossa.org>
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation; version 2 of the License.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program; if not, write to the Free Software
+ *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
+ */
+
+#ifdef HAVE_CONFIG_H
+#include <config.h>
+#endif
+
+#include <errno.h>
+#include <gdbus.h>
+#include "plugin.h"
+#include "manager.h"
+
+static DBusConnection *connection;
+
+static int sap_init(void)
+{
+	connection = dbus_bus_get(DBUS_BUS_SYSTEM, NULL);
+
+	if (!connection)
+		return -EIO;
+
+	if (sap_manager_init(connection) < 0) {
+		dbus_connection_unref(connection);
+		return -EIO;
+	}
+
+	return 0;
+}
+
+static void sap_exit(void)
+{
+	sap_manager_exit();
+
+	dbus_connection_unref(connection);
+}
+
+BLUETOOTH_PLUGIN_DEFINE(sap, VERSION,
+		BLUETOOTH_PLUGIN_PRIORITY_DEFAULT, sap_init, sap_exit)
diff --git a/sap/manager.c b/sap/manager.c
new file mode 100644
index 0000000..972a46b
--- /dev/null
+++ b/sap/manager.c
@@ -0,0 +1,94 @@
+/*
+ *  BlueZ - Bluetooth protocol stack for Linux
+ *
+ *  Copyright (C) 2010 Claudio Takahasi<claudio.takahasi@openbossa.org>
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation; version 2 of the License.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program; if not, write to the Free Software
+ *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
+ */
+
+#ifdef HAVE_CONFIG_H
+#include <config.h>
+#endif
+
+#include <errno.h>
+
+#include <bluetooth/bluetooth.h>
+#include <bluetooth/hci.h>
+#include <bluetooth/sdp.h>
+#include <bluetooth/sdp_lib.h>
+
+#include <gdbus.h>
+
+#include "log.h"
+#include "adapter.h"
+#include "device.h"
+
+#include "manager.h"
+
+#include "server.h"
+
+static DBusConnection *connection = NULL;
+
+
+static int sap_server_probe(struct btd_adapter *adapter)
+{
+	const gchar *path = adapter_get_path(adapter);
+	bdaddr_t src;
+
+	DBG("path %s", path);
+
+	adapter_get_address(adapter, &src);
+
+	return sap_server_register(path, &src);
+}
+
+static void sap_server_remove(struct btd_adapter *adapter)
+{
+	const gchar *path = adapter_get_path(adapter);
+
+	DBG("path %s", path);
+
+	sap_server_unregister(path);
+}
+
+static struct btd_adapter_driver sap_server_driver = {
+	.name	= "sap-server",
+	.probe	= sap_server_probe,
+	.remove	= sap_server_remove,
+};
+
+int sap_manager_init(DBusConnection *conn)
+{
+	connection = dbus_connection_ref(conn);
+
+	if (sap_server_init(connection) < 0) {
+		error("Can't init SAP server");
+		dbus_connection_unref(conn);
+		return -1;
+	}
+
+	btd_register_adapter_driver(&sap_server_driver);
+
+	return 0;
+}
+
+void sap_manager_exit(void)
+{
+	btd_unregister_adapter_driver(&sap_server_driver);
+
+	dbus_connection_unref(connection);
+	connection = NULL;
+
+	sap_server_exit();
+}
diff --git a/sap/manager.h b/sap/manager.h
new file mode 100644
index 0000000..5a779df
--- /dev/null
+++ b/sap/manager.h
@@ -0,0 +1,21 @@
+/*
+ *  BlueZ - Bluetooth protocol stack for Linux
+ *
+ *  Copyright (C) 2010 Claudio Takahasi<claudio.takahasi@openbossa.org>
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation; version 2 of the License.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program; if not, write to the Free Software
+ *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
+ */
+
+int sap_manager_init(DBusConnection *conn);
+void sap_manager_exit(void);
diff --git a/sap/sap-dummy.c b/sap/sap-dummy.c
new file mode 100644
index 0000000..db1078b
--- /dev/null
+++ b/sap/sap-dummy.c
@@ -0,0 +1,306 @@
+/*
+ *  BlueZ - Bluetooth protocol stack for Linux
+ *
+ *  Copyright (C) 2010 ST-Ericsson SA
+ *
+ *  Author: Waldemar Rymarkiewicz <waldemar.rymarkiewicz@tieto.com> for ST-Ericsson
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation; version 2 of the License.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program; if not, write to the Free Software
+ *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
+ */
+
+#ifdef HAVE_CONFIG_H
+#include <config.h>
+#endif
+
+#include <unistd.h>
+#include <stdlib.h>
+#include <stdint.h>
+
+#include <glib.h>
+#include <gdbus.h>
+
+#include "log.h"
+#include "sap.h"
+
+#define SAP_DUMMY_IFACE "org.bluez.SimAccessTest"
+#define SAP_DUMMY_PATH "/org/bluez/test"
+#define SAP_ONGOING_CALL_TIMER 5
+
+typedef enum {
+	SIM_CONNECTED	= 0x00,
+	SIM_DISCONNECTED= 0x01,
+	SIM_POWERED_OFF	= 0x02,
+	SIM_MISSING	= 0x03
+} sim_connection_status_t;
+
+static DBusConnection *connection = NULL;
+
+static sim_connection_status_t sim_card_connection_status = SIM_DISCONNECTED;
+static void *		sap_data = NULL;  /* SAP server private data.*/
+static gboolean		ongoing_call_status = FALSE;
+static int		max_msg_size_supported = 512;
+
+void sap_connect_req(void *sap_device, uint16_t maxmsgsize)
+{
+	if (sim_card_connection_status != SIM_CONNECTED) {
+		sap_connect_rsp(sap_device, SAP_STATUS_CONNECTION_FAILED,
+								maxmsgsize);
+		return;
+	} else if(max_msg_size_supported > maxmsgsize) {
+		sap_connect_rsp(sap_device, SAP_STATUS_MAX_MSG_SIZE_TOO_SMALL,
+						max_msg_size_supported);
+		return;
+	}else if (max_msg_size_supported < maxmsgsize) {
+		sap_connect_rsp(sap_device, SAP_STATUS_MAX_MSG_SIZE_NOT_SUPPORTED,
+					max_msg_size_supported);
+		return;
+	} else if(ongoing_call_status) {
+		sap_connect_rsp(sap_device, SAP_STATUS_OK_ONGOING_CALL,
+								maxmsgsize);
+		//run_timer
+		return;
+	} else {
+		sim_card_connection_status = SIM_CONNECTED;
+		sap_data = sap_device;
+
+		sap_connect_rsp(sap_device, SAP_STATUS_OK, maxmsgsize);
+		sap_status_ind(sap_device, SAP_STATUS_CHANGE_CARD_RESET);
+	}
+}
+
+void sap_disconnect_req(void *sap_device, uint8_t linkloss)
+{
+	sim_card_connection_status = SIM_DISCONNECTED;
+	sap_data = NULL;
+	ongoing_call_status = FALSE;
+
+	if(linkloss)
+		return;
+
+	sap_disconnect_rsp(sap_device);
+}
+
+void sap_transfer_apdu_req(void *sap_device, sap_parameter *param)
+{
+	if (sim_card_connection_status == SIM_MISSING)
+		sap_transfer_apdu_rsp(sap_device, SAP_RESULT_ERROR_CARD_REMOVED,
+								NULL, 0);
+	else if (sim_card_connection_status == SIM_POWERED_OFF)
+		sap_transfer_apdu_rsp(sap_device, SAP_RESULT_ERROR_POWERED_OFF,
+								NULL, 0);
+	else if (sim_card_connection_status != SIM_CONNECTED)
+		sap_transfer_apdu_rsp(sap_device, SAP_RESULT_ERROR_NOT_ACCESSIBLE,
+								NULL, 0);
+	else
+		sap_transfer_apdu_rsp(sap_device, SAP_RESULT_OK, NULL, 0);
+}
+
+void sap_transfer_atr_req(void * sap_device)
+{
+	uint8_t atr[] = {0x3b, 0x9a, 0x96, 0x00, 0x92, 0x01, 0x98, 0x93, 0x17,
+			 0x00, 0x02, 0x28, 0x03, 0x00};
+
+	if (sim_card_connection_status == SIM_MISSING)
+		sap_transfer_atr_rsp(sap_device, SAP_RESULT_ERROR_CARD_REMOVED,
+								NULL, 0);
+	else if (sim_card_connection_status == SIM_POWERED_OFF)
+		sap_transfer_atr_rsp(sap_device, SAP_RESULT_ERROR_POWERED_OFF,
+								NULL, 0);
+	else if (sim_card_connection_status != SIM_CONNECTED)
+		sap_transfer_atr_rsp(sap_device, SAP_RESULT_ERROR_NO_REASON,
+								NULL, 0);
+	else
+		sap_transfer_atr_rsp(sap_device, SAP_RESULT_OK, atr, 0x0E);
+}
+
+void sap_power_sim_off_req(void *sap_device)
+{
+	if(sim_card_connection_status == SIM_MISSING)
+		sap_power_sim_off_rsp(sap_device, SAP_RESULT_ERROR_CARD_REMOVED);
+	else if (sim_card_connection_status == SIM_POWERED_OFF)
+		sap_power_sim_off_rsp(sap_device, SAP_RESULT_ERROR_POWERED_OFF);
+	else if(sim_card_connection_status != SIM_CONNECTED)
+		sap_power_sim_off_rsp(sap_device, SAP_RESULT_ERROR_NO_REASON);
+	else {
+		sap_power_sim_off_rsp(sap_device, SAP_RESULT_OK);
+		sim_card_connection_status = SIM_POWERED_OFF;
+	}
+}
+
+void sap_power_sim_on_req(void *sap_device)
+{
+	if (sim_card_connection_status == SIM_MISSING)
+		sap_power_sim_on_rsp(sap_device, SAP_RESULT_ERROR_CARD_REMOVED);
+	else if (sim_card_connection_status == SIM_POWERED_OFF) {
+		sap_power_sim_on_rsp(sap_device, SAP_RESULT_OK);
+		sim_card_connection_status = SIM_CONNECTED;
+		return;
+	}else if(sim_card_connection_status != SIM_CONNECTED)
+		sap_power_sim_on_rsp(sap_device, SAP_RESULT_ERROR_NOT_ACCESSIBLE);
+	else {
+		sap_power_sim_on_rsp(sap_device, SAP_RESULT_ERROR_NO_REASON);
+	}
+}
+
+void sap_reset_sim_req(void *sap_device)
+{
+	if (sim_card_connection_status == SIM_MISSING)
+		sap_reset_sim_rsp(sap_device, SAP_RESULT_ERROR_CARD_REMOVED);
+	else if (sim_card_connection_status == SIM_POWERED_OFF)
+		sap_reset_sim_rsp(sap_device, SAP_RESULT_ERROR_POWERED_OFF);
+	else if (sim_card_connection_status != SIM_CONNECTED)
+		sap_reset_sim_rsp(sap_device, SAP_RESULT_ERROR_NO_REASON);
+	else {
+		sap_reset_sim_rsp(sap_device, SAP_RESULT_OK);
+		sap_status_ind(sap_device, SAP_STATUS_CHANGE_CARD_RESET);
+	}
+}
+
+void sap_transfer_card_reader_status_req(void * sap_device)
+{
+	if (sim_card_connection_status != SIM_CONNECTED) {
+		sap_transfer_card_reader_status_rsp(sap_device,
+					SAP_RESULT_ERROR_NO_REASON, 0xF1);
+		return;
+	}
+	sap_transfer_card_reader_status_rsp(sap_device, SAP_RESULT_OK, 0xF1);
+}
+
+void sap_set_transport_protocol_req(void * sap_device,sap_parameter * param)
+{
+	sap_transport_protocol_rsp(sap_device, SAP_RESULT_NOT_SUPPORTED);
+}
+
+static inline DBusMessage *invalid_args(DBusMessage *msg)
+{
+	return g_dbus_create_error(msg, "org.bluez.Error.InvalidArguments",
+					"Invalid arguments in method call");
+}
+
+static DBusMessage *ongoing_call(DBusConnection *conn, DBusMessage *msg,
+						void *data)
+{
+	dbus_bool_t ongoing;
+
+	if (!dbus_message_get_args(msg, NULL, DBUS_TYPE_BOOLEAN, &ongoing,
+						DBUS_TYPE_INVALID))
+		return invalid_args(msg);
+
+	if (ongoing_call_status && !ongoing) {
+		/* An ongoing call has finished. Continue connection.*/
+		sap_connect_rsp(sap_data, SAP_STATUS_OK, max_msg_size_supported);
+		sap_status_ind(sap_data, SAP_STATUS_CHANGE_CARD_RESET);
+		ongoing_call_status = ongoing;
+	} else if (!ongoing_call_status && ongoing) {
+		/* An ongoing call has started.*/
+		ongoing_call_status = ongoing;
+	}
+
+	DBG("sap-dummy: OngoingCall status set to %d", ongoing_call_status);
+
+	return dbus_message_new_method_return(msg);
+}
+
+static DBusMessage *max_msg_size(DBusConnection *conn, DBusMessage *msg,
+						void *data)
+{
+	dbus_uint32_t size;
+
+	if (sim_card_connection_status == SIM_CONNECTED)
+		return g_dbus_create_error(msg, "org.bluez.Error.Failed",
+				"Can't change msg size when connected.");
+
+	if (!dbus_message_get_args(msg, NULL, DBUS_TYPE_UINT32, &size,
+						DBUS_TYPE_INVALID))
+		return invalid_args(msg);
+
+	max_msg_size_supported = size;
+
+	DBG("sap-dummy: MaxMessageSize set to %d", max_msg_size_supported);
+
+	return dbus_message_new_method_return(msg);
+}
+
+static DBusMessage *disconnect(DBusConnection *conn, DBusMessage *msg,
+						void *data)
+{
+	sim_card_connection_status = SIM_DISCONNECTED;
+	sap_status_ind(sap_data, SAP_STATUS_CHANGE_CARD_NOT_ACCESSIBLE);
+
+	return dbus_message_new_method_return(msg);
+}
+
+static DBusMessage *card_status(DBusConnection *conn, DBusMessage *msg,
+						void *data)
+{
+	dbus_uint32_t status;
+
+	if(sim_card_connection_status != SIM_CONNECTED)
+		return g_dbus_create_error(msg, "org.bluez.Error.Failed",
+				"Can't change msg size when connected.");
+
+	if (!dbus_message_get_args(msg, NULL, DBUS_TYPE_UINT32, &status,
+						DBUS_TYPE_INVALID))
+		return invalid_args(msg);
+
+	if (status) {
+		if (sim_card_connection_status == SIM_MISSING) {
+			sim_card_connection_status = SIM_CONNECTED;
+			sap_status_ind(sap_data, SAP_STATUS_CHANGE_CARD_INSERTED);
+		}
+	} else {
+		sim_card_connection_status = SIM_MISSING;
+		sap_status_ind(sap_data, SAP_STATUS_CHANGE_CARD_REMOVED);
+	}
+
+	DBG("sap-dummy: Card status changed to %d", status);
+
+	return dbus_message_new_method_return(msg);
+}
+
+
+static GDBusMethodTable dummy_methods[] = {
+	{ "OngoingCall",	"b",	"",	ongoing_call},
+	{ "MaxMessageSize",	"u",	"",	max_msg_size},
+	{ "Disconnect",		"",	"",	disconnect},
+	{ "CardStatus",		"u",	"",	card_status},
+	{ }
+};
+
+static GDBusSignalTable dummy_signals[] = {
+	{ "","" },
+	{ }
+};
+
+int sap_init(void)
+{
+	connection = dbus_bus_get(DBUS_BUS_SYSTEM, NULL);
+
+	if (g_dbus_register_interface(connection, SAP_DUMMY_PATH,
+					SAP_DUMMY_IFACE,
+					dummy_methods, dummy_signals,
+					NULL, NULL, NULL) == FALSE) {
+		error("sap-dummy interface %s init failed on path %s",
+			SAP_DUMMY_IFACE, SAP_DUMMY_PATH);
+		return -1;
+	}
+
+	return 0;
+}
+
+void sap_exit(void)
+{
+	dbus_connection_unref(connection);
+	connection = NULL;
+}
diff --git a/sap/sap-ste.c b/sap/sap-ste.c
new file mode 100644
index 0000000..e9f99b5
--- /dev/null
+++ b/sap/sap-ste.c
@@ -0,0 +1,1265 @@
+/*
+ *  BlueZ - Bluetooth protocol stack for Linux
+ *
+ *  Copyright (C) 2010 ST-Ericsson SA
+ *
+ *  Author: Waldemar Rymarkiewicz <waldemar.rymarkiewicz@tieto.com> for
+ *  ST-Ericsson.
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation; version 2 of the License.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program; if not, write to the Free Software
+ *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
+ */
+
+#ifdef HAVE_CONFIG_H
+#include <config.h>
+#endif
+
+#include <stdio.h>
+#include <stdlib.h>
+
+#include <sys/socket.h>
+#include <sys/un.h>
+
+#include <fcntl.h>
+#include <errno.h>
+#include <glib.h>
+#include <unistd.h>
+
+#include "log.h"
+#include "sap.h"
+
+/** SAP_STE_MAX_MSG_SIZE - Maximum size of Sim Access Profile message
+ * supported by the server.
+ */
+#define SAP_STE_MAX_MSG_SIZE 	1024
+
+/** SAP_STE_MIN_MSG_SIZE - Minimal size of  Sim Access Profile message
+ * supported by the server.
+ */
+#define SAP_STE_MIN_MSG_SIZE 	512
+
+/** SAP_STE_UNIX_SOCKET_NAME - Unix socket name used to communicate with
+ * SIM daemon.
+ */
+#define SAP_STE_UNIX_SOCKET_NAME "/dev/socket/catd_a"
+
+/*Sizes of SIM message fields.*/
+#define SAP_STE_MSG_LEN_SIZE 		0x0002
+#define SAP_STE_MSG_TYPE_SIZE 		0x0002
+#define SAP_STE_MSG_CLIENT_TAG_SIZE 	0x0004
+#define SAP_STE_MSG_STATUS_SIZE 	0x0004
+
+/*Header size of SIM message */
+#define SAP_STE_MSG_HEADER_SIZE ((SAP_STE_MSG_LEN_SIZE) + \
+		(SAP_STE_MSG_TYPE_SIZE) + (SAP_STE_MSG_CLIENT_TAG_SIZE))
+
+#define SAP_STE_CLIENT_TAG 0x0000
+
+/** sap_ste_protocol_t - protocol used in communication with SIM.*/
+typedef enum {
+	SAP_STE_START_SAP_REQ 	= 0x2D01,
+	SAP_STE_START_SAP_RSP 	= 0x2E01,
+	SAP_STE_END_SAP_REQ	= 0x2D02,
+	SAP_STE_END_SAP_RSP 	= 0x2E02,
+	SAP_STE_POWER_OFF_REQ	= 0x2D03,
+	SAP_STE_POWER_OFF_RSP	= 0x2E03,
+	SAP_STE_POWER_ON_REQ 	= 0x2D04,
+	SAP_STE_POWER_ON_RSP	= 0x2E04,
+	SAP_STE_RESET_REQ	= 0x2D05,
+	SAP_STE_RESET_RSP	= 0x2E05,
+	SAP_STE_SEND_APDU_REQ	= 0x2D06,
+	SAP_STE_SEND_APDU_RSP	= 0x2E06,
+	SAP_STE_GET_ATR_REQ	= 0x2D07,
+	SAP_STE_GET_ATR_RSP	= 0x2E07,
+	SAP_STE_GET_STATUS_REQ	= 0x2D08,
+	SAP_STE_GET_STATUS_RSP	= 0x2E08,
+	SAP_STE_STATUS_IND	= 0x2F02
+} sap_ste_protocol_t;
+
+/** sap_ste_msg_t - Type of SIM message.*/
+typedef enum {
+	SAP_STE_SEND_APDU_MSG = 0,
+	SAP_STE_GET_ATR_MSG,
+	SAP_STE_POWER_OFF_MSG,
+	SAP_STE_POWER_ON_MSG,
+	SAP_STE_RESET_MSG,
+	SAP_STE_GET_STATUS_MSG,
+	SAP_STE_MSG_MAX,
+} sap_ste_msg_t;
+
+/** sap_ste_status_t - Status of a request.*/
+typedef enum {
+	SAP_STE_STATUS_OK 			= 0x00000000,
+	SAP_STE_STATUS_UNDEFINED_FAILURE 	= 0xFFFFFFFF,
+} sap_ste_status_t;
+
+/** sap_ste_card_status_t - Sim card status.*/
+typedef enum {
+	SAP_STE_CARD_STATUS_UNKNOWN = 0x00,
+	SAP_STE_CARD_STATUS_ACTIVE = 0x01,
+	SAP_STE_CARD_STATUS_NOT_ACTIVE = 0x02,
+	SAP_STE_CARD_STATUS_MISSING = 0x03,
+	SAP_STE_CARD_STATUS_INVALID = 0x04
+} sap_ste_card_status_t;
+
+/** SAP_STE_state_t - Sim connection state.*/
+typedef enum {
+		SAP_STE_DISABLED,	/* Reader not present or removed */
+		SAP_STE_POWERED_OFF,	/* Card in the reader but powered off */
+		SAP_STE_NO_CARD,	/* No card in the reader */
+		SAP_STE_ENABLED,	/* Card in the reader and powered on */
+		SAP_STE_STATE_MAX
+} sap_ste_state_t;
+
+/** sap_ste_message - Sim message format.
+ * @len;	Length of the message minus sizeof(len).
+ * @id;		Request type id.
+ * @client_tag;	SAP server cleint id.
+ * @payload;	Data.
+ */
+typedef struct {
+	uint16_t len;
+	uint16_t id;
+	uint32_t client_tag;
+	uint8_t payload[0];
+} __attribute__ ((packed)) sap_ste_message;
+
+/** sap_ste_connection - main admin structure that keeps data about connection
+ * with sim card.
+ */
+struct sap_ste_connection {
+	GIOChannel *io;
+	sap_ste_state_t state;
+	void *sap_data;
+};
+
+static struct sap_ste_connection *connection = NULL;
+
+/** sim2sap_result - Conversion table of sap result which varies with
+ * connection state and the message type.
+ */
+static const sap_result_t sim2sap_result[SAP_STE_MSG_MAX][SAP_STE_STATE_MAX] = {
+	/* SAP results for SEND APDU message */
+	{SAP_RESULT_ERROR_NOT_ACCESSIBLE,/*for SAP_STE_DISABLED state */
+	 SAP_RESULT_ERROR_POWERED_OFF,	/*for SAP_STE_POWERED_OFF state */
+	 SAP_RESULT_ERROR_CARD_REMOVED,	/*for SAP_STE_NO_CARD state */
+	 SAP_RESULT_ERROR_NO_REASON},	/*for SAP_STE_ENABLED state */
+	 /* SAP results for GET_ATR message */
+	{SAP_RESULT_ERROR_NO_REASON,
+	 SAP_RESULT_ERROR_POWERED_OFF,
+	 SAP_RESULT_ERROR_CARD_REMOVED,
+	 SAP_RESULT_ERROR_NO_REASON},
+	 /* SAP results POWER OFF message */
+	{SAP_RESULT_ERROR_NO_REASON,
+	 SAP_RESULT_ERROR_POWERED_OFF,
+	 SAP_RESULT_ERROR_CARD_REMOVED,
+	 SAP_RESULT_ERROR_NO_REASON},
+	 /* SAP results POWER ON message */
+	{SAP_RESULT_ERROR_NO_REASON,
+	 SAP_RESULT_ERROR_NOT_ACCESSIBLE,
+	 SAP_RESULT_ERROR_CARD_REMOVED,
+	 SAP_RESULT_ERROR_POWERED_ON},
+	 /* SAP results SIM RESET message */
+	{SAP_RESULT_ERROR_NO_REASON,
+	 SAP_RESULT_ERROR_POWERED_OFF,
+	 SAP_RESULT_ERROR_CARD_REMOVED,
+	 SAP_RESULT_ERROR_NOT_ACCESSIBLE},
+	 /* SAP results GET STATUS message */
+	{SAP_RESULT_ERROR_NO_REASON,
+	 SAP_RESULT_ERROR_NO_REASON,
+	 SAP_RESULT_ERROR_NO_REASON,
+	 SAP_RESULT_ERROR_NO_REASON}
+	};
+
+static void connection_uninit(struct sap_ste_connection *conn);
+static int connection_watch(int sock, void *sap_data);
+
+/**
+ * get_sap_result - Convert STE sim status to sap result.
+ * @conn;	Connection info structure.
+ * @msg;	Sim message type.
+ * @status;	Sim status.
+ *
+ * Returns:
+ *	SAP result.
+ */
+static sap_result_t get_sap_result(struct sap_ste_connection *conn,
+				sap_ste_msg_t msg, sap_ste_status_t status)
+{
+	if (!conn)
+		return SAP_RESULT_ERROR_NO_REASON;
+
+	switch (status){
+		case SAP_STE_STATUS_OK:
+			return SAP_RESULT_OK;
+
+		case SAP_STE_STATUS_UNDEFINED_FAILURE:
+			return sim2sap_result[msg][conn->state];
+
+		default:
+			error("Cannot convert sap_ste_status [status: %d] \
+						to sap_result.", status);
+			return SAP_RESULT_ERROR_NO_REASON;
+	}
+}
+
+/**
+ * get_sap_reader_status - Convert STE sim reader status to sap reader result.
+ * @status;	Sim card reader status.
+ *
+ * Returns:
+ *	SAP reader status.
+ */
+static icc_reader_status_t get_sap_reader_status(sap_ste_card_status_t status)
+{
+	switch (status){
+		case SAP_STE_CARD_STATUS_UNKNOWN:
+			return ICC_READER_UNSPECIFIED_ERROR;
+
+		case SAP_STE_CARD_STATUS_NOT_ACTIVE:
+			return ICC_READER_NOT_PRESENT;
+
+		case SAP_STE_CARD_STATUS_ACTIVE:
+			return ICC_READER_CARD_POWERED_ON;
+
+		case SAP_STE_CARD_STATUS_INVALID:
+			return ICC_READER_CARD_POWERED_OFF;
+
+		case SAP_STE_CARD_STATUS_MISSING:
+			return ICC_READER_NO_CARD;
+
+		default:
+			error("Cannot convert sap_ste_reader_status [status: %d]\
+					to icc_sap_reader_status.", status);
+			return ICC_READER_UNSPECIFIED_ERROR;
+	}
+}
+
+/**
+ * sap_status_change - Convert STE sim card status to sap change event.
+ * @conn;	Connection info structure.
+ * @status;	Sim card status.
+ *
+ * This also updates Sim connection state.
+ *
+ * Returns:
+ *	SAP change event.
+ */
+static sap_status_change_t sap_status_change(struct sap_ste_connection *conn,
+					sap_ste_card_status_t status)
+{
+	if (!conn)
+		return SAP_STATUS_CHANGE_UNKNOWN_ERROR;
+
+	switch (status){
+		case SAP_STE_CARD_STATUS_UNKNOWN:
+			return SAP_STATUS_CHANGE_UNKNOWN_ERROR;
+
+		case SAP_STE_CARD_STATUS_ACTIVE:
+			conn->state = SAP_STE_ENABLED;
+			return SAP_STATUS_CHANGE_CARD_RESET;
+
+		case SAP_STE_CARD_STATUS_NOT_ACTIVE:
+			conn->state = SAP_STE_DISABLED;
+			return SAP_STATUS_CHANGE_CARD_NOT_ACCESSIBLE;
+
+		case SAP_STE_CARD_STATUS_MISSING:
+			conn->state = SAP_STE_DISABLED;
+			return SAP_STATUS_CHANGE_CARD_REMOVED;
+
+		case SAP_STE_CARD_STATUS_INVALID:
+			conn->state = SAP_STE_DISABLED;
+			return SAP_STATUS_CHANGE_CARD_NOT_ACCESSIBLE;
+
+		default:
+			error("Cannot convert sap_ste_status_change to \
+							sap_status_change.");
+			return SAP_STATUS_CHANGE_UNKNOWN_ERROR;
+	}
+}
+/**
+ * send_message - Send Sim message to Sim daemon.
+ * @conn;	Connection info structure.
+ * @buf;	Sim message.
+ * @size;	Size of Sim message
+ *
+ * Returns:
+ *	O if success or negaive integer if error occured.
+ */
+static int send_message(struct sap_ste_connection *conn,
+					sap_ste_message *buf, gsize size)
+{
+	gsize written = 0;
+	GIOError gerr;
+
+	DBG("[STE_DRV] send_message: conn %p, buf %p size %d", conn, buf,
+								(int) size);
+
+	gerr = g_io_channel_write(conn->io, (const gchar *) buf, size, &written);
+
+	if (written != size) {
+		error("[STE_DRV] send_message: written only %d bytes out of %d"
+						, (int)written, (int)size);
+		return -1;
+	}
+
+	if (gerr != G_IO_ERROR_NONE) {
+		int err = errno;
+		error("write error: %s(%d)", strerror(err), err);
+		return -err;
+	}
+
+	return 0;
+}
+
+/**
+ * sap_ste_start_sap_req - Create and send start SAP request message.
+ * @conn;	Connection info structure.
+ *
+ * Returns:
+ *	O if success or negaive integer in case of error.
+ */
+static int sap_ste_start_sap_req(struct sap_ste_connection *conn)
+{
+	int err = 0;
+	sap_ste_message *msg = NULL;
+	gsize msg_size = SAP_STE_MSG_HEADER_SIZE;
+
+	DBG("[STE_DRV] sap_ste_start_sap_req: conn %p", conn);
+
+	msg = (sap_ste_message *)g_malloc0(msg_size);
+	if (!msg)
+		return -ENOMEM;
+
+	msg->len = msg_size - SAP_STE_MSG_LEN_SIZE;
+	msg->id = SAP_STE_START_SAP_REQ;
+	msg->client_tag = SAP_STE_CLIENT_TAG;
+
+	err = send_message(conn, msg, msg_size);
+
+	g_free(msg);
+	return err;
+}
+
+/**
+ * sap_ste_end_sap_req - Create and send end SAP request message.
+ * @conn;	Connection info structure.
+ *
+ * Returns:
+ *	O if success or negaive integer in case of error.
+ */
+static int sap_ste_end_sap_req(struct sap_ste_connection *conn)
+{
+	int err = 0;
+	sap_ste_message *msg = NULL;
+	gsize msg_size = SAP_STE_MSG_HEADER_SIZE;
+
+	DBG("[STE_DRV] sap_ste_end_sap_req: conn %p", conn);
+
+	msg = (sap_ste_message *)g_malloc0(msg_size);
+	if (!msg)
+		return -ENOMEM;
+
+	msg->len = msg_size - SAP_STE_MSG_LEN_SIZE;
+	msg->id = SAP_STE_END_SAP_REQ;
+	msg->client_tag = SAP_STE_CLIENT_TAG;
+
+	err = send_message(conn, msg, msg_size);
+
+	g_free(msg);
+	return err;
+}
+
+/**
+ * sap_ste_end_sap_req - Create and send transfer apdu request message.
+ * @conn;	Connection info structure.
+ *
+ * Returns:
+ *	O if success or negaive integer in case of error.
+ */
+static int sap_ste_send_apdu_req(struct sap_ste_connection *conn,
+						sap_parameter *param)
+{
+	int err = 0;
+	sap_ste_message *msg = NULL;
+	gsize msg_size = SAP_STE_MSG_HEADER_SIZE + param->len;
+
+	DBG("[STE_DRV] sap_ste_send_apdu_req: conn %p param %p len %d",
+							conn, param, param->len);
+
+	msg = (sap_ste_message *)g_malloc0(msg_size);
+	if (!msg)
+		return -ENOMEM;
+
+	msg->len = msg_size - SAP_STE_MSG_LEN_SIZE;
+	msg->id = SAP_STE_SEND_APDU_REQ;
+	msg->client_tag = SAP_STE_CLIENT_TAG;
+	memcpy(msg->payload, param->val, param->len);
+
+	err = send_message(conn, msg, msg_size);
+
+	g_free(msg);
+	return err;
+}
+
+/**
+ * sap_ste_get_atr_req - Create and send get ATR request message.
+ * @conn;	Connection info structure.
+ *
+ * Returns:
+ *	O if success or negaive integer in case of error.
+ */
+static int sap_ste_get_atr_req(struct sap_ste_connection *conn)
+{
+	int err = 0;
+	sap_ste_message *msg = NULL;
+	gsize msg_size = SAP_STE_MSG_HEADER_SIZE;
+
+	DBG("[STE_DRV] sap_ste_get_atr_req: conn %p", conn);
+
+	msg = (sap_ste_message *)g_malloc0(msg_size);
+	if (!msg)
+		return -ENOMEM;
+
+	msg->len = msg_size - SAP_STE_MSG_LEN_SIZE;
+	msg->id = SAP_STE_GET_ATR_REQ;
+	msg->client_tag = SAP_STE_CLIENT_TAG;
+
+	err = send_message(conn, msg, msg_size);
+
+	g_free(msg);
+	return err;
+}
+
+/**
+ * sap_ste_power_off_req - Create and send power off request message.
+ * @conn;	Connection info structure.
+ *
+ * Returns:
+ *	O if success or negaive integer in case of error.
+ */
+static int sap_ste_power_off_req(struct sap_ste_connection *conn)
+{
+	int err = 0;
+	sap_ste_message *msg = NULL;
+	gsize msg_size = SAP_STE_MSG_HEADER_SIZE;
+
+	DBG("[STE_DRV] sap_ste_power_off_req: conn %p", conn);
+
+	msg = (sap_ste_message *)g_malloc0(msg_size);
+	if (!msg)
+		return -ENOMEM;
+
+	msg->len = msg_size - SAP_STE_MSG_LEN_SIZE;
+	msg->id = SAP_STE_POWER_OFF_REQ;
+	msg->client_tag = SAP_STE_CLIENT_TAG;
+
+	err = send_message(conn, msg, msg_size);
+
+	g_free(msg);
+	return err;
+}
+
+/**
+ * sap_ste_power_on_req - Create and send power on request message.
+ * @conn;	Connection info structure.
+ *
+ * Returns:
+ *	O if success or negaive integer in case of error.
+ */
+static int sap_ste_power_on_req(struct sap_ste_connection *conn)
+{
+	int err = 0;
+	sap_ste_message *msg = NULL;
+	gsize msg_size = SAP_STE_MSG_HEADER_SIZE;
+
+	DBG("[STE_DRV] sap_ste_power_on_req: conn %p", conn);
+
+	msg = (sap_ste_message *)g_malloc0(msg_size);
+	if (!msg)
+		return -ENOMEM;
+
+	msg->len = msg_size - SAP_STE_MSG_LEN_SIZE;
+	msg->id = SAP_STE_POWER_ON_REQ;
+	msg->client_tag = SAP_STE_CLIENT_TAG;
+
+	err = send_message(conn, msg, msg_size);
+
+	g_free(msg);
+	return err;
+}
+
+/**
+ * sap_ste_reset_req - Create and send card reset request message.
+ * @conn;	Connection info structure.
+ *
+ * Returns:
+ *	O if success or negaive integer in case of error.
+ */
+static int sap_ste_reset_req(struct sap_ste_connection *conn)
+{
+	int err = 0;
+	sap_ste_message *msg = NULL;
+	gsize msg_size = SAP_STE_MSG_HEADER_SIZE;
+
+	DBG("[STE_DRV] sap_ste_reset_req: conn %p", conn);
+
+	msg = (sap_ste_message *)g_malloc0(msg_size);
+	if (!msg)
+		return -ENOMEM;
+
+	msg->len = msg_size - SAP_STE_MSG_LEN_SIZE;
+	msg->id = SAP_STE_RESET_REQ;
+	msg->client_tag = SAP_STE_CLIENT_TAG;
+
+	err = send_message(conn, msg, msg_size);
+
+	g_free(msg);
+	return err;
+}
+
+/**
+ * sap_ste_get_status_req - Create and send card status request message.
+ * @conn;	Connection info structure.
+ *
+ * Returns:
+ *	O if success or negaive integer in case of error.
+ */
+static int sap_ste_get_status_req(struct sap_ste_connection *conn)
+{
+	int err = 0;
+	sap_ste_message *msg = NULL;
+	gsize msg_size = SAP_STE_MSG_HEADER_SIZE;
+
+	DBG("[STE_DRV] sap_ste_get_status_req: conn %p", conn);
+
+	msg = (sap_ste_message *)g_malloc0(msg_size);
+	if (!msg)
+		return -ENOMEM;
+
+	msg->len = msg_size - SAP_STE_MSG_LEN_SIZE;
+	msg->id = SAP_STE_GET_STATUS_REQ;
+	msg->client_tag = SAP_STE_CLIENT_TAG;
+
+	err = send_message(conn, msg, msg_size);
+
+	g_free(msg);
+	return err;
+}
+
+/**
+ * sap_ste_start_sap_rsp - Handle start SAP response message.
+ * @conn;	Connection info structure.
+ * @msg;	Response message.
+ */
+static void sap_ste_start_sap_rsp(struct sap_ste_connection *conn,
+						sap_ste_message * msg)
+{
+	uint32_t *status;
+
+	DBG("[STE_DRV] sap_ste_start_sap_rsp: conn %p (conn %p) msg %p",
+							conn, connection, msg );
+	if (msg && conn) {
+		status = (uint32_t*) msg->payload;
+		if (*status == SAP_STE_STATUS_OK)
+			sap_connect_rsp(conn->sap_data, SAP_STATUS_OK, 0);
+		else {
+			sap_connect_rsp(conn->sap_data, SAP_STATUS_CONNECTION_FAILED, 0);
+			connection_uninit(conn);
+		}
+	}
+}
+
+/**
+ * sap_ste_end_sap_rsp - Handle end SAP response message.
+ * @conn;	Connection info structure.
+ * @msg;	Response message.
+ */
+static void sap_ste_end_sap_rsp(struct sap_ste_connection *conn,
+						sap_ste_message * msg)
+{
+	DBG("[STE_DRV] sap_ste_end_sap_rsp: conn %p (conn %p) msg %p",
+							conn, connection, msg );
+	if (msg && conn) {
+		sap_disconnect_rsp(conn->sap_data);
+		connection_uninit(conn);
+	}
+}
+
+/**
+ * sap_ste_send_apdu_rsp - Handle transfer apdu response message.
+ * @conn;	Connection info structure.
+ * @msg;	Response message.
+ */
+static void  sap_ste_send_apdu_rsp(struct sap_ste_connection *conn,
+						sap_ste_message * msg)
+{
+	uint32_t *status;
+	sap_result_t sr;
+	uint8_t *apdu = NULL;
+	uint16_t len = 0;
+
+	DBG("[STE_DRV] sap_ste_send_apdu_rsp: conn %p (conn %p) msg %p",
+							conn, connection, msg );
+
+	if (msg && conn) {
+		status = (uint32_t*) msg->payload;
+		if (*status == SAP_STE_STATUS_OK) {
+			apdu = (uint8_t *)(msg->payload + SAP_STE_MSG_STATUS_SIZE);
+			len = msg->len - (SAP_STE_MSG_HEADER_SIZE) +
+				SAP_STE_MSG_LEN_SIZE - SAP_STE_MSG_STATUS_SIZE;
+		}
+
+		sr = get_sap_result(conn, SAP_STE_SEND_APDU_MSG, *status);
+		sap_transfer_apdu_rsp(conn->sap_data, sr, apdu, len);
+	}
+}
+
+/**
+ * sap_ste_get_atr_rsp - Handle get ATR response message.
+ * @conn;	Connection info structure.
+ * @msg;	Response message.
+ */
+static void sap_ste_get_atr_rsp(struct sap_ste_connection *conn,
+						sap_ste_message * msg)
+{
+	uint32_t *status;
+	sap_result_t sr;
+	uint8_t *atr = NULL;
+	uint16_t len = 0;
+
+	DBG("[STE_DRV] sap_ste_get_atr_rsp: conn %p (conn %p) msg %p",
+							conn, connection, msg );
+
+	if (msg && conn) {
+		status = (uint32_t*) msg->payload;
+		if (*status == SAP_STE_STATUS_OK) {
+			atr = (uint8_t *)(msg->payload + SAP_STE_MSG_STATUS_SIZE);
+			len = msg->len - (SAP_STE_MSG_HEADER_SIZE) +
+							SAP_STE_MSG_LEN_SIZE;
+		}
+
+		sr = get_sap_result(conn, SAP_STE_GET_ATR_MSG, *status);
+		sap_transfer_atr_rsp(conn->sap_data, sr, atr, len);
+	}
+}
+
+/**
+ * sap_ste_power_off_rsp - Handle power off response message.
+ * @conn;	Connection info structure.
+ * @msg;	Response message.
+ */
+static void sap_ste_power_off_rsp(struct sap_ste_connection *conn,
+							sap_ste_message * msg)
+{
+	uint32_t *status;
+	sap_result_t sr;
+
+	DBG("[STE_DRV] sap_ste_power_off_rsp: conn %p (conn %p) msg %p",
+							conn, connection, msg );
+
+	if (msg && conn) {
+		status = (uint32_t *) msg->payload;
+		if (*status == SAP_STE_STATUS_OK)
+			conn->state = SAP_STE_POWERED_OFF;
+
+		sr = get_sap_result(conn, SAP_STE_POWER_OFF_MSG, *status);
+		sap_power_sim_off_rsp(conn->sap_data, sr);
+	}
+}
+
+/**
+ * sap_ste_power_on_rsp - Handle power on response message.
+ * @conn;	Connection info structure.
+ * @msg;	Response message.
+ */
+static void sap_ste_power_on_rsp(struct sap_ste_connection *conn,
+						sap_ste_message * msg)
+{
+	uint32_t *status;
+	sap_result_t sr;
+
+	DBG("[STE_DRV] sap_ste_power_on_rsp: conn %p (conn %p) msg %p",
+							conn, connection, msg );
+
+	if (msg && conn) {
+		status = (uint32_t *) msg->payload;
+		if (*status == SAP_STE_STATUS_OK)
+			conn->state = SAP_STE_ENABLED;
+
+		sr = get_sap_result(conn, SAP_STE_POWER_ON_MSG, *status);
+		sap_power_sim_on_rsp(conn->sap_data, sr);
+	}
+}
+
+/**
+ * sap_ste_reset_rsp - Handle reset response message.
+ * @conn;	Connection info structure.
+ * @msg;	Response message.
+ */
+static void sap_ste_reset_rsp(struct sap_ste_connection *conn,
+					sap_ste_message * msg)
+{
+	uint32_t *status;
+	sap_result_t sr;
+
+	DBG("[STE_DRV] sap_ste_reset_rsp: conn %p (conn %p) msg %p",
+							conn, connection, msg );
+
+	if (msg && conn) {
+		status = (uint32_t *) msg->payload;
+		if (*status == SAP_STE_STATUS_OK)
+			conn->state = SAP_STE_ENABLED;
+
+		sr = get_sap_result(conn, SAP_STE_RESET_MSG, *status);
+		sap_reset_sim_rsp(conn->sap_data, sr);
+	}
+}
+
+/**
+ * sap_ste_get_status_rsp - Handle card status response message.
+ * @conn;	Connection info structure.
+ * @msg;	Response message.
+ */
+static void sap_ste_get_status_rsp(struct sap_ste_connection *conn,
+						sap_ste_message * msg)
+{
+	uint8_t *p = NULL;
+	uint32_t *status;
+	sap_result_t sr;
+	sap_ste_card_status_t cs;
+	icc_reader_status_t iccrs;
+
+	DBG("[STE_DRV] sap_ste_get_status_rsp: conn %p (conn %p) msg %p",
+							conn, connection, msg );
+
+	if (msg && conn) {
+		p = msg->payload;
+		status = (uint32_t *)p; p += sizeof(uint32_t);
+		cs = *((uint16_t *)p);
+
+		iccrs = get_sap_reader_status(cs);
+		sr = get_sap_result(conn, SAP_STE_GET_STATUS_MSG, *status);
+		sap_transfer_card_reader_status_rsp(conn->sap_data, sr, iccrs);
+	}
+}
+
+/**
+ * sap_ste_status_ind - Handle status indication message.
+ * @conn;	Connection info structure.
+ * @msg;	Response message.
+ */
+static void sap_ste_status_ind(struct sap_ste_connection *conn,
+							sap_ste_message * msg)
+{
+	sap_status_change_t sc;
+	sap_ste_card_status_t cs;
+	uint32_t *status;
+
+	DBG("[STE_DRV] sap_ste_status_ind: conn %p (conn %p) msg %p",
+							conn, connection, msg );
+
+	if (msg && conn) {
+		status = (uint32_t *) msg->payload;
+		cs = *status;
+		sc = sap_status_change(conn, cs);
+
+		sap_status_ind(conn->sap_data, sc);
+	}
+}
+
+/**
+ * handle_msg - Handle messages from Sim daemon.
+ * @conn;	Connection info structure.
+ * @buf;	Data buffer.
+ * @size;	Size of data buffer.
+ *
+ * Returns:
+ *    0 if success or EBADMSG in case of bad message format.
+ */
+static int handle_msg(struct sap_ste_connection *conn, unsigned char *buf,
+								gsize size)
+{
+	unsigned char *iter = buf;
+	sap_ste_message * msg = (sap_ste_message *) buf;
+	gssize msize = (gssize) size;
+
+	DBG("[STE_DRV] handle_msg: msg %p conn %p", msg, conn);
+
+	if (msg == NULL || conn == NULL)
+		return -EFAULT;
+
+	do {
+		DBG("[STE_DRV] handle_msg: msize %d msg->len %d.",
+							(int)msize, msg->len);
+
+		/* Message must be at least size of header len */
+		if (msize < SAP_STE_MSG_HEADER_SIZE) {
+			error("[STE_DRV] Invalid message size.");
+			return -EBADMSG;
+		}
+
+		/* Message must be completed. */
+		if (msize < (SAP_STE_MSG_LEN_SIZE + msg->len)) {
+			error("[STE_DRV] Not complete message.");
+			return -EBADMSG;
+		}
+
+		switch (msg->id){
+			case SAP_STE_START_SAP_RSP:
+				sap_ste_start_sap_rsp(conn, msg);
+				break;
+
+			case SAP_STE_END_SAP_RSP:
+				sap_ste_end_sap_rsp(conn, msg);
+				break;
+
+			case SAP_STE_SEND_APDU_RSP:
+				sap_ste_send_apdu_rsp(conn, msg);
+				break;
+
+			case SAP_STE_GET_ATR_RSP:
+				sap_ste_get_atr_rsp(conn, msg);
+				break;
+
+			case SAP_STE_POWER_OFF_RSP:
+				sap_ste_power_off_rsp(conn, msg);
+				break;
+
+			case SAP_STE_POWER_ON_RSP:
+				sap_ste_power_on_rsp(conn, msg);
+				break;
+
+			case SAP_STE_RESET_RSP:
+				sap_ste_reset_rsp(conn, msg);
+				break;
+
+			case SAP_STE_GET_STATUS_RSP:
+				sap_ste_get_status_rsp(conn, msg);
+				break;
+
+			case SAP_STE_STATUS_IND:
+				sap_ste_status_ind(conn, msg);
+				break;
+
+			default:
+				error("[STE_DRV] Invalid or not supported \
+						frame [0x%02x].", msg->id);
+		}
+
+		/* Reduce total buffer size of just handled frame size*/
+		msize -= (SAP_STE_MSG_HEADER_SIZE +
+				(msg->len - (SAP_STE_MSG_HEADER_SIZE) +
+				 SAP_STE_MSG_LEN_SIZE));
+
+		/* Move msg ponter to then next message if any */
+		iter += (msg->len + SAP_STE_MSG_LEN_SIZE);
+		msg = (sap_ste_message *)iter;
+	} while (msize > 0);
+
+	return 0;
+}
+
+/**
+ * connection_io_data_cb - Handle data on socket to Sim daemon.
+ * @io;		Connection info structure.
+ * @conn;	Conndition that triggered this callback.
+ * @data;	Data buffor.
+ *
+ * Returns:
+ *    True if @data was handled, False otherwise.
+ */
+static gboolean connection_io_data_cb(GIOChannel *io, GIOCondition cond,
+							gpointer data)
+{
+	GIOError err = G_IO_ERROR_NONE;
+	unsigned char buf[SAP_STE_MAX_MSG_SIZE];
+	gsize read_bytes = 0;
+
+	if (cond & G_IO_NVAL) {
+		DBG("[STE_DRV] NVAL on sim socket");
+		return FALSE;
+	}
+
+	if (cond & G_IO_HUP) {
+		DBG("[STE_DRV] HUP on sim socket");
+		return FALSE;
+	}
+
+	if (cond & G_IO_ERR) {
+		DBG("[STE_DRV] ERR on sim socket");
+		return FALSE;
+	}
+
+	err = g_io_channel_read(io, (gchar *)buf, sizeof(buf), &read_bytes);
+	if (err != G_IO_ERROR_NONE) {
+		error("[STE_DRV] Error while reading from channel \
+						[err 0x%x io %p].", err, io);
+		return FALSE;
+	}
+
+	if (handle_msg(data, buf, read_bytes) < 0)
+		error("[STE_DRV] Invalid STE Sim message.");
+
+	return TRUE;
+}
+
+/**
+ * connection_io_destroy_cb - Clean up the SAP serer in case of socket closure.
+ * @data;	Private data.
+ *
+ * The callback is run if the connection with Sim daemon has been lost.
+ */
+static void connection_io_destroy_cb(void *data)
+{
+	struct sap_ste_connection *conn = (struct sap_ste_connection *)data;
+
+	if (conn && connection) {
+		DBG("[STE_DRV] connection_io_destroy_cb: conn %p conn %p io %p",
+						conn, connection, conn->io);
+
+		g_io_channel_unref(conn->io);
+		g_io_channel_shutdown(conn->io, TRUE, NULL);
+		g_free(conn);
+		connection = NULL;
+	}
+}
+
+/**
+ * connection_init - Initialize connection with Sim Daemon.
+ * @sap_data;	Private data of SAP Server.
+ *
+ * Returns:
+ *    0 if success, negative number in case of an error.
+ */
+static int connection_init(void * sap_data)
+{
+	int sock;
+	int len = 0;
+	struct sockaddr_un addr;
+	ssize_t addr_len;
+
+	/* Create a socket to communicate with SIMD*/
+	sock = socket(PF_UNIX, SOCK_STREAM, 0);
+	if (sock < 0) {
+		error("[STE_DRV] Create socket failed: %s", strerror(errno));
+		return -errno;
+	}
+
+	/*Connect to SIMD*/
+	memset(&addr, 0, sizeof(addr));
+	addr.sun_family = AF_UNIX;
+	len = sprintf(addr.sun_path, SAP_STE_UNIX_SOCKET_NAME);
+	addr_len = sizeof(addr.sun_family) + len;
+	if (connect(sock, (struct sockaddr *) &addr, addr_len) < 0) {
+		error("[STE_DRV] Connect to the socket failed:  %s",
+							strerror(errno));
+		goto drop;
+	}
+
+	if (fcntl(sock, F_SETFL, O_NONBLOCK) > 0) {
+		error("[STE_DRV] fcntl() failed: %s", strerror(errno));
+		goto drop;
+	}
+
+	DBG("[STE_DRV] connection_init: sock %d ",sock);
+
+	/* Start watching incoming data */
+	if (connection_watch(sock, sap_data) < 0)
+		goto drop;
+
+	return 0;
+
+drop:
+	DBG("[STE_DRV] connection_init: drop!");
+	close(sock);
+	return -errno;
+}
+
+/**
+ * connection_uninit - Disconnect from Sim daemon.
+ * @conn;	Connection info structure.
+ */
+static void connection_uninit(struct sap_ste_connection *conn)
+{
+	DBG("[STE_DRV] connection_uninit: conn %p connection %p", conn,
+								connection);
+
+	if (!conn)
+		return;
+
+	g_io_channel_shutdown(conn->io, TRUE, NULL);
+	g_io_channel_unref(conn->io);
+	g_free(conn);
+
+	connection = NULL;
+}
+
+
+/**
+ * connection_watch - Start watching Sim daemon connection.
+ * @sap_data;	Private data of SAP Server.
+ *
+ * Returns:
+ *    0 if success, negative number in case of an error.
+ */
+static int connection_watch(int sock, void *sap_data)
+{
+	GIOChannel *io = NULL;
+
+	DBG("[STE_DRV] connection_watch: sock %d, sap_data %p ", sock,
+								sap_data);
+
+	if (sock < 0)
+		return -1;
+
+	io = g_io_channel_unix_new(sock);
+	g_io_channel_set_close_on_unref(io, TRUE);
+
+
+	connection = g_new0(struct sap_ste_connection, 1);
+	if (!connection) {
+		error("[STE_DRV] connection_watch: connection %p io %p",
+								connection, io);
+		g_io_channel_shutdown(io, TRUE, NULL);
+		g_io_channel_unref(io);
+		return -1;
+	}
+
+	connection->io = io;
+	connection->sap_data = sap_data;
+	connection->state = SAP_STE_DISABLED;
+
+	g_io_add_watch_full(io, G_PRIORITY_DEFAULT,
+			G_IO_IN | G_IO_ERR | G_IO_HUP | G_IO_NVAL,
+			connection_io_data_cb, connection, connection_io_destroy_cb);
+
+	return 0;
+}
+
+/**
+ * sap_connect_req - Handle SAP connect request.
+ * @sap_data;	Private data of SAP Server.
+ * @maxmsgsize;	Message size supported by the SAP client.
+ */
+void sap_connect_req(void *sap_device, uint16_t maxmsgsize)
+{
+
+	DBG("[STE_DRV] sap_connect_req: conn %p sap_device %p maxmsgsize %d",
+			connection, sap_device, maxmsgsize);
+
+	if (maxmsgsize < SAP_STE_MIN_MSG_SIZE) {
+		sap_connect_rsp(sap_device, SAP_STATUS_MAX_MSG_SIZE_TOO_SMALL,
+							SAP_STE_MAX_MSG_SIZE);
+		return;
+	}
+
+	if (maxmsgsize > SAP_STE_MAX_MSG_SIZE) {
+		sap_connect_rsp(sap_device, SAP_STATUS_MAX_MSG_SIZE_NOT_SUPPORTED,
+							SAP_STE_MAX_MSG_SIZE);
+		return;
+	}
+
+	if (connection_init(sap_device) < 0) {
+		DBG("[STE_DRV] connection_init: failed!");
+		sap_connect_rsp(sap_device, SAP_STATUS_CONNECTION_FAILED, 0);
+		return;
+	}
+
+	if (connection && connection->state == SAP_STE_DISABLED) {
+		if (sap_ste_start_sap_req(connection) < 0) {
+			sap_connect_rsp(sap_device, SAP_STATUS_CONNECTION_FAILED,
+							SAP_STE_MAX_MSG_SIZE);
+			connection_uninit(connection);
+		}
+	} else {
+		DBG("[STE_DRV] Connection failed! (connection %p) ", connection);
+		sap_connect_rsp(sap_device, SAP_STATUS_CONNECTION_FAILED, 0);
+	}
+}
+
+/**
+ * sap_disconnect_req - Handle SAP disconnect request.
+ * @sap_data;	Private data of SAP Server.
+ * @linkloss;	Indicates thet link is being disconnected due to link loss.
+ */
+void sap_disconnect_req(void *sap_device, uint8_t linkloss)
+{
+	DBG("[STE_DRV] sap_disconnect_req: conn %p sap_device %p linkloss %d",
+					connection, sap_device, linkloss);
+	if (connection && linkloss) {
+		connection_uninit(connection);
+		return;
+	}
+
+	if (connection && connection->state != SAP_STE_DISABLED) {
+		if (sap_ste_end_sap_req(connection) < 0) {
+			sap_disconnect_rsp(sap_device);
+		}
+	} else {
+		sap_disconnect_rsp(sap_device);
+	}
+}
+
+/**
+ * sap_transfer_apdu_req - Handle SAP transfer apdu request.
+ * @sap_data;	Private data of SAP Server.
+ * @param;	SAP parameter of the request.
+ */
+void sap_transfer_apdu_req(void *sap_device, sap_parameter *param)
+{
+	sap_result_t sr;
+
+	DBG("[STE_DRV] sap_transfer_apdu_req: conn %p sap_device %p param %p\
+		param len %d", connection, sap_device, param, param->len);
+
+	if (connection && connection->state == SAP_STE_ENABLED) {
+		if (sap_ste_send_apdu_req(connection, param) < 0)
+			sap_transfer_apdu_rsp(sap_device,
+					SAP_RESULT_ERROR_NO_REASON, NULL, 0);
+	} else {
+		sr = get_sap_result(connection, SAP_STE_SEND_APDU_MSG,
+					SAP_STE_STATUS_UNDEFINED_FAILURE);
+		sap_transfer_apdu_rsp(sap_device, sr, NULL, 0);
+	}
+}
+
+/**
+ * sap_transfer_atr_req - Handle SAP ATR request.
+ * @sap_data;	Private data of SAP Server.
+ */
+void sap_transfer_atr_req(void * sap_device)
+{
+	sap_result_t sr;
+
+	DBG("[STE_DRV] sap_transfer_atr_req: conn %p, sap_device %p",
+							connection, sap_device);
+
+	if (connection && connection->state == SAP_STE_ENABLED) {
+		if (sap_ste_get_atr_req(connection) < 0)
+			sap_transfer_atr_rsp(sap_device,
+				SAP_RESULT_ERROR_NO_DATA, NULL, 0);
+	} else {
+		sr = get_sap_result(connection, SAP_STE_GET_ATR_MSG,
+					SAP_STE_STATUS_UNDEFINED_FAILURE);
+		sap_transfer_atr_rsp(sap_device, sr, NULL, 0);
+	}
+}
+
+/**
+ * sap_power_sim_off_req - Handle SAP power off request.
+ * @sap_data;	Private data of SAP Server.
+ */
+void sap_power_sim_off_req(void *sap_device)
+{
+	sap_result_t sr;
+
+	DBG("[STE_DRV] sap_power_sim_off_req: conn %p, sap_device %p",
+							connection, sap_device);
+
+	if (connection && connection->state == SAP_STE_ENABLED) {
+		if (sap_ste_power_off_req(connection) < 0)
+			sap_power_sim_off_rsp(sap_device,
+					SAP_RESULT_ERROR_NO_REASON);
+	} else {
+		sr = get_sap_result(connection, SAP_STE_POWER_OFF_MSG,
+					SAP_STE_STATUS_UNDEFINED_FAILURE);
+		sap_power_sim_off_rsp(sap_device, sr);
+	}
+}
+
+/**
+ * sap_power_sim_on_req - Handle SAP power on request.
+ * @sap_data;	Private data of SAP Server.
+ */
+void sap_power_sim_on_req(void *sap_device)
+{
+	sap_result_t sr;
+
+	DBG("[STE_DRV] sap_power_sim_on_req: conn %p, sap_device %p",
+							connection, sap_device);
+
+	if (connection && connection->state == SAP_STE_POWERED_OFF) {
+		if (sap_ste_power_on_req(connection) < 0)
+			sap_power_sim_on_rsp(sap_device,
+					SAP_RESULT_ERROR_NO_REASON);
+	} else {
+		sr = get_sap_result(connection, SAP_STE_POWER_ON_MSG,
+					SAP_STE_STATUS_UNDEFINED_FAILURE);
+		sap_power_sim_on_rsp(sap_device, sr);
+	}
+}
+
+/**
+ * sap_reset_sim_req - Handle SAP reset request.
+ * @sap_data;	Private data of SAP Server.
+ */
+void sap_reset_sim_req(void *sap_device)
+{
+	sap_result_t sr;
+
+	DBG("[STE_DRV] sap_reset_sim_req: conn %p, sap_device %p",
+							connection, sap_device);
+
+	if (connection && connection->state == SAP_STE_ENABLED) {
+		if (sap_ste_reset_req(connection) < 0)
+			sap_reset_sim_rsp(sap_device,
+						SAP_RESULT_ERROR_NO_REASON);
+	} else {
+		sr = get_sap_result(connection, SAP_STE_RESET_MSG,
+					SAP_STE_STATUS_UNDEFINED_FAILURE);
+		sap_reset_sim_rsp(sap_device, sr);
+	}
+}
+
+/**
+ * sap_transfer_card_reader_status_req - Handle get card reader status request.
+ * @sap_data;	Private data of SAP Server.
+ */
+void sap_transfer_card_reader_status_req(void * sap_device)
+{
+	sap_result_t sr;
+
+	DBG("[STE_DRV] sap_transfer_card_reader_status_req: conn %p, \
+					sap_device %p", connection, sap_device);
+
+	if (connection && connection->state != SAP_STE_DISABLED) {
+		if (sap_ste_get_status_req(connection) < 0)
+			sap_transfer_card_reader_status_rsp(sap_device,
+						SAP_RESULT_ERROR_NO_DATA,
+						ICC_READER_UNSPECIFIED_ERROR);
+	} else {
+		sr = get_sap_result(connection, SAP_STE_GET_STATUS_MSG,
+					SAP_STE_STATUS_UNDEFINED_FAILURE);
+		sap_transfer_card_reader_status_rsp(sap_device, sr,
+						ICC_READER_UNSPECIFIED_ERROR);
+	}
+}
+
+/**
+ * sap_set_transport_protocol_req - Handle set transport protocol request.
+ * @sap_data;	Private data of SAP Server.
+ */
+void sap_set_transport_protocol_req(void * sap_device,sap_parameter * param)
+{
+	sap_transport_protocol_rsp(sap_device, SAP_RESULT_NOT_SUPPORTED);
+}
+
+int sap_init(void)
+{
+	return 0;
+}
+
+void sap_exit(void)
+{
+}
diff --git a/sap/sap.h b/sap/sap.h
new file mode 100644
index 0000000..a9189fc
--- /dev/null
+++ b/sap/sap.h
@@ -0,0 +1,187 @@
+/*
+ *  BlueZ - Bluetooth protocol stack for Linux
+ *
+ *  Copyright (C) 2010 ST-Ericsson SA
+ *  Copyright (C) 2010 Claudio Takahasi<claudio.takahasi@openbossa.org>
+ *
+ *  Author: Marek Skowron <marek.skowron@tieto.com> for ST-Ericsson.
+ *  Author: Waldemar Rymarkiewicz <waldemar.rymarkiewicz@tieto.com> for ST-Ericsson.
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation; version 2 of the License.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program; if not, write to the Free Software
+ *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
+ */
+
+#include <stdint.h>
+#include <glib.h>
+
+ #define SAP_VERSION 0x0101
+
+/* Connection Status - SAP v1.1 section 5.2.2 */
+typedef enum {
+	SAP_STATUS_OK 				= 0x00,
+	SAP_STATUS_CONNECTION_FAILED		= 0x01,
+	SAP_STATUS_MAX_MSG_SIZE_NOT_SUPPORTED	= 0x02,
+	SAP_STATUS_MAX_MSG_SIZE_TOO_SMALL	= 0x03,
+	SAP_STATUS_OK_ONGOING_CALL		= 0x04
+} sap_status_t;
+
+/* Disconnection Type - SAP v1.1 section 5.2.3 */
+typedef enum {
+	SAP_DISCONNECTION_TYPE_GRACEFUL  = 0x00,
+	SAP_DISCONNECTION_TYPE_IMMEDIATE = 0x01,
+	SAP_DISCONNECTION_TYPE_CLIENT    = 0xFF
+} sap_disconnection_type_t;
+
+/* Result codes - SAP v1.1 section 5.2.4 */
+typedef enum {
+	SAP_RESULT_OK 			= 0x00,
+	SAP_RESULT_ERROR_NO_REASON	= 0x01,
+	SAP_RESULT_ERROR_NOT_ACCESSIBLE	= 0x02,
+	SAP_RESULT_ERROR_POWERED_OFF	= 0x03,
+	SAP_RESULT_ERROR_CARD_REMOVED	= 0x04,
+	SAP_RESULT_ERROR_POWERED_ON	= 0x05,
+	SAP_RESULT_ERROR_NO_DATA	= 0x06,
+	SAP_RESULT_NOT_SUPPORTED	= 0x07
+} sap_result_t;
+
+/* Status Change - SAP v1.1 section 5.2.8 */
+typedef enum {
+	SAP_STATUS_CHANGE_UNKNOWN_ERROR	= 0x00,
+	SAP_STATUS_CHANGE_CARD_RESET	= 0x01,
+	SAP_STATUS_CHANGE_CARD_NOT_ACCESSIBLE = 0x02,
+	SAP_STATUS_CHANGE_CARD_REMOVED	= 0x03,
+	SAP_STATUS_CHANGE_CARD_INSERTED	= 0x04,
+	SAP_STATUS_CHANGE_CARD_RECOVERED = 0x05
+} sap_status_change_t;
+
+/* Message format - SAP v1.1 section 5.1 */
+typedef struct {
+	uint8_t id;
+	uint8_t reserved;
+	uint16_t len;
+	uint8_t val[0];
+	/*
+	 * Padding bytes 0-3 bytes
+	 */
+} __attribute__ ((packed)) sap_parameter;
+
+typedef struct {
+	uint8_t id;
+	uint8_t nparam;
+	uint16_t reserved;
+	sap_parameter param[0];
+} __attribute__ ((packed)) sap_message;
+
+
+typedef enum {
+	ICC_READER_UNSPECIFIED_ERROR, /* No further information available */
+	ICC_READER_NOT_PRESENT,       /* Card Reader removed or not present */
+	ICC_READER_BUSY,              /* Card Reader in use */
+	ICC_READER_CARD_POWERED_ON,   /* Card in reader and is powered on */
+	ICC_READER_DEACTIVATED,       /* Card Reader deactivated */
+	ICC_READER_CARD_POWERED_OFF,  /* Card in reader, but powered off */
+	ICC_READER_NO_CARD,           /* No card in reader */
+	ICC_READER_LAST
+} icc_reader_status_t;
+
+
+#define SAP_BUF_SIZE		512
+
+#define SAP_MSG_HEADER_SIZE	4
+
+typedef enum {
+	SAP_CONNECT_REQ		= 0x00,
+	SAP_CONNECT_RESP	= 0x01,
+	SAP_DISCONNECT_REQ	= 0x02,
+	SAP_DISCONNECT_RESP	= 0x03,
+	SAP_DISCONNECT_IND	= 0x04,
+	SAP_TRANSFER_APDU_REQ	= 0x05,
+	SAP_TRANSFER_APDU_RESP	= 0x06,
+	SAP_TRANSFER_ATR_REQ	= 0x07,
+	SAP_TRANSFER_ATR_RESP	= 0x08,
+	SAP_POWER_SIM_OFF_REQ	= 0x09,
+	SAP_POWER_SIM_OFF_RESP	= 0x0A,
+	SAP_POWER_SIM_ON_REQ	= 0x0B,
+	SAP_POWER_SIM_ON_RESP	= 0x0C,
+	SAP_RESET_SIM_REQ	= 0x0D,
+	SAP_RESET_SIM_RESP	= 0x0E,
+	SAP_TRANSFER_CARD_READER_STATUS_REQ	= 0x0F,
+	SAP_TRANSFER_CARD_READER_STATUS_RESP	= 0x10,
+	SAP_STATUS_IND	= 0x11,
+	SAP_ERROR_RESP	= 0x12,
+	SAP_SET_TRANSPORT_PROTOCOL_REQ	= 0x13,
+	SAP_SET_TRANSPORT_PROTOCOL_RESP	= 0x14,
+} sap_protocol;
+
+/* Parameters Ids - SAP 1.1 section 5.2 */
+#define SAP_PARAM_ID_MAX_MSG_SIZE             0x00
+#define SAP_PARAM_ID_MAX_MSG_SIZE_LEN         0x02
+
+#define SAP_PARAM_ID_CONN_STATUS            0x01
+#define SAP_PARAM_ID_CONN_STATUS_LEN        0x01
+
+#define SAP_PARAM_ID_RESULT_CODE            0x02
+#define SAP_PARAM_ID_RESULT_CODE_LEN        0x01
+
+#define SAP_PARAM_ID_DISCONNECT_IND         0x03
+#define SAP_PARAM_ID_DISCONNECT_IND_LEN     0x01
+
+#define SAP_PARAM_ID_COMMAND_APDU           0x04
+#define SAP_PARAM_ID_RESPONSE_APDU          0x05
+#define SAP_PARAM_ID_ATR                    0x06
+
+#define SAP_PARAM_ID_CARD_READER_STATUS     0x07
+#define SAP_PARAM_ID_CARD_READER_STATUS_LEN 0x01
+
+#define SAP_PARAM_ID_STATUS_CHANGE          0x08
+#define SAP_PARAM_ID_STATUS_CHANGE_LEN      0x01
+
+#define SAP_PARAM_ID_TRANSPORT_PROTOCOL     0x09
+#define SAP_PARAM_ID_TRANSPORT_PROTOCOL_LEN 0x01
+
+#define SAP_PARAM_ID_COMMAND_APDU7816       0x10
+
+/* Transport Protocol - SAP v1.1 section 5.2.9 */
+#define SAP_TRANSPORT_PROTOCOL_T0           0x00
+#define SAP_TRANSPORT_PROTOCOL_T1           0x01
+
+/*SAP driver init and exit routines. Implemented by sap-*.c */
+int sap_init(void);
+void sap_exit(void);
+
+/* SAP requests implemented by sap-*.c */
+void sap_connect_req(void *sap_device, uint16_t maxmsgsize);
+void sap_disconnect_req(void *sap_device, uint8_t linkloss);
+void sap_transfer_apdu_req(void *sap_device, sap_parameter *param);
+void sap_transfer_atr_req(void *sap_device);
+void sap_power_sim_off_req(void *sap_device);
+void sap_power_sim_on_req(void *sap_device);
+void sap_reset_sim_req(void *sap_device);
+void sap_transfer_card_reader_status_req(void *sap_device);
+void sap_set_transport_protocol_req(void *sap_device, sap_parameter *param);
+
+/*SAP responses to SAP requests. Implemented by server.c */
+int sap_connect_rsp(void *sap_device, sap_status_t status, uint16_t maxmsgsize);
+int sap_disconnect_rsp(void *sap_device);
+int sap_transfer_apdu_rsp(void *sap_device, sap_result_t result, uint8_t *sap_apdu_resp, uint16_t length);
+int sap_transfer_atr_rsp(void *sap_device, sap_result_t result, uint8_t *sap_atr, uint16_t length);
+int sap_power_sim_off_rsp(void *sap_device, sap_result_t result);
+int sap_power_sim_on_rsp(void *sap_device, sap_result_t result);
+int sap_reset_sim_rsp(void *sap_device, sap_result_t result);
+int sap_transfer_card_reader_status_rsp(void *sap_device, sap_result_t result, icc_reader_status_t status);
+int sap_error_rsp(void *sap_device);
+int sap_transport_protocol_rsp(void *sap_device, sap_result_t result);
+
+/* Event indication. Implemented by server.c*/
+int sap_status_ind(void *sap_device, sap_status_change_t status_change);
+
diff --git a/sap/server.c b/sap/server.c
new file mode 100644
index 0000000..683df5e
--- /dev/null
+++ b/sap/server.c
@@ -0,0 +1,1516 @@
+/*
+ *  BlueZ - Bluetooth protocol stack for Linux
+ *
+ *  Copyright (C) 2010 ST-Ericsson SA
+ *  Copyright (C) 2010 Claudio Takahasi<claudio.takahasi@openbossa.org>
+ *
+ *  Author: Marek Skowron <marek.skowron@tieto.com> for ST-Ericsson.
+ *  Author: Waldemar Rymarkiewicz <waldemar.rymarkiewicz@tieto.com> for ST-Ericsson.
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation; version 2 of the License.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program; if not, write to the Free Software
+ *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
+ */
+
+#ifdef HAVE_CONFIG_H
+#include <config.h>
+#endif
+
+#include <stdio.h>
+#include <errno.h>
+#include <glib.h>
+#include <gdbus.h>
+#include <netinet/in.h>
+
+#include <bluetooth/bluetooth.h>
+#include <bluetooth/sdp.h>
+#include <bluetooth/sdp_lib.h>
+
+#include "adapter.h"
+#include "btio.h"
+#include "sdpd.h"
+#include "log.h"
+#include "error.h"
+#include "dbus-common.h"
+
+#include "sap.h"
+#include "server.h"
+
+#define SAP_SERVER_INTERFACE	"org.bluez.SimAccess"
+#define SAP_UUID		"0000112D-0000-1000-8000-00805F9B34FB"
+#define SAP_SERVER_CHANNEL	8
+#define SAP_BUF_SIZE		512
+
+#define PADDING4(x) (4 - (x & 0x03))
+#define PARAMETER_SIZE(x) (sizeof(sap_parameter) + x + PADDING4(x))
+
+#define SAP_NO_REQ 0xFF
+
+#define SAP_TIMER_GRACEFUL_DISCONNECT 30
+#define SAP_TIMER_NO_ACTIVITY 30
+
+typedef enum {
+	SAP_STATE_DISCONNECTED,
+	SAP_STATE_CONNECT_IN_PROGRESS,
+	SAP_STATE_CONNECTED,
+	SAP_STATE_GRACEFUL_DISCONNECT,
+	SAP_STATE_IMMEDIATE_DISCONNECT,
+	SAP_STATE_CLIENT_DISCONNECT
+} sap_state_t;
+
+struct sap_server {
+	bdaddr_t src;
+	char *path;
+	gboolean enable;
+	uint32_t record_id;
+	GIOChannel *listen_io;
+	GIOChannel *io;  /* Connected client channel.*/
+	sap_state_t state;
+	uint8_t processing_req;
+	guint timer_id;
+};
+
+static DBusConnection *connection = NULL;
+
+static void connect_req(void *data, sap_parameter *param);
+static int disconnect_req(void *data, sap_disconnection_type_t disc_type);
+static void transfer_apdu_req(void *data, sap_parameter *param);
+static void transfer_atr_req(void *data);
+static void power_sim_off_req(void *data);
+static void power_sim_on_req(void *data);
+static void reset_sim_req(void *data);
+static void transfer_card_reader_status_req(void *data);
+static void set_transport_protocol_req(void *data, sap_parameter *param);
+static int disconnect_ind(void *sap_device, sap_disconnection_type_t type);
+
+static gsize add_result_parameter(sap_result_t result, sap_parameter *param);
+
+static int is_power_sim_off_req_allowed(uint8_t processing_req);
+static int is_reset_sim_req_allowed(uint8_t processing_req);
+
+static int check_msg(sap_message *msg);
+
+static void start_guard_timer(struct sap_server *server, guint interval);
+static void stop_guard_timer(struct sap_server *server);
+static gboolean guard_timeout(gpointer data);
+
+static gsize add_result_parameter(sap_result_t result, sap_parameter *param)
+{
+	param->id = SAP_PARAM_ID_RESULT_CODE;
+	param->len = htons(SAP_PARAM_ID_RESULT_CODE_LEN);
+	*param->val = (uint8_t) result;
+	return PARAMETER_SIZE(SAP_PARAM_ID_RESULT_CODE_LEN);
+}
+
+
+static inline int is_power_sim_off_req_allowed(uint8_t processing_req)
+{
+	switch(processing_req) {
+	case SAP_NO_REQ:
+	case SAP_TRANSFER_APDU_REQ:
+	case SAP_TRANSFER_ATR_REQ:
+	case SAP_POWER_SIM_ON_REQ:
+	case SAP_RESET_SIM_REQ:
+	case SAP_TRANSFER_CARD_READER_STATUS_REQ:
+		return 1;
+	default:
+		return 0;
+	}
+}
+
+static inline int is_reset_sim_req_allowed(uint8_t processing_req)
+{
+	switch(processing_req) {
+	case SAP_NO_REQ:
+	case SAP_TRANSFER_APDU_REQ:
+	case SAP_TRANSFER_ATR_REQ:
+	case SAP_TRANSFER_CARD_READER_STATUS_REQ:
+		return 1;
+	default:
+		return 0;
+	}
+}
+
+static int check_msg(sap_message *msg)
+{
+	if(!msg)
+		return -EFAULT;
+
+	switch(msg->id) {
+	case SAP_CONNECT_REQ:
+		if (msg->nparam == 0x01 &&
+				msg->param->id == SAP_PARAM_ID_MAX_MSG_SIZE &&
+				ntohs(msg->param->len) == SAP_PARAM_ID_MAX_MSG_SIZE_LEN)
+			return 0;
+		break;
+	case SAP_TRANSFER_APDU_REQ:
+		if (msg->nparam == 0x01 &&
+				(msg->param->id == SAP_PARAM_ID_COMMAND_APDU ||
+				msg->param->id == SAP_PARAM_ID_COMMAND_APDU7816) &&
+				msg->param->len != 0x00)
+			return 0;
+		break;
+	case SAP_SET_TRANSPORT_PROTOCOL_REQ:
+		if (msg->nparam == 0x01 &&
+				msg->param->id == SAP_PARAM_ID_TRANSPORT_PROTOCOL &&
+				ntohs(msg->param->len) == SAP_PARAM_ID_TRANSPORT_PROTOCOL_LEN &&
+				(*msg->param->val  == SAP_TRANSPORT_PROTOCOL_T0 ||
+				*msg->param->val == SAP_TRANSPORT_PROTOCOL_T1))
+			return 0;
+		break;
+	case SAP_DISCONNECT_REQ:
+	case SAP_TRANSFER_ATR_REQ:
+	case SAP_POWER_SIM_OFF_REQ:
+	case SAP_POWER_SIM_ON_REQ:
+	case SAP_RESET_SIM_REQ:
+	case SAP_TRANSFER_CARD_READER_STATUS_REQ:
+		if (msg->nparam == 0x00)
+			return 0;
+		break;
+	}
+
+	error("Invalid message");
+	return -EBADMSG;
+}
+
+
+static void start_guard_timer(struct sap_server *server, guint interval)
+{
+	if(!server)
+		return;
+
+	if (!server->timer_id)
+		server->timer_id = g_timeout_add_seconds(interval,
+							guard_timeout, server);
+	else
+		error("Timer is already active.");
+}
+
+static void stop_guard_timer(struct sap_server *server)
+{
+	if (server && server->timer_id) {
+		g_source_remove(server->timer_id);
+		server->timer_id = 0;
+	}
+}
+
+static gboolean guard_timeout(gpointer data)
+{
+	struct sap_server *server = data;
+
+	if (!server)
+		return FALSE;
+
+	DBG("guard_timeout: state: %x pr %x", server->state,
+					server->processing_req);
+
+	server->timer_id = 0;
+
+	switch(server->state) {
+	case SAP_STATE_DISCONNECTED:
+		/* Client opened RFCOMM channel but didn't send CONNECT_REQ,
+		 * in fixed time or client disconnected SAP connection but
+		 * didn't closed RFCOMM channel in fixed time.*/
+		if (server->io)
+			g_io_channel_shutdown(server->io, TRUE, NULL);
+		break;
+	case SAP_STATE_GRACEFUL_DISCONNECT:
+		/* Client didn't disconnect SAP connection in fixed time,
+		 * so close SAP connection immediately. */
+		disconnect_req(server, SAP_DISCONNECTION_TYPE_IMMEDIATE);
+		break;
+	default:
+		error("guard_timeout: Unexpected state.");
+		break;
+	}
+
+	return FALSE;
+}
+
+static sdp_record_t *create_sap_record(uint8_t channel)
+{
+	sdp_list_t *apseq, *aproto, *profiles, *proto[2], *root, *svclass_id;
+	uuid_t sap_uuid, gt_uuid, root_uuid, l2cap, rfcomm;
+	sdp_profile_desc_t profile;
+	sdp_record_t *record;
+	sdp_data_t *ch;
+
+	record = sdp_record_alloc();
+	if (!record)
+		return NULL;
+
+	root = sdp_list_append(NULL, &root_uuid);
+	sdp_set_browse_groups(record, root);
+	sdp_list_free(root, NULL);
+
+	sdp_uuid16_create(&sap_uuid, SAP_SVCLASS_ID);
+	svclass_id = sdp_list_append(NULL, &sap_uuid);
+	sdp_uuid16_create(&gt_uuid, GENERIC_TELEPHONY_SVCLASS_ID);
+	svclass_id = sdp_list_append(svclass_id, &gt_uuid);
+
+	sdp_set_service_classes(record, svclass_id);
+	sdp_list_free(svclass_id, NULL);
+
+	sdp_uuid16_create(&profile.uuid, SAP_PROFILE_ID);
+	profile.version = SAP_VERSION;
+	profiles = sdp_list_append(NULL, &profile);
+	sdp_set_profile_descs(record, profiles);
+	sdp_list_free(profiles, NULL);
+
+	sdp_uuid16_create(&l2cap, L2CAP_UUID);
+	proto[0] = sdp_list_append(NULL, &l2cap);
+	apseq = sdp_list_append(NULL, proto[0]);
+
+	sdp_uuid16_create(&rfcomm, RFCOMM_UUID);
+	proto[1] = sdp_list_append(NULL, &rfcomm);
+	ch = sdp_data_alloc(SDP_UINT8, &channel);
+	proto[1] = sdp_list_append(proto[1], ch);
+	apseq = sdp_list_append(apseq, proto[1]);
+
+	aproto = sdp_list_append(NULL, apseq);
+	sdp_set_access_protos(record, aproto);
+
+	sdp_set_info_attr(record, "SIM Access Server",
+			NULL, NULL);
+
+	sdp_data_free(ch);
+	sdp_list_free(proto[0], NULL);
+	sdp_list_free(proto[1], NULL);
+	sdp_list_free(apseq, NULL);
+	sdp_list_free(aproto, NULL);
+
+	return record;
+}
+
+static int send_message(struct sap_server *server, gchar *buf, gssize size)
+{
+	gsize written = 0;
+	GError *gerr = NULL;
+	GIOStatus gstatus;
+
+	if(!server || !buf)
+		return -1;
+
+	DBG("send_message: size=%x",(unsigned int)size);
+
+	gstatus = g_io_channel_write_chars(server->io, buf, size, &written, &gerr);
+
+	if (gstatus != G_IO_STATUS_NORMAL) {
+		if (gerr)
+			g_error_free(gerr);
+
+		error("send_message:write error (%d)", gstatus);
+		return -1;
+	}
+	if(written != (gsize)size) {
+		error("send_message:write error. written %d size %d", written, size);
+	}
+	DBG("send_message: written=%x",(unsigned int)written);
+	return 0;
+}
+
+static void connect_req(void *data, sap_parameter *param)
+{
+	struct sap_server *server = data;
+	uint16_t maxmsgsize, *val;
+
+	if(!server || !param)
+		goto error_rsp;
+
+	if (server->state != SAP_STATE_DISCONNECTED)
+		goto error_rsp;
+
+	stop_guard_timer(server);
+
+	val = (uint16_t *) &param->val;
+	maxmsgsize = ntohs(*val);
+
+	DBG("Connect MaxMsgSize: 0x%04X(%d)", maxmsgsize, maxmsgsize);
+
+	server->state = SAP_STATE_CONNECT_IN_PROGRESS;
+
+	if (maxmsgsize <= SAP_BUF_SIZE){
+		server->processing_req = SAP_CONNECT_REQ;
+		sap_connect_req(server, maxmsgsize);
+	}else{
+		sap_connect_rsp(server, SAP_STATUS_MAX_MSG_SIZE_NOT_SUPPORTED,
+								SAP_BUF_SIZE);
+	}
+
+	return;
+
+error_rsp:
+	error("Wrong state (state %x pr %x)", server->state,
+						server->processing_req);
+	sap_error_rsp(data);
+}
+
+static int disconnect_req(void *data, sap_disconnection_type_t disc_type)
+{
+	struct sap_server *server = data;
+
+	if(!server)
+		goto error_rsp;
+
+	DBG("disconnect_req: type 0x%x state %d", disc_type, server->state);
+
+	switch(disc_type) {
+	case SAP_DISCONNECTION_TYPE_GRACEFUL:
+
+		if (server->state == SAP_STATE_DISCONNECTED ||
+				server->state == SAP_STATE_CONNECT_IN_PROGRESS)
+			goto error_req;
+
+		if (server->state == SAP_STATE_CONNECTED) {
+			server->state = SAP_STATE_GRACEFUL_DISCONNECT;
+			server->processing_req = SAP_NO_REQ;
+			disconnect_ind(server, disc_type);
+
+			/* Start guard timer - timer will disconnect connection
+			 * if client doesn't do it. */
+			start_guard_timer(server, SAP_TIMER_GRACEFUL_DISCONNECT);
+
+			return 0;
+		}
+		/* Disconnection is ongoing - do nothing. */
+		return 0;
+
+	case SAP_DISCONNECTION_TYPE_IMMEDIATE:
+
+		if (server->state == SAP_STATE_DISCONNECTED ||
+				server->state == SAP_STATE_CONNECT_IN_PROGRESS)
+			goto error_req;
+
+		if (server->state == SAP_STATE_CONNECTED ||
+				server->state == SAP_STATE_GRACEFUL_DISCONNECT) {
+			server->state = SAP_STATE_IMMEDIATE_DISCONNECT;
+			server->processing_req = SAP_NO_REQ;
+
+			stop_guard_timer(server);
+
+			disconnect_ind(server, disc_type);
+			sap_disconnect_req(server, 0);
+
+			return 0;
+		}
+		/* Disconnection is ongoing - do nothing. */
+		return 0;
+
+	case SAP_DISCONNECTION_TYPE_CLIENT:
+
+		if (server->state != SAP_STATE_CONNECTED &&
+				server->state != SAP_STATE_GRACEFUL_DISCONNECT)
+			goto error_rsp;
+
+		server->state = SAP_STATE_CLIENT_DISCONNECT;
+		server->processing_req = SAP_NO_REQ;
+
+		stop_guard_timer(server);
+
+		sap_disconnect_req(server, 0);
+
+		return 0;
+
+	default:
+		error("Unknown disconnection type (type %x).", disc_type);
+		return -EINVAL;
+	}
+
+error_rsp:
+	sap_error_rsp(server);
+error_req:
+	error("Wrong state (state %x pr %x)", server->state,
+						server->processing_req);
+	return -EPERM;
+}
+
+static void transfer_apdu_req(void * data, sap_parameter * param)
+{
+	struct sap_server *server = data;
+
+	if(!server || !param)
+		goto error_rsp;
+
+	param->len = ntohs(param->len);
+
+	DBG("transfer_apdu_req: data %p state %d", data, server->state);
+	DBG("transfer_apdu_req: apdu param id %d  val %s len %d ",
+					param->id, param->val, param->len);
+
+	if (server->state != SAP_STATE_CONNECTED &&
+			server->state != SAP_STATE_GRACEFUL_DISCONNECT)
+		goto error_rsp;
+
+	if (server->processing_req != SAP_NO_REQ)
+		goto error_rsp;
+
+	server->processing_req = SAP_TRANSFER_APDU_REQ;
+	sap_transfer_apdu_req(server, param);
+
+	return;
+
+error_rsp:
+	error("Wrong state (state %x pr %x)", server->state,
+						server->processing_req);
+	sap_error_rsp(server);
+}
+
+
+static void transfer_atr_req(void * data)
+{
+	struct sap_server *server = data;
+
+	if(!server)
+		goto error_rsp;
+
+	DBG("transfer_atr_req: data %p state %d", data, server->state);
+
+	if (server->state != SAP_STATE_CONNECTED)
+		goto error_rsp;
+
+	if (server->processing_req != SAP_NO_REQ)
+		goto error_rsp;
+
+	server->processing_req = SAP_TRANSFER_ATR_REQ;
+	sap_transfer_atr_req(server);
+
+	return;
+
+error_rsp:
+	error("Wrong state (state %x pr %x)", server->state,
+						server->processing_req);
+	sap_error_rsp(server);
+}
+
+
+static void power_sim_off_req(void *data)
+{
+	struct sap_server *server = data;
+
+	if(!server)
+		goto error_rsp;
+
+	DBG("power_sim_off_req: data %p state %d", data, server->state);
+
+	if (server->state != SAP_STATE_CONNECTED)
+		goto error_rsp;
+
+	if (!is_power_sim_off_req_allowed(server->processing_req))
+		goto error_rsp;
+
+	server->processing_req = SAP_POWER_SIM_OFF_REQ;
+	sap_power_sim_off_req(server);
+
+	return;
+
+error_rsp:
+	error("Wrong state (state %x pr %x)", server->state,
+						server->processing_req);
+	sap_error_rsp(server);
+}
+
+static void power_sim_on_req(void *data)
+{
+	struct sap_server *server = data;
+
+	if(!server)
+		goto error_rsp;
+
+	DBG("power_sim_on_req: data %p state %d", data, server->state);
+
+	if (server->state != SAP_STATE_CONNECTED)
+		goto error_rsp;
+
+	if (server->processing_req != SAP_NO_REQ)
+		goto error_rsp;
+
+	server->processing_req = SAP_POWER_SIM_ON_REQ;
+	sap_power_sim_on_req(server);
+
+	return;
+
+error_rsp:
+	error("Wrong state (state %x pr %x)", server->state,
+						server->processing_req);
+	sap_error_rsp(server);
+}
+
+static void reset_sim_req(void *data)
+{
+	struct sap_server *server = data;
+
+	if(!server)
+		goto error_rsp;
+
+	DBG("reset_sim_req: data %p state %d", data, server->state);
+
+	if (server->state != SAP_STATE_CONNECTED)
+		goto error_rsp;
+
+	if (!is_reset_sim_req_allowed(server->processing_req))
+		goto error_rsp;
+
+	server->processing_req = SAP_RESET_SIM_REQ;
+	sap_reset_sim_req(server);
+
+	return;
+
+error_rsp:
+	error("Wrong state (state %x pr %x)", server->state,
+						server->processing_req);
+	sap_error_rsp(server);
+}
+
+static void transfer_card_reader_status_req(void * data)
+{
+	struct sap_server *server = data;
+
+	if(!server)
+		goto error_rsp;
+
+	DBG("transfer_card_reader_status_req: data %p state %d",
+							data, server->state);
+
+	if (server->state != SAP_STATE_CONNECTED)
+		goto error_rsp;
+
+	if (server->processing_req != SAP_NO_REQ)
+		goto error_rsp;
+
+	server->processing_req = SAP_TRANSFER_CARD_READER_STATUS_REQ;
+	sap_transfer_card_reader_status_req(server);
+
+	return;
+
+error_rsp:
+	error("Wrong state (state %x pr %x)", server->state,
+						server->processing_req);
+	sap_error_rsp(server);
+}
+
+static void set_transport_protocol_req(void *data, sap_parameter *param)
+{
+	struct sap_server *server = data;
+
+	if(!server || !param)
+		goto error_rsp;
+
+	DBG("set_transport_protocol_req: data %p state %d param %p",
+						data, server->state, param);
+
+	if (server->state != SAP_STATE_CONNECTED)
+		goto error_rsp;
+
+	if (server->processing_req != SAP_NO_REQ)
+		goto error_rsp;
+
+	server->processing_req = SAP_SET_TRANSPORT_PROTOCOL_REQ;
+	sap_set_transport_protocol_req(server, param);
+
+	return;
+
+error_rsp:
+	error("Wrong state (state %x pr %x)", server->state,
+						server->processing_req);
+	sap_error_rsp(server);
+}
+
+static int disconnect_ind(void *sap_device, sap_disconnection_type_t type)
+{
+	struct sap_server *server = sap_device;
+	gchar buf[SAP_BUF_SIZE];
+	sap_message *msg = (sap_message *) buf;
+	sap_parameter *param = (sap_parameter *) msg->param;
+	gsize size = sizeof(sap_message);
+
+	if(!server)
+		return -1;
+
+	DBG("disconnect_ind: data %p state %d disc_type %d",
+						server, server->state, type);
+
+	if (server->state != SAP_STATE_GRACEFUL_DISCONNECT &&
+			server->state != SAP_STATE_IMMEDIATE_DISCONNECT)
+		goto error_ind;
+
+	memset(buf, 0, sizeof(buf));
+	msg->id = SAP_DISCONNECT_IND;
+	msg->nparam = 0x01;
+
+	/* Add disconnection type. */
+	param->id  = SAP_PARAM_ID_DISCONNECT_IND;
+	param->len = htons(SAP_PARAM_ID_DISCONNECT_IND_LEN);
+	*param->val = (uint8_t) type;
+	size += PARAMETER_SIZE(SAP_PARAM_ID_DISCONNECT_IND_LEN);
+
+	return send_message(sap_device, buf, size);
+
+error_ind:
+	error("Wrong state (state %x pr %x)", server->state,
+						server->processing_req);
+	return -EPERM;
+}
+
+int sap_connect_rsp(void *sap_device, sap_status_t status, uint16_t maxmsgsize)
+{
+	struct sap_server *server = sap_device;
+	gchar buf[SAP_BUF_SIZE];
+	sap_message *msg = (sap_message *) buf;
+	sap_parameter *param = (sap_parameter *) msg->param;
+	gsize size = sizeof(sap_message);
+
+	if(!server)
+		return -1;
+
+	DBG("sap_connect_rsp: state %x pr %x status %x", server->state,
+					server->processing_req, status);
+
+	if (server->state != SAP_STATE_CONNECT_IN_PROGRESS) {
+		return -EPERM;
+	}
+
+	memset(buf, 0, sizeof(buf));
+	msg->id = SAP_CONNECT_RESP;
+	msg->nparam = 0x01;
+
+	/* Add connection status */
+	param->id = SAP_PARAM_ID_CONN_STATUS;
+	param->len = htons(SAP_PARAM_ID_CONN_STATUS_LEN);
+	*param->val = (uint8_t)status;
+	size += PARAMETER_SIZE(SAP_PARAM_ID_CONN_STATUS_LEN);
+
+	/* Add MaxMsgSize */
+	if (maxmsgsize && (status == SAP_STATUS_MAX_MSG_SIZE_NOT_SUPPORTED ||
+			status == SAP_STATUS_MAX_MSG_SIZE_TOO_SMALL)) {
+		uint16_t *len;
+		msg->nparam++;
+		/* Skip the first param */
+		param = (sap_parameter *) &buf[size];
+		param->id = SAP_PARAM_ID_MAX_MSG_SIZE;
+		param->len = htons(SAP_PARAM_ID_MAX_MSG_SIZE_LEN);
+		len = (uint16_t *) &param->val;
+		*len = htons(maxmsgsize);
+		size += PARAMETER_SIZE(SAP_PARAM_ID_MAX_MSG_SIZE_LEN);
+	}
+
+	if (status == SAP_STATUS_OK) {
+		gboolean connected = TRUE;
+		emit_property_changed(connection, server->path, SAP_SERVER_INTERFACE,
+			"Connected", DBUS_TYPE_BOOLEAN, &connected);
+
+		server->state = SAP_STATE_CONNECTED;
+	} else {
+		server->state = SAP_STATE_DISCONNECTED;
+
+		/* Timer will shutdown channel if client doesn't send
+		 * CONNECT_REQ or doesn't shutdown channel itself.*/
+		start_guard_timer(server, SAP_TIMER_NO_ACTIVITY);
+	}
+
+	server->processing_req = SAP_NO_REQ;
+	return send_message(sap_device, buf, size);
+}
+
+int sap_disconnect_rsp(void *sap_device)
+{
+	struct sap_server *server = sap_device;
+	sap_message msg = {0};
+
+	if(!server)
+		return -1;
+
+	DBG("sap_disconnect_rsp: state %x pr %x", server->state,
+					server->processing_req);
+
+	switch(server->state) {
+	case SAP_STATE_CLIENT_DISCONNECT:
+		msg.id = SAP_DISCONNECT_RESP;
+
+		server->state = SAP_STATE_DISCONNECTED;
+		server->processing_req = SAP_NO_REQ;
+
+		/* Timer will close channel if client doesn't do it.*/
+		start_guard_timer(server, SAP_TIMER_NO_ACTIVITY);
+
+		return send_message(sap_device, (gchar *) &msg, sizeof(msg));
+
+	case SAP_STATE_IMMEDIATE_DISCONNECT:
+		server->state = SAP_STATE_DISCONNECTED;
+		server->processing_req = SAP_NO_REQ;
+
+		if (server->io)
+			g_io_channel_shutdown(server->io, TRUE, NULL);
+		return 0;
+	default:
+		break;
+	}
+
+	return 0;
+}
+
+int sap_transfer_apdu_rsp(void *sap_device, sap_result_t result, uint8_t *apdu,
+								uint16_t length)
+{
+	struct sap_server *server = sap_device;
+	gchar buf[SAP_BUF_SIZE] = {0};
+	sap_message *msg = (sap_message *) buf;
+	sap_parameter *param = (sap_parameter *) msg->param;
+	gsize size = sizeof(sap_message);
+
+	if(!server)
+		return -1;
+
+	DBG("sap_transfer_apdu_rsp: state %x pr %x", server->state,
+					server->processing_req);
+
+	if (server->processing_req != SAP_TRANSFER_APDU_REQ)
+		/* Ignore this response because processing (state) request
+		 * has been changed. This situation can happen e.g. when
+		 * client sends disconnect request while server is processing
+		 * another request.*/
+		return 0;
+
+	if (result == SAP_RESULT_OK && (!apdu || (apdu && length == 0x00)))
+		return -EINVAL;
+
+	msg->id = SAP_TRANSFER_APDU_RESP;
+
+	/* Add result code */
+	msg->nparam = 0x01;
+	size += add_result_parameter(result, param);
+
+	/* Add APDU response. */
+	if (result == SAP_RESULT_OK) {
+		msg->nparam++;
+		/* Skipping the first param. */
+		param = (sap_parameter *) &buf[size];
+		param->id = SAP_PARAM_ID_RESPONSE_APDU;
+		param->len = htons(length);
+
+		size += PARAMETER_SIZE(length);
+		if (size > SAP_BUF_SIZE)
+			return -EOVERFLOW;
+
+		memcpy(param->val, apdu, length);
+	}
+
+	server->processing_req = SAP_NO_REQ;
+	return send_message(sap_device, buf, size);
+}
+
+int sap_transfer_atr_rsp(void *sap_device, sap_result_t result, uint8_t *atr,
+								uint16_t length)
+{
+	struct sap_server *server = sap_device;
+	gchar buf[SAP_BUF_SIZE]= {0};
+	sap_message *msg = (sap_message *) buf;
+	sap_parameter *param = (sap_parameter *) msg->param;
+	gsize size = sizeof(sap_message);
+
+	if(!server)
+		return -1;
+
+	DBG("sap_transfer_atr_rsp: state %x pr %x", server->state,
+					server->processing_req);
+
+	if (server->processing_req != SAP_TRANSFER_ATR_REQ)
+		/* Ignore this response because processing (state) request
+		 * has been changed. This situation can happen e.g. when
+		 * client sends disconnect request while server is processing
+		 * another request.*/
+		return 0;
+
+	if (result == SAP_RESULT_OK && (!atr || (atr && length == 0x00)))
+		return -EINVAL;
+
+	msg->id = SAP_TRANSFER_ATR_RESP;
+
+	/* Add result code */
+	msg->nparam = 0x01;
+	size += add_result_parameter(result, param);
+
+	/* Add ATR response */
+	if (result == SAP_RESULT_OK) {
+		msg->nparam++;
+		/* Skip the first param */
+		param = (sap_parameter *) &buf[size];
+		param->id = SAP_PARAM_ID_ATR;
+		param->len = htons(length);
+
+		size += PARAMETER_SIZE(length);
+		if (size > SAP_BUF_SIZE)
+			return -EOVERFLOW;
+
+		memcpy(param->val, atr, length);
+	}
+
+	server->processing_req = SAP_NO_REQ;
+	return send_message(sap_device, buf, size);
+}
+
+int sap_power_sim_off_rsp(void *sap_device, sap_result_t result)
+{
+	struct sap_server *server = sap_device;
+	gchar buf[SAP_BUF_SIZE] = {0};
+	sap_message *msg = (sap_message *) buf;
+	gsize size = sizeof(sap_message);
+
+	if(!server)
+		return -1;
+
+	DBG("sap_power_sim_off_rsp: state %x pr %x", server->state,
+					server->processing_req);
+
+	if (server->processing_req != SAP_POWER_SIM_OFF_REQ)
+		/* Ignore this response because processing (state) request
+		 * has been changed. This situation can happen e.g. when
+		 * client sends disconnect request while server is processing
+		 * another request.*/
+		return 0;
+
+	msg->id = SAP_POWER_SIM_OFF_RESP;
+
+	/* Add result code.*/
+	msg->nparam = 0x01;
+	size += add_result_parameter(result, msg->param);
+
+	server->processing_req = SAP_NO_REQ;
+	return send_message(sap_device, buf, size);
+}
+
+int sap_power_sim_on_rsp(void *sap_device, sap_result_t result)
+{
+	struct sap_server *server = sap_device;
+	gchar buf[SAP_BUF_SIZE] = {0};
+	sap_message *msg = (sap_message *) buf;
+	gsize size = sizeof(sap_message);
+
+	if(!server)
+		return -1;
+
+	DBG("sap_power_sim_on_rsp: state %x pr %x", server->state,
+					server->processing_req);
+
+	if (server->processing_req != SAP_POWER_SIM_ON_REQ)
+		/* Ignore this response because processing (state) request
+		 * has been changed. This situation can happen e.g. when
+		 * client sends disconnect request while server is processing
+		 * another request.*/
+		return 0;
+
+	msg->id = SAP_POWER_SIM_ON_RESP;
+
+	/* Add result code */
+	msg->nparam = 0x01;
+	size += add_result_parameter(result, msg->param);
+
+	server->processing_req = SAP_NO_REQ;
+	return send_message(sap_device, buf, size);
+}
+
+int sap_reset_sim_rsp(void *sap_device, sap_result_t result)
+{
+	struct sap_server *server = sap_device;
+	gchar buf[SAP_BUF_SIZE] = {0};
+	sap_message *msg = (sap_message *) buf;
+	gsize size = sizeof(sap_message);
+
+	if(!server)
+		return -1;
+
+	DBG("sap_reset_sim_rsp: state %x pr %x", server->state,
+					server->processing_req);
+
+	if (server->processing_req != SAP_RESET_SIM_REQ)
+		/* Ignore this response because processing (state) request
+		 * has been changed. This situation can happen e.g. when
+		 * client sends disconnect request while server is processing
+		 * another request.*/
+		return 0;
+
+	msg->id = SAP_RESET_SIM_RESP;
+
+	/* Add result code */
+	msg->nparam = 0x01;
+	size += add_result_parameter(result, msg->param);
+
+	server->processing_req = SAP_NO_REQ;
+	return send_message(sap_device, buf, size);
+}
+
+int sap_transfer_card_reader_status_rsp(void *sap_device, sap_result_t result,
+						icc_reader_status_t status)
+{
+	struct sap_server *server = sap_device;
+	gchar buf[SAP_BUF_SIZE] = {0};
+	sap_message *msg = (sap_message *) buf;
+	sap_parameter *param = (sap_parameter *) msg->param;
+	gsize size = sizeof(sap_message);
+
+	if(!server)
+		return -1;
+
+	DBG("sap_transfer_card_reader_status_rsp: state %x pr %x", server->state,
+					server->processing_req);
+
+	if (server->processing_req != SAP_TRANSFER_CARD_READER_STATUS_REQ)
+		/* Ignore this response because processing (state) request
+		 * has been changed. This situation can happen e.g. when
+		 * client sends disconnect request while server is processing
+		 * another request.*/
+		return 0;
+
+	msg->id = SAP_TRANSFER_CARD_READER_STATUS_RESP;
+
+	/* Add result code */
+	msg->nparam = 0x01;
+	size += add_result_parameter(result, param);
+
+	/* Add card reader status. */
+	if (result == SAP_RESULT_OK) {
+		msg->nparam++;
+		/* Skipp the first param. */
+		param = (sap_parameter *) &buf[size];
+		param->id = SAP_PARAM_ID_CARD_READER_STATUS;
+		param->len = htons(SAP_PARAM_ID_CARD_READER_STATUS_LEN);
+		*param->val = (uint8_t) status;
+		size += PARAMETER_SIZE(SAP_PARAM_ID_CARD_READER_STATUS_LEN);
+	}
+
+	server->processing_req = SAP_NO_REQ;
+	return send_message(sap_device, buf, size);
+}
+
+int sap_transport_protocol_rsp(void *sap_device, sap_result_t result)
+{
+	struct sap_server *server = sap_device;
+	gchar buf[SAP_BUF_SIZE] = {0};
+	sap_message *msg = (sap_message *) buf;
+	gsize size = sizeof(sap_message);
+
+	if(!server)
+		return -1;
+
+	DBG("sap_transport_protocol_rsp: state %x pr %x", server->state,
+					server->processing_req);
+
+	if (server->processing_req != SAP_SET_TRANSPORT_PROTOCOL_REQ)
+		/* Ignore this response because processing (state) request
+		 * has been changed. This situation can happen e.g. when
+		 * client sends disconnect request while server is processing
+		 * another request.*/
+		return 0;
+
+	msg->id = SAP_SET_TRANSPORT_PROTOCOL_RESP;
+
+	/* Add result code */
+	msg->nparam = 0x01;
+	size += add_result_parameter(result, msg->param);
+
+	server->processing_req = SAP_NO_REQ;
+	return send_message(sap_device, buf, size);
+}
+
+int sap_error_rsp(void *sap_device)
+{
+	sap_message msg;
+
+	memset(&msg, 0, sizeof(msg));
+	msg.id = SAP_ERROR_RESP;
+
+	return send_message(sap_device, (gchar *) &msg, sizeof(msg));
+}
+
+int sap_status_ind(void *sap_device, sap_status_change_t status_change)
+{
+	struct sap_server *server = sap_device;
+	gchar buf[SAP_BUF_SIZE] = {0};
+	sap_message *msg = (sap_message *) buf;
+	sap_parameter *param = (sap_parameter *) msg->param;
+	gsize size = sizeof(sap_message);
+
+	if(!server)
+		return -1;
+
+	DBG("sap_status_ind: state %x pr %x", server->state,
+					server->processing_req);
+
+	if (server->state != SAP_STATE_CONNECTED &&
+			server->state != SAP_STATE_GRACEFUL_DISCONNECT)
+		/*Don't propagate status indication if client is not connected */
+		return 0;
+
+	msg->id = SAP_STATUS_IND;
+	msg->nparam = 0x01;
+
+	/* Add status change. */
+	param->id  = SAP_PARAM_ID_STATUS_CHANGE;
+	param->len = htons(SAP_PARAM_ID_STATUS_CHANGE_LEN);
+	*param->val = (uint8_t) status_change;
+	size += PARAMETER_SIZE(SAP_PARAM_ID_STATUS_CHANGE_LEN);
+
+	return send_message(sap_device, buf, size);
+}
+
+static int handle_cmd(void *data, gchar *buf, gsize size)
+{
+	sap_message *msg = (sap_message *) buf;
+
+	if (size < sizeof(sap_message))
+		goto error_rsp;
+
+	if (msg->nparam != 0 &&
+			size < (sizeof(sap_message) + sizeof(sap_parameter) + 4))
+		goto error_rsp;
+
+	if (check_msg(msg) < 0)
+		goto error_rsp;
+
+	switch(msg->id) {
+		case SAP_CONNECT_REQ:
+			DBG("SAP Connect.");
+			connect_req(data, msg->param);
+			return 0;
+		case SAP_DISCONNECT_REQ:
+			DBG("SAP Disconnect.");
+			disconnect_req(data, SAP_DISCONNECTION_TYPE_CLIENT);
+			return 0;
+		case SAP_TRANSFER_APDU_REQ:
+			DBG("SAP Transfer APDU.");
+			transfer_apdu_req(data, msg->param);
+			return 0;
+		case SAP_TRANSFER_ATR_REQ:
+			DBG("SAP Transfer ATR.");
+			transfer_atr_req(data);
+			return 0;
+		case SAP_POWER_SIM_OFF_REQ:
+			DBG("SAP SIM off.");
+			power_sim_off_req(data);
+			return 0;
+		case SAP_POWER_SIM_ON_REQ:
+			DBG("SAP SIM on.");
+			power_sim_on_req(data);
+			return 0;
+		case SAP_RESET_SIM_REQ:
+			DBG("SAP SIM reset.");
+			reset_sim_req(data);
+			return 0;
+		case SAP_TRANSFER_CARD_READER_STATUS_REQ:
+			DBG("SAP reader status.");
+			transfer_card_reader_status_req(data);
+			return 0;
+		case SAP_SET_TRANSPORT_PROTOCOL_REQ:
+			DBG("SAP set proto request.");
+			set_transport_protocol_req(data, msg->param);
+			return 0;
+		default:
+			DBG("SAP unknown message.");
+			break;
+	}
+
+error_rsp:
+	DBG("SAP ERROR RSP");
+	sap_error_rsp(data);
+	return -EBADMSG;
+}
+
+static gboolean sap_io_cb(GIOChannel *chan, GIOCondition cond, void *data)
+{
+	gchar buf[SAP_BUF_SIZE];
+	gsize bytes_read = 0;
+	GError *gerr = NULL;
+	GIOStatus gstatus;
+
+	if (cond & G_IO_NVAL){
+		DBG("ERR (G_IO_NVAL) on rfcomm socket.");
+		return FALSE;
+	}
+
+	if (cond & G_IO_ERR) {
+		DBG("ERR (G_IO_ERR) on rfcomm socket.");
+		return FALSE;
+	}
+
+	if (cond & G_IO_HUP ) {
+		DBG("HUP on rfcomm socket.");
+		return FALSE;
+	}
+
+	gstatus = g_io_channel_read_chars(chan, buf, sizeof(buf) - 1,
+				&bytes_read, &gerr);
+
+	if (gstatus != G_IO_STATUS_NORMAL) {
+		if(gerr)
+			g_error_free(gerr);
+		return TRUE;
+	}
+
+	if (handle_cmd(data, buf, bytes_read) < 0) {
+		error("Invalid SAP message.");
+	}
+
+	return TRUE;
+}
+
+static void sap_io_destroy(void *data)
+{
+	struct sap_server *server = data;
+
+	if (server && server->io) {
+		gboolean connected = FALSE;
+
+		stop_guard_timer(server);
+
+		g_io_channel_shutdown(server->io, TRUE, NULL);
+		g_io_channel_unref(server->io);
+
+		server->io = NULL;
+
+		if (server->state != SAP_STATE_CONNECT_IN_PROGRESS)
+			emit_property_changed(connection, server->path,
+				SAP_SERVER_INTERFACE,"Connected",
+				DBUS_TYPE_BOOLEAN, &connected);
+
+		if (server->state == SAP_STATE_CONNECT_IN_PROGRESS ||
+					server->state == SAP_STATE_CONNECTED ||
+					server->state == SAP_STATE_GRACEFUL_DISCONNECT){
+				sap_disconnect_req(NULL, 1);
+			}
+
+		server->state = SAP_STATE_DISCONNECTED;
+	}
+}
+
+static void sap_connect_cb(GIOChannel *chan, GError *gerr, gpointer data)
+{
+	struct sap_server *server = data;
+
+	if(!server)
+		return;
+
+	/* Timer will shutdown the channel in case of lack of client activity */
+	start_guard_timer(server, SAP_TIMER_NO_ACTIVITY);
+
+	g_io_add_watch_full(chan, G_PRIORITY_DEFAULT,
+			G_IO_IN | G_IO_ERR | G_IO_HUP| G_IO_NVAL,
+			(GIOFunc) sap_io_cb, server, sap_io_destroy);
+}
+
+static void connect_auth_cb(DBusError *derr, void *data)
+{
+	struct sap_server *server = data;
+	GError *gerr = NULL;
+
+	if(!server || !server->io)
+		return;
+
+	if (derr && dbus_error_is_set(derr)) {
+		error("Access denied: %s", derr->message);
+		goto drop;
+	}
+
+	if (!bt_io_accept(server->io, sap_connect_cb, server, NULL, &gerr)) {
+		error("bt_io_accept: %s", gerr->message);
+		g_error_free(gerr);
+		goto drop;
+	}
+	return;
+
+drop:
+	g_io_channel_shutdown(server->io, TRUE, NULL);
+	g_io_channel_unref(server->io);
+	server->io = NULL;
+}
+
+static void connect_confirm_cb(GIOChannel *chan, gpointer data)
+{
+	struct sap_server *server = data;
+	GError *gerr = NULL;
+	bdaddr_t src, dst;
+	int err;
+
+	if(!chan || !server)
+		return;
+
+	if (server->io)
+		goto drop;
+
+	bt_io_get(chan, BT_IO_RFCOMM, &gerr,
+			BT_IO_OPT_SOURCE_BDADDR, &src,
+			BT_IO_OPT_DEST_BDADDR, &dst,
+			BT_IO_OPT_INVALID);
+	if (gerr) {
+		error("%s", gerr->message);
+		g_error_free(gerr);
+		goto drop;
+	}
+
+	server->io = g_io_channel_ref(chan);
+
+	err = btd_request_authorization(&src, &dst, SAP_UUID, connect_auth_cb, server);
+
+	if (err < 0) {
+		DBG("Authorization denied: %s", strerror(err));
+		goto drop;
+	}
+
+	DBG("SAP incoming connection (sock %d) authorization.", g_io_channel_unix_get_fd(chan));
+
+	return;
+
+drop:
+	g_io_channel_shutdown(chan, TRUE, NULL);
+	if (server->io && server->io == chan) {
+		g_io_channel_unref(server->io);
+		server->io = NULL;
+	}
+}
+
+
+
+static inline DBusMessage *message_failed(DBusMessage *msg,
+					const char *description)
+{
+	return g_dbus_create_error(msg, ERROR_INTERFACE ".Failed",
+				"%s", description);
+}
+
+static DBusMessage *enable(DBusConnection *conn,
+			DBusMessage *msg, void *data)
+{
+	struct sap_server *server = data;
+	sdp_record_t *record = NULL;
+	GIOChannel *io = NULL;
+	GError *gerr = NULL;
+
+	if (!server)
+		return message_failed(msg, "Server internal error.");
+
+	if (server->enable)
+		return message_failed(msg, "Server already enabled.");
+
+	record = create_sap_record(SAP_SERVER_CHANNEL);
+	if (!record)
+		return message_failed(msg, "Can't create SDP record for SAP.");
+
+	if (add_record_to_server(&server->src, record) < 0) {
+		sdp_record_free(record);
+		return message_failed(msg, "SDP record registration failed.");
+	}
+
+	io = bt_io_listen(BT_IO_RFCOMM, NULL, connect_confirm_cb, server, NULL, &gerr,
+			BT_IO_OPT_SOURCE_BDADDR, &server->src,
+			BT_IO_OPT_CHANNEL, SAP_SERVER_CHANNEL,
+			BT_IO_OPT_SEC_LEVEL, BT_IO_SEC_HIGH,
+			BT_IO_OPT_MASTER, TRUE,
+			BT_IO_OPT_INVALID);
+	if (!io) {
+		g_error_free(gerr);
+		sdp_record_free(record);
+		return message_failed(msg, "Listen rfcomm channel failed.");
+	}
+
+	DBG("Listen socket %x", g_io_channel_unix_get_fd(io));
+
+	server->enable = TRUE;
+	server->record_id = record->handle;
+	server->listen_io = io;
+
+	emit_property_changed(connection, server->path, SAP_SERVER_INTERFACE,
+				"Enabled", DBUS_TYPE_BOOLEAN, &server->enable);
+
+	return dbus_message_new_method_return(msg);
+}
+
+static DBusMessage *disable(DBusConnection *conn,
+				DBusMessage *msg, void *data)
+{
+	struct sap_server *server = data;
+	DBusMessage *reply = NULL;
+
+	if(!server)
+		return message_failed(msg, "Server internal error.");
+
+	if (!server->enable)
+		return message_failed(msg, "Server already disabled.");
+
+	if (server->state != SAP_STATE_DISCONNECTED)
+		return message_failed(msg, "Ongoing connection exists.");
+
+	reply = dbus_message_new_method_return(msg);
+	if (!reply)
+		return NULL;
+
+	remove_record_from_server(server->record_id);
+
+	if (server->listen_io) {
+		g_io_channel_shutdown(server->listen_io, TRUE, NULL);
+		g_io_channel_unref(server->listen_io);
+		server->listen_io = NULL;
+	}
+
+	server->enable = FALSE;
+
+	emit_property_changed(connection, server->path, SAP_SERVER_INTERFACE,
+				"Enabled", DBUS_TYPE_BOOLEAN, &server->enable);
+
+	return reply;
+}
+
+static DBusMessage *get_properties(DBusConnection *conn,
+				DBusMessage *msg, void *data)
+{
+	struct sap_server *server = data;
+	DBusMessage *reply;
+	DBusMessageIter iter;
+	DBusMessageIter dict;
+	dbus_bool_t connected;
+
+	if(!server)
+		return message_failed(msg, "Server internal error.");
+
+	reply = dbus_message_new_method_return(msg);
+	if (!reply)
+		return NULL;
+
+	dbus_message_iter_init_append(reply, &iter);
+
+	dbus_message_iter_open_container(&iter, DBUS_TYPE_ARRAY,
+			DBUS_DICT_ENTRY_BEGIN_CHAR_AS_STRING
+			DBUS_TYPE_STRING_AS_STRING DBUS_TYPE_VARIANT_AS_STRING
+			DBUS_DICT_ENTRY_END_CHAR_AS_STRING, &dict);
+
+	dict_append_entry(&dict, "Enabled", DBUS_TYPE_BOOLEAN, &server->enable);
+
+	connected = (server->state == SAP_STATE_CONNECTED ||
+			server->state == SAP_STATE_GRACEFUL_DISCONNECT);
+	dict_append_entry(&dict, "Connected", DBUS_TYPE_BOOLEAN, &connected);
+
+	dbus_message_iter_close_container(&iter, &dict);
+
+	return reply;
+}
+
+static DBusMessage *disconnect(DBusConnection *conn, DBusMessage *msg, void *data)
+{
+	struct sap_server *server = data;
+	dbus_bool_t disc_type;
+	sap_disconnection_type_t sap_disc_type;
+
+	if (!server)
+		return message_failed(msg, "Server internal error.");
+
+	if (!server->enable)
+		return g_dbus_create_error(msg, ERROR_INTERFACE
+				".Failed",
+				"Server already disabled");
+
+	if (dbus_message_get_args(msg, NULL, DBUS_TYPE_BOOLEAN, &disc_type,
+						DBUS_TYPE_INVALID) == FALSE)
+		return NULL;
+
+	sap_disc_type = disc_type ? SAP_DISCONNECTION_TYPE_GRACEFUL :
+				SAP_DISCONNECTION_TYPE_IMMEDIATE;
+	if (disconnect_req(server, sap_disc_type) < 0)
+		return g_dbus_create_error(msg, ERROR_INTERFACE
+				".Failed",
+				"There is no active connection");
+
+	return dbus_message_new_method_return(msg);
+}
+
+static GDBusMethodTable server_methods[] = {
+	{ "Enable","","", enable },
+	{ "Disable","","", disable },
+	{ "GetProperties","","a{sv}",get_properties },
+	{ "Disconnect","b","", disconnect },
+	{ }
+};
+
+static GDBusSignalTable server_signals[] = {
+	{ "PropertyChanged",		"sv"},
+	{ }
+};
+
+static void server_free(struct sap_server *server)
+{
+	DBG("[%s::%s]", __FILE__, __FUNCTION__);
+
+	if (!server)
+		return;
+
+	g_free(server->path);
+	g_free(server);
+}
+
+static void destroy_sap_interface(void *data)
+{
+	struct sap_server *server = data;
+
+	DBG("Unregistered interface %s on path %s",
+			SAP_SERVER_INTERFACE, server->path);
+
+	server_free(server);
+}
+
+int sap_server_register(const char *path, bdaddr_t *src)
+{
+	struct sap_server *server;
+
+	if(sap_init() < 0) {
+		error("Sap driver initialization failed.");
+		return -1;
+	}
+
+	server = g_new0(struct sap_server, 1);
+
+	if (!server) {
+		sap_exit();
+		return -ENOMEM;
+	}
+
+	server->enable = FALSE;
+
+	if (!g_dbus_register_interface(connection, path, SAP_SERVER_INTERFACE,
+				server_methods, server_signals, NULL,
+				server, destroy_sap_interface)) {
+		error("D-Bus failed to register %s interface",
+						SAP_SERVER_INTERFACE);
+		server_free(server);
+		sap_exit();
+		return -1;
+	}
+
+	server->path = g_strdup(path);
+	bacpy(&server->src, src);
+
+	return 0;
+}
+
+int sap_server_unregister(const char *path)
+{
+	g_dbus_unregister_interface(connection, path, SAP_SERVER_INTERFACE);
+	sap_exit();
+	return 0;
+}
+
+int sap_server_init(DBusConnection *conn)
+{
+	connection = dbus_connection_ref(conn);
+	return 0;
+}
+
+void sap_server_exit(void)
+{
+	dbus_connection_unref(connection);
+	connection = NULL;
+}
diff --git a/sap/server.h b/sap/server.h
new file mode 100644
index 0000000..6e7f6fc
--- /dev/null
+++ b/sap/server.h
@@ -0,0 +1,23 @@
+/*
+ *  BlueZ - Bluetooth protocol stack for Linux
+ *
+ *  Copyright (C) 2010 Claudio Takahasi<claudio.takahasi@openbossa.org>
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by
+ *  the Free Software Foundation; version 2 of the License.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program; if not, write to the Free Software
+ *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
+ */
+
+int sap_server_init(DBusConnection *conn);
+void sap_server_exit(void);
+int sap_server_register(const char *path, bdaddr_t *src);
+int sap_server_unregister(const char *path);
-- 
1.7.0.4
