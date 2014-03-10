Return-Path: <cyrus@holtmann.org>
From: Szymon Janc <szymon.janc@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Szymon Janc <szymon.janc@gmail.com>
Subject: [PATCH 3/7] unit/test-hfp: Add initial tests for getting quoted string
Date: Tue, 11 Mar 2014 00:10:30 +0100
Message-Id: <1394493034-2417-3-git-send-email-szymon.janc@gmail.com>
In-Reply-To: <1394493034-2417-1-git-send-email-szymon.janc@gmail.com>
References: <1394493034-2417-1-git-send-email-szymon.janc@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 unit/test-hfp.c | 60 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 60 insertions(+)

diff --git a/unit/test-hfp.c b/unit/test-hfp.c
index 7837fc3..445fcb7 100644
--- a/unit/test-hfp.c
+++ b/unit/test-hfp.c
@@ -349,6 +349,54 @@ static void check_ustring_2(struct hfp_gw_result *result,
 	hfp_gw_send_result(context->hfp, HFP_RESULT_ERROR);
 }
 
+static void check_string_1(struct hfp_gw_result *result,
+				enum hfp_gw_cmd_type type, void *user_data)
+{
+	struct context *context = user_data;
+	const struct test_pdu *pdu;
+	unsigned int i = 4, j = 0;
+	char str[10];
+
+	pdu = &context->data->pdu_list[context->pdu_offset++];
+
+	g_assert(type == pdu->type);
+
+	g_assert(hfp_gw_result_get_string(result, str, sizeof(str)));
+
+	while (context->data->pdu_list[1].data[i] != '\"') {
+		g_assert(j < sizeof(str));
+		g_assert(str[j] == context->data->pdu_list[1].data[i]);
+
+		i++;
+		j++;
+	}
+
+	g_assert(context->data->pdu_list[1].data[i] == '\"');
+	g_assert(str[j] == '\0');
+
+	hfp_gw_send_result(context->hfp, HFP_RESULT_ERROR);
+}
+
+static void check_string_2(struct hfp_gw_result *result,
+				enum hfp_gw_cmd_type type, void *user_data)
+{
+	struct context *context = user_data;
+	const struct test_pdu *pdu;
+	char str[10];
+
+	memset(str, 'X', sizeof(str));
+
+	pdu = &context->data->pdu_list[context->pdu_offset++];
+
+	g_assert(type == pdu->type);
+
+	g_assert(!hfp_gw_result_get_string(result, str, 3));
+
+	g_assert(str[3] == 'X');
+
+	hfp_gw_send_result(context->hfp, HFP_RESULT_ERROR);
+}
+
 int main(int argc, char *argv[])
 {
 	g_test_init(&argc, &argv, NULL);
@@ -402,6 +450,18 @@ int main(int argc, char *argv[])
 			raw_pdu('A', 'T', 'D', '0', '1', '2', '3', '\r'),
 			type_pdu(HFP_GW_CMD_TYPE_SET, 0),
 			data_end());
+	define_test("/hfp/test_string_1", test_register, check_string_1,
+			raw_pdu('D', '\0'),
+			raw_pdu('A', 'T', 'D', '\"', '0', '1', '2', '3', '\"',
+									'\r'),
+			type_pdu(HFP_GW_CMD_TYPE_SET, 0),
+			data_end());
+	define_test("/hfp/test_string_2", test_register, check_string_2,
+			raw_pdu('D', '\0'),
+			raw_pdu('A', 'T', 'D', '\"', '0', '1', '2', '3', '\"',
+									'\r'),
+			type_pdu(HFP_GW_CMD_TYPE_SET, 0),
+			data_end());
 
 	return g_test_run();
 }
-- 
1.9.0

