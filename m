Return-Path: <cyrus@holtmann.org>
From: Marcin Kraglak <marcin.kraglak@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv2 10/11] unit/test-hfp: Add /hfp/test_fragmented_1
Date: Wed,  5 Mar 2014 20:22:55 +0100
Message-Id: <1394047376-11495-10-git-send-email-marcin.kraglak@tieto.com>
In-Reply-To: <1394047376-11495-1-git-send-email-marcin.kraglak@tieto.com>
References: <1394047376-11495-1-git-send-email-marcin.kraglak@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 unit/test-hfp.c | 47 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 47 insertions(+)

diff --git a/unit/test-hfp.c b/unit/test-hfp.c
index 546a239..5218a2b 100644
--- a/unit/test-hfp.c
+++ b/unit/test-hfp.c
@@ -45,6 +45,7 @@ struct test_pdu {
 	const uint8_t *data;
 	size_t size;
 	enum hfp_gw_cmd_type type;
+	bool fragmented;
 };
 
 struct test_data {
@@ -74,6 +75,14 @@ struct test_data {
 		.type = cmd_type,				\
 	}
 
+#define frg_pdu(args...)					\
+	{							\
+		.valid = true,					\
+		.data = data(args),				\
+		.size = sizeof(data(args)),			\
+		.fragmented = true,				\
+	}
+
 #define define_test(name, function, args...)				\
 	do {								\
 		const struct test_pdu pdus[] = {			\
@@ -255,6 +264,40 @@ static void test_register(gconstpointer data)
 	execute_context(context);
 }
 
+static gboolean send_pdu(gpointer user_data)
+{
+	struct context *context = user_data;
+	const struct test_pdu *pdu;
+	ssize_t len;
+
+	pdu = &context->data->pdu_list[context->pdu_offset++];
+
+	len = write(context->fd_server, pdu->data, pdu->size);
+	g_assert_cmpint(len, ==, pdu->size);
+
+	pdu = &context->data->pdu_list[context->pdu_offset];
+	if (pdu->fragmented)
+		g_idle_add(send_pdu, context);
+
+	return FALSE;
+}
+
+static void test_fragmented(gconstpointer data)
+{
+	struct context *context = create_context(data);
+	bool ret;
+
+	context->hfp = hfp_gw_new(context->fd_client);
+	g_assert(context->hfp);
+
+	ret = hfp_gw_set_close_on_unref(context->hfp, true);
+	g_assert(ret);
+
+	g_idle_add(send_pdu, context);
+
+	execute_context(context);
+}
+
 int main(int argc, char *argv[])
 {
 	g_test_init(&argc, &argv, NULL);
@@ -294,6 +337,10 @@ int main(int argc, char *argv[])
 			raw_pdu('A', 'T', 'D', '1', '2', '3', '4', '5', '\r'),
 			type_pdu(HFP_GW_CMD_TYPE_SET, 0),
 			data_end());
+	define_test("/hfp/test_fragmented_1", test_fragmented,
+			frg_pdu('A'), frg_pdu('T'), frg_pdu('+'), frg_pdu('B'),
+			frg_pdu('R'), frg_pdu('S'), frg_pdu('F'), frg_pdu('\r'),
+			data_end());
 
 	return g_test_run();
 }
-- 
1.8.3.1

