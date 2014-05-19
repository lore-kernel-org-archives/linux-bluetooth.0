Return-Path: <cyrus@holtmann.org>
From: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Andrzej Kaczmarek <andrzej.kaczmarek@tieto.com>
Subject: [PATCH 3/4] tools/mgmt-tester: Add "Get Conn Info - Success"
Date: Mon, 19 May 2014 23:14:04 +0200
Message-Id: <1400534045-16818-3-git-send-email-andrzej.kaczmarek@tieto.com>
In-Reply-To: <1400534045-16818-1-git-send-email-andrzej.kaczmarek@tieto.com>
References: <1400534045-16818-1-git-send-email-andrzej.kaczmarek@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 tools/mgmt-tester.c | 91 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 91 insertions(+)

diff --git a/tools/mgmt-tester.c b/tools/mgmt-tester.c
index 4cc7ba4..14b1d3d 100644
--- a/tools/mgmt-tester.c
+++ b/tools/mgmt-tester.c
@@ -2737,6 +2737,43 @@ static const struct generic_data set_privacy_nval_param_test = {
 	.expect_status = MGMT_STATUS_INVALID_PARAMS,
 };
 
+static const void *get_conn_info_send_param_func(uint16_t *len)
+{
+	struct test_data *data = tester_get_data();
+	static uint8_t param[7];
+
+	memcpy(param, hciemu_get_client_bdaddr(data->hciemu), 6);
+	param[6] = 0x00; /* Address type */
+
+	*len = sizeof(param);
+
+	return param;
+}
+
+static const void *get_conn_info_expect_param_func(uint16_t *len)
+{
+	struct test_data *data = tester_get_data();
+	static uint8_t param[10];
+
+	memcpy(param, hciemu_get_client_bdaddr(data->hciemu), 6);
+	param[6] = 0x00; /* Address type */
+	param[7] = 0xff; /* RSSI (= -1) */
+	param[8] = 0xff; /* TX power (= -1) */
+	param[9] = 0x04; /* max TX power */
+
+	*len = sizeof(param);
+
+	return param;
+}
+
+static const struct generic_data get_conn_info_succes1_test = {
+	.setup_settings = settings_powered_connectable_pairable_ssp,
+	.send_opcode = MGMT_OP_GET_CONN_INFO,
+	.send_func = get_conn_info_send_param_func,
+	.expect_status = MGMT_STATUS_SUCCESS,
+	.expect_func = get_conn_info_expect_param_func,
+};
+
 static void client_cmd_complete(uint16_t opcode, uint8_t status,
 					const void *param, uint8_t len,
 					void *user_data)
@@ -3422,6 +3459,57 @@ static void test_pairing_acceptor(const void *test_data)
 	bthost_hci_connect(bthost, master_bdaddr, addr_type);
 }
 
+static void connected_event(uint16_t index, uint16_t length, const void *param,
+							void *user_data)
+{
+	struct test_data *data = tester_get_data();
+	const struct generic_data *test = data->test_data;
+	const void *send_param = test->send_param;
+	uint16_t send_len = test->send_len;
+
+	tester_print("Sending command 0x%04x", test->send_opcode);
+
+	if (test->send_func)
+		send_param = test->send_func(&send_len);
+
+	mgmt_send(data->mgmt, test->send_opcode, data->mgmt_index, send_len,
+			send_param, command_generic_callback, NULL, NULL);
+	test_add_condition(data);
+
+	/* Complete MGMT_EV_DEVICE_CONNECTED *after* adding new one */
+	test_condition_complete(data);
+}
+
+static void test_command_generic_connect(const void *test_data)
+{
+	struct test_data *data = tester_get_data();
+	unsigned int id;
+	const uint8_t *master_bdaddr;
+	uint8_t addr_type;
+	struct bthost *bthost;
+
+	tester_print("Registering %s notification",
+					mgmt_evstr(MGMT_EV_DEVICE_CONNECTED));
+	id = mgmt_register(data->mgmt_alt, MGMT_EV_DEVICE_CONNECTED,
+				data->mgmt_index, connected_event,
+				NULL, NULL);
+	data->mgmt_alt_ev_id = id;
+	test_add_condition(data);
+
+	master_bdaddr = hciemu_get_master_bdaddr(data->hciemu);
+	if (!master_bdaddr) {
+		tester_warn("No master bdaddr");
+		tester_test_failed();
+		return;
+	}
+
+	addr_type = data->hciemu_type == HCIEMU_TYPE_BREDRLE ? BDADDR_BREDR :
+							BDADDR_LE_PUBLIC;
+
+	bthost = hciemu_client_get_host(data->hciemu);
+	bthost_hci_connect(bthost, master_bdaddr, addr_type);
+}
+
 int main(int argc, char *argv[])
 {
 	tester_init(&argc, &argv);
@@ -4013,5 +4101,8 @@ int main(int argc, char *argv[])
 				&set_privacy_nval_param_test,
 				NULL, test_command_generic);
 
+	test_bredrle("Get Conn Info - Success",
+				&get_conn_info_succes1_test, NULL,
+				test_command_generic_connect);
 	return tester_run();
 }
-- 
1.9.3

