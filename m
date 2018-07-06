Return-Path: <jaganath.k.os@gmail.com>
From: Jaganath Kanakkassery <jaganath.k.os@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: marcel@holtmann.org,
	Jaganath Kanakkassery <jaganathx.kanakkassery@intel.com>
Subject: [PATCH BlueZ 8/8] mgmt-tester: Add support ext create connection and enh conn complete
Date: Fri,  6 Jul 2018 16:58:05 +0530
Message-Id: <1530876485-17218-9-git-send-email-jaganathx.kanakkassery@intel.com>
In-Reply-To: <1530876485-17218-1-git-send-email-jaganathx.kanakkassery@intel.com>
References: <1530876485-17218-1-git-send-email-jaganathx.kanakkassery@intel.com>
List-ID: <linux-bluetooth.vger.kernel.org>

---
 tools/mgmt-tester.c | 49 ++++++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 42 insertions(+), 7 deletions(-)

diff --git a/tools/mgmt-tester.c b/tools/mgmt-tester.c
index d4ebdb6..8f65478 100644
--- a/tools/mgmt-tester.c
+++ b/tools/mgmt-tester.c
@@ -5292,6 +5292,7 @@ static void client_cmd_complete(uint16_t opcode, uint8_t status,
 	switch (opcode) {
 	case BT_HCI_CMD_WRITE_SCAN_ENABLE:
 	case BT_HCI_CMD_LE_SET_ADV_ENABLE:
+	case BT_HCI_CMD_LE_SET_EXT_ADV_ENABLE:
 		tester_print("Client set connectable: %s (0x%02x)",
 						mgmt_errstr(status), status);
 		if (!status && test->client_enable_ssp) {
@@ -5321,9 +5322,14 @@ static void setup_bthost(void)
 
 	bthost = hciemu_client_get_host(data->hciemu);
 	bthost_set_cmd_complete_cb(bthost, client_cmd_complete, data);
-	if (data->hciemu_type == HCIEMU_TYPE_LE || test->client_enable_adv)
-		bthost_set_adv_enable(bthost, 0x01);
-	else
+
+	if (data->hciemu_type == HCIEMU_TYPE_LE ||
+		test->client_enable_adv) {
+		if (data->hciemu_type == HCIEMU_TYPE_BREDRLE50)
+			bthost_set_ext_adv_enable(bthost, 0x01);
+		else
+			bthost_set_adv_enable(bthost, 0x01);
+	} else
 		bthost_write_scan_enable(bthost, 0x03);
 }
 
@@ -8868,9 +8874,15 @@ static void le_connected_event(uint16_t index, uint16_t length,
 	tester_print("Device connected");
 
 	test_add_condition(data);
-	hciemu_add_hook(data->hciemu, HCIEMU_HOOK_POST_CMD,
-						BT_HCI_CMD_LE_SET_ADV_ENABLE,
-						test_adv_enable_hook, data);
+
+	if (data->hciemu_type == HCIEMU_TYPE_BREDRLE50)
+		hciemu_add_hook(data->hciemu, HCIEMU_HOOK_POST_CMD,
+					BT_HCI_CMD_LE_SET_EXT_ADV_ENABLE,
+					test_adv_enable_hook, data);
+	else
+		hciemu_add_hook(data->hciemu, HCIEMU_HOOK_POST_CMD,
+					BT_HCI_CMD_LE_SET_ADV_ENABLE,
+					test_adv_enable_hook, data);
 
 	/* Make sure we get not disconnected during the testaces */
 	mgmt_register(data->mgmt_alt, MGMT_EV_DEVICE_DISCONNECTED,
@@ -8910,7 +8922,10 @@ static void add_device_callback(uint8_t status, uint16_t len, const void *param,
 	}
 
 	bthost = hciemu_client_get_host(data->hciemu);
-	bthost_hci_connect(bthost, master_bdaddr, BDADDR_LE_PUBLIC);
+	if (data->hciemu_type == HCIEMU_TYPE_BREDRLE50)
+		bthost_hci_ext_connect(bthost, master_bdaddr, BDADDR_LE_PUBLIC);
+	else
+		bthost_hci_connect(bthost, master_bdaddr, BDADDR_LE_PUBLIC);
 }
 
 static void test_connected_and_advertising(const void *test_data)
@@ -10384,5 +10399,25 @@ int main(int argc, char *argv[])
 				&device_found_invalid_field,
 				NULL, test_device_found);
 
+	test_bredrle50_full("Ext Adv. connectable & connected (slave) - Success",
+				&conn_slave_adv_conneactable_test,
+				setup_advertise_while_connected,
+				test_connected_and_advertising, 10);
+
+	test_bredrle50_full("Ext Adv. non-connectable & connected (slave) - Success",
+				&conn_slave_adv_non_conneactable_test,
+				setup_advertise_while_connected,
+				test_connected_and_advertising, 10);
+
+	test_bredrle50_full("Ext Adv. connectable & connected (master) - Success",
+				&conn_master_adv_conneactable_test,
+				setup_advertise_while_connected,
+				test_connected_and_advertising, 10);
+
+	test_bredrle50_full("Ext Adv. non-connectable & connected (master) - Success",
+				&conn_master_adv_non_conneactable_test,
+				setup_advertise_while_connected,
+				test_connected_and_advertising, 10);
+
 	return tester_run();
 }
-- 
2.7.4
