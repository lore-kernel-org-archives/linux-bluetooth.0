Return-Path: <cyrus@holtmann.org>
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Anderson Lizardo <anderson.lizardo@openbossa.org>
Subject: [PATCH BlueZ 2/4] sap: Use btd_error_* functions
Date: Fri, 21 Dec 2012 12:25:01 -0400
Message-Id: <1356107103-18039-2-git-send-email-anderson.lizardo@openbossa.org>
In-Reply-To: <1356107103-18039-1-git-send-email-anderson.lizardo@openbossa.org>
References: <1356107103-18039-1-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

These helper functions are available for plugins and simplify error
handling code.
---
 profiles/sap/sap-dummy.c |   24 +++++++++---------------
 profiles/sap/server.c    |   14 +++-----------
 2 files changed, 12 insertions(+), 26 deletions(-)

diff --git a/profiles/sap/sap-dummy.c b/profiles/sap/sap-dummy.c
index ffaf847..f68e048 100644
--- a/profiles/sap/sap-dummy.c
+++ b/profiles/sap/sap-dummy.c
@@ -31,6 +31,7 @@
 #include <stdint.h>
 
 #include "dbus-common.h"
+#include "error.h"
 #include "log.h"
 #include "sap.h"
 
@@ -234,12 +235,6 @@ void sap_set_transport_protocol_req(void *sap_device,
 	sap_transport_protocol_rsp(sap_device, SAP_RESULT_NOT_SUPPORTED);
 }
 
-static inline DBusMessage *invalid_args(DBusMessage *msg)
-{
-	return g_dbus_create_error(msg, "org.bluez.Error.InvalidArguments",
-					"Invalid arguments in method call");
-}
-
 static DBusMessage *ongoing_call(DBusConnection *conn, DBusMessage *msg,
 						void *data)
 {
@@ -247,7 +242,7 @@ static DBusMessage *ongoing_call(DBusConnection *conn, DBusMessage *msg,
 
 	if (!dbus_message_get_args(msg, NULL, DBUS_TYPE_BOOLEAN, &ongoing,
 						DBUS_TYPE_INVALID))
-		return invalid_args(msg);
+		return btd_error_invalid_args(msg);
 
 	if (ongoing_call_status && !ongoing) {
 		/* An ongoing call has finished. Continue connection.*/
@@ -269,12 +264,12 @@ static DBusMessage *max_msg_size(DBusConnection *conn, DBusMessage *msg,
 	dbus_uint32_t size;
 
 	if (sim_card_conn_status == SIM_CONNECTED)
-		return g_dbus_create_error(msg, "org.bluez.Error.Failed",
+		return btd_error_failed(msg,
 				"Can't change msg size when connected.");
 
 	if (!dbus_message_get_args(msg, NULL, DBUS_TYPE_UINT32, &size,
 							DBUS_TYPE_INVALID))
-		return invalid_args(msg);
+		return btd_error_invalid_args(msg);
 
 	max_msg_size_supported = size;
 
@@ -287,8 +282,7 @@ static DBusMessage *disconnect_immediate(DBusConnection *conn, DBusMessage *msg,
 						void *data)
 {
 	if (sim_card_conn_status == SIM_DISCONNECTED)
-		return g_dbus_create_error(msg, "org.bluez.Error.Failed",
-				"Already disconnected.");
+		return btd_error_failed(msg, "Already disconnected.");
 
 	sim_card_conn_status = SIM_DISCONNECTED;
 	sap_disconnect_ind(sap_data, SAP_DISCONNECTION_TYPE_IMMEDIATE);
@@ -304,12 +298,12 @@ static DBusMessage *card_status(DBusConnection *conn, DBusMessage *msg,
 	DBG("status %d", sim_card_conn_status);
 
 	if (sim_card_conn_status != SIM_CONNECTED)
-		return g_dbus_create_error(msg, "org.bluez.Error.Failed",
+		return btd_error_failed(msg,
 				"Can't change msg size when not connected.");
 
 	if (!dbus_message_get_args(msg, NULL, DBUS_TYPE_UINT32, &status,
 							DBUS_TYPE_INVALID))
-		return invalid_args(msg);
+		return btd_error_invalid_args(msg);
 
 	switch (status) {
 	case 0: /* card removed */
@@ -331,8 +325,8 @@ static DBusMessage *card_status(DBusConnection *conn, DBusMessage *msg,
 		break;
 
 	default:
-		return g_dbus_create_error(msg, "org.bluez.Error.Failed",
-				"Unknown card status. Use 0, 1 or 2.");
+		return btd_error_failed(msg,
+					"Unknown card status. Use 0, 1 or 2.");
 	}
 
 	DBG("Card status changed to %d", status);
diff --git a/profiles/sap/server.c b/profiles/sap/server.c
index 01caa33..0fa4e7c 100644
--- a/profiles/sap/server.c
+++ b/profiles/sap/server.c
@@ -1260,29 +1260,21 @@ static void connect_confirm_cb(GIOChannel *io, gpointer data)
 	DBG("Authorizing incoming SAP connection from %s", dstaddr);
 }
 
-static inline DBusMessage *message_failed(DBusMessage *msg,
-					const char *description)
-{
-	return g_dbus_create_error(msg, ERROR_INTERFACE ".Failed", "%s",
-								description);
-}
-
 static DBusMessage *disconnect(DBusConnection *conn, DBusMessage *msg,
 								void *data)
 {
 	struct sap_server *server = data;
 
 	if (!server)
-		return message_failed(msg, "Server internal error.");
+		return btd_error_failed(msg, "Server internal error.");
 
 	DBG("conn %p", server->conn);
 
 	if (!server->conn)
-		return message_failed(msg, "Client already disconnected");
+		return btd_error_failed(msg, "Client already disconnected");
 
 	if (disconnect_req(server, SAP_DISCONNECTION_TYPE_GRACEFUL) < 0)
-		return g_dbus_create_error(msg, ERROR_INTERFACE ".Failed",
-					"There is no active connection");
+		return btd_error_failed(msg, "There is no active connection");
 
 	return dbus_message_new_method_return(msg);
 }
-- 
1.7.9.5

