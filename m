Return-Path: <cyrus@holtmann.org>
From: Michael Janssen <jamuraa@chromium.org>
To: linux-bluetooth@vger.kernel.org
Cc: Michael Janssen <jamuraa@chromium.org>
Subject: [PATCH BlueZ v5 7/8] unit/gattrib: Respond to the request PDU.
Date: Fri, 31 Oct 2014 11:14:58 -0700
Message-Id: <1414779299-18197-8-git-send-email-jamuraa@chromium.org>
In-Reply-To: <1414779299-18197-1-git-send-email-jamuraa@chromium.org>
References: <1414779299-18197-1-git-send-email-jamuraa@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 unit/test-gattrib.c | 35 ++++++++++++++++++++++++++++-------
 1 file changed, 28 insertions(+), 7 deletions(-)

diff --git a/unit/test-gattrib.c b/unit/test-gattrib.c
index 326478d..a1ff530 100644
--- a/unit/test-gattrib.c
+++ b/unit/test-gattrib.c
@@ -358,7 +358,7 @@ static void send_test_pdus(gpointer context, struct test_pdu *pdus)
 	for (cur_pdu = pdus; cur_pdu->valid; cur_pdu++) {
 		if (g_test_verbose())
 			util_hexdump('>', cur_pdu->data, cur_pdu->size,
-						 test_debug, "send_test_pdus: ");
+                                                test_debug, "send_test_pdus: ");
 		len = write(fd, cur_pdu->data, cur_pdu->size);
 		g_assert_cmpint(len, ==, cur_pdu->size);
 		cur_pdu->sent = true;
@@ -370,13 +370,20 @@ static void send_test_pdus(gpointer context, struct test_pdu *pdus)
 
 #define PDU_MTU_RESP pdu(ATT_OP_MTU_RESP, 0x17)
 #define PDU_FIND_INFO_REQ pdu(ATT_OP_FIND_INFO_REQ, 0x01, 0x00, 0xFF, 0xFF)
+#define PDU_NO_ATT_ERR pdu(ATT_OP_ERROR, ATT_OP_FIND_INFO_REQ, 0x00, 0x00, 0x0A)
 #define PDU_IND_NODATA pdu(ATT_OP_HANDLE_IND, 0x01, 0x00)
 #define PDU_INVALID_IND pdu(ATT_OP_HANDLE_IND, 0x14)
 #define PDU_IND_DATA pdu(ATT_OP_HANDLE_IND, 0x14, 0x00, 0x01)
 
+struct expect_test_data {
+  struct test_pdu *expected;
+  GAttrib *att;
+};
+
 static void notify_canary_expect(const guint8 *pdu, guint16 len, gpointer data)
 {
-	struct test_pdu *expected = data;
+	struct expect_test_data *expect = data;
+        struct test_pdu *expected = expect->expected;
 	int cmp;
 
 	if (g_test_verbose())
@@ -399,6 +406,14 @@ static void notify_canary_expect(const guint8 *pdu, guint16 len, gpointer data)
 	g_assert(cmp == 0);
 
 	expected->received = true;
+
+	if (pdu[0] == ATT_OP_FIND_INFO_REQ) {
+		struct test_pdu no_attributes = PDU_NO_ATT_ERR;
+		int reqid;
+		reqid = g_attrib_send(expect->att, 0, no_attributes.data,
+					  no_attributes.size, NULL, NULL, NULL);
+		g_assert(reqid != 0);
+	}
 }
 
 static void test_register(struct context *cxt, gconstpointer user_data)
@@ -435,15 +450,19 @@ static void test_register(struct context *cxt, gconstpointer user_data)
 	};
 	struct test_pdu followed_ind_pdus[] = { PDU_IND_DATA, { } };
 	struct test_pdu *current_pdu;
+	struct expect_test_data expect;
+
+	expect.att = cxt->att;
 
 	/*
 	 * Without registering anything, should be able to ignore everything but
 	 * an unexpected response. */
 	send_test_pdus(cxt, pdus + 1);
 
+	expect.expected = pdus;
 	reg_id = g_attrib_register(cxt->att, GATTRIB_ALL_EVENTS,
 				      GATTRIB_ALL_HANDLES, notify_canary_expect,
-								    pdus, NULL);
+								 &expect, NULL);
 
 	send_test_pdus(cxt, pdus);
 
@@ -457,9 +476,10 @@ static void test_register(struct context *cxt, gconstpointer user_data)
 	if (g_test_verbose())
 		g_print("ALL_REQS, ALL_HANDLES\r\n");
 
+	expect.expected = req_pdus;
 	reg_id = g_attrib_register(cxt->att, GATTRIB_ALL_REQS,
 				      GATTRIB_ALL_HANDLES, notify_canary_expect,
-								req_pdus, NULL);
+								 &expect, NULL);
 
 	send_test_pdus(cxt, pdus);
 
@@ -473,9 +493,10 @@ static void test_register(struct context *cxt, gconstpointer user_data)
 	if (g_test_verbose())
 		g_print("IND, ALL_HANDLES\r\n");
 
+	expect.expected = all_ind_pdus;
 	reg_id = g_attrib_register(cxt->att, ATT_OP_HANDLE_IND,
 				      GATTRIB_ALL_HANDLES, notify_canary_expect,
-							    all_ind_pdus, NULL);
+								 &expect, NULL);
 
 	send_test_pdus(cxt, pdus);
 
@@ -489,9 +510,9 @@ static void test_register(struct context *cxt, gconstpointer user_data)
 	if (g_test_verbose())
 		g_print("IND, 0x0014\r\n");
 
+	expect.expected = followed_ind_pdus;
 	reg_id = g_attrib_register(cxt->att, ATT_OP_HANDLE_IND, 0x0014,
-					notify_canary_expect, followed_ind_pdus,
-									  NULL);
+					notify_canary_expect, &expect, NULL);
 
 	send_test_pdus(cxt, pdus);
 
-- 
2.1.0.rc2.206.gedb03e5

