Return-Path: <cyrus@holtmann.org>
From: Bruna Moreira <bruna.moreira@openbossa.org>
To: linux-bluetooth@vger.kernel.org
Cc: Bruna Moreira <bruna.moreira@openbossa.org>
Subject: [RFC BlueZ 21/35] tools/mgmt-tester: Add support for second controller
Date: Wed, 12 Jun 2013 08:57:07 -0400
Message-Id: <1371041841-21793-22-git-send-email-bruna.moreira@openbossa.org>
In-Reply-To: <1371041841-21793-1-git-send-email-bruna.moreira@openbossa.org>
References: <1371041841-21793-1-git-send-email-bruna.moreira@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Add second controller to tester and let a testcase start discovery and
receive Device Found events.
---
 tools/mgmt-tester.c |   74 ++++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 73 insertions(+), 1 deletion(-)

diff --git a/tools/mgmt-tester.c b/tools/mgmt-tester.c
index cbff775..a27b2e2 100644
--- a/tools/mgmt-tester.c
+++ b/tools/mgmt-tester.c
@@ -56,6 +56,8 @@ struct test_data {
 	uint16_t mgmt_index;
 	struct hciemu *hciemu;
 	enum hciemu_type hciemu_type;
+	struct hciemu *hciemu_second;
+	uint16_t mgmt_index_second;
 	int unmet_conditions;
 };
 
@@ -165,6 +167,30 @@ static void read_info_callback(uint8_t status, uint16_t length,
 	tester_pre_setup_complete();
 }
 
+static void setup_powered_callback(uint8_t status, uint16_t length,
+					const void *param, void *user_data);
+
+static void second_powered_discoverable()
+{
+	struct test_data *data = tester_get_data();
+	unsigned char con_param[] = { 0x01 };
+	unsigned char discov_param[] = { 0x01, 0x00, 0x00 };
+
+	tester_print("Enabling connectable, discoverable and powered (second)");
+
+	mgmt_send(data->mgmt, MGMT_OP_SET_CONNECTABLE, data->mgmt_index_second,
+					sizeof(con_param), con_param,
+					NULL, NULL, NULL);
+
+	mgmt_send(data->mgmt, MGMT_OP_SET_DISCOVERABLE, data->mgmt_index_second,
+					sizeof(discov_param), discov_param,
+					NULL, NULL, NULL);
+
+	mgmt_send(data->mgmt, MGMT_OP_SET_POWERED, data->mgmt_index_second,
+					sizeof(con_param), con_param,
+					setup_powered_callback, NULL, NULL);
+}
+
 static void index_added_callback(uint16_t index, uint16_t length,
 					const void *param, void *user_data)
 {
@@ -173,6 +199,12 @@ static void index_added_callback(uint16_t index, uint16_t length,
 	tester_print("Index Added callback");
 	tester_print("  Index: 0x%04x", index);
 
+	if (data->hciemu_second) {
+		data->mgmt_index_second = index;
+		second_powered_discoverable();
+		return;
+	}
+
 	data->mgmt_index = index;
 
 	mgmt_send(data->mgmt, MGMT_OP_READ_INFO, data->mgmt_index, 0, NULL,
@@ -268,6 +300,12 @@ static void test_post_teardown(const void *test_data)
 {
 	struct test_data *data = tester_get_data();
 
+	if (data->hciemu_second) {
+		hciemu_unref(data->hciemu_second);
+		data->mgmt_index_second = 0xffff;
+		data->hciemu_second = NULL;
+	}
+
 	hciemu_unref(data->hciemu);
 	data->hciemu = NULL;
 }
@@ -299,6 +337,8 @@ static void test_condition_complete(struct test_data *data)
 		if (!user) \
 			break; \
 		user->hciemu_type = HCIEMU_TYPE_BREDRLE; \
+		user->hciemu_second = NULL; \
+		user->mgmt_index_second = 0xffff; \
 		user->test_data = data; \
 		user->expected_version = 0x06; \
 		user->expected_manufacturer = 0x003f; \
@@ -317,6 +357,8 @@ static void test_condition_complete(struct test_data *data)
 		if (!user) \
 			break; \
 		user->hciemu_type = HCIEMU_TYPE_BREDR; \
+		user->hciemu_second = NULL; \
+		user->mgmt_index_second = 0xffff; \
 		user->test_data = data; \
 		user->expected_version = 0x05; \
 		user->expected_manufacturer = 0x003f; \
@@ -335,6 +377,8 @@ static void test_condition_complete(struct test_data *data)
 		if (!user) \
 			break; \
 		user->hciemu_type = HCIEMU_TYPE_LE; \
+		user->hciemu_second = NULL; \
+		user->mgmt_index_second = 0xffff; \
 		user->test_data = data; \
 		user->expected_version = 0x06; \
 		user->expected_manufacturer = 0x003f; \
@@ -1828,6 +1872,27 @@ static void setup_ssp_powered(const void *test_data)
 					setup_powered_callback, NULL, NULL);
 }
 
+static void setup_le_powered_callback(uint8_t status, uint16_t length,
+					const void *param, void *user_data)
+{
+	struct test_data *data = tester_get_data();
+
+	if (status != MGMT_STATUS_SUCCESS) {
+		tester_setup_failed();
+		return;
+	}
+
+	tester_print("First Controller powered on");
+
+	if (!data->hciemu_second) {
+		if (option_wait_powered)
+			tester_wait(1, powered_delay, NULL);
+		else
+			tester_setup_complete();
+		return;
+	}
+}
+
 static void setup_le_powered(const void *test_data)
 {
 	struct test_data *data = tester_get_data();
@@ -1835,12 +1900,19 @@ static void setup_le_powered(const void *test_data)
 
 	tester_print("Powering on controller (with LE enabled)");
 
+	data->hciemu_second = hciemu_new(data->hciemu_type);
+	if (!data->hciemu_second) {
+		tester_warn("Failed to setup second HCI emulation");
+		tester_setup_failed();
+		return;
+	}
+
 	mgmt_send(data->mgmt, MGMT_OP_SET_LE, data->mgmt_index,
 				sizeof(param), param, NULL, NULL, NULL);
 
 	mgmt_send(data->mgmt, MGMT_OP_SET_POWERED, data->mgmt_index,
 					sizeof(param), param,
-					setup_powered_callback, NULL, NULL);
+					setup_le_powered_callback, NULL, NULL);
 }
 
 static void setup_discovery_callback(uint8_t status, uint16_t length,
-- 
1.7.9.5

