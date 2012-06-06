Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@tieto.com>
To: <linux-bluetooth@vger.kernel.org>
CC: Szymon Janc <szymon.janc@tieto.com>
Subject: [PATCH 05/17] SAP: Introdue SAP_VDBG macro for verbose log messages
Date: Wed, 6 Jun 2012 15:19:15 +0200
Message-ID: <1338988767-19467-5-git-send-email-szymon.janc@tieto.com>
In-Reply-To: <1338988767-19467-1-git-send-email-szymon.janc@tieto.com>
References: <1338988767-19467-1-git-send-email-szymon.janc@tieto.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Some SAP operations (eg. APDU transfer) occurs very often even with
simple scenarios like subscribing to GSM network. This results in flood
of log messages. Since those messages are mostly usefull only when
developing SAP backend hide them after SAP_DEBUG flag.
---
 sap/sap-u8500.c |   18 ++++++------------
 sap/sap.h       |    6 ++++++
 sap/server.c    |    8 ++++----
 3 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/sap/sap-u8500.c b/sap/sap-u8500.c
index 531dce4..f07209d 100644
--- a/sap/sap-u8500.c
+++ b/sap/sap-u8500.c
@@ -38,12 +38,6 @@
 #define STE_SIMD_SOCK  "/dev/socket/catd_a"
 #define STE_CLIENT_TAG 0x0000
 
-#ifdef STE_SAP_DEBUG
-#define DBG_VERBOSE(fmt, arg...) DBG(fmt, arg)
-#else
-#define DBG_VERBOSE(fmt...)
-#endif
-
 #define sap_error(fmt, arg...) do { \
 	error("STE U8500 SAP: " fmt, ## arg); \
 	} while (0)
@@ -264,7 +258,7 @@ static int send_message(GIOChannel *io, void *buf, size_t size)
 {
 	gsize written;
 
-	DBG_VERBOSE("io %p, size %zu", io, size);
+	SAP_VDBG("io %p, size %zu", io, size);
 
 	if (g_io_channel_write_chars(io, buf, size, &written, NULL) !=
 							G_IO_STATUS_NORMAL)
@@ -280,7 +274,7 @@ static int send_request(GIOChannel *io, uint16_t id,
 	struct ste_message *msg;
 	size_t size = sizeof(*msg);
 
-	DBG_VERBOSE("io %p", io);
+	SAP_VDBG("io %p", io);
 
 	if (param)
 		size += param->len;
@@ -417,7 +411,7 @@ static void recv_response(struct ste_message *msg)
 	uint32_t status;
 	uint8_t *param;
 
-	DBG_VERBOSE("msg_id 0x%x", msg->id);
+	SAP_VDBG("msg_id 0x%x", msg->id);
 
 	if (msg->id == STE_END_SAP_RSP) {
 		sap_disconnect_rsp(u8500.sap_data);
@@ -429,7 +423,7 @@ static void recv_response(struct ste_message *msg)
 	status = *(uint32_t *)param;
 	param += sizeof(status);
 
-	DBG_VERBOSE("status 0x%x", status);
+	SAP_VDBG("status 0x%x", status);
 
 	switch (msg->id) {
 	case STE_START_SAP_RSP:
@@ -483,7 +477,7 @@ static int recv_message(void *buf, size_t size)
 	struct ste_message *msg = buf;
 
 	do {
-		DBG_VERBOSE("size %zu msg->len %u.", size, msg->len);
+		SAP_VDBG("size %zu msg->len %u.", size, msg->len);
 
 		if (size < sizeof(*msg)) {
 			sap_error("invalid message received (%zu bytes)", size);
@@ -641,7 +635,7 @@ void sap_transfer_apdu_req(void *sap_device, struct sap_parameter *param)
 {
 	uint8_t result;
 
-	DBG_VERBOSE("sap_device %p param %p", sap_device, param);
+	SAP_VDBG("sap_device %p param %p", sap_device, param);
 
 	if (u8500.state != STE_ENABLED) {
 		result = get_sap_result(STE_SEND_APDU_MSG, STE_STATUS_FAILURE);
diff --git a/sap/sap.h b/sap/sap.h
index a4d084e..5a98bad 100644
--- a/sap/sap.h
+++ b/sap/sap.h
@@ -26,6 +26,12 @@
 #include <stdint.h>
 #include <glib.h>
 
+#ifdef SAP_DEBUG
+#define SAP_VDBG(fmt, arg...) DBG(fmt, arg)
+#else
+#define SAP_VDBG(fmt...)
+#endif
+
 #define SAP_VERSION 0x0101
 
 /* Connection Status - SAP v1.1 section 5.2.2 */
diff --git a/sap/server.c b/sap/server.c
index ec97b39..8612d0d 100644
--- a/sap/server.c
+++ b/sap/server.c
@@ -247,7 +247,7 @@ static int send_message(struct sap_connection *conn, void *buf, size_t size)
 	if (!conn || !buf)
 		return -EINVAL;
 
-	DBG("conn %p, size %zu", conn, size);
+	SAP_VDBG("conn %p, size %zu", conn, size);
 
 	gstatus = g_io_channel_write_chars(conn->io, buf, size, &written,
 									&gerr);
@@ -389,7 +389,7 @@ static int disconnect_req(struct sap_connection *conn, uint8_t disc_type)
 static void transfer_apdu_req(struct sap_connection *conn,
 					struct sap_parameter *param)
 {
-	DBG("conn %p state %d", conn, conn->state);
+	SAP_VDBG("conn %p state %d", conn, conn->state);
 
 	if (!param)
 		goto error_rsp;
@@ -712,7 +712,7 @@ int sap_transfer_apdu_rsp(void *sap_device, uint8_t result, uint8_t *apdu,
 	if (!conn)
 		return -EINVAL;
 
-	DBG("state %d pr 0x%02x", conn->state, conn->processing_req);
+	SAP_VDBG("state %d pr 0x%02x", conn->state, conn->processing_req);
 
 	if (conn->processing_req != SAP_TRANSFER_APDU_REQ)
 		return 0;
@@ -1078,7 +1078,7 @@ static gboolean sap_io_cb(GIOChannel *io, GIOCondition cond, gpointer data)
 	GError *gerr = NULL;
 	GIOStatus gstatus;
 
-	DBG("conn %p io %p", conn, io);
+	SAP_VDBG("conn %p io %p", conn, io);
 
 	if (cond & G_IO_NVAL) {
 		DBG("ERR (G_IO_NVAL) on rfcomm socket.");
-- 
on behalf of ST-Ericsson

