Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: <kanak.gupta@stericsson.com>, Szymon Janc <szymon.janc@tieto.com>
Subject: [RFC 1/2] SAP: Add Terminate method to org.bluez.SimAccess
Date: Thu, 29 Mar 2012 16:27:03 +0200
Message-ID: <1333031224-26358-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This method will trigger server to immediate disconnect from client.
This is required to pass TP/DCN/BV-03-I.
---
 doc/sap-api.txt |    7 +++++++
 sap/server.c    |   23 +++++++++++++++++------
 2 files changed, 24 insertions(+), 6 deletions(-)

diff --git a/doc/sap-api.txt b/doc/sap-api.txt
index b8b7253..e54eb77 100644
--- a/doc/sap-api.txt
+++ b/doc/sap-api.txt
@@ -17,6 +17,13 @@ Methods		void Disconnect()
 
 			Possible errors: org.bluez.Error.Failed
 
+		void Terminate()
+
+			Terminate SAP connection with client.
+			This performs immediate disconnect.
+
+			Possible errors: org.bluez.Error.Failed
+
 		dict GetProperties()
 
 			Return all properties for the interface. See the
diff --git a/sap/server.c b/sap/server.c
index b5abd70..c7ea112 100644
--- a/sap/server.c
+++ b/sap/server.c
@@ -1251,11 +1251,9 @@ static inline DBusMessage *message_failed(DBusMessage *msg,
 								description);
 }
 
-static DBusMessage *disconnect(DBusConnection *conn, DBusMessage *msg,
-								void *data)
+static DBusMessage *disconnect(DBusMessage *msg, struct sap_server *server,
+					enum sap_disconnection_type type)
 {
-	struct sap_server *server = data;
-
 	if (!server)
 		return message_failed(msg, "Server internal error.");
 
@@ -1264,13 +1262,25 @@ static DBusMessage *disconnect(DBusConnection *conn, DBusMessage *msg,
 	if (!server->conn)
 		return message_failed(msg, "Client already disconnected");
 
-	if (disconnect_req(server->conn, SAP_DISCONNECTION_TYPE_GRACEFUL) < 0)
+	if (disconnect_req(server->conn, type) < 0)
 		return g_dbus_create_error(msg, ERROR_INTERFACE	".Failed",
 					"There is no active connection");
 
 	return dbus_message_new_method_return(msg);
 }
 
+static DBusMessage *disconnect_graceful(DBusConnection *conn, DBusMessage *msg,
+								void *data)
+{
+	return disconnect(msg, data, SAP_DISCONNECTION_TYPE_GRACEFUL);
+}
+
+static DBusMessage *disconnect_immediate(DBusConnection *conn, DBusMessage *msg,
+								void *data)
+{
+	return disconnect(msg, data, SAP_DISCONNECTION_TYPE_IMMEDIATE);
+}
+
 static DBusMessage *get_properties(DBusConnection *c,
 				DBusMessage *msg, void *data)
 {
@@ -1305,7 +1315,8 @@ static DBusMessage *get_properties(DBusConnection *c,
 
 static GDBusMethodTable server_methods[] = {
 	{"GetProperties", "", "a{sv}", get_properties},
-	{"Disconnect", "", "", disconnect},
+	{"Disconnect", "", "", disconnect_graceful},
+	{"Terminate", "", "", disconnect_immediate},
 	{ }
 };
 
-- 
on behalf of ST-Ericsson

