Return-Path: <cyrus@holtmann.org>
From: Christian Fetzer <christian.fetzer@oss.bmw-carit.de>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 1/8] obexd: Cache SDP record in bluetooth transport
Date: Tue,  9 Apr 2013 13:54:01 +0200
Message-Id: <1365508448-13171-2-git-send-email-christian.fetzer@oss.bmw-carit.de>
In-Reply-To: <1365508448-13171-1-git-send-email-christian.fetzer@oss.bmw-carit.de>
References: <1365508448-13171-1-git-send-email-christian.fetzer@oss.bmw-carit.de>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Christian Fetzer <christian.fetzer@bmw-carit.de>

This caches the SDP record of the active session in the Bluetooth
transport.
---
 obexd/client/bluetooth.c | 32 ++++++++++++++++++++++++++------
 1 file changed, 26 insertions(+), 6 deletions(-)

diff --git a/obexd/client/bluetooth.c b/obexd/client/bluetooth.c
index a832a3f..be06ec7 100644
--- a/obexd/client/bluetooth.c
+++ b/obexd/client/bluetooth.c
@@ -52,6 +52,7 @@ struct bluetooth_session {
 	bdaddr_t dst;
 	uint16_t port;
 	sdp_session_t *sdp;
+	sdp_record_t *sdp_record;
 	GIOChannel *io;
 	char *service;
 	obc_transport_func func;
@@ -82,6 +83,9 @@ static void session_destroy(struct bluetooth_session *session)
 	if (session->sdp)
 		sdp_close(session->sdp);
 
+	if (session->sdp_record)
+		sdp_record_free(session->sdp_record);
+
 	g_free(session->service);
 	g_free(session);
 }
@@ -160,7 +164,7 @@ static void search_callback(uint8_t type, uint16_t status,
 		sdp_record_t *rec;
 		sdp_list_t *protos;
 		sdp_data_t *data;
-		int recsize, ch = -1;
+		int recsize, ch = -1, psm = -1;
 
 		recsize = 0;
 		rec = sdp_extract_pdu(rsp, bytesleft, &recsize);
@@ -183,15 +187,31 @@ static void search_callback(uint8_t type, uint16_t status,
 		data = sdp_data_get(rec, 0x0200);
 		/* PSM must be odd and lsb of upper byte must be 0 */
 		if (data != NULL && (data->val.uint16 & 0x0101) == 0x0001)
-			ch = data->val.uint16;
-
-		sdp_record_free(rec);
+			psm = data->val.uint16;
+
+		/* Preferably connect using L2CAP directly instead of RFCOMM.
+		 * If the session has already a port specified, use that to
+		 * connect. */
+		if (session->port == 0) {
+			if (psm > 0)
+				port = psm;
+			else if (ch > 0)
+				port = ch;
+		} else if (session->port > 0 &&
+				(session->port == ch || session->port == psm)) {
+			port = session->port;
+		}
 
-		if (ch > 0) {
-			port = ch;
+		/* Cache the sdp record associated with the service that we
+		 * attempt to connect. This allows reading its application
+		 * specific parameters with get_service_record. */
+		if (port > 0) {
+			session->sdp_record = rec;
 			break;
 		}
 
+		sdp_record_free(rec);
+
 		scanned += recsize;
 		rsp += recsize;
 		bytesleft -= recsize;
-- 
1.8.2.1

