Return-Path: <cyrus@holtmann.org>
From: Waldemar Rymarkiewicz <waldemar.rymarkiewicz@tieto.com>
To: Johan Hedberg <johan.hedberg@gmail.com>
CC: <linux-bluetooth@vger.kernel.org>,
	Waldemar Rymarkiewicz <waldemar.rymarkiewicz@tieto.com>
Subject: [PATCH v5 3/4] Sim Access Profile dummy driver
Date: Wed, 16 Mar 2011 13:10:20 +0100
Message-ID: <1300277421-8053-3-git-send-email-waldemar.rymarkiewicz@tieto.com>
In-Reply-To: <1300277421-8053-1-git-send-email-waldemar.rymarkiewicz@tieto.com>
References: <1300277421-8053-1-git-send-email-waldemar.rymarkiewicz@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Add SAP dummy driver implementation and extend configure
with --with-sap=<driver>.
---
 .gitignore      |    1 +
 Makefile.am     |   13 +++-
 acinclude.m4    |    6 ++
 sap/sap-dummy.c |  269 ++++++++++++++++++++++++++++++++++++++++++++++++++++---
 4 files changed, 275 insertions(+), 14 deletions(-)

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
index 7267200..2994bf9 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -148,7 +148,13 @@ builtin_modules += sap
 builtin_sources += sap/main.c \
 			sap/manager.h sap/manager.c \
 			sap/server.h sap/server.c \
-			sap/sap.h sap/sap-dummy.c
+			sap/sap.h
+
+builtin_nodist += sap/sap.c
+
+noinst_LIBRARIES = sap/libsap.a
+
+sap_libsap_a_SOURCES = sap/sap.h sap/sap-dummy.c
 endif
 
 if INPUTPLUGIN
@@ -278,7 +284,7 @@ EXTRA_DIST += src/genbuiltin src/bluetooth.conf \
 			input/input.conf serial/serial.conf \
 			audio/audio.conf audio/telephony-dummy.c \
 			audio/telephony-maemo5.c audio/telephony-ofono.c \
-			audio/telephony-maemo6.c
+			audio/telephony-maemo6.c sap/sap-dummy.c
 
 
 if ALSA
@@ -403,6 +409,9 @@ src/builtin.h: src/genbuiltin $(builtin_sources)
 audio/telephony.c: audio/@TELEPHONY_DRIVER@
 	$(AM_V_GEN)$(LN_S) $(abs_top_srcdir)/$< $@
 
+sap/sap.c: sap/@SAP_DRIVER@
+	$(AM_V_GEN)$(LN_S) $(abs_top_srcdir)/$< $@
+
 scripts/%.rules:
 	$(AM_V_GEN)cp $(subst 97-,,$@) $@
 
