Return-Path: <cyrus@holtmann.org>
From: Christian Fetzer <christian.fetzer@oss.bmw-carit.de>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH v2 1/6] obexd: Cache SDP record in bluetooth transport
Date: Fri, 12 Apr 2013 11:29:01 +0200
Message-Id: <1365758946-8682-2-git-send-email-christian.fetzer@oss.bmw-carit.de>
In-Reply-To: <1365758946-8682-1-git-send-email-christian.fetzer@oss.bmw-carit.de>
References: <1365758946-8682-1-git-send-email-christian.fetzer@oss.bmw-carit.de>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Christian Fetzer <christian.fetzer@bmw-carit.de>

This caches the SDP record of the active session in the Bluetooth
transport.
---
 obexd/client/bluetooth.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/obexd/client/bluetooth.c b/obexd/client/bluetooth.c
index a832a3f..a14b75b 100644
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
@@ -185,13 +189,17 @@ static void search_callback(uint8_t type, uint16_t status,
 		if (data != NULL && (data->val.uint16 & 0x0101) == 0x0001)
 			ch = data->val.uint16;
 
-		sdp_record_free(rec);
-
+		/* Cache the sdp record associated with the service that we
+		 * attempt to connect. This allows reading its application
+		 * specific service attributes. */
 		if (ch > 0) {
 			port = ch;
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

