Return-Path: <cyrus@holtmann.org>
From: Michael Janssen <jamuraa@chromium.org>
To: linux-bluetooth@vger.kernel.org
Cc: Michael Janssen <jamuraa@chromium.org>
Subject: [PATCH BlueZ v2 6/7] attrib: Add unit tests for g_attrib_register
Date: Fri, 24 Oct 2014 13:36:22 -0700
Message-Id: <1414182983-23959-7-git-send-email-jamuraa@chromium.org>
In-Reply-To: <1414182983-23959-1-git-send-email-jamuraa@chromium.org>
References: <1414182983-23959-1-git-send-email-jamuraa@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 unit/test-gattrib.c | 157 +++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 156 insertions(+), 1 deletion(-)

diff --git a/unit/test-gattrib.c b/unit/test-gattrib.c
index 23a5485..61db4a1 100644
--- a/unit/test-gattrib.c
+++ b/unit/test-gattrib.c
@@ -45,6 +45,23 @@
 
 #define data(args...) ((const unsigned char[]) { args })
 
+struct test_pdu {
+	bool valid;
+	bool sent;
+	bool received;
+	const uint8_t *data;
+	size_t size;
+};
+
+#define pdu(args...)				\
+	{					\
+		.valid = true,			\
+		.sent = false,			\
+		.received = false,		\
+		.data = data(args),		\
+		.size = sizeof(data(args)),	\
+	}
+
 struct context {
 	GMainLoop *main_loop;
 	GIOChannel *att_io;
@@ -298,9 +315,147 @@ static void test_cancel(struct context *cxt, gconstpointer unused)
 	g_assert(!canceled);
 }
 
+static void send_test_pdus(gpointer context, struct test_pdu *pdus)
+{
+	struct context *cxt = context;
+	size_t len;
+	int fd;
+	struct test_pdu *cur_pdu;
+
+	fd = g_io_channel_unix_get_fd(cxt->server_io);
+
+	for (cur_pdu = pdus; cur_pdu->valid; cur_pdu++)
+		cur_pdu->sent = false;
+
+	for (cur_pdu = pdus; cur_pdu->valid; cur_pdu++) {
+		if (g_test_verbose())
+			util_hexdump('>', cur_pdu->data, cur_pdu->size,
+						 test_debug, "send_test_pdus: ");
+		len = write(fd, cur_pdu->data, cur_pdu->size);
+		g_assert_cmpint(len, ==, cur_pdu->size);
+		do {
+			g_main_context_iteration(NULL, TRUE);
+		} while (g_main_context_pending(NULL));
+		cur_pdu->sent = true;
+	}
+}
+
+#define PDU_MTU_RESP pdu(ATT_OP_MTU_RESP, 0x17)
+#define PDU_FIND_INFO_REQ pdu(ATT_OP_FIND_INFO_REQ, 0x01, 0x00, 0xFF, 0xFF)
+#define PDU_IND_NODATA pdu(ATT_OP_HANDLE_IND, 0x01, 0x00)
+#define PDU_INVALID_IND pdu(ATT_OP_HANDLE_IND, 0x14)
+#define PDU_IND_DATA pdu(ATT_OP_HANDLE_IND, 0x14, 0x00, 0x01)
+
+static void notify_canary_expect(const guint8 *pdu, guint16 len, gpointer data)
+{
+	struct test_pdu *expected = data;
+	int cmp;
+
+	if (g_test_verbose())
+		util_hexdump('<', pdu, len, test_debug,
+						      "notify_canary_expect: ");
+
+	while (expected->valid && expected->received)
+		expected++;
+
+	g_assert(expected->valid);
+
+	if (g_test_verbose())
+		util_hexdump('?', expected->data, expected->size, test_debug,
+						      "notify_canary_expect: ");
+
+	g_assert_cmpint(expected->size, ==, len);
+
+	cmp = memcmp(pdu, expected->data, expected->size);
+
+	g_assert(cmp == 0);
+
+	expected->received = true;
+}
+
 static void test_register(struct context *cxt, gconstpointer user_data)
 {
-	/* TODO */
+	guint reg_id;
+	gboolean success;
+	struct test_pdu pdus[] = {
+		/* Unmatched by any (GATTRIB_ALL_EVENTS) */
+		PDU_MTU_RESP,
+		/*
+		 * Unmatched PDU opcode
+		 * Unmatched handle (GATTRIB_ALL_REQS) */
+		PDU_FIND_INFO_REQ,
+		/*
+		 * Matched PDU opcode
+		 * Unmatched handle (GATTRIB_ALL_HANDLES) */
+		PDU_IND_NODATA,
+		/*
+		 * Matched PDU opcode
+		 * Invalid length? */
+		PDU_INVALID_IND,
+		/*
+		 * Matched PDU opcode
+		 * Matched handle */
+		PDU_IND_DATA,
+		{ },
+	};
+	struct test_pdu req_pdus[] = { PDU_FIND_INFO_REQ, { } };
+	struct test_pdu all_ind_pdus[] = {
+		PDU_IND_NODATA,
+		PDU_INVALID_IND,
+		PDU_IND_DATA,
+		{ },
+	};
+	struct test_pdu followed_ind_pdus[] = { PDU_IND_DATA, { } };
+
+	/*
+	 * Without registering anything, should be able to ignore everything but
+	 * an unexpected response. */
+	send_test_pdus(cxt, pdus + 1);
+
+	reg_id = g_attrib_register(cxt->att, GATTRIB_ALL_EVENTS,
+				      GATTRIB_ALL_HANDLES, notify_canary_expect,
+								    pdus, NULL);
+
+	send_test_pdus(cxt, pdus);
+
+	g_attrib_unregister(cxt->att, reg_id);
+
+	if (g_test_verbose())
+		g_print("ALL_REQS, ALL_HANDLES\r\n");
+
+	reg_id = g_attrib_register(cxt->att, GATTRIB_ALL_REQS,
+				      GATTRIB_ALL_HANDLES, notify_canary_expect,
+								req_pdus, NULL);
+
+	send_test_pdus(cxt, pdus);
+
+	g_attrib_unregister(cxt->att, reg_id);
+
+	if (g_test_verbose())
+		g_print("IND, ALL_HANDLES\r\n");
+
+	reg_id = g_attrib_register(cxt->att, ATT_OP_HANDLE_IND,
+				      GATTRIB_ALL_HANDLES, notify_canary_expect,
+							    all_ind_pdus, NULL);
+
+	send_test_pdus(cxt, pdus);
+
+	g_attrib_unregister(cxt->att, reg_id);
+
+	if (g_test_verbose())
+		g_print("IND, 0x0014\r\n");
+
+	reg_id = g_attrib_register(cxt->att, ATT_OP_HANDLE_IND, 0x0014,
+					notify_canary_expect, followed_ind_pdus,
+									  NULL);
+
+	send_test_pdus(cxt, pdus);
+
+	g_attrib_unregister(cxt->att, reg_id);
+
+	success = g_attrib_unregister(cxt->att, reg_id);
+
+	g_assert(!success);
 }
 
 static void test_buffers(struct context *cxt, gconstpointer unused)
-- 
2.1.0.rc2.206.gedb03e5