diff --git a/acinclude.m4 b/acinclude.m4
index d07418f..faa7f7c 100644
--- a/acinclude.m4
+++ b/acinclude.m4
@@ -205,6 +205,7 @@ AC_DEFUN([AC_ARG_BLUEZ], [
 	configfiles_enable=yes
 	telephony_driver=dummy
 	maemo6_enable=no
+	sap_driver=dummy
 
 	AC_ARG_ENABLE(optimization, AC_HELP_STRING([--disable-optimization], [disable code optimization]), [
 		optimization_enable=${enableval}
@@ -226,6 +227,11 @@ AC_DEFUN([AC_ARG_BLUEZ], [
 		sap_enable=${enableval}
 	])
 
+	AC_ARG_WITH(sap, AC_HELP_STRING([--with-sap=DRIVER], [select SAP driver]), [
+		sap_driver=${withval}
+	])
+	AC_SUBST([SAP_DRIVER], [sap-${sap_driver}.c])
+
 	AC_ARG_ENABLE(serial, AC_HELP_STRING([--disable-serial], [disable serial plugin]), [
 		serial_enable=${enableval}
 	])
diff --git a/sap/sap-dummy.c b/sap/sap-dummy.c
index b433ba3..39e1fc9 100644
--- a/sap/sap-dummy.c
+++ b/sap/sap-dummy.c
@@ -2,6 +2,7 @@
  *  BlueZ - Bluetooth protocol stack for Linux
  *
  *  Copyright (C) 2010 ST-Ericsson SA
+ *  Copyright (C) 2011 Tieto Poland
  *
  *  Author: Waldemar Rymarkiewicz <waldemar.rymarkiewicz@tieto.com>
  *          for ST-Ericsson
@@ -21,50 +22,185 @@
  *  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
  */
 
+#ifdef HAVE_CONFIG_H
+#include <config.h>
+#endif
+
+#include <unistd.h>
+#include <stdlib.h>
+#include <stdint.h>
+#include <glib.h>
+#include <gdbus.h>
+
 #include "log.h"
 #include "sap.h"
 
+#define SAP_DUMMY_IFACE "org.bluez.SimAccessTest"
+#define SAP_DUMMY_PATH "/org/bluez/test"
+
+enum {
+	SIM_DISCONNECTED= 0x00,
+	SIM_CONNECTED	= 0x01,
+	SIM_POWERED_OFF	= 0x02,
+	SIM_MISSING	= 0x03
+};
+
+static DBusConnection *connection = NULL;
+
+static int sim_card_conn_status = SIM_DISCONNECTED;
+static void *sap_data = NULL;  /* SAP server private data.*/
+static gboolean ongoing_call_status = FALSE;
+static int max_msg_size_supported = 512;
+
 void sap_connect_req(void *sap_device, uint16_t maxmsgsize)
 {
-	sap_connect_rsp(sap_device, SAP_STATUS_OK, maxmsgsize);
-	sap_status_ind(sap_device, SAP_STATUS_CHANGE_CARD_RESET);
+	DBG("status: %d", sim_card_conn_status);
+
+	if (sim_card_conn_status != SIM_DISCONNECTED) {
+		sap_connect_rsp(sap_device, SAP_STATUS_CONNECTION_FAILED,
+								maxmsgsize);
+		return;
+	} else if (max_msg_size_supported > maxmsgsize) {
+		sap_connect_rsp(sap_device, SAP_STATUS_MAX_MSG_SIZE_TOO_SMALL,
+						max_msg_size_supported);
+		return;
+	} else if (max_msg_size_supported < maxmsgsize) {
+		sap_connect_rsp(sap_device,
+				SAP_STATUS_MAX_MSG_SIZE_NOT_SUPPORTED,
+				max_msg_size_supported);
+		return;
+	} else if (ongoing_call_status) {
+		sap_connect_rsp(sap_device, SAP_STATUS_OK_ONGOING_CALL,
+								maxmsgsize);
+		return;
+	} else {
+		sim_card_conn_status = SIM_CONNECTED;
+		sap_data = sap_device;
+
+		sap_connect_rsp(sap_device, SAP_STATUS_OK, maxmsgsize);
+		sap_status_ind(sap_device, SAP_STATUS_CHANGE_CARD_RESET);
+	}
 }
 
 void sap_disconnect_req(void *sap_device, uint8_t linkloss)
 {
+	sim_card_conn_status = SIM_DISCONNECTED;
+	sap_data = NULL;
+	ongoing_call_status = FALSE;
+
+	DBG("status: %d", sim_card_conn_status);
+
+	if (linkloss)
+		return;
+
 	sap_disconnect_rsp(sap_device);
 }
 
 void sap_transfer_apdu_req(void *sap_device, struct sap_parameter *param)
 {
-	sap_transfer_apdu_rsp(sap_device, SAP_RESULT_OK, NULL, 0);
+	char apdu[] = "APDU response!";
+
+	DBG("status: %d", sim_card_conn_status);
+
+	if (sim_card_conn_status == SIM_MISSING)
+		sap_transfer_apdu_rsp(sap_device,
+				SAP_RESULT_ERROR_CARD_REMOVED, NULL, 0);
+	else if (sim_card_conn_status == SIM_POWERED_OFF)
+		sap_transfer_apdu_rsp(sap_device, SAP_RESULT_ERROR_POWERED_OFF,
+								NULL, 0);
+	else if (sim_card_conn_status != SIM_CONNECTED)
+		sap_transfer_apdu_rsp(sap_device,
+			SAP_RESULT_ERROR_NOT_ACCESSIBLE, NULL, 0);
+	else
+		sap_transfer_apdu_rsp(sap_device, SAP_RESULT_OK,
+						(uint8_t*)&apdu, sizeof(apdu));
 }
 
 void sap_transfer_atr_req(void *sap_device)
 {
-	sap_transfer_atr_rsp(sap_device, SAP_RESULT_OK, NULL, 0);
+	char atr[] = "ATR response!";
+
+	DBG("status: %d", sim_card_conn_status);
+
+	if (sim_card_conn_status == SIM_MISSING)
+		sap_transfer_atr_rsp(sap_device, SAP_RESULT_ERROR_CARD_REMOVED,
+								NULL, 0);
+	else if (sim_card_conn_status == SIM_POWERED_OFF)
+		sap_transfer_atr_rsp(sap_device, SAP_RESULT_ERROR_POWERED_OFF,
+								NULL, 0);
+	else if (sim_card_conn_status != SIM_CONNECTED)
+		sap_transfer_atr_rsp(sap_device, SAP_RESULT_ERROR_NO_REASON,
+								NULL, 0);
+	else
+		sap_transfer_atr_rsp(sap_device, SAP_RESULT_OK,
+						(uint8_t*)&atr, sizeof(atr));
 }
 
 void sap_power_sim_off_req(void *sap_device)
 {
-	sap_power_sim_off_rsp(sap_device, SAP_RESULT_OK);
+	DBG("status: %d", sim_card_conn_status);
+
+	if (sim_card_conn_status == SIM_MISSING) {
+		sap_power_sim_off_rsp(sap_device,
+					SAP_RESULT_ERROR_CARD_REMOVED);
+	} else if (sim_card_conn_status == SIM_POWERED_OFF) {
+		sap_power_sim_off_rsp(sap_device,
+					SAP_RESULT_ERROR_POWERED_OFF);
+	} else if (sim_card_conn_status != SIM_CONNECTED) {
+		sap_power_sim_off_rsp(sap_device,
+					SAP_RESULT_ERROR_NO_REASON);
+	} else {
+		sap_power_sim_off_rsp(sap_device, SAP_RESULT_OK);
+		sim_card_conn_status = SIM_POWERED_OFF;
+	}
 }
 
 void sap_power_sim_on_req(void *sap_device)
 {
-	sap_power_sim_on_rsp(sap_device, SAP_RESULT_OK);
+	DBG("status: %d", sim_card_conn_status);
+
+	if (sim_card_conn_status == SIM_MISSING) {
+		sap_power_sim_on_rsp(sap_device,
+					SAP_RESULT_ERROR_CARD_REMOVED);
+	} else if (sim_card_conn_status == SIM_POWERED_OFF) {
+		sap_power_sim_on_rsp(sap_device, SAP_RESULT_OK);
+		sim_card_conn_status = SIM_CONNECTED;
+		return;
+	} else if (sim_card_conn_status != SIM_CONNECTED) {
+		sap_power_sim_on_rsp(sap_device,
+					SAP_RESULT_ERROR_NOT_ACCESSIBLE);
+	} else {
+		sap_power_sim_on_rsp(sap_device,
+					SAP_RESULT_ERROR_NO_REASON);
+	}
 }
 
 void sap_reset_sim_req(void *sap_device)
 {
-	sap_reset_sim_rsp(sap_device, SAP_RESULT_OK);
-	sap_status_ind(sap_device, SAP_STATUS_CHANGE_CARD_RESET);
+	DBG("status: %d", sim_card_conn_status);
+
+	if (sim_card_conn_status == SIM_MISSING) {
+		sap_reset_sim_rsp(sap_device, SAP_RESULT_ERROR_CARD_REMOVED);
+	} else if (sim_card_conn_status == SIM_POWERED_OFF) {
+		sap_reset_sim_rsp(sap_device, SAP_RESULT_ERROR_POWERED_OFF);
+	} else if (sim_card_conn_status != SIM_CONNECTED) {
+		sap_reset_sim_rsp(sap_device, SAP_RESULT_ERROR_NO_REASON);
+	} else {
+		sap_reset_sim_rsp(sap_device, SAP_RESULT_OK);
+	}
 }
 
 void sap_transfer_card_reader_status_req(void *sap_device)
 {
-	sap_transfer_card_reader_status_rsp(sap_device, SAP_RESULT_OK,
-						ICC_READER_CARD_POWERED_ON);
+	DBG("status: %d", sim_card_conn_status);
+
+	if (sim_card_conn_status != SIM_CONNECTED) {
+		sap_transfer_card_reader_status_rsp(sap_device,
+					SAP_RESULT_ERROR_NO_REASON, 0xF1);
+		return;
+	}
+
+	sap_transfer_card_reader_status_rsp(sap_device, SAP_RESULT_OK, 0xF1);
 }
 
 void sap_set_transport_protocol_req(void *sap_device,
@@ -73,13 +209,122 @@ void sap_set_transport_protocol_req(void *sap_device,
 	sap_transport_protocol_rsp(sap_device, SAP_RESULT_NOT_SUPPORTED);
 }
 
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
+		sap_connect_rsp(sap_data, SAP_STATUS_OK,
+						max_msg_size_supported);
+		sap_status_ind(sap_data, SAP_STATUS_CHANGE_CARD_RESET);
+		ongoing_call_status = ongoing;
+	} else if (!ongoing_call_status && ongoing) {
+		/* An ongoing call has started.*/
+		ongoing_call_status = ongoing;
+	}
+
+	DBG("OngoingCall status set to %d", ongoing_call_status);
+
+	return dbus_message_new_method_return(msg);
+}
+
+static DBusMessage *max_msg_size(DBusConnection *conn, DBusMessage *msg,
+						void *data)
+{
+	dbus_uint32_t size;
+
+	if (sim_card_conn_status == SIM_CONNECTED)
+		return g_dbus_create_error(msg, "org.bluez.Error.Failed",
+				"Can't change msg size when connected.");
+
+	if (!dbus_message_get_args(msg, NULL, DBUS_TYPE_UINT32, &size,
+							DBUS_TYPE_INVALID))
+		return invalid_args(msg);
+
+	max_msg_size_supported = size;
+
+	DBG("MaxMessageSize set to %d", max_msg_size_supported);
+
+	return dbus_message_new_method_return(msg);
+}
+
+static DBusMessage *disconnect(DBusConnection *conn, DBusMessage *msg,
+						void *data)
+{
+	sim_card_conn_status = SIM_DISCONNECTED;
+	sap_status_ind(sap_data, SAP_STATUS_CHANGE_CARD_NOT_ACCESSIBLE);
+
+	return dbus_message_new_method_return(msg);
+}
+
+static DBusMessage *card_status(DBusConnection *conn, DBusMessage *msg,
+								void *data)
+{
+	dbus_uint32_t status;
+
+	DBG("status %d", sim_card_conn_status);
+
+	if (sim_card_conn_status != SIM_CONNECTED)
+		return g_dbus_create_error(msg, "org.bluez.Error.Failed",
+				"Can't change msg size when not connected.");
+
+	if (!dbus_message_get_args(msg, NULL, DBUS_TYPE_UINT32, &status,
+							DBUS_TYPE_INVALID))
+		return invalid_args(msg);
+
+	if (status) {
+		if (sim_card_conn_status == SIM_MISSING) {
+			sim_card_conn_status = SIM_CONNECTED;
+			sap_status_ind(sap_data,
+					SAP_STATUS_CHANGE_CARD_INSERTED);
+		}
+	} else {
+		sim_card_conn_status = SIM_MISSING;
+		sap_status_ind(sap_data, SAP_STATUS_CHANGE_CARD_REMOVED);
+	}
+
+	DBG("Card status changed to %d", status);
+
+	return dbus_message_new_method_return(msg);
+}
+
+static GDBusMethodTable dummy_methods[] = {
+	{ "OngoingCall", "b", "", ongoing_call},
+	{ "MaxMessageSize", "u", "", max_msg_size},
+	{ "Disconnect", "", "", disconnect},
+	{ "CardStatus", "u", "", card_status},
+	{ }
+};
+
 int sap_init(void)
 {
-	DBG("SAP driver init.");
+	connection = dbus_bus_get(DBUS_BUS_SYSTEM, NULL);
+
+	if (g_dbus_register_interface(connection, SAP_DUMMY_PATH,
+				SAP_DUMMY_IFACE, dummy_methods, NULL, NULL,
+				NULL, NULL) == FALSE) {
+		error("sap-dummy interface %s init failed on path %s",
+					SAP_DUMMY_IFACE, SAP_DUMMY_PATH);
+		return -1;
+	}
+
 	return 0;
 }
 
 void sap_exit(void)
 {
-	DBG("SAP driver exit.");
+	dbus_connection_unref(connection);
+	connection = NULL;
 }
-- 
1.7.1

