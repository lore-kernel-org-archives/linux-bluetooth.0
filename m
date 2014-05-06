Return-Path: <cyrus@holtmann.org>
From: Arman Uguray <armansito@chromium.org>
To: linux-bluetooth@vger.kernel.org
Cc: Arman Uguray <armansito@chromium.org>
Subject: [PATCH 09/10] unit/test-att: Add unit test for "Find By Type Value" request/response.
Date: Mon,  5 May 2014 21:46:02 -0700
Message-Id: <1399351563-25991-10-git-send-email-armansito@chromium.org>
In-Reply-To: <1399351563-25991-1-git-send-email-armansito@chromium.org>
References: <1399351563-25991-1-git-send-email-armansito@chromium.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Added test cases for the "Find By Type Value" request/response.
---
 unit/test-att.c | 105 ++++++++++++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 99 insertions(+), 6 deletions(-)

diff --git a/unit/test-att.c b/unit/test-att.c
index e45342a..86864c8 100644
--- a/unit/test-att.c
+++ b/unit/test-att.c
@@ -201,7 +201,7 @@ struct request_test_data {
 	uint16_t resp_param_length;
 	const void *req_data;
 	uint16_t req_size;
-	const  void *resp_data;
+	const void *resp_data;
 	uint16_t resp_size;
 	bool (*compare_func)(const void *a, const void *b);
 };
@@ -234,11 +234,11 @@ static const struct request_test_data request_test_1 = {
 };
 
 /* Exchange MTU request <-> error response test */
-static const unsigned char exchange_mtu_req_bytes_2[] = { 0x02, 0x32, 0x00 };
+static const uint8_t exchange_mtu_req_bytes_2[] = { 0x02, 0x32, 0x00 };
 static const struct bt_att_exchange_mtu_req_param exchange_mtu_req_param_2 = {
 	.client_rx_mtu = 50,
 };
-static const unsigned char exchange_mtu_resp_bytes_2[] = {
+static const uint8_t exchange_mtu_resp_bytes_2[] = {
 	0x01, 0x02, 0x00, 0x00, 0x06
 };
 static const struct bt_att_error_rsp_param exchange_mtu_rsp_param_2 = {
@@ -272,14 +272,14 @@ static bool compare_find_info_rsp(const void *a, const void *b)
 							p2->length) == 0;
 }
 
