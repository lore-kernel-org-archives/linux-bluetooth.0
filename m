Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Jaganath Kanakkassery <jaganath.k.os@gmail.com>
To: linux-bluetooth@vger.kernel.org
Cc: Jaganath Kanakkassery <jaganathx.kanakkassery@intel.com>
Subject: [PATCH v1 10/10] mgmt-tester: Add support ext create connection and enh conn complete
Date: Thu, 12 Apr 2018 16:51:01 +0530
Message-Id: <1523532061-17192-11-git-send-email-jaganathx.kanakkassery@intel.com>
In-Reply-To: <1523532061-17192-1-git-send-email-jaganathx.kanakkassery@intel.com>
References: <1523532061-17192-1-git-send-email-jaganathx.kanakkassery@intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 emulator/btdev.c    | 86 +++++++++++++++++++++++++++++++++++++++++++++++++++--
 emulator/bthost.c   | 55 ++++++++++++++++++++++++++++++++++
 emulator/bthost.h   |  3 ++
 tools/mgmt-tester.c | 49 +++++++++++++++++++++++++-----
 4 files changed, 184 insertions(+), 9 deletions(-)

diff --git a/emulator/btdev.c b/emulator/btdev.c
index c3d2b8a..72c35da 100644
--- a/emulator/btdev.c
+++ b/emulator/btdev.c
@@ -636,7 +636,8 @@ struct btdev *btdev_create(enum btdev_type type, uint16_t id)
 
 	memset(btdev, 0, sizeof(*btdev));
 
