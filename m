Return-Path: <cyrus@holtmann.org>
From: Marcin Kraglak <marcin.kraglak@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCHv2 05/11] unit/test-hfp: Add /hfp/test_register_1
Date: Wed,  5 Mar 2014 20:22:50 +0100
Message-Id: <1394047376-11495-5-git-send-email-marcin.kraglak@tieto.com>
In-Reply-To: <1394047376-11495-1-git-send-email-marcin.kraglak@tieto.com>
References: <1394047376-11495-1-git-send-email-marcin.kraglak@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 unit/test-hfp.c | 54 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 54 insertions(+)

diff --git a/unit/test-hfp.c b/unit/test-hfp.c
index 1a22298..f202f91 100644
--- a/unit/test-hfp.c
+++ b/unit/test-hfp.c
@@ -44,6 +44,7 @@ struct test_pdu {
 	bool valid;
 	const uint8_t *data;
 	size_t size;
+	enum hfp_gw_cmd_type type;
 };
 
 struct test_data {
@@ -65,6 +66,14 @@ struct test_data {
 		.valid = false,					\
 	}
 
+#define type_pdu(cmd_type, args...)				\
+	{							\
+		.valid = true,					\
+		.data = data(args),				\
+		.size = sizeof(data(args)),			\
+		.type = cmd_type,				\
+	}
+
 #define define_test(name, function, args...)				\
 	do {								\
 		const struct test_pdu pdus[] = {			\
@@ -118,6 +127,19 @@ static void cmd_handler(const char *command, void *user_data)
 	hfp_gw_send_result(context->hfp, HFP_RESULT_ERROR);
 }
 
+static void prefix_handler(struct hfp_gw_result *result,
+				enum hfp_gw_cmd_type type, void *user_data)
+{
+	struct context *context = user_data;
+	const struct test_pdu *pdu;
+
+	pdu = &context->data->pdu_list[context->pdu_offset++];
+
+	g_assert(type == pdu->type);
+
+	hfp_gw_send_result(context->hfp, HFP_RESULT_ERROR);
+}
+
 static struct context *create_context(gconstpointer data)
 {
 	struct context *context = g_new0(struct context, 1);
@@ -206,6 +228,33 @@ static void test_command_handler(gconstpointer data)
 	execute_context(context);
 }
 
+static void test_register(gconstpointer data)
+{
+	struct context *context = create_context(data);
+	const struct test_pdu *pdu;
+	ssize_t len;
+	bool ret;
+
+	context->hfp = hfp_gw_new(context->fd_client);
+	g_assert(context->hfp);
+
+	pdu = &context->data->pdu_list[context->pdu_offset++];
+
+	ret = hfp_gw_set_close_on_unref(context->hfp, true);
+	g_assert(ret);
+
+	ret = hfp_gw_register(context->hfp, prefix_handler, (char *)pdu->data,
+								context, NULL);
+	g_assert(ret);
+
+	pdu = &context->data->pdu_list[context->pdu_offset++];
+
+	len = write(context->fd_server, pdu->data, pdu->size);
+	g_assert_cmpint(len, ==, pdu->size);
+
+	execute_context(context);
+}
+
 int main(int argc, char *argv[])
 {
 	g_test_init(&argc, &argv, NULL);
@@ -219,6 +268,11 @@ int main(int argc, char *argv[])
 			raw_pdu('A', 'T', 'D', '1', '2', '3', '4', '\r'),
 			raw_pdu('A', 'T', 'D', '1', '2', '3', '4'),
 			data_end());
+	define_test("/hfp/test_register_1", test_register,
+			raw_pdu('+', 'B', 'R', 'S', 'F', '\0'),
+			raw_pdu('A', 'T', '+', 'B', 'R', 'S', 'F', '\r'),
+			type_pdu(HFP_GW_CMD_TYPE_COMMAND, 0),
+			data_end());
 
 	return g_test_run();
 }
-- 
1.8.3.1

