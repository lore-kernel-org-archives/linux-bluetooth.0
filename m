Return-Path: <cyrus@holtmann.org>
From: Waldemar Rymarkiewicz <waldemar.rymarkiewicz@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Johan Hedberg <johan.hedberg@gmail.com>,
	Waldemar Rymarkiewicz <waldemar.rymarkiewicz@tieto.com>
Subject: [PATCH v2] Add sap_disconnect_ind interface for sap-sim drivers
Date: Thu, 24 Mar 2011 17:16:42 +0100
Message-ID: <1300983402-2970-1-git-send-email-waldemar.rymarkiewicz@tieto.com>
In-Reply-To: <1300982971-2869-1-git-send-email-waldemar.rymarkiewicz@tieto.com>
References: <1300982971-2869-1-git-send-email-waldemar.rymarkiewicz@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The sap_disconnect_ind() let's the sim driver to indicate
immediate disconnection.

Add support of immediate disconnection in sap-dummy driver
as well as a card status change in order to pass all PTS tests.
---
 sap/sap-dummy.c |   31 ++++++++++++++++++++++++-------
 sap/sap.h       |    1 +
 sap/server.c    |    7 +++++++
 3 files changed, 32 insertions(+), 7 deletions(-)

diff --git a/sap/sap-dummy.c b/sap/sap-dummy.c
index 39e1fc9..37982be 100644
--- a/sap/sap-dummy.c
+++ b/sap/sap-dummy.c
@@ -260,11 +260,15 @@ static DBusMessage *max_msg_size(DBusConnection *conn, DBusMessage *msg,
 	return dbus_message_new_method_return(msg);
 }
 
-static DBusMessage *disconnect(DBusConnection *conn, DBusMessage *msg,
+static DBusMessage *disconnect_immediate(DBusConnection *conn, DBusMessage *msg,
 						void *data)
 {
+	if (sim_card_conn_status == SIM_DISCONNECTED)
+		return g_dbus_create_error(msg, "org.bluez.Error.Failed",
+				"Already disconnected.");
+
 	sim_card_conn_status = SIM_DISCONNECTED;
-	sap_status_ind(sap_data, SAP_STATUS_CHANGE_CARD_NOT_ACCESSIBLE);
+	sap_disconnect_ind(sap_data, SAP_DISCONNECTION_TYPE_IMMEDIATE);
 
 	return dbus_message_new_method_return(msg);
 }
@@ -284,15 +288,28 @@ static DBusMessage *card_status(DBusConnection *conn, DBusMessage *msg,
 							DBUS_TYPE_INVALID))
 		return invalid_args(msg);
 
-	if (status) {
+	switch (status) {
+	case 0: /* card removed */
+		sim_card_conn_status = SIM_MISSING;
+		sap_status_ind(sap_data, SAP_STATUS_CHANGE_CARD_REMOVED);
+		break;
+
+	case 1: /* card inserted */
 		if (sim_card_conn_status == SIM_MISSING) {
 			sim_card_conn_status = SIM_CONNECTED;
 			sap_status_ind(sap_data,
 					SAP_STATUS_CHANGE_CARD_INSERTED);
 		}
-	} else {
-		sim_card_conn_status = SIM_MISSING;
-		sap_status_ind(sap_data, SAP_STATUS_CHANGE_CARD_REMOVED);
+		break;
+
+	case 2: /* card not longer available*/
+		sim_card_conn_status = SIM_POWERED_OFF;
+		sap_status_ind(sap_data, SAP_STATUS_CHANGE_CARD_NOT_ACCESSIBLE);
+		break;
+
+	default:
+		return g_dbus_create_error(msg, "org.bluez.Error.Failed",
+				"Unknown card status. Use 0, 1 or 2.");
 	}
 
 	DBG("Card status changed to %d", status);
@@ -303,7 +320,7 @@ static DBusMessage *card_status(DBusConnection *conn, DBusMessage *msg,
 static GDBusMethodTable dummy_methods[] = {
 	{ "OngoingCall", "b", "", ongoing_call},
 	{ "MaxMessageSize", "u", "", max_msg_size},
-	{ "Disconnect", "", "", disconnect},
+	{ "DisconnectImmediate", "", "", disconnect_immediate},
 	{ "CardStatus", "u", "", card_status},
 	{ }
 };
diff --git a/sap/sap.h b/sap/sap.h
index 24240ca..7c4a815 100644
--- a/sap/sap.h
+++ b/sap/sap.h
@@ -184,3 +184,4 @@ int sap_transport_protocol_rsp(void *sap_device, uint8_t result);
 
 /* Event indication. Implemented by server.c*/
 int sap_status_ind(void *sap_device, uint8_t status_change);
+int sap_disconnect_ind(void *sap_device, uint8_t disc_type);
diff --git a/sap/server.c b/sap/server.c
index 35abffb..e3f756c 100644
--- a/sap/server.c
+++ b/sap/server.c
@@ -1000,6 +1000,13 @@ int sap_status_ind(void *sap_device, uint8_t status_change)
 	return send_message(sap_device, buf, size);
 }
 
+int sap_disconnect_ind(void *sap_device, uint8_t disc_type)
+{
+	struct sap_connection *conn = sap_device;
+
+	return disconnect_req(conn, SAP_DISCONNECTION_TYPE_IMMEDIATE);
+}
+
 static int handle_cmd(void *data, void *buf, size_t size)
 {
 	struct sap_message *msg = buf;
-- 
1.7.1

