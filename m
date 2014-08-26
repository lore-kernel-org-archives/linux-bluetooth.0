Return-Path: <cyrus@holtmann.org>
From: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
To: linux-bluetooth@vger.kernel.org
Cc: Lukasz Rymanowski <lukasz.rymanowski@tieto.com>
Subject: [PATCH 3/5] android/tester: Add parameter to remote connect function
Date: Tue, 26 Aug 2014 22:41:50 +0200
Message-Id: <1409085712-12402-3-git-send-email-lukasz.rymanowski@tieto.com>
In-Reply-To: <1409085712-12402-1-git-send-email-lukasz.rymanowski@tieto.com>
References: <1409085712-12402-1-git-send-email-lukasz.rymanowski@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This patch extends emu_remote_connect_hci_action function with address
type of device to be connected
---
 android/tester-gatt.c | 10 +++++++---
 android/tester-main.c |  8 +++++++-
 android/tester-main.h |  3 +++
 3 files changed, 17 insertions(+), 4 deletions(-)

diff --git a/android/tester-gatt.c b/android/tester-gatt.c
index 979a1de..b680322 100644
--- a/android/tester-gatt.c
+++ b/android/tester-gatt.c
@@ -95,6 +95,10 @@ static struct gatt_connect_data client2_conn_req = {
 static const uint8_t exchange_mtu_req_pdu[] = { 0x02, 0xa0, 0x02 };
 static const uint8_t exchange_mtu_resp_pdu[] = { 0x03, 0xa0, 0x02 };
 
+static struct bt_action_data bearer_type = {
+	.bearer_type = BDADDR_LE_PUBLIC,
+};
+
 static void gatt_client_register_action(void)
 {
 	struct test_data *data = tester_get_data();
@@ -380,7 +384,7 @@ static struct test_case test_cases[] = {
 		CALLBACK_STATUS(CB_GATTC_REGISTER_CLIENT, BT_STATUS_SUCCESS),
 		ACTION_SUCCESS(gatt_client_do_listen_action, &client1_conn_req),
 		CALLBACK_STATUS(CB_GATTC_LISTEN, GATT_STATUS_SUCCESS),
-		ACTION_SUCCESS(emu_remote_connect_hci_action, NULL),
+		ACTION_SUCCESS(emu_remote_connect_hci_action, &bearer_type),
 		CALLBACK_GATTC_CONNECT(GATT_STATUS_SUCCESS,
 						prop_emu_remotes_default_set,
 						CONN1_ID, CLIENT1_ID),
@@ -408,7 +412,7 @@ static struct test_case test_cases[] = {
 		CALLBACK_STATUS(CB_GATTC_REGISTER_CLIENT, BT_STATUS_SUCCESS),
 		ACTION_SUCCESS(gatt_client_do_listen_action, &client1_conn_req),
 		CALLBACK_STATUS(CB_GATTC_LISTEN, GATT_STATUS_SUCCESS),
-		ACTION_SUCCESS(emu_remote_connect_hci_action, NULL),
+		ACTION_SUCCESS(emu_remote_connect_hci_action, &bearer_type),
 		CALLBACK_GATTC_CONNECT(GATT_STATUS_SUCCESS,
 						prop_emu_remotes_default_set,
 						CONN1_ID, CLIENT1_ID),
@@ -427,7 +431,7 @@ static struct test_case test_cases[] = {
 						BT_ACL_STATE_DISCONNECTED),
 		ACTION_SUCCESS(gatt_client_do_listen_action, &client1_conn_req),
 		CALLBACK_STATUS(CB_GATTC_LISTEN, GATT_STATUS_SUCCESS),
-		ACTION_SUCCESS(emu_remote_connect_hci_action, NULL),
+		ACTION_SUCCESS(emu_remote_connect_hci_action, &bearer_type),
 		CALLBACK_GATTC_CONNECT(GATT_STATUS_SUCCESS,
 						prop_emu_remotes_default_set,
 						CONN2_ID, CLIENT1_ID),
diff --git a/android/tester-main.c b/android/tester-main.c
index c41ce1c..310efb0 100644
--- a/android/tester-main.c
+++ b/android/tester-main.c
@@ -1627,6 +1627,8 @@ void emu_remote_connect_hci_action(void)
 {
 	struct test_data *data = tester_get_data();
 	struct bthost *bthost = hciemu_client_get_host(data->hciemu);
+	struct step *current_data_step = queue_peek_head(data->steps);
+	struct bt_action_data *action_data = current_data_step->set_data;
 	struct step *step = g_new0(struct step, 1);
 	const uint8_t *master_addr;
 
@@ -1634,7 +1636,11 @@ void emu_remote_connect_hci_action(void)
 
 	tester_print("Trying to connect hci");
 
-	bthost_hci_connect(bthost, master_addr, BDADDR_LE_PUBLIC);
+	if (action_data)
+		bthost_hci_connect(bthost, master_addr,
+						action_data->bearer_type);
+	else
+		bthost_hci_connect(bthost, master_addr, BDADDR_BREDR);
 
 	step->action_status = BT_STATUS_SUCCESS;
 
diff --git a/android/tester-main.h b/android/tester-main.h
index 3331e91..e83933a 100644
--- a/android/tester-main.h
+++ b/android/tester-main.h
@@ -343,6 +343,9 @@ struct bt_action_data {
 
 	/* HidHost params */
 	const int report_size;
+
+	/*Connection params*/
+	const uint8_t bearer_type;
 };
 
 /* bthost's l2cap server setup parameters */
-- 
1.8.4