-	if (type == BTDEV_TYPE_BREDRLE || type == BTDEV_TYPE_LE) {
+	if (type == BTDEV_TYPE_BREDRLE || type == BTDEV_TYPE_LE
+				|| BTDEV_TYPE_BREDRLE50) {
 		btdev->crypto = bt_crypto_new();
 		if (!btdev->crypto) {
 			free(btdev);
@@ -1220,6 +1221,53 @@ static void le_conn_complete(struct btdev *btdev,
 	send_event(btdev, BT_HCI_EVT_LE_META_EVENT, buf, sizeof(buf));
 }
 
+static void le_ext_conn_complete(struct btdev *btdev,
+				const struct bt_hci_cmd_le_ext_create_conn *leecc,
+				uint8_t status)
+{
+	char buf[1 + sizeof(struct bt_hci_evt_le_enhanced_conn_complete)];
+	struct bt_hci_evt_le_enhanced_conn_complete *cc = (void *) &buf[1];
+	struct bt_hci_le_ext_create_conn *lecc = (void *)leecc->data;
+
+	memset(buf, 0, sizeof(buf));
+
+	buf[0] = BT_HCI_EVT_LE_ENHANCED_CONN_COMPLETE;
+
+	if (!status) {
+		struct btdev *remote;
+
+		remote = find_btdev_by_bdaddr_type(leecc->peer_addr,
+							leecc->peer_addr_type);
+
+		btdev->conn = remote;
+		btdev->le_adv_enable = 0;
+		remote->conn = btdev;
+		remote->le_adv_enable = 0;
+
+		cc->status = status;
+		cc->peer_addr_type = btdev->le_scan_own_addr_type;
+		if (cc->peer_addr_type == 0x01)
+			memcpy(cc->peer_addr, btdev->random_addr, 6);
+		else
+			memcpy(cc->peer_addr, btdev->bdaddr, 6);
+
+		cc->role = 0x01;
+		cc->handle = cpu_to_le16(42);
+		cc->interval = lecc->max_interval;
+		cc->latency = lecc->latency;
+		cc->supv_timeout = lecc->supv_timeout;
+
+		send_event(remote, BT_HCI_EVT_LE_META_EVENT, buf, sizeof(buf));
+	}
+
+	cc->status = status;
+	cc->peer_addr_type = leecc->peer_addr_type;
+	memcpy(cc->peer_addr, leecc->peer_addr, 6);
+	cc->role = 0x00;
+
+	send_event(btdev, BT_HCI_EVT_LE_META_EVENT, buf, sizeof(buf));
+}
+
 static const uint8_t *scan_addr(const struct btdev *btdev)
 {
 	if (btdev->le_scan_own_addr_type == 0x01)
@@ -1268,6 +1316,14 @@ static bool adv_connectable(struct btdev *btdev)
 	return btdev->le_adv_type != 0x03;
 }
 
+static bool ext_adv_connectable(struct btdev *btdev)
+{
+	if (!btdev->le_adv_enable)
+		return false;
+
+	return btdev->le_ext_adv_type & 0x01;
+}
+
 static void le_conn_request(struct btdev *btdev,
 				const struct bt_hci_cmd_le_create_conn *lecc)
 {
@@ -1282,6 +1338,20 @@ static void le_conn_request(struct btdev *btdev,
 					BT_HCI_ERR_CONN_FAILED_TO_ESTABLISH);
 }
 
+static void le_ext_conn_request(struct btdev *btdev,
+				const struct bt_hci_cmd_le_ext_create_conn *leecc)
+{
+	struct btdev *remote = find_btdev_by_bdaddr_type(leecc->peer_addr,
+							leecc->peer_addr_type);
+
+	if (remote && ext_adv_connectable(remote) && ext_adv_match(btdev, remote) &&
+				remote->le_adv_own_addr == leecc->peer_addr_type)
+		le_ext_conn_complete(btdev, leecc, 0);
+	else
+		le_ext_conn_complete(btdev, leecc,
+					BT_HCI_ERR_CONN_FAILED_TO_ESTABLISH);
+}
+
 static void conn_request(struct btdev *btdev, const uint8_t *bdaddr)
 {
 	struct btdev *remote = find_btdev_by_bdaddr(bdaddr);
@@ -3593,7 +3663,12 @@ static void default_cmd(struct btdev *btdev, uint16_t opcode,
 		}
 		cmd_complete(btdev, opcode, &status, sizeof(status));
 		break;
+	case BT_HCI_CMD_LE_EXT_CREATE_CONN:
+		if (btdev->type != BTDEV_TYPE_BREDRLE50)
+			goto unsupported;
 
+		cmd_status(btdev, BT_HCI_ERR_SUCCESS, opcode);
+		break;
 	default:
 		goto unsupported;
 	}
@@ -3632,6 +3707,7 @@ static void default_cmd_completion(struct btdev *btdev, uint16_t opcode,
 	const struct bt_hci_cmd_le_conn_param_req_neg_reply *lcprnr;
 	const struct bt_hci_cmd_le_set_scan_enable *lsse;
 	const struct bt_hci_cmd_le_set_ext_scan_enable *lsese;
+	const struct bt_hci_cmd_le_ext_create_conn *leecc;
 
 	switch (opcode) {
 	case BT_HCI_CMD_INQUIRY:
@@ -3834,7 +3910,13 @@ static void default_cmd_completion(struct btdev *btdev, uint16_t opcode,
 		if (btdev->le_scan_enable && lsese->enable)
 			le_set_ext_scan_enable_complete(btdev);
 		break;
-
+	case BT_HCI_CMD_LE_EXT_CREATE_CONN:
+		if (btdev->type != BTDEV_TYPE_BREDRLE50)
+			return;
+		leecc = data;
+		btdev->le_scan_own_addr_type = leecc->own_addr_type;
+		le_ext_conn_request(btdev, leecc);
+		break;
 	}
 }
 
diff --git a/emulator/bthost.c b/emulator/bthost.c
index 45b9bd6..d37957f 100644
--- a/emulator/bthost.c
+++ b/emulator/bthost.c
@@ -1167,6 +1167,26 @@ static void evt_le_conn_complete(struct bthost *bthost, const void *data,
 	init_conn(bthost, le16_to_cpu(ev->handle), ev->peer_addr, addr_type);
 }
 
+static void evt_le_ext_conn_complete(struct bthost *bthost, const void *data,
+								uint8_t len)
+{
+	const struct bt_hci_evt_le_enhanced_conn_complete *ev = data;
+	uint8_t addr_type;
+
+	if (len < sizeof(*ev))
+		return;
+
+	if (ev->status)
+		return;
+
+	if (ev->peer_addr_type == 0x00)
+		addr_type = BDADDR_LE_PUBLIC;
+	else
+		addr_type = BDADDR_LE_RANDOM;
+
+	init_conn(bthost, le16_to_cpu(ev->handle), ev->peer_addr, addr_type);
+}
+
 static void evt_le_conn_update_complete(struct bthost *bthost, const void *data,
 								uint8_t len)
 {
@@ -1246,6 +1266,9 @@ static void evt_le_meta_event(struct bthost *bthost, const void *data,
 	case BT_HCI_EVT_LE_LONG_TERM_KEY_REQUEST:
 		evt_le_ltk_request(bthost, evt_data, len - 1);
 		break;
+	case BT_HCI_EVT_LE_ENHANCED_CONN_COMPLETE:
+		evt_le_ext_conn_complete(bthost, evt_data, len - 1);
+		break;
 	default:
 		printf("Unsupported LE Meta event 0x%2.2x\n", *event);
 		break;
@@ -2275,6 +2298,38 @@ void bthost_hci_connect(struct bthost *bthost, const uint8_t *bdaddr,
 	}
 }
 
+void bthost_hci_ext_connect(struct bthost *bthost, const uint8_t *bdaddr,
+							uint8_t addr_type)
+{
+	struct bt_hci_cmd_le_ext_create_conn *cc;
+	struct bt_hci_le_ext_create_conn *cp;
+	uint8_t buf[sizeof(*cc) + sizeof(*cp)];
+
+	cc = (void *)buf;
+	cp = (void *)cc->data;
+
+	bthost->conn_init = true;
+
+	memset(cc, 0, sizeof(*cc));
+	memset(cp, 0, sizeof(*cp));
+
+	memcpy(cc->peer_addr, bdaddr, sizeof(cc->peer_addr));
+
+	if (addr_type == BDADDR_LE_RANDOM)
+		cc->peer_addr_type = 0x01;
+
+	cc->phys = 0x01;
+
+	cp->scan_interval = cpu_to_le16(0x0060);
+	cp->scan_window = cpu_to_le16(0x0030);
+	cp->min_interval = cpu_to_le16(0x0028);
+	cp->max_interval = cpu_to_le16(0x0038);
+	cp->supv_timeout = cpu_to_le16(0x002a);
+
+	send_command(bthost, BT_HCI_CMD_LE_EXT_CREATE_CONN,
+						buf, sizeof(buf));
+}
+
 void bthost_hci_disconnect(struct bthost *bthost, uint16_t handle,
 								uint8_t reason)
 {
diff --git a/emulator/bthost.h b/emulator/bthost.h
index 752c14b..b5f3696 100644
--- a/emulator/bthost.h
+++ b/emulator/bthost.h
@@ -56,6 +56,9 @@ void bthost_set_connect_cb(struct bthost *bthost, bthost_new_conn_cb cb,
 void bthost_hci_connect(struct bthost *bthost, const uint8_t *bdaddr,
 							uint8_t addr_type);
 
+void bthost_hci_ext_connect(struct bthost *bthost, const uint8_t *bdaddr,
+							uint8_t addr_type);
+
 void bthost_hci_disconnect(struct bthost *bthost, uint16_t handle,
 								uint8_t reason);
 
diff --git a/tools/mgmt-tester.c b/tools/mgmt-tester.c
index e5076b5..1523ca8 100644
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
 
@@ -8866,9 +8872,15 @@ static void le_connected_event(uint16_t index, uint16_t length,
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
@@ -8908,7 +8920,10 @@ static void add_device_callback(uint8_t status, uint16_t len, const void *param,
 	}
 
 	bthost = hciemu_client_get_host(data->hciemu);
-	bthost_hci_connect(bthost, master_bdaddr, BDADDR_LE_PUBLIC);
+	if (data->hciemu_type == HCIEMU_TYPE_BREDRLE50)
+		bthost_hci_ext_connect(bthost, master_bdaddr, BDADDR_LE_PUBLIC);
+	else
+		bthost_hci_connect(bthost, master_bdaddr, BDADDR_LE_PUBLIC);
 }
 
 static void test_connected_and_advertising(const void *test_data)
@@ -10382,5 +10397,25 @@ int main(int argc, char *argv[])
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

