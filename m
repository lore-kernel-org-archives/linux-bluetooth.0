Return-Path: <cyrus@holtmann.org>
From: Waldemar Rymarkiewicz <waldemar.rymarkiewicz@tieto.com>
To: Johan Hedberg <johan.hedberg@gmail.com>
CC: <linux-bluetooth@vger.kernel.org>,
	Waldemar Rymarkiewicz <waldemar.rymarkiewicz@tieto.com>
Subject: [PATCH v3 4/4] Simplify return value in disconnect_req
Date: Tue, 31 May 2011 12:46:50 +0200
Message-ID: <1306838810-18325-4-git-send-email-waldemar.rymarkiewicz@tieto.com>
In-Reply-To: <1306838810-18325-1-git-send-email-waldemar.rymarkiewicz@tieto.com>
References: <1306838810-18325-1-git-send-email-waldemar.rymarkiewicz@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 sap/server.c |   21 +++++++--------------
 1 files changed, 7 insertions(+), 14 deletions(-)

diff --git a/sap/server.c b/sap/server.c
index c268cec..ec17759 100644
--- a/sap/server.c
+++ b/sap/server.c
@@ -349,11 +349,9 @@ static int disconnect_req(struct sap_connection *conn, uint8_t disc_type)
 
 	switch (disc_type) {
 	case SAP_DISCONNECTION_TYPE_GRACEFUL:
-		if (conn->state == SAP_STATE_DISCONNECTED)
-			goto error_req;
-
-		if (conn->state == SAP_STATE_CONNECT_IN_PROGRESS)
-			goto error_req;
+		if (conn->state == SAP_STATE_DISCONNECTED ||
+				conn->state == SAP_STATE_CONNECT_IN_PROGRESS)
+			return -EPERM;
 
 		if (conn->state == SAP_STATE_CONNECTED) {
 			conn->state = SAP_STATE_GRACEFUL_DISCONNECT;
@@ -367,11 +365,9 @@ static int disconnect_req(struct sap_connection *conn, uint8_t disc_type)
 		return 0;
 
 	case SAP_DISCONNECTION_TYPE_IMMEDIATE:
-		if (conn->state == SAP_STATE_DISCONNECTED)
-			goto error_req;
-
-		if (conn->state == SAP_STATE_CONNECT_IN_PROGRESS)
-			goto error_req;
+		if (conn->state == SAP_STATE_DISCONNECTED ||
+				conn->state == SAP_STATE_CONNECT_IN_PROGRESS)
+			return -EPERM;
 
 		if (conn->state == SAP_STATE_CONNECTED ||
 				conn->state == SAP_STATE_GRACEFUL_DISCONNECT) {
@@ -389,7 +385,7 @@ static int disconnect_req(struct sap_connection *conn, uint8_t disc_type)
 		if (conn->state != SAP_STATE_CONNECTED &&
 				conn->state != SAP_STATE_GRACEFUL_DISCONNECT) {
 			sap_error_rsp(conn);
-			goto error_req;
+			return -EPERM;
 		}
 
 		conn->state = SAP_STATE_CLIENT_DISCONNECT;
@@ -404,9 +400,6 @@ static int disconnect_req(struct sap_connection *conn, uint8_t disc_type)
 		error("Unknown disconnection type (0x%02x).", disc_type);
 		return -EINVAL;
 	}
-
-error_req:
-	return -EPERM;
 }
 
 static void transfer_apdu_req(struct sap_connection *conn,
-- 
1.7.4.1

