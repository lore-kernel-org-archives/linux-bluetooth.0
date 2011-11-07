Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: <henrik.possung@stericsson.com>, <ulrik.lauren@stericsson.com>,
	Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH 3/4] SAP: Fix handling ongoing call
Date: Mon, 7 Nov 2011 15:57:10 +0100
Message-ID: <1320677830-32338-1-git-send-email-lukasz.rymanowski@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

If device is in ongoing call SAP server shall
response on connect with connection status 0x04
and once call is ended shall send reset status
indication.

With this patch, when reset status indication
comes from backend and SAP server is in connection
in progreess state, SAP server changes state to connected.

Change-Id: Ied2a4efab12db496944be79351c862b54b579d19
---
 sap/server.c |   38 ++++++++++++++++++++++++++++----------
 1 files changed, 28 insertions(+), 10 deletions(-)

diff --git a/sap/server.c b/sap/server.c
index 06a4361..b8aa8a5 100644
--- a/sap/server.c
+++ b/sap/server.c
@@ -60,6 +60,7 @@
 enum {
 	SAP_STATE_DISCONNECTED,
 	SAP_STATE_CONNECT_IN_PROGRESS,
+	SAP_STATE_CONNECT_MODEM_BUSY,
 	SAP_STATE_CONNECTED,
 	SAP_STATE_GRACEFUL_DISCONNECT,
 	SAP_STATE_IMMEDIATE_DISCONNECT,
@@ -349,7 +350,8 @@ static int disconnect_req(struct sap_connection *conn, uint8_t disc_type)
 	switch (disc_type) {
 	case SAP_DISCONNECTION_TYPE_GRACEFUL:
 		if (conn->state == SAP_STATE_DISCONNECTED ||
-				conn->state == SAP_STATE_CONNECT_IN_PROGRESS)
+				conn->state == SAP_STATE_CONNECT_IN_PROGRESS ||
+				conn->state == SAP_STATE_CONNECT_MODEM_BUSY)
 			return -EPERM;
 
 		if (conn->state == SAP_STATE_CONNECTED) {
@@ -365,7 +367,8 @@ static int disconnect_req(struct sap_connection *conn, uint8_t disc_type)
 
 	case SAP_DISCONNECTION_TYPE_IMMEDIATE:
 		if (conn->state == SAP_STATE_DISCONNECTED ||
-				conn->state == SAP_STATE_CONNECT_IN_PROGRESS)
+				conn->state == SAP_STATE_CONNECT_IN_PROGRESS ||
+				conn->state == SAP_STATE_CONNECT_MODEM_BUSY)
 			return -EPERM;
 
 		if (conn->state == SAP_STATE_CONNECTED ||
@@ -602,6 +605,17 @@ static gboolean guard_timeout(gpointer data)
 	return FALSE;
 }
 
+static void sap_set_connected(struct sap_connection *conn)
+{
+	gboolean connected = TRUE;
+
+	emit_property_changed(connection, server->path,
+					SAP_SERVER_INTERFACE,
+		"Connected", DBUS_TYPE_BOOLEAN, &connected);
+
+	conn->state = SAP_STATE_CONNECTED;
+}
+
 int sap_connect_rsp(void *sap_device, uint8_t status, uint16_t maxmsgsize)
 {
 	struct sap_connection *conn = sap_device;
@@ -643,13 +657,10 @@ int sap_connect_rsp(void *sap_device, uint8_t status, uint16_t maxmsgsize)
 	}
 
 	if (status == SAP_STATUS_OK) {
-		gboolean connected = TRUE;
-
-		emit_property_changed(connection, server->path,
-						SAP_SERVER_INTERFACE,
-			"Connected", DBUS_TYPE_BOOLEAN, &connected);
-
-		conn->state = SAP_STATE_CONNECTED;
+		sap_set_connected(conn);
+	} else if (status == SAP_STATUS_OK_ONGOING_CALL) {
+		DBG("ongoing call. Wait for reset indication!");
+		conn->state = SAP_STATE_CONNECT_MODEM_BUSY;
 	} else {
 		conn->state = SAP_STATE_DISCONNECTED;
 
@@ -962,6 +973,11 @@ int sap_status_ind(void *sap_device, uint8_t status_change)
 	DBG("state %d pr 0x%02x sc 0x%02x", conn->state, conn->processing_req,
 				status_change);
 
+	/* Might be need to change state to connected after ongoing call.*/
+	if (conn->state == SAP_STATE_CONNECT_MODEM_BUSY &&
+			status_change == SAP_STATUS_CHANGE_CARD_RESET)
+		sap_set_connected(conn);
+
 	if (conn->state != SAP_STATE_CONNECTED &&
 			conn->state != SAP_STATE_GRACEFUL_DISCONNECT)
 		return 0;
@@ -1111,12 +1127,14 @@ static void sap_io_destroy(void *data)
 
 		stop_guard_timer(conn);
 
-		if (conn->state != SAP_STATE_CONNECT_IN_PROGRESS)
+		if (conn->state != SAP_STATE_CONNECT_IN_PROGRESS &&
+				conn->state != SAP_STATE_CONNECT_MODEM_BUSY)
 			emit_property_changed(connection, server->path,
 					SAP_SERVER_INTERFACE, "Connected",
 					DBUS_TYPE_BOOLEAN, &connected);
 
 		if (conn->state == SAP_STATE_CONNECT_IN_PROGRESS ||
+				conn->state == SAP_STATE_CONNECT_MODEM_BUSY ||
 				conn->state == SAP_STATE_CONNECTED ||
 				conn->state == SAP_STATE_GRACEFUL_DISCONNECT)
 			sap_disconnect_req(NULL, 1);
-- 
on behalf of ST-Ericsson

