Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 10/17] SAP: Make sap_error_rsp function static
Date: Wed, 6 Jun 2012 15:19:20 +0200
Message-ID: <1338988767-19467-10-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1338988767-19467-1-git-send-email-szymon.janc@tieto.com>
References: <1338988767-19467-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This error message is used to reply to SAP protocol errors and it
should not be used by drivers as they don't have access to server
internal state machine. Messages passed to drivers are valid and
properly formatted so drivers shall use result code in response
messages to indicate error (section 4.11 of SAP specification).
---
 sap/sap.h    |    1 -
 sap/server.c |   27 +++++++++++++--------------
 2 files changed, 13 insertions(+), 15 deletions(-)

diff --git a/sap/sap.h b/sap/sap.h
index 5a98bad..16c333a 100644
--- a/sap/sap.h
+++ b/sap/sap.h
@@ -173,7 +173,6 @@ int sap_power_sim_on_rsp(void *sap_device, uint8_t result);
 int sap_reset_sim_rsp(void *sap_device, uint8_t result);
 int sap_transfer_card_reader_status_rsp(void *sap_device, uint8_t result,
 						uint8_t status);
-int sap_error_rsp(void *sap_device);
 int sap_transport_protocol_rsp(void *sap_device, uint8_t result);
 
 /* Event indication. Implemented by server.c*/
diff --git a/sap/server.c b/sap/server.c
index a96c3fa..648fa58 100644
--- a/sap/server.c
+++ b/sap/server.c
@@ -286,6 +286,19 @@ static int disconnect_ind(struct sap_connection *conn, uint8_t disc_type)
 	return send_message(conn, buf, size);
 }
 
+static int sap_error_rsp(struct sap_connection *conn)
+{
+	struct sap_message msg;
+
+	memset(&msg, 0, sizeof(msg));
+	msg.id = SAP_ERROR_RESP;
+
+	error("SAP error (state %d pr 0x%02x).", conn->state,
+							conn->processing_req);
+
+	return send_message(conn, &msg, sizeof(msg));
+}
+
 static void connect_req(struct sap_connection *conn,
 				struct sap_parameter *param)
 {
@@ -928,20 +941,6 @@ int sap_transport_protocol_rsp(void *sap_device, uint8_t result)
 	return send_message(sap_device, buf, size);
 }
 
-int sap_error_rsp(void *sap_device)
-{
-	struct sap_message msg;
-	struct sap_connection *conn = sap_device;
-
-	memset(&msg, 0, sizeof(msg));
-	msg.id = SAP_ERROR_RESP;
-
-	error("SAP error (state %d pr 0x%02x).", conn->state,
-							conn->processing_req);
-
-	return send_message(conn, &msg, sizeof(msg));
-}
-
 int sap_status_ind(void *sap_device, uint8_t status_change)
 {
 	struct sap_connection *conn = sap_device;
-- 
on behalf of ST-Ericsson

