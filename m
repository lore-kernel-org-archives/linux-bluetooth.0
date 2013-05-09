Return-Path: <cyrus@holtmann.org>
From: Lucas De Marchi <lucas.demarchi@profusion.mobi>
To: linux-bluetooth@vger.kernel.org
Cc: Lucas De Marchi <lucas.demarchi@profusion.mobi>
Subject: [PATCH BlueZ 25/26] unit: Get rid of guint* types
Date: Thu,  9 May 2013 01:16:55 -0300
Message-Id: <1368073016-28434-25-git-send-email-lucas.demarchi@profusion.mobi>
In-Reply-To: <1368073016-28434-1-git-send-email-lucas.demarchi@profusion.mobi>
References: <1368073016-28434-1-git-send-email-lucas.demarchi@profusion.mobi>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

guint -> unsigned int
guint8 -> uint8_t
guint16 -> uint16_t
guint32 -> uint32_t
guint64 -> uint64_t

Add "#include <inttypes.h>" where appropriate and prefer this one
over stdint.h.
---
 unit/test-gdbus-client.c   |   7 +-
 unit/test-gobex-apparam.c  |  20 ++---
 unit/test-gobex-header.c   |  12 +--
 unit/test-gobex-packet.c   |  12 +--
 unit/test-gobex-transfer.c | 180 +++++++++++++++++++++++----------------------
 unit/test-gobex.c          |  44 +++++------
 unit/test-mgmt.c           |   3 +-
 unit/test-sdp.c            |   5 +-
 unit/util.c                |   2 +-
 unit/util.h                |   7 +-
 10 files changed, 151 insertions(+), 141 deletions(-)

diff --git a/unit/test-gdbus-client.c b/unit/test-gdbus-client.c
index a594384..f3c39b7 100644
--- a/unit/test-gdbus-client.c
+++ b/unit/test-gdbus-client.c
@@ -25,6 +25,7 @@
 #include <config.h>
 #endif
 
+#include <inttypes.h>
 #include <glib.h>
 #include <gdbus.h>
 
