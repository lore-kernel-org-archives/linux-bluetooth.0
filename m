Return-Path: <cyrus@holtmann.org>
From: Marcin Kraglak <marcin.kraglak@tieto.com>
To: linux-bluetooth@vger.kernel.org
Subject: [PATCH 3/6] android/hal-bluetooth: Implement read_energy_info
Date: Fri, 21 Nov 2014 12:16:40 +0100
Message-Id: <1416568603-3666-3-git-send-email-marcin.kraglak@tieto.com>
In-Reply-To: <1416568603-3666-1-git-send-email-marcin.kraglak@tieto.com>
References: <1416568603-3666-1-git-send-email-marcin.kraglak@tieto.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

---
 android/bluetooth.c     | 12 ++++++++++++
 android/hal-bluetooth.c | 26 ++++++++++++++++++++++++--
 android/hal-msg.h       | 12 ++++++++++++
 3 files changed, 48 insertions(+), 2 deletions(-)

diff --git a/android/bluetooth.c b/android/bluetooth.c
index 947a83c..ca3dd24 100644
--- a/android/bluetooth.c
+++ b/android/bluetooth.c
@@ -5155,6 +5155,16 @@ static void handle_get_connection_state(const void *buf, uint16_t len)
 				-1);
 }
 
+static void handle_read_energy_info(const void *buf, uint16_t len)
+{
+	DBG("");
+
+	/* TODO */
+
+	ipc_send_rsp(hal_ipc, HAL_SERVICE_ID_BLUETOOTH, HAL_OP_READ_ENERGY_INFO,
+							HAL_STATUS_UNSUPPORTED);
+}
+
 static const struct ipc_handler cmd_handlers[] = {
 	/* HAL_OP_ENABLE */
 	{ handle_enable_cmd, false, 0 },
@@ -5208,6 +5218,8 @@ static const struct ipc_handler cmd_handlers[] = {
 	/* HAL_OP_GET_CONNECTION_STATE */
 	{ handle_get_connection_state, false,
 				sizeof(struct hal_cmd_get_connection_state) },
+	/* HAL_OP_READ_ENERGY_INFO */
+	{ handle_read_energy_info, false, 0 },
 };
 
 bool bt_bluetooth_register(struct ipc *ipc, uint8_t mode)
diff --git a/android/hal-bluetooth.c b/android/hal-bluetooth.c
index 50e3f07..9685499 100644
--- a/android/hal-bluetooth.c
+++ b/android/hal-bluetooth.c
@@ -350,6 +350,24 @@ static void handle_le_test_mode(void *buf, uint16_t len, int fd)
 		bt_hal_cbacks->le_test_mode_cb(ev->status, ev->num_packets);
 }
 
+static void handle_energy_info(void *buf, uint16_t len, int fd)
+{
+	struct hal_ev_energy_info *ev = buf;
+	bt_activity_energy_info info;
+
+	DBG("");
+
+	info.ctrl_state = ev->ctrl_state;
+	info.energy_used = ev->energy_used;
+	info.idle_time = ev->idle_time;
+	info.rx_time = ev->rx_time;
+	info.status = ev->status;
+	info.tx_time = ev->status;
+
+	if (bt_hal_cbacks->energy_info_cb)
+		bt_hal_cbacks->energy_info_cb(&info);
+}
+
 /*
  * handlers will be called from notification thread context,
  * index in table equals to 'opcode - HAL_MINIMUM_EVENT'
@@ -387,6 +405,8 @@ static const struct hal_ipc_handler ev_handlers[] = {
 				sizeof(struct hal_ev_dut_mode_receive) },
 	/* HAL_EV_LE_TEST_MODE */
 	{ handle_le_test_mode, false, sizeof(struct hal_ev_le_test_mode) },
+	/* HAL_EV_ENERGY_INFO */
+	{ handle_energy_info, false, sizeof(struct hal_ev_energy_info) },
 };
 
 static uint8_t get_mode(void)
@@ -998,9 +1018,11 @@ static int read_energy_info(void)
 {
 	DBG("");
 
-	/* TODO: implement */
+	if (!interface_ready())
+		return BT_STATUS_NOT_READY;
 
-	return BT_STATUS_UNSUPPORTED;
+	return hal_ipc_cmd(HAL_SERVICE_ID_BLUETOOTH, HAL_OP_READ_ENERGY_INFO, 0,
+							NULL, NULL, NULL, NULL);
 }
 #endif
 
diff --git a/android/hal-msg.h b/android/hal-msg.h
index 6a5a81c..9baa2d9 100644
--- a/android/hal-msg.h
+++ b/android/hal-msg.h
@@ -261,6 +261,8 @@ struct hal_rsp_get_connection_state {
 	int32_t connection_state;
 } __attribute__((packed));
 
+#define HAL_OP_READ_ENERGY_INFO		0x16
+
 /* Bluetooth Socket HAL api */
 
 #define HAL_SOCK_RFCOMM		0x01
@@ -1348,6 +1350,16 @@ struct hal_ev_le_test_mode {
 	uint16_t num_packets;
 } __attribute__((packed));
 
+#define HAL_EV_ENERGY_INFO		0x8c
+struct hal_ev_energy_info {
+	uint8_t status;
+	uint8_t ctrl_state;
+	uint64_t tx_time;
+	uint64_t rx_time;
+	uint64_t idle_time;
+	uint64_t energy_used;
+} __attribute__((packed));
+
 #define HAL_HIDHOST_STATE_CONNECTED		0x00
 #define HAL_HIDHOST_STATE_CONNECTING	0x01
 #define HAL_HIDHOST_STATE_DISCONNECTED	0x02
-- 
1.9.3

