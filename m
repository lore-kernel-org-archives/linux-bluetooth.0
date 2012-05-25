Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 08/10] SAP: Remove one line of indentation in sap_io_destroy
Date: Fri, 25 May 2012 16:21:00 +0200
Message-ID: <1337955662-19016-8-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1337955662-19016-1-git-send-email-szymon.janc@tieto.com>
References: <1337955662-19016-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 sap/server.c |   26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/sap/server.c b/sap/server.c
index 98440e8..00c540e 100644
--- a/sap/server.c
+++ b/sap/server.c
@@ -1111,28 +1111,28 @@ static gboolean sap_io_cb(GIOChannel *io, GIOCondition cond, gpointer data)
 static void sap_io_destroy(void *data)
 {
 	struct sap_connection *conn = data;
+	gboolean connected = FALSE;
 
 	DBG("conn %p", conn);
 
-	if (conn && conn->io) {
-		gboolean connected = FALSE;
+	if (!conn || !conn->io)
+		return;
 
-		stop_guard_timer(conn);
+	stop_guard_timer(conn);
 
-		if (conn->state != SAP_STATE_CONNECT_IN_PROGRESS &&
-				conn->state != SAP_STATE_CONNECT_MODEM_BUSY)
-			emit_property_changed(connection, server->path,
+	if (conn->state != SAP_STATE_CONNECT_IN_PROGRESS &&
+			conn->state != SAP_STATE_CONNECT_MODEM_BUSY)
+		emit_property_changed(connection, server->path,
 					SAP_SERVER_INTERFACE, "Connected",
 					DBUS_TYPE_BOOLEAN, &connected);
 
-		if (conn->state == SAP_STATE_CONNECT_IN_PROGRESS ||
-				conn->state == SAP_STATE_CONNECT_MODEM_BUSY ||
-				conn->state == SAP_STATE_CONNECTED ||
-				conn->state == SAP_STATE_GRACEFUL_DISCONNECT)
-			sap_disconnect_req(NULL, 1);
+	if (conn->state == SAP_STATE_CONNECT_IN_PROGRESS ||
+			conn->state == SAP_STATE_CONNECT_MODEM_BUSY ||
+			conn->state == SAP_STATE_CONNECTED ||
+			conn->state == SAP_STATE_GRACEFUL_DISCONNECT)
+		sap_disconnect_req(NULL, 1);
 
-		sap_conn_remove(conn);
-	}
+	sap_conn_remove(conn);
 }
 
 static void sap_connect_cb(GIOChannel *io, GError *gerr, gpointer data)
-- 
on behalf of ST-Ericsson