@@ -36,7 +37,7 @@ struct context {
 	DBusConnection *dbus_conn;
 	GDBusClient *dbus_client;
 	void *data;
-	guint timeout_source;
+	unsigned int timeout_source;
 };
 
 static const GDBusMethodTable methods[] = {
@@ -537,7 +538,7 @@ static void proxy_get_uint64(GDBusProxy *proxy, void *user_data)
 {
 	struct context *context = user_data;
 	DBusMessageIter iter;
-	guint64 value;
+	uint64_t value;
 
 	if (g_test_verbose())
 		g_print("proxy %s found\n",
@@ -555,7 +556,7 @@ static void proxy_get_uint64(GDBusProxy *proxy, void *user_data)
 static gboolean get_uint64(const GDBusPropertyTable *property,
 					DBusMessageIter *iter, void *data)
 {
-	guint64 value = G_MAXUINT64;
+	uint64_t value = G_MAXUINT64;
 
 	dbus_message_iter_append_basic(iter, DBUS_TYPE_UINT64, &value);
 
diff --git a/unit/test-gobex-apparam.c b/unit/test-gobex-apparam.c
index e6a42cc..d2460c3 100644
--- a/unit/test-gobex-apparam.c
+++ b/unit/test-gobex-apparam.c
@@ -24,7 +24,7 @@
 #include "config.h"
 #endif
 
-#include <stdint.h>
+#include <inttypes.h>
 #include <string.h>
 
 #include <gobex/gobex-apparam.h>
@@ -60,7 +60,7 @@ static uint8_t tag_multi[] = { TAG_U8, 0x01, 0x01,
 static GObexApparam *parse_and_decode(const void *data, gsize size)
 {
 	GObexApparam *apparam;
-	guint8 encoded[1024];
+	uint8_t encoded[1024];
 	gsize len;
 
 	apparam = g_obex_apparam_decode(data, size);
@@ -117,7 +117,7 @@ static void test_apparam_nval2_data(void)
 static void test_apparam_get_uint8(void)
 {
 	GObexApparam *apparam;
-	guint8 data;
+	uint8_t data;
 	gboolean ret;
 
 	apparam = parse_and_decode(tag_uint8, sizeof(tag_uint8));
@@ -256,7 +256,7 @@ static void test_apparam_get_multi(void)
 static void test_apparam_set_uint8(void)
 {
 	GObexApparam *apparam;
-	guint8 buf[1024];
+	uint8_t buf[1024];
 	gsize len;
 
 	apparam = g_obex_apparam_set_uint8(NULL, TAG_U8, 0x01);
@@ -271,7 +271,7 @@ static void test_apparam_set_uint8(void)
 static void test_apparam_set_uint16(void)
 {
 	GObexApparam *apparam;
-	guint8 buf[1024];
+	uint8_t buf[1024];
 	gsize len;
 
 	apparam = g_obex_apparam_set_uint16(NULL, TAG_U16, 0x0102);
@@ -286,7 +286,7 @@ static void test_apparam_set_uint16(void)
 static void test_apparam_set_uint32(void)
 {
 	GObexApparam *apparam;
-	guint8 buf[1024];
+	uint8_t buf[1024];
 	gsize len;
 
 	apparam = g_obex_apparam_set_uint32(NULL, TAG_U32, 0x01020304);
@@ -301,7 +301,7 @@ static void test_apparam_set_uint32(void)
 static void test_apparam_set_uint64(void)
 {
 	GObexApparam *apparam;
-	guint8 buf[1024];
+	uint8_t buf[1024];
 	gsize len;
 
 	apparam = g_obex_apparam_set_uint64(NULL, TAG_U64, 0x0102030405060708);
@@ -316,7 +316,7 @@ static void test_apparam_set_uint64(void)
 static void test_apparam_set_string(void)
 {
 	GObexApparam *apparam;
-	guint8 buf[1024];
+	uint8_t buf[1024];
 	gsize len;
 
 	apparam = g_obex_apparam_set_string(NULL, TAG_STRING, "ABC");
@@ -331,7 +331,7 @@ static void test_apparam_set_string(void)
 static void test_apparam_set_bytes(void)
 {
 	GObexApparam *apparam;
-	guint8 buf[1024];
+	uint8_t buf[1024];
 	gsize len;
 
 	apparam = g_obex_apparam_set_bytes(NULL, TAG_BYTES, tag_bytes + 2, 255);
@@ -346,7 +346,7 @@ static void test_apparam_set_bytes(void)
 static void test_apparam_set_multi(void)
 {
 	GObexApparam *apparam;
-	guint8 buf[1024];
+	uint8_t buf[1024];
 	gsize len;
 
 	apparam = g_obex_apparam_set_uint8(NULL, TAG_U8, 0x01);
diff --git a/unit/test-gobex-header.c b/unit/test-gobex-header.c
index 31c49a6..f78a2cc 100644
--- a/unit/test-gobex-header.c
+++ b/unit/test-gobex-header.c
@@ -24,7 +24,7 @@
 #include "config.h"
 #endif
 
-#include <stdint.h>
+#include <inttypes.h>
 #include <string.h>
 
 #include <gobex/gobex-header.h>
@@ -197,7 +197,7 @@ static void test_header_encode_connid(void)
 {
 	GObexHeader *header;
 	gboolean ret;
-	guint32 val;
+	uint32_t val;
 
 	header = parse_and_encode(hdr_connid, sizeof(hdr_connid));
 
@@ -260,8 +260,8 @@ static void test_header_encode_name_empty(void)
 static void test_header_encode_body(void)
 {
 	GObexHeader *header;
-	guint8 expected[] = { 1, 2, 3, 4};
-	const guint8 *buf;
+	uint8_t expected[] = { 1, 2, 3, 4};
+	const uint8_t *buf;
 	size_t len;
 	gboolean ret;
 
@@ -280,7 +280,7 @@ static void test_header_encode_apparam(void)
 	GObexHeader *header;
 	GObexApparam *apparam;
 	gboolean ret;
-	guint32 data;
+	uint32_t data;
 
 	header = parse_and_encode(hdr_apparam, sizeof(hdr_apparam));
 
@@ -299,7 +299,7 @@ static void test_header_encode_actionid(void)
 {
 	GObexHeader *header;
 	gboolean ret;
-	guint8 val;
+	uint8_t val;
 
 	header = parse_and_encode(hdr_actionid, sizeof(hdr_actionid));
 
diff --git a/unit/test-gobex-packet.c b/unit/test-gobex-packet.c
index bf2035b..6bd3f62 100644
--- a/unit/test-gobex-packet.c
+++ b/unit/test-gobex-packet.c
@@ -24,7 +24,7 @@
 #include "config.h"
 #endif
 
-#include <stdint.h>
+#include <inttypes.h>
 #include <string.h>
 #include <errno.h>
 
@@ -45,7 +45,7 @@ static uint8_t pkt_put[] = { G_OBEX_OP_PUT, 0x00, 0x03 };
 
 static uint8_t pkt_nval_len[] = { G_OBEX_OP_PUT, 0xab, 0xcd, 0x12 };
 
-static guint8 pkt_put_long[] = { G_OBEX_OP_PUT, 0x00, 0x32,
+static uint8_t pkt_put_long[] = { G_OBEX_OP_PUT, 0x00, 0x32,
 	G_OBEX_HDR_CONNECTION, 0x01, 0x02, 0x03, 0x04,
 	G_OBEX_HDR_TYPE, 0x00, 0x0b,
 	'f', 'o', 'o', '/', 'b', 'a', 'r', '\0',
@@ -84,7 +84,7 @@ static void test_decode_pkt_header(void)
 	GObexHeader *header;
 	GError *err = NULL;
 	gboolean ret;
-	guint8 val;
+	uint8_t val;
 
 	pkt = g_obex_packet_decode(pkt_put_action, sizeof(pkt_put_action),
 						0, G_OBEX_DATA_REF, &err);
@@ -106,8 +106,8 @@ static void test_decode_connect(void)
 	GObexHeader *header;
 	GError *err = NULL;
 	gboolean ret;
-	const guint8 *buf;
-	guint8 target[] = { 0xab, 0xcd };
+	const uint8_t *buf;
+	uint8_t target[] = { 0xab, 0xcd };
 	gsize len;
 
 	pkt = g_obex_packet_decode(pkt_connect, sizeof(pkt_connect),
@@ -213,7 +213,7 @@ static void test_encode_on_demand_fail(void)
 static void test_create_args(void)
 {
 	GObexPacket *pkt;
-	guint8 buf[255], body[] = { 0x00, 0x01, 0x02, 0x03, 0x04 };
+	uint8_t buf[255], body[] = { 0x00, 0x01, 0x02, 0x03, 0x04 };
 	gssize len;
 
 	pkt = g_obex_packet_new(G_OBEX_OP_PUT, FALSE,
diff --git a/unit/test-gobex-transfer.c b/unit/test-gobex-transfer.c
index ef05047..693c70b 100644
--- a/unit/test-gobex-transfer.c
+++ b/unit/test-gobex-transfer.c
@@ -31,7 +31,7 @@
 #include <errno.h>
 #include <unistd.h>
 #include <string.h>
-#include <stdint.h>
+#include <inttypes.h>
 #include <fcntl.h>
 
 #include <gobex/gobex.h>
@@ -41,7 +41,7 @@
 #define FINAL_BIT 0x80
 #define RANDOM_PACKETS 4
 
-static guint8 put_req_first[] = { G_OBEX_OP_PUT, 0x00, 0x30,
+static uint8_t put_req_first[] = { G_OBEX_OP_PUT, 0x00, 0x30,
 	G_OBEX_HDR_TYPE, 0x00, 0x0b,
 	'f', 'o', 'o', '/', 'b', 'a', 'r', '\0',
 	G_OBEX_HDR_NAME, 0x00, 0x15,
@@ -49,7 +49,7 @@ static guint8 put_req_first[] = { G_OBEX_OP_PUT, 0x00, 0x30,
 	G_OBEX_HDR_BODY, 0x00, 0x0d,
 	0, 1, 2, 3, 4, 5, 6, 7, 8, 9 };
 
-static guint8 put_req_first_srm[] = { G_OBEX_OP_PUT, 0x00, 0x32,
+static uint8_t put_req_first_srm[] = { G_OBEX_OP_PUT, 0x00, 0x32,
 	G_OBEX_HDR_TYPE, 0x00, 0x0b,
 	'f', 'o', 'o', '/', 'b', 'a', 'r', '\0',
 	G_OBEX_HDR_NAME, 0x00, 0x15,
@@ -58,32 +58,32 @@ static guint8 put_req_first_srm[] = { G_OBEX_OP_PUT, 0x00, 0x32,
 	G_OBEX_HDR_BODY, 0x00, 0x0d,
 	0, 1, 2, 3, 4, 5, 6, 7, 8, 9 };
 
-static guint8 put_req_zero[255] = { G_OBEX_OP_PUT, 0x00, 0xff,
+static uint8_t put_req_zero[255] = { G_OBEX_OP_PUT, 0x00, 0xff,
 	G_OBEX_HDR_BODY, 0x00, 0xfc };
 
-static guint8 put_req_last[] = { G_OBEX_OP_PUT | FINAL_BIT, 0x00, 0x06,
+static uint8_t put_req_last[] = { G_OBEX_OP_PUT | FINAL_BIT, 0x00, 0x06,
 					G_OBEX_HDR_BODY_END, 0x00, 0x03 };
 
-static guint8 abort_req[] = { G_OBEX_OP_ABORT | FINAL_BIT, 0x00, 0x03 };
+static uint8_t abort_req[] = { G_OBEX_OP_ABORT | FINAL_BIT, 0x00, 0x03 };
 
-static guint8 put_rsp_first[] = { G_OBEX_RSP_CONTINUE | FINAL_BIT,
+static uint8_t put_rsp_first[] = { G_OBEX_RSP_CONTINUE | FINAL_BIT,
 								0x00, 0x03 };
-static guint8 put_rsp_first_srm[] = { G_OBEX_RSP_CONTINUE | FINAL_BIT,
+static uint8_t put_rsp_first_srm[] = { G_OBEX_RSP_CONTINUE | FINAL_BIT,
 							0x00, 0x05,
 							G_OBEX_HDR_SRM, 0x01 };
-static guint8 put_rsp_first_srm_wait[] = { G_OBEX_RSP_CONTINUE | FINAL_BIT,
+static uint8_t put_rsp_first_srm_wait[] = { G_OBEX_RSP_CONTINUE | FINAL_BIT,
 							0x00, 0x07,
 							G_OBEX_HDR_SRM, 0x01,
 							G_OBEX_HDR_SRMP, 0x01 };
-static guint8 put_rsp_last[] = { G_OBEX_RSP_SUCCESS | FINAL_BIT, 0x00, 0x03 };
+static uint8_t put_rsp_last[] = { G_OBEX_RSP_SUCCESS | FINAL_BIT, 0x00, 0x03 };
 
-static guint8 get_req_first[] = { G_OBEX_OP_GET | FINAL_BIT, 0x00, 0x23,
+static uint8_t get_req_first[] = { G_OBEX_OP_GET | FINAL_BIT, 0x00, 0x23,
 	G_OBEX_HDR_TYPE, 0x00, 0x0b,
 	'f', 'o', 'o', '/', 'b', 'a', 'r', '\0',
 	G_OBEX_HDR_NAME, 0x00, 0x15,
 	0, 'f', 0, 'i', 0, 'l', 0, 'e', 0, '.', 0, 't', 0, 'x', 0, 't', 0, 0 };
 
-static guint8 get_req_first_app[] = { G_OBEX_OP_GET | FINAL_BIT, 0x00, 0x2a,
+static uint8_t get_req_first_app[] = { G_OBEX_OP_GET | FINAL_BIT, 0x00, 0x2a,
 	G_OBEX_HDR_TYPE, 0x00, 0x0b,
 	'f', 'o', 'o', '/', 'b', 'a', 'r', '\0',
 	G_OBEX_HDR_NAME, 0x00, 0x15,
@@ -91,14 +91,15 @@ static guint8 get_req_first_app[] = { G_OBEX_OP_GET | FINAL_BIT, 0x00, 0x2a,
 	G_OBEX_HDR_APPARAM, 0x00, 0x07,
 	0, 1, 2, 3  };
 
-static guint8 get_req_first_srm[] = { G_OBEX_OP_GET | FINAL_BIT, 0x00, 0x25,
+static uint8_t get_req_first_srm[] = { G_OBEX_OP_GET | FINAL_BIT, 0x00, 0x25,
 	G_OBEX_HDR_SRM, 0x01,
 	G_OBEX_HDR_TYPE, 0x00, 0x0b,
 	'f', 'o', 'o', '/', 'b', 'a', 'r', '\0',
 	G_OBEX_HDR_NAME, 0x00, 0x15,
 	0, 'f', 0, 'i', 0, 'l', 0, 'e', 0, '.', 0, 't', 0, 'x', 0, 't', 0, 0 };
 
-static guint8 get_req_first_srm_wait[] = { G_OBEX_OP_GET | FINAL_BIT, 0x00, 0x27,
+static uint8_t get_req_first_srm_wait[] = { G_OBEX_OP_GET | FINAL_BIT,
+	0x00, 0x27,
 	G_OBEX_HDR_SRM, 0x01,
 	G_OBEX_HDR_TYPE, 0x00, 0x0b,
 	'f', 'o', 'o', '/', 'b', 'a', 'r', '\0',
@@ -106,67 +107,72 @@ static guint8 get_req_first_srm_wait[] = { G_OBEX_OP_GET | FINAL_BIT, 0x00, 0x27
 	0, 'f', 0, 'i', 0, 'l', 0, 'e', 0, '.', 0, 't', 0, 'x', 0, 't', 0, 0,
 	G_OBEX_HDR_SRMP, 0x01 };
 
-static guint8 get_req_last[] = { G_OBEX_OP_GET | FINAL_BIT, 0x00, 0x03, };
+static uint8_t get_req_last[] = { G_OBEX_OP_GET | FINAL_BIT, 0x00, 0x03, };
 
-static guint8 get_rsp_first_app[] = { G_OBEX_RSP_CONTINUE | FINAL_BIT, 0x00, 0x0A,
+static uint8_t get_rsp_first_app[] = { G_OBEX_RSP_CONTINUE | FINAL_BIT,
+					0x00, 0x0A,
 					G_OBEX_HDR_APPARAM, 0x00, 0x07,
 					0, 1, 2, 3 };
-static guint8 get_rsp_first[] = { G_OBEX_RSP_CONTINUE | FINAL_BIT, 0x00, 0x10,
+static uint8_t get_rsp_first[] = { G_OBEX_RSP_CONTINUE | FINAL_BIT,
+					0x00, 0x10,
 					G_OBEX_HDR_BODY, 0x00, 0x0d,
 					0, 1, 2, 3, 4, 5, 6, 7, 8, 9 };
-static guint8 get_rsp_first_srm[] = { G_OBEX_RSP_CONTINUE | FINAL_BIT, 0x00, 0x12,
+static uint8_t get_rsp_first_srm[] = { G_OBEX_RSP_CONTINUE | FINAL_BIT,
+					0x00, 0x12,
 					G_OBEX_HDR_SRM, 0x01,
 					G_OBEX_HDR_BODY, 0x00, 0x0d,
 					0, 1, 2, 3, 4, 5, 6, 7, 8, 9 };
-static guint8 get_rsp_first_srm_wait_next[] = { G_OBEX_RSP_CONTINUE | FINAL_BIT,
+static uint8_t get_rsp_first_srm_wait_next[] = {
+					G_OBEX_RSP_CONTINUE | FINAL_BIT,
 					0x00, 0x14,
 					G_OBEX_HDR_SRM, 0x01,
 					G_OBEX_HDR_SRMP, 0x02,
 					G_OBEX_HDR_BODY, 0x00, 0x0d,
 					0, 1, 2, 3, 4, 5, 6, 7, 8, 9 };
-static guint8 get_rsp_zero[255] = { G_OBEX_RSP_CONTINUE | FINAL_BIT, 0x00, 0xff,
+static uint8_t get_rsp_zero[255] = { G_OBEX_RSP_CONTINUE | FINAL_BIT,
+					0x00, 0xff,
 					G_OBEX_HDR_BODY, 0x00, 0xfc };
-static guint8 get_rsp_zero_wait_next[255] = { G_OBEX_RSP_CONTINUE | FINAL_BIT,
+static uint8_t get_rsp_zero_wait_next[255] = { G_OBEX_RSP_CONTINUE | FINAL_BIT,
 					0x00, 0xff,
 					G_OBEX_HDR_SRMP, 0x02,
 					G_OBEX_HDR_BODY, 0x00, 0xfa };
-static guint8 get_rsp_last[] = { G_OBEX_RSP_SUCCESS | FINAL_BIT, 0x00, 0x06,
+static uint8_t get_rsp_last[] = { G_OBEX_RSP_SUCCESS | FINAL_BIT, 0x00, 0x06,
 					G_OBEX_HDR_BODY_END, 0x00, 0x03 };
 
-static guint8 conn_req[] = { G_OBEX_OP_CONNECT | FINAL_BIT, 0x00, 0x07,
+static uint8_t conn_req[] = { G_OBEX_OP_CONNECT | FINAL_BIT, 0x00, 0x07,
 					0x10, 0x00, 0x10, 0x00 };
-static guint8 conn_rsp[] = { G_OBEX_RSP_SUCCESS | FINAL_BIT, 0x00, 0x0c,
+static uint8_t conn_rsp[] = { G_OBEX_RSP_SUCCESS | FINAL_BIT, 0x00, 0x0c,
 					0x10, 0x00, 0x10, 0x00,
 					G_OBEX_HDR_CONNECTION, 0x00, 0x00,
 					0x00, 0x01 };
 
-static guint8 conn_req_srm[] = { G_OBEX_OP_CONNECT | FINAL_BIT, 0x00, 0x09,
+static uint8_t conn_req_srm[] = { G_OBEX_OP_CONNECT | FINAL_BIT, 0x00, 0x09,
 					0x10, 0x00, 0x10, 0x00,
 					G_OBEX_HDR_SRM, 0x02 };
-static guint8 conn_rsp_srm[] = { G_OBEX_RSP_SUCCESS | FINAL_BIT, 0x00, 0x0e,
+static uint8_t conn_rsp_srm[] = { G_OBEX_RSP_SUCCESS | FINAL_BIT, 0x00, 0x0e,
 					0x10, 0x00, 0x10, 0x00,
 					G_OBEX_HDR_CONNECTION, 0x00, 0x00,
 					0x00, 0x01,
 					G_OBEX_HDR_SRM, 0x01 };
 
-static guint8 unavailable_rsp[] = { G_OBEX_RSP_SERVICE_UNAVAILABLE | FINAL_BIT,
+static uint8_t unavailable_rsp[] = { G_OBEX_RSP_SERVICE_UNAVAILABLE | FINAL_BIT,
 					0x00, 0x03 };
 
-static guint8 conn_get_req_first[] = { G_OBEX_OP_GET | FINAL_BIT, 0x00, 0x28,
+static uint8_t conn_get_req_first[] = { G_OBEX_OP_GET | FINAL_BIT, 0x00, 0x28,
 	G_OBEX_HDR_CONNECTION, 0x00, 0x00, 0x00, 0x01,
 	G_OBEX_HDR_TYPE, 0x00, 0x0b,
 	'f', 'o', 'o', '/', 'b', 'a', 'r', '\0',
 	G_OBEX_HDR_NAME, 0x00, 0x15,
 	0, 'f', 0, 'i', 0, 'l', 0, 'e', 0, '.', 0, 't', 0, 'x', 0, 't', 0, 0 };
 
-static guint8 conn_get_req_wrg[] = { G_OBEX_OP_GET | FINAL_BIT, 0x00, 0x28,
+static uint8_t conn_get_req_wrg[] = { G_OBEX_OP_GET | FINAL_BIT, 0x00, 0x28,
 	G_OBEX_HDR_CONNECTION, 0x00, 0x00, 0x00, 0xFF,
 	G_OBEX_HDR_TYPE, 0x00, 0x0b,
 	'f', 'o', 'o', '/', 'b', 'a', 'r', '\0',
 	G_OBEX_HDR_NAME, 0x00, 0x15,
 	0, 'f', 0, 'i', 0, 'l', 0, 'e', 0, '.', 0, 't', 0, 'x', 0, 't', 0, 0 };
 
-static guint8 conn_put_req_first[] = { G_OBEX_OP_PUT, 0x00, 0x35,
+static uint8_t conn_put_req_first[] = { G_OBEX_OP_PUT, 0x00, 0x35,
 	G_OBEX_HDR_CONNECTION, 0x00, 0x00, 0x00, 0x01,
 	G_OBEX_HDR_TYPE, 0x00, 0x0b,
 	'f', 'o', 'o', '/', 'b', 'a', 'r', '\0',
@@ -175,9 +181,9 @@ static guint8 conn_put_req_first[] = { G_OBEX_OP_PUT, 0x00, 0x35,
 	G_OBEX_HDR_BODY, 0x00, 0x0d,
 	0, 1, 2, 3, 4, 5, 6, 7, 8, 9 };
 
-static guint8 hdr_type[] = "foo/bar";
-static guint8 hdr_app[] = { 0, 1, 2, 3 };
-static guint8 body_data[] = { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9 };
+static uint8_t hdr_type[] = "foo/bar";
+static uint8_t hdr_app[] = { 0, 1, 2, 3 };
+static uint8_t body_data[] = { 0, 1, 2, 3, 4, 5, 6, 7, 8, 9 };
 
 static void transfer_complete(GObex *obex, GError *err, gpointer user_data)
 {
@@ -272,7 +278,7 @@ static void test_put_req(void)
 {
 	GIOChannel *io;
 	GIOCondition cond;
-	guint io_id, timer_id;
+	unsigned int io_id, timer_id;
 	GObex *obex;
 	struct test_data d = { 0, NULL, {
 				{ put_req_first, sizeof(put_req_first) },
@@ -329,8 +335,8 @@ static gboolean rcv_data(const void *buf, gsize len, gpointer user_data)
 static void handle_put(GObex *obex, GObexPacket *req, gpointer user_data)
 {
 	struct test_data *d = user_data;
-	guint8 op = g_obex_packet_get_operation(req, NULL);
-	guint id;
+	uint8_t op = g_obex_packet_get_operation(req, NULL);
+	unsigned int id;
 
 	if (op != G_OBEX_OP_PUT) {
 		d->err = g_error_new(TEST_ERROR, TEST_ERROR_UNEXPECTED,
@@ -349,7 +355,7 @@ static void test_put_rsp(void)
 {
 	GIOChannel *io;
 	GIOCondition cond;
-	guint io_id, timer_id;
+	unsigned int io_id, timer_id;
 	GObex *obex;
 	struct test_data d = { 0, NULL, {
 				{ put_rsp_first, sizeof(put_rsp_first) },
@@ -395,8 +401,8 @@ static void handle_put_seq(GObex *obex, GObexPacket *req,
 							gpointer user_data)
 {
 	struct test_data *d = user_data;
-	guint8 op = g_obex_packet_get_operation(req, NULL);
-	guint id;
+	uint8_t op = g_obex_packet_get_operation(req, NULL);
+	unsigned int id;
 
 	if (op != G_OBEX_OP_PUT) {
 		d->err = g_error_new(TEST_ERROR, TEST_ERROR_UNEXPECTED,
@@ -415,7 +421,7 @@ static void test_stream_put_rsp(void)
 {
 	GIOChannel *io;
 	GIOCondition cond;
-	guint io_id, timer_id;
+	unsigned int io_id, timer_id;
 	GObex *obex;
 	struct test_data d = { 0, NULL, {
 				{ put_rsp_first, sizeof(put_rsp_first) },
@@ -477,7 +483,7 @@ static void test_stream_put_req_abort(void)
 {
 	GIOChannel *io;
 	GIOCondition cond;
-	guint io_id, timer_id;
+	unsigned int io_id, timer_id;
 	GObex *obex;
 	struct test_data d = { 0, NULL, {
 				{ put_req_first, sizeof(put_req_first) },
@@ -517,7 +523,7 @@ static void test_stream_put_rsp_abort(void)
 {
 	GIOChannel *io;
 	GIOCondition cond;
-	guint io_id, timer_id;
+	unsigned int io_id, timer_id;
 	GObex *obex;
 	struct test_data d = { 0, NULL, {
 				{ put_rsp_first, sizeof(put_rsp_first) },
@@ -562,8 +568,8 @@ static void handle_put_seq_wait(GObex *obex, GObexPacket *req,
 							gpointer user_data)
 {
 	struct test_data *d = user_data;
-	guint8 op = g_obex_packet_get_operation(req, NULL);
-	guint id;
+	uint8_t op = g_obex_packet_get_operation(req, NULL);
+	unsigned int id;
 
 	if (op != G_OBEX_OP_PUT) {
 		d->err = g_error_new(TEST_ERROR, TEST_ERROR_UNEXPECTED,
@@ -584,7 +590,7 @@ static void test_packet_put_rsp_wait(void)
 {
 	GIOChannel *io;
 	GIOCondition cond;
-	guint io_id, timer_id;
+	unsigned int io_id, timer_id;
 	GObex *obex;
 	struct test_data d = { 0, NULL, {
 		{ put_rsp_first_srm_wait, sizeof(put_rsp_first_srm_wait) },
@@ -631,7 +637,7 @@ static void test_packet_put_rsp(void)
 {
 	GIOChannel *io;
 	GIOCondition cond;
-	guint io_id, timer_id;
+	unsigned int io_id, timer_id;
 	GObex *obex;
 	struct test_data d = { 0, NULL, {
 			{ put_rsp_first_srm, sizeof(put_rsp_first_srm) },
@@ -677,7 +683,7 @@ static void test_get_req(void)
 {
 	GIOChannel *io;
 	GIOCondition cond;
-	guint io_id, timer_id;
+	unsigned int io_id, timer_id;
 	GObex *obex;
 	struct test_data d = { 0, NULL, {
 				{ get_req_first, sizeof(get_req_first) },
@@ -718,7 +724,7 @@ static void test_stream_get_req(void)
 {
 	GIOChannel *io;
 	GIOCondition cond;
-	guint io_id, timer_id;
+	unsigned int io_id, timer_id;
 	GObex *obex;
 	struct test_data d = { 0, NULL, {
 				{ get_req_first, sizeof(get_req_first) },
@@ -763,7 +769,7 @@ static void test_packet_get_req(void)
 {
 	GIOChannel *io;
 	GIOCondition cond;
-	guint io_id, timer_id;
+	unsigned int io_id, timer_id;
 	GObex *obex;
 	struct test_data d = { 0, NULL, {
 			{ get_req_first_srm, sizeof(get_req_first_srm) },
@@ -808,7 +814,7 @@ static void test_packet_get_req_wait(void)
 {
 	GIOChannel *io;
 	GIOCondition cond;
-	guint io_id, timer_id;
+	unsigned int io_id, timer_id;
 	GObex *obex;
 	struct test_data d = { 0, NULL, {
 		{ get_req_first_srm_wait, sizeof(get_req_first_srm_wait) },
@@ -854,7 +860,7 @@ static void test_packet_get_req_wait_next(void)
 {
 	GIOChannel *io;
 	GIOCondition cond;
-	guint io_id, timer_id;
+	unsigned int io_id, timer_id;
 	GObex *obex;
 	struct test_data d = { 0, NULL, {
 		{ get_req_first_srm, sizeof(get_req_first_srm) },
@@ -900,7 +906,7 @@ static void test_get_req_app(void)
 {
 	GIOChannel *io;
 	GIOCondition cond;
-	guint io_id, timer_id;
+	unsigned int io_id, timer_id;
 	GObex *obex;
 	struct test_data d = { 0, NULL, {
 			{ get_req_first_app, sizeof(get_req_first_app) },
@@ -944,8 +950,8 @@ static void handle_get_eagain(GObex *obex, GObexPacket *req,
 						gpointer user_data)
 {
 	struct test_data *d = user_data;
-	guint8 op = g_obex_packet_get_operation(req, NULL);
-	guint id;
+	uint8_t op = g_obex_packet_get_operation(req, NULL);
+	unsigned int id;
 
 	if (op != G_OBEX_OP_GET) {
 		d->err = g_error_new(TEST_ERROR, TEST_ERROR_UNEXPECTED,
@@ -963,8 +969,8 @@ static void handle_get_eagain(GObex *obex, GObexPacket *req,
 static void handle_get(GObex *obex, GObexPacket *req, gpointer user_data)
 {
 	struct test_data *d = user_data;
-	guint8 op = g_obex_packet_get_operation(req, NULL);
-	guint id;
+	uint8_t op = g_obex_packet_get_operation(req, NULL);
+	unsigned int id;
 
 	if (op != G_OBEX_OP_GET) {
 		d->err = g_error_new(TEST_ERROR, TEST_ERROR_UNEXPECTED,
@@ -983,7 +989,7 @@ static void test_stream_put_req(void)
 {
 	GIOChannel *io;
 	GIOCondition cond;
-	guint io_id, timer_id;
+	unsigned int io_id, timer_id;
 	GObex *obex;
 	struct test_data d = { 0, NULL, {
 				{ NULL, 0 },
@@ -1029,7 +1035,7 @@ static void test_packet_put_req_wait(void)
 {
 	GIOChannel *io;
 	GIOCondition cond;
-	guint io_id, timer_id;
+	unsigned int io_id, timer_id;
 	GObex *obex;
 	struct test_data d = { 0, NULL, {
 		{ NULL, 0 },
@@ -1075,7 +1081,7 @@ static void test_packet_put_req(void)
 {
 	GIOChannel *io;
 	GIOCondition cond;
-	guint io_id, timer_id;
+	unsigned int io_id, timer_id;
 	GObex *obex;
 	struct test_data d = { 0, NULL, {
 			{ NULL, 0 },
@@ -1121,7 +1127,7 @@ static void test_put_req_eagain(void)
 {
 	GIOChannel *io;
 	GIOCondition cond;
-	guint io_id, timer_id;
+	unsigned int io_id, timer_id;
 	GObex *obex;
 	struct test_data d = { 0, NULL, {
 				{ put_req_first, sizeof(put_req_first) },
@@ -1164,7 +1170,7 @@ static void test_get_rsp(void)
 {
 	GIOChannel *io;
 	GIOCondition cond;
-	guint io_id, timer_id;
+	unsigned int io_id, timer_id;
 	GObex *obex;
 	struct test_data d = { 0, NULL, {
 				{ get_rsp_first, sizeof(get_rsp_first) },
@@ -1205,8 +1211,8 @@ static void handle_get_seq(GObex *obex, GObexPacket *req,
 							gpointer user_data)
 {
 	struct test_data *d = user_data;
-	guint8 op = g_obex_packet_get_operation(req, NULL);
-	guint id;
+	uint8_t op = g_obex_packet_get_operation(req, NULL);
+	unsigned int id;
 
 	if (op != G_OBEX_OP_GET) {
 		d->err = g_error_new(TEST_ERROR, TEST_ERROR_UNEXPECTED,
@@ -1225,7 +1231,7 @@ static void test_stream_get_rsp(void)
 {
 	GIOChannel *io;
 	GIOCondition cond;
-	guint io_id, timer_id;
+	unsigned int io_id, timer_id;
 	GObex *obex;
 	struct test_data d = { 0, NULL, {
 				{ NULL, 0 },
@@ -1269,7 +1275,7 @@ static void test_packet_get_rsp(void)
 {
 	GIOChannel *io;
 	GIOCondition cond;
-	guint io_id, timer_id;
+	unsigned int io_id, timer_id;
 	GObex *obex;
 	struct test_data d = { 0, NULL, {
 				{ NULL, 0 },
@@ -1314,8 +1320,8 @@ static void handle_get_seq_srm_wait(GObex *obex, GObexPacket *req,
 							gpointer user_data)
 {
 	struct test_data *d = user_data;
-	guint8 op = g_obex_packet_get_operation(req, NULL);
-	guint id;
+	uint8_t op = g_obex_packet_get_operation(req, NULL);
+	unsigned int id;
 
 	if (op != G_OBEX_OP_GET) {
 		d->err = g_error_new(TEST_ERROR, TEST_ERROR_UNEXPECTED,
@@ -1336,7 +1342,7 @@ static void test_packet_get_rsp_wait(void)
 {
 	GIOChannel *io;
 	GIOCondition cond;
-	guint io_id, timer_id;
+	unsigned int io_id, timer_id;
 	GObex *obex;
 	struct test_data d = { 0, NULL, {
 				{ NULL, 0 },
@@ -1381,7 +1387,7 @@ static void test_packet_get_rsp_wait(void)
 static void handle_get_app(GObex *obex, GObexPacket *req, gpointer user_data)
 {
 	struct test_data *d = user_data;
-	guint8 op = g_obex_packet_get_operation(req, NULL);
+	uint8_t op = g_obex_packet_get_operation(req, NULL);
 	GObexPacket *rsp;
 
 	if (op != G_OBEX_OP_GET) {
@@ -1405,7 +1411,7 @@ static void test_get_rsp_app(void)
 {
 	GIOChannel *io;
 	GIOCondition cond;
-	guint io_id, timer_id;
+	unsigned int io_id, timer_id;
 	GObex *obex;
 	struct test_data d = { 0, NULL, {
 			{ get_rsp_first_app, sizeof(get_rsp_first_app) },
@@ -1449,7 +1455,7 @@ static void test_put_req_delay(void)
 {
 	GIOChannel *io;
 	GIOCondition cond;
-	guint io_id, timer_id;
+	unsigned int io_id, timer_id;
 	GObex *obex;
 	struct test_data d = { 0, NULL, {
 				{ put_req_first, sizeof(put_req_first) },
@@ -1492,7 +1498,7 @@ static void test_get_rsp_delay(void)
 {
 	GIOChannel *io;
 	GIOCondition cond;
-	guint io_id, timer_id;
+	unsigned int io_id, timer_id;
 	GObex *obex;
 	struct test_data d = { 0, NULL, {
 				{ get_rsp_first, sizeof(get_rsp_first) },
@@ -1556,8 +1562,8 @@ static gboolean rcv_data_delay(const void *buf, gsize len, gpointer user_data)
 static void handle_put_delay(GObex *obex, GObexPacket *req, gpointer user_data)
 {
 	struct test_data *d = user_data;
-	guint8 op = g_obex_packet_get_operation(req, NULL);
-	guint id;
+	uint8_t op = g_obex_packet_get_operation(req, NULL);
+	unsigned int id;
 
 	if (op != G_OBEX_OP_PUT) {
 		d->err = g_error_new(TEST_ERROR, TEST_ERROR_UNEXPECTED,
@@ -1576,7 +1582,7 @@ static void test_put_rsp_delay(void)
 {
 	GIOChannel *io;
 	GIOCondition cond;
-	guint io_id, timer_id;
+	unsigned int io_id, timer_id;
 	GObex *obex;
 	struct test_data d = { 0, NULL, {
 				{ put_rsp_first, sizeof(put_rsp_first) },
@@ -1619,7 +1625,7 @@ static void test_get_req_delay(void)
 {
 	GIOChannel *io;
 	GIOCondition cond;
-	guint io_id, timer_id;
+	unsigned int io_id, timer_id;
 	GObex *obex;
 	struct test_data d = { 0, NULL, {
 				{ get_req_first, sizeof(get_req_first) },
@@ -1662,7 +1668,7 @@ static void test_get_rsp_eagain(void)
 {
 	GIOChannel *io;
 	GIOCondition cond;
-	guint io_id, timer_id;
+	unsigned int io_id, timer_id;
 	GObex *obex;
 	struct test_data d = { 0, NULL, {
 				{ get_rsp_first, sizeof(get_rsp_first) },
@@ -1717,7 +1723,7 @@ static void test_conn_req(void)
 {
 	GIOChannel *io;
 	GIOCondition cond;
-	guint io_id, timer_id;
+	unsigned int io_id, timer_id;
 	GObex *obex;
 	struct test_data d = { 0, NULL, {
 				{ conn_req, sizeof(conn_req) } }, {
@@ -1754,7 +1760,7 @@ static void handle_conn_rsp(GObex *obex, GObexPacket *req,
 						gpointer user_data)
 {
 	struct test_data *d = user_data;
-	guint8 op = g_obex_packet_get_operation(req, NULL);
+	uint8_t op = g_obex_packet_get_operation(req, NULL);
 	GObexPacket *rsp;
 
 	if (op != G_OBEX_OP_CONNECT) {
@@ -1774,7 +1780,7 @@ static void test_conn_rsp(void)
 {
 	GIOChannel *io;
 	GIOCondition cond;
-	guint io_id, timer_id;
+	unsigned int io_id, timer_id;
 	GObex *obex;
 	struct test_data d = { 0, NULL, {
 			{ conn_rsp, sizeof(conn_rsp) } }, {
@@ -1831,7 +1837,7 @@ static void test_conn_get_req(void)
 {
 	GIOChannel *io;
 	GIOCondition cond;
-	guint io_id, timer_id;
+	unsigned int io_id, timer_id;
 	GObex *obex;
 	struct test_data d = { 0, NULL, {
 			{ conn_req, sizeof(conn_req) },
@@ -1873,7 +1879,7 @@ static void test_conn_get_rsp(void)
 {
 	GIOChannel *io;
 	GIOCondition cond;
-	guint io_id, timer_id;
+	unsigned int io_id, timer_id;
 	GObex *obex;
 	struct test_data d = { 0, NULL, {
 			{ conn_rsp, sizeof(conn_rsp) },
@@ -1937,7 +1943,7 @@ static void test_conn_put_req(void)
 {
 	GIOChannel *io;
 	GIOCondition cond;
-	guint io_id, timer_id;
+	unsigned int io_id, timer_id;
 	GObex *obex;
 	struct test_data d = { 0, NULL, {
 			{ conn_req, sizeof(conn_req) },
@@ -1979,7 +1985,7 @@ static void test_conn_put_rsp(void)
 {
 	GIOChannel *io;
 	GIOCondition cond;
-	guint io_id, timer_id;
+	unsigned int io_id, timer_id;
 	GObex *obex;
 	struct test_data d = { 0, NULL, {
 			{ conn_rsp, sizeof(conn_rsp) },
@@ -2027,7 +2033,7 @@ static void test_conn_get_wrg_rsp(void)
 {
 	GIOChannel *io;
 	GIOCondition cond;
-	guint io_id, timer_id;
+	unsigned int io_id, timer_id;
 	GObex *obex;
 	struct test_data d = { 0, NULL, {
 			{ conn_rsp, sizeof(conn_rsp) },
@@ -2086,7 +2092,7 @@ static void test_conn_put_req_seq(void)
 {
 	GIOChannel *io;
 	GIOCondition cond;
-	guint io_id, timer_id;
+	unsigned int io_id, timer_id;
 	GObex *obex;
 	struct test_data d = { 0, NULL, {
 				{ conn_req, sizeof(conn_req) } ,
@@ -2146,7 +2152,7 @@ static void test_conn_put_req_seq_srm(void)
 {
 	GIOChannel *io;
 	GIOCondition cond;
-	guint io_id, timer_id;
+	unsigned int io_id, timer_id;
 	GObex *obex;
 	struct test_data d = { 0, NULL, {
 				{ conn_req_srm, sizeof(conn_req_srm) } ,
diff --git a/unit/test-gobex.c b/unit/test-gobex.c
index 66307c2..b1bd21b 100644
--- a/unit/test-gobex.c
+++ b/unit/test-gobex.c
@@ -24,13 +24,13 @@
 #include "config.h"
 #endif
 
+#include <inttypes.h>
 #include <stdlib.h>
 #include <sys/types.h>
 #include <sys/socket.h>
 #include <errno.h>
 #include <unistd.h>
 #include <string.h>
-#include <stdint.h>
 
 #include <gobex/gobex.h>
 
@@ -104,7 +104,7 @@ static gboolean timeout(gpointer user_data)
 static void connect_rsp(GObex *obex, GError *err, GObexPacket *rsp,
 							gpointer user_data)
 {
-	guint8 rsp_code;
+	uint8_t rsp_code;
 	gboolean final;
 	GError **test_err = user_data;
 
@@ -235,7 +235,7 @@ static void send_req(GObexPacket *req, GObexResponseFunc rsp_func,
 	GError *gerr = NULL;
 	GIOChannel *io;
 	GIOCondition cond;
-	guint io_id, timer_id, test_time;
+	unsigned int io_id, timer_id, test_time;
 	GObex *obex;
 
 	create_endpoints(&obex, &io, transport_type);
@@ -272,7 +272,7 @@ static void send_connect(GObexResponseFunc rsp_func, GIOFunc send_rsp_func,
 					int req_timeout, int transport_type)
 {
 	GObexPacket *req;
-	guint8 connect_data[] = { 0x10, 0x00, 0x10, 0x00 };
+	uint8_t connect_data[] = { 0x10, 0x00, 0x10, 0x00 };
 
 	req = g_obex_packet_new(G_OBEX_OP_CONNECT, TRUE, G_OBEX_HDR_INVALID);
 	g_assert(req != NULL);
@@ -322,7 +322,7 @@ static void test_send_connect_req_timeout_pkt(void)
 
 struct req_info {
 	GObex *obex;
-	guint id;
+	unsigned int id;
 	GError *err;
 };
 
@@ -420,7 +420,7 @@ failed:
 static void test_cancel_req_delay(int transport_type)
 {
 	GIOChannel *io;
-	guint io_id, timer_id;
+	unsigned int io_id, timer_id;
 	struct req_info r;
 	GObexPacket *req;
 	GIOCondition cond;
@@ -464,7 +464,7 @@ static void test_cancel_req_delay_pkt(void)
 
 struct rcv_buf_info {
 	GError *err;
-	const guint8 *buf;
+	const uint8_t *buf;
 	gsize len;
 };
 
@@ -510,12 +510,12 @@ done:
 
 static void test_send_connect(int transport_type)
 {
-	guint8 connect_data[] = { 0x10, 0x00, 0x10, 0x00 };
+	uint8_t connect_data[] = { 0x10, 0x00, 0x10, 0x00 };
 	struct rcv_buf_info r;
 	GIOChannel *io;
 	GIOCondition cond;
 	GObexPacket *req;
-	guint io_id, timer_id;
+	unsigned int io_id, timer_id;
 	GObex *obex;
 
 	create_endpoints(&obex, &io, transport_type);
@@ -578,9 +578,9 @@ static void test_recv_unexpected(void)
 	GError *err = NULL;
 	GObexPacket *req;
 	GIOChannel *io;
-	guint timer_id;
+	unsigned int timer_id;
 	GObex *obex;
-	guint8 buf[255];
+	uint8_t buf[255];
 	gssize len;
 
 	create_endpoints(&obex, &io, SOCK_STREAM);
@@ -632,7 +632,7 @@ static void test_send_on_demand(int transport_type, GObexDataProducer func)
 	GIOChannel *io;
 	GIOCondition cond;
 	GObexPacket *req;
-	guint io_id, timer_id;
+	unsigned int io_id, timer_id;
 	GObex *obex;
 
 	create_endpoints(&obex, &io, transport_type);
@@ -715,7 +715,7 @@ static void handle_connect_err(GObex *obex, GError *err, gpointer user_data)
 static void recv_connect(int transport_type)
 {
 	GError *gerr = NULL;
-	guint timer_id;
+	unsigned int timer_id;
 	GObex *obex;
 	GIOChannel *io;
 	GIOStatus status;
@@ -773,7 +773,7 @@ static void disconn_ev(GObex *obex, GError *err, gpointer user_data)
 static void test_disconnect(void)
 {
 	GError *gerr = NULL;
-	guint timer_id;
+	unsigned int timer_id;
 	GObex *obex;
 	GIOChannel *io;
 
@@ -848,7 +848,7 @@ static void test_connect(void)
 {
 	GIOChannel *io;
 	GIOCondition cond;
-	guint io_id, timer_id;
+	unsigned int io_id, timer_id;
 	GObex *obex;
 	struct test_data d = { 0, NULL, {
 				{ pkt_connect_req, sizeof(pkt_connect_req) } }, {
@@ -884,7 +884,7 @@ static void test_setpath(void)
 {
 	GIOChannel *io;
 	GIOCondition cond;
-	guint io_id, timer_id;
+	unsigned int io_id, timer_id;
 	GObex *obex;
 	struct test_data d = { 0, NULL, {
 			{ pkt_setpath_req, sizeof(pkt_setpath_req) } }, {
@@ -920,7 +920,7 @@ static void test_setpath_up(void)
 {
 	GIOChannel *io;
 	GIOCondition cond;
-	guint io_id, timer_id;
+	unsigned int io_id, timer_id;
 	GObex *obex;
 	struct test_data d = { 0, NULL, {
 			{ pkt_setpath_up_req, sizeof(pkt_setpath_up_req) } }, {
@@ -956,7 +956,7 @@ static void test_setpath_up_down(void)
 {
 	GIOChannel *io;
 	GIOCondition cond;
-	guint io_id, timer_id;
+	unsigned int io_id, timer_id;
 	GObex *obex;
 	struct test_data d = { 0, NULL, {
 			{ pkt_setpath_up_down_req,
@@ -993,7 +993,7 @@ static void test_mkdir(void)
 {
 	GIOChannel *io;
 	GIOCondition cond;
-	guint io_id, timer_id;
+	unsigned int io_id, timer_id;
 	GObex *obex;
 	struct test_data d = { 0, NULL, {
 			{ pkt_mkdir_req, sizeof(pkt_mkdir_req) } }, {
@@ -1029,7 +1029,7 @@ static void test_delete(void)
 {
 	GIOChannel *io;
 	GIOCondition cond;
-	guint io_id, timer_id;
+	unsigned int io_id, timer_id;
 	GObex *obex;
 	struct test_data d = { 0, NULL, {
 			{ pkt_delete_req, sizeof(pkt_delete_req) } }, {
@@ -1065,7 +1065,7 @@ static void test_copy(void)
 {
 	GIOChannel *io;
 	GIOCondition cond;
-	guint io_id, timer_id;
+	unsigned int io_id, timer_id;
 	GObex *obex;
 	struct test_data d = { 0, NULL, {
 			{ pkt_copy_req, sizeof(pkt_copy_req) } }, {
@@ -1101,7 +1101,7 @@ static void test_move(void)
 {
 	GIOChannel *io;
 	GIOCondition cond;
-	guint io_id, timer_id;
+	unsigned int io_id, timer_id;
 	GObex *obex;
 	struct test_data d = { 0, NULL, {
 			{ pkt_move_req, sizeof(pkt_move_req) } }, {
diff --git a/unit/test-mgmt.c b/unit/test-mgmt.c
index f9dcb00..5b61975 100644
--- a/unit/test-mgmt.c
+++ b/unit/test-mgmt.c
@@ -25,6 +25,7 @@
 #include <config.h>
 #endif
 
+#include <inttypes.h>
 #include <stdbool.h>
 #include <unistd.h>
 #include <sys/socket.h>
@@ -39,7 +40,7 @@
 struct context {
 	GMainLoop *main_loop;
 	struct mgmt *mgmt_client;
-	guint server_source;
+	unsigned int server_source;
 	GList *handler_list;
 };
 
diff --git a/unit/test-sdp.c b/unit/test-sdp.c
index 5aa6948..4a749c7 100644
--- a/unit/test-sdp.c
+++ b/unit/test-sdp.c
@@ -25,6 +25,7 @@
 #include <config.h>
 #endif
 
+#include <inttypes.h>
 #include <unistd.h>
 #include <stdlib.h>
 #include <stdbool.h>
@@ -111,8 +112,8 @@ struct test_data_de {
 
 struct context {
 	GMainLoop *main_loop;
-	guint server_source;
-	guint client_source;
+	unsigned int server_source;
+	unsigned int client_source;
 	int fd;
 	int mtu;
 	uint8_t cont_data[16];
diff --git a/unit/util.c b/unit/util.c
index c76acdf..093f001 100644
--- a/unit/util.c
+++ b/unit/util.c
@@ -27,7 +27,7 @@
 #include <sys/socket.h>
 #include <unistd.h>
 #include <stdlib.h>
-#include <stdint.h>
+#include <inttypes.h>
 #include <string.h>
 #include <errno.h>
 
diff --git a/unit/util.h b/unit/util.h
index 752ce61..e4caf9c 100644
--- a/unit/util.h
+++ b/unit/util.h
@@ -19,6 +19,7 @@
  *
  */
 
+#include <inttypes.h>
 #include <gobex/gobex.h>
 
 enum {
@@ -32,13 +33,13 @@ struct test_buf {
 };
 
 struct test_data {
-	guint count;
+	unsigned int count;
 	GError *err;
 	struct test_buf recv[4];
 	struct test_buf send[4];
-	guint provide_delay;
+	unsigned int provide_delay;
 	GObex *obex;
-	guint id;
+	unsigned int id;
 	gsize total;
 	GMainLoop *mainloop;
 };
-- 
1.8.2.2

