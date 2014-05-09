Return-Path: <cyrus@holtmann.org>
From: Arman Uguray <armansito@chromium.org>
To: linux-bluetooth@vger.kernel.org
Cc: Arman Uguray <armansito@chromium.org>
Subject: [PATCH v1 06/10] unit/test-att: Add unit test for "Find Information" request/response.
Date: Fri,  9 May 2014 13:13:56 -0700
Message-Id: <1399666440-14078-7-git-send-email-armansito@chromium.org>
In-Reply-To: <1399666440-14078-1-git-send-email-armansito@chromium.org>
References: <1399666440-14078-1-git-send-email-armansito@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Added test case for the "Find Information" request/response.
---
 unit/test-att.c | 75 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 74 insertions(+), 1 deletion(-)

diff --git a/unit/test-att.c b/unit/test-att.c
index 2ea65f9..9649db5 100644
--- a/unit/test-att.c
+++ b/unit/test-att.c
@@ -204,6 +204,7 @@ struct request_test_data {
 	uint16_t req_size;
 	const  void *resp_data;
 	uint16_t resp_size;
+	bool (*compare_func)(const void *a, const void *b);
 };
 
 struct request_test {
@@ -259,6 +260,67 @@ static const struct request_test_data request_test_2 = {
 	.resp_size = sizeof(exchange_mtu_resp_bytes_2),
 };
 
+/* Find Information request <-> response */
+static bool compare_find_info_rsp(const void *a, const void *b)
+{
+	const struct bt_att_find_information_rsp_param *p1 = a;
+	const struct bt_att_find_information_rsp_param *p2 = b;
+
+	if (p1->format != p2->format || p1->length != p2->length)
+		return false;
+
+	return memcmp(p1->information_data, p2->information_data,
+							p2->length) == 0;
+}
+
+static const unsigned char find_info_req_bytes[] = {
+	0x04, 0x01, 0x00, 0xff, 0xff
+};
+static const struct bt_att_find_information_req_param find_info_req_param = {
+	.start_handle = 0x0001,
+	.end_handle = 0xffff,
+};
+static const unsigned char find_info_resp_bytes_1[] = {
+	0x05, 0x01, 0x01, 0x00, 0x0d, 0x18
+};
+static const uint8_t find_info_resp_information_data_1[] = {
+	0x01, 0x00, 0x0d, 0x18
+};
+static const struct bt_att_find_information_rsp_param find_info_rsp_param = {
+	.format = 0x01,
+	.information_data = find_info_resp_information_data_1,
+	.length = sizeof(find_info_resp_information_data_1),
+};
+static const struct request_test_data request_test_3 = {
+	.req_opcode = ATT_OP_FIND_INFORMATION_REQ,
+	.req_param = &find_info_req_param,
+	.req_param_length = sizeof(find_info_req_param),
+	.resp_opcode = ATT_OP_FIND_INFORMATION_RESP,
+	.resp_param = &find_info_rsp_param,
+	.resp_param_length = sizeof(find_info_rsp_param),
+	.req_data = find_info_req_bytes,
+	.req_size = sizeof(find_info_req_bytes),
+	.resp_data = find_info_resp_bytes_1,
+	.resp_size = sizeof(find_info_resp_bytes_1),
+	.compare_func = compare_find_info_rsp,
+};
+
+/* Find Information request <-> invalid response */
+static const unsigned char find_info_resp_bytes_2[] = {
+	0x05, 0x01
+};
+
+static const struct request_test_data request_test_4 = {
+	.req_opcode = ATT_OP_FIND_INFORMATION_REQ,
+	.req_param = &find_info_req_param,
+	.req_param_length = sizeof(find_info_req_param),
+	.resp_opcode = ATT_OP_ERROR_RESP,
+	.req_data = find_info_req_bytes,
+	.req_size = sizeof(find_info_req_bytes),
+	.resp_data = find_info_resp_bytes_2,
+	.resp_size = sizeof(find_info_resp_bytes_2),
+};
+
 static void test_request_callback(uint8_t opcode, const void *param,
 					uint16_t length, void *user_data)
 {
@@ -268,7 +330,16 @@ static void test_request_callback(uint8_t opcode, const void *param,
 	g_assert(opcode == test_data->resp_opcode);
 	g_assert(length == test_data->resp_param_length);
 
-	g_assert(0 == memcmp(param, test_data->resp_param, length));
+	if (length == 0 || !param) {
+		g_assert(length == 0 && !param);
+		context_quit(test->context);
+		return;
+	}
+
+	if (test_data->compare_func)
+		g_assert(test_data->compare_func(param, test_data->resp_param));
+	else
+		g_assert(0 == memcmp(param, test_data->resp_param, length));
 
 	context_quit(test->context);
 }
@@ -303,6 +374,8 @@ int main(int argc, char *argv[])
 
 	g_test_add_data_func("/att/request/1", &request_test_1, test_request);
 	g_test_add_data_func("/att/request/2", &request_test_2, test_request);
+	g_test_add_data_func("/att/request/3", &request_test_3, test_request);
+	g_test_add_data_func("/att/request/4", &request_test_4, test_request);
 
 	return g_test_run();
 }
-- 
1.8.3.2

