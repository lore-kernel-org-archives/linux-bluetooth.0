Return-Path: <cyrus@holtmann.org>
From: Michael Janssen <jamuraa@chromium.org>
To: linux-bluetooth@vger.kernel.org
Cc: Michael Janssen <jamuraa@chromium.org>
Subject: [PATCH BlueZ v4 08/10] unit/gattrib: Check expected PDUs were delivered
Date: Wed, 29 Oct 2014 19:45:43 -0700
Message-Id: <1414637145-32919-9-git-send-email-jamuraa@chromium.org>
In-Reply-To: <1414637145-32919-1-git-send-email-jamuraa@chromium.org>
References: <1414637145-32919-1-git-send-email-jamuraa@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Check that the PDUs that we expect to receive when
registering for events have been delivered.
---
 unit/test-gattrib.c | 35 ++++++++++++++++++++++++++++-------
 1 file changed, 28 insertions(+), 7 deletions(-)

diff --git a/unit/test-gattrib.c b/unit/test-gattrib.c
index e25746c..85f0f2b 100644
--- a/unit/test-gattrib.c
+++ b/unit/test-gattrib.c
@@ -403,7 +403,7 @@ static void notify_canary_expect(const guint8 *pdu, guint16 len, gpointer data)
 static void test_register(struct context *cxt, gconstpointer user_data)
 {
 	guint reg_id;
-	gboolean success;
+	gboolean canceled;
 	struct test_pdu pdus[] = {
 		/* Unmatched by any (GATTRIB_ALL_EVENTS) */
 		PDU_MTU_RESP,
@@ -433,6 +433,7 @@ static void test_register(struct context *cxt, gconstpointer user_data)
 		{ },
 	};
 	struct test_pdu followed_ind_pdus[] = { PDU_IND_DATA, { } };
+	struct test_pdu *current_pdu;
 
 	/*
 	 * Without registering anything, should be able to ignore everything but
@@ -445,7 +446,12 @@ static void test_register(struct context *cxt, gconstpointer user_data)
 
 	send_test_pdus(cxt, pdus);
 
-	g_attrib_unregister(cxt->att, reg_id);
+	canceled = g_attrib_unregister(cxt->att, reg_id);
+
+	g_assert(canceled);
+
+	for (current_pdu = pdus; current_pdu->valid; current_pdu++)
+		g_assert(current_pdu->received);
 
 	if (g_test_verbose())
 		g_print("ALL_REQS, ALL_HANDLES\r\n");
@@ -456,7 +462,12 @@ static void test_register(struct context *cxt, gconstpointer user_data)
 
 	send_test_pdus(cxt, pdus);
 
-	g_attrib_unregister(cxt->att, reg_id);
+	canceled = g_attrib_unregister(cxt->att, reg_id);
+
+	g_assert(canceled);
+
+	for (current_pdu = req_pdus; current_pdu->valid; current_pdu++)
+		g_assert(current_pdu->received);
 
 	if (g_test_verbose())
 		g_print("IND, ALL_HANDLES\r\n");
@@ -467,7 +478,12 @@ static void test_register(struct context *cxt, gconstpointer user_data)
 
 	send_test_pdus(cxt, pdus);
 
-	g_attrib_unregister(cxt->att, reg_id);
+	canceled = g_attrib_unregister(cxt->att, reg_id);
+
+	g_assert(canceled);
+
+	for (current_pdu = all_ind_pdus; current_pdu->valid; current_pdu++)
+		g_assert(current_pdu->received);
 
 	if (g_test_verbose())
 		g_print("IND, 0x0014\r\n");
@@ -478,11 +494,16 @@ static void test_register(struct context *cxt, gconstpointer user_data)
 
 	send_test_pdus(cxt, pdus);
 
-	g_attrib_unregister(cxt->att, reg_id);
+	canceled = g_attrib_unregister(cxt->att, reg_id);
+
+	g_assert(canceled);
 
-	success = g_attrib_unregister(cxt->att, reg_id);
+	for (current_pdu = followed_ind_pdus; current_pdu->valid; current_pdu++)
+		g_assert(current_pdu->received);
 
-	g_assert(!success);
+	canceled = g_attrib_unregister(cxt->att, reg_id);
+
+	g_assert(!canceled);
 }
 
 static void test_buffers(struct context *cxt, gconstpointer unused)
-- 
2.1.0.rc2.206.gedb03e5

