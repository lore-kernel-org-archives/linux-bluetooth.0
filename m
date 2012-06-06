Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 02/17] SAP: Use switch instead of if-else in sap_status_ind
Date: Wed, 6 Jun 2012 15:19:12 +0200
Message-ID: <1338988767-19467-2-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1338988767-19467-1-git-send-email-szymon.janc@tieto.com>
References: <1338988767-19467-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

It makes it easier to understand what actions are performed in each
server state.
---
 sap/server.c |   41 +++++++++++++++++++++++++----------------
 1 file changed, 25 insertions(+), 16 deletions(-)

diff --git a/sap/server.c b/sap/server.c
index f5d19c4..e5effac 100644
--- a/sap/server.c
+++ b/sap/server.c
@@ -955,26 +955,35 @@ int sap_status_ind(void *sap_device, uint8_t status_change)
 	DBG("state %d pr 0x%02x sc 0x%02x", conn->state, conn->processing_req,
 								status_change);
 
-	/* Might be need to change state to connected after ongoing call.*/
-	if (conn->state == SAP_STATE_CONNECT_MODEM_BUSY &&
-			status_change == SAP_STATUS_CHANGE_CARD_RESET)
-		sap_set_connected(conn);
+	switch (conn->state) {
+	case SAP_STATE_CONNECT_MODEM_BUSY:
+		if (status_change != SAP_STATUS_CHANGE_CARD_RESET)
+			break;
 
-	if (conn->state != SAP_STATE_CONNECTED &&
-			conn->state != SAP_STATE_GRACEFUL_DISCONNECT)
-		return 0;
+		/* Change state to connected after ongoing call ended */
+		sap_set_connected(conn);
+		/* fall */
+	case SAP_STATE_CONNECTED:
+	case SAP_STATE_GRACEFUL_DISCONNECT:
+		memset(buf, 0, sizeof(buf));
+		msg->id = SAP_STATUS_IND;
+		msg->nparam = 0x01;
 
-	memset(buf, 0, sizeof(buf));
-	msg->id = SAP_STATUS_IND;
-	msg->nparam = 0x01;
+		/* Add status change. */
+		param->id  = SAP_PARAM_ID_STATUS_CHANGE;
+		param->len = htons(SAP_PARAM_ID_STATUS_CHANGE_LEN);
+		*param->val = status_change;
+		size += PARAMETER_SIZE(SAP_PARAM_ID_STATUS_CHANGE_LEN);
 
-	/* Add status change. */
-	param->id  = SAP_PARAM_ID_STATUS_CHANGE;
-	param->len = htons(SAP_PARAM_ID_STATUS_CHANGE_LEN);
-	*param->val = status_change;
-	size += PARAMETER_SIZE(SAP_PARAM_ID_STATUS_CHANGE_LEN);
+		return send_message(sap_device, buf, size);
+	case SAP_STATE_DISCONNECTED:
+	case SAP_STATE_CONNECT_IN_PROGRESS:
+	case SAP_STATE_IMMEDIATE_DISCONNECT:
+	case SAP_STATE_CLIENT_DISCONNECT:
+		break;
+	}
 
-	return send_message(sap_device, buf, size);
+	return 0;
 }
 
 int sap_disconnect_ind(void *sap_device, uint8_t disc_type)
-- 
on behalf of ST-Ericsson

