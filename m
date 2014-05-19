Return-Path: <cyrus@holtmann.org>
From: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
Subject: [PATCH 4/4] tools/mgmt-tester: Add "Get Conn Info - Not Connected"
Date: Mon, 19 May 2014 23:14:05 +0200
Message-Id: <1400534045-16818-4-git-send-email-andrzej.kaczmarek@tieto.com>
In-Reply-To: <1400534045-16818-1-git-send-email-andrzej.kaczmarek@tieto.com>
References: <1400534045-16818-1-git-send-email-andrzej.kaczmarek@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 tools/mgmt-tester.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/tools/mgmt-tester.c b/tools/mgmt-tester.c
index 14b1d3d..4290c21 100644
--- a/tools/mgmt-tester.c
+++ b/tools/mgmt-tester.c
@@ -2766,6 +2766,22 @@ static const void *get_conn_info_expect_param_func(uint16_t *len)
 	return param;
 }
 
+static const void *get_conn_info_error_expect_param_func(uint16_t *len)
+{
+	struct test_data *data = tester_get_data();
+	static uint8_t param[10];
+
+	/* All unset parameters shall be 0 in case of error */
+	memset(param, 0, sizeof(param));
+
+	memcpy(param, hciemu_get_client_bdaddr(data->hciemu), 6);
+	param[6] = 0x00; /* Address type */
+
+	*len = sizeof(param);
+
+	return param;
+}
+
 static const struct generic_data get_conn_info_succes1_test = {
 	.setup_settings = settings_powered_connectable_pairable_ssp,
 	.send_opcode = MGMT_OP_GET_CONN_INFO,
@@ -2774,6 +2790,14 @@ static const struct generic_data get_conn_info_succes1_test = {
 	.expect_func = get_conn_info_expect_param_func,
 };
 
+static const struct generic_data get_conn_info_ncon_test = {
+	.setup_settings = settings_powered_connectable_pairable_ssp,
+	.send_opcode = MGMT_OP_GET_CONN_INFO,
+	.send_func = get_conn_info_send_param_func,
+	.expect_status = MGMT_STATUS_NOT_CONNECTED,
+	.expect_func = get_conn_info_error_expect_param_func,
+};
+
 static void client_cmd_complete(uint16_t opcode, uint8_t status,
 					const void *param, uint8_t len,
 					void *user_data)
@@ -4104,5 +4128,9 @@ int main(int argc, char *argv[])
 	test_bredrle("Get Conn Info - Success",
 				&get_conn_info_succes1_test, NULL,
 				test_command_generic_connect);
+	test_bredrle("Get Conn Info - Not Connected",
+				&get_conn_info_ncon_test, NULL,
+				test_command_generic);
+
 	return tester_run();
 }
-- 
1.9.3