-static const unsigned char find_info_req_bytes[] = {
+static const uint8_t find_info_req_bytes[] = {
 	0x04, 0x01, 0x00, 0xff, 0xff
 };
 static const struct bt_att_find_information_req_param find_info_req_param = {
 	.start_handle = 0x0001,
 	.end_handle = 0xffff,
 };
-static const unsigned char find_info_resp_bytes_1[] = {
+static const uint8_t find_info_resp_bytes_1[] = {
 	0x05, 0x01, 0x01, 0x00, 0x0d, 0x18
 };
 static const uint8_t find_info_resp_information_data_1[] = {
@@ -305,7 +305,7 @@ static const struct request_test_data request_test_3 = {
 };
 
 /* Find Information request <-> invalid response */
-static const unsigned char find_info_resp_bytes_2[] = {
+static const uint8_t find_info_resp_bytes_2[] = {
 	0x05, 0x01
 };
 
@@ -320,6 +320,96 @@ static const struct request_test_data request_test_4 = {
 	.resp_size = sizeof(find_info_resp_bytes_2),
 };
 
+/* Find By Type Value request <-> response */
+static bool compare_find_by_type_val_rsp(const void *a, const void *b)
+{
+	const struct bt_att_find_by_type_value_rsp_param *p1 = a;
+	const struct bt_att_find_by_type_value_rsp_param *p2 = b;
+
+	if (p1->length != p2->length)
+		return false;
+
+	return memcmp(p1->handles_information_list,
+				p2->handles_information_list, p2->length) == 0;
+}
+
+static const uint8_t find_by_type_val_req_bytes_1[] = {
+	0x06, 0x01, 0x00, 0xff, 0xff, 0x00, 0x28, 0x01, 0x02, 0x03, 0x04
+};
+static const uint8_t find_by_type_val_req_att_value[] = {
+	0x01, 0x02, 0x03, 0x04
+};
+static const struct bt_att_find_by_type_value_req_param
+						find_by_type_val_rqp_1 = {
+	.start_handle = 0x0001,
+	.end_handle = 0xffff,
+	.type = 0x2800,
+	.value = find_by_type_val_req_att_value,
+	.length = sizeof(find_by_type_val_req_att_value),
+};
+static const uint8_t find_by_type_val_rsp_bytes_1[] = {
+	0x07, 0x01, 0x00, 0x02, 0x00, 0x02, 0x00, 0x03, 0x00
+};
+static const struct bt_att_find_by_type_value_rsp_param find_by_type_val_rpp = {
+	.handles_information_list = find_by_type_val_rsp_bytes_1 + 1,
+	.length = sizeof(find_by_type_val_rsp_bytes_1) - 1,
+};
+
+static const struct request_test_data request_test_5 = {
+	.req_opcode = ATT_OP_FIND_BY_TYPE_VALUE_REQ,
+	.req_param = &find_by_type_val_rqp_1,
+	.req_param_length = sizeof(find_by_type_val_rqp_1),
+	.resp_opcode = ATT_OP_FIND_BY_TYPE_VALUE_RESP,
+	.resp_param = &find_by_type_val_rpp,
+	.resp_param_length = sizeof(find_by_type_val_rpp),
+	.req_data = find_by_type_val_req_bytes_1,
+	.req_size = sizeof(find_by_type_val_req_bytes_1),
+	.resp_data = find_by_type_val_rsp_bytes_1,
+	.resp_size = sizeof(find_by_type_val_rsp_bytes_1),
+	.compare_func = compare_find_by_type_val_rsp,
+};
+
+/* Find By Type Value request <-> invalid response */
+static const uint8_t find_by_type_val_rsp_bytes_2[] = {
+	0x07, 0x01, 0x00, 0x02
+};
+
+static const struct request_test_data request_test_6 = {
+	.req_opcode = ATT_OP_FIND_BY_TYPE_VALUE_REQ,
+	.req_param = &find_by_type_val_rqp_1,
+	.req_param_length = sizeof(find_by_type_val_rqp_1),
+	.resp_opcode = ATT_OP_ERROR_RESP,
+	.req_data = find_by_type_val_req_bytes_1,
+	.req_size = sizeof(find_by_type_val_req_bytes_1),
+	.resp_data = find_by_type_val_rsp_bytes_2,
+	.resp_size = sizeof(find_by_type_val_rsp_bytes_2),
+};
+
+/* Find By Type Value request no value <-> response */
+static const uint8_t find_by_type_val_req_bytes_2[] = {
+	0x06, 0x01, 0x00, 0xff, 0xff, 0x00, 0x28
+};
+static const struct bt_att_find_by_type_value_req_param
+						find_by_type_val_rqp_2 = {
+	.start_handle = 0x0001,
+	.end_handle = 0xffff,
+	.type = 0x2800,
+};
+
+static const struct request_test_data request_test_7 = {
+	.req_opcode = ATT_OP_FIND_BY_TYPE_VALUE_REQ,
+	.req_param = &find_by_type_val_rqp_2,
+	.req_param_length = sizeof(find_by_type_val_rqp_2),
+	.resp_opcode = ATT_OP_FIND_BY_TYPE_VALUE_RESP,
+	.resp_param = &find_by_type_val_rpp,
+	.resp_param_length = sizeof(find_by_type_val_rpp),
+	.req_data = find_by_type_val_req_bytes_2,
+	.req_size = sizeof(find_by_type_val_req_bytes_2),
+	.resp_data = find_by_type_val_rsp_bytes_1,
+	.resp_size = sizeof(find_by_type_val_rsp_bytes_1),
+	.compare_func = compare_find_by_type_val_rsp,
+};
+
 static void test_request_callback(uint8_t opcode, const void *param,
 					uint16_t length, void *user_data)
 {
@@ -375,6 +465,9 @@ int main(int argc, char *argv[])
 	g_test_add_data_func("/att/request/2", &request_test_2, test_request);
 	g_test_add_data_func("/att/request/3", &request_test_3, test_request);
 	g_test_add_data_func("/att/request/4", &request_test_4, test_request);
+	g_test_add_data_func("/att/request/5", &request_test_5, test_request);
+	g_test_add_data_func("/att/request/6", &request_test_6, test_request);
+	g_test_add_data_func("/att/request/7", &request_test_7, test_request);
 
 	return g_test_run();
 }
-- 
1.9.1.423.g4596e3a

