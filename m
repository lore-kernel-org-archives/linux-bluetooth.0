Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 15/17] SAP: Remove connection when closing io
Date: Wed, 6 Jun 2012 15:19:25 +0200
Message-ID: <1338988767-19467-15-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1338988767-19467-1-git-send-email-szymon.janc@tieto.com>
References: <1338988767-19467-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

There is no need to keep it in memory after io has been closed.
---
 sap/server.c |   51 ++++++++++++++++++++-------------------------------
 1 file changed, 20 insertions(+), 31 deletions(-)

diff --git a/sap/server.c b/sap/server.c
index ee2624d..a619a23 100644
--- a/sap/server.c
+++ b/sap/server.c
@@ -580,6 +580,24 @@ static void stop_guard_timer(struct sap_server *server)
 	}
 }
 
+static void sap_server_remove_conn(struct sap_server *server)
+{
+	struct sap_connection *conn = server->conn;
+
+	DBG("conn %p", conn);
+
+	if (!conn)
+		return;
+
+	if (conn->io) {
+		g_io_channel_shutdown(conn->io, TRUE, NULL);
+		g_io_channel_unref(conn->io);
+	}
+
+	g_free(conn);
+	server->conn = NULL;
+}
+
 static gboolean guard_timeout(gpointer data)
 {
 	struct sap_server *server = data;
@@ -598,11 +616,7 @@ static gboolean guard_timeout(gpointer data)
 		/* Client opened RFCOMM channel but didn't send CONNECT_REQ,
 		 * in fixed time or client disconnected SAP connection but
 		 * didn't closed RFCOMM channel in fixed time.*/
-		if (conn->io) {
-			g_io_channel_shutdown(conn->io, TRUE, NULL);
-			g_io_channel_unref(conn->io);
-			conn->io = NULL;
-		}
+		sap_server_remove_conn(server);
 		break;
 
 	case SAP_STATE_GRACEFUL_DISCONNECT:
@@ -717,14 +731,7 @@ int sap_disconnect_rsp(void *sap_device)
 		return send_message(conn, &msg, sizeof(msg));
 
 	case SAP_STATE_IMMEDIATE_DISCONNECT:
-		conn->state = SAP_STATE_DISCONNECTED;
-		conn->processing_req = SAP_NO_REQ;
-
-		if (conn->io) {
-			g_io_channel_shutdown(conn->io, TRUE, NULL);
-			g_io_channel_unref(conn->io);
-			conn->io = NULL;
-		}
+		sap_server_remove_conn(server);
 
 		return 0;
 
@@ -1080,24 +1087,6 @@ error_rsp:
 	return -EBADMSG;
 }
 
-static void sap_server_remove_conn(struct sap_server *server)
-{
-	struct sap_connection *conn = server->conn;
-
-	DBG("conn %p", conn);
-
-	if (!conn)
-		return;
-
-	if (conn->io) {
-		g_io_channel_shutdown(conn->io, TRUE, NULL);
-		g_io_channel_unref(conn->io);
-	}
-
-	g_free(conn);
-	server->conn = NULL;
-}
-
 static gboolean sap_io_cb(GIOChannel *io, GIOCondition cond, gpointer data)
 {
 	char buf[SAP_BUF_SIZE];
-- 
on behalf of ST-Ericsson

