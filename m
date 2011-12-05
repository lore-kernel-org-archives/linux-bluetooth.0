Return-Path: <cyrus@holtmann.org>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH obexd 1/4] gobex: always set CONNECTION_ID to 1 on unit tests
Date: Mon,  5 Dec 2011 14:35:16 +0200
Message-Id: <1323088519-18235-1-git-send-email-luiz.dentz@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

This simplify the creation of new test by not requiring different
variables for every connection response.
---
 unit/test-gobex-transfer.c |   41 ++++++++++++-----------------------------
 1 files changed, 12 insertions(+), 29 deletions(-)

diff --git a/unit/test-gobex-transfer.c b/unit/test-gobex-transfer.c
index f769fc6..ae3e28a 100644
--- a/unit/test-gobex-transfer.c
+++ b/unit/test-gobex-transfer.c
@@ -82,18 +82,6 @@ static guint8 conn_rsp[] = { G_OBEX_RSP_SUCCESS | FINAL_BIT, 0x00, 0x0c,
 					0x10, 0x00, 0x10, 0x00,
 					G_OBEX_HDR_CONNECTION, 0x00, 0x00,
 					0x00, 0x01 };
-static guint8 conn_rsp_2[] = { G_OBEX_RSP_SUCCESS | FINAL_BIT, 0x00, 0x0c,
-					0x10, 0x00, 0x10, 0x00,
-					G_OBEX_HDR_CONNECTION, 0x00, 0x00,
-					0x00, 0x02 };
-static guint8 conn_rsp_3[] = { G_OBEX_RSP_SUCCESS | FINAL_BIT, 0x00, 0x0c,
-					0x10, 0x00, 0x10, 0x00,
-					G_OBEX_HDR_CONNECTION, 0x00, 0x00,
-					0x00, 0x03 };
-static guint8 conn_rsp_4[] = { G_OBEX_RSP_SUCCESS | FINAL_BIT, 0x00, 0x0c,
-					0x10, 0x00, 0x10, 0x00,
-					G_OBEX_HDR_CONNECTION, 0x00, 0x00,
-					0x00, 0x04 };
 
 static guint8 unavailable_rsp[] = { G_OBEX_RSP_SERVICE_UNAVAILABLE | FINAL_BIT,
 					0x00, 0x03 };
@@ -104,8 +92,9 @@ static guint8 conn_get_req_first[] = { G_OBEX_OP_GET | FINAL_BIT, 0x00, 0x28,
 	'f', 'o', 'o', '/', 'b', 'a', 'r', '\0',
 	G_OBEX_HDR_NAME, 0x00, 0x15,
 	0, 'f', 0, 'i', 0, 'l', 0, 'e', 0, '.', 0, 't', 0, 'x', 0, 't', 0, 0 };
-static guint8 conn_get_req_first_2[] = { G_OBEX_OP_GET | FINAL_BIT, 0x00, 0x28,
-	G_OBEX_HDR_CONNECTION, 0x00, 0x00, 0x00, 0x02,
+
+static guint8 conn_get_req_wrg[] = { G_OBEX_OP_GET | FINAL_BIT, 0x00, 0x28,
+	G_OBEX_HDR_CONNECTION, 0x00, 0x00, 0x00, 0xFF,
 	G_OBEX_HDR_TYPE, 0x00, 0x0b,
 	'f', 'o', 'o', '/', 'b', 'a', 'r', '\0',
 	G_OBEX_HDR_NAME, 0x00, 0x15,
@@ -119,14 +108,6 @@ static guint8 conn_put_req_first[] = { G_OBEX_OP_PUT, 0x00, 0x35,
 	0, 'f', 0, 'i', 0, 'l', 0, 'e', 0, '.', 0, 't', 0, 'x', 0, 't', 0, 0,
 	G_OBEX_HDR_BODY, 0x00, 0x0d,
 	0, 1, 2, 3, 4, 5, 6, 7, 8, 9 };
-static guint8 conn_put_req_first_3[] = { G_OBEX_OP_PUT, 0x00, 0x35,
-	G_OBEX_HDR_CONNECTION, 0x00, 0x00, 0x00, 0x03,
-	G_OBEX_HDR_TYPE, 0x00, 0x0b,
-	'f', 'o', 'o', '/', 'b', 'a', 'r', '\0',
-	G_OBEX_HDR_NAME, 0x00, 0x15,
-	0, 'f', 0, 'i', 0, 'l', 0, 'e', 0, '.', 0, 't', 0, 'x', 0, 't', 0, 0,
-	G_OBEX_HDR_BODY, 0x00, 0x0d,
-	0, 1, 2, 3, 4, 5, 6, 7, 8, 9 };
 
 static guint8 hdr_type[] = "foo/bar";
 static guint8 hdr_app[] = { 0, 1, 2, 3 };
@@ -983,7 +964,9 @@ static void handle_conn_rsp(GObex *obex, GObexPacket *req,
 		return;
 	}
 
-	rsp = g_obex_packet_new(G_OBEX_RSP_SUCCESS, TRUE, G_OBEX_HDR_INVALID);
+	rsp = g_obex_packet_new(G_OBEX_RSP_SUCCESS, TRUE,
+						G_OBEX_HDR_CONNECTION, 1,
+						G_OBEX_HDR_INVALID);
 	g_obex_send(obex, rsp, &d->err);
 }
 
@@ -1093,10 +1076,10 @@ static void test_conn_get_rsp(void)
 	guint io_id, timer_id;
 	GObex *obex;
 	struct test_data d = { 0, NULL, {
-			{ conn_rsp_2, sizeof(conn_rsp_2) },
+			{ conn_rsp, sizeof(conn_rsp) },
 			{ get_rsp_first, sizeof(get_rsp_first) },
 			{ get_rsp_last, sizeof(get_rsp_last) } }, {
-			{ conn_get_req_first_2, sizeof(conn_get_req_first_2) },
+			{ conn_get_req_first, sizeof(conn_get_req_first) },
 			{ get_req_last, sizeof(get_req_last) },
 			{ NULL, 0 } } };
 
@@ -1199,10 +1182,10 @@ static void test_conn_put_rsp(void)
 	guint io_id, timer_id;
 	GObex *obex;
 	struct test_data d = { 0, NULL, {
-			{ conn_rsp_3, sizeof(conn_rsp_3) },
+			{ conn_rsp, sizeof(conn_rsp) },
 			{ put_rsp_first, sizeof(put_rsp_first) },
 			{ put_rsp_last, sizeof(put_rsp_last) } }, {
-			{ conn_put_req_first_3, sizeof(conn_put_req_first_3) },
+			{ conn_put_req_first, sizeof(conn_put_req_first) },
 			{ put_req_last, sizeof(put_req_last) },
 			{ NULL, 0 } } };
 
@@ -1247,9 +1230,9 @@ static void test_conn_get_wrg_rsp(void)
 	guint io_id, timer_id;
 	GObex *obex;
 	struct test_data d = { 0, NULL, {
-			{ conn_rsp_4, sizeof(conn_rsp_4) },
+			{ conn_rsp, sizeof(conn_rsp) },
 			{ unavailable_rsp, sizeof(unavailable_rsp) } }, {
-			{ conn_get_req_first, sizeof(conn_get_req_first) },
+			{ conn_get_req_wrg, sizeof(conn_get_req_wrg) },
 			{ NULL, 0 } } };
 
 	create_endpoints(&obex, &io, SOCK_STREAM);
-- 
1.7.7.3

